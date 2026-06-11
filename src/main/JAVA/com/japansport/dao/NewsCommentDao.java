package com.japansport.dao;

import com.japansport.model.NewsComment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewsCommentDao extends DAO {

    // Hàm lấy danh sách bình luận theo bài viết
    public List<NewsComment> getByNewsId(int newsId) {
        List<NewsComment> list = new ArrayList<>();
        String sql = "SELECT * FROM news_comments WHERE news_id = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = getPreparedStatement(sql)) {
            ps.setInt(1, newsId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NewsComment c = new NewsComment();
                    c.setId(rs.getInt("id"));
                    c.setNewsId(rs.getInt("news_id"));
                    c.setUserName(rs.getString("user_name"));
                    c.setContent(rs.getString("content"));
                    c.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hàm thêm bình luận mới
    public boolean insert(NewsComment c) {
        String sql = "INSERT INTO news_comments(news_id, user_name, content) VALUES(?,?,?)";
        try (PreparedStatement ps = getPreparedStatement(sql)) {
            ps.setInt(1, c.getNewsId());
            ps.setString(2, c.getUserName());
            ps.setString(3, c.getContent());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}