package com.japansport.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.japansport.dao.UserDao;
import com.japansport.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

@WebServlet("/auth/facebook/callback")
public class FacebookCallbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String code = req.getParameter("code");
        String state = req.getParameter("state");
        String error = req.getParameter("error");

        if (error != null) {
            req.setAttribute("errorMessage", "Đăng nhập Facebook bị hủy hoặc lỗi: " + error);
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        String savedState = (session != null) ? (String) session.getAttribute("FACEBOOK_OAUTH_STATE") : null;

        if (savedState == null || !savedState.equals(state)) {
            req.setAttribute("errorMessage", "Xác thực Facebook thất bại (lỗi State).");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        if (session != null) {
            session.removeAttribute("FACEBOOK_OAUTH_STATE");
        }

        if (code != null) {
            Properties props = GoogleAuthServlet.loadConfig();
            String appId = props.getProperty("facebook.appId");
            String appSecret = props.getProperty("facebook.appSecret");
            String redirectUri = props.getProperty("facebook.redirectUri");

            try {
                // Lấy Access Token từ Facebook
                String tokenUrl = "https://graph.facebook.com/v19.0/oauth/access_token"
                        + "?client_id=" + URLEncoder.encode(appId, StandardCharsets.UTF_8)
                        + "&redirect_uri=" + URLEncoder.encode(redirectUri, StandardCharsets.UTF_8)
                        + "&client_secret=" + URLEncoder.encode(appSecret, StandardCharsets.UTF_8)
                        + "&code=" + URLEncoder.encode(code, StandardCharsets.UTF_8);

                HttpClient client = HttpClient.newHttpClient();
                HttpRequest tokenRequest = HttpRequest.newBuilder()
                        .uri(URI.create(tokenUrl))
                        .GET()
                        .build();

                HttpResponse<String> tokenResponse = client.send(tokenRequest, HttpResponse.BodyHandlers.ofString());
                JsonObject tokenJson = JsonParser.parseString(tokenResponse.body()).getAsJsonObject();

                if (!tokenJson.has("access_token")) {
                    req.setAttribute("errorMessage", "Không lấy được access_token từ Facebook.");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                    return;
                }
                String accessToken = tokenJson.get("access_token").getAsString();

                // Lấy thông tin User
                String userInfoUrl = "https://graph.facebook.com/me?fields=id,name,email&access_token=" + accessToken;
                HttpRequest userRequest = HttpRequest.newBuilder()
                        .uri(URI.create(userInfoUrl))
                        .GET()
                        .build();

                HttpResponse<String> userResponse = client.send(userRequest, HttpResponse.BodyHandlers.ofString());
                JsonObject userJson = JsonParser.parseString(userResponse.body()).getAsJsonObject();

                if (!userJson.has("id")) {
                    req.setAttribute("errorMessage", "Không lấy được thông tin từ Facebook.");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                    return;
                }

                String facebookId = userJson.get("id").getAsString();
                String name = userJson.has("name") ? userJson.get("name").getAsString() : "Người dùng Facebook";
                String email = userJson.has("email") ? userJson.get("email").getAsString() : null;

                // Nếu FB trả về email thì check xem đã có trong DB chưa
                // Nếu không có email thì fake email và tìm theo fake email
                String emailToCheck = (email != null && !email.isBlank()) ? email : (facebookId + "@facebook.com");

                UserDao dao = new UserDao();
                User user = dao.findByEmail(emailToCheck);

                if (user == null) {
                    // Chèn user mới
                    user = dao.insertFacebookUser(facebookId, name, email);
                } else {
                    // Update tên nếu cần thiết (optional)
                }

                if (user.getActive() == 0) {
                    req.setAttribute("errorMessage", "Tài khoản của bạn đã bị khóa.");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                    return;
                }

                req.changeSessionId();
                session = req.getSession(true);
                session.setAttribute("currentUser", user);

                resp.sendRedirect(req.getContextPath() + "/");

            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("errorMessage", "Có lỗi khi đăng nhập bằng Facebook.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("errorMessage", "Mã xác thực không hợp lệ.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
