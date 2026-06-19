package com.japansport.model;

import java.sql.Timestamp;

public class OrderSignature {
    private int id;
    private int orderId;
    private String hashData;
    private String signature;
    private boolean valid;
    private Timestamp createdAt;

    // Fields for join
    private String customerName;
    private double totalAmount;
    
    // Additional fields for real-time verification
    private String currentEmail;
    private String currentFullName;
    private String currentPhone;
    private String currentPublicKey;

    public OrderSignature() {
    }

    public OrderSignature(int id, int orderId, String hashData, String signature, boolean valid, Timestamp createdAt) {
        this.id = id;
        this.orderId = orderId;
        this.hashData = hashData;
        this.signature = signature;
        this.valid = valid;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getHashData() {
        return hashData;
    }

    public void setHashData(String hashData) {
        this.hashData = hashData;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getCurrentEmail() { return currentEmail; }
    public void setCurrentEmail(String currentEmail) { this.currentEmail = currentEmail; }

    public String getCurrentFullName() { return currentFullName; }
    public void setCurrentFullName(String currentFullName) { this.currentFullName = currentFullName; }

    public String getCurrentPhone() { return currentPhone; }
    public void setCurrentPhone(String currentPhone) { this.currentPhone = currentPhone; }

    public String getCurrentPublicKey() { return currentPublicKey; }
    public void setCurrentPublicKey(String currentPublicKey) { this.currentPublicKey = currentPublicKey; }
}
