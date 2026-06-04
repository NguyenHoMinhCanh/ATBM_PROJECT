package com.japansport.controller;

import com.japansport.dao.CartDao;
import com.japansport.dao.ProductVariantDAO;
import com.japansport.dao.ProductDao;
import com.japansport.model.Product;
import com.japansport.model.ProductVariant;
import com.japansport.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * API gộp 2 chức năng cho Quick Add / Quick View trên trang danh sách:
 * - GET  /api/cart-quick?action=variants&productId=X  → trả JSON danh sách variant
 * - POST /api/cart-quick?action=add                   → thêm vào giỏ, trả JSON
 */
@WebServlet(name = "CartQuickApiController", value = "/api/cart-quick")
public class CartQuickApiController extends HttpServlet {

    private final CartDao cartDao = new CartDao();
    private final ProductVariantDAO variantDAO = new ProductVariantDAO();
    private final ProductDao productDao = new ProductDao();

    // ========== GET: lấy thông tin sản phẩm + variants cho Quick View ==========
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String action = req.getParameter("action");
        if (!"variants".equals(action)) {
            resp.setStatus(400);
            out.print("{\"ok\":false,\"msg\":\"action không hợp lệ\"}");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(req.getParameter("productId"));
        } catch (Exception e) {
            resp.setStatus(400);
            out.print("{\"ok\":false,\"msg\":\"productId không hợp lệ\"}");
            return;
        }

        // Lấy thông tin sản phẩm
        Product p = productDao.getById(productId);
        if (p == null) {
            resp.setStatus(404);
            out.print("{\"ok\":false,\"msg\":\"Không tìm thấy sản phẩm\"}");
            return;
        }

        // Lấy variants
        List<ProductVariant> variants = variantDAO.findByProductId(productId);

        StringBuilder json = new StringBuilder();
        json.append("{\"ok\":true,");
        json.append("\"product\":{");
        json.append("\"id\":").append(p.getId()).append(",");
        json.append("\"name\":").append(esc(p.getName())).append(",");
        json.append("\"imageUrl\":").append(esc(p.getImage_url())).append(",");
        json.append("\"price\":").append(p.getPrice()).append(",");
        json.append("\"oldPrice\":").append(p.getOld_price());
        json.append("},");
        json.append("\"variants\":[");
        for (int i = 0; i < variants.size(); i++) {
            ProductVariant v = variants.get(i);
            if (i > 0) json.append(",");
            json.append("{");
            json.append("\"id\":").append(v.getId()).append(",");
            json.append("\"color\":").append(esc(v.getColor())).append(",");
            json.append("\"size\":").append(esc(v.getSize())).append(",");
            json.append("\"stockQty\":").append(v.getStockQty()).append(",");
            json.append("\"price\":").append(v.getPrice() != null ? v.getPrice() : "null");
            json.append("}");
        }
        json.append("]}");

        out.print(json);
    }

    // ========== POST: thêm nhanh vào giỏ hàng ==========
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        User u = (User) req.getSession().getAttribute("currentUser");
        if (u == null) {
            resp.setStatus(401);
            out.print("{\"ok\":false,\"msg\":\"login_required\"}");
            return;
        }

        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            String vidStr = req.getParameter("variantId");
            Integer variantId = (vidStr == null || vidStr.isEmpty()) ? null : Integer.parseInt(vidStr);
            int qty = 1;
            try { qty = Integer.parseInt(req.getParameter("qty")); } catch (Exception ignore) {}
            if (qty < 1) qty = 1;

            // Kiểm tra sản phẩm có variant không
            List<ProductVariant> variants = variantDAO.findByProductId(productId);
            if (!variants.isEmpty() && variantId == null) {
                // Sản phẩm có variant nhưng chưa chọn → yêu cầu chọn
                out.print("{\"ok\":false,\"msg\":\"variant_required\"}");
                return;
            }

            // Kiểm tra tồn kho nếu có variantId
            if (variantId != null) {
                ProductVariant v = variantDAO.findById(variantId);
                if (v == null || v.getStockQty() < qty) {
                    out.print("{\"ok\":false,\"msg\":\"Sản phẩm đã hết hàng hoặc không đủ số lượng.\"}");
                    return;
                }
            }

            cartDao.addToCart(u.getId(), productId, variantId, qty);
            int count = cartDao.getCartCount(u.getId());
            out.print("{\"ok\":true,\"msg\":\"Đã thêm vào giỏ hàng!\",\"cartCount\":" + count + "}");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            out.print("{\"ok\":false,\"msg\":\"Lỗi hệ thống, vui lòng thử lại.\"}");
        }
    }

    private String esc(String s) {
        if (s == null) return "null";
        return "\"" + s.replace("\\", "\\\\").replace("\"", "\\\"")
                       .replace("\n", "\\n").replace("\r", "\\r") + "\"";
    }
}
