package com.japansport.controller;

import com.japansport.model.User;
import com.japansport.dao.OrderDao;
import com.japansport.dao.ProductDao;
import com.japansport.dao.UserDao;
import com.japansport.model.Order;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();
    private final OrderDao orderDao = new OrderDao();
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        request.setAttribute("adminName", currentUser != null ? currentUser.getName() : "Admin");
        request.setAttribute("pageTitle", "Dashboard");

        // Bộ lọc ngày cho sản phẩm bán chạy
        String startDate = request.getParameter("startDate");
        String endDate   = request.getParameter("endDate");
        if (startDate == null || startDate.trim().isEmpty()) {
            startDate = LocalDate.now().withDayOfMonth(1).toString();
        }
        if (endDate == null || endDate.trim().isEmpty()) {
            endDate = LocalDate.now().toString();
        }
        List<Map<String, Object>> bestSellers =
                orderDao.getBestSellingProductsReport(startDate, endDate, 10);
        request.setAttribute("bestSellers", bestSellers);
        request.setAttribute("startDate",   startDate);
        request.setAttribute("endDate",     endDate);

        // STATS
        int totalProducts = productDao.countAll();
        int totalUsers    = userDao.countAllUsers();
        int activeUsers   = userDao.countActiveUsers();
        int totalOrders   = orderDao.countAllOrders();
        double totalRevenue = orderDao.sumRevenuePaidDone();

        Map<String, Integer> orderStatusCounts = new HashMap<>();
        orderStatusCounts.put("PENDING",  orderDao.countByStatus("PENDING"));
        orderStatusCounts.put("PAID",     orderDao.countByStatus("PAID"));
        orderStatusCounts.put("SHIPPING", orderDao.countByStatus("SHIPPING"));
        orderStatusCounts.put("DONE",     orderDao.countByStatus("DONE"));
        orderStatusCounts.put("CANCEL",   orderDao.countByStatus("CANCEL"));

        List<Order> recentOrders = orderDao.getRecentOrders(6);

        // Revenue chart 12 months
        Map<String, Double> revenueByMonth = new HashMap<>();
        for (Object[] row : orderDao.revenueByMonthLast12()) {
            revenueByMonth.put((String) row[0], (Double) row[1]);
        }
        DateTimeFormatter monthKeyFmt   = DateTimeFormatter.ofPattern("yyyy-MM");
        DateTimeFormatter monthLabelFmt = DateTimeFormatter.ofPattern("MM/yyyy");
        List<String> monthLabels = new ArrayList<>();
        List<Double> monthValues = new ArrayList<>();
        LocalDate now = LocalDate.now();
        for (int i = 11; i >= 0; i--) {
            LocalDate d = now.minusMonths(i);
            monthLabels.add(d.format(monthLabelFmt));
            monthValues.add(revenueByMonth.getOrDefault(d.format(monthKeyFmt), 0d));
        }

        request.setAttribute("totalProducts",     totalProducts);
        request.setAttribute("totalUsers",        totalUsers);
        request.setAttribute("activeUsers",       activeUsers);
        request.setAttribute("totalOrders",       totalOrders);
        request.setAttribute("totalRevenue",      totalRevenue);
        request.setAttribute("orderStatusCounts", orderStatusCounts);
        request.setAttribute("recentOrders",      recentOrders);
        request.setAttribute("monthLabels",       monthLabels);
        request.setAttribute("monthValues",       monthValues);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}