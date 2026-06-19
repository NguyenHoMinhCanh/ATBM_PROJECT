package com.japansport.controller;

import com.japansport.dao.CartDao;
import com.japansport.dao.VoucherDao;
import com.japansport.model.Cart;
import com.japansport.model.CartItem;
import com.japansport.model.User;

import com.japansport.model.Voucher;
import com.japansport.service.VoucherService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    private final CartDao cartDao = new CartDao();
    private final VoucherService voucherService = new VoucherService();
    private final VoucherDao voucherDao = new VoucherDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = (User) req.getSession().getAttribute("currentUser");

        String mode = req.getParameter("mode");
        if ("count".equalsIgnoreCase(mode) || "mini".equalsIgnoreCase(mode)) {
            resp.setContentType("application/json;charset=UTF-8");
            try {
                int count = (u == null) ? 0 : cartDao.getCartCount(u.getId());
                if ("mini".equalsIgnoreCase(mode) && u != null) {
                    Cart cart = cartDao.getActiveCart(u.getId());
                    List<CartItem> items = cart.getItems();
                    StringBuilder json = new StringBuilder();
                    json.append("{\"count\":").append(count).append(",\"items\":[");
                    // Chỉ lấy tối đa 5 sản phẩm mới nhất cho mini cart
                    int maxItems = Math.min(items.size(), 5);
                    for (int i = 0; i < maxItems; i++) {
                        CartItem item = items.get(items.size() - 1 - i); // Lấy từ cuối để hiển thị mới nhất
                        if (i > 0) json.append(",");
                        json.append("{");
                        json.append("\"productId\":").append(item.getProductId()).append(",");
                        json.append("\"name\":").append(esc(item.getProductName())).append(",");
                        json.append("\"imageUrl\":\"").append(item.getImageUrl() != null ? item.getImageUrl() : "").append("\",");
                        json.append("\"color\":\"").append(item.getColor() == null ? "" : item.getColor()).append("\",");
                        json.append("\"size\":\"").append(item.getSize() == null ? "" : item.getSize()).append("\",");
                        json.append("\"quantity\":").append(item.getQuantity()).append(",");
                        json.append("\"price\":").append(item.getUnitPrice());
                        json.append("}");
                    }
                    json.append("]}");
                    resp.getWriter().write(json.toString());
                } else {
                    resp.getWriter().write("{\"count\":" + count + "}");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.getWriter().write("{\"count\":0}");
            }
            return;
        }

        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?back=" + req.getContextPath() + "/cart");
            return;
        }

        try {
            Cart cart = cartDao.getActiveCart(u.getId());
            BigDecimal subtotal = BigDecimal.valueOf(cart.getSubtotal());

            // xu ly voucher
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
                    req.getSession().removeAttribute("appliedVoucherCode");
                }
            }

            // Gợi ý voucher phù hợp với đơn hàng hiện tại
            List<Voucher> suggestedVouchers = voucherDao.getApplicableVouchers(subtotal);

            req.setAttribute("cart", cart);
            req.setAttribute("cartItems", cart.getItems());
            req.setAttribute("subtotal", subtotal);
            req.setAttribute("appliedVoucher", appliedVoucher);
            req.setAttribute("discountAmount", discountAmount);
            req.setAttribute("finalTotal", finalTotal);
            req.setAttribute("voucherCode", voucherCode);
            req.setAttribute("suggestedVouchers", suggestedVouchers);

            req.getRequestDispatcher("/cart.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?back=" + req.getHeader("Referer"));
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null || action.isBlank()) action = "add";

        try {
            if ("applyVoucher".equals(action)) {
                String voucherCode = req.getParameter("voucherCode");
                if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                    Cart cart = cartDao.getActiveCart(u.getId());
                    BigDecimal subtotal = BigDecimal.valueOf(cart.getSubtotal());
                    Voucher voucher = voucherService.applyVoucher(voucherCode, subtotal);

                    if (voucher != null) {
                        req.getSession().setAttribute("appliedVoucherCode", voucherCode.toUpperCase());
                        req.getSession().setAttribute("voucherSuccess", "Áp dụng voucher " + voucherCode + " thành công!");
                    } else {
                        req.getSession().setAttribute("voucherError", "Mã voucher không hợp lệ hoặc không thỏa mãn điều kiện!");
                    }
                }
            }
            else if ("removeVoucher".equals(action)) {
                req.getSession().removeAttribute("appliedVoucherCode");
                req.getSession().setAttribute("voucherSuccess", "Đã bỏ voucher.");
            }
            else {
                switch (action) {
                    case "add": {
                        int productId = Integer.parseInt(req.getParameter("productId"));
                        String vidStr = req.getParameter("variantId");
                        Integer variantId = (vidStr == null || vidStr.isBlank()) ? null : Integer.parseInt(vidStr);
                        int qty = Integer.parseInt(req.getParameter("qty"));
                        cartDao.addToCart(u.getId(), productId, variantId, qty);

                        // mua ngay -> đi checkout
                        if ("1".equals(req.getParameter("buyNow"))) {
                            resp.sendRedirect(req.getContextPath() + "/checkout");
                            return;
                        }
                        break;
                    }
                    case "update": {
                        int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
                        int qty = Integer.parseInt(req.getParameter("qty"));
                        cartDao.updateQuantity(u.getId(), cartItemId, qty);
                        break;
                    }
                    case "remove": {
                        int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
                        cartDao.removeItem(u.getId(), cartItemId);
                        break;
                    }
                    case "clear": {
                        cartDao.clearCart(u.getId());
                        break;
                    }
                }
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("cartError", e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private String esc(String s) {
        if (s == null) return "null";
        return "\"" + s.replace("\\", "\\\\").replace("\"", "\\\"")
                       .replace("\n", "\\n").replace("\r", "\\r") + "\"";
    }
}
