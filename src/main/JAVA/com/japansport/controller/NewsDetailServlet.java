package com.japansport.controller;

import com.japansport.dao.NewsDao;
import com.japansport.model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "NewsDetailServlet", urlPatterns = {"/news-detail"})
public class NewsDetailServlet extends HttpServlet {

    private NewsDao newsDao;

    @Override
    public void init() {
        newsDao = new NewsDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String slug = request.getParameter("slug");
        if (slug == null || slug.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/news");
            return;
        }

        try {
            News n = newsDao.shopGetPublishedBySlug(slug);
            if (n == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // Tăng lượt view
            newsDao.increaseViewCount(n.getId());
            n.setViewCount(n.getViewCount() + 1);

            // Gửi dữ liệu bài viết chính
            request.setAttribute("news", n);

            //ĐIỂM MỚI BỔ SUNG
            List<News> recentNews = newsDao.shopGetPublished(null, null, 5, 0);
            request.setAttribute("recentNews", recentNews);

            // Điều hướng sang JSP
            request.getRequestDispatcher("/news-detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi hệ thống khi tải bài viết.");
        }
    }
}