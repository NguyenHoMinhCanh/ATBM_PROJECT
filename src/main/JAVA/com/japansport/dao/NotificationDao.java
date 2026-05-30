package com.japansport.dao;

import com.japansport.model.Notification;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO xử lý bảng notifications — thông báo in-app cho người dùng.
 */
public class NotificationDao extends DAO {

    /**
     * Tạo thông báo mới trong transaction đang mở.
     *
     * @param conn    Connection của transaction caller
     * @param userId  user_id của người nhận
     * @param title   Tiêu đề ngắn gọn
     * @param message Nội dung chi tiết
     * @param link    Đường dẫn liên quan (có thể null)
     */
    public void insertNotification(Connection conn, int userId, String title,
                                    String message, String link) throws SQLException {
        String sql = "INSERT INTO notifications (user_id, title, message, link) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, message);
            if (link == null) ps.setNull(4, Types.VARCHAR); else ps.setString(4, link);
            ps.executeUpdate();
        }
    }

    /**
     * Đếm số thông báo chưa đọc của người dùng.
     */
    public int getUnreadCount(int userId) {
        String sql = "SELECT COUNT(*) AS cnt FROM notifications WHERE user_id = ? AND is_read = 0";
        try (PreparedStatement ps = getPreparedStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("cnt");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy danh sách thông báo gần nhất của người dùng.
     *
     * @param userId ID người dùng
     * @param limit  Số lượng tối đa cần lấy
     */
    public List<Notification> getNotifications(int userId, int limit) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC LIMIT ?";
        try (PreparedStatement ps = getPreparedStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Notification n = new Notification();
                    n.setId(rs.getInt("id"));
                    n.setUserId(rs.getInt("user_id"));
                    n.setTitle(rs.getString("title"));
                    n.setMessage(rs.getString("message"));
                    n.setLink(rs.getString("link"));
                    n.setRead(rs.getBoolean("is_read"));
                    n.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(n);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Đánh dấu tất cả thông báo của người dùng là đã đọc.
     */
    public void markAllRead(int userId) {
        String sql = "UPDATE notifications SET is_read = 1 WHERE user_id = ? AND is_read = 0";
        try (PreparedStatement ps = getPreparedStatement(sql)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Đánh dấu một thông báo cụ thể là đã đọc.
     */
    public void markRead(int notificationId, int userId) {
        String sql = "UPDATE notifications SET is_read = 1 WHERE id = ? AND user_id = ?";
        try (PreparedStatement ps = getPreparedStatement(sql)) {
            ps.setInt(1, notificationId);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Đánh dấu thông báo có link tương ứng của người dùng là đã đọc.
     */
    public void markReadByLink(int userId, String link) {
        String sql = "UPDATE notifications SET is_read = 1 WHERE user_id = ? AND link = ? AND is_read = 0";
        try (PreparedStatement ps = getPreparedStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, link);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
