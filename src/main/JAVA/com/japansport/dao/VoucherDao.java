package com.japansport.dao;

import com.japansport.model.Voucher;
import com.mysql.cj.jdbc.JdbcConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VoucherDao {

    // lấy all voucher
    public List<Voucher> getAllVouchers() {
        List<Voucher> list = new ArrayList<>();
        String sql = "select * from vouchers order by created_at desc";
        try (Connection conn = DBConnect.getInstance().getConnect();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             while (rs.next()) {
                 list.add(mapResultSetToVoucher(rs));
             }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }

    /**
     * Lấy danh sách voucher phù hợp với giá trị đơn hàng:
     * - Còn hiệu lực (is_active = 1)
     * - Trong thời gian áp dụng
     * - Giá trị đơn hàng >= min_order_value
     * - Còn lượt sử dụng
     * Sắp xếp: discount_value DESC (gợi ý voucher có giảm giá cao nhất trước)
     */
    public List<Voucher> getApplicableVouchers(java.math.BigDecimal orderTotal) {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM vouchers WHERE is_active = 1 " +
                "AND (start_date IS NULL OR start_date <= NOW()) " +
                "AND (end_date IS NULL OR end_date >= NOW()) " +
                "AND (min_order_value IS NULL OR min_order_value <= ?) " +
                "AND (usage_limit IS NULL OR used_count < usage_limit) " +
                "ORDER BY discount_value DESC " +
                "LIMIT 5";
        try (Connection conn = DBConnect.getInstance().getConnect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, orderTotal);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToVoucher(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // lay voucher from id
    public Voucher getVoucherById (int id) {
        String sql = "select * from vouchers where id = ?";
        try (Connection conn = DBConnect.getInstance().getConnect();
        PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()){
                if (rs.next()) {
                    return mapResultSetToVoucher(rs);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // tim voucher theo code ( khi user dung ma)
    public Voucher getVoucherByCode(String code) {
        String sql = "select * from vouchers where code = ? and is_active = 1";
        try (Connection conn = DBConnect.getInstance().getConnect();
        PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, code.toUpperCase().trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVoucher(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addVoucher(Voucher voucher) {
        String sql = "INSERT INTO vouchers (code, name, discount_type, discount_value, min_order_value, " +
                "max_discount, start_date, end_date, usage_limit, is_active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getInstance().getConnect();
        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, voucher.getCode().toUpperCase());
            ps.setString(2, voucher.getName());
            ps.setString(3, voucher.getDiscountType());
            ps.setBigDecimal(4, voucher.getDiscountValue());
            ps.setBigDecimal(5, voucher.getMinOrderValue());
            ps.setBigDecimal(6, voucher.getMaxDiscount());
            ps.setTimestamp(7, voucher.getStartDate() != null ? Timestamp.valueOf(voucher.getStartDate()) : null);
            ps.setTimestamp(8, voucher.getEndDate() != null ? Timestamp.valueOf(voucher.getEndDate()) : null);
            ps.setObject(9, voucher.getUsageLimit());
            ps.setBoolean(10, voucher.isActive());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    // update voucher
    public boolean updateVoucher(Voucher voucher) {
        String sql = "UPDATE vouchers SET code=?, name=?, discount_type=?, discount_value=?, " +
                "min_order_value=?, max_discount=?, start_date=?, end_date=?, usage_limit=?, is_active=? " +
                "WHERE id=?";
        try (Connection conn = DBConnect.getInstance().getConnect();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, voucher.getCode().toUpperCase());
            ps.setString(2, voucher.getName());
            ps.setString(3, voucher.getDiscountType());
            ps.setBigDecimal(4, voucher.getDiscountValue());
            ps.setBigDecimal(5, voucher.getMinOrderValue());
            ps.setBigDecimal(6, voucher.getMaxDiscount());
            ps.setTimestamp(7, voucher.getStartDate() != null ? Timestamp.valueOf(voucher.getStartDate()) : null);
            ps.setTimestamp(8, voucher.getEndDate() != null ? Timestamp.valueOf(voucher.getEndDate()) : null);
            ps.setObject(9, voucher.getUsageLimit());
            ps.setBoolean(10, voucher.isActive());
            ps.setInt(11, voucher.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Tự động tắt (is_active = 0) các voucher đã hết hạn (end_date < NOW()).
     * Được gọi bởi VoucherExpiryScheduler mỗi phút.
     * @return số voucher đã bị deactivate
     */
    public int deactivateExpiredVouchers() {
        String sql = "UPDATE vouchers SET is_active = 0 " +
                "WHERE is_active = 1 AND end_date IS NOT NULL AND end_date < NOW()";
        try (Connection conn = DBConnect.getInstance().getConnect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int updated = ps.executeUpdate();
            if (updated > 0) {
                System.out.println("[VoucherDao] Đã tự động tắt " + updated + " voucher hết hạn.");
            }
            return updated;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public boolean deleteVoucher(int id) {
        String sql = "DELETE FROM vouchers WHERE id = ?";
        try (Connection conn = DBConnect.getInstance().getConnect();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private Voucher mapResultSetToVoucher(ResultSet rs) throws Exception{
        Voucher v = new Voucher();
        v.setId(rs.getInt("id"));
        v.setCode(rs.getString("code"));
        v.setName(rs.getString("name"));
        v.setDiscountType(rs.getString("discount_type"));
        v.setDiscountValue(rs.getBigDecimal("discount_value"));
        v.setMinOrderValue(rs.getBigDecimal("min_order_value"));
        v.setMaxDiscount(rs.getBigDecimal("max_discount"));

        Timestamp start = rs.getTimestamp("start_date");
        v.setStartDate(start != null ? start.toLocalDateTime() : null);

        Timestamp end = rs.getTimestamp("end_date");
        v.setEndDate(end != null ? end.toLocalDateTime() : null);

        v.setUsageLimit(rs.getObject("usage_limit", Integer.class));
        v.setUsedCount(rs.getInt("used_count"));
        v.setActive(rs.getBoolean("is_active"));
        v.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        v.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());

        return v;
    }
}
