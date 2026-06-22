package com.japansport.dao;

import com.japansport.model.UserKeyHistory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserKeyHistoryDao extends DAO {

    public boolean logGeneration(int userId, String publicKey) {
        String sql = "INSERT INTO user_key_history(user_id, public_key, created_at) VALUES(?, ?, CURRENT_TIMESTAMP)";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, publicKey);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean logLoss(int userId) {
        String sql = "UPDATE user_key_history SET expired_at = CURRENT_TIMESTAMP WHERE user_id = ? AND expired_at IS NULL";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<UserKeyHistory> getHistoryByUserId(int userId) {
        List<UserKeyHistory> list = new ArrayList<>();
        String sql = "SELECT id, user_id, public_key, created_at, expired_at FROM user_key_history WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection cn = getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserKeyHistory h = new UserKeyHistory();
                    h.setId(rs.getInt("id"));
                    h.setUserId(rs.getInt("user_id"));
                    h.setPublicKey(rs.getString("public_key"));
                    h.setCreatedAt(rs.getTimestamp("created_at"));
                    h.setExpiredAt(rs.getTimestamp("expired_at"));
                    list.add(h);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
