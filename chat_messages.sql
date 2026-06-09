-- =============================================
-- BANG LUU TIN NHAN CHAT GIUA KHACH HANG VA ADMIN
-- Chay file nay trong MySQL/phpMyAdmin de tao bang
-- =============================================

CREATE TABLE IF NOT EXISTS chat_messages (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL COMMENT 'ID cua khach hang (tham chieu bang users)',
    sender_role VARCHAR(10) NOT NULL DEFAULT 'USER' COMMENT 'USER hoac ADMIN',
    content     TEXT NOT NULL COMMENT 'Noi dung tin nhan',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_user_id (user_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
