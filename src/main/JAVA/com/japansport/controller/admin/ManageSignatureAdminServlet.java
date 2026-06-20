package com.japansport.controller.admin;

import com.japansport.dao.OrderSignatureDao;
import com.japansport.model.OrderSignature;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.japansport.util.RSAUtil;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/signatures"})
public class ManageSignatureAdminServlet extends HttpServlet {

    private final OrderSignatureDao signatureDao = new OrderSignatureDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<OrderSignature> signatures = signatureDao.getAllSignatures();
        
        // DYNAMIC VERIFICATION (Kiểm tra chống giả mạo DB)
        for (OrderSignature os : signatures) {
            try {
                String pubKeyBase64 = os.getCurrentPublicKey();
                String savedHash = os.getHashData();
                
                // Kiểm tra xem dữ liệu trong DB (orders) có bị sửa đổi so với Hash không
                boolean isDbTampered = false;
                try {
                    long currentDbTotal = Math.round(os.getTotalAmount());
                    String[] parts = savedHash.split("\\|");
                    if (parts.length >= 3) {
                        long savedTotal = Long.parseLong(parts[2].replaceAll("[^\\d]", ""));
                        if (savedTotal != currentDbTotal) {
                            isDbTampered = true; // Giá tiền trong DB đã bị thầy sửa!
                        }
                    }
                } catch (Exception e) {}

                if (pubKeyBase64 != null && !pubKeyBase64.isEmpty() && !isDbTampered) {
                    java.security.PublicKey pubKey = RSAUtil.getPublicKeyFromBase64(pubKeyBase64);
                    // Verify chữ ký với chuỗi Hash gốc 5 trường
                    boolean isValidNow = RSAUtil.verify(savedHash, os.getSignature(), pubKey);
                    os.setValid(isValidNow);
                } else {
                    os.setValid(false);
                }
            } catch (Exception e) {
                os.setValid(false);
            }
        }
        
        req.setAttribute("signatures", signatures);
        req.getRequestDispatcher("/admin/manage_signatures.jsp").forward(req, resp);
    }
}
