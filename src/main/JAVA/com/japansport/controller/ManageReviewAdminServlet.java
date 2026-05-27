package com.japansport.controller;

import com.japansport.dao.ReviewDao;
import com.japansport.model.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageReviewAdminServlet", urlPatterns = {"/admin/reviews"})
public class ManageReviewAdminServlet extends HttpServlet {

    private ReviewDao reviewDao;

    @Override
    public void init() {
        reviewDao = new ReviewDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("delete".equals(action)) {
            deleteReview(request, response);
            return;
        }
        
        showList(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            String[] reviewIds = request.getParameterValues("reviewIds");
            String newStatus = request.getParameter("status"); // APPROVED hoặc PENDING
            
            if (reviewIds != null && newStatus != null) {
                for (String idStr : reviewIds) {
                    try {
                        int id = Integer.parseInt(idStr);
                        reviewDao.adminUpdateStatus(id, newStatus);
                    } catch (NumberFormatException ignore) {}
                }
                response.sendRedirect(request.getContextPath() + "/admin/reviews?success=update_status");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/reviews?error=missing_data");
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/reviews");
    }

    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String status = request.getParameter("status"); // lọc theo trạng thái
        if (status != null && status.isBlank()) status = null;

        List<Review> reviews = reviewDao.adminGetAll(status);
        request.setAttribute("reviews", reviews);
        request.setAttribute("currentStatus", status);

        // Flash messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        
        if ("update_status".equals(success)) {
            request.setAttribute("success", "Đã cập nhật trạng thái các đánh giá thành công!");
        } else if ("delete".equals(success)) {
            request.setAttribute("success", "Đã xóa đánh giá thành công!");
        }
        
        if ("delete_failed".equals(error)) {
            request.setAttribute("error", "Xóa đánh giá thất bại!");
        } else if ("missing_data".equals(error)) {
            request.setAttribute("error", "Chưa chọn đánh giá hoặc trạng thái!");
        }

        request.setAttribute("pageTitle", "Quản lý Đánh giá");
        request.getRequestDispatcher("/admin/reviews.jsp").forward(request, response);
    }

    private void deleteReview(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/admin/reviews?error=missing_data");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            boolean ok = reviewDao.adminDelete(id);
            if (ok) {
                response.sendRedirect(request.getContextPath() + "/admin/reviews?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/reviews?error=delete_failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/reviews?error=delete_failed");
        }
    }
}
