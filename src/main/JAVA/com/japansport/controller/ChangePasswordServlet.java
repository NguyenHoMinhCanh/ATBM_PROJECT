package com.japansport.controller;

import com.japansport.dao.UserDao;
import com.japansport.dao.UserKeyHistoryDao;
import com.japansport.model.User;
import com.japansport.model.UserKeyHistory;
import com.japansport.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.List;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private static String ensureCsrf(HttpSession session) {
        Object cur = session.getAttribute("CSRF_TOKEN");
        if (cur != null) return String.valueOf(cur);

        byte[] buf = new byte[32];
        new SecureRandom().nextBytes(buf);
        String token = Base64.getUrlEncoder().withoutPadding().encodeToString(buf);
        session.setAttribute("CSRF_TOKEN", token);
        return token;
    }

    private static boolean validCsrf(HttpServletRequest req) {
        HttpSession session = req.getSession();
        String s = String.valueOf(session.getAttribute("CSRF_TOKEN"));
        String r = req.getParameter("csrf");
        return r != null && r.equals(s);
    }

    private static void redirectLogin(HttpServletRequest req, HttpServletResponse resp, String backPath) throws IOException {
        resp.sendRedirect(req.getContextPath() + "/login.jsp?back=" + backPath);
    }

    private void forwardToChangePassword(HttpServletRequest req, HttpServletResponse resp, User u) throws ServletException, IOException {
        try {
            UserKeyHistoryDao historyDao = new UserKeyHistoryDao();
            List<UserKeyHistory> keyHistory = historyDao.getHistoryByUserId(u.getId());
            if (keyHistory.isEmpty() && u.getPublicKey() != null && !u.getPublicKey().trim().isEmpty()) {
                historyDao.logGeneration(u.getId(), u.getPublicKey());
                keyHistory = historyDao.getHistoryByUserId(u.getId());
            }
            req.setAttribute("keyHistory", keyHistory);
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.getRequestDispatcher("/change_password.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        ensureCsrf(session);

        User u = (User) session.getAttribute("currentUser");
        if (u == null) {
            redirectLogin(req, resp, "/change-password");
            return;
        }

        forwardToChangePassword(req, resp, u);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        ensureCsrf(session);

        User u = (User) session.getAttribute("currentUser");
        if (u == null) {
            redirectLogin(req, resp, "/change-password");
            return;
        }

        if (!validCsrf(req)) {
            req.setAttribute("errorMessage", "CSRF token không hợp lệ. Vui lòng tải lại trang và thử lại.");
            forwardToChangePassword(req, resp, u);
            return;
        }

        String oldPass = req.getParameter("old_password");
        String newPass = req.getParameter("new_password");
        String confirm = req.getParameter("confirm_password");

        if (oldPass == null || oldPass.isBlank() || newPass == null || newPass.isBlank() || confirm == null || confirm.isBlank()) {
            req.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin.");
            forwardToChangePassword(req, resp, u);
            return;
        }

        if (newPass.length() < 8) {
            req.setAttribute("errorMessage", "Mật khẩu mới tối thiểu 8 ký tự.");
            forwardToChangePassword(req, resp, u);
            return;
        }

        if (!newPass.equals(confirm)) {
            req.setAttribute("errorMessage", "Xác nhận mật khẩu không khớp.");
            forwardToChangePassword(req, resp, u);
            return;
        }

        try {
            UserDao dao = new UserDao();
            User dbUser = dao.getById(u.getId());
            if (dbUser == null || dbUser.getActive() != 1) {
                req.setAttribute("errorMessage", "Tài khoản không hợp lệ.");
                forwardToChangePassword(req, resp, u);
                return;
            }

            if (!PasswordUtil.verify(oldPass, dbUser.getPassword())) {
                req.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng.");
                forwardToChangePassword(req, resp, u);
                return;
            }

            String newHash = PasswordUtil.hash(newPass);
            boolean ok = dao.updatePassword(u.getId(), newHash);

            if (ok) {
                session.setAttribute("FLASH_MSG", "Đổi mật khẩu thành công.");
                session.setAttribute("FLASH_TYPE", "success");
                resp.sendRedirect(req.getContextPath() + "/account");
            } else {
                req.setAttribute("errorMessage", "Đổi mật khẩu thất bại. Vui lòng thử lại.");
                forwardToChangePassword(req, resp, u);
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Có lỗi hệ thống. Vui lòng thử lại.");
            forwardToChangePassword(req, resp, u);
        }
    }
}
