package com.japansport.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.japansport.dao.OrderDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api/webhook/shipping"})
public class WebhookShippingController extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cấu hình UTF-8 để đọc tiếng Việt không bị lỗi font
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        // 1. (Tùy chọn) Xác thực bảo mật: Kiểm tra token từ Header
        // Nếu làm thật sẽ check token ở đây để đảm bảo đúng là ĐVVC gọi
        /*
        String token = request.getHeader("Token");
        if (token == null || !token.equals("MY_SECRET_TOKEN")) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        */

        // 2. Đọc dữ liệu JSON gửi đến từ đơn vị vận chuyển
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        
        String jsonString = sb.toString();
        
        if (jsonString == null || jsonString.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            // 3. Phân tích chuỗi JSON. Dùng Gson (thư viện có sẵn trong build.gradle)
            // Cấu trúc giả định: { "order_code": "123", "status": "delivered", "reason": "Giao thành công" }
            JsonObject jsonObject = JsonParser.parseString(jsonString).getAsJsonObject();
            
            // Lấy mã đơn hàng (mã nội bộ của website mình)
            String orderCodeStr = jsonObject.has("order_code") && !jsonObject.get("order_code").isJsonNull() 
                    ? jsonObject.get("order_code").getAsString() : "";
            
            // Lấy trạng thái mới từ bên vận chuyển
            String status = jsonObject.has("status") && !jsonObject.get("status").isJsonNull() 
                    ? jsonObject.get("status").getAsString() : "";
            
            String reason = jsonObject.has("reason") && !jsonObject.get("reason").isJsonNull() 
                    ? jsonObject.get("reason").getAsString() : "Hệ thống tự cập nhật qua Webhook";

            if (!orderCodeStr.isEmpty() && !status.isEmpty()) {
                try {
                    int orderId = Integer.parseInt(orderCodeStr);
                    
                    // Chuyển đổi trạng thái từ Đơn vị vận chuyển sang hệ thống của mình
                    // Ví dụ: họ báo "delivered" thì mình lưu là "COMPLETED"
                    String systemStatus = "SHIPPING"; 
                    if (status.equalsIgnoreCase("delivered") || status.equalsIgnoreCase("thanh_cong")) {
                        systemStatus = "DONE";
                    } else if (status.equalsIgnoreCase("returned") || status.equalsIgnoreCase("hoan_hang")) {
                        systemStatus = "CANCEL";
                    }

                    // 4. Bỏ qua OrderDao để tự Update trực tiếp, giúp in ra mã lỗi SQL chi tiết lên Postman
                    boolean isSuccess = false;
                    String errorDetail = "";
                    
                    try {
                        // Dùng Reflection để gọi phương thức protected getConnection()
                        java.lang.reflect.Method m = com.japansport.dao.DAO.class.getDeclaredMethod("getConnection");
                        m.setAccessible(true);
                        java.sql.Connection conn = (java.sql.Connection) m.invoke(orderDao); // Lỗi ở đây sẽ ném ra SQL Exception
                        
                        String updateSql = "UPDATE orders SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
                        java.sql.PreparedStatement ps = conn.prepareStatement(updateSql);
                        ps.setString(1, systemStatus);
                        ps.setInt(2, orderId);
                        int affected = ps.executeUpdate();
                        if (affected > 0) {
                            isSuccess = true;
                        } else {
                            errorDetail = "Lệnh Update chạy thành công nhưng không có dòng nào bị ảnh hưởng (Order ID không khớp)";
                        }
                        ps.close();
                        conn.close();
                    } catch (Exception ex) {
                        isSuccess = false;
                        errorDetail = ex.toString() + " - " + ex.getMessage();
                    }

                    if (isSuccess) {
                        response.setStatus(HttpServletResponse.SC_OK);
                        response.getWriter().write("{\"success\": true, \"message\": \"Webhook chạy hoàn hảo! Đã cập nhật trạng thái thành " + systemStatus + "\"}");
                        return;
                    } else {
                        response.setStatus(HttpServletResponse.SC_OK);
                        response.getWriter().write("{\"success\": false, \"message\": \"Lỗi Update DB: " + errorDetail + "\"}");
                        return;
                    }

                } catch (NumberFormatException e) {
                    System.out.println("Mã đơn hàng không hợp lệ: " + orderCodeStr);
                }
            }

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": false, \"message\": \"Thiếu order_code hoặc status\"}");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi: " + e.getMessage() + "\"}");
        }
    }
}
