package com.japansport.controller;

import com.japansport.dao.NotificationDao;
import com.japansport.model.Notification;
import com.japansport.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(name = "NotificationApiServlet", urlPatterns = {"/api/notifications"})
public class NotificationApiServlet extends HttpServlet {

    private final NotificationDao notificationDao = new NotificationDao();
    private static final SimpleDateFormat DF = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private static String jsonEscape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "")
                .replace("\t", "\\t");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.getWriter().write("{\"ok\":false,\"message\":\"Chưa đăng nhập\"}");
            return;
        }

        int userId = u.getId();
        int unreadCount = notificationDao.getUnreadCount(userId);
        List<Notification> list = notificationDao.getNotifications(userId, 20);

        StringBuilder sb = new StringBuilder();
        sb.append("{\"ok\":true");
        sb.append(",\"unreadCount\":").append(unreadCount);
        sb.append(",\"notifications\":[");
        for (int i = 0; i < list.size(); i++) {
            Notification n = list.get(i);
            if (i > 0) sb.append(",");
            String dateStr = (n.getCreatedAt() == null) ? "" : DF.format(n.getCreatedAt());
            sb.append("{");
            sb.append("\"id\":").append(n.getId()).append(",");
            sb.append("\"userId\":").append(n.getUserId()).append(",");
            sb.append("\"title\":\"").append(jsonEscape(n.getTitle())).append("\",");
            sb.append("\"message\":\"").append(jsonEscape(n.getMessage())).append("\",");
            sb.append("\"link\":\"").append(jsonEscape(n.getLink())).append("\",");
            sb.append("\"isRead\":").append(n.isRead()).append(",");
            sb.append("\"createdAt\":\"").append(jsonEscape(dateStr)).append("\"");
            sb.append("}");
        }
        sb.append("]}");

        resp.getWriter().write(sb.toString());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.getWriter().write("{\"ok\":false,\"message\":\"Chưa đăng nhập\"}");
            return;
        }

        int userId = u.getId();
        String action = req.getParameter("action");

        if ("markAllRead".equals(action)) {
            notificationDao.markAllRead(userId);
            resp.getWriter().write("{\"ok\":true}");
            return;
        } else if ("markRead".equals(action)) {
            String notifIdStr = req.getParameter("id");
            if (notifIdStr != null && !notifIdStr.isBlank()) {
                try {
                    int notificationId = Integer.parseInt(notifIdStr);
                    notificationDao.markRead(notificationId, userId);
                    resp.getWriter().write("{\"ok\":true}");
                    return;
                } catch (NumberFormatException e) {
                    resp.getWriter().write("{\"ok\":false,\"message\":\"ID không hợp lệ\"}");
                    return;
                }
            }
        }

        resp.getWriter().write("{\"ok\":false,\"message\":\"Thao tác không hợp lệ\"}");
    }
}
