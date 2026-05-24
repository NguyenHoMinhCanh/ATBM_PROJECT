package com.japansport.service;

import com.japansport.dao.VoucherDao;
import com.japansport.model.Voucher;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class VoucherService {
    private VoucherDao voucherDao = new VoucherDao();

    public Voucher applyVoucher(String code, BigDecimal orderTotal) {
        if (code == null || code.trim().isEmpty()) return null;

        Voucher voucher = voucherDao.getVoucherByCode(code.trim());
        if (voucher == null || !voucher.isActive()) {
            return null;
        }

        LocalDateTime now = LocalDateTime.now();

        // check time hieu luc
        if (voucher.getStartDate() != null && now.isBefore(voucher.getStartDate())) return null;
        if (voucher.getEndDate() != null && now.isAfter(voucher.getEndDate())) return null;

        // check gia tri don toi thieu
        if (orderTotal.compareTo(voucher.getMinOrderValue()) < 0) return null;

        // check gioi han su dung
        if (voucher.getUsageLimit() != null && voucher.getUsedCount() >= voucher.getUsageLimit()) {
            return null;
        }

        return voucher;
    }

    public BigDecimal calculateDiscount(Voucher voucher, BigDecimal orderTotal) {
        if (voucher == null) return BigDecimal.ZERO;

        BigDecimal discount;
        if ("percent".equals(voucher.getDiscountType())) {
            discount = orderTotal.multiply(voucher.getDiscountValue().divide(BigDecimal.valueOf(100)));

        } else {
            discount = voucher.getDiscountValue();
        }

        // gioi han giam toi da
        if (voucher.getMaxDiscount() != null && discount.compareTo(voucher.getMaxDiscount()) > 0) {
            discount = voucher.getMaxDiscount();
        }

        return discount;
    }
}
