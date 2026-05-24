package com.japansport.util;

import java.text.Normalizer;
import java.util.regex.Pattern;

/**
 * Tiện ích xử lý văn bản tiếng Việt.
 * Dùng chủ yếu cho chức năng tìm kiếm không dấu.
 */
public final class ViTextUtil {

    private static final Pattern COMBINING_MARKS = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");

    private ViTextUtil() {}

    /**
     * Chuyển chuỗi tiếng Việt về dạng không dấu, chữ thường.
     * Ví dụ: "Giày Chạy Bộ" → "giay chay bo"
     */
    public static String stripAccents(String input) {
        if (input == null) return "";
        // NFD: tách ký tự có dấu thành ký tự gốc + combining mark
        String normalized = Normalizer.normalize(input, Normalizer.Form.NFD);
        // Bỏ hết combining marks (các dấu)
        String stripped = COMBINING_MARKS.matcher(normalized).replaceAll("");
        // Riêng chữ đ/Đ không bị xử lý bởi NFD nên phải replace thủ công
        stripped = stripped.replace('đ', 'd').replace('Đ', 'D');
        return stripped.toLowerCase();
    }

    /**
     * Kiểm tra xem {@code text} có chứa {@code keyword} không,
     * so sánh cả hai ở dạng không dấu, chữ thường.
     */
    public static boolean containsIgnoreAccent(String text, String keyword) {
        if (text == null || keyword == null) return false;
        return stripAccents(text).contains(stripAccents(keyword));
    }
}
