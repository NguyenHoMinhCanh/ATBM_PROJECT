package com.japansport.controller;

import com.japansport.dao.CartDao;
import com.japansport.dao.OrderDao;
import com.japansport.model.OrderItem;
import com.japansport.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ReorderController", urlPatterns = {"/reorder"})
public class ReorderController extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();
    private final CartDao cartDao = new CartDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        // 1. Kiểm tra đăng nhập
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            int userId = currentUser.getId();

            // 2. Lấy danh sách sản phẩm từ đơn hàng cũ
            List<OrderItem> oldItems = orderDao.getOrderItems(orderId);
            int successCount = 0;

            if (oldItems != null && !oldItems.isEmpty()) {
                // 3. Thêm từng sản phẩm vào giỏ hàng
                for (OrderItem item : oldItems) {
                    try {
                        // Gọi đúng hàm addToCart trong CartDao của bạn
                        cartDao.addToCart(userId, item.getProductId(), item.getVariantId(), item.getQuantity());
                        successCount++;
                    } catch (Exception ex) {
                        // Bỏ qua item nếu lỗi (ví dụ: sản phẩm đã hết hàng hoặc bị xóa khỏi hệ thống)
                        System.out.println("Không thể add sản phẩm (ID: " + item.getProductId() + ") vào giỏ reorder: " + ex.getMessage());
                    }
                }

                // 4. Thiết lập thông báo cho người dùng
                if (successCount > 0) {
                    session.setAttribute("cartSuccess", "Đã thêm " + successCount + " sản phẩm từ đơn hàng cũ vào giỏ!");
                } else {
                    session.setAttribute("cartError", "Rất tiếc, các sản phẩm trong đơn hàng này hiện đã hết hàng!");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("cartError", "Có lỗi xảy ra khi đặt lại đơn hàng.");
        }

        // 5. Chuyển hướng người dùng sang trang Giỏ Hàng
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}