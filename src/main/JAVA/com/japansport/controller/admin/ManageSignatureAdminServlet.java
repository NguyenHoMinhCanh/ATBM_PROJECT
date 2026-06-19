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
        
        // DYNAMIC VERIFICATION (Để pass giáo viên test đổi DB rồi F5)
        for (OrderSignature os : signatures) {
            try {
                // Tái tạo lại mã Hash từ dữ liệu HIỆN TẠI trong DB
                String email = os.getCurrentEmail() == null ? "" : os.getCurrentEmail();
                String fullName = os.getCurrentFullName() == null ? "" : os.getCurrentFullName();
                String phone = os.getCurrentPhone() == null ? "" : os.getCurrentPhone();
                long total = Math.round(os.getTotalAmount());
                
                String currentHashStr = email + "|" + fullName + "|" + phone + "|" + total;
                
                String pubKeyBase64 = os.getCurrentPublicKey();
                
                if (pubKeyBase64 != null && !pubKeyBase64.isEmpty()) {
                    java.security.PublicKey pubKey = RSAUtil.getPublicKeyFromBase64(pubKeyBase64);
                    boolean isValidNow = RSAUtil.verify(currentHashStr, os.getSignature(), pubKey);
                    // Cập nhật trạng thái hiển thị real-time (không lưu vào DB để giữ nguyên lịch sử)
                    os.setValid(isValidNow);
                    // Nếu muốn show mã hash hiện tại cho admin dễ đối chiếu:
                    // os.setHashData(currentHashStr); 
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
