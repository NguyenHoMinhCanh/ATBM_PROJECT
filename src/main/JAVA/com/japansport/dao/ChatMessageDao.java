package com.japansport.dao;

import com.japansport.model.ChatMessage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ChatMessageDao - doc / ghi tin nhan chat vao database.
 * Bang: chat_messages
 */
public class ChatMessageDao extends DAO {

    /**
     * Luu 1 tin nhan moi vao DB
     */
    public int insertMessage(ChatMessage msg) {
        String sql = "INSERT INTO chat_messages (user_id, sender_role, content) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = getPreparedStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, msg.getUserId());
            ps.setString(2, msg.getSenderRole());
            ps.setString(3, msg.getContent());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Lay lich su chat cua 1 user (sap xep theo thoi gian tang dan)
     */
    public List<ChatMessage> getByUserId(int userId, int limit) {
        List<ChatMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT m.*, u.name as sender_name FROM chat_messages m " +
                     "LEFT JOIN users u ON m.user_id = u.id " +
                     "WHERE m.user_id = ? ORDER BY m.id DESC LIMIT ?) sub ORDER BY sub.id ASC";
        try {
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ChatMessage m = mapRow(rs);
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lay danh sach tat ca user da tung chat (cho trang Admin)
     * Tra ve tin nhan cuoi cung cua moi user
     */
    public List<ChatMessage> getAllChatUsers() {
        List<ChatMessage> list = new ArrayList<>();
        // lay tin nhan cuoi cung cua tung user
        String sql = "SELECT m.*, u.name as sender_name FROM chat_messages m " +
                     "INNER JOIN (SELECT user_id, MAX(id) as max_id FROM chat_messages GROUP BY user_id) latest " +
                     "ON m.id = latest.max_id " +
                     "LEFT JOIN users u ON m.user_id = u.id " +
                     "ORDER BY m.id DESC";
        try {
            PreparedStatement ps = getPreparedStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ChatMessage m = mapRow(rs);
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private ChatMessage mapRow(ResultSet rs) throws SQLException {
        ChatMessage m = new ChatMessage();
        m.setId(rs.getInt("id"));
        m.setUserId(rs.getInt("user_id"));
        m.setSenderRole(rs.getString("sender_role"));
        m.setContent(rs.getString("content"));
        m.setCreatedAt(rs.getTimestamp("created_at"));
        // ten nguoi gui (co the null neu user bi xoa)
        try {
            m.setSenderName(rs.getString("sender_name"));
        } catch (SQLException ex) {
            m.setSenderName("Khách");
        }
        return m;
    }

    /**
     * Lay tin nhan moi sau lastId (dung cho polling)
     */
    public List<ChatMessage> getNewMessages(int userId, int lastId) {
        List<ChatMessage> list = new ArrayList<>();
        String sql = "SELECT m.*, u.name as sender_name FROM chat_messages m " +
                     "LEFT JOIN users u ON m.user_id = u.id " +
                     "WHERE m.user_id = ? AND m.id > ? ORDER BY m.id ASC";
        try {
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, lastId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
