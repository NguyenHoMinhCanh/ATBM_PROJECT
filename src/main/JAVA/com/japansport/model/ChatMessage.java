package com.japansport.model;

import java.sql.Timestamp;

public class ChatMessage {
    int id;
    int userId;         // id cua khach hang
    String senderRole;  // "USER" hoac "ADMIN"
    String content;
    Timestamp createdAt;

    // them truong phu: ten nguoi gui (de hien thi ben admin)
    String senderName;

    public ChatMessage() {
    }

    public ChatMessage(int userId, String senderRole, String content) {
        this.userId = userId;
        this.senderRole = senderRole;
        this.content = content;
    }

    // --- getter / setter ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getSenderRole() { return senderRole; }
    public void setSenderRole(String senderRole) { this.senderRole = senderRole; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getSenderName() { return senderName; }
    public void setSenderName(String senderName) { this.senderName = senderName; }
}
