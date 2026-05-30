package com.japansport.model;

import java.sql.Timestamp;

public class Notification {

    // Loại thông báo - dùng constant để tránh magic string
    public static final String TYPE_ORDER  = "ORDER";
    public static final String TYPE_PROMO  = "PROMO";
    public static final String TYPE_SYSTEM = "SYSTEM";

    private int id;
    private int userId;
    private String type;      // ORDER, PROMO, SYSTEM
    private String title;
    private String content;
    private String link;
    private boolean read;     // ánh xạ cột is_read
    private Timestamp createdAt;

    // ===== Constructors =====

    public Notification() {}

    /** Constructor tiện lợi để tạo nhanh thông báo rồi insert */
    public Notification(int userId, String type, String title, String content, String link) {
        this.userId  = userId;
        this.type    = type;
        this.title   = title;
        this.content = content;
        this.link    = link;
        this.read    = false;
    }

    // ===== Getters & Setters =====

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getLink() { return link; }
    public void setLink(String link) { this.link = link; }

    public boolean isRead() { return read; }
    public void setRead(boolean read) { this.read = read; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    // ===== Helper method =====

    /** Trả về icon Bootstrap Icons tương ứng với từng loại thông báo (dùng trong JSP) */
    public String getTypeIcon() {
        if (type == null) return "bi-bell";
        switch (type) {
            case TYPE_ORDER:  return "bi-bag-check";
            case TYPE_PROMO:  return "bi-tag";
            case TYPE_SYSTEM: return "bi-info-circle";
            default:          return "bi-bell";
        }
    }
}
