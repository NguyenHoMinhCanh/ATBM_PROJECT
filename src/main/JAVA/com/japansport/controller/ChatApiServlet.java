package com.japansport.controller;

import com.japansport.dao.ChatMessageDao;
import com.japansport.model.ChatMessage;
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
 * API lay lich su tin nhan chat + gui tin nhan moi.
 *
 * GET  /api/chat?userId=5       -> lay lich su chat cua user id=5
 * GET  /api/chat?action=users   -> lay danh sach user da chat (admin)
 * GET  /api/chat?action=poll&userId=5&lastId=10 -> lay tin nhan moi sau lastId (polling)
 * POST /api/chat                -> gui tin nhan moi (body: userId, content)
 */
@WebServlet(name = "ChatApiServlet", urlPatterns = {"/api/chat"})
public class ChatApiServlet extends HttpServlet {

    private final ChatMessageDao chatDao = new ChatMessageDao();
    private static final SimpleDateFormat DATE_FMT = new SimpleDateFormat("dd/MM HH:mm");

    // escape JSON
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            writeJson(resp, "{\"ok\":false,\"msg\":\"Chua dang nhap\"}");
            return;
        }

        String action = req.getParameter("action");

        // Admin: lay danh sach tat ca user da tung gui tin nhan
        if ("users".equals(action) && currentUser.isAdmin()) {
            List<ChatMessage> chatUsers = chatDao.getAllChatUsers();
            StringBuilder sb = new StringBuilder();
            sb.append("{\"items\":[");
            for (int i = 0; i < chatUsers.size(); i++) {
                ChatMessage m = chatUsers.get(i);
                if (i > 0) sb.append(",");
                sb.append("{");
                sb.append("\"userId\":").append(m.getUserId()).append(",");
                sb.append("\"name\":\"").append(esc(m.getSenderName())).append("\",");
                sb.append("\"lastMsg\":\"").append(esc(m.getContent())).append("\",");
                sb.append("\"time\":\"").append(m.getCreatedAt() != null ? DATE_FMT.format(m.getCreatedAt()) : "").append("\"");
                sb.append("}");
            }
            sb.append("]}");
            writeJson(resp, sb.toString());
            return;
        }

        // Polling: lay tin nhan moi sau lastId
        if ("poll".equals(action)) {
            int userId;
            if (currentUser.isAdmin()) {
                String uidParam = req.getParameter("userId");
                userId = (uidParam != null) ? Integer.parseInt(uidParam) : 0;
            } else {
                userId = currentUser.getId();
            }
            int lastId = 0;
            try { lastId = Integer.parseInt(req.getParameter("lastId")); } catch (Exception e) {}

            List<ChatMessage> newMsgs = chatDao.getNewMessages(userId, lastId);
            writeJson(resp, buildMsgListJson(newMsgs));
            return;
        }

        // Lay lich su chat cua 1 user cu the
        int userId;
        if (currentUser.isAdmin()) {
            String uidParam = req.getParameter("userId");
            if (uidParam == null) {
                writeJson(resp, "{\"items\":[]}");
                return;
            }
            userId = Integer.parseInt(uidParam);
        } else {
            userId = currentUser.getId();
        }

        List<ChatMessage> messages = chatDao.getByUserId(userId, 50);
        writeJson(resp, buildMsgListJson(messages));
    }

    // POST: gui tin nhan moi
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            writeJson(resp, "{\"ok\":false,\"msg\":\"Chua dang nhap\"}");
            return;
        }

        // Doc body JSON
        StringBuilder body = new StringBuilder();
        String line;
        var reader = req.getReader();
        while ((line = reader.readLine()) != null) {
            body.append(line);
        }
        String jsonBody = body.toString();

        // Parse don gian
        String content = parseJsonField(jsonBody, "content");
        if (content == null || content.trim().isEmpty()) {
            resp.setStatus(400);
            writeJson(resp, "{\"ok\":false,\"msg\":\"Tin nhan rong\"}");
            return;
        }

        int targetUserId;
        String senderRole;

        if (currentUser.isAdmin()) {
            // Admin gui tin nhan cho khach hang
            senderRole = "ADMIN";
            String uidStr = parseJsonField(jsonBody, "userId");
            targetUserId = (uidStr != null) ? Integer.parseInt(uidStr) : 0;
        } else {
            // Khach hang gui tin nhan
            senderRole = "USER";
            targetUserId = currentUser.getId();
        }

        ChatMessage msg = new ChatMessage(targetUserId, senderRole, content);
        int newId = chatDao.insertMessage(msg);

        writeJson(resp, "{\"ok\":true,\"id\":" + newId + "}");
    }

    // Build JSON cho danh sach tin nhan
    private String buildMsgListJson(List<ChatMessage> messages) {
        StringBuilder sb = new StringBuilder();
        sb.append("{\"items\":[");
        for (int i = 0; i < messages.size(); i++) {
            ChatMessage m = messages.get(i);
            if (i > 0) sb.append(",");
            sb.append("{");
            sb.append("\"id\":").append(m.getId()).append(",");
            sb.append("\"userId\":").append(m.getUserId()).append(",");
            sb.append("\"role\":\"").append(esc(m.getSenderRole())).append("\",");
            sb.append("\"content\":\"").append(esc(m.getContent())).append("\",");
            sb.append("\"time\":\"").append(m.getCreatedAt() != null ? DATE_FMT.format(m.getCreatedAt()) : "").append("\"");
            sb.append("}");
        }
        sb.append("]}");
        return sb.toString();
    }

    // Parse JSON field don gian
    private String parseJsonField(String json, String field) {
        String key = "\"" + field + "\"";
        int idx = json.indexOf(key);
        if (idx < 0) return null;
        int colonIdx = json.indexOf(":", idx + key.length());
        if (colonIdx < 0) return null;
        int start = colonIdx + 1;
        while (start < json.length() && json.charAt(start) == ' ') start++;
        if (start >= json.length()) return null;
        if (json.charAt(start) == '"') {
            int end = json.indexOf("\"", start + 1);
            if (end < 0) return null;
            return json.substring(start + 1, end);
        }
        int end = start;
        while (end < json.length() && json.charAt(end) != ',' && json.charAt(end) != '}') end++;
        return json.substring(start, end).trim();
    }
}
