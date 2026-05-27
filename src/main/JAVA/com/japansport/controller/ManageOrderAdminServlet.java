package com.japansport.controller;

import com.japansport.dao.OrderDao;
import com.japansport.model.Order;
import com.japansport.model.OrderItem;
import com.japansport.model.User;
import com.japansport.model.OrderStatusLog;
import com.japansport.dao.OrderStatusLogDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageOrderAdminServlet", urlPatterns = {"/admin/orders"})
public class ManageOrderAdminServlet extends HttpServlet {

    private OrderDao orderDao;

    @Override
    public void init() {
        orderDao = new OrderDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "count":
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                int total = orderDao.adminCountAll(null, null);
                response.getWriter().write("{\"count\":" + total + "}");
                return;
            case "cancel":
                cancelOrder(request, response);
                break;
            case "detail":
                showDetail(request, response);
                break;
            case "list":
            default:
                showList(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        if ("updateStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            String reason = request.getParameter("reason");

            if (status == null || status.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&error=badstatus");
                return;
            }

            if (reason == null || reason.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&error=missingreason");
                return;
            }

            status = status.trim().toUpperCase();
            reason = reason.trim();

            // Validate status theo enum đang dùng trong Order.getStatusVi()
            if (!status.equals("PENDING") && !status.equals("PAID") && !status.equals("SHIPPING")
                    && !status.equals("DONE") && !status.equals("CANCEL")) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&error=badstatus");
                return;
            }

            Order order = orderDao.adminGetById(id);
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=notfound");
                return;
            }

            String currentStatus = order.getStatus();
            if (currentStatus != null) {
                currentStatus = currentStatus.trim().toUpperCase();
            } else {
                currentStatus = "PENDING";
            }

            // Ràng buộc luồng chuyển đổi trạng thái (State Machine Transitions)
            // - Trạng thái cuối: DONE hoặc CANCEL không thể thay đổi nữa
            if ("DONE".equals(currentStatus) || "CANCEL".equals(currentStatus)) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&error=badstatus");
                return;
            }

            // - PENDING có thể chuyển sang PENDING, PAID, SHIPPING, CANCEL
            // - PAID có thể chuyển sang PAID, SHIPPING, CANCEL
            // - SHIPPING có thể chuyển sang SHIPPING, DONE, CANCEL
            boolean isValidTransition = false;
            if (status.equals(currentStatus)) {
                isValidTransition = true;
            } else if ("PENDING".equals(currentStatus)) {
                if (status.equals("PAID") || status.equals("SHIPPING") || status.equals("CANCEL")) {
                    isValidTransition = true;
                }
            } else if ("PAID".equals(currentStatus)) {
                if (status.equals("SHIPPING") || status.equals("CANCEL")) {
                    isValidTransition = true;
                }
            } else if ("SHIPPING".equals(currentStatus)) {
                if (status.equals("DONE") || status.equals("CANCEL")) {
                    isValidTransition = true;
                }
            }

            if (!isValidTransition) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&error=badstatus");
                return;
            }

            User currentUser = (User) request.getSession().getAttribute("currentUser");
            int adminUserId = (currentUser != null) ? currentUser.getId() : 1;

            boolean ok;
            // Nếu admin chọn CANCEL thì dùng hàm cancel để hoàn tồn kho (hỗ trợ PENDING, PAID, SHIPPING)
            if (status.equals("CANCEL")) {
                int rc = orderDao.adminCancelOrder(id, adminUserId, reason);
                ok = (rc == 1);
                if (!ok) {
                    // -1: không còn trạng thái hủy hợp lệ, 0: notfound, -2: error
                    if (rc == -1) {
                        response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&error=badstatus");
                        return;
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&error=error");
                    return;
                }
            } else {
                ok = orderDao.adminUpdateStatus(id, status, adminUserId, reason);
            }

            response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + (ok ? "&success=1" : "&error=error"));
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }

    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String status = request.getParameter("status"); // optional filter
        String keyword = request.getParameter("q");     // optional search (name/email/phone)
        if (status != null && status.isBlank()) status = null;
        if (keyword != null && keyword.isBlank()) keyword = null;

        // Phân trang
        final int PAGE_SIZE = 10;
        int page = 1;
        try {
            String p = request.getParameter("page");
            if (p != null && !p.isBlank()) page = Math.max(1, Integer.parseInt(p));
        } catch (NumberFormatException ignored) {}

        int totalRecords = orderDao.adminCountAll(status, keyword);
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Order> orders = orderDao.adminGetPaged(status, keyword, page, PAGE_SIZE);

        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("filterStatus", status);
        request.setAttribute("filterKeyword", keyword);

        // show flash messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if (success != null) {
            switch (success) {
                case "cancel":
                    request.setAttribute("success", "Đã hủy đơn hàng thành công.");
                    break;
                default:
                    request.setAttribute("success", success);
            }
        }
        if (error != null) {
            switch (error) {
                case "notfound":
                    request.setAttribute("error", "Không tìm thấy đơn hàng.");
                    break;
                case "badstatus":
                    request.setAttribute("error", "Không thể thay đổi trạng thái đơn hàng này.");
                    break;
                default:
                    request.setAttribute("error", error);
            }
        }
        request.setAttribute("pageTitle", "Quản lý đơn hàng");
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }


    private void cancelOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=list&error=notfound");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=list&error=notfound");
            return;
        }

        int rc = orderDao.adminCancelOrder(id);
        if (rc == 1) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=list&success=cancel");
        } else if (rc == 0) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=list&error=notfound");
        } else if (rc == -1) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&error=badstatus");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + id + "&error=error");
        }
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Order order = orderDao.adminGetById(id);
        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=notfound");
            return;
        }

        List<OrderItem> items = orderDao.getOrderItems(id);

        OrderStatusLogDao logDao = new OrderStatusLogDao();
        List<OrderStatusLog> statusLogs = logDao.getLogsByOrderId(id);

        java.util.Map<String, Object> refundRequest = orderDao.getRefundRequest(id);

        request.setAttribute("order", order);
        request.setAttribute("items", items);
        request.setAttribute("statusLogs", statusLogs);
        request.setAttribute("refundRequest", refundRequest);
        request.setAttribute("pageTitle", "Chi tiết đơn hàng #" + id);
        request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);
    }
}
