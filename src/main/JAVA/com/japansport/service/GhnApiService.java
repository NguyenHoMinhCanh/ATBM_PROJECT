package com.japansport.service;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class GhnApiService {
    
    private static final String GHN_TOKEN = "0e125c2f-697f-11f1-a973-aee5264794df";
    private static final String SHOP_ID = "200740";
    private static final String CREATE_ORDER_URL = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/create";

    public static String createOrder(String toName, String toPhone, String fullAddress, int districtId, String wardCode, double codAmount) throws Exception {
        URL url = new URL(CREATE_ORDER_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Token", GHN_TOKEN);
        conn.setRequestProperty("ShopId", SHOP_ID);
        conn.setDoOutput(true);

        // Tạo JSON body
        JsonObject body = new JsonObject();
        body.addProperty("payment_type_id", 1); // 1: Người bán trả ship
        body.addProperty("note", "Giao hàng cẩn thận");
        body.addProperty("required_note", "CHOTHUHANG");
        body.addProperty("to_name", toName);
        body.addProperty("to_phone", toPhone);
        body.addProperty("to_address", fullAddress);
        body.addProperty("to_ward_code", wardCode);
        body.addProperty("to_district_id", districtId);
        body.addProperty("cod_amount", (int) codAmount);
        body.addProperty("weight", 500); // 500 gram
        body.addProperty("length", 20); // 20 cm
        body.addProperty("width", 20);
        body.addProperty("height", 10);
        body.addProperty("service_type_id", 2); // 2: Đi chuẩn

        // Thông tin món hàng (gửi mẫu 1 món)
        JsonArray items = new JsonArray();
        JsonObject item = new JsonObject();
        item.addProperty("name", "Giày Thể Thao");
        item.addProperty("quantity", 1);
        item.addProperty("price", (int) codAmount);
        item.addProperty("weight", 500);
        items.add(item);
        body.add("items", items);

        // Gửi request
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = body.toString().getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        // Đọc response
        int responseCode = conn.getResponseCode();
        try (Scanner scanner = new Scanner(responseCode >= 200 && responseCode < 300 ? conn.getInputStream() : conn.getErrorStream(), "utf-8")) {
            String responseStr = scanner.useDelimiter("\\A").hasNext() ? scanner.next() : "";
            System.out.println("GHN Response: " + responseStr);
            
            if (responseCode == 200) {
                JsonObject jsonResponse = new Gson().fromJson(responseStr, JsonObject.class);
                if (jsonResponse.has("data") && !jsonResponse.get("data").isJsonNull()) {
                    JsonObject dataObj = jsonResponse.getAsJsonObject("data");
                    if (dataObj.has("order_code")) {
                        return dataObj.get("order_code").getAsString();
                    }
                }
            }
            throw new Exception("Lỗi từ GHN: " + responseStr);
        }
    }
}
