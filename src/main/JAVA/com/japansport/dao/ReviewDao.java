package com.japansport.dao;

import com.japansport.model.Review;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class ReviewDao extends DAO {

    private Review mapRow(ResultSet rs) throws SQLException {
        Review r = new Review();
        r.setId(rs.getInt("id"));
        r.setProductId(rs.getInt("product_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setRating(rs.getInt("rating"));
        r.setComment(rs.getString("comment"));
        r.setStatus(rs.getString("status"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        try { r.setUserName(rs.getString("user_name")); } catch (SQLException ignored) {}
        return r;
    }

    public static class PageResult<T> {
        public final List<T> items;
        public final int page;
        public final int pageSize;
        public final int total;
        public final int totalPages;

        public PageResult(List<T> items, int page, int pageSize, int total) {
            this.items = items;
            this.page = page;
            this.pageSize = pageSize;
            this.total = total;
            this.totalPages = (int) Math.ceil(total / (double) pageSize);
        }
    }

    // Summary (APPROVED only)
    public Map<String, Object> getStatsApproved(int productId) {
        Map<String, Object> out = new HashMap<>();
        double avg = 0.0;
        int count = 0;
        Map<Integer, Integer> counts = new HashMap<>();
        for (int i = 1; i <= 5; i++) counts.put(i, 0);

        try {
            String sqlAvg = "SELECT AVG(rating) AS avg_rating, COUNT(*) AS cnt " +
                    "FROM reviews WHERE product_id=? AND status='APPROVED'";
            PreparedStatement ps1 = getPreparedStatement(sqlAvg);
            ps1.setInt(1, productId);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                avg = rs1.getDouble("avg_rating");
                count = rs1.getInt("cnt");
            }

            String sqlCounts = "SELECT rating, COUNT(*) AS cnt " +
                    "FROM reviews WHERE product_id=? AND status='APPROVED' GROUP BY rating";
            PreparedStatement ps2 = getPreparedStatement(sqlCounts);
            ps2.setInt(1, productId);
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                counts.put(rs2.getInt("rating"), rs2.getInt("cnt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        out.put("avg", avg);
        out.put("count", count);
        out.put("counts", counts);
        return out;
    }

    private String buildOrderBy(String sortKey) {
        if (sortKey == null) sortKey = "";
        switch (sortKey) {
            case "highest": return " ORDER BY r.rating DESC, r.created_at DESC, r.id DESC";
            case "lowest":  return " ORDER BY r.rating ASC, r.created_at DESC, r.id DESC";
            case "newest":
            default:        return " ORDER BY r.created_at DESC, r.id DESC";
        }
    }

    // Visible list: guest -> APPROVED; user -> APPROVED + mine PENDING
    public PageResult<Review> findVisible(int productId, Integer viewerUserId,
                                          int ratingFilter, String sortKey,
                                          int page, int pageSize) {
        if (page < 1) page = 1;
        if (pageSize < 1) pageSize = 6;
        int offset = (page - 1) * pageSize;

        boolean hasFilter = ratingFilter >= 1 && ratingFilter <= 5;

        String whereBase;
        if (viewerUserId == null) {
            whereBase = " WHERE r.product_id=? AND r.status='APPROVED' ";
        } else {
            whereBase = " WHERE r.product_id=? AND (r.status='APPROVED' OR (r.status='PENDING' AND r.user_id=?)) ";
        }
        String whereRating = hasFilter ? " AND r.rating=? " : "";

        int total = 0;
        List<Review> items = new ArrayList<>();

        try {
            String sqlCount = "SELECT COUNT(*) AS cnt FROM reviews r " + whereBase + whereRating;
            PreparedStatement psCount = getPreparedStatement(sqlCount);
            int idx = 1;
            psCount.setInt(idx++, productId);
            if (viewerUserId != null) psCount.setInt(idx++, viewerUserId);
            if (hasFilter) psCount.setInt(idx++, ratingFilter);
            ResultSet rsCount = psCount.executeQuery();
            if (rsCount.next()) total = rsCount.getInt("cnt");

            String sqlList =
                    "SELECT r.*, u.name AS user_name " +
                            "FROM reviews r LEFT JOIN users u ON r.user_id = u.id " +
                            whereBase + whereRating +
                            buildOrderBy(sortKey) +
                            " LIMIT ? OFFSET ?";

            PreparedStatement ps = getPreparedStatement(sqlList);
            idx = 1;
            ps.setInt(idx++, productId);
            if (viewerUserId != null) ps.setInt(idx++, viewerUserId);
            if (hasFilter) ps.setInt(idx++, ratingFilter);
            ps.setInt(idx++, pageSize);
            ps.setInt(idx++, offset);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) items.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return new PageResult<>(items, page, pageSize, total);
    }

    public boolean insertReview(int productId, int userId, int rating, String comment, String status) {
        try {
            String sql = "INSERT INTO reviews(product_id, user_id, rating, comment, status, created_at) " +
                    "VALUES(?,?,?,?, ?, NOW())";
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ps.setInt(3, rating);
            ps.setString(4, comment);
            ps.setString(5, status);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Nếu schema orders/order_items không đúng thì mình return true để không chặn
    public boolean canUserReview(int userId, int productId) {
        try {
            String sql =
                    "SELECT 1 FROM orders o JOIN order_items oi ON o.id = oi.order_id " +
                            "WHERE o.user_id=? AND oi.product_id=? LIMIT 1";
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            return true;
        }
    }

    /**
     * Lấy rating trung bình + số lượng đánh giá của nhiều sản phẩm cùng lúc.
     * Tránh N+1 query khi render danh sách sản phẩm trang chủ.
     *
     * @param productIds danh sách id sản phẩm cần lấy
     * @return Map<productId, double[]{avg, count}>
     */
    public Map<Integer, double[]> getAvgRatingBatch(List<Integer> productIds) {
        Map<Integer, double[]> result = new HashMap<>();
        if (productIds == null || productIds.isEmpty()) return result;

        // Xây dựng chuỗi placeholder (?, ?, ...) an toàn
        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < productIds.size(); i++) {
            if (i > 0) placeholders.append(",");
            placeholders.append("?");
        }

        String sql = "SELECT product_id, AVG(rating) AS avg_r, COUNT(*) AS cnt " +
                     "FROM reviews " +
                     "WHERE product_id IN (" + placeholders + ") AND status = 'APPROVED' " +
                     "GROUP BY product_id";
        try {
            PreparedStatement ps = getPreparedStatement(sql);
            for (int i = 0; i < productIds.size(); i++) {
                ps.setInt(i + 1, productIds.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int pid = rs.getInt("product_id");
                double avg = rs.getDouble("avg_r");
                int cnt = rs.getInt("cnt");
                result.put(pid, new double[]{avg, cnt});
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // ===== ADMIN METHODS =====

    public List<Review> adminGetAll(String status) {
        List<Review> list = new ArrayList<>();
        try {
            String sql = "SELECT r.*, u.name AS user_name, p.name AS product_name FROM reviews r " +
                    "LEFT JOIN users u ON r.user_id = u.id " +
                    "LEFT JOIN products p ON r.product_id = p.id ";
            if (status != null && !status.isEmpty()) {
                sql += " WHERE r.status = ? ";
            }
            sql += " ORDER BY CASE WHEN r.status = 'PENDING' THEN 1 ELSE 2 END, r.created_at DESC";
            
            PreparedStatement ps = getPreparedStatement(sql);
            if (status != null && !status.isEmpty()) {
                ps.setString(1, status);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review r = mapRow(rs);
                // Vì mapRow không có productName, ta set thủ công cho admin
                try {
                    r.setProductName(rs.getString("product_name"));
                } catch (SQLException ignore) {}
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean adminUpdateStatus(int reviewId, String status) {
        try {
            String sql = "UPDATE reviews SET status=? WHERE id=?";
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, reviewId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean adminDelete(int reviewId) {
        try {
            String sql = "DELETE FROM reviews WHERE id=?";
            PreparedStatement ps = getPreparedStatement(sql);
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
