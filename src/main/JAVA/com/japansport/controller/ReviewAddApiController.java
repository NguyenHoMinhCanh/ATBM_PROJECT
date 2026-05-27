package com.japansport.controller;

import com.japansport.dao.ReviewDao;
import com.japansport.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="ReviewAddApiController", urlPatterns={"/api/reviews/add"})
public class ReviewAddApiController extends HttpServlet {

    private final ReviewDao reviewDao = new ReviewDao();

    private int parseInt(String s, int def){
        try { return Integer.parseInt(s); } catch (Exception e){ return def; }
    }

    // Danh sách từ cấm (bad words cơ bản)
    private static final String[] BAD_WORDS = {
        "đmm", "vkl", "địt", "cc", "lừa đảo", "chó", "shit", "fuck", "đm", "vcl"
    };

    // Kiểm tra xem comment có chứa từ cấm, link hoặc số điện thoại (10 số liền nhau) không
    private boolean isClean(String comment) {
        String lowerComment = comment.toLowerCase();
        
        // 1. Check từ cấm
        for (String word : BAD_WORDS) {
            if (lowerComment.contains(word)) {
                return false;
            }
        }
        
        // 2. Check chứa Link (http, https, .com, .vn)
        if (lowerComment.contains("http://") || lowerComment.contains("https://") || 
            lowerComment.contains(".com") || lowerComment.contains(".vn")) {
            return false;
        }

        // 3. Check chứa số điện thoại (từ 9-11 số đi liền nhau hoặc cách nhau bởi khoảng trắng/dấu chấm)
        // Loại bỏ hết khoảng trắng và ký tự đặc biệt để đếm số lượng chữ số liên tiếp
        String numbersOnly = comment.replaceAll("[^0-9]", "");
        if (numbersOnly.length() >= 9) {
            // Check regex tìm chuỗi 9-11 số liên tiếp trong chuỗi gốc đã xóa dấu cách
            if (comment.replaceAll("[\\s\\-\\.]", "").matches(".*\\d{9,11}.*")) {
                return false;
            }
        }

        return true;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.setStatus(401);
            resp.getWriter().write("{\"ok\":false,\"message\":\"Bạn cần đăng nhập để đánh giá.\"}");
            return;
        }

        int productId = parseInt(req.getParameter("productId"), 0);
        int rating = parseInt(req.getParameter("rating"), 0);
        String comment = req.getParameter("comment");
        if (comment == null) comment = "";
        comment = comment.trim();

        if (productId <= 0 || rating < 1 || rating > 5 || comment.length() < 5) {
            resp.setStatus(400);
            resp.getWriter().write("{\"ok\":false,\"message\":\"Dữ liệu không hợp lệ (rating 1-5, comment >= 5 ký tự).\"}");
            return;
        }

        if (!reviewDao.canUserReview(u.getId(), productId)) {
            resp.setStatus(403);
            resp.getWriter().write("{\"ok\":false,\"message\":\"Bạn cần mua sản phẩm để đánh giá.\"}");
            return;
        }

        // Áp dụng bộ lọc
        boolean clean = isClean(comment);
        String status = clean ? "APPROVED" : "PENDING";

        boolean ok = reviewDao.insertReview(productId, u.getId(), rating, comment, status);
        if (ok) {
            if (clean) {
                resp.getWriter().write("{\"ok\":true,\"message\":\"Đánh giá của bạn đã được đăng thành công!\"}");
            } else {
                resp.getWriter().write("{\"ok\":true,\"message\":\"Đánh giá đang được xét duyệt vì chứa nội dung cần xác minh.\"}");
            }
        } else {
            resp.setStatus(500);
            resp.getWriter().write("{\"ok\":false,\"message\":\"Không gửi được đánh giá. Vui lòng thử lại.\"}");
        }
    }
}
