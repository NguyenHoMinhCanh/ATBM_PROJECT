package com.japansport.dao;

import com.japansport.model.Notification;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * NotificationDAO - Xử lý toàn bộ thao tác DB cho bảng notifications.
 * Dùng chung cho cả User và Admin (phân biệt qua user_id).
 */
public class NotificationDAO extends DAO {

    // ========== MAPPER ==========

    private Notification mapRow(ResultSet rs) throws SQLException {
        Notification n = new Notification();
        n.setId(rs.getInt("id"));
        n.setUserId(rs.getInt("user_id"));
        n.setType(rs.getString("type"));
        n.setTitle(rs.getString("title"));
        n.setContent(rs.getString("content"));
        n.setLink(rs.getString("link"));
        n.setRead(rs.getBoolean("is_read"));
        n.setCreatedAt(rs.getTimestamp("created_at"));
        return n;
    }

    // ========== READ ==========

    /**
     * Lấy N thông báo mới nhất của một user (dùng cho popup chuông).
     * @param userId  ID của user (hoặc admin)
     * @param limit   Số lượng tối đa trả về (thường là 10)
     */
    public List<Notification> getRecent(int userId, int limit) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id = ? " +
                     "ORDER BY created_at DESC LIMIT ?";
        try {
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Đếm số thông báo chưa đọc của user — dùng để hiện badge đỏ trên icon chuông.
     * @return số nguyên >= 0
     */
    public int countUnread(int userId) {
        String sql = "SELECT COUNT(*) AS total FROM notifications " +
                     "WHERE user_id = ? AND is_read = 0";
        try {
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("total");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ========== WRITE ==========

    /**
     * Thêm một thông báo mới vào DB.
     * Dùng khi: đặt hàng thành công, admin đổi trạng thái đơn, v.v.
     * @return ID của bản ghi vừa insert, hoặc -1 nếu lỗi.
     */
    public int insert(Notification n) {
        String sql = "INSERT INTO notifications (user_id, type, title, content, link) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = getPreparedStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, n.getUserId());
            ps.setString(2, n.getType());
            ps.setString(3, n.getTitle());
            ps.setString(4, n.getContent());
            ps.setString(5, n.getLink());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Đánh dấu TẤT CẢ thông báo của user là đã đọc.
     * Gọi khi user mở popup chuông ra xem.
     */
    public void markAllRead(int userId) {
        String sql = "UPDATE notifications SET is_read = 1 " +
                     "WHERE user_id = ? AND is_read = 0";
        try {
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Đánh dấu 1 thông báo cụ thể là đã đọc.
     * Gọi khi user click vào 1 thông báo trong popup.
     */
    public void markOneRead(int notificationId, int userId) {
        String sql = "UPDATE notifications SET is_read = 1 " +
                     "WHERE id = ? AND user_id = ?";
        try {
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setInt(1, notificationId);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ========== HELPER / FACTORY ==========

    /**
     * Helper dùng trong OrderDao hoặc Servlet: tạo và insert nhanh 1 thông báo đơn hàng.
     * Ví dụ: NotificationDAO.pushOrder(userId, orderId, "DONE") → insert thông báo "Đơn hàng hoàn tất".
     */
    public void pushOrderNotification(int userId, int orderId, String newStatus) {
        String title, content;
        switch (newStatus.toUpperCase()) {
            case "PENDING":
                title   = "Đặt hàng thành công! 🎉";
                content = "Đơn hàng #" + orderId + " đã được tiếp nhận và đang chờ xử lý.";
                break;
            case "PAID":
                title   = "Đơn hàng đã được xác nhận";
                content = "Đơn hàng #" + orderId + " đã thanh toán và đang được chuẩn bị.";
                break;
            case "SHIPPING":
                title   = "Đơn hàng đang trên đường giao";
                content = "Đơn hàng #" + orderId + " đang được giao đến bạn. Vui lòng chú ý điện thoại!";
                break;
            case "DONE":
                title   = "Đơn hàng đã giao thành công ✅";
                content = "Đơn hàng #" + orderId + " đã hoàn tất. Cảm ơn bạn đã mua sắm!";
                break;
            case "CANCEL":
                title   = "Đơn hàng đã bị hủy";
                content = "Đơn hàng #" + orderId + " đã bị hủy. Liên hệ hỗ trợ nếu cần.";
                break;
            default:
                title   = "Cập nhật đơn hàng #" + orderId;
                content = "Trạng thái đơn hàng của bạn đã được cập nhật.";
        }
        insert(new Notification(userId, Notification.TYPE_ORDER, title, content,
                                "/orders?id=" + orderId));
    }
}
