/*
 Navicat Premium Dump SQL

 Source Server         : Docker_test
 Source Server Type    : MySQL
 Source Server Version : 90600 (9.6.0)
 Source Host           : 192.168.68.128:3306
 Source Schema         : web

 Target Server Type    : MySQL
 Target Server Version : 90600 (9.6.0)
 File Encoding         : 65001

 Date: 16/06/2026 00:37:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banners
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `position` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `active` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banners
-- ----------------------------
INSERT INTO `banners` VALUES (1, 'assets/images/login/1.webp', 'http://localhost:8080/demo/list-product?gender=women', 'Giày nữ thanh lịch', 'HOME_WOMEN_RIGHT', 1, '2025-12-11 23:45:53');
INSERT INTO `banners` VALUES (2, 'https://bizweb.dktcdn.net/100/347/092/themes/708609/assets/banner_product_nangdong.jpg?1767921323274', 'http://localhost:8080/demo/list-product?gender=men', 'giày nam năng động', 'HOME_MEN', 1, '2025-12-11 23:45:53');
INSERT INTO `banners` VALUES (3, 'https://bizweb.dktcdn.net/100/347/092/themes/708609/assets/banner_project_1.jpg?1767921323274', '/list-product?categoryId=4', 'Sneaker lifestyle', 'HOME_MAIN', 1, '2025-12-11 23:45:53');
INSERT INTO `banners` VALUES (4, 'https://bizweb.dktcdn.net/100/347/092/themes/708609/assets/banner_product_noibat.jpg?1767921323274', 'http://localhost:8080/demo/home', 'Banner-bottom', 'HOME_WOMEN_BOTTOM', 1, '2025-12-11 23:45:53');
INSERT INTO `banners` VALUES (5, 'https://bizweb.dktcdn.net/100/347/092/themes/708609/assets/banner.jpg?1767921323274', 'http://localhost:8080/demo/home', 'giày nhật chính hãng', 'HOME_TOP', 1, '2025-12-11 23:45:53');

-- ----------------------------
-- Table structure for brands
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `slug` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `logo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `active` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES (1, 'Nike', 'nike', '/images/brands/nike.png', 1, '2025-12-11 23:45:23', '2025-12-11 23:45:23');
INSERT INTO `brands` VALUES (2, 'Adidas', 'adidas', '/images/brands/adidas.png', 1, '2025-12-11 23:45:23', '2025-12-11 23:45:23');
INSERT INTO `brands` VALUES (3, 'Puma', 'puma', '/images/brands/puma.png', 1, '2025-12-11 23:45:23', '2025-12-11 23:45:23');
INSERT INTO `brands` VALUES (4, 'New Balance', 'new-balance', '/images/brands/new_balance.png', 1, '2025-12-11 23:45:23', '2025-12-11 23:45:23');
INSERT INTO `brands` VALUES (5, 'Converse', 'converse', '/images/brands/converse.png', 1, '2025-12-11 23:45:23', '2025-12-11 23:45:23');
INSERT INTO `brands` VALUES (6, 'Vans', 'vans', '/images/brands/vans.png', 1, '2025-12-11 23:45:23', '2025-12-11 23:45:23');
INSERT INTO `brands` VALUES (7, 'Asics', 'asics', '/images/brands/asics.png', 1, '2025-12-11 23:45:23', '2025-12-11 23:45:23');
INSERT INTO `brands` VALUES (8, 'Reebok', 'reebok', '/images/brands/reebok.png', 1, '2025-12-11 23:45:23', '2025-12-11 23:45:23');
INSERT INTO `brands` VALUES (9, 'Under Armour', 'under-armour', '/images/brands/under_armour.png', 1, '2025-12-11 23:45:23', '2025-12-11 23:45:23');
INSERT INTO `brands` VALUES (10, 'Mizuno', 'mizuno', '/images/brands/mizuno.png', 1, '2025-12-11 23:45:23', '2026-01-15 16:28:09');

-- ----------------------------
-- Table structure for cart_items
-- ----------------------------
DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE `cart_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int NOT NULL,
  `product_id` int NOT NULL,
  `variant_id` int NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_cart_items_cart`(`cart_id` ASC) USING BTREE,
  INDEX `fk_cart_items_product`(`product_id` ASC) USING BTREE,
  INDEX `fk_cart_items_variant`(`variant_id` ASC) USING BTREE,
  CONSTRAINT `fk_cart_items_cart` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_items_variant` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart_items
-- ----------------------------
INSERT INTO `cart_items` VALUES (1, 1, 1, NULL, 2, '2025-12-15 23:36:34');
INSERT INTO `cart_items` VALUES (2, 1, 3, NULL, 1, '2025-12-15 23:36:34');
INSERT INTO `cart_items` VALUES (3, 1, 7, NULL, 1, '2025-12-15 23:36:34');
INSERT INTO `cart_items` VALUES (4, 2, 2, NULL, 1, '2025-12-15 23:36:34');
INSERT INTO `cart_items` VALUES (5, 2, 8, NULL, 2, '2025-12-15 23:36:34');

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ACTIVE',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `active_key` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uq_carts_active_key`(`active_key` ASC) USING BTREE,
  INDEX `idx_carts_user_active`(`user_id` ASC, `is_active` ASC) USING BTREE,
  CONSTRAINT `fk_carts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carts
-- ----------------------------
INSERT INTO `carts` VALUES (1, 3, '2025-12-15 23:36:21', '2026-01-01 23:31:47', 'ORDERED', 0, NULL);
INSERT INTO `carts` VALUES (2, 4, '2025-12-15 23:36:21', '2026-01-01 23:31:47', 'ORDERED', 0, NULL);
INSERT INTO `carts` VALUES (3, 3, '2025-12-15 23:36:34', '2026-01-01 23:31:53', 'ACTIVE', 1, 3);
INSERT INTO `carts` VALUES (4, 4, '2025-12-15 23:36:34', '2026-01-01 23:31:53', 'ACTIVE', 1, 4);
INSERT INTO `carts` VALUES (5, 1, '2025-12-31 01:27:40', '2026-01-13 21:14:12', 'ACTIVE', 1, 1);
INSERT INTO `carts` VALUES (6, 5, '2026-01-01 23:38:32', '2026-01-01 23:38:32', 'ACTIVE', 1, 5);
INSERT INTO `carts` VALUES (8, 7, '2026-01-11 00:39:15', '2026-01-11 00:40:02', 'ORDERED', 0, NULL);
INSERT INTO `carts` VALUES (9, 7, '2026-01-11 21:26:39', '2026-01-12 20:05:37', 'ORDERED', 0, NULL);
INSERT INTO `carts` VALUES (10, 7, '2026-01-12 20:07:49', '2026-01-12 23:15:45', 'ORDERED', 0, NULL);
INSERT INTO `carts` VALUES (11, 7, '2026-01-12 23:16:48', '2026-01-12 23:16:51', 'ORDERED', 0, NULL);
INSERT INTO `carts` VALUES (12, 7, '2026-01-12 23:17:04', '2026-01-12 23:59:21', 'ORDERED', 0, NULL);
INSERT INTO `carts` VALUES (13, 7, '2026-01-12 23:59:45', '2026-01-16 11:11:38', 'ORDERED', 0, NULL);
INSERT INTO `carts` VALUES (14, 7, '2026-01-16 11:11:38', '2026-01-16 11:11:38', 'ACTIVE', 1, 7);
INSERT INTO `carts` VALUES (15, 8, '2026-06-15 17:22:41', '2026-06-15 17:22:41', 'ACTIVE', 1, 8);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_featured` tinyint(1) NULL DEFAULT 0,
  `active` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `slug` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  `display_order` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Giày chạy bộ', '/images/categories/running.jpg', '/category/running', 1, 1, '2025-12-11 23:45:33', '2025-12-11 23:45:33', NULL, NULL, 0);
INSERT INTO `categories` VALUES (2, 'Giày bóng đá', '/images/categories/football.jpg', '/category/football', 1, 1, '2025-12-11 23:45:33', '2025-12-11 23:45:33', NULL, NULL, 0);
INSERT INTO `categories` VALUES (3, 'Giày bóng rổ', '/images/categories/basket.jpg', '/category/basket', 1, 1, '2025-12-11 23:45:33', '2025-12-11 23:45:33', NULL, NULL, 0);
INSERT INTO `categories` VALUES (4, 'Sneaker lifestyle', '/images/categories/lifestyle.jpg', '/category/lifestyle', 1, 1, '2025-12-11 23:45:33', '2025-12-11 23:45:33', NULL, NULL, 0);
INSERT INTO `categories` VALUES (5, 'Dép & Sandal', '/images/categories/sandal.jpg', '/category/sandal', 0, 1, '2025-12-11 23:45:33', '2026-01-15 09:43:24', 'dep-sandal', NULL, 0);
INSERT INTO `categories` VALUES (6, 'Giày tennis', '/images/categories/tennis.jpg', '/category/tennis', 0, 1, '2025-12-11 23:45:33', '2025-12-11 23:45:33', NULL, NULL, 0);
INSERT INTO `categories` VALUES (7, 'Giày training / gym', '/images/categories/training.jpg', '/category/training', 0, 1, '2025-12-11 23:45:33', '2025-12-11 23:45:33', NULL, NULL, 0);
INSERT INTO `categories` VALUES (8, 'Phụ kiện chăm sóc giày', '/images/categories/access.jpg', '/category/access', 0, 1, '2025-12-11 23:45:33', '2025-12-11 23:45:33', NULL, NULL, 0);

-- ----------------------------
-- Table structure for contact_messages
-- ----------------------------
DROP TABLE IF EXISTS `contact_messages`;
CREATE TABLE `contact_messages`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'NEW',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_contact_messages_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_contact_messages_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contact_messages
-- ----------------------------
INSERT INTO `contact_messages` VALUES (1, 3, 'Nguyễn Văn A', 'user1@example.com', '0909000001', 'Shop cho em hỏi size giày chạy Nike Pegasus 40.', 'NEW', '2025-12-11 23:45:59');
INSERT INTO `contact_messages` VALUES (2, NULL, 'Khách lạ', 'guest@example.com', '0909555666', 'Shop có ship về Bình Dương không ạ?', 'NEW', '2025-12-11 23:45:59');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `slug` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `summary` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `thumbnail_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `author` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `view_count` int NOT NULL DEFAULT 0,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PUBLISHED',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_news_slug`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, 'Cách chọn size giày (Nike/Adidas) chuẩn, tránh rộng – chật khi mua online', 'cach-chon-size-giay-nikeadidas-chuan-tranh-rong-chat-khi-mua-online', NULL, '<p>Mua giày online dễ “lệch size” vì mỗi hãng có form khác nhau. Dưới đây là cách đo nhanh và mẹo chọn size an toàn.</p>\r\n\r\n<h2>Bước 1: Đo chiều dài bàn chân</h2>\r\n<ul>\r\n  <li>Đặt chân lên tờ giấy, kẻ vạch gót và mũi dài nhất.</li>\r\n  <li>Đo khoảng cách (mm) và <b>cộng thêm 5–10mm</b> để có “khoảng thở”.</li>\r\n</ul>\r\n\r\n<h2>Bước 2: Hiểu form theo hãng</h2>\r\n<ul>\r\n  <li><b>Nike (nhiều mẫu form ôm):</b> chân bè nên cân nhắc +0.5 size.</li>\r\n  <li><b>Adidas (nhiều mẫu form thoải mái):</b> thường true-to-size, nhưng dòng knit dễ giãn.</li>\r\n</ul>\r\n\r\n<h2>Bước 3: Chọn theo nhu cầu</h2>\r\n<ul>\r\n  <li><b>Đi học/đi làm:</b> ưu tiên thoải mái, dư nhẹ 0.5cm.</li>\r\n  <li><b>Chạy bộ:</b> dư 0.5–1cm (chân trượt về trước khi chạy).</li>\r\n  <li><b>Bóng rổ/đổi hướng:</b> ôm gót chắc để giảm lật cổ chân.</li>\r\n</ul>\r\n\r\n<p><b>Mẹo:</b> Nếu bạn đang mang 1 đôi vừa chân, hãy đo <i>chiều dài insole</i> (lót giày) rồi đối chiếu.</p>', 'https://bizweb.dktcdn.net/thumb/large/100/347/092/articles/1043a024-100-sr-rt-glb.jpg?v=1756175361867', NULL, 9, 'PUBLISHED', 0, '2026-01-15 15:52:43', '2026-01-16 08:21:59');
INSERT INTO `news` VALUES (2, 'Top 5 đôi giày chạy bộ tốt nhất năm 2026', 'top-5-doi-giay-chay-bo-tot-nhat-nam-2026', 'Khám phá danh sách những đôi giày chạy bộ được đánh giá cao nhất về độ êm ái, hỗ trợ phản lực và độ bền trong năm nay.', '<p>Đối với những người yêu thích chạy bộ, việc sở hữu một đôi giày phù hợp là cực kỳ quan trọng. Năm 2026 chứng kiến sự bùng nổ của các công nghệ đế bọt mới giúp tối ưu hóa hiệu suất chạy...</p>', 'https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?w=800', 'Admin', 0, 'PUBLISHED', 1, '2026-06-15 16:27:30', '2026-06-15 16:27:30');
INSERT INTO `news` VALUES (3, 'Cách phân biệt giày thật và giày giả chính xác 100%', 'cach-phan-biet-giay-that-va-giay-gia-chinh-xac-100', 'Mẹo kiểm tra đường may, hộp giày, tem mác và lót giày giúp bạn không bao giờ mua phải hàng kém chất lượng.', '<p>Hiện nay công nghệ làm giả giày ngày càng tinh vi. Tuy nhiên, nếu chú ý kỹ vào các chi tiết như đường chỉ khâu, font chữ trên tem và mùi keo đặc trưng, bạn hoàn toàn có thể tự mình nhận biết...</p>', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800', 'Biên tập viên', 0, 'PUBLISHED', 0, '2026-06-15 16:27:30', '2026-06-15 16:27:30');
INSERT INTO `news` VALUES (4, 'Bí quyết chọn size giày đá bóng vừa vặn không bị kích chân', 'bi-quyet-chon-size-giay-da-bong-vua-van-khong-bi-kich-chan', 'Giày đá bóng cần độ ôm sát nhưng nếu chọn sai size sẽ gây chấn thương. Dưới đây là hướng dẫn đo chân chuẩn nhất.', '<p>Không giống như giày đi chơi thông thường, giày đá bóng đòi hỏi sự chính xác tuyệt đối về kích thước để đảm bảo cảm giác bóng và tránh các chấn thương lật cổ chân, thâm móng...</p>', 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=800', 'Huấn luyện viên', 0, 'PUBLISHED', 1, '2026-06-15 16:27:30', '2026-06-15 16:27:30');
INSERT INTO `news` VALUES (5, 'Xu hướng thời trang Sneaker khuấy đảo giới trẻ hè này', 'xu-huong-thoi-trang-sneaker-khuay-dao-gioi-tre-he-nay', 'Những mẫu thiết kế retro cổ điển phối màu độc lạ đang trở lại và chiếm lĩnh các bảng xếp hạng thời trang đường phố.', '<p>Phong cách hoài cổ phối cùng các gam màu pastel nhẹ nhàng đang là xu hướng chủ đạo của mùa hè năm nay. Các thương hiệu lớn liên tục tái bản các dòng sản phẩm huyền thoại...</p>', 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800', 'JapanSport Team', 0, 'PUBLISHED', 0, '2026-06-15 16:27:30', '2026-06-15 16:27:30');
INSERT INTO `news` VALUES (6, 'Lợi ích của việc chạy bộ mỗi buổi sáng đối với sức khỏe', 'loi-ich-cua-viec-chay-bo-moi-buoi-sang-doi-voi-suc-khoe', 'Chỉ với 20 phút chạy bộ mỗi ngày, bạn sẽ thấy cơ thể có những thay đổi rõ rệt về cả thể chất lẫn tinh thần.', '<p>Chạy bộ buổi sáng không chỉ giúp đốt cháy calo, cải thiện hệ tim mạch mà còn kích thích sản sinh nội tiết tố hạnh phúc, giúp bạn bắt đầu một ngày mới tràn đầy năng lượng...</p>', 'https://images.unsplash.com/photo-1502224562085-639556652f33?w=800', 'Bác sĩ thể thao', 0, 'PUBLISHED', 0, '2026-06-15 16:27:30', '2026-06-15 16:27:30');

-- ----------------------------
-- Table structure for news_categories
-- ----------------------------
DROP TABLE IF EXISTS `news_categories`;
CREATE TABLE `news_categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `slug` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_news_categories_slug`(`slug` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news_categories
-- ----------------------------

-- ----------------------------
-- Table structure for news_category_map
-- ----------------------------
DROP TABLE IF EXISTS `news_category_map`;
CREATE TABLE `news_category_map`  (
  `news_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`news_id`, `category_id`) USING BTREE,
  INDEX `fk_ncm_cat`(`category_id` ASC) USING BTREE,
  CONSTRAINT `fk_ncm_cat` FOREIGN KEY (`category_id`) REFERENCES `news_categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ncm_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news_category_map
-- ----------------------------

-- ----------------------------
-- Table structure for news_comments
-- ----------------------------
DROP TABLE IF EXISTS `news_comments`;
CREATE TABLE `news_comments`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `news_id` int NOT NULL,
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `news_id`(`news_id` ASC) USING BTREE,
  CONSTRAINT `news_comments_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news_comments
-- ----------------------------

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'ID người dùng nhận thông báo',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_read` tinyint(1) NULL DEFAULT 0 COMMENT '0: chưa đọc, 1: đã đọc',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Đường dẫn khi click vào thông báo',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notifications
-- ----------------------------

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `variant_id` int NULL DEFAULT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `size` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` double NOT NULL,
  `subtotal` double NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_order_items_order`(`order_id` ASC) USING BTREE,
  INDEX `fk_order_items_product`(`product_id` ASC) USING BTREE,
  INDEX `fk_order_items_variant`(`variant_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_items_variant` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (1, 1, 1, NULL, NULL, NULL, 1, 2990000, 2990000);
INSERT INTO `order_items` VALUES (2, 1, 2, NULL, NULL, NULL, 2, 3590000, 7180000);
INSERT INTO `order_items` VALUES (3, 2, 7, NULL, NULL, NULL, 2, 1590000, 3180000);
INSERT INTO `order_items` VALUES (4, 3, 1, 1, 'Black', '40', 2, 2990000, 5980000);
INSERT INTO `order_items` VALUES (5, 4, 1, 1, 'Black', '40', 1, 2990000, 2990000);
INSERT INTO `order_items` VALUES (6, 5, 1, 1, 'Black', '40', 7, 2990000, 20930000);
INSERT INTO `order_items` VALUES (7, 6, 1, 2, 'Black', '41', 1, 2990000, 2990000);
INSERT INTO `order_items` VALUES (8, 7, 1, 2, 'Black', '41', 1, 2990000, 2990000);
INSERT INTO `order_items` VALUES (9, 8, 4, 238, 'Black', '40', 1, 4290000, 4290000);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `address_id` int NOT NULL,
  `total_amount` double NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PENDING',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_orders_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_orders_address`(`address_id` ASC) USING BTREE,
  CONSTRAINT `fk_orders_address` FOREIGN KEY (`address_id`) REFERENCES `user_addresses` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 3, 1, 10170000, 'PENDING', '2025-12-11 23:45:59', '2025-12-11 23:45:59');
INSERT INTO `orders` VALUES (2, 4, 2, 3190000, 'PAID', '2025-12-11 23:45:59', '2025-12-11 23:45:59');
INSERT INTO `orders` VALUES (3, 7, 3, 5980000, 'SHIPPING', '2026-01-11 00:40:02', '2026-01-13 23:54:48');
INSERT INTO `orders` VALUES (4, 7, 5, 2990000, 'PENDING', '2026-01-12 20:05:37', '2026-01-12 20:05:37');
INSERT INTO `orders` VALUES (5, 7, 6, 20930000, 'CANCEL', '2026-01-12 23:15:45', '2026-01-13 10:56:25');
INSERT INTO `orders` VALUES (6, 7, 7, 2990000, 'CANCEL', '2026-01-12 23:16:51', '2026-01-13 10:56:21');
INSERT INTO `orders` VALUES (7, 7, 8, 2990000, 'PAID', '2026-01-12 23:59:21', '2026-01-15 19:35:59');
INSERT INTO `orders` VALUES (8, 7, 9, 4290000, 'PENDING', '2026-01-16 11:11:38', '2026-01-16 11:11:38');

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token_hash` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime NULL DEFAULT NULL,
  `request_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_token_hash`(`token_hash`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------
INSERT INTO `password_reset_tokens` VALUES (1, 7, '313cd1949f9751b488cc5689225970bf483b533edb39eb31043e2a60bf89c48d', '2026-01-03 00:43:27', NULL, '0:0:0:0:0:0:0:1', '2026-01-03 00:23:27');
INSERT INTO `password_reset_tokens` VALUES (2, 7, 'd42e951d1a6f2437e02c7eeca6c4920cb91ceed601b7e19e199de61bf72a981f', '2026-01-03 00:43:59', NULL, '0:0:0:0:0:0:0:1', '2026-01-03 00:23:59');
INSERT INTO `password_reset_tokens` VALUES (3, 7, '5f448eb563ee9382fe7b3aed8191e66d365f596c0190ac973486e118f7ce6099', '2026-01-04 01:14:21', NULL, '0:0:0:0:0:0:0:1', '2026-01-04 00:54:20');
INSERT INTO `password_reset_tokens` VALUES (4, 7, '6c870da3d71723c2948fc80bf216df5ca905424671ded76e4a498e28cefcd295', '2026-01-04 01:15:33', NULL, '0:0:0:0:0:0:0:1', '2026-01-04 00:55:32');
INSERT INTO `password_reset_tokens` VALUES (5, 7, '645e2ac767f9907506425b45bbd09360f5f3be5701d74e47e7bd2e0bd8039170', '2026-01-04 15:20:10', NULL, '0:0:0:0:0:0:0:1', '2026-01-04 14:50:09');
INSERT INTO `password_reset_tokens` VALUES (6, 7, '39643268f035f5b742f25b3aeaf4d284ad082dabe21d79f084912a9d192fb7c3', '2026-01-04 16:31:34', NULL, '0:0:0:0:0:0:0:1', '2026-01-04 16:01:34');
INSERT INTO `password_reset_tokens` VALUES (7, 7, 'da175edb653af5ca9652a1a727a7ea8004de6fdb4b28fd5a7b5caed1b9e4c963', '2026-01-10 15:26:40', NULL, '0:0:0:0:0:0:0:1', '2026-01-10 14:56:40');
INSERT INTO `password_reset_tokens` VALUES (8, 7, '6274003fd2ad6a87f6a40be015e79c29eb552d6d09dd9e4424600134da40cfb6', '2026-01-10 15:55:51', NULL, '0:0:0:0:0:0:0:1', '2026-01-10 15:25:50');
INSERT INTO `password_reset_tokens` VALUES (9, 7, '1125b8fd11a7167b0dc6fbdbbaee44de92c21acb268ed90a85af494b966968c3', '2026-01-10 16:06:54', NULL, '0:0:0:0:0:0:0:1', '2026-01-10 15:36:53');
INSERT INTO `password_reset_tokens` VALUES (10, 7, '317ba6120f12a35fb98d292bc52bd071a69867754ecd6187a5d3f7a99848794c', '2026-01-10 16:11:32', NULL, '0:0:0:0:0:0:0:1', '2026-01-10 15:41:32');
INSERT INTO `password_reset_tokens` VALUES (11, 7, 'd2387eebe95a2b082d134ef02db38a28d3a9625b39c872a820760960ae4747d3', '2026-01-10 16:41:58', NULL, '0:0:0:0:0:0:0:1', '2026-01-10 16:11:57');
INSERT INTO `password_reset_tokens` VALUES (12, 7, '644ce88743491c2d0900dcc7c2be4f4d66c744d940ca722a1372b5375c34d4f7', '2026-01-16 07:50:12', NULL, '0:0:0:0:0:0:0:1', '2026-01-16 07:20:11');
INSERT INTO `password_reset_tokens` VALUES (13, 7, '7cb8a87068192a8020992dc484f35bb20c0764846f43190ae5c2659f8f3ebf96', '2026-01-16 08:47:52', NULL, '0:0:0:0:0:0:0:1', '2026-01-16 08:17:52');
INSERT INTO `password_reset_tokens` VALUES (14, 7, '8b80fef3397feffa42d43133578ba3626dd83425071d50cb67e6796f6a8667c8', '2026-01-16 08:48:29', '2026-01-16 08:18:59', '0:0:0:0:0:0:0:1', '2026-01-16 08:18:28');

-- ----------------------------
-- Table structure for policies
-- ----------------------------
DROP TABLE IF EXISTS `policies`;
CREATE TABLE `policies`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `slug` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `policy_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'GENERAL',
  `display_order` int NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_policies_slug`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of policies
-- ----------------------------

-- ----------------------------
-- Table structure for product_images
-- ----------------------------
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_main` tinyint(1) NULL DEFAULT 0,
  `sort_order` int NULL DEFAULT 0,
  `active` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_product_images_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_product_images_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 891 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_images
-- ----------------------------
INSERT INTO `product_images` VALUES (1, 1, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-womens-road-cw7358-002-01-2c8c3f6e-99ff-4997-8c71-3732c331e62d-ee1f7fdf-e631-416d-a15b-2e573bce5876.jpg?v=1712173686633', 'Nike Air Zoom Pegasus 40 - main', 1, 0, 1, '2025-12-11 23:45:49', 'Black');
INSERT INTO `product_images` VALUES (2, 1, 'https://bizweb.dktcdn.net/100/347/092/products/nike-0-air-zoom-pegasus-38-cw7356-002-02-d5408a9e-3404-47e5-8cea-7f15e5620299.png?v=1712173686633', 'Nike Air Zoom Pegasus 40 - side', 0, 1, 1, '2025-12-11 23:45:49', 'Black');
INSERT INTO `product_images` VALUES (3, 2, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'Adidas Ultraboost Light - main', 1, 0, 1, '2025-12-11 23:45:49', 'Black');
INSERT INTO `product_images` VALUES (4, 2, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-05-eb36cd2e-804a-4b42-9efb-93137a65315a.jpg?v=1712215775217', 'Adidas Ultraboost Light - side', 0, 1, 1, '2025-12-11 23:45:49', 'Black');
INSERT INTO `product_images` VALUES (5, 3, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'Nike Mercurial Vapor 15 Elite - main', 1, 0, 1, '2025-12-11 23:45:49', 'White');
INSERT INTO `product_images` VALUES (6, 4, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'Adidas Predator Accuracy. - main', 1, 0, 1, '2025-12-11 23:45:49', 'Black');
INSERT INTO `product_images` VALUES (7, 5, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', NULL, 1, 0, 1, '2025-12-11 23:45:49', 'Green');
INSERT INTO `product_images` VALUES (8, 6, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'Puma All Pro Nitro - main', 1, 0, 1, '2025-12-11 23:45:49', 'Black');
INSERT INTO `product_images` VALUES (9, 7, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'Converse Chuck Taylor All Star - main', 1, 1, 1, '2025-12-11 23:45:49', 'Green');
INSERT INTO `product_images` VALUES (10, 8, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-superstar-fv3290-01.jpg', 'Vans Old Skool Classic - main', 1, 0, 1, '2025-12-11 23:45:49', 'Black');
INSERT INTO `product_images` VALUES (11, 9, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-ultraboost-20-eg0713-01.jpg', 'Asics Gel-Nimbus 26 - main', 1, 0, 1, '2025-12-11 23:45:49', 'White');
INSERT INTO `product_images` VALUES (12, 10, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'Mizuno Wave Rider 27 - main', 1, 0, 1, '2025-12-11 23:45:49', 'White');
INSERT INTO `product_images` VALUES (13, 1, 'https://bizweb.dktcdn.net/100/347/092/products/nike-0-air-zoom-pegasus-38-cw7356-002-03-d1812fdf-1a78-474f-a96a-5b57402e8438.png?v=1712173686633', NULL, 1, 1, 1, '2025-12-25 13:33:10', 'Black');
INSERT INTO `product_images` VALUES (14, 1, 'https://bizweb.dktcdn.net/100/347/092/products/nike-0-air-zoom-pegasus-38-cw7356-002-04-7952d5a4-9b1b-4151-b5d5-3cdf33d7f008.png?v=1712173686633', NULL, 0, 2, 1, '2025-12-25 13:33:10', 'Black');
INSERT INTO `product_images` VALUES (15, 1, 'https://bizweb.dktcdn.net/100/347/092/products/nike-0-air-zoom-pegasus-38-cw7356-002-05-7b3f4ce2-e4fe-4536-b8c1-677756d04596.png?v=1712173686633', NULL, 0, 3, 1, '2025-12-25 13:33:10', 'Black');
INSERT INTO `product_images` VALUES (16, 1, '/images/products/p1_blue_1.jpg', NULL, 1, 1, 1, '2025-12-25 13:33:10', 'Blue');
INSERT INTO `product_images` VALUES (17, 1, '/images/products/p1_blue_2.jpg', NULL, 0, 2, 1, '2025-12-25 13:33:10', 'Blue');
INSERT INTO `product_images` VALUES (18, 1, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/663c3749-e7a7-4a6d-8111-32398a36b1cf.jpg', 'Nike Air Zoom Pegasus 40 - main', 1, 1, 1, '2025-12-29 22:58:11', 'White');
INSERT INTO `product_images` VALUES (19, 1, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-02.jpg?v=1679400171817', 'Nike Air Zoom Pegasus 40 - main', 1, 1, 1, '2025-12-29 22:58:11', 'White');
INSERT INTO `product_images` VALUES (20, 1, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-03.jpg?v=1679400173177', 'Nike Air Zoom Pegasus 40 - main', 1, 1, 1, '2025-12-29 22:58:11', 'White');
INSERT INTO `product_images` VALUES (21, 1, 'https://bizweb.dktcdn.net/100/347/092/products/95124a7c-371b-4c90-b0f3-e015c87f9f7a.jpg?v=1679400174423', 'Nike Air Zoom Pegasus 40 - main', 1, 1, 1, '2025-12-29 22:58:11', 'White');
INSERT INTO `product_images` VALUES (22, 1, 'https://bizweb.dktcdn.net/100/347/092/products/83b45721-c27f-4e1b-ba1f-9756977196af.jpg?v=1679400175697', 'Nike Air Zoom Pegasus 40 - main', 1, 1, 1, '2025-12-29 22:58:11', 'White');
INSERT INTO `product_images` VALUES (23, 1, 'https://bizweb.dktcdn.net/100/347/092/products/ee5a12bd-ad4a-45db-bff5-5adc4d2d0dc7.jpg?v=1679400181080', 'Nike Air Zoom Pegasus 40 - main', 1, 1, 1, '2025-12-29 22:58:11', 'White');
INSERT INTO `product_images` VALUES (24, 1, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-womens-road-cw7358-002-07.jpg?v=1643141108047', 'Nike Air Zoom Pegasus 40 - main', 1, 1, 1, '2025-12-29 22:58:11', 'White');
INSERT INTO `product_images` VALUES (553, 10, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401.jpg?v=1731244819500', NULL, 0, 0, 1, '2026-01-16 04:06:01', 'White');
INSERT INTO `product_images` VALUES (554, 10, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-2.jpg?v=1731244818317', NULL, 0, 0, 1, '2026-01-16 04:06:09', 'White');
INSERT INTO `product_images` VALUES (555, 10, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-1.jpg?v=1731244778880', NULL, 0, 0, 1, '2026-01-16 04:12:09', 'White');
INSERT INTO `product_images` VALUES (557, 10, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/ultraboost-light-shoes-black-id2932-hm1.jpg', NULL, 0, 0, 1, '2026-01-16 04:12:37', 'Black');
INSERT INTO `product_images` VALUES (558, 10, 'https://bizweb.dktcdn.net/100/347/092/products/ultraboost-light-shoes-black-id2932-hm3-hover.jpg?v=1704539346687', NULL, 0, 0, 1, '2026-01-16 04:12:43', 'Black');
INSERT INTO `product_images` VALUES (559, 10, 'https://bizweb.dktcdn.net/100/347/092/products/ultraboost-light-shoes-black-id2932-hm5.jpg?v=1704539348100', NULL, 0, 0, 1, '2026-01-16 04:12:47', 'Black');
INSERT INTO `product_images` VALUES (560, 10, 'https://bizweb.dktcdn.net/100/347/092/products/ultraboost-light-shoes-black-id2932-hm6.jpg?v=1704539348757', NULL, 0, 0, 1, '2026-01-16 04:12:55', 'Black');
INSERT INTO `product_images` VALUES (561, 10, 'https://bizweb.dktcdn.net/100/347/092/products/ultraboost-light-shoes-black-id2932-hm8.jpg?v=1704539349717', NULL, 0, 0, 1, '2026-01-16 04:13:05', 'Black');
INSERT INTO `product_images` VALUES (562, 2, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-04-884ee4b9-78f1-44c5-b0ff-d7df728f6000.jpg?v=1712215775217', NULL, 0, 0, 1, '2026-01-16 04:14:13', 'Black');
INSERT INTO `product_images` VALUES (563, 2, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-03-70b40d8a-8bd0-469b-84e3-6a4ba0a5d6f9.jpg?v=1712215775217', NULL, 0, 0, 1, '2026-01-16 04:14:20', 'Black');
INSERT INTO `product_images` VALUES (564, 2, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-05-eb36cd2e-804a-4b42-9efb-93137a65315a.jpg?v=1712215775217', NULL, 0, 0, 1, '2026-01-16 04:14:34', 'Black');
INSERT INTO `product_images` VALUES (565, 2, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-sl20.jpg?v=1649244897697', NULL, 0, 0, 1, '2026-01-16 04:14:46', 'Blue');
INSERT INTO `product_images` VALUES (566, 2, 'https://bizweb.dktcdn.net/100/347/092/products/sl20-2-shoes-blue-fz2492-02-standard-hover.jpg?v=1649244898153', NULL, 0, 0, 1, '2026-01-16 04:14:53', 'Blue');
INSERT INTO `product_images` VALUES (567, 2, 'https://bizweb.dktcdn.net/100/347/092/products/sl20-2-shoes-blue-fz2492-03-standard.jpg?v=1649244898617', NULL, 0, 0, 1, '2026-01-16 04:14:58', 'Blue');
INSERT INTO `product_images` VALUES (568, 2, 'https://bizweb.dktcdn.net/100/347/092/products/sl20-2-shoes-blue-fz2492-04-standard.jpg?v=1649244898920', NULL, 0, 0, 1, '2026-01-16 04:15:04', 'Blue');
INSERT INTO `product_images` VALUES (569, 2, 'https://bizweb.dktcdn.net/100/347/092/products/sl20-2-shoes-blue-fz2492-06-standard.jpg?v=1649244899677', NULL, 0, 0, 1, '2026-01-16 04:15:13', 'Blue');
INSERT INTO `product_images` VALUES (570, 3, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-02.jpg?v=1681810446247', NULL, 0, 0, 1, '2026-01-16 04:17:34', 'White');
INSERT INTO `product_images` VALUES (571, 3, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-03.jpg?v=1681810446873', NULL, 0, 0, 1, '2026-01-16 04:17:41', 'White');
INSERT INTO `product_images` VALUES (572, 3, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-04.jpg?v=1681810447663', NULL, 0, 0, 1, '2026-01-16 04:17:46', 'White');
INSERT INTO `product_images` VALUES (573, 3, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-05.jpg?v=1681810448473', NULL, 0, 0, 1, '2026-01-16 04:18:00', 'White');
INSERT INTO `product_images` VALUES (574, 3, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-01.jpg', NULL, 0, 0, 1, '2026-01-16 04:18:16', 'Black');
INSERT INTO `product_images` VALUES (575, 3, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-02.jpg?v=1679254204573', NULL, 0, 0, 1, '2026-01-16 04:18:22', 'Black');
INSERT INTO `product_images` VALUES (576, 3, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-03.jpg?v=1679254204573', NULL, 0, 0, 1, '2026-01-16 04:18:28', 'Black');
INSERT INTO `product_images` VALUES (577, 3, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-04.jpg?v=1679254204573', NULL, 0, 0, 1, '2026-01-16 04:18:33', 'Black');
INSERT INTO `product_images` VALUES (578, 3, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-05.jpg?v=1679254204573', NULL, 0, 0, 1, '2026-01-16 04:18:40', 'Black');
INSERT INTO `product_images` VALUES (579, 9, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-eg0713-03.jpg?v=1611978277637', NULL, 0, 0, 1, '2026-01-16 04:21:26', 'White');
INSERT INTO `product_images` VALUES (580, 9, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-eg0713-05.jpg?v=1611978278390', NULL, 0, 0, 1, '2026-01-16 04:21:33', 'White');
INSERT INTO `product_images` VALUES (581, 9, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-eg0713-06.jpg?v=1611978278663', NULL, 0, 0, 1, '2026-01-16 04:21:38', 'White');
INSERT INTO `product_images` VALUES (582, 9, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-eg0713-07.jpg?v=1611978278937', NULL, 0, 0, 1, '2026-01-16 04:21:44', 'White');
INSERT INTO `product_images` VALUES (583, 9, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/8bf013bf-6b92-4d4b-844c-cb2495024bfa.jpg', NULL, 0, 0, 1, '2026-01-16 04:21:57', 'Beige');
INSERT INTO `product_images` VALUES (584, 9, 'https://bizweb.dktcdn.net/100/347/092/products/8ddf7247-21e0-4263-9836-671459e808fc.jpg?v=1768395629403', NULL, 0, 0, 1, '2026-01-16 04:22:02', 'Beige');
INSERT INTO `product_images` VALUES (585, 9, 'https://bizweb.dktcdn.net/100/347/092/products/aa25ab72-9808-4aa2-a6ae-c4dddd610572.jpg?v=1768395631890', NULL, 0, 0, 1, '2026-01-16 04:22:06', 'Beige');
INSERT INTO `product_images` VALUES (586, 9, 'https://bizweb.dktcdn.net/100/347/092/products/d52df393-e3bb-4529-86d1-b5ac3bc441e6.jpg?v=1768395633240', NULL, 0, 0, 1, '2026-01-16 04:22:11', 'Beige');
INSERT INTO `product_images` VALUES (587, 9, 'https://bizweb.dktcdn.net/100/347/092/products/3c3bea06-f5c0-4466-857b-07d5e723813c.jpg?v=1768395635320', NULL, 0, 0, 1, '2026-01-16 04:22:16', 'Beige');
INSERT INTO `product_images` VALUES (588, 8, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-03.jpg?v=1641020680080', NULL, 0, 0, 1, '2026-01-16 04:24:04', 'Black');
INSERT INTO `product_images` VALUES (589, 8, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-04.jpg?v=1641020680537', NULL, 0, 0, 1, '2026-01-16 04:24:10', 'Black');
INSERT INTO `product_images` VALUES (590, 8, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-05.jpg?v=1641020681120', NULL, 0, 0, 1, '2026-01-16 04:24:17', 'Black');
INSERT INTO `product_images` VALUES (591, 8, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-06.jpg?v=1641020681633', NULL, 0, 0, 1, '2026-01-16 04:24:24', 'Black');
INSERT INTO `product_images` VALUES (592, 8, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/zz-ef0213-01.jpg', NULL, 0, 0, 1, '2026-01-16 04:24:42', 'White');
INSERT INTO `product_images` VALUES (593, 8, 'https://bizweb.dktcdn.net/100/347/092/products/zz-ef0213-02.jpg?v=1581248816070', NULL, 0, 0, 1, '2026-01-16 04:24:48', 'White');
INSERT INTO `product_images` VALUES (594, 8, 'https://bizweb.dktcdn.net/100/347/092/products/zz-ef0213-03.jpg?v=1581248816543', NULL, 0, 0, 1, '2026-01-16 04:24:54', 'White');
INSERT INTO `product_images` VALUES (595, 8, 'https://bizweb.dktcdn.net/100/347/092/products/zz-ef0213-04.jpg?v=1581248816907', NULL, 0, 0, 1, '2026-01-16 04:25:01', 'White');
INSERT INTO `product_images` VALUES (596, 8, 'https://bizweb.dktcdn.net/100/347/092/products/zz-ef0213-05.jpg?v=1581248817227', NULL, 0, 0, 1, '2026-01-16 04:25:09', 'White');
INSERT INTO `product_images` VALUES (597, 7, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-02.jpg?v=1715502720517', NULL, 0, 0, 1, '2026-01-16 04:27:33', 'Green');
INSERT INTO `product_images` VALUES (598, 7, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-03.jpg?v=1715502721263', NULL, 0, 0, 1, '2026-01-16 04:27:38', 'Green');
INSERT INTO `product_images` VALUES (599, 7, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-04.jpg?v=1715502722113', NULL, 0, 0, 1, '2026-01-16 04:27:44', 'Green');
INSERT INTO `product_images` VALUES (600, 7, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-05.jpg?v=1715502723040', NULL, 0, 0, 1, '2026-01-16 04:27:50', 'Green');
INSERT INTO `product_images` VALUES (601, 7, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-06.jpg?v=1715502723833', NULL, 0, 0, 1, '2026-01-16 04:27:56', 'Green');
INSERT INTO `product_images` VALUES (602, 7, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', NULL, 0, 0, 1, '2026-01-16 04:28:05', 'Red');
INSERT INTO `product_images` VALUES (603, 7, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-02.jpg?v=1715501860317', NULL, 0, 0, 1, '2026-01-16 04:28:10', 'Red');
INSERT INTO `product_images` VALUES (604, 7, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-03.jpg?v=1715501861110', NULL, 0, 0, 1, '2026-01-16 04:28:15', 'Red');
INSERT INTO `product_images` VALUES (605, 7, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-04.jpg?v=1715501861907', NULL, 0, 0, 1, '2026-01-16 04:28:20', 'Red');
INSERT INTO `product_images` VALUES (606, 7, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-05.jpg?v=1715501862833', NULL, 0, 0, 1, '2026-01-16 04:28:26', 'Red');
INSERT INTO `product_images` VALUES (607, 6, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg?v=1738945330490', NULL, 0, 0, 1, '2026-01-16 04:30:25', 'Black');
INSERT INTO `product_images` VALUES (608, 6, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-3.jpg?v=1738945332317', NULL, 0, 0, 1, '2026-01-16 04:30:30', 'Black');
INSERT INTO `product_images` VALUES (609, 6, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-4.jpg?v=1738945334350', NULL, 0, 0, 1, '2026-01-16 04:30:35', 'Black');
INSERT INTO `product_images` VALUES (610, 6, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-5.jpg?v=1738945336210', NULL, 0, 0, 1, '2026-01-16 04:30:44', 'Black');
INSERT INTO `product_images` VALUES (611, 6, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/s-l1600-3-11zon-4efaccd1-ef65-41c9-ae71-c315a9ef6ad0.jpg', NULL, 0, 0, 1, '2026-01-16 04:31:09', 'Red');
INSERT INTO `product_images` VALUES (612, 6, 'https://bizweb.dktcdn.net/100/347/092/products/s-l1600-11zon-be7aa8e7-029e-4c09-9d5b-e29fcc89c3be.jpg?v=1766476850843', NULL, 0, 0, 1, '2026-01-16 04:31:13', 'Red');
INSERT INTO `product_images` VALUES (613, 6, 'https://bizweb.dktcdn.net/100/347/092/products/s-l1600-4-11zon-4cd0d970-ac29-4337-8559-43707a7d650b.jpg?v=1766476850843', NULL, 0, 0, 1, '2026-01-16 04:31:19', 'Red');
INSERT INTO `product_images` VALUES (614, 6, 'https://bizweb.dktcdn.net/100/347/092/products/s-l1600-1-11zon-c3223d68-9d9b-4e52-99a2-b978ab564f9e.jpg?v=1766476853923', NULL, 0, 0, 1, '2026-01-16 04:31:26', 'Red');
INSERT INTO `product_images` VALUES (615, 6, 'https://bizweb.dktcdn.net/100/347/092/products/s-l1600-2-11zon-128f0448-9bbc-4ad7-af84-16279804bfb9.jpg?v=1766476853923', NULL, 0, 0, 1, '2026-01-16 04:31:32', 'Red');
INSERT INTO `product_images` VALUES (616, 5, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-2.jpg?v=1768322978887', NULL, 0, 0, 1, '2026-01-16 04:33:32', 'Green');
INSERT INTO `product_images` VALUES (617, 5, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-3.jpg?v=1768322979953', NULL, 0, 0, 1, '2026-01-16 04:33:37', 'Green');
INSERT INTO `product_images` VALUES (618, 5, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-4.jpg?v=1768322980867', NULL, 0, 0, 1, '2026-01-16 04:33:42', 'Green');
INSERT INTO `product_images` VALUES (619, 5, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-5.jpg?v=1768322981807', NULL, 0, 0, 1, '2026-01-16 04:33:49', 'Green');
INSERT INTO `product_images` VALUES (620, 5, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/fb2598-101-01.jpg', NULL, 0, 0, 1, '2026-01-16 04:34:03', 'White');
INSERT INTO `product_images` VALUES (621, 5, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-02.jpg?v=1710061265467', NULL, 0, 0, 1, '2026-01-16 04:34:11', 'White');
INSERT INTO `product_images` VALUES (622, 5, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-03.jpg?v=1710061266370', NULL, 0, 0, 1, '2026-01-16 04:34:16', 'White');
INSERT INTO `product_images` VALUES (623, 5, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-04.jpg?v=1710061267553', NULL, 0, 0, 1, '2026-01-16 04:34:22', 'White');
INSERT INTO `product_images` VALUES (624, 5, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-05.jpg?v=1710061268690', NULL, 0, 0, 1, '2026-01-16 04:34:29', 'White');
INSERT INTO `product_images` VALUES (625, 4, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-06.jpg?v=1622030220267', NULL, 0, 0, 1, '2026-01-16 04:35:51', 'Black');
INSERT INTO `product_images` VALUES (626, 4, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-02.jpg?v=1622030220267', NULL, 0, 0, 1, '2026-01-16 04:35:56', 'Black');
INSERT INTO `product_images` VALUES (627, 4, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-03.jpg?v=1622030220267', NULL, 0, 0, 1, '2026-01-16 04:36:01', 'Black');
INSERT INTO `product_images` VALUES (628, 4, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-04.jpg?v=1622030220267', NULL, 0, 0, 1, '2026-01-16 04:36:08', 'Black');
INSERT INTO `product_images` VALUES (629, 4, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/9e9335f3c9def8b6c34da1fb735c13f4-472x497.jpg', NULL, 0, 0, 1, '2026-01-16 04:36:24', 'Navy');
INSERT INTO `product_images` VALUES (630, 4, 'https://bizweb.dktcdn.net/100/347/092/products/94a4ef10be5c7bb3a0db85c10fa9b7f7-472x497-1.jpg?v=1705130111020', NULL, 0, 0, 1, '2026-01-16 04:36:30', 'Navy');
INSERT INTO `product_images` VALUES (631, 4, 'https://bizweb.dktcdn.net/100/347/092/products/ef40c4c4664901acbba9cf9dd6bbe800-472x497.jpg?v=1705130007890', NULL, 0, 0, 1, '2026-01-16 04:36:35', 'Navy');
INSERT INTO `product_images` VALUES (632, 4, 'https://bizweb.dktcdn.net/100/347/092/products/a6f1722d435cf4875ca858980d8a69bf-472x497.jpg?v=1705130007890', NULL, 0, 0, 1, '2026-01-16 04:36:40', 'Navy');
INSERT INTO `product_images` VALUES (633, 4, 'https://bizweb.dktcdn.net/100/347/092/products/6a86001a20a7c13491c5d69efd31bf74-472x497.jpg?v=1705130007890', NULL, 0, 0, 1, '2026-01-16 04:36:48', 'Navy');
INSERT INTO `product_images` VALUES (634, 11, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'AF1 White - Mặt trước', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (635, 11, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-02.jpg', 'AF1 White - Mặt bên', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (636, 11, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-03.jpg', 'AF1 White - Gót giày', 0, 2, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (637, 11, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/fb2598-101-01.jpg', 'AF1 Black - Mặt trước', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (638, 11, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-02.jpg', 'AF1 Black - Mặt bên', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (639, 11, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-03.jpg', 'AF1 Black - Gót giày', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (640, 11, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/36f2d78a-70f8-4c79-9a07-3c8c0f6d913e.jpg', 'AF1 Grey - Mặt trước', 1, 0, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (641, 11, 'https://bizweb.dktcdn.net/100/347/092/products/766a31a1-e9a5-44b3-9981-48fe39f750bb.jpg', 'AF1 Grey - Mặt bên', 0, 1, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (642, 11, 'https://bizweb.dktcdn.net/100/347/092/products/7e33f5b842804ba48745d51160041600.jpg', 'AF1 Grey - Gót giày', 0, 2, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (643, 12, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-superstar-fv3290-01.jpg', 'Samba Black - Mặt trước', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (644, 12, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-04.jpg', 'Samba Black - Mặt bên', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (645, 12, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-05.jpg', 'Samba Black - Gót giày', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (646, 12, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-superstar-fv3290-02.jpg', 'Samba White - Mặt trước', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (647, 12, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-03.jpg', 'Samba White - Mặt bên', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (648, 12, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-06.jpg', 'Samba White - Đế giày', 0, 2, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (649, 13, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/x-plr-shoes-beige-by9255-01-standard-1.jpg', 'NB550 White Green - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Green');
INSERT INTO `product_images` VALUES (650, 13, 'https://bizweb.dktcdn.net/100/347/092/products/x-plr-shoes-beige-by9255-02-standard-hover-1.jpg', 'NB550 White Green - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Green');
INSERT INTO `product_images` VALUES (651, 13, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/x-plr-shoes-beige-by9255-03-standard-1.jpg', 'NB550 White Grey - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Grey');
INSERT INTO `product_images` VALUES (652, 13, 'https://bizweb.dktcdn.net/100/347/092/products/x-plr-shoes-beige-by9255-04-standard-1.jpg', 'NB550 White Grey - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Grey');
INSERT INTO `product_images` VALUES (653, 13, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-1.jpg', 'NB550 White Red - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Red');
INSERT INTO `product_images` VALUES (654, 13, 'https://bizweb.dktcdn.net/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-3.jpg', 'NB550 White Red - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Red');
INSERT INTO `product_images` VALUES (655, 14, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'Palermo White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (656, 14, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'Palermo White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (657, 14, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-3.jpg', 'Palermo White - Back', 0, 2, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (658, 14, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-4.jpg', 'Palermo Pink - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (659, 14, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-5.jpg', 'Palermo Pink - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (660, 14, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-3.jpg', 'Palermo Pink - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (661, 15, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'Chuck70 Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (662, 15, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-02.jpg', 'Chuck70 Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (663, 15, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-03.jpg', 'Chuck70 Black - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (664, 15, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'Chuck70 Red - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Red');
INSERT INTO `product_images` VALUES (665, 15, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-02.jpg', 'Chuck70 Red - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Red');
INSERT INTO `product_images` VALUES (666, 15, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-03.jpg', 'Chuck70 Red - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Red');
INSERT INTO `product_images` VALUES (667, 16, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'OldSkool BlackWhite - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black White');
INSERT INTO `product_images` VALUES (668, 16, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-04.jpg', 'OldSkool BlackWhite - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black White');
INSERT INTO `product_images` VALUES (669, 16, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-05.jpg', 'OldSkool Navy - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (670, 16, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-06.jpg', 'OldSkool Navy - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (671, 16, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'OldSkool Red - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Red');
INSERT INTO `product_images` VALUES (672, 16, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-04.jpg', 'OldSkool Red - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Red');
INSERT INTO `product_images` VALUES (673, 17, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-1.jpg', 'DunkLow BW - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black White');
INSERT INTO `product_images` VALUES (674, 17, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-2.jpg', 'DunkLow BW - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black White');
INSERT INTO `product_images` VALUES (675, 17, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-3.jpg', 'DunkLow BW - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black White');
INSERT INTO `product_images` VALUES (676, 17, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-4.jpg', 'DunkLow GreyFog - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Grey Fog');
INSERT INTO `product_images` VALUES (677, 17, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-5.jpg', 'DunkLow GreyFog - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Grey Fog');
INSERT INTO `product_images` VALUES (678, 17, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-6.jpg', 'DunkLow GreyFog - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Grey Fog');
INSERT INTO `product_images` VALUES (679, 17, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'DunkLow Green - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Green');
INSERT INTO `product_images` VALUES (680, 17, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-02.jpg', 'DunkLow Green - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Green');
INSERT INTO `product_images` VALUES (681, 17, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-03.jpg', 'DunkLow Green - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Green');
INSERT INTO `product_images` VALUES (682, 18, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-falcon-w-ef4988-01.jpg', 'Gazelle Green - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Green');
INSERT INTO `product_images` VALUES (683, 18, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-falcon-w-ef4988-03.jpg', 'Gazelle Green - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Green');
INSERT INTO `product_images` VALUES (684, 18, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-falcon-w-ef4988-05.jpg', 'Gazelle Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (685, 18, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-falcon-w-ef4988-06.jpg', 'Gazelle Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (686, 18, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-falcon-w-ef4988-07.jpg', 'Gazelle Pink - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (687, 18, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-falcon-w-ef4988-08.jpg', 'Gazelle Pink - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (688, 19, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-1.jpg', 'NB2002R Grey - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (689, 19, 'https://bizweb.dktcdn.net/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-3.jpg', 'NB2002R Grey - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (690, 19, 'https://bizweb.dktcdn.net/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-5.jpg', 'NB2002R Grey - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (691, 19, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'NB2002R Brown - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Brown');
INSERT INTO `product_images` VALUES (692, 19, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-2.jpg', 'NB2002R Brown - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Brown');
INSERT INTO `product_images` VALUES (693, 19, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-4.jpg', 'NB2002R Brown - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Brown');
INSERT INTO `product_images` VALUES (694, 20, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'RunStarHike Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (695, 20, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-03.jpg', 'RunStarHike Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (696, 20, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-05.jpg', 'RunStarHike Black - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (697, 20, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'RunStarHike White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (698, 20, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-02.jpg', 'RunStarHike White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (699, 20, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-04.jpg', 'RunStarHike White - Back', 0, 2, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (700, 21, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'SK8Hi Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (701, 21, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-02.jpg', 'SK8Hi Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (702, 21, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-04.jpg', 'SK8Hi Black - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (703, 21, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'SK8Hi Navy - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (704, 21, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-03.jpg', 'SK8Hi Navy - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (705, 21, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-05.jpg', 'SK8Hi Navy - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (706, 22, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'PumaSuede Navy - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (707, 22, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'PumaSuede Navy - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (708, 22, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-4.jpg', 'PumaSuede Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (709, 22, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-5.jpg', 'PumaSuede Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (710, 23, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-plus-pegasus-plus-trail-plus-5-plus-gs.jpg', 'Vaporfly Volt - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Volt');
INSERT INTO `product_images` VALUES (711, 23, 'https://bizweb.dktcdn.net/100/347/092/products/nike-plus-pegasus-plus-trail-plus-5-plus-gs-1-af8cd553-7a73-4272-a465-3ec1eb4f346f.jpg', 'Vaporfly Volt - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Volt');
INSERT INTO `product_images` VALUES (712, 23, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-01-33f41548-eee8-493c-b25a-0656a44d0665.jpg', 'Vaporfly Pink - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (713, 23, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-02-c539f141-482a-4177-8c3f-c9d6b366c1f3.jpg', 'Vaporfly Pink - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (714, 23, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'Vaporfly Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (715, 23, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'Vaporfly Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (716, 24, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'Boston12 Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (717, 24, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-03-70b40d8a-8bd0-469b-84e3-6a4ba0a5d6f9.jpg', 'Boston12 Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (718, 24, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-04-6b20dc7a-c0b7-4e44-b9de-eb89b25b83f8.jpg', 'Boston12 Black - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (719, 24, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/qt-racer-2-0-trang-fw7285-01.jpg', 'Boston12 White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (720, 24, 'https://bizweb.dktcdn.net/100/347/092/products/qt-racer-2-0-trang-fw7285-02.jpg', 'Boston12 White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (721, 24, 'https://bizweb.dktcdn.net/100/347/092/products/qt-racer-2-0-trang-fw7285-03.jpg', 'Boston12 White - Back', 0, 2, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (722, 25, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'Novablast Blue - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Blue');
INSERT INTO `product_images` VALUES (723, 25, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-2.jpg', 'Novablast Blue - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Blue');
INSERT INTO `product_images` VALUES (724, 25, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'Novablast White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (725, 25, 'https://bizweb.dktcdn.net/100/347/092/products/evoride-women-s-1012a677-020-02.jpg', 'Novablast White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (726, 25, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'Novablast Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (727, 25, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-1.jpg', 'Novablast Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (728, 26, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'SCElite WhiteRed - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Red');
INSERT INTO `product_images` VALUES (729, 26, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-2.jpg', 'SCElite WhiteRed - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Red');
INSERT INTO `product_images` VALUES (730, 26, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-3.jpg', 'SCElite NeonYellow - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Neon Yellow');
INSERT INTO `product_images` VALUES (731, 26, 'https://bizweb.dktcdn.net/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-2.jpg', 'SCElite NeonYellow - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Neon Yellow');
INSERT INTO `product_images` VALUES (732, 27, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-01-33f41548-eee8-493c-b25a-0656a44d0665.jpg', 'Pegasus41 Pink - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (733, 27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-02-c539f141-482a-4177-8c3f-c9d6b366c1f3.jpg', 'Pegasus41 Pink - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (734, 27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-03-2ddd5784-2c26-4fb5-8581-e42521cb9fe7.jpg', 'Pegasus41 Pink - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (735, 27, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-01.jpg', 'Pegasus41 Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (736, 27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-02.jpg', 'Pegasus41 Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (737, 27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-03.jpg', 'Pegasus41 Black - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (738, 27, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/663c3749-e7a7-4a6d-8111-32398a36b1cf.jpg', 'Pegasus41 White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (739, 27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-02.jpg', 'Pegasus41 White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (740, 28, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'WaveRebellion Yellow - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Yellow');
INSERT INTO `product_images` VALUES (741, 28, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-1.jpg', 'WaveRebellion Yellow - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Yellow');
INSERT INTO `product_images` VALUES (742, 28, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'WaveRebellion Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (743, 28, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-2.jpg', 'WaveRebellion Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (744, 29, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-ultraboost-20-eg0713-01.jpg', 'UBLight White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (745, 29, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-eg0713-03.jpg', 'UBLight White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (746, 29, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-eg0713-05.jpg', 'UBLight White - Back', 0, 2, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (747, 29, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-ultraboost-20-fv8351-03.jpg', 'UBLight Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (748, 29, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-fv8351-05.jpg', 'UBLight Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (749, 29, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-fv8351-07.jpg', 'UBLight Black - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (750, 29, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/sl20-2-shoes-blue-fz2492-02.jpg', 'UBLight Navy - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (751, 29, 'https://bizweb.dktcdn.net/100/347/092/products/sl20-2-shoes-blue-fz2492-04.jpg', 'UBLight Navy - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (752, 30, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'GelKayano Grey - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (753, 30, 'https://bizweb.dktcdn.net/100/347/092/products/evoride-women-s-1012a677-020-03.jpg', 'GelKayano Grey - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (754, 30, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-04.jpg', 'GelKayano Blue - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Blue');
INSERT INTO `product_images` VALUES (755, 30, 'https://bizweb.dktcdn.net/100/347/092/products/evoride-women-s-1012a677-020-06.jpg', 'GelKayano Blue - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Blue');
INSERT INTO `product_images` VALUES (756, 31, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'VelocityNitro Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (757, 31, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-03-1721029200115.jpg', 'VelocityNitro Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (758, 31, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-05-1721029204028.jpg', 'VelocityNitro Black - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (759, 31, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'VelocityNitro White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (760, 31, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'VelocityNitro White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (761, 32, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'HOVRMachina BlackRed - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black Red');
INSERT INTO `product_images` VALUES (762, 32, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-air-max-2017-849559-005-2.jpg', 'HOVRMachina BlackRed - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black Red');
INSERT INTO `product_images` VALUES (763, 32, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-adidas-supernova-rise-move-for-the-planet-ig8328-01-3.jpg', 'HOVRMachina GreyBlue - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Grey Blue');
INSERT INTO `product_images` VALUES (764, 32, 'https://bizweb.dktcdn.net/100/347/092/products/giay-adidas-supernova-rise-move-for-the-planet-ig8328-01-4.jpg', 'HOVRMachina GreyBlue - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Grey Blue');
INSERT INTO `product_images` VALUES (765, 33, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'Mercurial Volt - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Volt');
INSERT INTO `product_images` VALUES (766, 33, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-02.jpg', 'Mercurial Volt - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Volt');
INSERT INTO `product_images` VALUES (767, 33, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/fb2598-101-01.jpg', 'Mercurial Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (768, 33, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-02.jpg', 'Mercurial Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (769, 33, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/663c3749-e7a7-4a6d-8111-32398a36b1cf.jpg', 'Mercurial White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (770, 33, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-02.jpg', 'Mercurial White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (771, 34, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'Predator BlackRed - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black Red');
INSERT INTO `product_images` VALUES (772, 34, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-03.jpg', 'Predator BlackRed - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black Red');
INSERT INTO `product_images` VALUES (773, 34, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-05.jpg', 'Predator BlackRed - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black Red');
INSERT INTO `product_images` VALUES (774, 34, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/edge-xt-shoes-white-fw0670-01.jpg', 'Predator WhiteGold - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Gold');
INSERT INTO `product_images` VALUES (775, 34, 'https://bizweb.dktcdn.net/100/347/092/products/edge-xt-shoes-white-fw0670-03.jpg', 'Predator WhiteGold - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Gold');
INSERT INTO `product_images` VALUES (776, 34, 'https://bizweb.dktcdn.net/100/347/092/products/edge-xt-shoes-white-fw0670-05.jpg', 'Predator WhiteGold - Back', 0, 2, 1, '2026-06-15 16:28:15', 'White Gold');
INSERT INTO `product_images` VALUES (777, 35, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'Future7 Blue - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Blue');
INSERT INTO `product_images` VALUES (778, 35, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-03-1721029200115.jpg', 'Future7 Blue - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Blue');
INSERT INTO `product_images` VALUES (779, 35, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'Future7 White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (780, 35, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-3.jpg', 'Future7 White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (781, 36, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-01.jpg', 'PhantomGX Crimson - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Crimson');
INSERT INTO `product_images` VALUES (782, 36, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-02.jpg', 'PhantomGX Crimson - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Crimson');
INSERT INTO `product_images` VALUES (783, 36, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-03.jpg', 'PhantomGX Crimson - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Crimson');
INSERT INTO `product_images` VALUES (784, 36, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'PhantomGX Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (785, 36, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'PhantomGX Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (786, 37, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'Copa Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (787, 37, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-02.jpg', 'Copa Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (788, 37, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/edge-xt-shoes-white-fw0670-01.jpg', 'Copa White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (789, 37, 'https://bizweb.dktcdn.net/100/347/092/products/edge-xt-shoes-white-fw0670-02.jpg', 'Copa White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (790, 38, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'MizunoAlpha White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (791, 38, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-1.jpg', 'MizunoAlpha White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (792, 38, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401-2.jpg', 'MizunoAlpha Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (793, 38, 'https://bizweb.dktcdn.net/100/347/092/products/11271239-r1.jpg', 'MizunoAlpha Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (794, 39, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', 'KD16 Aura - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Aura');
INSERT INTO `product_images` VALUES (795, 39, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-2.jpg', 'KD16 Aura - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Aura');
INSERT INTO `product_images` VALUES (796, 39, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-3.jpg', 'KD16 Aura - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Aura');
INSERT INTO `product_images` VALUES (797, 39, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'KD16 Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (798, 39, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'KD16 Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (799, 39, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/663c3749-e7a7-4a6d-8111-32398a36b1cf.jpg', 'KD16 White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (800, 39, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-02.jpg', 'KD16 White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (801, 40, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-4d-fusio-h04509-01.jpg', 'Harden8 WhiteRed - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Red');
INSERT INTO `product_images` VALUES (802, 40, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-4d-fusio-h04509-02.jpg', 'Harden8 WhiteRed - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Red');
INSERT INTO `product_images` VALUES (803, 40, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-21-be-fy0391-01.jpg', 'Harden8 BlackSilver - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black Silver');
INSERT INTO `product_images` VALUES (804, 40, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-21-be-fy0391-02.jpg', 'Harden8 BlackSilver - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black Silver');
INSERT INTO `product_images` VALUES (805, 41, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'Curry11 WhiteBlue - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Blue');
INSERT INTO `product_images` VALUES (806, 41, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-air-max-2017-849559-005-2.jpg', 'Curry11 WhiteBlue - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Blue');
INSERT INTO `product_images` VALUES (807, 41, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-adidas-if8597-1.jpg', 'Curry11 BlackGold - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black Gold');
INSERT INTO `product_images` VALUES (808, 41, 'https://bizweb.dktcdn.net/100/347/092/products/giay-adidas-if8597-2.jpg', 'Curry11 BlackGold - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black Gold');
INSERT INTO `product_images` VALUES (809, 42, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', 'LeBron21 Tahitian - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Tahitian');
INSERT INTO `product_images` VALUES (810, 42, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-4.jpg', 'LeBron21 Tahitian - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Tahitian');
INSERT INTO `product_images` VALUES (811, 42, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-5.jpg', 'LeBron21 Tahitian - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Tahitian');
INSERT INTO `product_images` VALUES (812, 42, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'LeBron21 Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (813, 42, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'LeBron21 Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (814, 43, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'MB03 ToxicGreen - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Toxic Green');
INSERT INTO `product_images` VALUES (815, 43, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'MB03 ToxicGreen - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Toxic Green');
INSERT INTO `product_images` VALUES (816, 43, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-4.jpg', 'MB03 Purple - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Purple');
INSERT INTO `product_images` VALUES (817, 43, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-5.jpg', 'MB03 Purple - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Purple');
INSERT INTO `product_images` VALUES (818, 43, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'MB03 Blue - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Blue');
INSERT INTO `product_images` VALUES (819, 43, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-03-1721029200115.jpg', 'MB03 Blue - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Blue');
INSERT INTO `product_images` VALUES (820, 44, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'TWOWXY Navy - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (821, 44, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-2.jpg', 'TWOWXY Navy - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (822, 44, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-4.jpg', 'TWOWXY Navy - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (823, 44, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-3.jpg', 'TWOWXY Red - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Red');
INSERT INTO `product_images` VALUES (824, 44, 'https://bizweb.dktcdn.net/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-2.jpg', 'TWOWXY Red - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Red');
INSERT INTO `product_images` VALUES (825, 45, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'CalmSlide Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (826, 45, 'https://bizweb.dktcdn.net/100/347/092/products/110339010959-18-2-1080x715-1.jpg', 'CalmSlide Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (827, 45, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-gy9416-01.jpg', 'CalmSlide GeodeTeal - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Geode Teal');
INSERT INTO `product_images` VALUES (828, 45, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-02.jpg', 'CalmSlide GeodeTeal - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Geode Teal');
INSERT INTO `product_images` VALUES (829, 45, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'CalmSlide White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (830, 45, 'https://bizweb.dktcdn.net/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'CalmSlide White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (831, 46, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'Adilette22 MagicLime - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Magic Lime');
INSERT INTO `product_images` VALUES (832, 46, 'https://bizweb.dktcdn.net/100/347/092/products/dep-adilette-22-be-if3673-02-standard.jpg', 'Adilette22 MagicLime - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Magic Lime');
INSERT INTO `product_images` VALUES (833, 46, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-gy9416-01.jpg', 'Adilette22 Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (834, 46, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-02.jpg', 'Adilette22 Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (835, 47, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'VansLaCosta Checker - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Checkerboard');
INSERT INTO `product_images` VALUES (836, 47, 'https://bizweb.dktcdn.net/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'VansLaCosta Checker - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Checkerboard');
INSERT INTO `product_images` VALUES (837, 47, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'VansLaCosta Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (838, 47, 'https://bizweb.dktcdn.net/100/347/092/products/110339010959-18-2-1080x715-1.jpg', 'VansLaCosta Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (839, 48, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'Leadcat Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (840, 48, 'https://bizweb.dktcdn.net/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'Leadcat Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (841, 48, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'Leadcat White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (842, 48, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-01.jpg', 'Leadcat White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (843, 48, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/110339010959-18-2-1080x715-1.jpg', 'Leadcat Navy - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (844, 48, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-02.jpg', 'Leadcat Navy - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (845, 49, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'NB200Slide Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (846, 49, 'https://bizweb.dktcdn.net/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'NB200Slide Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (847, 49, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'NB200Slide Grey - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (848, 49, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-01.jpg', 'NB200Slide Grey - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Grey');
INSERT INTO `product_images` VALUES (849, 50, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'GelRes9 WhiteBlue - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Blue');
INSERT INTO `product_images` VALUES (850, 50, 'https://bizweb.dktcdn.net/100/347/092/products/evoride-women-s-1012a677-020-03.jpg', 'GelRes9 WhiteBlue - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Blue');
INSERT INTO `product_images` VALUES (851, 50, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'GelRes9 BlackOrange - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black Orange');
INSERT INTO `product_images` VALUES (852, 50, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-1.jpg', 'GelRes9 BlackOrange - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black Orange');
INSERT INTO `product_images` VALUES (853, 51, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/m-plus-zoom-plus-gp-plus-challenge-plus-pro-plus-hc.jpg', 'VaporPro2 White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (854, 51, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-vomero-18-hm6803-401-1.jpg', 'VaporPro2 White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (855, 51, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-01-33f41548-eee8-493c-b25a-0656a44d0665.jpg', 'VaporPro2 Pink - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (856, 51, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-02-c539f141-482a-4177-8c3f-c9d6b366c1f3.jpg', 'VaporPro2 Pink - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Pink');
INSERT INTO `product_images` VALUES (857, 52, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'Barricade Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (858, 52, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-03-70b40d8a-8bd0-469b-84e3-6a4ba0a5d6f9.jpg', 'Barricade Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (859, 52, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-01-standard.jpg', 'Barricade WhiteGreen - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Green');
INSERT INTO `product_images` VALUES (860, 52, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-02-standard.jpg', 'Barricade WhiteGreen - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Green');
INSERT INTO `product_images` VALUES (861, 53, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-3.jpg', 'FFLav WhitePink - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Pink');
INSERT INTO `product_images` VALUES (862, 53, 'https://bizweb.dktcdn.net/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-2.jpg', 'FFLav WhitePink - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Pink');
INSERT INTO `product_images` VALUES (863, 53, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'FFLav Navy - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (864, 53, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-2.jpg', 'FFLav Navy - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Navy');
INSERT INTO `product_images` VALUES (865, 54, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'Metcon9 Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (866, 54, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'Metcon9 Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (867, 54, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/663c3749-e7a7-4a6d-8111-32398a36b1cf.jpg', 'Metcon9 White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (868, 54, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-02.jpg', 'Metcon9 White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (869, 54, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-01.jpg', 'Metcon9 Olive - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Olive');
INSERT INTO `product_images` VALUES (870, 54, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-02.jpg', 'Metcon9 Olive - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Olive');
INSERT INTO `product_images` VALUES (871, 55, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-01-standard.jpg', 'NanoX3 Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (872, 55, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-02-standard.jpg', 'NanoX3 Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (873, 55, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-03-standard.jpg', 'NanoX3 Black - Back', 0, 2, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (874, 55, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-21-be-fy0391-01.jpg', 'NanoX3 White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (875, 55, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-21-be-fy0391-02.jpg', 'NanoX3 White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (876, 56, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'TriBase BlackGrey - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black Grey');
INSERT INTO `product_images` VALUES (877, 56, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-air-max-2017-849559-005-2.jpg', 'TriBase BlackGrey - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black Grey');
INSERT INTO `product_images` VALUES (878, 56, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-adidas-supernova-rise-move-for-the-planet-ig8328-01-3.jpg', 'TriBase White - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (879, 56, 'https://bizweb.dktcdn.net/100/347/092/products/giay-adidas-supernova-rise-move-for-the-planet-ig8328-01-4.jpg', 'TriBase White - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White');
INSERT INTO `product_images` VALUES (880, 57, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'Fuse3 WhitePink - Main', 1, 0, 1, '2026-06-15 16:28:15', 'White Pink');
INSERT INTO `product_images` VALUES (881, 57, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'Fuse3 WhitePink - Side', 0, 1, 1, '2026-06-15 16:28:15', 'White Pink');
INSERT INTO `product_images` VALUES (882, 57, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-3.jpg', 'Fuse3 WhitePink - Back', 0, 2, 1, '2026-06-15 16:28:15', 'White Pink');
INSERT INTO `product_images` VALUES (883, 57, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-4.jpg', 'Fuse3 Black - Main', 1, 0, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (884, 57, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-5.jpg', 'Fuse3 Black - Side', 0, 1, 1, '2026-06-15 16:28:15', 'Black');
INSERT INTO `product_images` VALUES (885, 58, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-01.jpg?v=1694779868303', 'ShoeKit - Bộ dụng cụ', 1, 0, 1, '2026-06-15 16:28:15', 'Default');
INSERT INTO `product_images` VALUES (886, 58, 'https://bizweb.dktcdn.net/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-02.jpg', 'ShoeKit - Chi tiết', 0, 1, 1, '2026-06-15 16:28:15', 'Default');
INSERT INTO `product_images` VALUES (887, 59, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-01.jpg?v=1694779868303', 'NanoSpray - Mặt trước', 1, 0, 1, '2026-06-15 16:28:15', 'Default');
INSERT INTO `product_images` VALUES (888, 59, 'https://bizweb.dktcdn.net/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-02.jpg', 'NanoSpray - Chi tiết', 0, 1, 1, '2026-06-15 16:28:15', 'Default');
INSERT INTO `product_images` VALUES (889, 60, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'Socks - Pack 3 đôi', 1, 0, 1, '2026-06-15 16:28:15', 'Multi');
INSERT INTO `product_images` VALUES (890, 60, 'https://bizweb.dktcdn.net/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'Socks - Chi tiết', 0, 1, 1, '2026-06-15 16:28:15', 'Multi');

-- ----------------------------
-- Table structure for product_promotions
-- ----------------------------
DROP TABLE IF EXISTS `product_promotions`;
CREATE TABLE `product_promotions`  (
  `product_id` int NOT NULL,
  `promotion_id` int NOT NULL,
  `sale_price` decimal(15, 2) NULL DEFAULT NULL COMMENT 'Giá bán trong đợt, NULL = dùng price gốc',
  PRIMARY KEY (`product_id`, `promotion_id`) USING BTREE,
  INDEX `fk_pp_promotion`(`promotion_id` ASC) USING BTREE,
  CONSTRAINT `fk_pp_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_pp_promotion` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_promotions
-- ----------------------------

-- ----------------------------
-- Table structure for product_specs
-- ----------------------------
DROP TABLE IF EXISTS `product_specs`;
CREATE TABLE `product_specs`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `spec_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `spec_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sort_order` int NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_product_specs_product`(`product_id` ASC, `sort_order` ASC) USING BTREE,
  CONSTRAINT `fk_product_specs_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 377 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_specs
-- ----------------------------
INSERT INTO `product_specs` VALUES (1, 1, 'Chất liệu Upper', 'Mesh thoáng khí', 1, '2025-12-21 22:18:01', '2025-12-21 22:18:01');
INSERT INTO `product_specs` VALUES (2, 1, 'Đế ngoài', 'Cao su chống trượt', 2, '2025-12-21 22:18:01', '2025-12-21 22:18:01');
INSERT INTO `product_specs` VALUES (3, 1, 'Công nghệ đệm', 'Air Zoom', 3, '2025-12-21 22:18:01', '2025-12-21 22:18:01');
INSERT INTO `product_specs` VALUES (4, 1, 'Mục đích', 'Chạy bộ đường trường', 4, '2025-12-21 22:18:01', '2025-12-21 22:18:01');
INSERT INTO `product_specs` VALUES (305, 11, 'Chất liệu Upper', 'Da tổng hợp full-grain', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (306, 11, 'Đế ngoài', 'Cao su nguyên khối Pivot Circle', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (307, 11, 'Công nghệ đệm', 'Nike Air ẩn (Encapsulated)', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (308, 11, 'Form giày', 'Rộng hơn TTS 0.5 size', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (309, 11, 'Xuất xứ', 'Việt Nam', 5, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (310, 11, 'Bảo hành', '6 tháng keo đế', 6, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (311, 12, 'Chất liệu Upper', 'Da thật + Da lộn Suede', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (312, 12, 'Đế ngoài', 'Cao su Gum Rubber', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (313, 12, 'Lót giày', 'OrthoLite', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (314, 12, 'Form giày', 'True to Size', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (315, 12, 'Xuất xứ', 'Indonesia', 5, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (316, 13, 'Chất liệu Upper', 'Da tổng hợp đục lỗ', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (317, 13, 'Đế ngoài', 'Cao su chống mài mòn', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (318, 13, 'Form giày', 'Rộng nhẹ (NB truyền thống)', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (319, 13, 'Xuất xứ', 'Trung Quốc', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (320, 14, 'Chất liệu Upper', 'Da lộn Suede', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (321, 14, 'Đế ngoài', 'Cao su Gum', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (322, 14, 'Lót giày', 'SoftFoam+', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (323, 14, 'Trọng lượng', '~280g', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (324, 17, 'Chất liệu Upper', 'Da tổng hợp Premium', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (325, 17, 'Đế ngoài', 'Cao su Pivot Circle', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (326, 17, 'Công nghệ đệm', 'Foam nhẹ', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (327, 17, 'Form giày', 'TTS đến hơi chật 0.5', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (328, 23, 'Chất liệu Upper', 'Flyknit siêu nhẹ', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (329, 23, 'Đế ngoài', 'Cao su Waffle', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (330, 23, 'Công nghệ đệm', 'ZoomX + Carbon Plate', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (331, 23, 'Trọng lượng', '~188g (size 42)', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (332, 23, 'Drop', '8mm', 5, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (333, 23, 'Tuổi thọ', '~400km', 6, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (334, 24, 'Chất liệu Upper', 'Mesh kỹ thuật', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (335, 24, 'Đế ngoài', 'Continental Rubber', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (336, 24, 'Công nghệ đệm', 'Lightstrike Pro + Energyrods 2.0', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (337, 24, 'Trọng lượng', '~240g (size 42)', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (338, 24, 'Tuổi thọ', '~800-1000km', 5, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (339, 25, 'Chất liệu Upper', 'Mesh Jacquard', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (340, 25, 'Đế ngoài', 'AHAR Rubber', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (341, 25, 'Công nghệ đệm', 'FF BLAST PLUS ECO', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (342, 25, 'Trọng lượng', '~260g (size 42)', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (343, 25, 'Drop', '8mm', 5, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (344, 27, 'Chất liệu Upper', 'Mesh + Flywire', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (345, 27, 'Đế ngoài', 'Waffle cải tiến', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (346, 27, 'Công nghệ đệm', 'React X + Zoom Air', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (347, 27, 'Trọng lượng', '~275g (size 42)', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (348, 27, 'Drop', '10mm', 5, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (349, 29, 'Chất liệu Upper', 'Primeknit', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (350, 29, 'Đế ngoài', 'Continental Rubber', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (351, 29, 'Công nghệ đệm', 'Light BOOST', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (352, 29, 'Trọng lượng', '~280g (size 42)', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (353, 33, 'Chất liệu Upper', 'Vaporposite+ siêu mỏng', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (354, 33, 'Đế', 'FG (Firm Ground - Sân cỏ tự nhiên)', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (355, 33, 'Công nghệ', 'Anti-Clog Traction', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (356, 33, 'Cổ giày', 'Dynamic Fit Collar', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (357, 35, 'Chất liệu Upper', 'Textile + FUZIONFIT+', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (358, 35, 'Đế', 'TF (Turf - Sân cỏ nhân tạo)', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (359, 35, 'Công nghệ', 'GripControl Pro', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (360, 39, 'Chất liệu Upper', 'Mesh đa lớp', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (361, 39, 'Đế ngoài', 'EP (Engineered Performance)', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (362, 39, 'Công nghệ đệm', 'Zoom Air Strobel + Air', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (363, 39, 'Cổ giày', 'Low-top', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (364, 41, 'Chất liệu Upper', 'UA Warp Mesh', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (365, 41, 'Đế ngoài', 'UA Flow (không cao su)', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (366, 41, 'Công nghệ đệm', 'UA Flow toàn chiều dài', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (367, 41, 'Trọng lượng', '~310g', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (368, 54, 'Chất liệu Upper', 'Mesh siêu bền', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (369, 54, 'Mục đích', 'Cử tạ, CrossFit, Gym', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (370, 54, 'Công nghệ đệm', 'Hyperlift + React Foam', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (371, 54, 'Đặc biệt', 'Rope Wrap hỗ trợ leo dây', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (372, 54, 'Trọng lượng', '~340g', 5, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (373, 55, 'Chất liệu Upper', 'Flexweave Knit', 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (374, 55, 'Mục đích', 'CrossFit, HIIT, Functional', 2, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (375, 55, 'Công nghệ đệm', 'Floatride Energy + Lift&Run', 3, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_specs` VALUES (376, 55, 'Đặc biệt', 'Heel Clip ổn định gót', 4, '2026-06-15 16:28:15', '2026-06-15 16:28:15');

-- ----------------------------
-- Table structure for product_variants
-- ----------------------------
DROP TABLE IF EXISTS `product_variants`;
CREATE TABLE `product_variants`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `size` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `stock_qty` int NOT NULL DEFAULT 0,
  `sku` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_product_color_size`(`product_id` ASC, `color` ASC, `size` ASC) USING BTREE,
  INDEX `idx_variant_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_variant_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 707 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_variants
-- ----------------------------
INSERT INTO `product_variants` VALUES (1, 1, 'Black', '40', 7, 'P1-BLK-40', NULL, '2025-12-19 21:41:01', '2026-01-13 10:56:25');
INSERT INTO `product_variants` VALUES (2, 1, 'Black', '41', 5, 'P1-BLK-41', NULL, '2025-12-19 21:41:01', '2026-01-13 10:56:21');
INSERT INTO `product_variants` VALUES (3, 1, 'White', '40', 3, 'P1-WHT-40', NULL, '2025-12-19 21:41:01', '2025-12-19 21:41:01');
INSERT INTO `product_variants` VALUES (4, 2, 'Black', '42', 8, 'P2-BLK-42', NULL, '2025-12-19 21:41:01', '2025-12-19 21:41:01');
INSERT INTO `product_variants` VALUES (5, 2, 'Blue', '41', 0, 'P2-BLU-41', NULL, '2025-12-19 21:41:01', '2025-12-19 21:41:01');
INSERT INTO `product_variants` VALUES (6, 1, 'BLUE', '39', 5, 'P1-BLU-39', NULL, '2025-12-20 21:52:22', '2025-12-20 21:52:22');
INSERT INTO `product_variants` VALUES (7, 1, 'BLUE', '42', 7, 'P1-BLU-42', NULL, '2025-12-20 21:52:22', '2025-12-20 21:52:22');
INSERT INTO `product_variants` VALUES (8, 1, 'RED', '39', 4, 'P1-RED-39', NULL, '2025-12-20 21:52:22', '2025-12-20 21:52:22');
INSERT INTO `product_variants` VALUES (9, 1, 'RED', '42', 0, 'P1-RED-42', NULL, '2025-12-20 21:52:22', '2025-12-20 21:52:22');
INSERT INTO `product_variants` VALUES (10, 1, 'GREEN', '40', 1, 'P1-GR-40', 350, '2026-01-15 18:52:48', '2026-01-15 18:52:48');
INSERT INTO `product_variants` VALUES (208, 10, 'White', '40', 8, 'P13-WHI-40', NULL, '2026-01-16 04:03:11', '2026-01-16 04:04:46');
INSERT INTO `product_variants` VALUES (209, 10, 'Black', '40', 5, 'P13-BLK-40', NULL, '2026-01-16 04:04:06', '2026-01-16 04:04:35');
INSERT INTO `product_variants` VALUES (210, 10, 'Black', '42', 6, 'P13-BLK-42', NULL, '2026-01-16 04:05:12', '2026-01-16 04:05:12');
INSERT INTO `product_variants` VALUES (211, 10, 'White', '42', 7, 'P13-WHI-42', NULL, '2026-01-16 04:05:32', '2026-01-16 04:05:32');
INSERT INTO `product_variants` VALUES (212, 3, 'Black', '40', 7, 'P13-BLK-40', NULL, '2026-01-16 04:16:22', '2026-01-16 04:16:22');
INSERT INTO `product_variants` VALUES (213, 3, 'Black', '41', 6, 'P13-BLK-41', NULL, '2026-01-16 04:16:38', '2026-01-16 04:16:38');
INSERT INTO `product_variants` VALUES (214, 3, 'White', '40', 9, 'P13-WHI-40', NULL, '2026-01-16 04:16:54', '2026-01-16 04:16:54');
INSERT INTO `product_variants` VALUES (215, 3, 'White', '41', 9, 'P13-WHI-41', NULL, '2026-01-16 04:17:13', '2026-01-16 04:17:13');
INSERT INTO `product_variants` VALUES (216, 9, 'White', '40', 9, 'P13-WHI-40', NULL, '2026-01-16 04:19:42', '2026-01-16 04:20:03');
INSERT INTO `product_variants` VALUES (217, 9, 'White', '42', 6, 'P13-WHI-42', NULL, '2026-01-16 04:19:58', '2026-01-16 04:19:58');
INSERT INTO `product_variants` VALUES (218, 9, 'Beige', '40', 6, 'P13-BEI-40', NULL, '2026-01-16 04:20:34', '2026-01-16 04:20:34');
INSERT INTO `product_variants` VALUES (219, 9, 'Beige', '42', 9, 'P13-BEI-41', NULL, '2026-01-16 04:20:50', '2026-01-16 04:21:02');
INSERT INTO `product_variants` VALUES (220, 8, 'Black', '40', 8, 'P13-BLK-40', NULL, '2026-01-16 04:22:55', '2026-01-16 04:22:55');
INSERT INTO `product_variants` VALUES (221, 8, 'Black', '42', 9, 'P13-BLK-42', NULL, '2026-01-16 04:23:08', '2026-01-16 04:23:08');
INSERT INTO `product_variants` VALUES (222, 8, 'White', '40', 8, 'P13-WHI-40', NULL, '2026-01-16 04:23:21', '2026-01-16 04:23:21');
INSERT INTO `product_variants` VALUES (223, 8, 'White', '42', 9, 'P13-WHI-42', NULL, '2026-01-16 04:23:39', '2026-01-16 04:23:39');
INSERT INTO `product_variants` VALUES (224, 7, 'Red', '40', 5, 'P13-RED-40', NULL, '2026-01-16 04:26:42', '2026-01-16 04:26:42');
INSERT INTO `product_variants` VALUES (225, 7, 'Red', '41', 8, 'P13-RED-41', NULL, '2026-01-16 04:26:53', '2026-01-16 04:26:53');
INSERT INTO `product_variants` VALUES (226, 7, 'Green', '40', 9, 'P13-GRE-40', NULL, '2026-01-16 04:27:03', '2026-01-16 04:27:03');
INSERT INTO `product_variants` VALUES (227, 7, 'Green', '41', 4, 'P13-GRE-41', NULL, '2026-01-16 04:27:18', '2026-01-16 04:27:18');
INSERT INTO `product_variants` VALUES (228, 6, 'Black', '40', 5, 'P13-BLK-40', NULL, '2026-01-16 04:29:17', '2026-01-16 04:29:24');
INSERT INTO `product_variants` VALUES (229, 6, 'Black', '42', 5, 'P13-BLK-42', NULL, '2026-01-16 04:29:34', '2026-01-16 04:29:34');
INSERT INTO `product_variants` VALUES (230, 6, 'Red', '40', 6, 'P13-RED-40', NULL, '2026-01-16 04:29:45', '2026-01-16 04:29:45');
INSERT INTO `product_variants` VALUES (231, 6, 'Red', '42', 4, 'P13-RED-42', NULL, '2026-01-16 04:29:55', '2026-01-16 04:29:55');
INSERT INTO `product_variants` VALUES (232, 5, 'Green', '40', 5, 'P13-GRE-40', NULL, '2026-01-16 04:32:04', '2026-01-16 04:32:04');
INSERT INTO `product_variants` VALUES (233, 5, 'Green', '41', 5, 'P13-GRE-41', NULL, '2026-01-16 04:32:17', '2026-01-16 04:32:17');
INSERT INTO `product_variants` VALUES (234, 5, 'White', '40', 5, 'P13-WHI-40', NULL, '2026-01-16 04:32:42', '2026-01-16 04:32:42');
INSERT INTO `product_variants` VALUES (235, 5, 'White', '41', 7, 'P13-WHI-41', NULL, '2026-01-16 04:33:01', '2026-01-16 04:33:01');
INSERT INTO `product_variants` VALUES (236, 4, 'Navy', '40', 5, 'P13-NAV-40', NULL, '2026-01-16 04:34:59', '2026-01-16 04:34:59');
INSERT INTO `product_variants` VALUES (237, 4, 'Navy', '41', 8, 'P13-NAV-41', NULL, '2026-01-16 04:35:08', '2026-01-16 04:35:08');
INSERT INTO `product_variants` VALUES (238, 4, 'Black', '40', 4, 'P13-BLK-40', NULL, '2026-01-16 04:35:20', '2026-01-16 11:11:38');
INSERT INTO `product_variants` VALUES (239, 4, 'Black', '41', 8, 'P13-BLK-41', NULL, '2026-01-16 04:35:31', '2026-01-16 04:35:31');
INSERT INTO `product_variants` VALUES (240, 11, 'White', '38', 8, 'AF1-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (241, 11, 'White', '39', 15, 'AF1-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (242, 11, 'White', '40', 22, 'AF1-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (243, 11, 'White', '41', 18, 'AF1-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (244, 11, 'White', '42', 10, 'AF1-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (245, 11, 'Black', '38', 4, 'AF1-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (246, 11, 'Black', '39', 6, 'AF1-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (247, 11, 'Black', '40', 12, 'AF1-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (248, 11, 'Black', '41', 9, 'AF1-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (249, 11, 'Black', '42', 14, 'AF1-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (250, 11, 'Grey', '39', 3, 'AF1-GRY-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (251, 11, 'Grey', '40', 7, 'AF1-GRY-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (252, 11, 'Grey', '41', 11, 'AF1-GRY-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (253, 11, 'Grey', '42', 5, 'AF1-GRY-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (254, 11, 'Grey', '43', 2, 'AF1-GRY-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (255, 12, 'Black', '38', 5, 'SAM-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (256, 12, 'Black', '39', 12, 'SAM-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (257, 12, 'Black', '40', 19, 'SAM-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (258, 12, 'Black', '41', 25, 'SAM-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (259, 12, 'Black', '42', 11, 'SAM-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (260, 12, 'White', '38', 7, 'SAM-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (261, 12, 'White', '39', 14, 'SAM-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (262, 12, 'White', '40', 20, 'SAM-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (263, 12, 'White', '41', 16, 'SAM-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (264, 12, 'White', '42', 8, 'SAM-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (265, 13, 'White Green', '39', 8, 'NB550-WG-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (266, 13, 'White Green', '40', 13, 'NB550-WG-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (267, 13, 'White Green', '41', 20, 'NB550-WG-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (268, 13, 'White Green', '42', 6, 'NB550-WG-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (269, 13, 'White Grey', '39', 10, 'NB550-WGR-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (270, 13, 'White Grey', '40', 16, 'NB550-WGR-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (271, 13, 'White Grey', '41', 12, 'NB550-WGR-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (272, 13, 'White Grey', '42', 4, 'NB550-WGR-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (273, 13, 'White Red', '39', 5, 'NB550-WR-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (274, 13, 'White Red', '40', 9, 'NB550-WR-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (275, 13, 'White Red', '41', 14, 'NB550-WR-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (276, 13, 'White Red', '42', 3, 'NB550-WR-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (277, 14, 'White', '36', 12, 'PAL-WHT-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (278, 14, 'White', '37', 18, 'PAL-WHT-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (279, 14, 'White', '38', 9, 'PAL-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (280, 14, 'White', '39', 6, 'PAL-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (281, 14, 'Pink', '36', 15, 'PAL-PNK-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (282, 14, 'Pink', '37', 21, 'PAL-PNK-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (283, 14, 'Pink', '38', 11, 'PAL-PNK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (284, 14, 'Pink', '39', 4, 'PAL-PNK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (285, 15, 'Black', '38', 14, 'C70-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (286, 15, 'Black', '39', 22, 'C70-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (287, 15, 'Black', '40', 19, 'C70-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (288, 15, 'Black', '41', 11, 'C70-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (289, 15, 'Black', '42', 7, 'C70-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (290, 15, 'Red', '38', 8, 'C70-RED-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (291, 15, 'Red', '39', 13, 'C70-RED-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (292, 15, 'Red', '40', 16, 'C70-RED-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (293, 15, 'Red', '41', 5, 'C70-RED-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (294, 15, 'Red', '42', 3, 'C70-RED-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (295, 16, 'Black White', '39', 16, 'VOS-BW-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (296, 16, 'Black White', '40', 24, 'VOS-BW-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (297, 16, 'Black White', '41', 20, 'VOS-BW-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (298, 16, 'Black White', '42', 13, 'VOS-BW-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (299, 16, 'Navy', '39', 8, 'VOS-NAV-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (300, 16, 'Navy', '40', 11, 'VOS-NAV-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (301, 16, 'Navy', '41', 6, 'VOS-NAV-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (302, 16, 'Navy', '42', 3, 'VOS-NAV-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (303, 16, 'Red', '39', 5, 'VOS-RED-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (304, 16, 'Red', '40', 9, 'VOS-RED-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (305, 16, 'Red', '41', 7, 'VOS-RED-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (306, 16, 'Red', '42', 2, 'VOS-RED-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (307, 17, 'Black White', '38', 3, 'DL-BW-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (308, 17, 'Black White', '39', 5, 'DL-BW-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (309, 17, 'Black White', '40', 3, 'DL-BW-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (310, 17, 'Black White', '41', 8, 'DL-BW-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (311, 17, 'Black White', '42', 2, 'DL-BW-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (312, 17, 'Grey Fog', '38', 7, 'DL-GF-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (313, 17, 'Grey Fog', '39', 12, 'DL-GF-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (314, 17, 'Grey Fog', '40', 18, 'DL-GF-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (315, 17, 'Grey Fog', '41', 15, 'DL-GF-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (316, 17, 'Grey Fog', '42', 9, 'DL-GF-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (317, 17, 'Green', '39', 4, 'DL-GRN-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (318, 17, 'Green', '40', 7, 'DL-GRN-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (319, 17, 'Green', '41', 10, 'DL-GRN-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (320, 17, 'Green', '42', 4, 'DL-GRN-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (321, 17, 'Green', '43', 6, 'DL-GRN-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (322, 18, 'Green', '36', 9, 'GAZ-GRN-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (323, 18, 'Green', '37', 14, 'GAZ-GRN-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (324, 18, 'Green', '38', 7, 'GAZ-GRN-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (325, 18, 'Green', '39', 3, 'GAZ-GRN-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (326, 18, 'Black', '36', 11, 'GAZ-BLK-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (327, 18, 'Black', '37', 16, 'GAZ-BLK-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (328, 18, 'Black', '38', 8, 'GAZ-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (329, 18, 'Black', '39', 5, 'GAZ-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (330, 18, 'Pink', '36', 13, 'GAZ-PNK-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (331, 18, 'Pink', '37', 19, 'GAZ-PNK-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (332, 18, 'Pink', '38', 10, 'GAZ-PNK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (333, 18, 'Pink', '39', 4, 'GAZ-PNK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (334, 19, 'Grey', '40', 6, 'NB2002-GRY-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (335, 19, 'Grey', '41', 10, 'NB2002-GRY-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (336, 19, 'Grey', '42', 15, 'NB2002-GRY-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (337, 19, 'Grey', '43', 4, 'NB2002-GRY-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (338, 19, 'Brown', '40', 3, 'NB2002-BRN-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (339, 19, 'Brown', '41', 7, 'NB2002-BRN-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (340, 19, 'Brown', '42', 9, 'NB2002-BRN-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (341, 19, 'Brown', '43', 2, 'NB2002-BRN-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (342, 20, 'Black', '36', 8, 'RSH-BLK-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (343, 20, 'Black', '37', 13, 'RSH-BLK-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (344, 20, 'Black', '38', 5, 'RSH-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (345, 20, 'Black', '39', 3, 'RSH-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (346, 20, 'White', '36', 6, 'RSH-WHT-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (347, 20, 'White', '37', 10, 'RSH-WHT-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (348, 20, 'White', '38', 7, 'RSH-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (349, 20, 'White', '39', 2, 'RSH-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (350, 21, 'Black', '39', 11, 'SK8-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (351, 21, 'Black', '40', 17, 'SK8-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (352, 21, 'Black', '41', 9, 'SK8-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (353, 21, 'Black', '42', 5, 'SK8-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (354, 21, 'Navy', '39', 5, 'SK8-NAV-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (355, 21, 'Navy', '40', 8, 'SK8-NAV-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (356, 21, 'Navy', '41', 6, 'SK8-NAV-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (357, 21, 'Navy', '42', 3, 'SK8-NAV-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (358, 22, 'Navy', '39', 8, 'PSD-NAV-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (359, 22, 'Navy', '40', 14, 'PSD-NAV-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (360, 22, 'Navy', '41', 21, 'PSD-NAV-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (361, 22, 'Navy', '42', 12, 'PSD-NAV-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (362, 22, 'Navy', '43', 6, 'PSD-NAV-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (363, 22, 'Black', '39', 5, 'PSD-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (364, 22, 'Black', '40', 10, 'PSD-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (365, 22, 'Black', '41', 16, 'PSD-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (366, 22, 'Black', '42', 9, 'PSD-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (367, 22, 'Black', '43', 3, 'PSD-BLK-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (368, 23, 'Volt', '39', 2, 'VPF-VLT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (369, 23, 'Volt', '40', 3, 'VPF-VLT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (370, 23, 'Volt', '41', 5, 'VPF-VLT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (371, 23, 'Volt', '42', 2, 'VPF-VLT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (372, 23, 'Pink', '39', 4, 'VPF-PNK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (373, 23, 'Pink', '40', 6, 'VPF-PNK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (374, 23, 'Pink', '41', 8, 'VPF-PNK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (375, 23, 'Pink', '42', 3, 'VPF-PNK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (376, 23, 'Black', '39', 1, 'VPF-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (377, 23, 'Black', '40', 4, 'VPF-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (378, 23, 'Black', '41', 3, 'VPF-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (379, 23, 'Black', '42', 2, 'VPF-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (380, 24, 'Black', '36', 10, 'BOS-BLK-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (381, 24, 'Black', '37', 18, 'BOS-BLK-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (382, 24, 'Black', '38', 14, 'BOS-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (383, 24, 'Black', '39', 8, 'BOS-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (384, 24, 'Black', '40', 5, 'BOS-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (385, 24, 'White', '36', 6, 'BOS-WHT-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (386, 24, 'White', '37', 12, 'BOS-WHT-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (387, 24, 'White', '38', 9, 'BOS-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (388, 24, 'White', '39', 5, 'BOS-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (389, 24, 'White', '40', 3, 'BOS-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (390, 25, 'Blue', '40', 12, 'NOV-BLU-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (391, 25, 'Blue', '41', 18, 'NOV-BLU-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (392, 25, 'Blue', '42', 9, 'NOV-BLU-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (393, 25, 'Blue', '43', 4, 'NOV-BLU-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (394, 25, 'White', '40', 7, 'NOV-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (395, 25, 'White', '41', 14, 'NOV-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (396, 25, 'White', '42', 8, 'NOV-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (397, 25, 'White', '43', 5, 'NOV-WHT-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (398, 25, 'Black', '40', 6, 'NOV-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (399, 25, 'Black', '41', 10, 'NOV-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (400, 25, 'Black', '42', 16, 'NOV-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (401, 25, 'Black', '43', 3, 'NOV-BLK-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (402, 26, 'White Red', '41', 2, 'SCE-WR-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (403, 26, 'White Red', '42', 4, 'SCE-WR-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (404, 26, 'White Red', '43', 1, 'SCE-WR-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (405, 26, 'Neon Yellow', '41', 3, 'SCE-NY-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (406, 26, 'Neon Yellow', '42', 5, 'SCE-NY-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (407, 26, 'Neon Yellow', '43', 2, 'SCE-NY-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (408, 27, 'Pink', '36', 15, 'PEG-PNK-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (409, 27, 'Pink', '37', 22, 'PEG-PNK-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (410, 27, 'Pink', '38', 18, 'PEG-PNK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (411, 27, 'Pink', '39', 10, 'PEG-PNK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (412, 27, 'Pink', '40', 5, 'PEG-PNK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (413, 27, 'Black', '36', 8, 'PEG-BLK-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (414, 27, 'Black', '37', 13, 'PEG-BLK-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (415, 27, 'Black', '38', 11, 'PEG-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (416, 27, 'Black', '39', 6, 'PEG-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (417, 27, 'Black', '40', 3, 'PEG-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (418, 27, 'White', '36', 5, 'PEG-WHT-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (419, 27, 'White', '37', 9, 'PEG-WHT-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (420, 27, 'White', '38', 7, 'PEG-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (421, 27, 'White', '39', 4, 'PEG-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (422, 27, 'White', '40', 2, 'PEG-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (423, 28, 'Yellow', '40', 4, 'WRB-YEL-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (424, 28, 'Yellow', '41', 7, 'WRB-YEL-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (425, 28, 'Yellow', '42', 5, 'WRB-YEL-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (426, 28, 'Yellow', '43', 3, 'WRB-YEL-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (427, 28, 'Black', '40', 6, 'WRB-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (428, 28, 'Black', '41', 9, 'WRB-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (429, 28, 'Black', '42', 8, 'WRB-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (430, 28, 'Black', '43', 4, 'WRB-BLK-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (431, 29, 'White', '38', 6, 'UBL-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (432, 29, 'White', '39', 11, 'UBL-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (433, 29, 'White', '40', 19, 'UBL-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (434, 29, 'White', '41', 15, 'UBL-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (435, 29, 'White', '42', 8, 'UBL-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (436, 29, 'Black', '38', 4, 'UBL-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (437, 29, 'Black', '39', 7, 'UBL-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (438, 29, 'Black', '40', 14, 'UBL-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (439, 29, 'Black', '41', 20, 'UBL-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (440, 29, 'Black', '42', 12, 'UBL-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (441, 29, 'Navy', '38', 3, 'UBL-NAV-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (442, 29, 'Navy', '39', 5, 'UBL-NAV-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (443, 29, 'Navy', '40', 8, 'UBL-NAV-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (444, 29, 'Navy', '41', 10, 'UBL-NAV-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (445, 29, 'Navy', '42', 6, 'UBL-NAV-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (446, 30, 'Grey', '36', 9, 'KAY-GRY-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (447, 30, 'Grey', '37', 14, 'KAY-GRY-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (448, 30, 'Grey', '38', 7, 'KAY-GRY-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (449, 30, 'Grey', '39', 4, 'KAY-GRY-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (450, 30, 'Blue', '36', 5, 'KAY-BLU-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (451, 30, 'Blue', '37', 10, 'KAY-BLU-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (452, 30, 'Blue', '38', 8, 'KAY-BLU-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (453, 30, 'Blue', '39', 3, 'KAY-BLU-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (454, 31, 'Black', '39', 10, 'VN3-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (455, 31, 'Black', '40', 16, 'VN3-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (456, 31, 'Black', '41', 22, 'VN3-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (457, 31, 'Black', '42', 14, 'VN3-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (458, 31, 'Black', '43', 8, 'VN3-BLK-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (459, 31, 'White', '39', 5, 'VN3-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (460, 31, 'White', '40', 10, 'VN3-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (461, 31, 'White', '41', 15, 'VN3-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (462, 31, 'White', '42', 9, 'VN3-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (463, 31, 'White', '43', 4, 'VN3-WHT-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (464, 32, 'Black Red', '40', 8, 'HVM-BR-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (465, 32, 'Black Red', '41', 12, 'HVM-BR-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (466, 32, 'Black Red', '42', 10, 'HVM-BR-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (467, 32, 'Black Red', '43', 5, 'HVM-BR-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (468, 32, 'Grey Blue', '40', 4, 'HVM-GB-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (469, 32, 'Grey Blue', '41', 7, 'HVM-GB-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (470, 32, 'Grey Blue', '42', 6, 'HVM-GB-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (471, 32, 'Grey Blue', '43', 3, 'HVM-GB-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (472, 33, 'Volt', '39', 2, 'MER-VLT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (473, 33, 'Volt', '40', 3, 'MER-VLT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (474, 33, 'Volt', '41', 6, 'MER-VLT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (475, 33, 'Volt', '42', 4, 'MER-VLT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (476, 33, 'Black', '39', 4, 'MER-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (477, 33, 'Black', '40', 5, 'MER-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (478, 33, 'Black', '41', 9, 'MER-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (479, 33, 'Black', '42', 7, 'MER-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (480, 33, 'White', '39', 3, 'MER-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (481, 33, 'White', '40', 6, 'MER-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (482, 33, 'White', '41', 8, 'MER-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (483, 33, 'White', '42', 5, 'MER-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (484, 34, 'Black Red', '39', 6, 'PRD-BR-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (485, 34, 'Black Red', '40', 11, 'PRD-BR-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (486, 34, 'Black Red', '41', 8, 'PRD-BR-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (487, 34, 'Black Red', '42', 4, 'PRD-BR-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (488, 34, 'White Gold', '39', 3, 'PRD-WG-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (489, 34, 'White Gold', '40', 7, 'PRD-WG-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (490, 34, 'White Gold', '41', 5, 'PRD-WG-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (491, 34, 'White Gold', '42', 2, 'PRD-WG-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (492, 35, 'Blue', '39', 9, 'FUT-BLU-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (493, 35, 'Blue', '40', 14, 'FUT-BLU-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (494, 35, 'Blue', '41', 7, 'FUT-BLU-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (495, 35, 'Blue', '42', 4, 'FUT-BLU-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (496, 35, 'White', '39', 5, 'FUT-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (497, 35, 'White', '40', 10, 'FUT-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (498, 35, 'White', '41', 8, 'FUT-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (499, 35, 'White', '42', 3, 'FUT-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (500, 36, 'Crimson', '39', 3, 'PHG-CRM-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (501, 36, 'Crimson', '40', 6, 'PHG-CRM-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (502, 36, 'Crimson', '41', 10, 'PHG-CRM-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (503, 36, 'Crimson', '42', 4, 'PHG-CRM-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (504, 36, 'Black', '39', 5, 'PHG-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (505, 36, 'Black', '40', 8, 'PHG-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (506, 36, 'Black', '41', 12, 'PHG-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (507, 36, 'Black', '42', 6, 'PHG-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (508, 37, 'Black', '39', 8, 'COP-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (509, 37, 'Black', '40', 15, 'COP-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (510, 37, 'Black', '41', 12, 'COP-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (511, 37, 'Black', '42', 6, 'COP-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (512, 37, 'White', '39', 4, 'COP-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (513, 37, 'White', '40', 9, 'COP-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (514, 37, 'White', '41', 7, 'COP-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (515, 37, 'White', '42', 3, 'COP-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (516, 38, 'White', '40', 3, 'MZA-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (517, 38, 'White', '41', 5, 'MZA-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (518, 38, 'White', '42', 2, 'MZA-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (519, 38, 'Black', '40', 4, 'MZA-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (520, 38, 'Black', '41', 7, 'MZA-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (521, 38, 'Black', '42', 3, 'MZA-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (522, 39, 'Aura', '40', 4, 'KD16-AUR-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (523, 39, 'Aura', '41', 7, 'KD16-AUR-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (524, 39, 'Aura', '42', 11, 'KD16-AUR-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (525, 39, 'Aura', '43', 5, 'KD16-AUR-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (526, 39, 'Black', '40', 3, 'KD16-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (527, 39, 'Black', '41', 4, 'KD16-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (528, 39, 'Black', '42', 8, 'KD16-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (529, 39, 'Black', '43', 3, 'KD16-BLK-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (530, 39, 'White', '40', 2, 'KD16-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (531, 39, 'White', '41', 6, 'KD16-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (532, 39, 'White', '42', 9, 'KD16-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (533, 39, 'White', '43', 4, 'KD16-WHT-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (534, 40, 'White Red', '40', 9, 'HAR-WR-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (535, 40, 'White Red', '41', 14, 'HAR-WR-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (536, 40, 'White Red', '42', 10, 'HAR-WR-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (537, 40, 'White Red', '43', 5, 'HAR-WR-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (538, 40, 'Black Silver', '40', 5, 'HAR-BS-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (539, 40, 'Black Silver', '41', 8, 'HAR-BS-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (540, 40, 'Black Silver', '42', 6, 'HAR-BS-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (541, 40, 'Black Silver', '43', 3, 'HAR-BS-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (542, 41, 'White Blue', '40', 4, 'CUR-WB-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (543, 41, 'White Blue', '41', 6, 'CUR-WB-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (544, 41, 'White Blue', '42', 10, 'CUR-WB-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (545, 41, 'White Blue', '43', 4, 'CUR-WB-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (546, 41, 'Black Gold', '40', 3, 'CUR-BG-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (547, 41, 'Black Gold', '41', 8, 'CUR-BG-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (548, 41, 'Black Gold', '42', 12, 'CUR-BG-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (549, 41, 'Black Gold', '43', 5, 'CUR-BG-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (550, 42, 'Tahitian', '41', 3, 'LBR-TAH-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (551, 42, 'Tahitian', '42', 4, 'LBR-TAH-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (552, 42, 'Tahitian', '43', 7, 'LBR-TAH-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (553, 42, 'Tahitian', '44', 3, 'LBR-TAH-44', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (554, 42, 'Black', '41', 5, 'LBR-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (555, 42, 'Black', '42', 8, 'LBR-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (556, 42, 'Black', '43', 6, 'LBR-BLK-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (557, 42, 'Black', '44', 2, 'LBR-BLK-44', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (558, 43, 'Toxic Green', '39', 6, 'MB3-TXG-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (559, 43, 'Toxic Green', '40', 10, 'MB3-TXG-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (560, 43, 'Toxic Green', '41', 15, 'MB3-TXG-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (561, 43, 'Toxic Green', '42', 8, 'MB3-TXG-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (562, 43, 'Purple', '39', 4, 'MB3-PUR-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (563, 43, 'Purple', '40', 6, 'MB3-PUR-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (564, 43, 'Purple', '41', 9, 'MB3-PUR-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (565, 43, 'Purple', '42', 4, 'MB3-PUR-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (566, 43, 'Blue', '39', 3, 'MB3-BLU-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (567, 43, 'Blue', '40', 5, 'MB3-BLU-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (568, 43, 'Blue', '41', 7, 'MB3-BLU-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (569, 43, 'Blue', '42', 3, 'MB3-BLU-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (570, 44, 'Navy', '40', 8, 'TWO-NAV-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (571, 44, 'Navy', '41', 13, 'TWO-NAV-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (572, 44, 'Navy', '42', 10, 'TWO-NAV-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (573, 44, 'Navy', '43', 5, 'TWO-NAV-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (574, 44, 'Red', '40', 4, 'TWO-RED-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (575, 44, 'Red', '41', 7, 'TWO-RED-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (576, 44, 'Red', '42', 6, 'TWO-RED-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (577, 44, 'Red', '43', 3, 'TWO-RED-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (578, 45, 'Black', '38', 25, 'CAL-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (579, 45, 'Black', '39', 30, 'CAL-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (580, 45, 'Black', '40', 28, 'CAL-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (581, 45, 'Black', '41', 20, 'CAL-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (582, 45, 'Black', '42', 15, 'CAL-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (583, 45, 'Geode Teal', '38', 12, 'CAL-TEA-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (584, 45, 'Geode Teal', '39', 18, 'CAL-TEA-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (585, 45, 'Geode Teal', '40', 14, 'CAL-TEA-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (586, 45, 'Geode Teal', '41', 8, 'CAL-TEA-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (587, 45, 'Geode Teal', '42', 5, 'CAL-TEA-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (588, 45, 'White', '38', 10, 'CAL-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (589, 45, 'White', '39', 15, 'CAL-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (590, 45, 'White', '40', 20, 'CAL-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (591, 45, 'White', '41', 12, 'CAL-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (592, 45, 'White', '42', 7, 'CAL-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (593, 46, 'Magic Lime', '38', 8, 'ADL-LIM-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (594, 46, 'Magic Lime', '39', 15, 'ADL-LIM-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (595, 46, 'Magic Lime', '40', 22, 'ADL-LIM-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (596, 46, 'Magic Lime', '41', 18, 'ADL-LIM-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (597, 46, 'Magic Lime', '42', 10, 'ADL-LIM-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (598, 46, 'Black', '38', 12, 'ADL-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (599, 46, 'Black', '39', 20, 'ADL-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (600, 46, 'Black', '40', 25, 'ADL-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (601, 46, 'Black', '41', 16, 'ADL-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (602, 46, 'Black', '42', 9, 'ADL-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (603, 47, 'Checkerboard', '39', 12, 'VLC-CHK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (604, 47, 'Checkerboard', '40', 20, 'VLC-CHK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (605, 47, 'Checkerboard', '41', 14, 'VLC-CHK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (606, 47, 'Checkerboard', '42', 8, 'VLC-CHK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (607, 47, 'Black', '39', 10, 'VLC-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (608, 47, 'Black', '40', 16, 'VLC-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (609, 47, 'Black', '41', 11, 'VLC-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (610, 47, 'Black', '42', 5, 'VLC-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (611, 48, 'Black', '38', 12, 'LDC-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (612, 48, 'Black', '39', 18, 'LDC-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (613, 48, 'Black', '40', 25, 'LDC-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (614, 48, 'Black', '41', 16, 'LDC-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (615, 48, 'White', '38', 8, 'LDC-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (616, 48, 'White', '39', 10, 'LDC-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (617, 48, 'White', '40', 14, 'LDC-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (618, 48, 'White', '41', 8, 'LDC-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (619, 48, 'Navy', '38', 5, 'LDC-NAV-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (620, 48, 'Navy', '39', 7, 'LDC-NAV-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (621, 48, 'Navy', '40', 11, 'LDC-NAV-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (622, 48, 'Navy', '41', 6, 'LDC-NAV-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (623, 49, 'Black', '38', 14, 'NBS-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (624, 49, 'Black', '39', 20, 'NBS-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (625, 49, 'Black', '40', 28, 'NBS-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (626, 49, 'Black', '41', 22, 'NBS-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (627, 49, 'Black', '42', 15, 'NBS-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (628, 49, 'Grey', '38', 8, 'NBS-GRY-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (629, 49, 'Grey', '39', 12, 'NBS-GRY-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (630, 49, 'Grey', '40', 18, 'NBS-GRY-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (631, 49, 'Grey', '41', 14, 'NBS-GRY-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (632, 49, 'Grey', '42', 7, 'NBS-GRY-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (633, 50, 'White Blue', '40', 8, 'GR9-WB-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (634, 50, 'White Blue', '41', 12, 'GR9-WB-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (635, 50, 'White Blue', '42', 9, 'GR9-WB-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (636, 50, 'White Blue', '43', 4, 'GR9-WB-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (637, 50, 'Black Orange', '40', 5, 'GR9-BO-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (638, 50, 'Black Orange', '41', 8, 'GR9-BO-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (639, 50, 'Black Orange', '42', 6, 'GR9-BO-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (640, 50, 'Black Orange', '43', 3, 'GR9-BO-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (641, 51, 'White', '36', 10, 'ZVP-WHT-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (642, 51, 'White', '37', 15, 'ZVP-WHT-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (643, 51, 'White', '38', 8, 'ZVP-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (644, 51, 'White', '39', 4, 'ZVP-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (645, 51, 'Pink', '36', 6, 'ZVP-PNK-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (646, 51, 'Pink', '37', 11, 'ZVP-PNK-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (647, 51, 'Pink', '38', 7, 'ZVP-PNK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (648, 51, 'Pink', '39', 3, 'ZVP-PNK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (649, 52, 'Black', '40', 7, 'BAR-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (650, 52, 'Black', '41', 11, 'BAR-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (651, 52, 'Black', '42', 9, 'BAR-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (652, 52, 'Black', '43', 4, 'BAR-BLK-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (653, 52, 'White Green', '40', 5, 'BAR-WG-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (654, 52, 'White Green', '41', 8, 'BAR-WG-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (655, 52, 'White Green', '42', 6, 'BAR-WG-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (656, 52, 'White Green', '43', 3, 'BAR-WG-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (657, 53, 'White Pink', '36', 8, 'LAV-WP-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (658, 53, 'White Pink', '37', 13, 'LAV-WP-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (659, 53, 'White Pink', '38', 10, 'LAV-WP-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (660, 53, 'White Pink', '39', 5, 'LAV-WP-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (661, 53, 'Navy', '36', 4, 'LAV-NAV-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (662, 53, 'Navy', '37', 9, 'LAV-NAV-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (663, 53, 'Navy', '38', 7, 'LAV-NAV-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (664, 53, 'Navy', '39', 3, 'LAV-NAV-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (665, 54, 'Black', '40', 11, 'MET-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (666, 54, 'Black', '41', 17, 'MET-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (667, 54, 'Black', '42', 13, 'MET-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (668, 54, 'Black', '43', 7, 'MET-BLK-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (669, 54, 'White', '40', 6, 'MET-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (670, 54, 'White', '41', 9, 'MET-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (671, 54, 'White', '42', 5, 'MET-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (672, 54, 'White', '43', 3, 'MET-WHT-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (673, 54, 'Olive', '40', 4, 'MET-OLV-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (674, 54, 'Olive', '41', 7, 'MET-OLV-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (675, 54, 'Olive', '42', 8, 'MET-OLV-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (676, 54, 'Olive', '43', 2, 'MET-OLV-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (677, 55, 'Black', '38', 5, 'NNX-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (678, 55, 'Black', '39', 9, 'NNX-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (679, 55, 'Black', '40', 15, 'NNX-BLK-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (680, 55, 'Black', '41', 12, 'NNX-BLK-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (681, 55, 'Black', '42', 7, 'NNX-BLK-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (682, 55, 'White', '38', 3, 'NNX-WHT-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (683, 55, 'White', '39', 6, 'NNX-WHT-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (684, 55, 'White', '40', 10, 'NNX-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (685, 55, 'White', '41', 8, 'NNX-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (686, 55, 'White', '42', 4, 'NNX-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (687, 56, 'Black Grey', '40', 8, 'TBR-BG-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (688, 56, 'Black Grey', '41', 13, 'TBR-BG-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (689, 56, 'Black Grey', '42', 10, 'TBR-BG-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (690, 56, 'Black Grey', '43', 5, 'TBR-BG-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (691, 56, 'White', '40', 4, 'TBR-WHT-40', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (692, 56, 'White', '41', 7, 'TBR-WHT-41', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (693, 56, 'White', '42', 6, 'TBR-WHT-42', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (694, 56, 'White', '43', 3, 'TBR-WHT-43', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (695, 57, 'White Pink', '36', 12, 'FUS-WP-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (696, 57, 'White Pink', '37', 18, 'FUS-WP-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (697, 57, 'White Pink', '38', 14, 'FUS-WP-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (698, 57, 'White Pink', '39', 7, 'FUS-WP-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (699, 57, 'Black', '36', 6, 'FUS-BLK-36', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (700, 57, 'Black', '37', 10, 'FUS-BLK-37', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (701, 57, 'Black', '38', 8, 'FUS-BLK-38', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (702, 57, 'Black', '39', 4, 'FUS-BLK-39', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (703, 58, 'Default', 'One Size', 50, 'KIT-DEF-OS', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (704, 59, 'Default', 'One Size', 80, 'NANO-DEF-OS', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (705, 60, 'Multi', 'M (39-42)', 35, 'SOX-MUL-M', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `product_variants` VALUES (706, 60, 'Multi', 'L (43-46)', 28, 'SOX-MUL-L', NULL, '2026-06-15 16:28:15', '2026-06-15 16:28:15');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `price` double NOT NULL,
  `old_price` double NULL DEFAULT NULL,
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `category_id` int NOT NULL,
  `brand_id` int NOT NULL,
  `active` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_products_category`(`category_id` ASC) USING BTREE,
  INDEX `fk_products_brand`(`brand_id` ASC) USING BTREE,
  CONSTRAINT `fk_products_brand` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Nike Air Zoom Pegasus 40', 'Giày chạy bộ Nike Air Zoom Pegasus 40 êm ái, phù hợp chạy bộ hằng ngày.', 2990000, 3490000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/air-zoom-pegasus-40-older-road-running-shoes-jqwr5f.jpg', 'men', 1, 1, 1, '2025-12-11 23:45:43', '2026-01-15 00:02:02');
INSERT INTO `products` VALUES (2, 'Adidas Ultraboost Light', 'Giày chạy bộ Adidas Ultraboost Light đệm Boost nhẹ và đàn hồi.', 3590000, 3990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'men', 1, 2, 1, '2025-12-11 23:45:43', '2026-01-16 04:16:01');
INSERT INTO `products` VALUES (3, 'Nike Mercurial Vapor 15 Elite', 'Giày đá bóng Nike Mercurial Vapor 15 Elite cho sân cỏ nhân tạo.', 4290000, 5490000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'men', 2, 1, 1, '2025-12-11 23:45:43', '2026-01-16 04:18:58');
INSERT INTO `products` VALUES (4, 'Adidas Predator Accuracy.', 'Giày đá bóng Adidas Predator Accuracy. kiểm soát bóng tốt.', 4290000, 4690000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'men', 2, 2, 1, '2025-12-11 23:45:43', '2026-01-16 04:37:04');
INSERT INTO `products` VALUES (5, 'Nike Lebron Witness 8', 'Giày bóng rổ Nike Lebron Witness 8 hỗ trợ cổ chân và bật nhảy.', 3290000, 3990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', 'men', 3, 1, 1, '2025-12-11 23:45:43', '2026-01-16 04:34:45');
INSERT INTO `products` VALUES (6, 'Puma All Pro Nitro', 'Giày bóng rổ Puma All Pro Nitro nhẹ, bám sân tốt.', 2690000, 3290000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'men', 3, 3, 1, '2025-12-11 23:45:43', '2026-01-16 04:31:45');
INSERT INTO `products` VALUES (7, 'Converse Chuck Taylor All Star', 'Giày sneaker Converse Chuck Taylor All Star cổ điển.', 1590000, 1990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'unisex', 4, 5, 1, '2025-12-11 23:45:43', '2026-01-16 04:29:04');
INSERT INTO `products` VALUES (8, 'Vans Old Skool Classic', 'Giày sneaker Vans Old Skool Classic cho phong cách streetwear.', 1690000, 1990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-superstar-fv3290-01.jpg', 'unisex', 4, 6, 1, '2025-12-11 23:45:43', '2026-01-16 04:25:18');
INSERT INTO `products` VALUES (9, 'Asics Gel-Nimbus 26', 'Giày chạy bộ Asics Gel-Nimbus 26 hỗ trợ long run.', 4490000, 4990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-ultraboost-20-eg0713-01.jpg', 'women', 1, 7, 1, '2025-12-11 23:45:43', '2026-01-16 04:22:33');
INSERT INTO `products` VALUES (10, 'Mizuno Wave Rider 27', 'Giày chạy bộ Mizuno Wave Rider 27 cân bằng giữa êm và phản hồi lực.', 2990000, 3490000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'men', 1, 10, 1, '2025-12-11 23:45:43', '2026-01-16 04:07:28');
INSERT INTO `products` VALUES (11, 'Nike Air Force 1 \'07 Triple White', '<h3>NIKE AIR FORCE 1 \'07 - BIỂU TƯỢNG SNEAKER VƯỢT THỜI GIAN</h3>\n<p>Ra mắt lần đầu năm 1982, Nike Air Force 1 là đôi giày bóng rổ <strong>ĐẦU TIÊN</strong> trên thế giới sử dụng công nghệ đệm khí Nike Air. Trải qua hơn 40 năm, AF1 đã vượt ra khỏi sân bóng rổ để trở thành biểu tượng văn hóa đường phố được hàng triệu người yêu thích trên toàn cầu.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Chất liệu Upper:</strong> Da tổng hợp cao cấp full-grain, mềm mại nhưng vô cùng bền bỉ, càng đi càng đẹp theo thời gian</li>\n  <li><strong>Đế giữa (Midsole):</strong> Bọt đệm Nike Air ẩn bên trong gót chân, mang lại cảm giác êm ái suốt cả ngày dài đi bộ hay đứng làm việc</li>\n  <li><strong>Đế ngoài (Outsole):</strong> Cao su nguyên khối với các vòng tròn pivot xoay đặc trưng, bám đường cực tốt trên mọi bề mặt</li>\n  <li><strong>Thiết kế:</strong> Cổ thấp linh hoạt, lưỡi gà dày dặn êm ái, dễ dàng phối đồ từ quần jeans, jogger đến chân váy</li>\n  <li><strong>Màu sắc:</strong> Trắng tinh khôi (Triple White) - phối được với literally mọi outfit</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>AF1 có form <strong>hơi rộng hơn 0.5 size</strong> so với chuẩn. Nếu bàn chân bạn thon hoặc vừa, nên chọn <strong>giảm 0.5 size</strong> so với size thường mang. Ví dụ: bạn thường đi size 42 thì nên chọn 41.5 hoặc 41.</p>\n\n<h3>✅ CAM KẾT CHÍNH HÃNG 100%</h3>\n<p>Sản phẩm chính hãng Nike, đầy đủ hộp + tag + giấy gói. Bảo hành keo đế 6 tháng. Hỗ trợ đổi size miễn phí trong 7 ngày nếu giày chưa qua sử dụng ngoài trời.</p>', 2950000, 3200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'unisex', 4, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (12, 'Adidas Samba OG Black White', '<h3>ADIDAS SAMBA OG - HUYỀN THOẠI TRỞ LẠI TỪ SÂN CỎ</h3>\n<p>Ban đầu được thiết kế cho các cầu thủ bóng đá tập luyện trên nền đất đông cứng của mùa đông nước Đức những năm 1950, Adidas Samba nay đã trở thành <strong>đôi giày bán chạy nhất lịch sử Adidas</strong> và là must-have item trong tủ giày của mọi tín đồ thời trang.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Upper:</strong> Da thật kết hợp da lộn (suede) ở mũi chữ T đặc trưng, tạo nên vẻ ngoài sang trọng đậm chất vintage</li>\n  <li><strong>Đế ngoài:</strong> Cao su gum (gum sole) màu nâu caramel nguyên bản, bám cực tốt và tạo điểm nhấn thẩm mỹ tuyệt vời</li>\n  <li><strong>Lưỡi gà:</strong> Có logo Samba dập nổi bằng vàng gold, chi tiết nhỏ nhưng đẳng cấp</li>\n  <li><strong>Lót giày:</strong> OrthoLite mềm mại, thấm hút mồ hôi và chống vi khuẩn</li>\n  <li><strong>Phong cách:</strong> Versatile - phù hợp từ outfit đi học, đi làm văn phòng casual cho đến đi chơi cuối tuần</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Samba OG có form <strong>True to Size (TTS)</strong>, bạn chọn đúng size thường mang là vừa. Bàn chân bè nên tăng 0.5 size.</p>\n\n<h3>🎁 ĐẶC QUYỀN KHI MUA TẠI SHOP</h3>\n<p>Tặng kèm 1 đôi dây giày phụ màu trắng. Miễn phí vệ sinh giày trọn đời khi mua tại cửa hàng. Đổi trả dễ dàng trong 7 ngày.</p>', 2800000, NULL, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-superstar-fv3290-01.jpg', 'unisex', 4, 2, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (13, 'New Balance 550 White Green', '<h3>NEW BALANCE 550 - HUYỀN THOẠI BÓNG RỔ THẬP NIÊN 80 TRỞ LẠI</h3>\n<p>Được thiết kế lần đầu vào năm 1989 như một đôi giày thi đấu bóng rổ, New Balance 550 đã im hơi lặng tiếng suốt nhiều thập kỷ trước khi được hồi sinh vào năm 2021 và ngay lập tức trở thành <strong>cơn sốt toàn cầu</strong> nhờ phong cách retro-chunky cuốn hút.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Upper:</strong> Da tổng hợp cao cấp phối cùng các tấm đục lỗ (perforated panels) giúp thoáng khí xuất sắc ngay cả khi đi cả ngày</li>\n  <li><strong>Thiết kế đế:</strong> Đế giữa dày dặn phong cách chunky retro tạo thêm chiều cao ~3cm một cách tự nhiên không bị lố</li>\n  <li><strong>Logo:</strong> Chữ N cỡ lớn hai bên hông - điểm nhận diện thương hiệu New Balance không lẫn vào đâu được</li>\n  <li><strong>Cổ giày:</strong> Đệm foam dày ôm gót cực chắc, không bị tuột gót khi đi bộ nhanh</li>\n  <li><strong>Đế ngoài:</strong> Cao su chống mài mòn, các rãnh xẻ flex grooves hỗ trợ gập bàn chân tự nhiên</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>NB 550 có form <strong>hơi rộng</strong> theo truyền thống của New Balance. Chân thon nên giảm 0.5 size, chân bè đi đúng size.</p>\n\n<h3>✅ CAM KẾT</h3>\n<p>Hàng chính hãng New Balance, check code trên website hãng được. Full box + phụ kiện. Bảo hành keo 6 tháng.</p>', 3400000, 3800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/x-plr-shoes-beige-by9255-01-standard-1.jpg', 'unisex', 4, 4, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (14, 'Puma Palermo Leather Vintage', '<h3>PUMA PALERMO - PHONG CÁCH TERRACE TỪ NƯỚC Ý</h3>\n<p>Lấy cảm hứng từ văn hóa bóng đá và phong cách terrace casual của các cổ động viên Ý những năm 80-90, Puma Palermo mang đến vẻ đẹp thanh lịch, tinh tế mà không kém phần cá tính. Đây là mẫu giày đang được <strong>các fashionista và KOLs săn lùng nhiều nhất</strong> trong năm nay.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Upper:</strong> Da lộn (suede) mềm mịn như nhung kết hợp lưới mesh bên hông tạo vẻ vintage đầy cuốn hút</li>\n  <li><strong>Đế gum:</strong> Cao su gum dày nguyên khối tông nâu ấm - đặc trưng nhận diện của dòng Palermo</li>\n  <li><strong>Logo:</strong> Formstrip Puma thêu tinh xảo bên hông cùng thẻ tag đặc trưng gắn ở lưỡi gà</li>\n  <li><strong>Trọng lượng:</strong> Siêu nhẹ chỉ ~280g mỗi chiếc, đi cả ngày không mỏi chân</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Puma Palermo có form <strong>True to Size</strong>. Nữ giới lưu ý chọn theo bảng size nữ của Puma.</p>\n\n<h3>✅ CHÍNH SÁCH BÁN HÀNG</h3>\n<p>Cam kết chính hãng Puma. Full box đẹp, sẵn sàng làm quà tặng. Đổi size miễn phí trong 7 ngày.</p>', 2500000, 2800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'women', 4, 3, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (15, 'Converse Chuck 70 Hi Black', '<h3>CONVERSE CHUCK 70 HIGH TOP - BẢN NÂNG CẤP CỦA HUYỀN THOẠI</h3>\n<p>Chuck 70 là phiên bản <strong>cao cấp nhất</strong> trong dòng Chuck Taylor All Star, tái hiện lại chính xác thiết kế nguyên bản từ thập niên 1970. So với bản Chuck Taylor thường, Chuck 70 sở hữu chất liệu canvas dày hơn 30%, đệm êm hơn gấp đôi, và các chi tiết hoàn thiện tinh xảo hơn hẳn.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Canvas:</strong> Vải bố 10oz dày dặn, bền bỉ hơn hẳn Chuck Taylor thường, màu sắc sâu và đồng nhất hơn</li>\n  <li><strong>Đế:</strong> Đế cao su egret (trắng ngà) vintage thay vì trắng sáng, tạo cảm giác hoài cổ đặc trưng</li>\n  <li><strong>Đệm lót:</strong> OrthoLite cushion lót trong, êm ái vượt trội so với lót giày bình thường của Converse</li>\n  <li><strong>Chi tiết:</strong> Logo All Star dập nhiệt ở gót, patch gót dày hơn, ốp mắt cáo bằng kim loại nặng</li>\n  <li><strong>Cổ giày:</strong> High-top bảo vệ cổ chân, có thể gập xuống tạo phong cách khác biệt</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Chuck 70 có form <strong>dài và hẹp</strong>. Hầu hết mọi người nên chọn <strong>giảm 1 full size</strong> so với giày thể thao Nike/Adidas. Ví dụ: Nike bạn đi 42 thì Converse nên chọn 41.</p>\n\n<h3>✅ CAM KẾT</h3>\n<p>Chính hãng Converse, full box. Tặng kèm 1 đôi dây giày phụ. Bảo hành 6 tháng.</p>', 1890000, 2100000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'unisex', 4, 5, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (16, 'Vans Old Skool Classic Black White', '<h3>VANS OLD SKOOL - ĐÔI GIÀY STREETWEAR KINH ĐIỂN</h3>\n<p>Vans Old Skool là mẫu giày đầu tiên của Vans sử dụng đường kẻ sọc Jazz Stripe nổi tiếng (hay còn gọi là Sidestripe) - biểu tượng mà ngày nay ai cũng nhận ra. Ra mắt năm 1977, Old Skool nhanh chóng trở thành đôi giày gắn liền với văn hóa skateboard, punk rock và thời trang đường phố toàn cầu.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Upper:</strong> Kết hợp hoàn hảo giữa da lộn (suede) ở mũi giày và vải canvas ở thân giày, vừa bền vừa thoáng khí</li>\n  <li><strong>Jazz Stripe:</strong> Đường kẻ sọc trắng signature chạy dọc hai bên hông - biểu tượng không thể thiếu</li>\n  <li><strong>Đế waffle:</strong> Đế cao su waffle nguyên bản của Vans, bám đường cực tốt kể cả trên bề mặt trơn ướt</li>\n  <li><strong>Cổ giày:</strong> Đệm padded collar dày dặn ôm gót ấm áp, thoải mái không bị cọ xát</li>\n  <li><strong>Trọng lượng:</strong> Nhẹ, linh hoạt, phù hợp đi bộ, đi chơi và cả skateboarding</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Vans Old Skool có form <strong>True to Size</strong>. Nếu phân vân giữa 2 size, nên chọn size lớn hơn vì canvas sẽ ôm dần theo bàn chân.</p>\n\n<h3>✅ CAM KẾT</h3>\n<p>Hàng Vans chính hãng. Full box, thẻ bảo hành. Hỗ trợ đổi size 7 ngày.</p>', 1690000, 1890000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'unisex', 4, 6, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (17, 'Nike Dunk Low Retro Panda', '<h3>NIKE DUNK LOW RETRO \"PANDA\" - ĐÔI GIÀY HOT NHẤT HÀNH TINH</h3>\n<p>Nike Dunk Low Retro phối màu Panda (Đen Trắng) là <strong>đôi giày bán chạy nhất toàn cầu</strong> trong 3 năm liên tiếp. Thiết kế phối 2 tone đen-trắng đơn giản nhưng cuốn hút khó cưỡng, phù hợp với mọi phong cách thời trang từ tối giản đến phá cách.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Upper:</strong> Da tổng hợp premium, overlay đen nổi bật trên nền trắng tạo hiệu ứng thị giác mạnh mẽ</li>\n  <li><strong>Đế giữa:</strong> Foam nhẹ mang lại cảm giác thoải mái cho việc đi bộ hằng ngày</li>\n  <li><strong>Đế ngoài:</strong> Cao su bền bỉ với rãnh pivot tròn di sản từ phiên bản gốc năm 1985</li>\n  <li><strong>Lưỡi gà:</strong> Dày dặn, có đệm foam mềm mại ôm chân vừa vặn</li>\n  <li><strong>Cổ giày:</strong> Low-top thoải mái, cổ chân linh hoạt khi di chuyển</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Dunk Low Retro có form <strong>True to Size đến hơi chật 0.5</strong>. Chân bè nên tăng thêm 0.5 size để thoải mái hơn.</p>\n\n<h3>⚠️ LƯU Ý QUAN TRỌNG</h3>\n<p>Do quá hot, thị trường có rất nhiều hàng nhái/fake. Sản phẩm tại shop cam kết 100% chính hãng, kèm hóa đơn mua hàng từ Nike Vietnam. Bạn có thể check barcode trực tiếp trên app Nike.</p>', 3100000, 3500000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-1.jpg', 'unisex', 4, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (18, 'Adidas Gazelle Bold Platform Green', '<h3>ADIDAS GAZELLE BOLD - PHIÊN BẢN ĐẾ TĂNG CHIỀU CAO CHO NỮ</h3>\n<p>Adidas Gazelle Bold là biến thể đặc biệt dành riêng cho phái nữ của dòng Gazelle huyền thoại. Điểm khác biệt lớn nhất là phần đế platform dày hơn, giúp tăng thêm <strong>khoảng 4cm chiều cao</strong> một cách tự nhiên và thời trang. Phong cách Y2K retro đang cực kỳ được ưa chuộng.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Upper:</strong> Da lộn suede premium mềm mịn, phối màu xanh rêu cực kỳ đặc biệt và hiếm trên thị trường</li>\n  <li><strong>Đế Bold:</strong> Platform rubber dày ~4cm, tăng chiều cao tự nhiên mà vẫn đi êm, không nặng nề</li>\n  <li><strong>3-Stripes:</strong> Ba sọc Adidas đặc trưng bằng da lộn tông-sur-tông sang trọng</li>\n  <li><strong>Lót OrthoLite:</strong> Đệm lót êm ái, thấm hút mồ hôi, chống mùi hiệu quả cả ngày</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Gazelle Bold form <strong>hơi nhỏ 0.5 size</strong> so với chuẩn. Nên chọn tăng 0.5 size. Bảng size nữ Adidas (EU): 36, 37, 38, 39, 40.</p>\n\n<h3>✅ CAM KẾT</h3>\n<p>Chính hãng Adidas Originals. Full box cao cấp. Tặng kèm túi dustbag bảo quản giày.</p>', 3200000, 3600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-falcon-w-ef4988-01.jpg', 'women', 4, 2, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (19, 'New Balance 2002R Protection Pack Grey', '<h3>NEW BALANCE 2002R PROTECTION PACK - SIÊU PHẨM \"CHÁY HÀNG\" TOÀN CẦU</h3>\n<p>New Balance 2002R Protection Pack là phiên bản giới hạn gây bão cộng đồng sneakerhead toàn thế giới. Lấy cảm hứng từ ý tưởng bảo vệ đôi giày mới mua, phiên bản này có các lớp bảo vệ bọc quanh upper tạo nên vẻ ngoài <strong>deconstructed (giải cấu trúc)</strong> cực kỳ độc đáo.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Thiết kế:</strong> Các tấm da lộn xám bạc xếp chồng lên nhau tạo hiệu ứng 3D độc nhất vô nhị</li>\n  <li><strong>Đệm ABZORB:</strong> Công nghệ hấp thụ lực va chạm hàng đầu của New Balance ở phần gót</li>\n  <li><strong>N-ERGY:</strong> Lớp đệm thứ hai ở phần mũi chân giúp hoàn trả năng lượng khi bước đi</li>\n  <li><strong>Đế ENCAP:</strong> Khung nhựa TPU bao quanh phần đế giữa tăng cường độ ổn định</li>\n  <li><strong>Trọng lượng:</strong> ~340g, nhẹ hơn so với ngoại hình chunky</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>NB 2002R có form <strong>rộng thoải mái</strong> đặc trưng của New Balance. Chân thon nên giảm 0.5 size.</p>\n\n<h3>✅ CAM KẾT</h3>\n<p>Chính hãng New Balance. Full box + giấy gói + tag. Bảo hành keo 6 tháng.</p>', 4200000, 4800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-1.jpg', 'men', 4, 4, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (20, 'Converse Run Star Hike Platform', '<h3>CONVERSE RUN STAR HIKE - CHUCK TAYLOR PHIÊN BẢN \"BIẾN HÌNH\"</h3>\n<p>Run Star Hike là phiên bản táo bạo nhất trong gia đình Chuck Taylor. Giữ nguyên DNA canvas cổ điển của Converse nhưng <strong>nâng đế lên thành platform zigzag cực kỳ bắt mắt</strong>, tạo nên sự kết hợp hoàn hảo giữa di sản và hiện đại. Đây là lựa chọn yêu thích của nhiều ngôi sao và influencer.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Đế Hike:</strong> Platform zigzag tăng chiều cao ~5cm, thiết kế răng cưa độc đáo, bám đường tốt</li>\n  <li><strong>Canvas:</strong> Vải bố 10oz chuẩn Converse, bền đẹp theo thời gian</li>\n  <li><strong>Đệm:</strong> CX Foam mềm mại giúp đi thoải mái hơn Chuck Taylor truyền thống rất nhiều</li>\n  <li><strong>Thiết kế:</strong> High-top với 2 tầng lỗ xỏ dây tạo điểm nhấn thị giác</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Giống Chuck Taylor, nên chọn <strong>giảm 1 size</strong> so với giày thể thao. Phù hợp đặc biệt cho các bạn nữ muốn hack chiều cao.</p>', 2400000, 2700000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'women', 4, 5, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (21, 'Vans SK8-Hi Tapered Black', '<h3>VANS SK8-HI TAPERED - CỔ CAO HUYỀN THOẠI</h3>\n<p>SK8-Hi (đọc là \"Skate High\") là mẫu giày cổ cao mang tính biểu tượng nhất của Vans, ra mắt năm 1978 dành cho các vận động viên trượt ván. Phiên bản Tapered được thu gọn form dáng, <strong>mảnh mai hơn bản gốc 15%</strong>, phù hợp cho cả nam và nữ.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Upper:</strong> Suede + Canvas kết hợp, cổ cao bảo vệ mắt cá chân khi vận động</li>\n  <li><strong>Jazz Stripe:</strong> Sọc trắng signature chạy từ mắt cá lên đến mũi giày</li>\n  <li><strong>Đế waffle:</strong> Cao su vulcanized bám dính cực tốt, chuẩn cho skateboarding</li>\n  <li><strong>Tapered:</strong> Form dáng thon gọn hơn SK8-Hi classic, không bị cồng kềnh</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>SK8-Hi Tapered có form <strong>True to Size</strong>. Cổ cao nên ban đầu có thể hơi chật, sau vài ngày đi sẽ mềm dần.</p>', 1990000, 2200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'unisex', 4, 6, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (22, 'Puma Suede Classic XXI Navy', '<h3>PUMA SUEDE CLASSIC XXI - DA LỘN KINH ĐIỂN TỪ NĂM 1968</h3>\n<p>Puma Suede là một trong những đôi giày có tuổi đời lâu nhất trong lịch sử sneaker, ra mắt từ năm 1968 với tên gọi ban đầu là \"Crack\". Phiên bản Classic XXI (21st Century) giữ nguyên vẻ đẹp nguyên bản nhưng được cải tiến về mặt thoải mái và bền bỉ.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Suede:</strong> Da lộn cao cấp toàn bộ upper, mềm mịn và có độ bóng satin nhẹ đẹp mắt</li>\n  <li><strong>Formstrip:</strong> Dải logo Puma trắng tương phản với nền xanh navy tạo điểm nhấn mạnh mẽ</li>\n  <li><strong>Đế:</strong> Cao su phẳng bám tốt, phù hợp đi bộ trên mọi bề mặt</li>\n  <li><strong>Lót SoftFoam+:</strong> Đệm lót Puma độc quyền, êm ái thoải mái suốt cả ngày</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Puma Suede Classic có form <strong>chuẩn size</strong>. Chọn đúng size thường mang.</p>', 1800000, 2100000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'men', 4, 3, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (23, 'Nike ZoomX Vaporfly NEXT% 3', '<h3>NIKE ZOOMX VAPORFLY NEXT% 3 - SIÊU GIÀY PHÁ KỶ LỤC MARATHON</h3>\n<p>Vaporfly NEXT% 3 là đôi giày đua marathon <strong>nhanh nhất thế giới</strong>. Đây chính là đôi giày mà Eliud Kipchoge đã mang khi phá kỷ lục marathon sub-2 giờ lịch sử. Phiên bản thứ 3 được tinh chỉnh hoàn hảo với upper mới nhẹ hơn và đế ZoomX cải tiến hoàn trả năng lượng lên đến 85%.</p>\n\n<h3>🔥 CÔNG NGHỆ ĐỈNH CAO</h3>\n<ul>\n  <li><strong>ZoomX Foam:</strong> Loại bọt đệm nhẹ nhất và đàn hồi nhất từng được Nike tạo ra, hoàn trả năng lượng lên đến 85%</li>\n  <li><strong>Carbon Plate:</strong> Đĩa sợi carbon toàn chiều dài tạo hiệu ứng đòn bẩy tại mỗi bước chạy, giúp bạn tiết kiệm năng lượng đáng kể</li>\n  <li><strong>Upper Flyknit:</strong> Vải dệt Flyknit thế hệ mới siêu mỏng, siêu nhẹ, ôm chân như đôi tất</li>\n  <li><strong>Trọng lượng:</strong> Chỉ ~188g (size 42) - nhẹ đến mức bạn quên mình đang mang giày</li>\n  <li><strong>Drop:</strong> 8mm (gót cao hơn mũi 8mm) - tối ưu cho kiểu chạy forefoot/midfoot</li>\n</ul>\n\n<h3>🏃 PHÙ HỢP VỚI AI?</h3>\n<p>Dành cho runner nghiêm túc muốn phá PB (Personal Best) trong các giải marathon, half-marathon, hoặc các buổi chạy tempo quan trọng. <strong>Không khuyến khích</strong> dùng cho tập luyện hằng ngày vì tuổi thọ đế giới hạn ~400km.</p>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Vaporfly NEXT% 3 có form <strong>ôm chân</strong>. Nên chọn <strong>tăng 0.5 size</strong> so với size thường mang, đặc biệt nếu bạn chạy đường dài (chân sẽ phình ra khi chạy lâu).</p>', 6500000, 6800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-plus-pegasus-plus-trail-plus-5-plus-gs.jpg', 'men', 1, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (24, 'Adidas Adizero Boston 12', '<h3>ADIDAS ADIZERO BOSTON 12 - GIÀY TẬP LUYỆN CỦA DÂN CHẠY CHUYÊN NGHIỆP</h3>\n<p>Adizero Boston 12 là đôi giày \"daily trainer\" (tập luyện hằng ngày) mang DNA đua tốc độ từ dòng Adizero Elite. Nếu Vaporfly là giày ngày race day, thì Boston 12 chính là người bạn đồng hành <strong>trung thành trong mọi buổi tập</strong> của bạn.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Lightstrike Pro:</strong> Đệm gót bằng vật liệu siêu nhẹ Lightstrike Pro - cùng chất liệu với giày đua Adizero Adios Pro</li>\n  <li><strong>Energyrods 2.0:</strong> 5 thanh sợi thủy tinh ở đế giữa giúp chuyển tiếp bước chạy mượt mà từ gót đến mũi</li>\n  <li><strong>Upper Mesh:</strong> Lưới kỹ thuật nhẹ, thoáng khí cực kỳ trong điều kiện nóng ẩm Việt Nam</li>\n  <li><strong>Continental Outsole:</strong> Đế ngoài cao su Continental (hãng lốp xe hơi) bám đường siêu tốt kể cả khi ướt</li>\n  <li><strong>Trọng lượng:</strong> ~240g (size 42)</li>\n</ul>\n\n<h3>🏃 PHÙ HỢP VỚI AI?</h3>\n<p>Runner muốn 1 đôi giày \"do-it-all\" - chạy easy run, tempo, interval đều xử lý ngon lành. Bền bỉ cho khoảng 800-1000km.</p>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Boston 12 có form <strong>True to Size</strong>. Nên chọn đúng size thường mang.</p>', 3900000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'women', 1, 2, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (25, 'Asics Novablast 4', '<h3>ASICS NOVABLAST 4 - CHẠY TRÊN MÂY, NẢY NHƯ TRAMPOLINE</h3>\n<p>Novablast 4 là đôi giày chạy bộ \"vui nhất\" của Asics. Nếu bạn đang tìm một đôi giày mang lại <strong>cảm giác bouncy (nảy) cực kỳ thú vị</strong> ở mỗi bước chạy, thì đây chính là lựa chọn hoàn hảo. Nhiều runner mô tả cảm giác đi Novablast như đang nhún trên bạt trampoline.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>FF BLAST PLUS ECO:</strong> Bọt đệm mới nhất của Asics, nhẹ hơn 20% và nảy hơn 15% so với thế hệ trước, được làm từ nguyên liệu tái chế thân thiện môi trường</li>\n  <li><strong>Thiết kế đế Trampoline:</strong> Hình dạng đế lấy cảm hứng từ bạt nhún, cong ở cả mũi và gót tạo độ nảy tự nhiên</li>\n  <li><strong>Upper Mesh:</strong> Lưới kỹ thuật jacquard thoáng khí, hỗ trợ tốt mà không tạo cảm giác bó chặt</li>\n  <li><strong>AHAR Outsole:</strong> Cao su chống mài mòn AHAR ở những vùng tiếp đất chính, tăng tuổi thọ đế</li>\n  <li><strong>Drop:</strong> 8mm | Trọng lượng: ~260g (size 42)</li>\n</ul>\n\n<h3>🏃 PHÙ HỢP VỚI AI?</h3>\n<p>Người mới bắt đầu chạy bộ đến runner trung cấp. Tuyệt vời cho easy run, recovery run và chạy bộ giải trí cuối tuần.</p>', 4300000, 4600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'men', 1, 7, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (26, 'New Balance FuelCell SC Elite v4', '<h3>NEW BALANCE FUELCELL SC ELITE V4 - ĐỐI THỦ XỨNG TẦM CỦA VAPORFLY</h3>\n<p>FuelCell SC Elite v4 là câu trả lời mạnh mẽ của New Balance trước sự thống trị của Nike trong phân khúc giày đua carbon plate. Được <strong>nhiều VĐV chuyên nghiệp lựa chọn</strong> trong các giải marathon lớn trên thế giới.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>FuelCell Foam:</strong> Bọt đệm nitrogen-infused siêu nhẹ và đàn hồi cao, hoàn trả năng lượng ấn tượng</li>\n  <li><strong>Carbon Fiber Plate:</strong> Đĩa sợi carbon toàn chiều dài với hình dạng spoon (thìa) tối ưu cho đòn bẩy</li>\n  <li><strong>Upper FantomFit:</strong> Lớp da tổng hợp siêu mỏng hàn nhiệt trực tiếp lên mesh, giảm trọng lượng tối đa</li>\n  <li><strong>Trọng lượng:</strong> ~195g (size 42) - nhẹ bậc nhất phân khúc</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>SC Elite v4 có form <strong>hơi hẹp ở phần midfoot</strong>. Nên tăng 0.5 size nếu chân bè.</p>', 5800000, 6200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'men', 1, 4, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (27, 'Nike Pegasus 41', '<h3>NIKE PEGASUS 41 - ĐÔI GIÀY CHẠY BỘ BÁN CHẠY NHẤT MỌI THỜI ĐẠI</h3>\n<p>Dòng Pegasus đã trải qua 41 đời nâng cấp kể từ năm 1983, biến nó trở thành <strong>dòng giày chạy bộ có tuổi đời dài nhất và bán chạy nhất</strong> trong lịch sử Nike. Pegasus 41 tiếp tục sứ mệnh là đôi giày \"cho tất cả mọi người\" - từ người mới bắt đầu đến runner lão luyện.</p>\n\n<h3>🔥 NÂNG CẤP MỚI Ở PHIÊN BẢN 41</h3>\n<ul>\n  <li><strong>React X Foam:</strong> Đệm React X mới nhẹ hơn 13% và hoàn trả năng lượng nhiều hơn 13% so với React cũ</li>\n  <li><strong>Air Zoom:</strong> Đơn vị Zoom Air ở mũi chân cho cảm giác phản hồi lực nhanh khi đẩy bước</li>\n  <li><strong>Flywire:</strong> Dây cáp Flywire ôm chân tùy chỉnh theo cách buộc dây</li>\n  <li><strong>Waffle Outsole:</strong> Đế ngoài waffle cải tiến bám đường tốt trên cả mặt đường khô và ướt</li>\n  <li><strong>Trọng lượng:</strong> ~275g (size 42) | Drop: 10mm</li>\n</ul>\n\n<h3>🏃 PHÙ HỢP VỚI AI?</h3>\n<p>Mọi đối tượng. Pegasus là đôi giày chạy bộ toàn năng nhất: easy run, long run, tempo run đều ổn. Đặc biệt phù hợp cho người mới bắt đầu chạy bộ.</p>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Pegasus 41 có form <strong>True to Size</strong>. Rất dễ chọn size, hầu hết mọi người đều vừa với size thường mang.</p>', 3200000, 3500000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-01-33f41548-eee8-493c-b25a-0656a44d0665.jpg', 'women', 1, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (28, 'Mizuno Wave Rebellion Pro 2', '<h3>MIZUNO WAVE REBELLION PRO 2 - SÓNG THẦN TỐC ĐỘ TỪ NHẬT BẢN</h3>\n<p>Mizuno Wave Rebellion Pro 2 là vũ khí bí mật của nhiều runner Nhật Bản tại các giải marathon lớn. Kết hợp giữa triết lý chế tạo tỉ mỉ của Nhật Bản với công nghệ đệm hiện đại, đây là đôi giày đua <strong>mang đậm chất \"Made in Japan\"</strong>.</p>\n\n<h3>🔥 CÔNG NGHỆ ĐỘC QUYỀN MIZUNO</h3>\n<ul>\n  <li><strong>Mizuno ENERZY LITE+:</strong> Bọt đệm nhẹ nhất từng được Mizuno tạo ra, hoàn trả năng lượng vượt trội</li>\n  <li><strong>Wave Plate (Nylon):</strong> Tấm sóng nylon cong giúp chuyển tiếp bước chạy mượt mà từ gót đến mũi</li>\n  <li><strong>Smooth Speed Assist:</strong> Hình dáng đế rocker cong giúp đẩy bạn về phía trước một cách tự nhiên</li>\n  <li><strong>G3 Outsole:</strong> Đế ngoài cao su nhẹ bám đường tốt, chống mài mòn lâu dài</li>\n  <li><strong>Trọng lượng:</strong> ~215g (size 42)</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Mizuno thường có form <strong>hẹp hơn Nike/Adidas khoảng 0.5 size</strong>. Nên tăng 0.5 size, đặc biệt nếu chân bạn bè.</p>', 5200000, 5600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'men', 1, 10, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (29, 'Adidas Ultraboost Light 24', '<h3>ADIDAS ULTRABOOST LIGHT - ĐỆM BOOST HUYỀN THOẠI, NHẸ HƠN BAO GIỜ HẾT</h3>\n<p>Ultraboost Light là phiên bản nhẹ nhất trong lịch sử dòng Ultraboost huyền thoại. Giảm trọng lượng <strong>30% so với Ultraboost 22</strong> nhờ công nghệ bọt đệm Light BOOST mới, nhưng vẫn giữ nguyên cảm giác đàn hồi \"marshmallow\" mà hàng triệu runner yêu thích.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Light BOOST:</strong> Bọt đệm Boost thế hệ mới nhẹ hơn 30% mà vẫn giữ nguyên độ đàn hồi nổi tiếng</li>\n  <li><strong>Primeknit Upper:</strong> Vải dệt Primeknit ôm chân như đôi tất, thoáng khí tối ưu cho thời tiết nóng</li>\n  <li><strong>Linear Energy Push:</strong> Hệ thống thanh chống xoắn ở đế giữa giúp ổn định bàn chân</li>\n  <li><strong>Continental Outsole:</strong> Đế cao su Continental bám đường tuyệt vời, kể cả khi ướt</li>\n  <li><strong>Trọng lượng:</strong> ~280g (size 42) - nhẹ nhất lịch sử Ultraboost</li>\n</ul>\n\n<h3>🏃 PHÙ HỢP VỚI AI?</h3>\n<p>Versatile runner - người muốn 1 đôi giày vừa chạy bộ thoải mái, vừa đi dạo phố, đi làm, đi chơi đều đẹp. Ultraboost từ lâu đã vượt ra ngoài running để trở thành sneaker lifestyle.</p>', 3590000, 3990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-ultraboost-20-eg0713-01.jpg', 'unisex', 1, 2, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (30, 'Asics Gel-Kayano 31', '<h3>ASICS GEL-KAYANO 31 - VUA GIÀY ỔN ĐỊNH CHO RUNNER CHÂN BÈ</h3>\n<p>Gel-Kayano 31 là đôi giày ổn định (stability shoe) bán chạy nhất thế giới suốt 30 năm. Nếu bạn có bàn chân phẳng (flat feet) hoặc xu hướng nghiêng bàn chân vào trong khi chạy (overpronation), thì Kayano chính là <strong>bác sĩ chỉnh hình cho đôi chân</strong> của bạn.</p>\n\n<h3>🔥 CÔNG NGHỆ ỔN ĐỊNH HÀNG ĐẦU</h3>\n<ul>\n  <li><strong>4D GUIDANCE SYSTEM:</strong> Hệ thống hướng dẫn 4 chiều kiểm soát chuyển động bàn chân, giảm overpronation hiệu quả</li>\n  <li><strong>FF BLAST PLUS ECO:</strong> Đệm êm ái, nảy nhẹ nhàng, cảm giác thoải mái ngay lần đầu xỏ chân</li>\n  <li><strong>PureGEL:</strong> Viên gel giảm chấn siêu nhẹ ở phần gót, hấp thụ lực va chạm khi tiếp đất</li>\n  <li><strong>Upper Engineered Mesh:</strong> Lưới kỹ thuật nhiều lớp ôm chân vừa vặn, thoáng khí</li>\n  <li><strong>Trọng lượng:</strong> ~295g (size 42) | Drop: 10mm</li>\n</ul>\n\n<h3>🏃 PHÙ HỢP VỚI AI?</h3>\n<p>Runner có bàn chân phẳng, overpronation nhẹ-trung bình, hoặc bất kỳ ai muốn một đôi giày chạy êm ái và bảo vệ tối đa cho khớp gối, cổ chân.</p>', 4490000, 4990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'women', 1, 7, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (31, 'Puma Velocity Nitro 3', '<h3>PUMA VELOCITY NITRO 3 - GIÀY CHẠY GIÁ TỐT NHẤT PHÂN KHÚC</h3>\n<p>Velocity Nitro 3 là lựa chọn <strong>best value for money</strong> (giá tốt nhất cho chất lượng) trong phân khúc giày chạy bộ tầm trung. Sở hữu công nghệ đệm NITRO FOAM độc quyền của Puma mà giá chỉ bằng một nửa các đối thủ cùng phân khúc.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>NITRO FOAM:</strong> Bọt đệm được bơm khí nitrogen, nhẹ hơn 40% so với EVA truyền thống mà vẫn cực kỳ đàn hồi</li>\n  <li><strong>PUMAGRIP:</strong> Đế ngoài cao su đặc biệt bám đường tuyệt vời trên mọi địa hình</li>\n  <li><strong>Upper Mesh:</strong> Lưới thoáng khí rộng, phù hợp thời tiết nóng ẩm Việt Nam</li>\n  <li><strong>Trọng lượng:</strong> ~265g (size 42)</li>\n</ul>\n\n<h3>🏃 PHÙ HỢP VỚI AI?</h3>\n<p>Runner ở mọi trình độ muốn đôi giày tốt mà không phải bỏ ra 4-5 triệu. Tuyệt vời cho tập luyện hằng ngày.</p>', 2690000, 3200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'men', 1, 3, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (32, 'Under Armour HOVR Machina 3', '<h3>UNDER ARMOUR HOVR MACHINA 3 - KẾT NỐI THÔNG MINH, CHẠY THÔNG MINH</h3>\n<p>HOVR Machina 3 là đôi giày chạy thông minh tích hợp chip cảm biến, có thể kết nối với ứng dụng MapMyRun để <strong>theo dõi tốc độ, nhịp chạy (cadence), và phân tích form chạy</strong> của bạn theo thời gian thực.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>UA HOVR:</strong> Bọt đệm \"zero gravity feel\" - cảm giác như không trọng lượng, êm ái mà vẫn phản hồi lực tốt</li>\n  <li><strong>Chip cảm biến:</strong> Tích hợp sẵn trong đế, không cần sạc pin, kết nối Bluetooth với app MapMyRun</li>\n  <li><strong>Pebax Propulsion Plate:</strong> Tấm nhựa Pebax ở đế giữa hỗ trợ đẩy bước (push-off) hiệu quả</li>\n  <li><strong>Warp Upper:</strong> Upper dạng lưới đan chéo ôm chân chắc chắn ở phần midfoot</li>\n  <li><strong>Trọng lượng:</strong> ~290g (size 42)</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Under Armour thường <strong>True to Size</strong> hoặc hơi rộng nhẹ. Chọn đúng size.</p>', 3800000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'men', 1, 9, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (33, 'Nike Mercurial Superfly 9 Elite FG', '<h3>NIKE MERCURIAL SUPERFLY 9 ELITE - TỐC ĐỘ THUẦN KHIẾT</h3>\n<p>Mercurial Superfly là dòng giày bóng đá tốc độ <strong>đình đám nhất hành tinh</strong>, được các siêu sao như Kylian Mbappé, Cristiano Ronaldo sử dụng. Phiên bản Elite FG (Firm Ground) dành cho sân cỏ tự nhiên với đế đinh hỗn hợp giúp bạn bứt tốc như tên lửa.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Vaporposite+:</strong> Upper siêu mỏng bọc chân như lớp da thứ hai, cho cảm giác chạm bóng thuần khiết</li>\n  <li><strong>Dynamic Fit Collar:</strong> Cổ sock cao liền mạch ôm cổ chân tạo cảm giác hòa quyện bàn chân-giày-bóng</li>\n  <li><strong>Anti-Clog Traction:</strong> Công nghệ chống bám đất sét ở đế, đảm bảo hiệu suất kể cả trên sân ướt</li>\n  <li><strong>Đế đinh FG:</strong> Hệ thống đinh hỗn hợp chevron tối ưu cho xoay người, tăng tốc và phanh gấp</li>\n</ul>\n\n<h3>⚽ PHÙ HỢP VỚI AI?</h3>\n<p>Cầu thủ tấn công, tiền vệ cánh ưa thích tốc độ và rê bóng. Lưu ý: FG chỉ dùng cho sân cỏ tự nhiên.</p>', 5200000, 5800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'men', 2, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (34, 'Adidas Predator Accuracy.1 FG', '<h3>ADIDAS PREDATOR ACCURACY.1 - KIỂM SOÁT BÓNG TUYỆT ĐỐI</h3>\n<p>Predator là dòng giày bóng đá <strong>kiểm soát bóng huyền thoại</strong> từ năm 1994. Accuracy.1 được trang bị các vùng cao su nổi ZONE SKIN giúp tăng ma sát khi chạm bóng, cho phép bạn sút cầu vồng, căng ngang và chuyền bóng chính xác đến từng cm.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>ZONE SKIN:</strong> Các mấu cao su 3D phân bố chiến lược ở mu bàn chân và mép trong giúp tăng spin và kiểm soát bóng</li>\n  <li><strong>PRIMEKNIT COLLAR:</strong> Cổ dệt vừa vặn không cần buộc dây khu vực cổ chân</li>\n  <li><strong>FACET FRAME:</strong> Khung nhựa TPU ở đế giữa tối ưu chuyển hướng nhanh</li>\n  <li><strong>Đế đinh FG:</strong> Thiết kế blade + conical giúp bám sân cỏ tự nhiên chắc chắn</li>\n</ul>\n\n<h3>⚽ PHÙ HỢP VỚI AI?</h3>\n<p>Tiền vệ trung tâm, playmaker yêu thích kiểm soát bóng, chuyền dài và sút phạt.</p>', 4800000, 5400000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'men', 2, 2, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (35, 'Puma Future 7 Ultimate TF', '<h3>PUMA FUTURE 7 ULTIMATE TF - SÂN CỎ NHÂN TẠO, KỸ THUẬT SIÊU PHÀM</h3>\n<p>Future 7 Ultimate TF là đôi giày dành riêng cho sân cỏ nhân tạo (Turf) - loại mặt sân phổ biến nhất tại Việt Nam. Được Neymar Jr. đại diện, đôi giày này được thiết kế cho những cầu thủ yêu thích <strong>rê bóng kỹ thuật, đột phá qua người</strong>.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>FUZIONFIT+:</strong> Dải băng đàn hồi ôm sát mu bàn chân, tạo cảm giác khóa chân tuyệt vời</li>\n  <li><strong>Dynamic Motion System:</strong> Hệ thống đế ngoài linh hoạt cho phép xoay bàn chân tự do khi rê bóng</li>\n  <li><strong>GripControl Pro:</strong> Texture nổi trên upper tăng ma sát khi chạm bóng ở mọi góc độ</li>\n  <li><strong>Đế TF:</strong> Đinh ngắn cao su phù hợp sân cỏ nhân tạo 5 người/7 người</li>\n</ul>\n\n<h3>⚽ PHÙ HỢP VỚI AI?</h3>\n<p>Cầu thủ kỹ thuật, tiền đạo cánh thích rê bóng. Phù hợp sân cỏ nhân tạo 5v5 / 7v7 phổ biến tại VN.</p>', 2900000, 3400000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'men', 2, 3, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (36, 'Nike Phantom GX 2 Elite TF', '<h3>NIKE PHANTOM GX 2 ELITE TF - CHẠM BÓNG NHƯ TUYỆT PHẨM</h3>\n<p>Phantom GX 2 là thế hệ mới nhất trong dòng Phantom, thay thế hoàn toàn Phantom GT. Với upper NikeSkin thế hệ 2 siêu mỏng và mềm, đây là đôi giày mang lại <strong>cảm giác chạm bóng thuần túy nhất</strong> mà Nike từng sản xuất.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>NikeSkin 2.0:</strong> Upper siêu mỏng chỉ 1.5mm, mềm mại ôm bàn chân cho cảm giác chạm bóng \"barefoot\" (chân trần)</li>\n  <li><strong>Grip Texture:</strong> Các đường vân nổi cực nhỏ trên khắp upper giúp kiểm soát bóng khi mưa</li>\n  <li><strong>Flyknit Tongue:</strong> Lưỡi gà Flyknit liền mạch với upper, không bị lệch khi chạy</li>\n  <li><strong>Đế TF:</strong> Đinh cao su ngắn phù hợp sân cỏ nhân tạo Việt Nam</li>\n</ul>', 4200000, NULL, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-01.jpg', 'men', 2, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (37, 'Adidas Copa Pure 2 Elite TF', '<h3>ADIDAS COPA PURE 2 ELITE TF - DA THẬT, CẢM GIÁC THẬT</h3>\n<p>Copa là dòng giày bóng đá lâu đời nhất của Adidas, nổi tiếng với chất liệu da thật kangaroo mềm mịn. Copa Pure 2 là phiên bản hiện đại hóa với upper da K-Leather cao cấp, mang lại <strong>cảm giác chạm bóng ấm áp, mềm mại</strong> mà không dòng giày synthetic nào sánh được.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>K-Leather Upper:</strong> Da kangaroo tự nhiên cao cấp, mềm mịn và tạo hình theo bàn chân sau vài lần sử dụng</li>\n  <li><strong>FUSIONSKIN:</strong> Lớp phủ bảo vệ chống thấm nước, giúp da bền hơn mà vẫn giữ cảm giác mềm mại</li>\n  <li><strong>Speedframe:</strong> Khung đế nhẹ tối ưu cho chuyển hướng</li>\n  <li><strong>Đế TF:</strong> Đinh ngắn phù hợp sân cỏ nhân tạo</li>\n</ul>', 3800000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'men', 2, 2, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (38, 'Mizuno Alpha Elite TF', '<h3>MIZUNO ALPHA ELITE TF - TINH HOA NHẬT BẢN TRÊN SÂN CỎ</h3>\n<p>Mizuno Alpha Elite là đôi giày bóng đá <strong>Made in Japan</strong> chất lượng hàng đầu, được chế tác thủ công tại nhà máy Yamagata với sự tỉ mỉ đến từng đường kim mũi chỉ. Đây là lựa chọn của nhiều cầu thủ J-League và các giải đấu chuyên nghiệp châu Á.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>MIJ Upper:</strong> Da tổng hợp Nhật Bản siêu mỏng, mềm mại vượt trội, cho cảm giác chạm bóng tinh tế</li>\n  <li><strong>Barefoot Fit:</strong> Form giày rộng rãi kiểu Nhật, thoải mái cho bàn chân châu Á thường bè hơn</li>\n  <li><strong>D-Flex Groove:</strong> Rãnh linh hoạt ở đế giúp bàn chân gập tự nhiên khi chạy</li>\n  <li><strong>Đế TF:</strong> Đinh cao su phù hợp sân cỏ nhân tạo</li>\n</ul>', 3500000, 3900000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'men', 2, 10, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (39, 'Nike KD 16 EP Aura', '<h3>NIKE KD 16 EP - SIGNATURE SHOE CỦA KEVIN DURANT</h3>\n<p>KD 16 là đôi giày signature thế hệ thứ 16 của Kevin Durant, một trong những scorer vĩ đại nhất lịch sử NBA. Thiết kế lấy cảm hứng từ nghệ thuật origami Nhật Bản với các đường gấp tinh xảo trên upper.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Air Zoom Strobel:</strong> Đơn vị Zoom Air toàn chiều dài gắn trực tiếp vào lót giày, mang lại cảm giác sân gần (court feel) và phản hồi lực bùng nổ</li>\n  <li><strong>Air Cushioning:</strong> Thêm 1 đơn vị Air ở phần gót chồng lên Zoom Strobel tạo đệm kép siêu êm khi tiếp đất</li>\n  <li><strong>FlyWire:</strong> Dây cáp Flywire khóa chặt midfoot khi chuyển hướng đột ngột</li>\n  <li><strong>EP Outsole:</strong> Đế ngoài EP (Engineered Performance) với rãnh xương cá bám sân gỗ indoor tuyệt vời</li>\n</ul>\n\n<h3>🏀 PHÙ HỢP VỚI AI?</h3>\n<p>Guard/Forward linh hoạt, thích court feel gần sân và phản hồi lực nhanh. Cổ thấp linh hoạt cho cổ chân.</p>', 4200000, 4600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', 'men', 3, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (40, 'Adidas Harden Vol. 8', '<h3>ADIDAS HARDEN VOL. 8 - VŨ KHÍ CỦA \"THE BEARD\" JAMES HARDEN</h3>\n<p>Harden Vol. 8 được thiết kế cho lối chơi step-back đặc trưng của James Harden - dừng đột ngột, lùi lại, rồi tung cú ném 3 điểm chết người. Đế giày có hệ thống bám sân đặc biệt cho phép <strong>phanh gấp và đổi hướng trong nháy mắt</strong>.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Boost:</strong> Đệm Boost toàn chiều dài - êm ái và hoàn trả năng lượng khi bật nhảy</li>\n  <li><strong>Torsion System:</strong> Thanh chống xoắn TPU ở giữa đế tăng ổn định khi pivot</li>\n  <li><strong>Herringbone Outsole:</strong> Rãnh xương cá đa hướng bám sân gỗ cực tốt</li>\n  <li><strong>Lace Cage:</strong> Hệ thống buộc dây với khung nhựa giữ chân ổn định</li>\n</ul>\n\n<h3>🏀 PHÙ HỢP VỚI AI?</h3>\n<p>Guard thích iso play, step-back, crossover. Cần đệm êm và bám sân tốt.</p>', 3600000, 4000000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-4d-fusio-h04509-01.jpg', 'men', 3, 2, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (41, 'Under Armour Curry 11 Champion Mindset', '<h3>UNDER ARMOUR CURRY 11 - \"MINDSET\" CỦA NHÀ VÔ ĐỊCH STEPHEN CURRY</h3>\n<p>Curry 11 là tuyệt tác mới nhất trong dòng signature của Stephen Curry - tay ném 3 điểm vĩ đại nhất mọi thời đại. Đệm UA Flow không cao su mang lại <strong>cảm giác gần sân nhất có thể</strong> cho những cú cắt nhanh và ném bóng chính xác.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>UA Flow:</strong> Đệm đế giữa toàn chiều dài KHÔNG CÓ lớp cao su ngoài - bám sân trực tiếp bằng foam, siêu nhẹ và dính như keo</li>\n  <li><strong>Curry Chassis:</strong> Khung ổn định TPU ở gót và midfoot, chống lật cổ chân khi chuyển hướng</li>\n  <li><strong>UA Warp Upper:</strong> Upper dạng lưới đan chéo co giãn theo bàn chân</li>\n  <li><strong>Trọng lượng:</strong> ~310g (size 42) - nhẹ bậc nhất phân khúc basketball</li>\n</ul>\n\n<h3>🏀 PHÙ HỢP VỚI AI?</h3>\n<p>Point guard/Shooting guard thích di chuyển nhanh, cắt rổ không bóng, ném 3 điểm.</p>', 4500000, 4800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'men', 3, 9, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (42, 'Nike LeBron 21 Tahitian', '<h3>NIKE LEBRON 21 - SỨC MẠNH CỦA VƯƠNG GIẢ</h3>\n<p>LeBron 21 là signature shoe của LeBron James - cầu thủ bóng rổ vĩ đại nhất thế hệ. Đôi giày được thiết kế cho những cú lao vào rổ mạnh mẽ với <strong>đệm Zoom Air max volume lớn nhất</strong> từng được Nike đặt trong giày bóng rổ.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Max Volume Zoom Air:</strong> Đơn vị Zoom Air cỡ cực lớn ở mũi chân tạo lực đẩy bùng nổ</li>\n  <li><strong>Air Max Unit:</strong> Đệm Air Max ở gót hấp thụ chấn khi tiếp đất nặng</li>\n  <li><strong>Cable System:</strong> Hệ thống dây cáp tích hợp khóa chân ổn định</li>\n  <li><strong>Outsole:</strong> Rãnh traction xương cá đa hướng, rộng</li>\n</ul>\n\n<h3>🏀 PHÙ HỢP VỚI AI?</h3>\n<p>Power forward/Center thích lao rổ, cần đệm cực êm bảo vệ khớp. Cũng phù hợp cho cầu thủ nặng >80kg.</p>', 4900000, 5300000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', 'men', 3, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (43, 'Puma MB.03 LaMelo Ball Toxic', '<h3>PUMA MB.03 - CÙNG LAMELO BALL PHÁ VỠ MỌI QUY TẮC</h3>\n<p>MB.03 là signature shoe thế hệ 3 của LaMelo Ball - ngôi sao trẻ có phong cách chơi bóng rổ sáng tạo và phóng khoáng nhất NBA hiện tại. Thiết kế không lưỡi gà (laceless) <strong>cực kỳ táo bạo và khác biệt</strong>.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>NITRO Foam:</strong> Đệm NITRO được bơm khí nitrogen nhẹ và nảy</li>\n  <li><strong>ProFoam+:</strong> Lớp đệm thứ hai ở gót tăng cường hấp thụ chấn</li>\n  <li><strong>Laceless Design:</strong> Không lưỡi gà, upper bootie ôm chân liền mạch</li>\n  <li><strong>Outsole:</strong> Cao su bám sân indoor tốt với họa tiết herringbone</li>\n</ul>\n\n<h3>🏀 PHÙ HỢP VỚI AI?</h3>\n<p>Guard linh hoạt thích phong cách tự do. Thiết kế bắt mắt phù hợp cả chơi bóng lẫn đi casual.</p>', 3300000, 3800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'men', 3, 3, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (44, 'New Balance TWO WXY v4', '<h3>NEW BALANCE TWO WXY V4 - NGỰA Ô CỦA SÂN BÓNG RỔ</h3>\n<p>TWO WXY v4 là đôi giày bóng rổ performance tốt nhất của New Balance, được nhiều reviewer đánh giá là <strong>\"best bang for your buck\" (đáng tiền nhất)</strong> trong phân khúc. Kawhi Leonard và nhiều cầu thủ NBA cũng tin dùng dòng giày này.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>FuelCell:</strong> Đệm FuelCell được bơm khí nitrogen mang lại cảm giác nảy và phản hồi lực nhanh</li>\n  <li><strong>Stability Wrap:</strong> Vành đế nhựa TPU bao quanh gót và midfoot tăng ổn định tối đa</li>\n  <li><strong>Data-to-Design Upper:</strong> Upper được thiết kế dựa trên dữ liệu chuyển động của VĐV chuyên nghiệp</li>\n  <li><strong>Herringbone Outsole:</strong> Đế xương cá bám sân gỗ cực dính</li>\n</ul>', 3500000, 3900000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'men', 3, 4, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (45, 'Nike Calm Slide Black', '<h3>NIKE CALM SLIDE - DÉP ĐANG LÀM MƯA LÀM GIÓ</h3>\n<p>Nike Calm Slide là mẫu dép <strong>viral nhất mạng xã hội</strong> trong 2 năm qua. Thiết kế nguyên khối (one-piece) tinh giản bằng chất liệu xốp InjectedPhylon siêu mềm, tạo cảm giác như đi trên mây. Ai đã thử một lần đều không muốn tháo ra.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Chất liệu:</strong> InjectedPhylon nguyên khối, siêu nhẹ, chống thấm nước 100%</li>\n  <li><strong>Đệm:</strong> Đế dày ~3cm cực kỳ êm ái, cảm giác \"stepping on clouds\"</li>\n  <li><strong>Thiết kế:</strong> Tối giản, không logo lớn, phong cách minimalist</li>\n  <li><strong>Rãnh đế:</strong> Rãnh chống trơn trượt phù hợp đi bể bơi, phòng tắm, đi mưa</li>\n</ul>\n\n<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>\n<p>Calm Slide rộng bản, nên chọn <strong>đúng size hoặc giảm 1 size</strong> so với giày thể thao.</p>', 1200000, 1500000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'unisex', 5, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (46, 'Adidas Adilette 22 Slides', '<h3>ADIDAS ADILETTE 22 - DÉP TỪ TƯƠNG LAI</h3>\n<p>Adilette 22 sở hữu ngoại hình <strong>đậm chất sci-fi (khoa học viễn tưởng)</strong>, lấy cảm hứng từ bản đồ địa hình bề mặt sao Hỏa. Khác biệt hoàn toàn so với mẫu Adilette truyền thống, đây là đôi dép dành cho người muốn phong cách khác biệt, ĐỘC và LẠ.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Chất liệu:</strong> EVA làm từ mía (sugarcane-based EVA) thân thiện với môi trường</li>\n  <li><strong>Thiết kế:</strong> Bề mặt terrain texture mô phỏng địa hình hành tinh, cực kỳ bắt mắt</li>\n  <li><strong>Đế:</strong> Đế dày chunky tăng chiều cao ~3.5cm</li>\n  <li><strong>3-Stripes:</strong> Ba sọc Adidas được tạo hình 3D trên quai dép</li>\n</ul>', 1400000, 1600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'unisex', 5, 2, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (47, 'Vans La Costa Slide-On', '<h3>VANS LA COSTA SLIDE-ON - PHONG CÁCH CALIFORNIA THOẢI MÁI</h3>\n<p>Lấy cảm hứng từ bãi biển California đầy nắng, Vans La Costa Slide-On mang đến phong cách <strong>casual, thoải mái và năng động</strong>. Phù hợp cho những buổi dạo biển, đi cà phê cuối tuần hay đơn giản là nghỉ ngơi sau giờ làm việc.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Quai dép:</strong> EVA mềm mại với logo Vans Off The Wall dập nổi</li>\n  <li><strong>Đế:</strong> UltraCush siêu êm, nhẹ và chống trơn trượt</li>\n  <li><strong>Thiết kế:</strong> Checkerboard (caro) kinh điển trên quai dép</li>\n</ul>', 900000, 1100000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'unisex', 5, 6, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (48, 'Puma Leadcat 2.0 Slides', '<h3>PUMA LEADCAT 2.0 - DÉP QUAI NGANG KINH ĐIỂN</h3>\n<p>Leadcat 2.0 là mẫu dép quai ngang truyền thống bán chạy nhất của Puma. Thiết kế đơn giản, tinh tế với logo Puma Cat dập nổi trên quai. Phù hợp cho mọi dịp từ đi bể bơi đến dạo phố cuối tuần.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Quai:</strong> Nhựa mềm một mảnh với logo Puma Cat dập nổi lớn</li>\n  <li><strong>Đế:</strong> EVA nhẹ êm ái, rãnh chống trượt</li>\n  <li><strong>Form:</strong> Rộng thoải mái, phù hợp cả nam và nữ</li>\n</ul>', 750000, 900000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'unisex', 5, 3, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (49, 'New Balance 200 Slide V2', '<h3>NEW BALANCE 200 SLIDE V2 - ĐƠN GIẢN MÀ CHẤT</h3>\n<p>New Balance 200 Slide V2 dành cho những ai yêu thích sự tối giản mà vẫn muốn nổi bật với logo NB đặc trưng. Đệm CUSH+ êm ái cho đôi bàn chân nghỉ ngơi hoàn hảo.</p>\n\n<h3>🔥 ĐIỂM NỔI BẬT</h3>\n<ul>\n  <li><strong>Đệm CUSH+:</strong> Công nghệ đệm êm ái độc quyền New Balance</li>\n  <li><strong>Quai:</strong> Quai rộng có logo NB thêu nổi sang trọng</li>\n  <li><strong>Đế:</strong> Cao su mềm chống trơn trượt</li>\n</ul>', 800000, 950000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'unisex', 5, 4, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (50, 'Asics Gel-Resolution 9 Clay', '<h3>ASICS GEL-RESOLUTION 9 - VUA GIÀY TENNIS BỀN BỈ</h3>\n<p>Gel-Resolution 9 là đôi giày tennis bền bỉ nhất thị trường. Được thiết kế đặc biệt cho các cầu thủ <strong>baseliner (chơi cuối sân)</strong> với khả năng chịu mài mòn cực cao khi trượt trên mặt sân đất nện (clay) hoặc sân cứng.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>DYNAWALL:</strong> Hệ thống ổn định ở phần midfoot, chống lật cổ chân khi di chuyển ngang đột ngột</li>\n  <li><strong>GEL Technology:</strong> Gel giảm chấn ở gót và mũi, bảo vệ khớp trong trận đấu dài</li>\n  <li><strong>AHAR Plus Outsole:</strong> Đế cao su chống mài mòn bền gấp 3 lần cao su thường, đặc biệt ở vùng mũi chân</li>\n  <li><strong>PGuard Toe Protector:</strong> Lớp bảo vệ mũi giày chống cọ xát khi lao về phía trước</li>\n</ul>', 4100000, 4500000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'men', 6, 7, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (51, 'NikeCourt Zoom Vapor Pro 2 HC', '<h3>NIKECOURT ZOOM VAPOR PRO 2 - TỐC ĐỘ TRÊN SÂN TENNIS</h3>\n<p>Zoom Vapor Pro 2 là đôi giày tennis tốc độ của Nike, được nhiều tay vợt WTA sử dụng. Nhẹ, linh hoạt và phản hồi lực nhanh cho những cú trả bóng tấn công. Phiên bản HC (Hard Court) dành cho sân cứng.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Zoom Air:</strong> Đơn vị Zoom Air ở mũi chân cho cảm giác phản hồi nhanh khi lao về phía trước</li>\n  <li><strong>Dynamic Fit System:</strong> Upper ôm chân tùy chỉnh theo cách buộc dây</li>\n  <li><strong>Modified Herringbone:</strong> Đế xương cá cải tiến bám sân cứng tuyệt vời</li>\n  <li><strong>Trọng lượng:</strong> ~305g (size 38) - nhẹ cho giày tennis nữ</li>\n</ul>', 3200000, 3600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/m-plus-zoom-plus-gp-plus-challenge-plus-pro-plus-hc.jpg', 'women', 6, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (52, 'Adidas Barricade 13 Tennis', '<h3>ADIDAS BARRICADE 13 - PHÁO ĐÀI BẤT KHẢ XÂM PHẠM</h3>\n<p>Barricade là dòng giày tennis <strong>ổn định và bền bỉ nhất</strong> của Adidas, được đặt tên theo ý nghĩa \"hàng rào phòng thủ kiên cố\". Phù hợp cho người chơi thường xuyên, cần đôi giày chịu được cường độ tập luyện cao.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Bounce Pro:</strong> Đệm đế giữa Bounce Pro mới nhẹ hơn và đàn hồi hơn Bounce cũ</li>\n  <li><strong>ADITUFF:</strong> Lớp bảo vệ mũi giày chống mài mòn khi trượt trên sân</li>\n  <li><strong>3D Torsion System:</strong> Thanh chống xoắn 3 chiều ổn định bàn chân khi pivot</li>\n  <li><strong>Adiwear Outsole:</strong> Đế cao su chống mài mòn bền bỉ ở khu vực mũi chân</li>\n</ul>', 3800000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'men', 6, 2, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (53, 'New Balance Fresh Foam Lav v2', '<h3>NEW BALANCE FRESH FOAM LAV V2 - ÊM ÁI NHẤT CHO TENNIS</h3>\n<p>Fresh Foam Lav v2 là đôi giày tennis êm ái nhất của New Balance, mang công nghệ đệm Fresh Foam từ giày chạy bộ sang giày tennis. Phù hợp cho những người chơi cần <strong>sự thoải mái tối đa</strong> trong các trận đấu dài.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Fresh Foam:</strong> Đệm Fresh Foam siêu êm, giảm mệt mỏi bàn chân trong trận đấu dài 2-3 tiếng</li>\n  <li><strong>Kinetic Stitch:</strong> Upper bằng lưới với các đường may kỹ thuật tạo hỗ trợ mà không bó chân</li>\n  <li><strong>NDure Outsole:</strong> Đế cao su bền bỉ với rãnh herringbone bám đa hướng</li>\n</ul>', 3000000, 3400000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-3.jpg', 'women', 6, 4, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (54, 'Nike Metcon 9 AMP', '<h3>NIKE METCON 9 - KING OF THE GYM, VUA PHÒNG TẬP TẠ</h3>\n<p>Metcon là dòng giày tập gym/CrossFit <strong>bán chạy nhất thế giới suốt 9 đời</strong> liên tiếp. Nếu bạn nghiêm túc với việc nâng tạ (Squat, Deadlift, Clean & Jerk), thì Metcon 9 chính là lựa chọn không thể thay thế.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Hyperlift Insert:</strong> Tấm nâng gót bằng nhựa cứng giúp Squat sâu hơn, giữ gót ổn định khi nâng tạ nặng</li>\n  <li><strong>Đế phẳng:</strong> Đế cao su cực phẳng, cứng, tạo nền tảng vững chắc cho deadlift</li>\n  <li><strong>Rope Wrap:</strong> Lớp cao su bọc quanh phần giữa giày bảo vệ khi leo dây thừng (rope climb)</li>\n  <li><strong>React Foam:</strong> Đệm React ở mũi giày cho các bài cardio, box jump</li>\n  <li><strong>Trọng lượng:</strong> ~340g (size 42)</li>\n</ul>\n\n<h3>🏋️ PHÙ HỢP VỚI AI?</h3>\n<p>Gymer tập nặng, CrossFitter, người tập cử tạ. KHÔNG phù hợp để chạy bộ đường dài (đế quá cứng và phẳng).</p>', 3800000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'men', 7, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (55, 'Reebok Nano X3 Adventure', '<h3>REEBOK NANO X3 - CHIẾN BINH CROSSFIT HUYỀN THOẠI</h3>\n<p>Reebok Nano là dòng giày gắn liền với CrossFit từ thuở sơ khai. Nano X3 là phiên bản thứ 13 với hệ thống đệm <strong>Lift and Run</strong> thông minh - tự động cứng lại khi bạn nâng tạ và mềm đi khi bạn chạy.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>Lift & Run Chassis:</strong> Hệ thống khung đế kép: cứng cho nâng tạ, linh hoạt cho chạy bộ ngắn</li>\n  <li><strong>Floatride Energy Foam:</strong> Đệm Floatride ở mũi chân cho cảm giác nảy khi box jump, burpee</li>\n  <li><strong>Flexweave Knit Upper:</strong> Vải dệt Flexweave bền bỉ, thoáng khí, chống rách</li>\n  <li><strong>Heel Clip:</strong> Khung nhựa ôm gót ổn định khi nâng tạ nặng</li>\n</ul>\n\n<h3>🏋️ PHÙ HỢP VỚI AI?</h3>\n<p>CrossFitter, người tập HIIT, Functional Training. Versatile cho cả nâng tạ lẫn cardio.</p>', 3400000, 3800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-01-standard.jpg', 'unisex', 7, 8, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (56, 'Under Armour TriBase Reign 6', '<h3>UNDER ARMOUR TRIBASE REIGN 6 - NỀN TẢNG VỮNG CHẮC</h3>\n<p>TriBase Reign 6 sở hữu công nghệ đế 3 điểm chạm <strong>TriBase™</strong> giúp bàn chân tiếp đất với 3 điểm tựa ổn định (gót, mu bàn chân ngoài, mu bàn chân trong), mang lại nền tảng vững chắc nhất cho mọi bài nâng tạ.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>TriBase™:</strong> 3 điểm tiếp đất tối ưu cho nâng tạ ổn định, giảm thiểu lắc lư</li>\n  <li><strong>Micro G Foam:</strong> Đệm Micro G mỏng nhẹ, tạo cảm giác gần sàn (ground feel)</li>\n  <li><strong>Full Rubber Outsole:</strong> Đế cao su toàn bộ, grip tốt trên sàn phòng tập</li>\n  <li><strong>External Heel Counter:</strong> Khung gót ngoài ổn định cổ chân</li>\n</ul>', 3200000, 3600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'men', 7, 9, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (57, 'Puma Fuse 3.0 Training', '<h3>PUMA FUSE 3.0 - GIÀY TẬP GYM DÀNH CHO NỮ</h3>\n<p>Puma Fuse 3.0 được thiết kế đặc biệt cho phái nữ yêu thích gym và fitness. Form dáng thon gọn, nhẹ nhàng nhưng vẫn đảm bảo độ ổn định khi tập các bài nặng như Squat, Lunge, và các bài HIIT.</p>\n\n<h3>🔥 CÔNG NGHỆ</h3>\n<ul>\n  <li><strong>FUSIONFIT:</strong> Upper ôm chân linh hoạt theo mọi hướng chuyển động</li>\n  <li><strong>SOFTRIDE:</strong> Đệm SOFTRIDE êm ái ở phần trước, thoải mái cho cardio</li>\n  <li><strong>Rubber Outsole:</strong> Đế cao su phẳng, grip tốt, ổn định cho nâng tạ</li>\n  <li><strong>Trọng lượng:</strong> ~255g (size 38) - siêu nhẹ cho giày training</li>\n</ul>', 2500000, 2900000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'women', 7, 3, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (58, 'Bộ Vệ Sinh Giày Chuyên Sâu Premium', '<h3>BỘ VỆ SINH GIÀY CHUYÊN SÂU - GIÀY SẠCH NHƯ MỚI</h3>\n<p>Bộ kit vệ sinh giày cao cấp bao gồm tất cả những gì bạn cần để giữ cho đôi sneaker yêu quý luôn sạch sẽ và mới đẹp như ngày đầu. Dung dịch vệ sinh gốc thực vật an toàn cho <strong>mọi loại chất liệu</strong>: da, vải, mesh, suede, canvas, knit.</p>\n\n<h3>📦 BỘ KIT BAO GỒM</h3>\n<ul>\n  <li><strong>1x Dung dịch vệ sinh 150ml:</strong> Gốc thực vật, không chứa hóa chất mạnh, an toàn cho mọi vật liệu</li>\n  <li><strong>1x Bàn chải lông heo tự nhiên:</strong> Lông mềm không làm xước vải và da, phù hợp upper giày</li>\n  <li><strong>1x Bàn chải cứng nhỏ:</strong> Dùng cho đế và midsole cáu bẩn nặng</li>\n  <li><strong>1x Khăn microfiber:</strong> Siêu mềm, hút nước tốt, dùng lau khô giày sau khi vệ sinh</li>\n  <li><strong>1x Túi đựng giày du lịch:</strong> Vải dù chống bụi, tiện mang đi travel</li>\n</ul>\n\n<h3>📋 HƯỚNG DẪN SỬ DỤNG</h3>\n<p>1. Pha dung dịch với nước theo tỉ lệ 1:10 → 2. Nhúng bàn chải vào dung dịch → 3. Chà nhẹ theo vòng tròn → 4. Lau sạch bằng khăn microfiber → 5. Phơi khô thoáng gió (KHÔNG phơi nắng trực tiếp).</p>', 550000, 650000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-01.jpg?v=1694779868303', 'unisex', 8, 10, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (59, 'Bình Xịt Nano Chống Thấm Nước Giày', '<h3>BÌNH XỊT NANO CHỐNG THẤM NƯỚC - BẢO VỆ GIÀY DƯỚI MƯA</h3>\n<p>Xịt nano siêu kỵ nước tạo lớp bảo vệ vô hình trên bề mặt giày, giúp đôi sneaker của bạn <strong>hoàn toàn không thấm nước</strong> khi gặp mưa hoặc nước bắn. Nước sẽ lăn ra khỏi giày như giọt nước trên lá sen.</p>\n\n<h3>🔥 ĐẶC ĐIỂM</h3>\n<ul>\n  <li><strong>Dung tích:</strong> 250ml, đủ xịt cho 8-10 đôi giày</li>\n  <li><strong>Công nghệ:</strong> Nano Fluorocarbon tạo lớp phủ siêu kỵ nước vô hình</li>\n  <li><strong>Tương thích:</strong> Mọi loại vải: canvas, mesh, suede, leather, knit</li>\n  <li><strong>Hiệu lực:</strong> Kéo dài 3-4 tuần cho mỗi lần xịt</li>\n  <li><strong>Không mùi:</strong> Không gây dị ứng, an toàn cho da tay</li>\n</ul>', 280000, 350000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-01.jpg?v=1694779868303', 'unisex', 8, 10, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');
INSERT INTO `products` VALUES (60, 'Pack 3 đôi Vớ Thể Thao Nike Everyday Cushion', '<h3>VỚ NIKE EVERYDAY CUSHION - BẠN ĐỒNG HÀNH HOÀN HẢO CỦA MỌI ĐÔI GIÀY</h3>\n<p>Đôi giày tốt cần đi kèm đôi vớ tốt. Nike Everyday Cushion là dòng vớ thể thao <strong>bán chạy nhất của Nike</strong>, được hàng triệu vận động viên và người dùng tin tưởng sử dụng hằng ngày.</p>\n\n<h3>📦 GÓI SẢN PHẨM</h3>\n<ul>\n  <li><strong>Số lượng:</strong> Pack 3 đôi (1 Trắng + 1 Đen + 1 Xám)</li>\n  <li><strong>Cổ vớ:</strong> Crew (cổ lửng ngang bắp chân)</li>\n  <li><strong>Chất liệu:</strong> 71% Cotton + 26% Polyester + 3% Spandex</li>\n</ul>\n\n<h3>🔥 TÍNH NĂNG</h3>\n<ul>\n  <li><strong>Dri-FIT:</strong> Công nghệ thấm hút mồ hôi cực mạnh, giữ chân luôn khô ráo dù tập luyện căng thẳng</li>\n  <li><strong>Cushioning:</strong> Đệm lót ở lòng bàn chân giảm phồng rộp khi chạy bộ hoặc chơi thể thao</li>\n  <li><strong>Arch Support:</strong> Dải đàn hồi ôm vòm bàn chân tạo cảm giác chắc chắn</li>\n  <li><strong>Ribbed Cuff:</strong> Cổ vớ đàn hồi không bị tuột xuống khi vận động</li>\n</ul>', 350000, 420000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'unisex', 8, 1, 1, '2026-06-15 16:28:15', '2026-06-15 16:28:15');

-- ----------------------------
-- Table structure for promotions
-- ----------------------------
DROP TABLE IF EXISTS `promotions`;
CREATE TABLE `promotions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Tên đợt: Flash Sale 30/4, Clearance...',
  `label` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'SALE' COMMENT 'Nhãn hiển thị trên card: SALE, HOT, -30%...',
  `start_date` datetime NULL DEFAULT NULL,
  `end_date` datetime NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of promotions
-- ----------------------------

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PENDING',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_reviews_product`(`product_id` ASC) USING BTREE,
  INDEX `fk_reviews_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_reviews_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO `reviews` VALUES (1, 1, 3, 5, 'Giày chạy rất êm, form đúng size.', 'APPROVED', '2025-12-11 23:45:59');
INSERT INTO `reviews` VALUES (2, 2, 4, 4, 'Đệm êm nhưng hơi nóng chân khi chạy dài.', 'APPROVED', '2025-12-11 23:45:59');
INSERT INTO `reviews` VALUES (3, 1, 2, 4, 'giày oke đó, đáng tiền mua', 'APPROVED', '2025-12-24 11:02:00');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'ADMIN', 'Quản trị hệ thống', 'Toàn quyền quản lý hệ thống');
INSERT INTO `roles` VALUES (2, 'STAFF', 'Nhân viên', 'Quản lý đơn hàng, sản phẩm, khách hàng');
INSERT INTO `roles` VALUES (3, 'USER', 'Khách hàng', 'Người mua hàng trên website');

-- ----------------------------
-- Table structure for user_addresses
-- ----------------------------
DROP TABLE IF EXISTS `user_addresses`;
CREATE TABLE `user_addresses`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `full_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address_line` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `district` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ward` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_default` tinyint(1) NULL DEFAULT 0,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_addresses_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_addresses_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_addresses
-- ----------------------------
INSERT INTO `user_addresses` VALUES (1, 3, 'Nguyễn Văn A', '0909000001', '123 Lê Lợi', 'TP.HCM', 'Quận 1', 'Bến Thành', 1, '2025-12-11 23:45:59');
INSERT INTO `user_addresses` VALUES (2, 4, 'Trần Thị B', '0909000002', '89 Phan Xích Long', 'TP.HCM', 'Phú Nhuận', 'Phường 3', 1, '2025-12-11 23:45:59');
INSERT INTO `user_addresses` VALUES (3, 7, 'linh trọng', '0342406654', '123, ', 'TP. Hồ Chí Minh', 'thuan an', 'binh hoa', 0, '2026-01-11 00:40:02');
INSERT INTO `user_addresses` VALUES (4, 7, 'linh trọng', '0342406654', '123,', 'TP. Hồ Chí Minh', 'thuan an', 'binh hoa', 0, '2026-01-12 20:01:22');
INSERT INTO `user_addresses` VALUES (5, 7, 'linh trọng', '0342406654', '123,', 'TP. Hồ Chí Minh', 'thuan an', 'binh hoa', 0, '2026-01-12 20:05:37');
INSERT INTO `user_addresses` VALUES (6, 7, 'linh trọng', '0342406654', '123,', 'TP. Hồ Chí Minh', 'thuan an', 'binh hoa', 0, '2026-01-12 23:15:45');
INSERT INTO `user_addresses` VALUES (7, 7, 'linh trọng', '0342406654', '123,', 'TP. Hồ Chí Minh', 'thuan an', 'binh hoa', 0, '2026-01-12 23:16:51');
INSERT INTO `user_addresses` VALUES (8, 7, 'linh trọng', '0342406654', '123,', 'TP. Hồ Chí Minh', 'thuan an', 'binh hoa', 0, '2026-01-12 23:59:21');
INSERT INTO `user_addresses` VALUES (9, 7, 'linh trọng', '0342406654', '123,', 'TP. Hồ Chí Minh', 'thuan an', 'binh hoa', 1, '2026-01-16 11:11:38');

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles`  (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `fk_user_roles_role`(`role_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_roles
-- ----------------------------
INSERT INTO `user_roles` VALUES (1, 1);
INSERT INTO `user_roles` VALUES (2, 1);
INSERT INTO `user_roles` VALUES (3, 3);
INSERT INTO `user_roles` VALUES (4, 3);
INSERT INTO `user_roles` VALUES (5, 3);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `birthday` date NULL DEFAULT NULL,
  `active` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `auth_provider` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'local',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin@japansport.com', 'admin123', 'NLU', NULL, NULL, NULL, NULL, 1, '2025-12-11 23:44:51', '2026-01-02 23:34:39', 'local');
INSERT INTO `users` VALUES (2, 'staff1@japansport.com', 'staff123', 'Nhân viên kho', NULL, NULL, NULL, NULL, 1, '2025-12-11 23:44:51', '2026-01-14 00:38:03', 'local');
INSERT INTO `users` VALUES (3, 'user1@example.com', 'user123', 'Nguyễn Văn A', NULL, NULL, NULL, NULL, 1, '2025-12-11 23:44:51', '2025-12-11 23:44:51', 'local');
INSERT INTO `users` VALUES (4, 'user2@example.com', 'user123', 'Trần Thị B', NULL, NULL, NULL, NULL, 1, '2025-12-11 23:44:51', '2025-12-11 23:44:51', 'local');
INSERT INTO `users` VALUES (5, 'user3@example.com', 'user123', 'Lê C', NULL, NULL, NULL, NULL, 1, '2025-12-11 23:44:51', '2026-01-15 16:21:44', 'local');
INSERT INTO `users` VALUES (6, 'tronglinh2708@...', 'pbkdf2$...', 'linh', NULL, NULL, NULL, NULL, 1, '2025-12-30 01:38:48', '2025-12-30 01:38:48', 'local');
INSERT INTO `users` VALUES (7, 'tronglinh2708@gmail.com', 'pbkdf2$120000$S7E3T34QEDn0CEtTnCQC_w$1OdEJrDwCldbgHMRuxSC0TpTlM3HxPhrdmeJ5jZvFTU', 'linh trọng', '', 'uploads/avatars/u7_622cc253-28f6-4672-b56e-b704b77e0db6.jpg', NULL, NULL, 1, '2026-01-03 00:22:49', '2026-01-16 08:18:59', 'local');
INSERT INTO `users` VALUES (8, '1669488177617120@facebook.com', '', 'Trọng Linh', NULL, NULL, NULL, NULL, 1, '2026-06-15 17:22:41', '2026-06-15 17:22:41', 'facebook');

-- ----------------------------
-- Table structure for vouchers
-- ----------------------------
DROP TABLE IF EXISTS `vouchers`;
CREATE TABLE `vouchers`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `discount_type` enum('percent','fixed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'percent',
  `discount_value` decimal(10, 2) NOT NULL,
  `min_order_value` decimal(10, 2) NULL DEFAULT 0.00,
  `max_discount` decimal(10, 2) NULL DEFAULT NULL,
  `start_date` datetime NULL DEFAULT NULL,
  `end_date` datetime NULL DEFAULT NULL,
  `usage_limit` int NULL DEFAULT NULL,
  `used_count` int NULL DEFAULT 0,
  `is_active` tinyint(1) NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE,
  UNIQUE INDEX `uk_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vouchers
-- ----------------------------
INSERT INTO `vouchers` VALUES (1, 'WELCOME10', 'Giảm 10% cho đơn đầu tiên', 'percent', 10.00, 500000.00, 200000.00, '2026-01-01 00:00:00', '2026-12-31 23:59:59', 100, 0, 1, '2026-06-15 16:27:31', '2026-06-15 16:27:31');
INSERT INTO `vouchers` VALUES (2, 'FREESHIP', 'Miễn phí ship toàn quốc', 'fixed', 30000.00, 800000.00, NULL, '2026-05-01 00:00:00', '2026-05-30 23:59:59', 50, 0, 0, '2026-06-15 16:27:31', '2026-06-15 16:28:25');
INSERT INTO `vouchers` VALUES (3, 'SALE20', 'Giảm 20% cho đơn từ 1 triệu', 'percent', 20.00, 1000000.00, 500000.00, '2026-05-01 00:00:00', '2026-05-20 23:59:59', 200, 0, 0, '2026-06-15 16:27:31', '2026-06-15 16:28:25');

SET FOREIGN_KEY_CHECKS = 1;
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
