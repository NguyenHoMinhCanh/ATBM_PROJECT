package com.japansport.controller;

import com.japansport.dao.UserDao;
import com.japansport.model.User;
import com.japansport.util.RSAUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.OutputStream;
import java.security.KeyPair;
import java.security.PrivateKey;
import java.security.PublicKey;

@WebServlet("/generate-key")
public class KeyManagementServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if ("reset".equals(action)) {
            userDao.updatePublicKey(currentUser.getId(), null);
            currentUser.setPublicKey(null);
            session.setAttribute("currentUser", currentUser);
            session.setAttribute("FLASH_MSG", "Khóa cũ đã bị xóa. Bạn có thể tạo khóa mới.");
            session.setAttribute("FLASH_TYPE", "success");
            resp.sendRedirect(req.getContextPath() + "/account");
            return;
        }

        if (currentUser.getPublicKey() != null && !currentUser.getPublicKey().isEmpty()) {
            session.setAttribute("FLASH_MSG", "Bạn đã có khóa. Vui lòng báo mất khóa nếu muốn tạo lại.");
            session.setAttribute("FLASH_TYPE", "error");
            resp.sendRedirect(req.getContextPath() + "/account");
            return;
        }

        try {
            // Generate Key Pair
            KeyPair keyPair = RSAUtil.generateKeyPair();
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();

            // Store Public Key to Database
            String publicKeyBase64 = RSAUtil.keyToBase64(publicKey);
            userDao.updatePublicKey(currentUser.getId(), publicKeyBase64);
            
            // Update the session user
            currentUser.setPublicKey(publicKeyBase64);
            session.setAttribute("currentUser", currentUser);

            // Send Private Key to the user as a downloadable file
            String privateKeyBase64 = RSAUtil.keyToBase64(privateKey);
            
            resp.setContentType("application/octet-stream");
            resp.setHeader("Content-Disposition", "attachment; filename=\"private_key.pem\"");
            
            try (OutputStream out = resp.getOutputStream()) {
                out.write(privateKeyBase64.getBytes("UTF-8"));
                out.flush();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("FLASH_MSG", "Lỗi tạo khóa. Vui lòng thử lại.");
            session.setAttribute("FLASH_TYPE", "error");
            resp.sendRedirect(req.getContextPath() + "/account");
        }
    }
}
