package com.japansport.controller;

import com.japansport.dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/check-order-status"})
public class CheckOrderStatusController extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String orderIdParam = req.getParameter("orderId");
        String status = "PENDING";

        if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam);

                String dbStatus = orderDao.getStatusByOrderId(orderId);

                if (dbStatus != null) {
                    status = dbStatus;
                }

            } catch (Exception e) {
                // In ra lỗi trên console server để dễ debug
                e.printStackTrace();
            }
        }

        resp.getWriter().write("{\"status\": \"" + status + "\"}");
    }
}