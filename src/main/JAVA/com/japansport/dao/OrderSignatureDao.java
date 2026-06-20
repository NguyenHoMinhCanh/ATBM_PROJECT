package com.japansport.dao;

import com.japansport.model.OrderSignature;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderSignatureDao extends DAO {

    public boolean insertSignature(int orderId, String hashData, String signature, boolean isValid) {
        String sql = "INSERT INTO order_signatures(order_id, hash_data, signature, is_valid) VALUES(?, ?, ?, ?)";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setString(2, hashData);
            ps.setString(3, signature);
            ps.setInt(4, isValid ? 1 : 0);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<OrderSignature> getAllSignatures() {
        List<OrderSignature> list = new ArrayList<>();
        String sql = "SELECT s.*, u.name as customer_name, o.total_amount, " +
                     "u.email, u.public_key, a.full_name, a.phone " +
                     "FROM order_signatures s " +
                     "JOIN orders o ON s.order_id = o.id " +
                     "JOIN users u ON o.user_id = u.id " +
                     "JOIN user_addresses a ON o.address_id = a.id " +
                     "ORDER BY s.created_at DESC";
                     
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                OrderSignature os = new OrderSignature();
                os.setId(rs.getInt("id"));
                os.setOrderId(rs.getInt("order_id"));
                os.setHashData(rs.getString("hash_data"));
                os.setSignature(rs.getString("signature"));
                os.setValid(rs.getInt("is_valid") == 1);
                os.setCreatedAt(rs.getTimestamp("created_at"));
                os.setCustomerName(rs.getString("customer_name"));
                os.setTotalAmount(rs.getDouble("total_amount"));
                
                os.setCurrentEmail(rs.getString("email"));
                os.setCurrentFullName(rs.getString("full_name"));
                os.setCurrentPhone(rs.getString("phone"));
                os.setCurrentPublicKey(rs.getString("public_key"));
                
                list.add(os);
            }
        } catch (SQLException e) {
            OrderSignature err = new OrderSignature();
            err.setId(-1);
            err.setOrderId(-1);
            err.setCustomerName("ERROR");
            err.setHashData(e.getMessage() + " | " + e.getClass().getName());
            err.setSignature("ERROR");
            list.add(err);
            e.printStackTrace();
        }
        return list;
    }
}
