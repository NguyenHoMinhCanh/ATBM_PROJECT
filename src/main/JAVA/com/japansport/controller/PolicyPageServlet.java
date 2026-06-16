package com.japansport.controller;

import com.japansport.dao.PolicyDao;
import com.japansport.model.Policy;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "PolicyPageServlet", urlPatterns = {"/policy"})
public class PolicyPageServlet extends HttpServlet {

    private PolicyDao dao;

    @Override
    public void init() {
        dao = new PolicyDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String slug = request.getParameter("slug");
        if (slug == null || slug.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        Policy p = dao.getBySlug(slug);
        if (p == null || !p.isActive()) {
            // Tự động tạo nội dung tạm thời nếu Database chưa có, tránh lỗi 404 Tomcat
            p = new Policy();
            p.setTitle(slug.replace("-", " ").toUpperCase());
            p.setContent("<div class='container my-5 py-5 text-center'><h4><i class='bi bi-tools text-warning'></i> Nội dung đang được cập nhật</h4><p>Chính sách này hiện chưa có nội dung trong Database. Vui lòng thêm trong trang Admin.</p></div>");
        }

        request.setAttribute("policy", p);
        request.getRequestDispatcher("/policy.jsp").forward(request, response);
    }
}
