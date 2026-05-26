package com.japansport.dao;

import com.japansport.model.OrderStatusLog;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO xử lý bảng order_status_logs.
 * Các phương thức ghi log nhận Connection bên ngoài để tham gia vào transaction của caller.
 */
public class OrderStatusLogDao extends DAO {

    /**
     * Ghi một bản ghi lịch sử vào order_status_logs.
     * Dùng Connection đã có (để chạy trong cùng transaction với thay đổi trạng thái đơn).
     *
     * @param conn       Connection của transaction đang mở
     * @param orderId    ID đơn hàng
     * @param fromStatus Trạng thái trước (null nếu là lúc tạo đơn)
     * @param toStatus   Trạng thái mới
     * @param reason     Lý do thay đổi
     * @param changedBy  user_id của admin/staff thực hiện
     */
    public void insertLog(Connection conn, int orderId, String fromStatus,
                          String toStatus, String reason, int changedBy) throws SQLException {
        String sql = "INSERT INTO order_status_logs (order_id, from_status, to_status, reason, changed_by) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            if (fromStatus == null) ps.setNull(2, Types.VARCHAR); else ps.setString(2, fromStatus);
            ps.setString(3, toStatus);
            ps.setString(4, reason);
            ps.setInt(5, changedBy);
            ps.executeUpdate();
        }
    }

    /**
     * Lấy toàn bộ lịch sử thay đổi trạng thái của một đơn hàng, sắp xếp theo thời gian tăng dần.
     */
    public List<OrderStatusLog> getLogsByOrderId(int orderId) {
        List<OrderStatusLog> list = new ArrayList<>();
        String sql =
                "SELECT l.id, l.order_id, l.from_status, l.to_status, l.reason, l.changed_by, l.changed_at, " +
                "u.name AS changed_by_name " +
                "FROM order_status_logs l " +
                "JOIN users u ON u.id = l.changed_by " +
                "WHERE l.order_id = ? " +
                "ORDER BY l.changed_at ASC, l.id ASC";
        try (PreparedStatement ps = getPreparedStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderStatusLog log = new OrderStatusLog();
                    log.setId(rs.getInt("id"));
                    log.setOrderId(rs.getInt("order_id"));
                    log.setFromStatus(rs.getString("from_status"));
                    log.setToStatus(rs.getString("to_status"));
                    log.setReason(rs.getString("reason"));
                    log.setChangedBy(rs.getInt("changed_by"));
                    log.setChangedByName(rs.getString("changed_by_name"));
                    log.setChangedAt(rs.getTimestamp("changed_at"));
                    list.add(log);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
