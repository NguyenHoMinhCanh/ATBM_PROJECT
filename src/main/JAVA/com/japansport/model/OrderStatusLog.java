package com.japansport.model;

import java.sql.Timestamp;

/**
 * Ánh xạ bảng order_status_logs — lưu lịch sử thay đổi trạng thái đơn hàng.
 */
public class OrderStatusLog {

    private int id;
    private int orderId;
    private String fromStatus;   // NULL nghĩa là lúc tạo đơn
    private String toStatus;
    private String reason;
    private int changedBy;       // user_id của admin/staff
    private String changedByName;// join từ users.name
    private Timestamp changedAt;

    // ===== Constructors =====
    public OrderStatusLog() {}

    // ===== Helpers =====
    public String getFromStatusVi() {
        return statusToVi(fromStatus);
    }

    public String getToStatusVi() {
        return statusToVi(toStatus);
    }

    public static String statusToVi(String s) {
        if (s == null) return "—";
        switch (s.toUpperCase()) {
            case "PENDING":  return "Chờ xử lý";
            case "PAID":     return "Đã thanh toán";
            case "SHIPPING": return "Đang giao";
            case "DONE":     return "Hoàn tất";
            case "CANCEL":   return "Đã hủy";
            default:         return s;
        }
    }

    // ===== Getters/Setters =====
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public String getFromStatus() { return fromStatus; }
    public void setFromStatus(String fromStatus) { this.fromStatus = fromStatus; }

    public String getToStatus() { return toStatus; }
    public void setToStatus(String toStatus) { this.toStatus = toStatus; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public int getChangedBy() { return changedBy; }
    public void setChangedBy(int changedBy) { this.changedBy = changedBy; }

    public String getChangedByName() { return changedByName; }
    public void setChangedByName(String changedByName) { this.changedByName = changedByName; }

    public Timestamp getChangedAt() { return changedAt; }
    public void setChangedAt(Timestamp changedAt) { this.changedAt = changedAt; }
}
