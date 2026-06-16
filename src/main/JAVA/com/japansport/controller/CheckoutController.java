package com.japansport.controller;

import com.japansport.dao.CartDao;
import com.japansport.dao.NotificationDAO;
import com.japansport.dao.OrderDao;
import com.japansport.dao.UserAddressDao;
import com.japansport.dao.VoucherDao;
import com.japansport.model.Cart;
import com.japansport.model.User;
import com.japansport.model.UserAddress;
import com.japansport.model.Voucher;
import com.japansport.service.VoucherService;
import com.japansport.util.MailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {

    private final CartDao cartDao = new CartDao();
    private final OrderDao orderDao = new OrderDao();
    private final UserAddressDao addressDao = new UserAddressDao();
    private final VoucherService voucherService = new VoucherService();
    private final VoucherDao voucherDao = new VoucherDao();
    private final NotificationDAO notifDao = new NotificationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?back=" + req.getContextPath() + "/checkout");
            return;
        }

        try {
            Cart cart = cartDao.getActiveCart(u.getId());
            if (cart.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            // Prefill địa chỉ mặc định để payment.jsp tự điền nhanh
            UserAddress addr = null;
            try {
                addr = addressDao.getDefaultByUserId(u.getId());
            } catch (Exception ignored) {}
            req.setAttribute("defaultAddress", addr);

            // ===== XỬ LÝ VOUCHER =====
            BigDecimal subtotal = BigDecimal.valueOf(cart.getSubtotal());
            String voucherCode = (String) req.getSession().getAttribute("appliedVoucherCode");
            Voucher appliedVoucher = null;
            BigDecimal discountAmount = BigDecimal.ZERO;
            BigDecimal finalTotal = subtotal;

            if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                appliedVoucher = voucherService.applyVoucher(voucherCode, subtotal);
                if (appliedVoucher != null) {
                    discountAmount = voucherService.calculateDiscount(appliedVoucher, subtotal);
                    finalTotal = subtotal.subtract(discountAmount);
                } else {
                    // Voucher hết hạn hoặc không còn hợp lệ → xóa khỏi session
                    req.getSession().removeAttribute("appliedVoucherCode");
                }
            }

            // Gợi ý voucher phù hợp với đơn hàng hiện tại
            List<Voucher> suggestedVouchers = voucherDao.getApplicableVouchers(subtotal);

            req.setAttribute("cart", cart);
            req.setAttribute("cartItems", cart.getItems());
            req.setAttribute("appliedVoucher", appliedVoucher);
            req.setAttribute("discountAmount", discountAmount);
            req.setAttribute("finalTotal", finalTotal);
            req.setAttribute("voucherCode", voucherCode);
            req.setAttribute("suggestedVouchers", suggestedVouchers);
            req.getRequestDispatcher("/payment.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?back=" + req.getContextPath() + "/checkout");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        // 1. Lấy dữ liệu từ form
        String email = req.getParameter("email");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String addressLine = req.getParameter("addressLine");
        String city = req.getParameter("city");
        String district = req.getParameter("district");
        String ward = req.getParameter("ward");
        String payMethod = req.getParameter("payMethod");
        String note = req.getParameter("note");
        String ghnDistrictIdStr = req.getParameter("ghnDistrictId");
        String ghnWardCode = req.getParameter("ghnWardCode");

        try {
            // Lấy giỏ hàng TRƯỚC KHI thanh toán để tính tổng tiền truyền vào email
            Cart cart = cartDao.getActiveCart(u.getId());
            double subtotal = cart.getSubtotal();

            // Xử lý tính toán giảm giá (nếu có dùng Voucher) để ra số tiền cuối cùng
            String voucherCode = (String) req.getSession().getAttribute("appliedVoucherCode");
            double finalTotal = subtotal;
            double discountAmount = 0;
            if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                Voucher appliedVoucher = voucherService.applyVoucher(voucherCode, BigDecimal.valueOf(subtotal));
                if (appliedVoucher != null) {
                    BigDecimal discount = voucherService.calculateDiscount(appliedVoucher, BigDecimal.valueOf(subtotal));
                    discountAmount = discount.doubleValue();
                    finalTotal = subtotal - discountAmount;
                }
            }

            // Xử lý phí vận chuyển
            String shippingFeeStr = req.getParameter("shippingFee");
            double shippingFee = 0;
            if (shippingFeeStr != null && !shippingFeeStr.trim().isEmpty()) {
                try {
                    shippingFee = Double.parseDouble(shippingFeeStr);
                } catch (Exception e) {}
            }
            finalTotal += shippingFee;

            // 2. Thực hiện lưu đơn hàng vào database
            int orderId = orderDao.placeOrderFromCart(
                    u.getId(), fullName, phone, addressLine, city, district, ward, payMethod, note,
                    discountAmount, shippingFee
            );

            // 3. Đẩy đơn hàng sang GHN
            try {
                if (ghnDistrictIdStr != null && !ghnDistrictIdStr.trim().isEmpty() && ghnWardCode != null && !ghnWardCode.trim().isEmpty()) {
                    int distId = Integer.parseInt(ghnDistrictIdStr);
                    String fullAddr = addressLine + ", " + ward + ", " + district + ", " + city;
                    double cod = "cod".equals(payMethod) ? finalTotal : 0; // Đã chuyển khoản thì thu hộ 0đ
                    
                    String ghnOrderCode = com.japansport.service.GhnApiService.createOrder(
                            fullName, phone, fullAddr, distId, ghnWardCode, cod
                    );
                    System.out.println("TẠO ĐƠN GHN THÀNH CÔNG! Mã vận đơn GHN: " + ghnOrderCode + " cho Đơn hàng ID: " + orderId);
                }
            } catch (Exception e) {
                System.err.println("Lỗi bắn đơn sang GHN (Đơn ID " + orderId + "): " + e.getMessage());
            }

            // Trigger: gửi thông báo in-app cho User
            try {
                notifDao.pushOrderNotification(u.getId(), orderId, "PENDING");
            } catch (Exception ignored) {} // không để lỗi notification hỏng checkout

            // Gửi email xác nhận đơn hàng (async, không block)
            final double finalAmountForEmail = finalTotal;
            new Thread(() -> {
                MailUtil.sendOrderConfirmationEmail(
                        email,
                        fullName,
                        String.valueOf(orderId),
                        finalAmountForEmail
                );
            }).start();

            // Xóa session voucher sau khi dùng xong
            req.getSession().removeAttribute("appliedVoucherCode");

            HttpSession session = req.getSession();
            session.setAttribute("FLASH_MSG", "Đặt hàng thành công. Mã đơn #" + orderId);
            session.setAttribute("FLASH_TYPE", "success");
            resp.sendRedirect(req.getContextPath() + "/order-detail?id=" + orderId);

        } catch (Exception e) {
            req.setAttribute("errorMessage", "Đặt hàng thất bại: " + e.getMessage());
            doGet(req, resp);
        }
    }
}
