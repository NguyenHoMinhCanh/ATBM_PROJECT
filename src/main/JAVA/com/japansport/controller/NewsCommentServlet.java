package com.japansport.controller;

import com.japansport.dao.NewsCommentDao;
import com.japansport.model.NewsComment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "NewsCommentServlet", urlPatterns = {"/post-comment"})
public class NewsCommentServlet extends HttpServlet {

    private NewsCommentDao commentDao = new NewsCommentDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int newsId = Integer.parseInt(request.getParameter("newsId"));
            String slug = request.getParameter("slug");
            String userName = request.getParameter("userName");
            String content = request.getParameter("content");

            if (userName == null || userName.isBlank()) userName = "Khách ẩn danh";

            if (content != null && !content.isBlank()) {
                NewsComment c = new NewsComment();
                c.setNewsId(newsId);
                c.setUserName(userName);
                c.setContent(content);
                commentDao.insert(c);
            }
            // Gửi xong thì load lại đúng trang bài viết đó
            response.sendRedirect(request.getContextPath() + "/news-detail?slug=" + slug);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/news");
        }
    }
}