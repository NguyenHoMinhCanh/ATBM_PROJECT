package com.japansport.controller;

import com.japansport.dao.NotificationDAO;
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

/**
 * NotificationApiServlet - REST-style API cho tính năng chuông thông báo.
 *
 * GET  /api/notifications?action=count   → { "unread": 3 }
 * GET  /api/notifications?action=list    → { "unread": 3, "items": [...] }
 * POST /api/notifications?action=markAll → { "ok": true }
 * POST /api/notifications?action=markOne&id=5 → { "ok": true }
 */
@WebServlet(name = "NotificationApiServlet", urlPatterns = {"/api/notifications"})
public class NotificationApiServlet extends HttpServlet {

    private final NotificationDAO notifDao = new NotificationDAO();
    private static final SimpleDateFormat DATE_FMT = new SimpleDateFormat("dd/MM HH:mm");

    // ===== Utility: escape JSON string =====
    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "")
                .replace("\t", "\\t");
    }

    private static void writeJson(HttpServletResponse resp, String json) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }

    // ===== GET =====
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("currentUser");
        if (user == null) {
            writeJson(resp, "{\"unread\":0,\"items\":[]}");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "count";

        switch (action) {

            case "count": {
                int unread = notifDao.countUnread(user.getId());
                writeJson(resp, "{\"unread\":" + unread + "}");
                break;
            }

            case "list": {
                int unread = notifDao.countUnread(user.getId());
                List<Notification> list = notifDao.getRecent(user.getId(), 10);

                StringBuilder sb = new StringBuilder();
                sb.append("{\"unread\":").append(unread).append(",\"items\":[");

                for (int i = 0; i < list.size(); i++) {
                    Notification n = list.get(i);
                    String createdAt = (n.getCreatedAt() == null) ? "" : DATE_FMT.format(n.getCreatedAt());
                    if (i > 0) sb.append(",");
                    sb.append("{");
                    sb.append("\"id\":").append(n.getId()).append(",");
                    sb.append("\"type\":\"").append(esc(n.getType())).append("\",");
                    sb.append("\"icon\":\"").append(esc(n.getTypeIcon())).append("\",");
                    sb.append("\"title\":\"").append(esc(n.getTitle())).append("\",");
                    sb.append("\"content\":\"").append(esc(n.getContent())).append("\",");
                    sb.append("\"link\":\"").append(esc(n.getLink())).append("\",");
                    sb.append("\"isRead\":").append(n.isRead()).append(",");
                    sb.append("\"createdAt\":\"").append(esc(createdAt)).append("\"");
                    sb.append("}");
                }

                sb.append("]}");
                writeJson(resp, sb.toString());
                break;
            }

            default:
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                writeJson(resp, "{\"ok\":false,\"message\":\"Unknown action\"}");
        }
    }

    // ===== POST =====
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("currentUser");
        if (user == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            writeJson(resp, "{\"ok\":false,\"message\":\"Unauthorized\"}");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {

            case "markAll": {
                notifDao.markAllRead(user.getId());
                writeJson(resp, "{\"ok\":true}");
                break;
            }

            case "markOne": {
                try {
                    int notifId = Integer.parseInt(req.getParameter("id"));
                    notifDao.markOneRead(notifId, user.getId());
                    writeJson(resp, "{\"ok\":true}");
                } catch (NumberFormatException e) {
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    writeJson(resp, "{\"ok\":false,\"message\":\"Invalid id\"}");
                }
                break;
            }

            default:
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                writeJson(resp, "{\"ok\":false,\"message\":\"Unknown action\"}");
        }
    }
}
