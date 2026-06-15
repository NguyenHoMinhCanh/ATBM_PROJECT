package com.japansport.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.UUID;

@WebServlet("/auth/facebook")
public class FacebookAuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Nếu đã đăng nhập thì không cần OAuth nữa
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        Properties props = GoogleAuthServlet.loadConfig(); // Dùng ké hàm loadConfig bên Google
        String appId = props.getProperty("facebook.appId");
        String redirectUri = props.getProperty("facebook.redirectUri");

        // Tạo state token chống CSRF
        String state = UUID.randomUUID().toString();
        req.getSession().setAttribute("FACEBOOK_OAUTH_STATE", state);

        String authUrl = "https://www.facebook.com/v19.0/dialog/oauth"
                + "?client_id=" + URLEncoder.encode(appId, StandardCharsets.UTF_8)
                + "&redirect_uri=" + URLEncoder.encode(redirectUri, StandardCharsets.UTF_8)
                + "&state=" + URLEncoder.encode(state, StandardCharsets.UTF_8)
                + "&scope=public_profile";

        resp.sendRedirect(authUrl);
    }
}
