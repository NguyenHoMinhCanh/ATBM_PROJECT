-- ----------------------------
-- Table structure for promotions
-- ----------------------------
CREATE TABLE IF NOT EXISTS `promotions`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Tên đợt: Flash Sale 30/4, Clearance...',
  `label` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'SALE' COMMENT 'Nhãn hiển thị trên card: SALE, HOT, -30%...',
  `start_date` datetime NULL DEFAULT NULL,
  `end_date` datetime NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_promotions
-- ----------------------------
CREATE TABLE IF NOT EXISTS `product_promotions`  (
  `product_id` int NOT NULL,
  `promotion_id` int NOT NULL,
  `sale_price` decimal(15, 2) NULL DEFAULT NULL COMMENT 'Giá bán trong đợt, NULL = dùng price gốc',
  PRIMARY KEY (`product_id`, `promotion_id`) USING BTREE,
  INDEX `fk_pp_promotion`(`promotion_id` ASC) USING BTREE,
  CONSTRAINT `fk_pp_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_pp_promotion` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;
