-- ==============================================================================
-- SEED DATA: 50 SẢN PHẨM MỚI CHO WEBSITE JAPANSPORT SNEAKER
-- Ngày tạo: 13/06/2026
-- Hướng dẫn: Mở Navicat/MySQL Workbench, chọn DB `web`, chạy toàn bộ script này.
-- ==============================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============ PHẦN 1: DỌN DẸP DỮ LIỆU CŨ (GIỮ LẠI 10 SP ĐẦU) ============
DELETE FROM product_images WHERE product_id > 10;
DELETE FROM product_variants WHERE product_id > 10;
DELETE FROM product_specs WHERE product_id > 10;
DELETE FROM cart_items WHERE product_id > 10;
DELETE FROM order_items WHERE product_id > 10;
DELETE FROM products WHERE id > 10;

SET FOREIGN_KEY_CHECKS = 1;

-- ============ PHẦN 2: THÊM 50 SẢN PHẨM MỚI ============

-- ===================== SNEAKER LIFESTYLE (12 SP) =====================

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(11, 'Nike Air Force 1 ''07 Triple White',
'<h3>NIKE AIR FORCE 1 ''07 - BIỂU TƯỢNG SNEAKER VƯỢT THỜI GIAN</h3>
<p>Ra mắt lần đầu năm 1982, Nike Air Force 1 là đôi giày bóng rổ <strong>ĐẦU TIÊN</strong> trên thế giới sử dụng công nghệ đệm khí Nike Air. Trải qua hơn 40 năm, AF1 đã vượt ra khỏi sân bóng rổ để trở thành biểu tượng văn hóa đường phố được hàng triệu người yêu thích trên toàn cầu.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Chất liệu Upper:</strong> Da tổng hợp cao cấp full-grain, mềm mại nhưng vô cùng bền bỉ, càng đi càng đẹp theo thời gian</li>
  <li><strong>Đế giữa (Midsole):</strong> Bọt đệm Nike Air ẩn bên trong gót chân, mang lại cảm giác êm ái suốt cả ngày dài đi bộ hay đứng làm việc</li>
  <li><strong>Đế ngoài (Outsole):</strong> Cao su nguyên khối với các vòng tròn pivot xoay đặc trưng, bám đường cực tốt trên mọi bề mặt</li>
  <li><strong>Thiết kế:</strong> Cổ thấp linh hoạt, lưỡi gà dày dặn êm ái, dễ dàng phối đồ từ quần jeans, jogger đến chân váy</li>
  <li><strong>Màu sắc:</strong> Trắng tinh khôi (Triple White) - phối được với literally mọi outfit</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>AF1 có form <strong>hơi rộng hơn 0.5 size</strong> so với chuẩn. Nếu bàn chân bạn thon hoặc vừa, nên chọn <strong>giảm 0.5 size</strong> so với size thường mang. Ví dụ: bạn thường đi size 42 thì nên chọn 41.5 hoặc 41.</p>

<h3>✅ CAM KẾT CHÍNH HÃNG 100%</h3>
<p>Sản phẩm chính hãng Nike, đầy đủ hộp + tag + giấy gói. Bảo hành keo đế 6 tháng. Hỗ trợ đổi size miễn phí trong 7 ngày nếu giày chưa qua sử dụng ngoài trời.</p>',
2950000, 3200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'unisex', 4, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(12, 'Adidas Samba OG Black White',
'<h3>ADIDAS SAMBA OG - HUYỀN THOẠI TRỞ LẠI TỪ SÂN CỎ</h3>
<p>Ban đầu được thiết kế cho các cầu thủ bóng đá tập luyện trên nền đất đông cứng của mùa đông nước Đức những năm 1950, Adidas Samba nay đã trở thành <strong>đôi giày bán chạy nhất lịch sử Adidas</strong> và là must-have item trong tủ giày của mọi tín đồ thời trang.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Upper:</strong> Da thật kết hợp da lộn (suede) ở mũi chữ T đặc trưng, tạo nên vẻ ngoài sang trọng đậm chất vintage</li>
  <li><strong>Đế ngoài:</strong> Cao su gum (gum sole) màu nâu caramel nguyên bản, bám cực tốt và tạo điểm nhấn thẩm mỹ tuyệt vời</li>
  <li><strong>Lưỡi gà:</strong> Có logo Samba dập nổi bằng vàng gold, chi tiết nhỏ nhưng đẳng cấp</li>
  <li><strong>Lót giày:</strong> OrthoLite mềm mại, thấm hút mồ hôi và chống vi khuẩn</li>
  <li><strong>Phong cách:</strong> Versatile - phù hợp từ outfit đi học, đi làm văn phòng casual cho đến đi chơi cuối tuần</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Samba OG có form <strong>True to Size (TTS)</strong>, bạn chọn đúng size thường mang là vừa. Bàn chân bè nên tăng 0.5 size.</p>

<h3>🎁 ĐẶC QUYỀN KHI MUA TẠI SHOP</h3>
<p>Tặng kèm 1 đôi dây giày phụ màu trắng. Miễn phí vệ sinh giày trọn đời khi mua tại cửa hàng. Đổi trả dễ dàng trong 7 ngày.</p>',
2800000, NULL, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-superstar-fv3290-01.jpg', 'unisex', 4, 2, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(13, 'New Balance 550 White Green',
'<h3>NEW BALANCE 550 - HUYỀN THOẠI BÓNG RỔ THẬP NIÊN 80 TRỞ LẠI</h3>
<p>Được thiết kế lần đầu vào năm 1989 như một đôi giày thi đấu bóng rổ, New Balance 550 đã im hơi lặng tiếng suốt nhiều thập kỷ trước khi được hồi sinh vào năm 2021 và ngay lập tức trở thành <strong>cơn sốt toàn cầu</strong> nhờ phong cách retro-chunky cuốn hút.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Upper:</strong> Da tổng hợp cao cấp phối cùng các tấm đục lỗ (perforated panels) giúp thoáng khí xuất sắc ngay cả khi đi cả ngày</li>
  <li><strong>Thiết kế đế:</strong> Đế giữa dày dặn phong cách chunky retro tạo thêm chiều cao ~3cm một cách tự nhiên không bị lố</li>
  <li><strong>Logo:</strong> Chữ N cỡ lớn hai bên hông - điểm nhận diện thương hiệu New Balance không lẫn vào đâu được</li>
  <li><strong>Cổ giày:</strong> Đệm foam dày ôm gót cực chắc, không bị tuột gót khi đi bộ nhanh</li>
  <li><strong>Đế ngoài:</strong> Cao su chống mài mòn, các rãnh xẻ flex grooves hỗ trợ gập bàn chân tự nhiên</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>NB 550 có form <strong>hơi rộng</strong> theo truyền thống của New Balance. Chân thon nên giảm 0.5 size, chân bè đi đúng size.</p>

<h3>✅ CAM KẾT</h3>
<p>Hàng chính hãng New Balance, check code trên website hãng được. Full box + phụ kiện. Bảo hành keo 6 tháng.</p>',
3400000, 3800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/x-plr-shoes-beige-by9255-01-standard-1.jpg', 'unisex', 4, 4, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(14, 'Puma Palermo Leather Vintage',
'<h3>PUMA PALERMO - PHONG CÁCH TERRACE TỪ NƯỚC Ý</h3>
<p>Lấy cảm hứng từ văn hóa bóng đá và phong cách terrace casual của các cổ động viên Ý những năm 80-90, Puma Palermo mang đến vẻ đẹp thanh lịch, tinh tế mà không kém phần cá tính. Đây là mẫu giày đang được <strong>các fashionista và KOLs săn lùng nhiều nhất</strong> trong năm nay.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Upper:</strong> Da lộn (suede) mềm mịn như nhung kết hợp lưới mesh bên hông tạo vẻ vintage đầy cuốn hút</li>
  <li><strong>Đế gum:</strong> Cao su gum dày nguyên khối tông nâu ấm - đặc trưng nhận diện của dòng Palermo</li>
  <li><strong>Logo:</strong> Formstrip Puma thêu tinh xảo bên hông cùng thẻ tag đặc trưng gắn ở lưỡi gà</li>
  <li><strong>Trọng lượng:</strong> Siêu nhẹ chỉ ~280g mỗi chiếc, đi cả ngày không mỏi chân</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Puma Palermo có form <strong>True to Size</strong>. Nữ giới lưu ý chọn theo bảng size nữ của Puma.</p>

<h3>✅ CHÍNH SÁCH BÁN HÀNG</h3>
<p>Cam kết chính hãng Puma. Full box đẹp, sẵn sàng làm quà tặng. Đổi size miễn phí trong 7 ngày.</p>',
2500000, 2800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'women', 4, 3, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(15, 'Converse Chuck 70 Hi Black',
'<h3>CONVERSE CHUCK 70 HIGH TOP - BẢN NÂNG CẤP CỦA HUYỀN THOẠI</h3>
<p>Chuck 70 là phiên bản <strong>cao cấp nhất</strong> trong dòng Chuck Taylor All Star, tái hiện lại chính xác thiết kế nguyên bản từ thập niên 1970. So với bản Chuck Taylor thường, Chuck 70 sở hữu chất liệu canvas dày hơn 30%, đệm êm hơn gấp đôi, và các chi tiết hoàn thiện tinh xảo hơn hẳn.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Canvas:</strong> Vải bố 10oz dày dặn, bền bỉ hơn hẳn Chuck Taylor thường, màu sắc sâu và đồng nhất hơn</li>
  <li><strong>Đế:</strong> Đế cao su egret (trắng ngà) vintage thay vì trắng sáng, tạo cảm giác hoài cổ đặc trưng</li>
  <li><strong>Đệm lót:</strong> OrthoLite cushion lót trong, êm ái vượt trội so với lót giày bình thường của Converse</li>
  <li><strong>Chi tiết:</strong> Logo All Star dập nhiệt ở gót, patch gót dày hơn, ốp mắt cáo bằng kim loại nặng</li>
  <li><strong>Cổ giày:</strong> High-top bảo vệ cổ chân, có thể gập xuống tạo phong cách khác biệt</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Chuck 70 có form <strong>dài và hẹp</strong>. Hầu hết mọi người nên chọn <strong>giảm 1 full size</strong> so với giày thể thao Nike/Adidas. Ví dụ: Nike bạn đi 42 thì Converse nên chọn 41.</p>

<h3>✅ CAM KẾT</h3>
<p>Chính hãng Converse, full box. Tặng kèm 1 đôi dây giày phụ. Bảo hành 6 tháng.</p>',
1890000, 2100000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'unisex', 4, 5, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(16, 'Vans Old Skool Classic Black White',
'<h3>VANS OLD SKOOL - ĐÔI GIÀY STREETWEAR KINH ĐIỂN</h3>
<p>Vans Old Skool là mẫu giày đầu tiên của Vans sử dụng đường kẻ sọc Jazz Stripe nổi tiếng (hay còn gọi là Sidestripe) - biểu tượng mà ngày nay ai cũng nhận ra. Ra mắt năm 1977, Old Skool nhanh chóng trở thành đôi giày gắn liền với văn hóa skateboard, punk rock và thời trang đường phố toàn cầu.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Upper:</strong> Kết hợp hoàn hảo giữa da lộn (suede) ở mũi giày và vải canvas ở thân giày, vừa bền vừa thoáng khí</li>
  <li><strong>Jazz Stripe:</strong> Đường kẻ sọc trắng signature chạy dọc hai bên hông - biểu tượng không thể thiếu</li>
  <li><strong>Đế waffle:</strong> Đế cao su waffle nguyên bản của Vans, bám đường cực tốt kể cả trên bề mặt trơn ướt</li>
  <li><strong>Cổ giày:</strong> Đệm padded collar dày dặn ôm gót ấm áp, thoải mái không bị cọ xát</li>
  <li><strong>Trọng lượng:</strong> Nhẹ, linh hoạt, phù hợp đi bộ, đi chơi và cả skateboarding</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Vans Old Skool có form <strong>True to Size</strong>. Nếu phân vân giữa 2 size, nên chọn size lớn hơn vì canvas sẽ ôm dần theo bàn chân.</p>

<h3>✅ CAM KẾT</h3>
<p>Hàng Vans chính hãng. Full box, thẻ bảo hành. Hỗ trợ đổi size 7 ngày.</p>',
1690000, 1890000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'unisex', 4, 6, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(17, 'Nike Dunk Low Retro Panda',
'<h3>NIKE DUNK LOW RETRO "PANDA" - ĐÔI GIÀY HOT NHẤT HÀNH TINH</h3>
<p>Nike Dunk Low Retro phối màu Panda (Đen Trắng) là <strong>đôi giày bán chạy nhất toàn cầu</strong> trong 3 năm liên tiếp. Thiết kế phối 2 tone đen-trắng đơn giản nhưng cuốn hút khó cưỡng, phù hợp với mọi phong cách thời trang từ tối giản đến phá cách.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Upper:</strong> Da tổng hợp premium, overlay đen nổi bật trên nền trắng tạo hiệu ứng thị giác mạnh mẽ</li>
  <li><strong>Đế giữa:</strong> Foam nhẹ mang lại cảm giác thoải mái cho việc đi bộ hằng ngày</li>
  <li><strong>Đế ngoài:</strong> Cao su bền bỉ với rãnh pivot tròn di sản từ phiên bản gốc năm 1985</li>
  <li><strong>Lưỡi gà:</strong> Dày dặn, có đệm foam mềm mại ôm chân vừa vặn</li>
  <li><strong>Cổ giày:</strong> Low-top thoải mái, cổ chân linh hoạt khi di chuyển</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Dunk Low Retro có form <strong>True to Size đến hơi chật 0.5</strong>. Chân bè nên tăng thêm 0.5 size để thoải mái hơn.</p>

<h3>⚠️ LƯU Ý QUAN TRỌNG</h3>
<p>Do quá hot, thị trường có rất nhiều hàng nhái/fake. Sản phẩm tại shop cam kết 100% chính hãng, kèm hóa đơn mua hàng từ Nike Vietnam. Bạn có thể check barcode trực tiếp trên app Nike.</p>',
3100000, 3500000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-1.jpg', 'unisex', 4, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(18, 'Adidas Gazelle Bold Platform Green',
'<h3>ADIDAS GAZELLE BOLD - PHIÊN BẢN ĐẾ TĂNG CHIỀU CAO CHO NỮ</h3>
<p>Adidas Gazelle Bold là biến thể đặc biệt dành riêng cho phái nữ của dòng Gazelle huyền thoại. Điểm khác biệt lớn nhất là phần đế platform dày hơn, giúp tăng thêm <strong>khoảng 4cm chiều cao</strong> một cách tự nhiên và thời trang. Phong cách Y2K retro đang cực kỳ được ưa chuộng.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Upper:</strong> Da lộn suede premium mềm mịn, phối màu xanh rêu cực kỳ đặc biệt và hiếm trên thị trường</li>
  <li><strong>Đế Bold:</strong> Platform rubber dày ~4cm, tăng chiều cao tự nhiên mà vẫn đi êm, không nặng nề</li>
  <li><strong>3-Stripes:</strong> Ba sọc Adidas đặc trưng bằng da lộn tông-sur-tông sang trọng</li>
  <li><strong>Lót OrthoLite:</strong> Đệm lót êm ái, thấm hút mồ hôi, chống mùi hiệu quả cả ngày</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Gazelle Bold form <strong>hơi nhỏ 0.5 size</strong> so với chuẩn. Nên chọn tăng 0.5 size. Bảng size nữ Adidas (EU): 36, 37, 38, 39, 40.</p>

<h3>✅ CAM KẾT</h3>
<p>Chính hãng Adidas Originals. Full box cao cấp. Tặng kèm túi dustbag bảo quản giày.</p>',
3200000, 3600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-falcon-w-ef4988-01.jpg', 'women', 4, 2, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(19, 'New Balance 2002R Protection Pack Grey',
'<h3>NEW BALANCE 2002R PROTECTION PACK - SIÊU PHẨM "CHÁY HÀNG" TOÀN CẦU</h3>
<p>New Balance 2002R Protection Pack là phiên bản giới hạn gây bão cộng đồng sneakerhead toàn thế giới. Lấy cảm hứng từ ý tưởng bảo vệ đôi giày mới mua, phiên bản này có các lớp bảo vệ bọc quanh upper tạo nên vẻ ngoài <strong>deconstructed (giải cấu trúc)</strong> cực kỳ độc đáo.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Thiết kế:</strong> Các tấm da lộn xám bạc xếp chồng lên nhau tạo hiệu ứng 3D độc nhất vô nhị</li>
  <li><strong>Đệm ABZORB:</strong> Công nghệ hấp thụ lực va chạm hàng đầu của New Balance ở phần gót</li>
  <li><strong>N-ERGY:</strong> Lớp đệm thứ hai ở phần mũi chân giúp hoàn trả năng lượng khi bước đi</li>
  <li><strong>Đế ENCAP:</strong> Khung nhựa TPU bao quanh phần đế giữa tăng cường độ ổn định</li>
  <li><strong>Trọng lượng:</strong> ~340g, nhẹ hơn so với ngoại hình chunky</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>NB 2002R có form <strong>rộng thoải mái</strong> đặc trưng của New Balance. Chân thon nên giảm 0.5 size.</p>

<h3>✅ CAM KẾT</h3>
<p>Chính hãng New Balance. Full box + giấy gói + tag. Bảo hành keo 6 tháng.</p>',
4200000, 4800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-1.jpg', 'men', 4, 4, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(20, 'Converse Run Star Hike Platform',
'<h3>CONVERSE RUN STAR HIKE - CHUCK TAYLOR PHIÊN BẢN "BIẾN HÌNH"</h3>
<p>Run Star Hike là phiên bản táo bạo nhất trong gia đình Chuck Taylor. Giữ nguyên DNA canvas cổ điển của Converse nhưng <strong>nâng đế lên thành platform zigzag cực kỳ bắt mắt</strong>, tạo nên sự kết hợp hoàn hảo giữa di sản và hiện đại. Đây là lựa chọn yêu thích của nhiều ngôi sao và influencer.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Đế Hike:</strong> Platform zigzag tăng chiều cao ~5cm, thiết kế răng cưa độc đáo, bám đường tốt</li>
  <li><strong>Canvas:</strong> Vải bố 10oz chuẩn Converse, bền đẹp theo thời gian</li>
  <li><strong>Đệm:</strong> CX Foam mềm mại giúp đi thoải mái hơn Chuck Taylor truyền thống rất nhiều</li>
  <li><strong>Thiết kế:</strong> High-top với 2 tầng lỗ xỏ dây tạo điểm nhấn thị giác</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Giống Chuck Taylor, nên chọn <strong>giảm 1 size</strong> so với giày thể thao. Phù hợp đặc biệt cho các bạn nữ muốn hack chiều cao.</p>',
2400000, 2700000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'women', 4, 5, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(21, 'Vans SK8-Hi Tapered Black',
'<h3>VANS SK8-HI TAPERED - CỔ CAO HUYỀN THOẠI</h3>
<p>SK8-Hi (đọc là "Skate High") là mẫu giày cổ cao mang tính biểu tượng nhất của Vans, ra mắt năm 1978 dành cho các vận động viên trượt ván. Phiên bản Tapered được thu gọn form dáng, <strong>mảnh mai hơn bản gốc 15%</strong>, phù hợp cho cả nam và nữ.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Upper:</strong> Suede + Canvas kết hợp, cổ cao bảo vệ mắt cá chân khi vận động</li>
  <li><strong>Jazz Stripe:</strong> Sọc trắng signature chạy từ mắt cá lên đến mũi giày</li>
  <li><strong>Đế waffle:</strong> Cao su vulcanized bám dính cực tốt, chuẩn cho skateboarding</li>
  <li><strong>Tapered:</strong> Form dáng thon gọn hơn SK8-Hi classic, không bị cồng kềnh</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>SK8-Hi Tapered có form <strong>True to Size</strong>. Cổ cao nên ban đầu có thể hơi chật, sau vài ngày đi sẽ mềm dần.</p>',
1990000, 2200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'unisex', 4, 6, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(22, 'Puma Suede Classic XXI Navy',
'<h3>PUMA SUEDE CLASSIC XXI - DA LỘN KINH ĐIỂN TỪ NĂM 1968</h3>
<p>Puma Suede là một trong những đôi giày có tuổi đời lâu nhất trong lịch sử sneaker, ra mắt từ năm 1968 với tên gọi ban đầu là "Crack". Phiên bản Classic XXI (21st Century) giữ nguyên vẻ đẹp nguyên bản nhưng được cải tiến về mặt thoải mái và bền bỉ.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Suede:</strong> Da lộn cao cấp toàn bộ upper, mềm mịn và có độ bóng satin nhẹ đẹp mắt</li>
  <li><strong>Formstrip:</strong> Dải logo Puma trắng tương phản với nền xanh navy tạo điểm nhấn mạnh mẽ</li>
  <li><strong>Đế:</strong> Cao su phẳng bám tốt, phù hợp đi bộ trên mọi bề mặt</li>
  <li><strong>Lót SoftFoam+:</strong> Đệm lót Puma độc quyền, êm ái thoải mái suốt cả ngày</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Puma Suede Classic có form <strong>chuẩn size</strong>. Chọn đúng size thường mang.</p>',
1800000, 2100000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'men', 4, 3, 1);


-- ===================== GIÀY CHẠY BỘ - RUNNING (10 SP) =====================

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(23, 'Nike ZoomX Vaporfly NEXT% 3',
'<h3>NIKE ZOOMX VAPORFLY NEXT% 3 - SIÊU GIÀY PHÁ KỶ LỤC MARATHON</h3>
<p>Vaporfly NEXT% 3 là đôi giày đua marathon <strong>nhanh nhất thế giới</strong>. Đây chính là đôi giày mà Eliud Kipchoge đã mang khi phá kỷ lục marathon sub-2 giờ lịch sử. Phiên bản thứ 3 được tinh chỉnh hoàn hảo với upper mới nhẹ hơn và đế ZoomX cải tiến hoàn trả năng lượng lên đến 85%.</p>

<h3>🔥 CÔNG NGHỆ ĐỈNH CAO</h3>
<ul>
  <li><strong>ZoomX Foam:</strong> Loại bọt đệm nhẹ nhất và đàn hồi nhất từng được Nike tạo ra, hoàn trả năng lượng lên đến 85%</li>
  <li><strong>Carbon Plate:</strong> Đĩa sợi carbon toàn chiều dài tạo hiệu ứng đòn bẩy tại mỗi bước chạy, giúp bạn tiết kiệm năng lượng đáng kể</li>
  <li><strong>Upper Flyknit:</strong> Vải dệt Flyknit thế hệ mới siêu mỏng, siêu nhẹ, ôm chân như đôi tất</li>
  <li><strong>Trọng lượng:</strong> Chỉ ~188g (size 42) - nhẹ đến mức bạn quên mình đang mang giày</li>
  <li><strong>Drop:</strong> 8mm (gót cao hơn mũi 8mm) - tối ưu cho kiểu chạy forefoot/midfoot</li>
</ul>

<h3>🏃 PHÙ HỢP VỚI AI?</h3>
<p>Dành cho runner nghiêm túc muốn phá PB (Personal Best) trong các giải marathon, half-marathon, hoặc các buổi chạy tempo quan trọng. <strong>Không khuyến khích</strong> dùng cho tập luyện hằng ngày vì tuổi thọ đế giới hạn ~400km.</p>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Vaporfly NEXT% 3 có form <strong>ôm chân</strong>. Nên chọn <strong>tăng 0.5 size</strong> so với size thường mang, đặc biệt nếu bạn chạy đường dài (chân sẽ phình ra khi chạy lâu).</p>',
6500000, 6800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-plus-pegasus-plus-trail-plus-5-plus-gs.jpg', 'men', 1, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(24, 'Adidas Adizero Boston 12',
'<h3>ADIDAS ADIZERO BOSTON 12 - GIÀY TẬP LUYỆN CỦA DÂN CHẠY CHUYÊN NGHIỆP</h3>
<p>Adizero Boston 12 là đôi giày "daily trainer" (tập luyện hằng ngày) mang DNA đua tốc độ từ dòng Adizero Elite. Nếu Vaporfly là giày ngày race day, thì Boston 12 chính là người bạn đồng hành <strong>trung thành trong mọi buổi tập</strong> của bạn.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Lightstrike Pro:</strong> Đệm gót bằng vật liệu siêu nhẹ Lightstrike Pro - cùng chất liệu với giày đua Adizero Adios Pro</li>
  <li><strong>Energyrods 2.0:</strong> 5 thanh sợi thủy tinh ở đế giữa giúp chuyển tiếp bước chạy mượt mà từ gót đến mũi</li>
  <li><strong>Upper Mesh:</strong> Lưới kỹ thuật nhẹ, thoáng khí cực kỳ trong điều kiện nóng ẩm Việt Nam</li>
  <li><strong>Continental Outsole:</strong> Đế ngoài cao su Continental (hãng lốp xe hơi) bám đường siêu tốt kể cả khi ướt</li>
  <li><strong>Trọng lượng:</strong> ~240g (size 42)</li>
</ul>

<h3>🏃 PHÙ HỢP VỚI AI?</h3>
<p>Runner muốn 1 đôi giày "do-it-all" - chạy easy run, tempo, interval đều xử lý ngon lành. Bền bỉ cho khoảng 800-1000km.</p>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Boston 12 có form <strong>True to Size</strong>. Nên chọn đúng size thường mang.</p>',
3900000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'women', 1, 2, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(25, 'Asics Novablast 4',
'<h3>ASICS NOVABLAST 4 - CHẠY TRÊN MÂY, NẢY NHƯ TRAMPOLINE</h3>
<p>Novablast 4 là đôi giày chạy bộ "vui nhất" của Asics. Nếu bạn đang tìm một đôi giày mang lại <strong>cảm giác bouncy (nảy) cực kỳ thú vị</strong> ở mỗi bước chạy, thì đây chính là lựa chọn hoàn hảo. Nhiều runner mô tả cảm giác đi Novablast như đang nhún trên bạt trampoline.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>FF BLAST PLUS ECO:</strong> Bọt đệm mới nhất của Asics, nhẹ hơn 20% và nảy hơn 15% so với thế hệ trước, được làm từ nguyên liệu tái chế thân thiện môi trường</li>
  <li><strong>Thiết kế đế Trampoline:</strong> Hình dạng đế lấy cảm hứng từ bạt nhún, cong ở cả mũi và gót tạo độ nảy tự nhiên</li>
  <li><strong>Upper Mesh:</strong> Lưới kỹ thuật jacquard thoáng khí, hỗ trợ tốt mà không tạo cảm giác bó chặt</li>
  <li><strong>AHAR Outsole:</strong> Cao su chống mài mòn AHAR ở những vùng tiếp đất chính, tăng tuổi thọ đế</li>
  <li><strong>Drop:</strong> 8mm | Trọng lượng: ~260g (size 42)</li>
</ul>

<h3>🏃 PHÙ HỢP VỚI AI?</h3>
<p>Người mới bắt đầu chạy bộ đến runner trung cấp. Tuyệt vời cho easy run, recovery run và chạy bộ giải trí cuối tuần.</p>',
4300000, 4600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'men', 1, 7, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(26, 'New Balance FuelCell SC Elite v4',
'<h3>NEW BALANCE FUELCELL SC ELITE V4 - ĐỐI THỦ XỨNG TẦM CỦA VAPORFLY</h3>
<p>FuelCell SC Elite v4 là câu trả lời mạnh mẽ của New Balance trước sự thống trị của Nike trong phân khúc giày đua carbon plate. Được <strong>nhiều VĐV chuyên nghiệp lựa chọn</strong> trong các giải marathon lớn trên thế giới.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>FuelCell Foam:</strong> Bọt đệm nitrogen-infused siêu nhẹ và đàn hồi cao, hoàn trả năng lượng ấn tượng</li>
  <li><strong>Carbon Fiber Plate:</strong> Đĩa sợi carbon toàn chiều dài với hình dạng spoon (thìa) tối ưu cho đòn bẩy</li>
  <li><strong>Upper FantomFit:</strong> Lớp da tổng hợp siêu mỏng hàn nhiệt trực tiếp lên mesh, giảm trọng lượng tối đa</li>
  <li><strong>Trọng lượng:</strong> ~195g (size 42) - nhẹ bậc nhất phân khúc</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>SC Elite v4 có form <strong>hơi hẹp ở phần midfoot</strong>. Nên tăng 0.5 size nếu chân bè.</p>',
5800000, 6200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'men', 1, 4, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(27, 'Nike Pegasus 41',
'<h3>NIKE PEGASUS 41 - ĐÔI GIÀY CHẠY BỘ BÁN CHẠY NHẤT MỌI THỜI ĐẠI</h3>
<p>Dòng Pegasus đã trải qua 41 đời nâng cấp kể từ năm 1983, biến nó trở thành <strong>dòng giày chạy bộ có tuổi đời dài nhất và bán chạy nhất</strong> trong lịch sử Nike. Pegasus 41 tiếp tục sứ mệnh là đôi giày "cho tất cả mọi người" - từ người mới bắt đầu đến runner lão luyện.</p>

<h3>🔥 NÂNG CẤP MỚI Ở PHIÊN BẢN 41</h3>
<ul>
  <li><strong>React X Foam:</strong> Đệm React X mới nhẹ hơn 13% và hoàn trả năng lượng nhiều hơn 13% so với React cũ</li>
  <li><strong>Air Zoom:</strong> Đơn vị Zoom Air ở mũi chân cho cảm giác phản hồi lực nhanh khi đẩy bước</li>
  <li><strong>Flywire:</strong> Dây cáp Flywire ôm chân tùy chỉnh theo cách buộc dây</li>
  <li><strong>Waffle Outsole:</strong> Đế ngoài waffle cải tiến bám đường tốt trên cả mặt đường khô và ướt</li>
  <li><strong>Trọng lượng:</strong> ~275g (size 42) | Drop: 10mm</li>
</ul>

<h3>🏃 PHÙ HỢP VỚI AI?</h3>
<p>Mọi đối tượng. Pegasus là đôi giày chạy bộ toàn năng nhất: easy run, long run, tempo run đều ổn. Đặc biệt phù hợp cho người mới bắt đầu chạy bộ.</p>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Pegasus 41 có form <strong>True to Size</strong>. Rất dễ chọn size, hầu hết mọi người đều vừa với size thường mang.</p>',
3200000, 3500000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-01-33f41548-eee8-493c-b25a-0656a44d0665.jpg', 'women', 1, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(28, 'Mizuno Wave Rebellion Pro 2',
'<h3>MIZUNO WAVE REBELLION PRO 2 - SÓNG THẦN TỐC ĐỘ TỪ NHẬT BẢN</h3>
<p>Mizuno Wave Rebellion Pro 2 là vũ khí bí mật của nhiều runner Nhật Bản tại các giải marathon lớn. Kết hợp giữa triết lý chế tạo tỉ mỉ của Nhật Bản với công nghệ đệm hiện đại, đây là đôi giày đua <strong>mang đậm chất "Made in Japan"</strong>.</p>

<h3>🔥 CÔNG NGHỆ ĐỘC QUYỀN MIZUNO</h3>
<ul>
  <li><strong>Mizuno ENERZY LITE+:</strong> Bọt đệm nhẹ nhất từng được Mizuno tạo ra, hoàn trả năng lượng vượt trội</li>
  <li><strong>Wave Plate (Nylon):</strong> Tấm sóng nylon cong giúp chuyển tiếp bước chạy mượt mà từ gót đến mũi</li>
  <li><strong>Smooth Speed Assist:</strong> Hình dáng đế rocker cong giúp đẩy bạn về phía trước một cách tự nhiên</li>
  <li><strong>G3 Outsole:</strong> Đế ngoài cao su nhẹ bám đường tốt, chống mài mòn lâu dài</li>
  <li><strong>Trọng lượng:</strong> ~215g (size 42)</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Mizuno thường có form <strong>hẹp hơn Nike/Adidas khoảng 0.5 size</strong>. Nên tăng 0.5 size, đặc biệt nếu chân bạn bè.</p>',
5200000, 5600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'men', 1, 10, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(29, 'Adidas Ultraboost Light 24',
'<h3>ADIDAS ULTRABOOST LIGHT - ĐỆM BOOST HUYỀN THOẠI, NHẸ HƠN BAO GIỜ HẾT</h3>
<p>Ultraboost Light là phiên bản nhẹ nhất trong lịch sử dòng Ultraboost huyền thoại. Giảm trọng lượng <strong>30% so với Ultraboost 22</strong> nhờ công nghệ bọt đệm Light BOOST mới, nhưng vẫn giữ nguyên cảm giác đàn hồi "marshmallow" mà hàng triệu runner yêu thích.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Light BOOST:</strong> Bọt đệm Boost thế hệ mới nhẹ hơn 30% mà vẫn giữ nguyên độ đàn hồi nổi tiếng</li>
  <li><strong>Primeknit Upper:</strong> Vải dệt Primeknit ôm chân như đôi tất, thoáng khí tối ưu cho thời tiết nóng</li>
  <li><strong>Linear Energy Push:</strong> Hệ thống thanh chống xoắn ở đế giữa giúp ổn định bàn chân</li>
  <li><strong>Continental Outsole:</strong> Đế cao su Continental bám đường tuyệt vời, kể cả khi ướt</li>
  <li><strong>Trọng lượng:</strong> ~280g (size 42) - nhẹ nhất lịch sử Ultraboost</li>
</ul>

<h3>🏃 PHÙ HỢP VỚI AI?</h3>
<p>Versatile runner - người muốn 1 đôi giày vừa chạy bộ thoải mái, vừa đi dạo phố, đi làm, đi chơi đều đẹp. Ultraboost từ lâu đã vượt ra ngoài running để trở thành sneaker lifestyle.</p>',
3590000, 3990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-ultraboost-20-eg0713-01.jpg', 'unisex', 1, 2, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(30, 'Asics Gel-Kayano 31',
'<h3>ASICS GEL-KAYANO 31 - VUA GIÀY ỔN ĐỊNH CHO RUNNER CHÂN BÈ</h3>
<p>Gel-Kayano 31 là đôi giày ổn định (stability shoe) bán chạy nhất thế giới suốt 30 năm. Nếu bạn có bàn chân phẳng (flat feet) hoặc xu hướng nghiêng bàn chân vào trong khi chạy (overpronation), thì Kayano chính là <strong>bác sĩ chỉnh hình cho đôi chân</strong> của bạn.</p>

<h3>🔥 CÔNG NGHỆ ỔN ĐỊNH HÀNG ĐẦU</h3>
<ul>
  <li><strong>4D GUIDANCE SYSTEM:</strong> Hệ thống hướng dẫn 4 chiều kiểm soát chuyển động bàn chân, giảm overpronation hiệu quả</li>
  <li><strong>FF BLAST PLUS ECO:</strong> Đệm êm ái, nảy nhẹ nhàng, cảm giác thoải mái ngay lần đầu xỏ chân</li>
  <li><strong>PureGEL:</strong> Viên gel giảm chấn siêu nhẹ ở phần gót, hấp thụ lực va chạm khi tiếp đất</li>
  <li><strong>Upper Engineered Mesh:</strong> Lưới kỹ thuật nhiều lớp ôm chân vừa vặn, thoáng khí</li>
  <li><strong>Trọng lượng:</strong> ~295g (size 42) | Drop: 10mm</li>
</ul>

<h3>🏃 PHÙ HỢP VỚI AI?</h3>
<p>Runner có bàn chân phẳng, overpronation nhẹ-trung bình, hoặc bất kỳ ai muốn một đôi giày chạy êm ái và bảo vệ tối đa cho khớp gối, cổ chân.</p>',
4490000, 4990000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'women', 1, 7, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(31, 'Puma Velocity Nitro 3',
'<h3>PUMA VELOCITY NITRO 3 - GIÀY CHẠY GIÁ TỐT NHẤT PHÂN KHÚC</h3>
<p>Velocity Nitro 3 là lựa chọn <strong>best value for money</strong> (giá tốt nhất cho chất lượng) trong phân khúc giày chạy bộ tầm trung. Sở hữu công nghệ đệm NITRO FOAM độc quyền của Puma mà giá chỉ bằng một nửa các đối thủ cùng phân khúc.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>NITRO FOAM:</strong> Bọt đệm được bơm khí nitrogen, nhẹ hơn 40% so với EVA truyền thống mà vẫn cực kỳ đàn hồi</li>
  <li><strong>PUMAGRIP:</strong> Đế ngoài cao su đặc biệt bám đường tuyệt vời trên mọi địa hình</li>
  <li><strong>Upper Mesh:</strong> Lưới thoáng khí rộng, phù hợp thời tiết nóng ẩm Việt Nam</li>
  <li><strong>Trọng lượng:</strong> ~265g (size 42)</li>
</ul>

<h3>🏃 PHÙ HỢP VỚI AI?</h3>
<p>Runner ở mọi trình độ muốn đôi giày tốt mà không phải bỏ ra 4-5 triệu. Tuyệt vời cho tập luyện hằng ngày.</p>',
2690000, 3200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'men', 1, 3, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(32, 'Under Armour HOVR Machina 3',
'<h3>UNDER ARMOUR HOVR MACHINA 3 - KẾT NỐI THÔNG MINH, CHẠY THÔNG MINH</h3>
<p>HOVR Machina 3 là đôi giày chạy thông minh tích hợp chip cảm biến, có thể kết nối với ứng dụng MapMyRun để <strong>theo dõi tốc độ, nhịp chạy (cadence), và phân tích form chạy</strong> của bạn theo thời gian thực.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>UA HOVR:</strong> Bọt đệm "zero gravity feel" - cảm giác như không trọng lượng, êm ái mà vẫn phản hồi lực tốt</li>
  <li><strong>Chip cảm biến:</strong> Tích hợp sẵn trong đế, không cần sạc pin, kết nối Bluetooth với app MapMyRun</li>
  <li><strong>Pebax Propulsion Plate:</strong> Tấm nhựa Pebax ở đế giữa hỗ trợ đẩy bước (push-off) hiệu quả</li>
  <li><strong>Warp Upper:</strong> Upper dạng lưới đan chéo ôm chân chắc chắn ở phần midfoot</li>
  <li><strong>Trọng lượng:</strong> ~290g (size 42)</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Under Armour thường <strong>True to Size</strong> hoặc hơi rộng nhẹ. Chọn đúng size.</p>',
3800000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'men', 1, 9, 1);


-- ===================== GIÀY BÓNG ĐÁ (6 SP) =====================

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(33, 'Nike Mercurial Superfly 9 Elite FG',
'<h3>NIKE MERCURIAL SUPERFLY 9 ELITE - TỐC ĐỘ THUẦN KHIẾT</h3>
<p>Mercurial Superfly là dòng giày bóng đá tốc độ <strong>đình đám nhất hành tinh</strong>, được các siêu sao như Kylian Mbappé, Cristiano Ronaldo sử dụng. Phiên bản Elite FG (Firm Ground) dành cho sân cỏ tự nhiên với đế đinh hỗn hợp giúp bạn bứt tốc như tên lửa.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Vaporposite+:</strong> Upper siêu mỏng bọc chân như lớp da thứ hai, cho cảm giác chạm bóng thuần khiết</li>
  <li><strong>Dynamic Fit Collar:</strong> Cổ sock cao liền mạch ôm cổ chân tạo cảm giác hòa quyện bàn chân-giày-bóng</li>
  <li><strong>Anti-Clog Traction:</strong> Công nghệ chống bám đất sét ở đế, đảm bảo hiệu suất kể cả trên sân ướt</li>
  <li><strong>Đế đinh FG:</strong> Hệ thống đinh hỗn hợp chevron tối ưu cho xoay người, tăng tốc và phanh gấp</li>
</ul>

<h3>⚽ PHÙ HỢP VỚI AI?</h3>
<p>Cầu thủ tấn công, tiền vệ cánh ưa thích tốc độ và rê bóng. Lưu ý: FG chỉ dùng cho sân cỏ tự nhiên.</p>',
5200000, 5800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'men', 2, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(34, 'Adidas Predator Accuracy.1 FG',
'<h3>ADIDAS PREDATOR ACCURACY.1 - KIỂM SOÁT BÓNG TUYỆT ĐỐI</h3>
<p>Predator là dòng giày bóng đá <strong>kiểm soát bóng huyền thoại</strong> từ năm 1994. Accuracy.1 được trang bị các vùng cao su nổi ZONE SKIN giúp tăng ma sát khi chạm bóng, cho phép bạn sút cầu vồng, căng ngang và chuyền bóng chính xác đến từng cm.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>ZONE SKIN:</strong> Các mấu cao su 3D phân bố chiến lược ở mu bàn chân và mép trong giúp tăng spin và kiểm soát bóng</li>
  <li><strong>PRIMEKNIT COLLAR:</strong> Cổ dệt vừa vặn không cần buộc dây khu vực cổ chân</li>
  <li><strong>FACET FRAME:</strong> Khung nhựa TPU ở đế giữa tối ưu chuyển hướng nhanh</li>
  <li><strong>Đế đinh FG:</strong> Thiết kế blade + conical giúp bám sân cỏ tự nhiên chắc chắn</li>
</ul>

<h3>⚽ PHÙ HỢP VỚI AI?</h3>
<p>Tiền vệ trung tâm, playmaker yêu thích kiểm soát bóng, chuyền dài và sút phạt.</p>',
4800000, 5400000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'men', 2, 2, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(35, 'Puma Future 7 Ultimate TF',
'<h3>PUMA FUTURE 7 ULTIMATE TF - SÂN CỎ NHÂN TẠO, KỸ THUẬT SIÊU PHÀM</h3>
<p>Future 7 Ultimate TF là đôi giày dành riêng cho sân cỏ nhân tạo (Turf) - loại mặt sân phổ biến nhất tại Việt Nam. Được Neymar Jr. đại diện, đôi giày này được thiết kế cho những cầu thủ yêu thích <strong>rê bóng kỹ thuật, đột phá qua người</strong>.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>FUZIONFIT+:</strong> Dải băng đàn hồi ôm sát mu bàn chân, tạo cảm giác khóa chân tuyệt vời</li>
  <li><strong>Dynamic Motion System:</strong> Hệ thống đế ngoài linh hoạt cho phép xoay bàn chân tự do khi rê bóng</li>
  <li><strong>GripControl Pro:</strong> Texture nổi trên upper tăng ma sát khi chạm bóng ở mọi góc độ</li>
  <li><strong>Đế TF:</strong> Đinh ngắn cao su phù hợp sân cỏ nhân tạo 5 người/7 người</li>
</ul>

<h3>⚽ PHÙ HỢP VỚI AI?</h3>
<p>Cầu thủ kỹ thuật, tiền đạo cánh thích rê bóng. Phù hợp sân cỏ nhân tạo 5v5 / 7v7 phổ biến tại VN.</p>',
2900000, 3400000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'men', 2, 3, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(36, 'Nike Phantom GX 2 Elite TF',
'<h3>NIKE PHANTOM GX 2 ELITE TF - CHẠM BÓNG NHƯ TUYỆT PHẨM</h3>
<p>Phantom GX 2 là thế hệ mới nhất trong dòng Phantom, thay thế hoàn toàn Phantom GT. Với upper NikeSkin thế hệ 2 siêu mỏng và mềm, đây là đôi giày mang lại <strong>cảm giác chạm bóng thuần túy nhất</strong> mà Nike từng sản xuất.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>NikeSkin 2.0:</strong> Upper siêu mỏng chỉ 1.5mm, mềm mại ôm bàn chân cho cảm giác chạm bóng "barefoot" (chân trần)</li>
  <li><strong>Grip Texture:</strong> Các đường vân nổi cực nhỏ trên khắp upper giúp kiểm soát bóng khi mưa</li>
  <li><strong>Flyknit Tongue:</strong> Lưỡi gà Flyknit liền mạch với upper, không bị lệch khi chạy</li>
  <li><strong>Đế TF:</strong> Đinh cao su ngắn phù hợp sân cỏ nhân tạo Việt Nam</li>
</ul>',
4200000, NULL, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-01.jpg', 'men', 2, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(37, 'Adidas Copa Pure 2 Elite TF',
'<h3>ADIDAS COPA PURE 2 ELITE TF - DA THẬT, CẢM GIÁC THẬT</h3>
<p>Copa là dòng giày bóng đá lâu đời nhất của Adidas, nổi tiếng với chất liệu da thật kangaroo mềm mịn. Copa Pure 2 là phiên bản hiện đại hóa với upper da K-Leather cao cấp, mang lại <strong>cảm giác chạm bóng ấm áp, mềm mại</strong> mà không dòng giày synthetic nào sánh được.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>K-Leather Upper:</strong> Da kangaroo tự nhiên cao cấp, mềm mịn và tạo hình theo bàn chân sau vài lần sử dụng</li>
  <li><strong>FUSIONSKIN:</strong> Lớp phủ bảo vệ chống thấm nước, giúp da bền hơn mà vẫn giữ cảm giác mềm mại</li>
  <li><strong>Speedframe:</strong> Khung đế nhẹ tối ưu cho chuyển hướng</li>
  <li><strong>Đế TF:</strong> Đinh ngắn phù hợp sân cỏ nhân tạo</li>
</ul>',
3800000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'men', 2, 2, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(38, 'Mizuno Alpha Elite TF',
'<h3>MIZUNO ALPHA ELITE TF - TINH HOA NHẬT BẢN TRÊN SÂN CỎ</h3>
<p>Mizuno Alpha Elite là đôi giày bóng đá <strong>Made in Japan</strong> chất lượng hàng đầu, được chế tác thủ công tại nhà máy Yamagata với sự tỉ mỉ đến từng đường kim mũi chỉ. Đây là lựa chọn của nhiều cầu thủ J-League và các giải đấu chuyên nghiệp châu Á.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>MIJ Upper:</strong> Da tổng hợp Nhật Bản siêu mỏng, mềm mại vượt trội, cho cảm giác chạm bóng tinh tế</li>
  <li><strong>Barefoot Fit:</strong> Form giày rộng rãi kiểu Nhật, thoải mái cho bàn chân châu Á thường bè hơn</li>
  <li><strong>D-Flex Groove:</strong> Rãnh linh hoạt ở đế giúp bàn chân gập tự nhiên khi chạy</li>
  <li><strong>Đế TF:</strong> Đinh cao su phù hợp sân cỏ nhân tạo</li>
</ul>',
3500000, 3900000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'men', 2, 10, 1);


-- ===================== GIÀY BÓNG RỔ (6 SP) =====================

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(39, 'Nike KD 16 EP Aura',
'<h3>NIKE KD 16 EP - SIGNATURE SHOE CỦA KEVIN DURANT</h3>
<p>KD 16 là đôi giày signature thế hệ thứ 16 của Kevin Durant, một trong những scorer vĩ đại nhất lịch sử NBA. Thiết kế lấy cảm hứng từ nghệ thuật origami Nhật Bản với các đường gấp tinh xảo trên upper.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Air Zoom Strobel:</strong> Đơn vị Zoom Air toàn chiều dài gắn trực tiếp vào lót giày, mang lại cảm giác sân gần (court feel) và phản hồi lực bùng nổ</li>
  <li><strong>Air Cushioning:</strong> Thêm 1 đơn vị Air ở phần gót chồng lên Zoom Strobel tạo đệm kép siêu êm khi tiếp đất</li>
  <li><strong>FlyWire:</strong> Dây cáp Flywire khóa chặt midfoot khi chuyển hướng đột ngột</li>
  <li><strong>EP Outsole:</strong> Đế ngoài EP (Engineered Performance) với rãnh xương cá bám sân gỗ indoor tuyệt vời</li>
</ul>

<h3>🏀 PHÙ HỢP VỚI AI?</h3>
<p>Guard/Forward linh hoạt, thích court feel gần sân và phản hồi lực nhanh. Cổ thấp linh hoạt cho cổ chân.</p>',
4200000, 4600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', 'men', 3, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(40, 'Adidas Harden Vol. 8',
'<h3>ADIDAS HARDEN VOL. 8 - VŨ KHÍ CỦA "THE BEARD" JAMES HARDEN</h3>
<p>Harden Vol. 8 được thiết kế cho lối chơi step-back đặc trưng của James Harden - dừng đột ngột, lùi lại, rồi tung cú ném 3 điểm chết người. Đế giày có hệ thống bám sân đặc biệt cho phép <strong>phanh gấp và đổi hướng trong nháy mắt</strong>.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Boost:</strong> Đệm Boost toàn chiều dài - êm ái và hoàn trả năng lượng khi bật nhảy</li>
  <li><strong>Torsion System:</strong> Thanh chống xoắn TPU ở giữa đế tăng ổn định khi pivot</li>
  <li><strong>Herringbone Outsole:</strong> Rãnh xương cá đa hướng bám sân gỗ cực tốt</li>
  <li><strong>Lace Cage:</strong> Hệ thống buộc dây với khung nhựa giữ chân ổn định</li>
</ul>

<h3>🏀 PHÙ HỢP VỚI AI?</h3>
<p>Guard thích iso play, step-back, crossover. Cần đệm êm và bám sân tốt.</p>',
3600000, 4000000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-4d-fusio-h04509-01.jpg', 'men', 3, 2, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(41, 'Under Armour Curry 11 Champion Mindset',
'<h3>UNDER ARMOUR CURRY 11 - "MINDSET" CỦA NHÀ VÔ ĐỊCH STEPHEN CURRY</h3>
<p>Curry 11 là tuyệt tác mới nhất trong dòng signature của Stephen Curry - tay ném 3 điểm vĩ đại nhất mọi thời đại. Đệm UA Flow không cao su mang lại <strong>cảm giác gần sân nhất có thể</strong> cho những cú cắt nhanh và ném bóng chính xác.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>UA Flow:</strong> Đệm đế giữa toàn chiều dài KHÔNG CÓ lớp cao su ngoài - bám sân trực tiếp bằng foam, siêu nhẹ và dính như keo</li>
  <li><strong>Curry Chassis:</strong> Khung ổn định TPU ở gót và midfoot, chống lật cổ chân khi chuyển hướng</li>
  <li><strong>UA Warp Upper:</strong> Upper dạng lưới đan chéo co giãn theo bàn chân</li>
  <li><strong>Trọng lượng:</strong> ~310g (size 42) - nhẹ bậc nhất phân khúc basketball</li>
</ul>

<h3>🏀 PHÙ HỢP VỚI AI?</h3>
<p>Point guard/Shooting guard thích di chuyển nhanh, cắt rổ không bóng, ném 3 điểm.</p>',
4500000, 4800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'men', 3, 9, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(42, 'Nike LeBron 21 Tahitian',
'<h3>NIKE LEBRON 21 - SỨC MẠNH CỦA VƯƠNG GIẢ</h3>
<p>LeBron 21 là signature shoe của LeBron James - cầu thủ bóng rổ vĩ đại nhất thế hệ. Đôi giày được thiết kế cho những cú lao vào rổ mạnh mẽ với <strong>đệm Zoom Air max volume lớn nhất</strong> từng được Nike đặt trong giày bóng rổ.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Max Volume Zoom Air:</strong> Đơn vị Zoom Air cỡ cực lớn ở mũi chân tạo lực đẩy bùng nổ</li>
  <li><strong>Air Max Unit:</strong> Đệm Air Max ở gót hấp thụ chấn khi tiếp đất nặng</li>
  <li><strong>Cable System:</strong> Hệ thống dây cáp tích hợp khóa chân ổn định</li>
  <li><strong>Outsole:</strong> Rãnh traction xương cá đa hướng, rộng</li>
</ul>

<h3>🏀 PHÙ HỢP VỚI AI?</h3>
<p>Power forward/Center thích lao rổ, cần đệm cực êm bảo vệ khớp. Cũng phù hợp cho cầu thủ nặng >80kg.</p>',
4900000, 5300000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', 'men', 3, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(43, 'Puma MB.03 LaMelo Ball Toxic',
'<h3>PUMA MB.03 - CÙNG LAMELO BALL PHÁ VỠ MỌI QUY TẮC</h3>
<p>MB.03 là signature shoe thế hệ 3 của LaMelo Ball - ngôi sao trẻ có phong cách chơi bóng rổ sáng tạo và phóng khoáng nhất NBA hiện tại. Thiết kế không lưỡi gà (laceless) <strong>cực kỳ táo bạo và khác biệt</strong>.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>NITRO Foam:</strong> Đệm NITRO được bơm khí nitrogen nhẹ và nảy</li>
  <li><strong>ProFoam+:</strong> Lớp đệm thứ hai ở gót tăng cường hấp thụ chấn</li>
  <li><strong>Laceless Design:</strong> Không lưỡi gà, upper bootie ôm chân liền mạch</li>
  <li><strong>Outsole:</strong> Cao su bám sân indoor tốt với họa tiết herringbone</li>
</ul>

<h3>🏀 PHÙ HỢP VỚI AI?</h3>
<p>Guard linh hoạt thích phong cách tự do. Thiết kế bắt mắt phù hợp cả chơi bóng lẫn đi casual.</p>',
3300000, 3800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'men', 3, 3, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(44, 'New Balance TWO WXY v4',
'<h3>NEW BALANCE TWO WXY V4 - NGỰA Ô CỦA SÂN BÓNG RỔ</h3>
<p>TWO WXY v4 là đôi giày bóng rổ performance tốt nhất của New Balance, được nhiều reviewer đánh giá là <strong>"best bang for your buck" (đáng tiền nhất)</strong> trong phân khúc. Kawhi Leonard và nhiều cầu thủ NBA cũng tin dùng dòng giày này.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>FuelCell:</strong> Đệm FuelCell được bơm khí nitrogen mang lại cảm giác nảy và phản hồi lực nhanh</li>
  <li><strong>Stability Wrap:</strong> Vành đế nhựa TPU bao quanh gót và midfoot tăng ổn định tối đa</li>
  <li><strong>Data-to-Design Upper:</strong> Upper được thiết kế dựa trên dữ liệu chuyển động của VĐV chuyên nghiệp</li>
  <li><strong>Herringbone Outsole:</strong> Đế xương cá bám sân gỗ cực dính</li>
</ul>',
3500000, 3900000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'men', 3, 4, 1);


-- ===================== DÉP & SANDAL (5 SP) =====================

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(45, 'Nike Calm Slide Black',
'<h3>NIKE CALM SLIDE - DÉP ĐANG LÀM MƯA LÀM GIÓ</h3>
<p>Nike Calm Slide là mẫu dép <strong>viral nhất mạng xã hội</strong> trong 2 năm qua. Thiết kế nguyên khối (one-piece) tinh giản bằng chất liệu xốp InjectedPhylon siêu mềm, tạo cảm giác như đi trên mây. Ai đã thử một lần đều không muốn tháo ra.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Chất liệu:</strong> InjectedPhylon nguyên khối, siêu nhẹ, chống thấm nước 100%</li>
  <li><strong>Đệm:</strong> Đế dày ~3cm cực kỳ êm ái, cảm giác "stepping on clouds"</li>
  <li><strong>Thiết kế:</strong> Tối giản, không logo lớn, phong cách minimalist</li>
  <li><strong>Rãnh đế:</strong> Rãnh chống trơn trượt phù hợp đi bể bơi, phòng tắm, đi mưa</li>
</ul>

<h3>📐 HƯỚNG DẪN CHỌN SIZE</h3>
<p>Calm Slide rộng bản, nên chọn <strong>đúng size hoặc giảm 1 size</strong> so với giày thể thao.</p>',
1200000, 1500000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'unisex', 5, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(46, 'Adidas Adilette 22 Slides',
'<h3>ADIDAS ADILETTE 22 - DÉP TỪ TƯƠNG LAI</h3>
<p>Adilette 22 sở hữu ngoại hình <strong>đậm chất sci-fi (khoa học viễn tưởng)</strong>, lấy cảm hứng từ bản đồ địa hình bề mặt sao Hỏa. Khác biệt hoàn toàn so với mẫu Adilette truyền thống, đây là đôi dép dành cho người muốn phong cách khác biệt, ĐỘC và LẠ.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Chất liệu:</strong> EVA làm từ mía (sugarcane-based EVA) thân thiện với môi trường</li>
  <li><strong>Thiết kế:</strong> Bề mặt terrain texture mô phỏng địa hình hành tinh, cực kỳ bắt mắt</li>
  <li><strong>Đế:</strong> Đế dày chunky tăng chiều cao ~3.5cm</li>
  <li><strong>3-Stripes:</strong> Ba sọc Adidas được tạo hình 3D trên quai dép</li>
</ul>',
1400000, 1600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'unisex', 5, 2, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(47, 'Vans La Costa Slide-On',
'<h3>VANS LA COSTA SLIDE-ON - PHONG CÁCH CALIFORNIA THOẢI MÁI</h3>
<p>Lấy cảm hứng từ bãi biển California đầy nắng, Vans La Costa Slide-On mang đến phong cách <strong>casual, thoải mái và năng động</strong>. Phù hợp cho những buổi dạo biển, đi cà phê cuối tuần hay đơn giản là nghỉ ngơi sau giờ làm việc.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Quai dép:</strong> EVA mềm mại với logo Vans Off The Wall dập nổi</li>
  <li><strong>Đế:</strong> UltraCush siêu êm, nhẹ và chống trơn trượt</li>
  <li><strong>Thiết kế:</strong> Checkerboard (caro) kinh điển trên quai dép</li>
</ul>',
900000, 1100000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'unisex', 5, 6, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(48, 'Puma Leadcat 2.0 Slides',
'<h3>PUMA LEADCAT 2.0 - DÉP QUAI NGANG KINH ĐIỂN</h3>
<p>Leadcat 2.0 là mẫu dép quai ngang truyền thống bán chạy nhất của Puma. Thiết kế đơn giản, tinh tế với logo Puma Cat dập nổi trên quai. Phù hợp cho mọi dịp từ đi bể bơi đến dạo phố cuối tuần.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Quai:</strong> Nhựa mềm một mảnh với logo Puma Cat dập nổi lớn</li>
  <li><strong>Đế:</strong> EVA nhẹ êm ái, rãnh chống trượt</li>
  <li><strong>Form:</strong> Rộng thoải mái, phù hợp cả nam và nữ</li>
</ul>',
750000, 900000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'unisex', 5, 3, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(49, 'New Balance 200 Slide V2',
'<h3>NEW BALANCE 200 SLIDE V2 - ĐƠN GIẢN MÀ CHẤT</h3>
<p>New Balance 200 Slide V2 dành cho những ai yêu thích sự tối giản mà vẫn muốn nổi bật với logo NB đặc trưng. Đệm CUSH+ êm ái cho đôi bàn chân nghỉ ngơi hoàn hảo.</p>

<h3>🔥 ĐIỂM NỔI BẬT</h3>
<ul>
  <li><strong>Đệm CUSH+:</strong> Công nghệ đệm êm ái độc quyền New Balance</li>
  <li><strong>Quai:</strong> Quai rộng có logo NB thêu nổi sang trọng</li>
  <li><strong>Đế:</strong> Cao su mềm chống trơn trượt</li>
</ul>',
800000, 950000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'unisex', 5, 4, 1);


-- ===================== GIÀY TENNIS (4 SP) =====================

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(50, 'Asics Gel-Resolution 9 Clay',
'<h3>ASICS GEL-RESOLUTION 9 - VUA GIÀY TENNIS BỀN BỈ</h3>
<p>Gel-Resolution 9 là đôi giày tennis bền bỉ nhất thị trường. Được thiết kế đặc biệt cho các cầu thủ <strong>baseliner (chơi cuối sân)</strong> với khả năng chịu mài mòn cực cao khi trượt trên mặt sân đất nện (clay) hoặc sân cứng.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>DYNAWALL:</strong> Hệ thống ổn định ở phần midfoot, chống lật cổ chân khi di chuyển ngang đột ngột</li>
  <li><strong>GEL Technology:</strong> Gel giảm chấn ở gót và mũi, bảo vệ khớp trong trận đấu dài</li>
  <li><strong>AHAR Plus Outsole:</strong> Đế cao su chống mài mòn bền gấp 3 lần cao su thường, đặc biệt ở vùng mũi chân</li>
  <li><strong>PGuard Toe Protector:</strong> Lớp bảo vệ mũi giày chống cọ xát khi lao về phía trước</li>
</ul>',
4100000, 4500000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'men', 6, 7, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(51, 'NikeCourt Zoom Vapor Pro 2 HC',
'<h3>NIKECOURT ZOOM VAPOR PRO 2 - TỐC ĐỘ TRÊN SÂN TENNIS</h3>
<p>Zoom Vapor Pro 2 là đôi giày tennis tốc độ của Nike, được nhiều tay vợt WTA sử dụng. Nhẹ, linh hoạt và phản hồi lực nhanh cho những cú trả bóng tấn công. Phiên bản HC (Hard Court) dành cho sân cứng.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Zoom Air:</strong> Đơn vị Zoom Air ở mũi chân cho cảm giác phản hồi nhanh khi lao về phía trước</li>
  <li><strong>Dynamic Fit System:</strong> Upper ôm chân tùy chỉnh theo cách buộc dây</li>
  <li><strong>Modified Herringbone:</strong> Đế xương cá cải tiến bám sân cứng tuyệt vời</li>
  <li><strong>Trọng lượng:</strong> ~305g (size 38) - nhẹ cho giày tennis nữ</li>
</ul>',
3200000, 3600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/m-plus-zoom-plus-gp-plus-challenge-plus-pro-plus-hc.jpg', 'women', 6, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(52, 'Adidas Barricade 13 Tennis',
'<h3>ADIDAS BARRICADE 13 - PHÁO ĐÀI BẤT KHẢ XÂM PHẠM</h3>
<p>Barricade là dòng giày tennis <strong>ổn định và bền bỉ nhất</strong> của Adidas, được đặt tên theo ý nghĩa "hàng rào phòng thủ kiên cố". Phù hợp cho người chơi thường xuyên, cần đôi giày chịu được cường độ tập luyện cao.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Bounce Pro:</strong> Đệm đế giữa Bounce Pro mới nhẹ hơn và đàn hồi hơn Bounce cũ</li>
  <li><strong>ADITUFF:</strong> Lớp bảo vệ mũi giày chống mài mòn khi trượt trên sân</li>
  <li><strong>3D Torsion System:</strong> Thanh chống xoắn 3 chiều ổn định bàn chân khi pivot</li>
  <li><strong>Adiwear Outsole:</strong> Đế cao su chống mài mòn bền bỉ ở khu vực mũi chân</li>
</ul>',
3800000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'men', 6, 2, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(53, 'New Balance Fresh Foam Lav v2',
'<h3>NEW BALANCE FRESH FOAM LAV V2 - ÊM ÁI NHẤT CHO TENNIS</h3>
<p>Fresh Foam Lav v2 là đôi giày tennis êm ái nhất của New Balance, mang công nghệ đệm Fresh Foam từ giày chạy bộ sang giày tennis. Phù hợp cho những người chơi cần <strong>sự thoải mái tối đa</strong> trong các trận đấu dài.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Fresh Foam:</strong> Đệm Fresh Foam siêu êm, giảm mệt mỏi bàn chân trong trận đấu dài 2-3 tiếng</li>
  <li><strong>Kinetic Stitch:</strong> Upper bằng lưới với các đường may kỹ thuật tạo hỗ trợ mà không bó chân</li>
  <li><strong>NDure Outsole:</strong> Đế cao su bền bỉ với rãnh herringbone bám đa hướng</li>
</ul>',
3000000, 3400000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-3.jpg', 'women', 6, 4, 1);


-- ===================== GIÀY TRAINING / GYM (4 SP) =====================

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(54, 'Nike Metcon 9 AMP',
'<h3>NIKE METCON 9 - KING OF THE GYM, VUA PHÒNG TẬP TẠ</h3>
<p>Metcon là dòng giày tập gym/CrossFit <strong>bán chạy nhất thế giới suốt 9 đời</strong> liên tiếp. Nếu bạn nghiêm túc với việc nâng tạ (Squat, Deadlift, Clean & Jerk), thì Metcon 9 chính là lựa chọn không thể thay thế.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Hyperlift Insert:</strong> Tấm nâng gót bằng nhựa cứng giúp Squat sâu hơn, giữ gót ổn định khi nâng tạ nặng</li>
  <li><strong>Đế phẳng:</strong> Đế cao su cực phẳng, cứng, tạo nền tảng vững chắc cho deadlift</li>
  <li><strong>Rope Wrap:</strong> Lớp cao su bọc quanh phần giữa giày bảo vệ khi leo dây thừng (rope climb)</li>
  <li><strong>React Foam:</strong> Đệm React ở mũi giày cho các bài cardio, box jump</li>
  <li><strong>Trọng lượng:</strong> ~340g (size 42)</li>
</ul>

<h3>🏋️ PHÙ HỢP VỚI AI?</h3>
<p>Gymer tập nặng, CrossFitter, người tập cử tạ. KHÔNG phù hợp để chạy bộ đường dài (đế quá cứng và phẳng).</p>',
3800000, 4200000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'men', 7, 1, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(55, 'Reebok Nano X3 Adventure',
'<h3>REEBOK NANO X3 - CHIẾN BINH CROSSFIT HUYỀN THOẠI</h3>
<p>Reebok Nano là dòng giày gắn liền với CrossFit từ thuở sơ khai. Nano X3 là phiên bản thứ 13 với hệ thống đệm <strong>Lift and Run</strong> thông minh - tự động cứng lại khi bạn nâng tạ và mềm đi khi bạn chạy.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>Lift & Run Chassis:</strong> Hệ thống khung đế kép: cứng cho nâng tạ, linh hoạt cho chạy bộ ngắn</li>
  <li><strong>Floatride Energy Foam:</strong> Đệm Floatride ở mũi chân cho cảm giác nảy khi box jump, burpee</li>
  <li><strong>Flexweave Knit Upper:</strong> Vải dệt Flexweave bền bỉ, thoáng khí, chống rách</li>
  <li><strong>Heel Clip:</strong> Khung nhựa ôm gót ổn định khi nâng tạ nặng</li>
</ul>

<h3>🏋️ PHÙ HỢP VỚI AI?</h3>
<p>CrossFitter, người tập HIIT, Functional Training. Versatile cho cả nâng tạ lẫn cardio.</p>',
3400000, 3800000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-01-standard.jpg', 'unisex', 7, 8, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(56, 'Under Armour TriBase Reign 6',
'<h3>UNDER ARMOUR TRIBASE REIGN 6 - NỀN TẢNG VỮNG CHẮC</h3>
<p>TriBase Reign 6 sở hữu công nghệ đế 3 điểm chạm <strong>TriBase™</strong> giúp bàn chân tiếp đất với 3 điểm tựa ổn định (gót, mu bàn chân ngoài, mu bàn chân trong), mang lại nền tảng vững chắc nhất cho mọi bài nâng tạ.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>TriBase™:</strong> 3 điểm tiếp đất tối ưu cho nâng tạ ổn định, giảm thiểu lắc lư</li>
  <li><strong>Micro G Foam:</strong> Đệm Micro G mỏng nhẹ, tạo cảm giác gần sàn (ground feel)</li>
  <li><strong>Full Rubber Outsole:</strong> Đế cao su toàn bộ, grip tốt trên sàn phòng tập</li>
  <li><strong>External Heel Counter:</strong> Khung gót ngoài ổn định cổ chân</li>
</ul>',
3200000, 3600000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'men', 7, 9, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(57, 'Puma Fuse 3.0 Training',
'<h3>PUMA FUSE 3.0 - GIÀY TẬP GYM DÀNH CHO NỮ</h3>
<p>Puma Fuse 3.0 được thiết kế đặc biệt cho phái nữ yêu thích gym và fitness. Form dáng thon gọn, nhẹ nhàng nhưng vẫn đảm bảo độ ổn định khi tập các bài nặng như Squat, Lunge, và các bài HIIT.</p>

<h3>🔥 CÔNG NGHỆ</h3>
<ul>
  <li><strong>FUSIONFIT:</strong> Upper ôm chân linh hoạt theo mọi hướng chuyển động</li>
  <li><strong>SOFTRIDE:</strong> Đệm SOFTRIDE êm ái ở phần trước, thoải mái cho cardio</li>
  <li><strong>Rubber Outsole:</strong> Đế cao su phẳng, grip tốt, ổn định cho nâng tạ</li>
  <li><strong>Trọng lượng:</strong> ~255g (size 38) - siêu nhẹ cho giày training</li>
</ul>',
2500000, 2900000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'women', 7, 3, 1);


-- ===================== PHỤ KIỆN CHĂM SÓC GIÀY (3 SP) =====================

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(58, 'Bộ Vệ Sinh Giày Chuyên Sâu Premium',
'<h3>BỘ VỆ SINH GIÀY CHUYÊN SÂU - GIÀY SẠCH NHƯ MỚI</h3>
<p>Bộ kit vệ sinh giày cao cấp bao gồm tất cả những gì bạn cần để giữ cho đôi sneaker yêu quý luôn sạch sẽ và mới đẹp như ngày đầu. Dung dịch vệ sinh gốc thực vật an toàn cho <strong>mọi loại chất liệu</strong>: da, vải, mesh, suede, canvas, knit.</p>

<h3>📦 BỘ KIT BAO GỒM</h3>
<ul>
  <li><strong>1x Dung dịch vệ sinh 150ml:</strong> Gốc thực vật, không chứa hóa chất mạnh, an toàn cho mọi vật liệu</li>
  <li><strong>1x Bàn chải lông heo tự nhiên:</strong> Lông mềm không làm xước vải và da, phù hợp upper giày</li>
  <li><strong>1x Bàn chải cứng nhỏ:</strong> Dùng cho đế và midsole cáu bẩn nặng</li>
  <li><strong>1x Khăn microfiber:</strong> Siêu mềm, hút nước tốt, dùng lau khô giày sau khi vệ sinh</li>
  <li><strong>1x Túi đựng giày du lịch:</strong> Vải dù chống bụi, tiện mang đi travel</li>
</ul>

<h3>📋 HƯỚNG DẪN SỬ DỤNG</h3>
<p>1. Pha dung dịch với nước theo tỉ lệ 1:10 → 2. Nhúng bàn chải vào dung dịch → 3. Chà nhẹ theo vòng tròn → 4. Lau sạch bằng khăn microfiber → 5. Phơi khô thoáng gió (KHÔNG phơi nắng trực tiếp).</p>',
550000, 650000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-01.jpg?v=1694779868303', 'unisex', 8, 10, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(59, 'Bình Xịt Nano Chống Thấm Nước Giày',
'<h3>BÌNH XỊT NANO CHỐNG THẤM NƯỚC - BẢO VỆ GIÀY DƯỚI MƯA</h3>
<p>Xịt nano siêu kỵ nước tạo lớp bảo vệ vô hình trên bề mặt giày, giúp đôi sneaker của bạn <strong>hoàn toàn không thấm nước</strong> khi gặp mưa hoặc nước bắn. Nước sẽ lăn ra khỏi giày như giọt nước trên lá sen.</p>

<h3>🔥 ĐẶC ĐIỂM</h3>
<ul>
  <li><strong>Dung tích:</strong> 250ml, đủ xịt cho 8-10 đôi giày</li>
  <li><strong>Công nghệ:</strong> Nano Fluorocarbon tạo lớp phủ siêu kỵ nước vô hình</li>
  <li><strong>Tương thích:</strong> Mọi loại vải: canvas, mesh, suede, leather, knit</li>
  <li><strong>Hiệu lực:</strong> Kéo dài 3-4 tuần cho mỗi lần xịt</li>
  <li><strong>Không mùi:</strong> Không gây dị ứng, an toàn cho da tay</li>
</ul>',
280000, 350000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-01.jpg?v=1694779868303', 'unisex', 8, 10, 1);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `old_price`, `image_url`, `gender`, `category_id`, `brand_id`, `active`) VALUES
(60, 'Pack 3 đôi Vớ Thể Thao Nike Everyday Cushion',
'<h3>VỚ NIKE EVERYDAY CUSHION - BẠN ĐỒNG HÀNH HOÀN HẢO CỦA MỌI ĐÔI GIÀY</h3>
<p>Đôi giày tốt cần đi kèm đôi vớ tốt. Nike Everyday Cushion là dòng vớ thể thao <strong>bán chạy nhất của Nike</strong>, được hàng triệu vận động viên và người dùng tin tưởng sử dụng hằng ngày.</p>

<h3>📦 GÓI SẢN PHẨM</h3>
<ul>
  <li><strong>Số lượng:</strong> Pack 3 đôi (1 Trắng + 1 Đen + 1 Xám)</li>
  <li><strong>Cổ vớ:</strong> Crew (cổ lửng ngang bắp chân)</li>
  <li><strong>Chất liệu:</strong> 71% Cotton + 26% Polyester + 3% Spandex</li>
</ul>

<h3>🔥 TÍNH NĂNG</h3>
<ul>
  <li><strong>Dri-FIT:</strong> Công nghệ thấm hút mồ hôi cực mạnh, giữ chân luôn khô ráo dù tập luyện căng thẳng</li>
  <li><strong>Cushioning:</strong> Đệm lót ở lòng bàn chân giảm phồng rộp khi chạy bộ hoặc chơi thể thao</li>
  <li><strong>Arch Support:</strong> Dải đàn hồi ôm vòm bàn chân tạo cảm giác chắc chắn</li>
  <li><strong>Ribbed Cuff:</strong> Cổ vớ đàn hồi không bị tuột xuống khi vận động</li>
</ul>',
350000, 420000, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'unisex', 8, 1, 1);


-- ============ PHẦN 3: THÊM BIẾN THỂ (VARIANTS) - NHIỀU MÀU × NHIỀU SIZE ============

INSERT INTO `product_variants` (`product_id`, `color`, `size`, `stock_qty`, `sku`) VALUES
-- SP 11: AF1 - 3 màu (White, Black, Grey) × 5 size = 15 variants
(11, 'White', '38', 8, 'AF1-WHT-38'), (11, 'White', '39', 15, 'AF1-WHT-39'), (11, 'White', '40', 22, 'AF1-WHT-40'), (11, 'White', '41', 18, 'AF1-WHT-41'), (11, 'White', '42', 10, 'AF1-WHT-42'),
(11, 'Black', '38', 4, 'AF1-BLK-38'), (11, 'Black', '39', 6, 'AF1-BLK-39'), (11, 'Black', '40', 12, 'AF1-BLK-40'), (11, 'Black', '41', 9, 'AF1-BLK-41'), (11, 'Black', '42', 14, 'AF1-BLK-42'),
(11, 'Grey', '39', 3, 'AF1-GRY-39'), (11, 'Grey', '40', 7, 'AF1-GRY-40'), (11, 'Grey', '41', 11, 'AF1-GRY-41'), (11, 'Grey', '42', 5, 'AF1-GRY-42'), (11, 'Grey', '43', 2, 'AF1-GRY-43'),

-- SP 12: Samba - 2 màu (Black, White) × 5 size = 10 variants
(12, 'Black', '38', 5, 'SAM-BLK-38'), (12, 'Black', '39', 12, 'SAM-BLK-39'), (12, 'Black', '40', 19, 'SAM-BLK-40'), (12, 'Black', '41', 25, 'SAM-BLK-41'), (12, 'Black', '42', 11, 'SAM-BLK-42'),
(12, 'White', '38', 7, 'SAM-WHT-38'), (12, 'White', '39', 14, 'SAM-WHT-39'), (12, 'White', '40', 20, 'SAM-WHT-40'), (12, 'White', '41', 16, 'SAM-WHT-41'), (12, 'White', '42', 8, 'SAM-WHT-42'),

-- SP 13: NB 550 - 3 màu (White Green, White Grey, White Red) × 4 size = 12 variants
(13, 'White Green', '39', 8, 'NB550-WG-39'), (13, 'White Green', '40', 13, 'NB550-WG-40'), (13, 'White Green', '41', 20, 'NB550-WG-41'), (13, 'White Green', '42', 6, 'NB550-WG-42'),
(13, 'White Grey', '39', 10, 'NB550-WGR-39'), (13, 'White Grey', '40', 16, 'NB550-WGR-40'), (13, 'White Grey', '41', 12, 'NB550-WGR-41'), (13, 'White Grey', '42', 4, 'NB550-WGR-42'),
(13, 'White Red', '39', 5, 'NB550-WR-39'), (13, 'White Red', '40', 9, 'NB550-WR-40'), (13, 'White Red', '41', 14, 'NB550-WR-41'), (13, 'White Red', '42', 3, 'NB550-WR-42'),

-- SP 14: Puma Palermo - 2 màu (White, Pink) × 4 size = 8 variants
(14, 'White', '36', 12, 'PAL-WHT-36'), (14, 'White', '37', 18, 'PAL-WHT-37'), (14, 'White', '38', 9, 'PAL-WHT-38'), (14, 'White', '39', 6, 'PAL-WHT-39'),
(14, 'Pink', '36', 15, 'PAL-PNK-36'), (14, 'Pink', '37', 21, 'PAL-PNK-37'), (14, 'Pink', '38', 11, 'PAL-PNK-38'), (14, 'Pink', '39', 4, 'PAL-PNK-39'),

-- SP 15: Chuck 70 - 2 màu (Black, Red) × 5 size = 10 variants
(15, 'Black', '38', 14, 'C70-BLK-38'), (15, 'Black', '39', 22, 'C70-BLK-39'), (15, 'Black', '40', 19, 'C70-BLK-40'), (15, 'Black', '41', 11, 'C70-BLK-41'), (15, 'Black', '42', 7, 'C70-BLK-42'),
(15, 'Red', '38', 8, 'C70-RED-38'), (15, 'Red', '39', 13, 'C70-RED-39'), (15, 'Red', '40', 16, 'C70-RED-40'), (15, 'Red', '41', 5, 'C70-RED-41'), (15, 'Red', '42', 3, 'C70-RED-42'),

-- SP 16: Vans Old Skool - 3 màu (Black White, Navy, Red) × 4 size = 12 variants
(16, 'Black White', '39', 16, 'VOS-BW-39'), (16, 'Black White', '40', 24, 'VOS-BW-40'), (16, 'Black White', '41', 20, 'VOS-BW-41'), (16, 'Black White', '42', 13, 'VOS-BW-42'),
(16, 'Navy', '39', 8, 'VOS-NAV-39'), (16, 'Navy', '40', 11, 'VOS-NAV-40'), (16, 'Navy', '41', 6, 'VOS-NAV-41'), (16, 'Navy', '42', 3, 'VOS-NAV-42'),
(16, 'Red', '39', 5, 'VOS-RED-39'), (16, 'Red', '40', 9, 'VOS-RED-40'), (16, 'Red', '41', 7, 'VOS-RED-41'), (16, 'Red', '42', 2, 'VOS-RED-42'),

-- SP 17: Dunk Low - 3 màu (Black White, Grey Fog, Green) × 5 size = 15 variants
(17, 'Black White', '38', 3, 'DL-BW-38'), (17, 'Black White', '39', 5, 'DL-BW-39'), (17, 'Black White', '40', 3, 'DL-BW-40'), (17, 'Black White', '41', 8, 'DL-BW-41'), (17, 'Black White', '42', 2, 'DL-BW-42'),
(17, 'Grey Fog', '38', 7, 'DL-GF-38'), (17, 'Grey Fog', '39', 12, 'DL-GF-39'), (17, 'Grey Fog', '40', 18, 'DL-GF-40'), (17, 'Grey Fog', '41', 15, 'DL-GF-41'), (17, 'Grey Fog', '42', 9, 'DL-GF-42'),
(17, 'Green', '39', 4, 'DL-GRN-39'), (17, 'Green', '40', 7, 'DL-GRN-40'), (17, 'Green', '41', 10, 'DL-GRN-41'), (17, 'Green', '42', 4, 'DL-GRN-42'), (17, 'Green', '43', 6, 'DL-GRN-43'),

-- SP 18: Gazelle Bold - 3 màu (Green, Black, Pink) × 4 size = 12 variants
(18, 'Green', '36', 9, 'GAZ-GRN-36'), (18, 'Green', '37', 14, 'GAZ-GRN-37'), (18, 'Green', '38', 7, 'GAZ-GRN-38'), (18, 'Green', '39', 3, 'GAZ-GRN-39'),
(18, 'Black', '36', 11, 'GAZ-BLK-36'), (18, 'Black', '37', 16, 'GAZ-BLK-37'), (18, 'Black', '38', 8, 'GAZ-BLK-38'), (18, 'Black', '39', 5, 'GAZ-BLK-39'),
(18, 'Pink', '36', 13, 'GAZ-PNK-36'), (18, 'Pink', '37', 19, 'GAZ-PNK-37'), (18, 'Pink', '38', 10, 'GAZ-PNK-38'), (18, 'Pink', '39', 4, 'GAZ-PNK-39'),

-- SP 19: NB 2002R - 2 màu (Grey, Brown) × 4 size = 8 variants
(19, 'Grey', '40', 6, 'NB2002-GRY-40'), (19, 'Grey', '41', 10, 'NB2002-GRY-41'), (19, 'Grey', '42', 15, 'NB2002-GRY-42'), (19, 'Grey', '43', 4, 'NB2002-GRY-43'),
(19, 'Brown', '40', 3, 'NB2002-BRN-40'), (19, 'Brown', '41', 7, 'NB2002-BRN-41'), (19, 'Brown', '42', 9, 'NB2002-BRN-42'), (19, 'Brown', '43', 2, 'NB2002-BRN-43'),

-- SP 20: Run Star Hike - 2 màu (Black, White) × 4 size = 8 variants
(20, 'Black', '36', 8, 'RSH-BLK-36'), (20, 'Black', '37', 13, 'RSH-BLK-37'), (20, 'Black', '38', 5, 'RSH-BLK-38'), (20, 'Black', '39', 3, 'RSH-BLK-39'),
(20, 'White', '36', 6, 'RSH-WHT-36'), (20, 'White', '37', 10, 'RSH-WHT-37'), (20, 'White', '38', 7, 'RSH-WHT-38'), (20, 'White', '39', 2, 'RSH-WHT-39'),

-- SP 21: SK8-Hi - 2 màu (Black, Navy) × 4 size = 8 variants
(21, 'Black', '39', 11, 'SK8-BLK-39'), (21, 'Black', '40', 17, 'SK8-BLK-40'), (21, 'Black', '41', 9, 'SK8-BLK-41'), (21, 'Black', '42', 5, 'SK8-BLK-42'),
(21, 'Navy', '39', 5, 'SK8-NAV-39'), (21, 'Navy', '40', 8, 'SK8-NAV-40'), (21, 'Navy', '41', 6, 'SK8-NAV-41'), (21, 'Navy', '42', 3, 'SK8-NAV-42'),

-- SP 22: Puma Suede - 2 màu (Navy, Black) × 5 size = 10 variants
(22, 'Navy', '39', 8, 'PSD-NAV-39'), (22, 'Navy', '40', 14, 'PSD-NAV-40'), (22, 'Navy', '41', 21, 'PSD-NAV-41'), (22, 'Navy', '42', 12, 'PSD-NAV-42'), (22, 'Navy', '43', 6, 'PSD-NAV-43'),
(22, 'Black', '39', 5, 'PSD-BLK-39'), (22, 'Black', '40', 10, 'PSD-BLK-40'), (22, 'Black', '41', 16, 'PSD-BLK-41'), (22, 'Black', '42', 9, 'PSD-BLK-42'), (22, 'Black', '43', 3, 'PSD-BLK-43'),

-- SP 23: Vaporfly - 3 màu (Volt, Pink, Black) × 4 size = 12 variants
(23, 'Volt', '39', 2, 'VPF-VLT-39'), (23, 'Volt', '40', 3, 'VPF-VLT-40'), (23, 'Volt', '41', 5, 'VPF-VLT-41'), (23, 'Volt', '42', 2, 'VPF-VLT-42'),
(23, 'Pink', '39', 4, 'VPF-PNK-39'), (23, 'Pink', '40', 6, 'VPF-PNK-40'), (23, 'Pink', '41', 8, 'VPF-PNK-41'), (23, 'Pink', '42', 3, 'VPF-PNK-42'),
(23, 'Black', '39', 1, 'VPF-BLK-39'), (23, 'Black', '40', 4, 'VPF-BLK-40'), (23, 'Black', '41', 3, 'VPF-BLK-41'), (23, 'Black', '42', 2, 'VPF-BLK-42'),

-- SP 24: Boston 12 - 2 màu (Black, White) × 5 size = 10 variants
(24, 'Black', '36', 10, 'BOS-BLK-36'), (24, 'Black', '37', 18, 'BOS-BLK-37'), (24, 'Black', '38', 14, 'BOS-BLK-38'), (24, 'Black', '39', 8, 'BOS-BLK-39'), (24, 'Black', '40', 5, 'BOS-BLK-40'),
(24, 'White', '36', 6, 'BOS-WHT-36'), (24, 'White', '37', 12, 'BOS-WHT-37'), (24, 'White', '38', 9, 'BOS-WHT-38'), (24, 'White', '39', 5, 'BOS-WHT-39'), (24, 'White', '40', 3, 'BOS-WHT-40'),

-- SP 25: Novablast - 3 màu (Blue, White, Black) × 4 size = 12 variants
(25, 'Blue', '40', 12, 'NOV-BLU-40'), (25, 'Blue', '41', 18, 'NOV-BLU-41'), (25, 'Blue', '42', 9, 'NOV-BLU-42'), (25, 'Blue', '43', 4, 'NOV-BLU-43'),
(25, 'White', '40', 7, 'NOV-WHT-40'), (25, 'White', '41', 14, 'NOV-WHT-41'), (25, 'White', '42', 8, 'NOV-WHT-42'), (25, 'White', '43', 5, 'NOV-WHT-43'),
(25, 'Black', '40', 6, 'NOV-BLK-40'), (25, 'Black', '41', 10, 'NOV-BLK-41'), (25, 'Black', '42', 16, 'NOV-BLK-42'), (25, 'Black', '43', 3, 'NOV-BLK-43'),

-- SP 26: FuelCell SC Elite - 2 màu (White Red, Neon Yellow) × 3 size = 6 variants
(26, 'White Red', '41', 2, 'SCE-WR-41'), (26, 'White Red', '42', 4, 'SCE-WR-42'), (26, 'White Red', '43', 1, 'SCE-WR-43'),
(26, 'Neon Yellow', '41', 3, 'SCE-NY-41'), (26, 'Neon Yellow', '42', 5, 'SCE-NY-42'), (26, 'Neon Yellow', '43', 2, 'SCE-NY-43'),

-- SP 27: Pegasus 41 - 3 màu (Pink, Black, White) × 5 size = 15 variants
(27, 'Pink', '36', 15, 'PEG-PNK-36'), (27, 'Pink', '37', 22, 'PEG-PNK-37'), (27, 'Pink', '38', 18, 'PEG-PNK-38'), (27, 'Pink', '39', 10, 'PEG-PNK-39'), (27, 'Pink', '40', 5, 'PEG-PNK-40'),
(27, 'Black', '36', 8, 'PEG-BLK-36'), (27, 'Black', '37', 13, 'PEG-BLK-37'), (27, 'Black', '38', 11, 'PEG-BLK-38'), (27, 'Black', '39', 6, 'PEG-BLK-39'), (27, 'Black', '40', 3, 'PEG-BLK-40'),
(27, 'White', '36', 5, 'PEG-WHT-36'), (27, 'White', '37', 9, 'PEG-WHT-37'), (27, 'White', '38', 7, 'PEG-WHT-38'), (27, 'White', '39', 4, 'PEG-WHT-39'), (27, 'White', '40', 2, 'PEG-WHT-40'),

-- SP 28: Wave Rebellion - 2 màu (Yellow, Black) × 4 size = 8 variants
(28, 'Yellow', '40', 4, 'WRB-YEL-40'), (28, 'Yellow', '41', 7, 'WRB-YEL-41'), (28, 'Yellow', '42', 5, 'WRB-YEL-42'), (28, 'Yellow', '43', 3, 'WRB-YEL-43'),
(28, 'Black', '40', 6, 'WRB-BLK-40'), (28, 'Black', '41', 9, 'WRB-BLK-41'), (28, 'Black', '42', 8, 'WRB-BLK-42'), (28, 'Black', '43', 4, 'WRB-BLK-43'),

-- SP 29: Ultraboost Light - 3 màu (White, Black, Navy) × 5 size = 15 variants
(29, 'White', '38', 6, 'UBL-WHT-38'), (29, 'White', '39', 11, 'UBL-WHT-39'), (29, 'White', '40', 19, 'UBL-WHT-40'), (29, 'White', '41', 15, 'UBL-WHT-41'), (29, 'White', '42', 8, 'UBL-WHT-42'),
(29, 'Black', '38', 4, 'UBL-BLK-38'), (29, 'Black', '39', 7, 'UBL-BLK-39'), (29, 'Black', '40', 14, 'UBL-BLK-40'), (29, 'Black', '41', 20, 'UBL-BLK-41'), (29, 'Black', '42', 12, 'UBL-BLK-42'),
(29, 'Navy', '38', 3, 'UBL-NAV-38'), (29, 'Navy', '39', 5, 'UBL-NAV-39'), (29, 'Navy', '40', 8, 'UBL-NAV-40'), (29, 'Navy', '41', 10, 'UBL-NAV-41'), (29, 'Navy', '42', 6, 'UBL-NAV-42'),

-- SP 30: Gel-Kayano - 2 màu (Grey, Blue) × 4 size = 8 variants
(30, 'Grey', '36', 9, 'KAY-GRY-36'), (30, 'Grey', '37', 14, 'KAY-GRY-37'), (30, 'Grey', '38', 7, 'KAY-GRY-38'), (30, 'Grey', '39', 4, 'KAY-GRY-39'),
(30, 'Blue', '36', 5, 'KAY-BLU-36'), (30, 'Blue', '37', 10, 'KAY-BLU-37'), (30, 'Blue', '38', 8, 'KAY-BLU-38'), (30, 'Blue', '39', 3, 'KAY-BLU-39'),

-- SP 31: Velocity Nitro - 2 màu (Black, White) × 5 size = 10 variants
(31, 'Black', '39', 10, 'VN3-BLK-39'), (31, 'Black', '40', 16, 'VN3-BLK-40'), (31, 'Black', '41', 22, 'VN3-BLK-41'), (31, 'Black', '42', 14, 'VN3-BLK-42'), (31, 'Black', '43', 8, 'VN3-BLK-43'),
(31, 'White', '39', 5, 'VN3-WHT-39'), (31, 'White', '40', 10, 'VN3-WHT-40'), (31, 'White', '41', 15, 'VN3-WHT-41'), (31, 'White', '42', 9, 'VN3-WHT-42'), (31, 'White', '43', 4, 'VN3-WHT-43'),

-- SP 32: HOVR Machina - 2 màu (Black Red, Grey Blue) × 4 size = 8 variants
(32, 'Black Red', '40', 8, 'HVM-BR-40'), (32, 'Black Red', '41', 12, 'HVM-BR-41'), (32, 'Black Red', '42', 10, 'HVM-BR-42'), (32, 'Black Red', '43', 5, 'HVM-BR-43'),
(32, 'Grey Blue', '40', 4, 'HVM-GB-40'), (32, 'Grey Blue', '41', 7, 'HVM-GB-41'), (32, 'Grey Blue', '42', 6, 'HVM-GB-42'), (32, 'Grey Blue', '43', 3, 'HVM-GB-43'),

-- SP 33: Mercurial - 3 màu (Volt, Black, White) × 4 size = 12 variants
(33, 'Volt', '39', 2, 'MER-VLT-39'), (33, 'Volt', '40', 3, 'MER-VLT-40'), (33, 'Volt', '41', 6, 'MER-VLT-41'), (33, 'Volt', '42', 4, 'MER-VLT-42'),
(33, 'Black', '39', 4, 'MER-BLK-39'), (33, 'Black', '40', 5, 'MER-BLK-40'), (33, 'Black', '41', 9, 'MER-BLK-41'), (33, 'Black', '42', 7, 'MER-BLK-42'),
(33, 'White', '39', 3, 'MER-WHT-39'), (33, 'White', '40', 6, 'MER-WHT-40'), (33, 'White', '41', 8, 'MER-WHT-41'), (33, 'White', '42', 5, 'MER-WHT-42'),

-- SP 34: Predator - 2 màu (Black Red, White Gold) × 4 size = 8 variants
(34, 'Black Red', '39', 6, 'PRD-BR-39'), (34, 'Black Red', '40', 11, 'PRD-BR-40'), (34, 'Black Red', '41', 8, 'PRD-BR-41'), (34, 'Black Red', '42', 4, 'PRD-BR-42'),
(34, 'White Gold', '39', 3, 'PRD-WG-39'), (34, 'White Gold', '40', 7, 'PRD-WG-40'), (34, 'White Gold', '41', 5, 'PRD-WG-41'), (34, 'White Gold', '42', 2, 'PRD-WG-42'),

-- SP 35: Future TF - 2 màu (Blue, White) × 4 size = 8 variants
(35, 'Blue', '39', 9, 'FUT-BLU-39'), (35, 'Blue', '40', 14, 'FUT-BLU-40'), (35, 'Blue', '41', 7, 'FUT-BLU-41'), (35, 'Blue', '42', 4, 'FUT-BLU-42'),
(35, 'White', '39', 5, 'FUT-WHT-39'), (35, 'White', '40', 10, 'FUT-WHT-40'), (35, 'White', '41', 8, 'FUT-WHT-41'), (35, 'White', '42', 3, 'FUT-WHT-42'),

-- SP 36: Phantom GX 2 - 2 màu (Crimson, Black) × 4 size = 8 variants
(36, 'Crimson', '39', 3, 'PHG-CRM-39'), (36, 'Crimson', '40', 6, 'PHG-CRM-40'), (36, 'Crimson', '41', 10, 'PHG-CRM-41'), (36, 'Crimson', '42', 4, 'PHG-CRM-42'),
(36, 'Black', '39', 5, 'PHG-BLK-39'), (36, 'Black', '40', 8, 'PHG-BLK-40'), (36, 'Black', '41', 12, 'PHG-BLK-41'), (36, 'Black', '42', 6, 'PHG-BLK-42'),

-- SP 37: Copa Pure - 2 màu (Black, White) × 4 size = 8 variants
(37, 'Black', '39', 8, 'COP-BLK-39'), (37, 'Black', '40', 15, 'COP-BLK-40'), (37, 'Black', '41', 12, 'COP-BLK-41'), (37, 'Black', '42', 6, 'COP-BLK-42'),
(37, 'White', '39', 4, 'COP-WHT-39'), (37, 'White', '40', 9, 'COP-WHT-40'), (37, 'White', '41', 7, 'COP-WHT-41'), (37, 'White', '42', 3, 'COP-WHT-42'),

-- SP 38: Mizuno Alpha - 2 màu (White, Black) × 3 size = 6 variants
(38, 'White', '40', 3, 'MZA-WHT-40'), (38, 'White', '41', 5, 'MZA-WHT-41'), (38, 'White', '42', 2, 'MZA-WHT-42'),
(38, 'Black', '40', 4, 'MZA-BLK-40'), (38, 'Black', '41', 7, 'MZA-BLK-41'), (38, 'Black', '42', 3, 'MZA-BLK-42'),

-- SP 39: KD 16 - 3 màu (Aura, Black, White) × 4 size = 12 variants
(39, 'Aura', '40', 4, 'KD16-AUR-40'), (39, 'Aura', '41', 7, 'KD16-AUR-41'), (39, 'Aura', '42', 11, 'KD16-AUR-42'), (39, 'Aura', '43', 5, 'KD16-AUR-43'),
(39, 'Black', '40', 3, 'KD16-BLK-40'), (39, 'Black', '41', 4, 'KD16-BLK-41'), (39, 'Black', '42', 8, 'KD16-BLK-42'), (39, 'Black', '43', 3, 'KD16-BLK-43'),
(39, 'White', '40', 2, 'KD16-WHT-40'), (39, 'White', '41', 6, 'KD16-WHT-41'), (39, 'White', '42', 9, 'KD16-WHT-42'), (39, 'White', '43', 4, 'KD16-WHT-43'),

-- SP 40: Harden Vol 8 - 2 màu (White Red, Black Silver) × 4 size = 8 variants
(40, 'White Red', '40', 9, 'HAR-WR-40'), (40, 'White Red', '41', 14, 'HAR-WR-41'), (40, 'White Red', '42', 10, 'HAR-WR-42'), (40, 'White Red', '43', 5, 'HAR-WR-43'),
(40, 'Black Silver', '40', 5, 'HAR-BS-40'), (40, 'Black Silver', '41', 8, 'HAR-BS-41'), (40, 'Black Silver', '42', 6, 'HAR-BS-42'), (40, 'Black Silver', '43', 3, 'HAR-BS-43'),

-- SP 41: Curry 11 - 2 màu (White Blue, Black Gold) × 4 size = 8 variants
(41, 'White Blue', '40', 4, 'CUR-WB-40'), (41, 'White Blue', '41', 6, 'CUR-WB-41'), (41, 'White Blue', '42', 10, 'CUR-WB-42'), (41, 'White Blue', '43', 4, 'CUR-WB-43'),
(41, 'Black Gold', '40', 3, 'CUR-BG-40'), (41, 'Black Gold', '41', 8, 'CUR-BG-41'), (41, 'Black Gold', '42', 12, 'CUR-BG-42'), (41, 'Black Gold', '43', 5, 'CUR-BG-43'),

-- SP 42: LeBron 21 - 2 màu (Tahitian, Black) × 4 size = 8 variants
(42, 'Tahitian', '41', 3, 'LBR-TAH-41'), (42, 'Tahitian', '42', 4, 'LBR-TAH-42'), (42, 'Tahitian', '43', 7, 'LBR-TAH-43'), (42, 'Tahitian', '44', 3, 'LBR-TAH-44'),
(42, 'Black', '41', 5, 'LBR-BLK-41'), (42, 'Black', '42', 8, 'LBR-BLK-42'), (42, 'Black', '43', 6, 'LBR-BLK-43'), (42, 'Black', '44', 2, 'LBR-BLK-44'),

-- SP 43: MB.03 - 3 màu (Toxic Green, Purple, Blue) × 4 size = 12 variants
(43, 'Toxic Green', '39', 6, 'MB3-TXG-39'), (43, 'Toxic Green', '40', 10, 'MB3-TXG-40'), (43, 'Toxic Green', '41', 15, 'MB3-TXG-41'), (43, 'Toxic Green', '42', 8, 'MB3-TXG-42'),
(43, 'Purple', '39', 4, 'MB3-PUR-39'), (43, 'Purple', '40', 6, 'MB3-PUR-40'), (43, 'Purple', '41', 9, 'MB3-PUR-41'), (43, 'Purple', '42', 4, 'MB3-PUR-42'),
(43, 'Blue', '39', 3, 'MB3-BLU-39'), (43, 'Blue', '40', 5, 'MB3-BLU-40'), (43, 'Blue', '41', 7, 'MB3-BLU-41'), (43, 'Blue', '42', 3, 'MB3-BLU-42'),

-- SP 44: TWO WXY - 2 màu (Navy, Red) × 4 size = 8 variants
(44, 'Navy', '40', 8, 'TWO-NAV-40'), (44, 'Navy', '41', 13, 'TWO-NAV-41'), (44, 'Navy', '42', 10, 'TWO-NAV-42'), (44, 'Navy', '43', 5, 'TWO-NAV-43'),
(44, 'Red', '40', 4, 'TWO-RED-40'), (44, 'Red', '41', 7, 'TWO-RED-41'), (44, 'Red', '42', 6, 'TWO-RED-42'), (44, 'Red', '43', 3, 'TWO-RED-43'),

-- SP 45: Calm Slide - 3 màu (Black, Geode Teal, White) × 5 size = 15 variants
(45, 'Black', '38', 25, 'CAL-BLK-38'), (45, 'Black', '39', 30, 'CAL-BLK-39'), (45, 'Black', '40', 28, 'CAL-BLK-40'), (45, 'Black', '41', 20, 'CAL-BLK-41'), (45, 'Black', '42', 15, 'CAL-BLK-42'),
(45, 'Geode Teal', '38', 12, 'CAL-TEA-38'), (45, 'Geode Teal', '39', 18, 'CAL-TEA-39'), (45, 'Geode Teal', '40', 14, 'CAL-TEA-40'), (45, 'Geode Teal', '41', 8, 'CAL-TEA-41'), (45, 'Geode Teal', '42', 5, 'CAL-TEA-42'),
(45, 'White', '38', 10, 'CAL-WHT-38'), (45, 'White', '39', 15, 'CAL-WHT-39'), (45, 'White', '40', 20, 'CAL-WHT-40'), (45, 'White', '41', 12, 'CAL-WHT-41'), (45, 'White', '42', 7, 'CAL-WHT-42'),

-- SP 46: Adilette 22 - 2 màu (Magic Lime, Black) × 5 size = 10 variants
(46, 'Magic Lime', '38', 8, 'ADL-LIM-38'), (46, 'Magic Lime', '39', 15, 'ADL-LIM-39'), (46, 'Magic Lime', '40', 22, 'ADL-LIM-40'), (46, 'Magic Lime', '41', 18, 'ADL-LIM-41'), (46, 'Magic Lime', '42', 10, 'ADL-LIM-42'),
(46, 'Black', '38', 12, 'ADL-BLK-38'), (46, 'Black', '39', 20, 'ADL-BLK-39'), (46, 'Black', '40', 25, 'ADL-BLK-40'), (46, 'Black', '41', 16, 'ADL-BLK-41'), (46, 'Black', '42', 9, 'ADL-BLK-42'),

-- SP 47: Vans La Costa - 2 màu (Checkerboard, Black) × 4 size = 8 variants
(47, 'Checkerboard', '39', 12, 'VLC-CHK-39'), (47, 'Checkerboard', '40', 20, 'VLC-CHK-40'), (47, 'Checkerboard', '41', 14, 'VLC-CHK-41'), (47, 'Checkerboard', '42', 8, 'VLC-CHK-42'),
(47, 'Black', '39', 10, 'VLC-BLK-39'), (47, 'Black', '40', 16, 'VLC-BLK-40'), (47, 'Black', '41', 11, 'VLC-BLK-41'), (47, 'Black', '42', 5, 'VLC-BLK-42'),

-- SP 48: Leadcat - 3 màu (Black, White, Navy) × 4 size = 12 variants
(48, 'Black', '38', 12, 'LDC-BLK-38'), (48, 'Black', '39', 18, 'LDC-BLK-39'), (48, 'Black', '40', 25, 'LDC-BLK-40'), (48, 'Black', '41', 16, 'LDC-BLK-41'),
(48, 'White', '38', 8, 'LDC-WHT-38'), (48, 'White', '39', 10, 'LDC-WHT-39'), (48, 'White', '40', 14, 'LDC-WHT-40'), (48, 'White', '41', 8, 'LDC-WHT-41'),
(48, 'Navy', '38', 5, 'LDC-NAV-38'), (48, 'Navy', '39', 7, 'LDC-NAV-39'), (48, 'Navy', '40', 11, 'LDC-NAV-40'), (48, 'Navy', '41', 6, 'LDC-NAV-41'),

-- SP 49: NB 200 Slide - 2 màu (Black, Grey) × 5 size = 10 variants
(49, 'Black', '38', 14, 'NBS-BLK-38'), (49, 'Black', '39', 20, 'NBS-BLK-39'), (49, 'Black', '40', 28, 'NBS-BLK-40'), (49, 'Black', '41', 22, 'NBS-BLK-41'), (49, 'Black', '42', 15, 'NBS-BLK-42'),
(49, 'Grey', '38', 8, 'NBS-GRY-38'), (49, 'Grey', '39', 12, 'NBS-GRY-39'), (49, 'Grey', '40', 18, 'NBS-GRY-40'), (49, 'Grey', '41', 14, 'NBS-GRY-41'), (49, 'Grey', '42', 7, 'NBS-GRY-42'),

-- SP 50: Gel-Resolution 9 - 2 màu (White Blue, Black Orange) × 4 size = 8 variants
(50, 'White Blue', '40', 8, 'GR9-WB-40'), (50, 'White Blue', '41', 12, 'GR9-WB-41'), (50, 'White Blue', '42', 9, 'GR9-WB-42'), (50, 'White Blue', '43', 4, 'GR9-WB-43'),
(50, 'Black Orange', '40', 5, 'GR9-BO-40'), (50, 'Black Orange', '41', 8, 'GR9-BO-41'), (50, 'Black Orange', '42', 6, 'GR9-BO-42'), (50, 'Black Orange', '43', 3, 'GR9-BO-43'),

-- SP 51: NikeCourt Zoom Vapor Pro 2 - 2 màu (White, Pink) × 4 size = 8 variants
(51, 'White', '36', 10, 'ZVP-WHT-36'), (51, 'White', '37', 15, 'ZVP-WHT-37'), (51, 'White', '38', 8, 'ZVP-WHT-38'), (51, 'White', '39', 4, 'ZVP-WHT-39'),
(51, 'Pink', '36', 6, 'ZVP-PNK-36'), (51, 'Pink', '37', 11, 'ZVP-PNK-37'), (51, 'Pink', '38', 7, 'ZVP-PNK-38'), (51, 'Pink', '39', 3, 'ZVP-PNK-39'),

-- SP 52: Barricade 13 - 2 màu (Black, White Green) × 4 size = 8 variants
(52, 'Black', '40', 7, 'BAR-BLK-40'), (52, 'Black', '41', 11, 'BAR-BLK-41'), (52, 'Black', '42', 9, 'BAR-BLK-42'), (52, 'Black', '43', 4, 'BAR-BLK-43'),
(52, 'White Green', '40', 5, 'BAR-WG-40'), (52, 'White Green', '41', 8, 'BAR-WG-41'), (52, 'White Green', '42', 6, 'BAR-WG-42'), (52, 'White Green', '43', 3, 'BAR-WG-43'),

-- SP 53: Fresh Foam Lav v2 - 2 màu (White Pink, Navy) × 4 size = 8 variants
(53, 'White Pink', '36', 8, 'LAV-WP-36'), (53, 'White Pink', '37', 13, 'LAV-WP-37'), (53, 'White Pink', '38', 10, 'LAV-WP-38'), (53, 'White Pink', '39', 5, 'LAV-WP-39'),
(53, 'Navy', '36', 4, 'LAV-NAV-36'), (53, 'Navy', '37', 9, 'LAV-NAV-37'), (53, 'Navy', '38', 7, 'LAV-NAV-38'), (53, 'Navy', '39', 3, 'LAV-NAV-39'),

-- SP 54: Metcon 9 - 3 màu (Black, White, Olive) × 4 size = 12 variants
(54, 'Black', '40', 11, 'MET-BLK-40'), (54, 'Black', '41', 17, 'MET-BLK-41'), (54, 'Black', '42', 13, 'MET-BLK-42'), (54, 'Black', '43', 7, 'MET-BLK-43'),
(54, 'White', '40', 6, 'MET-WHT-40'), (54, 'White', '41', 9, 'MET-WHT-41'), (54, 'White', '42', 5, 'MET-WHT-42'), (54, 'White', '43', 3, 'MET-WHT-43'),
(54, 'Olive', '40', 4, 'MET-OLV-40'), (54, 'Olive', '41', 7, 'MET-OLV-41'), (54, 'Olive', '42', 8, 'MET-OLV-42'), (54, 'Olive', '43', 2, 'MET-OLV-43'),

-- SP 55: Nano X3 - 2 màu (Black, White) × 5 size = 10 variants
(55, 'Black', '38', 5, 'NNX-BLK-38'), (55, 'Black', '39', 9, 'NNX-BLK-39'), (55, 'Black', '40', 15, 'NNX-BLK-40'), (55, 'Black', '41', 12, 'NNX-BLK-41'), (55, 'Black', '42', 7, 'NNX-BLK-42'),
(55, 'White', '38', 3, 'NNX-WHT-38'), (55, 'White', '39', 6, 'NNX-WHT-39'), (55, 'White', '40', 10, 'NNX-WHT-40'), (55, 'White', '41', 8, 'NNX-WHT-41'), (55, 'White', '42', 4, 'NNX-WHT-42'),

-- SP 56: TriBase Reign 6 - 2 màu (Black Grey, White) × 4 size = 8 variants
(56, 'Black Grey', '40', 8, 'TBR-BG-40'), (56, 'Black Grey', '41', 13, 'TBR-BG-41'), (56, 'Black Grey', '42', 10, 'TBR-BG-42'), (56, 'Black Grey', '43', 5, 'TBR-BG-43'),
(56, 'White', '40', 4, 'TBR-WHT-40'), (56, 'White', '41', 7, 'TBR-WHT-41'), (56, 'White', '42', 6, 'TBR-WHT-42'), (56, 'White', '43', 3, 'TBR-WHT-43'),

-- SP 57: Puma Fuse 3.0 - 2 màu (White Pink, Black) × 4 size = 8 variants
(57, 'White Pink', '36', 12, 'FUS-WP-36'), (57, 'White Pink', '37', 18, 'FUS-WP-37'), (57, 'White Pink', '38', 14, 'FUS-WP-38'), (57, 'White Pink', '39', 7, 'FUS-WP-39'),
(57, 'Black', '36', 6, 'FUS-BLK-36'), (57, 'Black', '37', 10, 'FUS-BLK-37'), (57, 'Black', '38', 8, 'FUS-BLK-38'), (57, 'Black', '39', 4, 'FUS-BLK-39'),

-- SP 58-60: Phụ kiện
(58, 'Default', 'One Size', 50, 'KIT-DEF-OS'),
(59, 'Default', 'One Size', 80, 'NANO-DEF-OS'),
(60, 'Multi', 'M (39-42)', 35, 'SOX-MUL-M'), (60, 'Multi', 'L (43-46)', 28, 'SOX-MUL-L');


-- ============ PHẦN 4: THÊM ẢNH SẢN PHẨM (3-6 ảnh/SP, chia theo MÀU) ============

INSERT INTO `product_images` (`product_id`, `image_url`, `alt`, `is_main`, `sort_order`, `active`, `color`) VALUES
-- SP 11: AF1 - 3 màu, mỗi màu 3 ảnh = 9 ảnh
(11, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'AF1 White - Mặt trước', 1, 0, 1, 'White'),
(11, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-02.jpg', 'AF1 White - Mặt bên', 0, 1, 1, 'White'),
(11, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-03.jpg', 'AF1 White - Gót giày', 0, 2, 1, 'White'),
(11, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/fb2598-101-01.jpg', 'AF1 Black - Mặt trước', 1, 0, 1, 'Black'),
(11, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-02.jpg', 'AF1 Black - Mặt bên', 0, 1, 1, 'Black'),
(11, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-03.jpg', 'AF1 Black - Gót giày', 0, 2, 1, 'Black'),
(11, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/36f2d78a-70f8-4c79-9a07-3c8c0f6d913e.jpg', 'AF1 Grey - Mặt trước', 1, 0, 1, 'Grey'),
(11, 'https://bizweb.dktcdn.net/100/347/092/products/766a31a1-e9a5-44b3-9981-48fe39f750bb.jpg', 'AF1 Grey - Mặt bên', 0, 1, 1, 'Grey'),
(11, 'https://bizweb.dktcdn.net/100/347/092/products/7e33f5b842804ba48745d51160041600.jpg', 'AF1 Grey - Gót giày', 0, 2, 1, 'Grey'),

-- SP 12: Samba - 2 màu, mỗi màu 3 ảnh = 6 ảnh
(12, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-superstar-fv3290-01.jpg', 'Samba Black - Mặt trước', 1, 0, 1, 'Black'),
(12, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-04.jpg', 'Samba Black - Mặt bên', 0, 1, 1, 'Black'),
(12, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-05.jpg', 'Samba Black - Gót giày', 0, 2, 1, 'Black'),
(12, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-superstar-fv3290-02.jpg', 'Samba White - Mặt trước', 1, 0, 1, 'White'),
(12, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-03.jpg', 'Samba White - Mặt bên', 0, 1, 1, 'White'),
(12, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-superstar-fv3290-06.jpg', 'Samba White - Đế giày', 0, 2, 1, 'White'),

-- SP 13: NB 550 - 3 màu, mỗi màu 2 ảnh = 6 ảnh
(13, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/x-plr-shoes-beige-by9255-01-standard-1.jpg', 'NB550 White Green - Main', 1, 0, 1, 'White Green'),
(13, 'https://bizweb.dktcdn.net/100/347/092/products/x-plr-shoes-beige-by9255-02-standard-hover-1.jpg', 'NB550 White Green - Side', 0, 1, 1, 'White Green'),
(13, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/x-plr-shoes-beige-by9255-03-standard-1.jpg', 'NB550 White Grey - Main', 1, 0, 1, 'White Grey'),
(13, 'https://bizweb.dktcdn.net/100/347/092/products/x-plr-shoes-beige-by9255-04-standard-1.jpg', 'NB550 White Grey - Side', 0, 1, 1, 'White Grey'),
(13, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-1.jpg', 'NB550 White Red - Main', 1, 0, 1, 'White Red'),
(13, 'https://bizweb.dktcdn.net/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-3.jpg', 'NB550 White Red - Side', 0, 1, 1, 'White Red'),

-- SP 14: Palermo - 2 màu, mỗi màu 3 ảnh = 6 ảnh
(14, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'Palermo White - Main', 1, 0, 1, 'White'),
(14, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'Palermo White - Side', 0, 1, 1, 'White'),
(14, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-3.jpg', 'Palermo White - Back', 0, 2, 1, 'White'),
(14, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-4.jpg', 'Palermo Pink - Main', 1, 0, 1, 'Pink'),
(14, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-5.jpg', 'Palermo Pink - Side', 0, 1, 1, 'Pink'),
(14, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-3.jpg', 'Palermo Pink - Back', 0, 2, 1, 'Pink'),

-- SP 15: Chuck 70 - 2 màu, mỗi màu 3 ảnh = 6 ảnh
(15, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'Chuck70 Black - Main', 1, 0, 1, 'Black'),
(15, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-02.jpg', 'Chuck70 Black - Side', 0, 1, 1, 'Black'),
(15, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-03.jpg', 'Chuck70 Black - Back', 0, 2, 1, 'Black'),
(15, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'Chuck70 Red - Main', 1, 0, 1, 'Red'),
(15, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-02.jpg', 'Chuck70 Red - Side', 0, 1, 1, 'Red'),
(15, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-03.jpg', 'Chuck70 Red - Back', 0, 2, 1, 'Red'),

-- SP 16: Vans Old Skool - 3 màu, mỗi màu 2 ảnh = 6 ảnh
(16, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'OldSkool BlackWhite - Main', 1, 0, 1, 'Black White'),
(16, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-04.jpg', 'OldSkool BlackWhite - Side', 0, 1, 1, 'Black White'),
(16, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-05.jpg', 'OldSkool Navy - Main', 1, 0, 1, 'Navy'),
(16, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-06.jpg', 'OldSkool Navy - Side', 0, 1, 1, 'Navy'),
(16, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'OldSkool Red - Main', 1, 0, 1, 'Red'),
(16, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-04.jpg', 'OldSkool Red - Side', 0, 1, 1, 'Red'),

-- SP 17: Dunk Low - 3 màu, mỗi màu 3 ảnh = 9 ảnh
(17, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-1.jpg', 'DunkLow BW - Main', 1, 0, 1, 'Black White'),
(17, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-2.jpg', 'DunkLow BW - Side', 0, 1, 1, 'Black White'),
(17, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-3.jpg', 'DunkLow BW - Back', 0, 2, 1, 'Black White'),
(17, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-4.jpg', 'DunkLow GreyFog - Main', 1, 0, 1, 'Grey Fog'),
(17, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-5.jpg', 'DunkLow GreyFog - Side', 0, 1, 1, 'Grey Fog'),
(17, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-dunk-low-retro-dd1391-103-6.jpg', 'DunkLow GreyFog - Back', 0, 2, 1, 'Grey Fog'),
(17, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'DunkLow Green - Main', 1, 0, 1, 'Green'),
(17, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-02.jpg', 'DunkLow Green - Side', 0, 1, 1, 'Green'),
(17, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-03.jpg', 'DunkLow Green - Back', 0, 2, 1, 'Green'),

-- SP 18: Gazelle Bold - 3 màu, mỗi màu 2 ảnh = 6 ảnh
(18, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-falcon-w-ef4988-01.jpg', 'Gazelle Green - Main', 1, 0, 1, 'Green'),
(18, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-falcon-w-ef4988-03.jpg', 'Gazelle Green - Side', 0, 1, 1, 'Green'),
(18, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-falcon-w-ef4988-05.jpg', 'Gazelle Black - Main', 1, 0, 1, 'Black'),
(18, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-falcon-w-ef4988-06.jpg', 'Gazelle Black - Side', 0, 1, 1, 'Black'),
(18, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-falcon-w-ef4988-07.jpg', 'Gazelle Pink - Main', 1, 0, 1, 'Pink'),
(18, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-falcon-w-ef4988-08.jpg', 'Gazelle Pink - Side', 0, 1, 1, 'Pink'),

-- SP 19: NB 2002R - 2 màu, mỗi màu 3 ảnh = 6 ảnh
(19, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-1.jpg', 'NB2002R Grey - Main', 1, 0, 1, 'Grey'),
(19, 'https://bizweb.dktcdn.net/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-3.jpg', 'NB2002R Grey - Side', 0, 1, 1, 'Grey'),
(19, 'https://bizweb.dktcdn.net/100/347/092/products/giay-new-balance-fresh-foam-roav-v1-uroavwm1-5.jpg', 'NB2002R Grey - Back', 0, 2, 1, 'Grey'),
(19, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'NB2002R Brown - Main', 1, 0, 1, 'Brown'),
(19, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-2.jpg', 'NB2002R Brown - Side', 0, 1, 1, 'Brown'),
(19, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-4.jpg', 'NB2002R Brown - Back', 0, 2, 1, 'Brown'),

-- SP 20: Run Star Hike - 2 màu, mỗi màu 3 ảnh = 6 ảnh
(20, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'RunStarHike Black - Main', 1, 0, 1, 'Black'),
(20, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-03.jpg', 'RunStarHike Black - Side', 0, 1, 1, 'Black'),
(20, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-05.jpg', 'RunStarHike Black - Back', 0, 2, 1, 'Black'),
(20, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'RunStarHike White - Main', 1, 0, 1, 'White'),
(20, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-02.jpg', 'RunStarHike White - Side', 0, 1, 1, 'White'),
(20, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-04.jpg', 'RunStarHike White - Back', 0, 2, 1, 'White'),

-- SP 21: SK8-Hi - 2 màu, mỗi màu 3 ảnh = 6 ảnh
(21, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nty52-01.jpg', 'SK8Hi Black - Main', 1, 0, 1, 'Black'),
(21, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-02.jpg', 'SK8Hi Black - Side', 0, 1, 1, 'Black'),
(21, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nty52-04.jpg', 'SK8Hi Black - Back', 0, 2, 1, 'Black'),
(21, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-vans-vn0007nvfgn-01.jpg', 'SK8Hi Navy - Main', 1, 0, 1, 'Navy'),
(21, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-03.jpg', 'SK8Hi Navy - Side', 0, 1, 1, 'Navy'),
(21, 'https://bizweb.dktcdn.net/100/347/092/products/giay-vans-vn0007nvfgn-05.jpg', 'SK8Hi Navy - Back', 0, 2, 1, 'Navy'),

-- SP 22: Puma Suede - 2 màu, mỗi màu 2 ảnh = 4 ảnh
(22, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'PumaSuede Navy - Main', 1, 0, 1, 'Navy'),
(22, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'PumaSuede Navy - Side', 0, 1, 1, 'Navy'),
(22, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-4.jpg', 'PumaSuede Black - Main', 1, 0, 1, 'Black'),
(22, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-5.jpg', 'PumaSuede Black - Side', 0, 1, 1, 'Black'),

-- SP 23: Vaporfly - 3 màu, mỗi màu 2 ảnh = 6 ảnh
(23, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-plus-pegasus-plus-trail-plus-5-plus-gs.jpg', 'Vaporfly Volt - Main', 1, 0, 1, 'Volt'),
(23, 'https://bizweb.dktcdn.net/100/347/092/products/nike-plus-pegasus-plus-trail-plus-5-plus-gs-1-af8cd553-7a73-4272-a465-3ec1eb4f346f.jpg', 'Vaporfly Volt - Side', 0, 1, 1, 'Volt'),
(23, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-01-33f41548-eee8-493c-b25a-0656a44d0665.jpg', 'Vaporfly Pink - Main', 1, 0, 1, 'Pink'),
(23, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-02-c539f141-482a-4177-8c3f-c9d6b366c1f3.jpg', 'Vaporfly Pink - Side', 0, 1, 1, 'Pink'),
(23, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'Vaporfly Black - Main', 1, 0, 1, 'Black'),
(23, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'Vaporfly Black - Side', 0, 1, 1, 'Black'),

-- SP 24: Boston 12 - 2 màu, mỗi màu 3 ảnh = 6 ảnh
(24, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'Boston12 Black - Main', 1, 0, 1, 'Black'),
(24, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-03-70b40d8a-8bd0-469b-84e3-6a4ba0a5d6f9.jpg', 'Boston12 Black - Side', 0, 1, 1, 'Black'),
(24, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-04-6b20dc7a-c0b7-4e44-b9de-eb89b25b83f8.jpg', 'Boston12 Black - Back', 0, 2, 1, 'Black'),
(24, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/qt-racer-2-0-trang-fw7285-01.jpg', 'Boston12 White - Main', 1, 0, 1, 'White'),
(24, 'https://bizweb.dktcdn.net/100/347/092/products/qt-racer-2-0-trang-fw7285-02.jpg', 'Boston12 White - Side', 0, 1, 1, 'White'),
(24, 'https://bizweb.dktcdn.net/100/347/092/products/qt-racer-2-0-trang-fw7285-03.jpg', 'Boston12 White - Back', 0, 2, 1, 'White'),

-- SP 25: Novablast - 3 màu, mỗi màu 2 ảnh = 6 ảnh
(25, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'Novablast Blue - Main', 1, 0, 1, 'Blue'),
(25, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-2.jpg', 'Novablast Blue - Side', 0, 1, 1, 'Blue'),
(25, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'Novablast White - Main', 1, 0, 1, 'White'),
(25, 'https://bizweb.dktcdn.net/100/347/092/products/evoride-women-s-1012a677-020-02.jpg', 'Novablast White - Side', 0, 1, 1, 'White'),
(25, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'Novablast Black - Main', 1, 0, 1, 'Black'),
(25, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-1.jpg', 'Novablast Black - Side', 0, 1, 1, 'Black'),

-- SP 26-32: Running còn lại - mỗi SP 2 màu × 2 ảnh = 4 ảnh
(26, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'SCElite WhiteRed - Main', 1, 0, 1, 'White Red'),
(26, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-2.jpg', 'SCElite WhiteRed - Side', 0, 1, 1, 'White Red'),
(26, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-3.jpg', 'SCElite NeonYellow - Main', 1, 0, 1, 'Neon Yellow'),
(26, 'https://bizweb.dktcdn.net/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-2.jpg', 'SCElite NeonYellow - Side', 0, 1, 1, 'Neon Yellow'),

(27, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-01-33f41548-eee8-493c-b25a-0656a44d0665.jpg', 'Pegasus41 Pink - Main', 1, 0, 1, 'Pink'),
(27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-02-c539f141-482a-4177-8c3f-c9d6b366c1f3.jpg', 'Pegasus41 Pink - Side', 0, 1, 1, 'Pink'),
(27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-03-2ddd5784-2c26-4fb5-8581-e42521cb9fe7.jpg', 'Pegasus41 Pink - Back', 0, 2, 1, 'Pink'),
(27, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-01.jpg', 'Pegasus41 Black - Main', 1, 0, 1, 'Black'),
(27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-02.jpg', 'Pegasus41 Black - Side', 0, 1, 1, 'Black'),
(27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-03.jpg', 'Pegasus41 Black - Back', 0, 2, 1, 'Black'),
(27, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/663c3749-e7a7-4a6d-8111-32398a36b1cf.jpg', 'Pegasus41 White - Main', 1, 0, 1, 'White'),
(27, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-02.jpg', 'Pegasus41 White - Side', 0, 1, 1, 'White'),

(28, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/11271239-r1.jpg', 'WaveRebellion Yellow - Main', 1, 0, 1, 'Yellow'),
(28, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-1.jpg', 'WaveRebellion Yellow - Side', 0, 1, 1, 'Yellow'),
(28, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'WaveRebellion Black - Main', 1, 0, 1, 'Black'),
(28, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-2.jpg', 'WaveRebellion Black - Side', 0, 1, 1, 'Black'),

(29, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-ultraboost-20-eg0713-01.jpg', 'UBLight White - Main', 1, 0, 1, 'White'),
(29, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-eg0713-03.jpg', 'UBLight White - Side', 0, 1, 1, 'White'),
(29, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-eg0713-05.jpg', 'UBLight White - Back', 0, 2, 1, 'White'),
(29, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-ultraboost-20-fv8351-03.jpg', 'UBLight Black - Main', 1, 0, 1, 'Black'),
(29, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-fv8351-05.jpg', 'UBLight Black - Side', 0, 1, 1, 'Black'),
(29, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-ultraboost-20-fv8351-07.jpg', 'UBLight Black - Back', 0, 2, 1, 'Black'),
(29, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/sl20-2-shoes-blue-fz2492-02.jpg', 'UBLight Navy - Main', 1, 0, 1, 'Navy'),
(29, 'https://bizweb.dktcdn.net/100/347/092/products/sl20-2-shoes-blue-fz2492-04.jpg', 'UBLight Navy - Side', 0, 1, 1, 'Navy'),

(30, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'GelKayano Grey - Main', 1, 0, 1, 'Grey'),
(30, 'https://bizweb.dktcdn.net/100/347/092/products/evoride-women-s-1012a677-020-03.jpg', 'GelKayano Grey - Side', 0, 1, 1, 'Grey'),
(30, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-04.jpg', 'GelKayano Blue - Main', 1, 0, 1, 'Blue'),
(30, 'https://bizweb.dktcdn.net/100/347/092/products/evoride-women-s-1012a677-020-06.jpg', 'GelKayano Blue - Side', 0, 1, 1, 'Blue'),

(31, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'VelocityNitro Black - Main', 1, 0, 1, 'Black'),
(31, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-03-1721029200115.jpg', 'VelocityNitro Black - Side', 0, 1, 1, 'Black'),
(31, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-05-1721029204028.jpg', 'VelocityNitro Black - Back', 0, 2, 1, 'Black'),
(31, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'VelocityNitro White - Main', 1, 0, 1, 'White'),
(31, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'VelocityNitro White - Side', 0, 1, 1, 'White'),

(32, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'HOVRMachina BlackRed - Main', 1, 0, 1, 'Black Red'),
(32, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-air-max-2017-849559-005-2.jpg', 'HOVRMachina BlackRed - Side', 0, 1, 1, 'Black Red'),
(32, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-adidas-supernova-rise-move-for-the-planet-ig8328-01-3.jpg', 'HOVRMachina GreyBlue - Main', 1, 0, 1, 'Grey Blue'),
(32, 'https://bizweb.dktcdn.net/100/347/092/products/giay-adidas-supernova-rise-move-for-the-planet-ig8328-01-4.jpg', 'HOVRMachina GreyBlue - Side', 0, 1, 1, 'Grey Blue'),

-- SP 33-38: Football - mỗi SP 2-3 màu × 2-3 ảnh
(33, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-01.jpg', 'Mercurial Volt - Main', 1, 0, 1, 'Volt'),
(33, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-force-1-gs-white-black-ct3839-100-02.jpg', 'Mercurial Volt - Side', 0, 1, 1, 'Volt'),
(33, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/fb2598-101-01.jpg', 'Mercurial Black - Main', 1, 0, 1, 'Black'),
(33, 'https://bizweb.dktcdn.net/100/347/092/products/fb2598-101-02.jpg', 'Mercurial Black - Side', 0, 1, 1, 'Black'),
(33, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/663c3749-e7a7-4a6d-8111-32398a36b1cf.jpg', 'Mercurial White - Main', 1, 0, 1, 'White'),
(33, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-02.jpg', 'Mercurial White - Side', 0, 1, 1, 'White'),

(34, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'Predator BlackRed - Main', 1, 0, 1, 'Black Red'),
(34, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-03.jpg', 'Predator BlackRed - Side', 0, 1, 1, 'Black Red'),
(34, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-05.jpg', 'Predator BlackRed - Back', 0, 2, 1, 'Black Red'),
(34, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/edge-xt-shoes-white-fw0670-01.jpg', 'Predator WhiteGold - Main', 1, 0, 1, 'White Gold'),
(34, 'https://bizweb.dktcdn.net/100/347/092/products/edge-xt-shoes-white-fw0670-03.jpg', 'Predator WhiteGold - Side', 0, 1, 1, 'White Gold'),
(34, 'https://bizweb.dktcdn.net/100/347/092/products/edge-xt-shoes-white-fw0670-05.jpg', 'Predator WhiteGold - Back', 0, 2, 1, 'White Gold'),

(35, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'Future7 Blue - Main', 1, 0, 1, 'Blue'),
(35, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-03-1721029200115.jpg', 'Future7 Blue - Side', 0, 1, 1, 'Blue'),
(35, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'Future7 White - Main', 1, 0, 1, 'White'),
(35, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-3.jpg', 'Future7 White - Side', 0, 1, 1, 'White'),

(36, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-01.jpg', 'PhantomGX Crimson - Main', 1, 0, 1, 'Crimson'),
(36, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-02.jpg', 'PhantomGX Crimson - Side', 0, 1, 1, 'Crimson'),
(36, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-03.jpg', 'PhantomGX Crimson - Back', 0, 2, 1, 'Crimson'),
(36, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'PhantomGX Black - Main', 1, 0, 1, 'Black'),
(36, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'PhantomGX Black - Side', 0, 1, 1, 'Black'),

(37, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/response-super-djen-fx4833-01.jpg', 'Copa Black - Main', 1, 0, 1, 'Black'),
(37, 'https://bizweb.dktcdn.net/100/347/092/products/response-super-djen-fx4833-02.jpg', 'Copa Black - Side', 0, 1, 1, 'Black'),
(37, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/edge-xt-shoes-white-fw0670-01.jpg', 'Copa White - Main', 1, 0, 1, 'White'),
(37, 'https://bizweb.dktcdn.net/100/347/092/products/edge-xt-shoes-white-fw0670-02.jpg', 'Copa White - Side', 0, 1, 1, 'White'),

(38, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'MizunoAlpha White - Main', 1, 0, 1, 'White'),
(38, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-1.jpg', 'MizunoAlpha White - Side', 0, 1, 1, 'White'),
(38, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401-2.jpg', 'MizunoAlpha Black - Main', 1, 0, 1, 'Black'),
(38, 'https://bizweb.dktcdn.net/100/347/092/products/11271239-r1.jpg', 'MizunoAlpha Black - Side', 0, 1, 1, 'Black'),

-- SP 39-44: Basketball - mỗi SP 2-3 màu × 2-3 ảnh
(39, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', 'KD16 Aura - Main', 1, 0, 1, 'Aura'),
(39, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-2.jpg', 'KD16 Aura - Side', 0, 1, 1, 'Aura'),
(39, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-3.jpg', 'KD16 Aura - Back', 0, 2, 1, 'Aura'),
(39, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'KD16 Black - Main', 1, 0, 1, 'Black'),
(39, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'KD16 Black - Side', 0, 1, 1, 'Black'),
(39, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/663c3749-e7a7-4a6d-8111-32398a36b1cf.jpg', 'KD16 White - Main', 1, 0, 1, 'White'),
(39, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-02.jpg', 'KD16 White - Side', 0, 1, 1, 'White'),

(40, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-4d-fusio-h04509-01.jpg', 'Harden8 WhiteRed - Main', 1, 0, 1, 'White Red'),
(40, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-4d-fusio-h04509-02.jpg', 'Harden8 WhiteRed - Side', 0, 1, 1, 'White Red'),
(40, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-21-be-fy0391-01.jpg', 'Harden8 BlackSilver - Main', 1, 0, 1, 'Black Silver'),
(40, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-21-be-fy0391-02.jpg', 'Harden8 BlackSilver - Side', 0, 1, 1, 'Black Silver'),

(41, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'Curry11 WhiteBlue - Main', 1, 0, 1, 'White Blue'),
(41, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-air-max-2017-849559-005-2.jpg', 'Curry11 WhiteBlue - Side', 0, 1, 1, 'White Blue'),
(41, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-adidas-if8597-1.jpg', 'Curry11 BlackGold - Main', 1, 0, 1, 'Black Gold'),
(41, 'https://bizweb.dktcdn.net/100/347/092/products/giay-adidas-if8597-2.jpg', 'Curry11 BlackGold - Side', 0, 1, 1, 'Black Gold'),

(42, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-jordan-1-low-553558-147-1.jpg', 'LeBron21 Tahitian - Main', 1, 0, 1, 'Tahitian'),
(42, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-4.jpg', 'LeBron21 Tahitian - Side', 0, 1, 1, 'Tahitian'),
(42, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-jordan-1-low-553558-147-5.jpg', 'LeBron21 Tahitian - Back', 0, 2, 1, 'Tahitian'),
(42, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'LeBron21 Black - Main', 1, 0, 1, 'Black'),
(42, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'LeBron21 Black - Side', 0, 1, 1, 'Black'),

(43, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'MB03 ToxicGreen - Main', 1, 0, 1, 'Toxic Green'),
(43, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'MB03 ToxicGreen - Side', 0, 1, 1, 'Toxic Green'),
(43, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-4.jpg', 'MB03 Purple - Main', 1, 0, 1, 'Purple'),
(43, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-5.jpg', 'MB03 Purple - Side', 0, 1, 1, 'Purple'),
(43, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-01-1721029197148.jpg', 'MB03 Blue - Main', 1, 0, 1, 'Blue'),
(43, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-velocity-nitro-3-black-silver-w-377749-01-03-1721029200115.jpg', 'MB03 Blue - Side', 0, 1, 1, 'Blue'),

(44, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'TWOWXY Navy - Main', 1, 0, 1, 'Navy'),
(44, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-2.jpg', 'TWOWXY Navy - Side', 0, 1, 1, 'Navy'),
(44, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-4.jpg', 'TWOWXY Navy - Back', 0, 2, 1, 'Navy'),
(44, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-3.jpg', 'TWOWXY Red - Main', 1, 0, 1, 'Red'),
(44, 'https://bizweb.dktcdn.net/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-2.jpg', 'TWOWXY Red - Side', 0, 1, 1, 'Red'),

-- SP 45-49: Sandal - mỗi SP 2-3 màu × 2 ảnh
(45, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'CalmSlide Black - Main', 1, 0, 1, 'Black'),
(45, 'https://bizweb.dktcdn.net/100/347/092/products/110339010959-18-2-1080x715-1.jpg', 'CalmSlide Black - Side', 0, 1, 1, 'Black'),
(45, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-gy9416-01.jpg', 'CalmSlide GeodeTeal - Main', 1, 0, 1, 'Geode Teal'),
(45, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-02.jpg', 'CalmSlide GeodeTeal - Side', 0, 1, 1, 'Geode Teal'),
(45, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'CalmSlide White - Main', 1, 0, 1, 'White'),
(45, 'https://bizweb.dktcdn.net/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'CalmSlide White - Side', 0, 1, 1, 'White'),

(46, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'Adilette22 MagicLime - Main', 1, 0, 1, 'Magic Lime'),
(46, 'https://bizweb.dktcdn.net/100/347/092/products/dep-adilette-22-be-if3673-02-standard.jpg', 'Adilette22 MagicLime - Side', 0, 1, 1, 'Magic Lime'),
(46, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/adidas-gy9416-01.jpg', 'Adilette22 Black - Main', 1, 0, 1, 'Black'),
(46, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-02.jpg', 'Adilette22 Black - Side', 0, 1, 1, 'Black'),

(47, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'VansLaCosta Checker - Main', 1, 0, 1, 'Checkerboard'),
(47, 'https://bizweb.dktcdn.net/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'VansLaCosta Checker - Side', 0, 1, 1, 'Checkerboard'),
(47, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'VansLaCosta Black - Main', 1, 0, 1, 'Black'),
(47, 'https://bizweb.dktcdn.net/100/347/092/products/110339010959-18-2-1080x715-1.jpg', 'VansLaCosta Black - Side', 0, 1, 1, 'Black'),

(48, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'Leadcat Black - Main', 1, 0, 1, 'Black'),
(48, 'https://bizweb.dktcdn.net/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'Leadcat Black - Side', 0, 1, 1, 'Black'),
(48, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'Leadcat White - Main', 1, 0, 1, 'White'),
(48, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-01.jpg', 'Leadcat White - Side', 0, 1, 1, 'White'),
(48, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/110339010959-18-2-1080x715-1.jpg', 'Leadcat Navy - Main', 1, 0, 1, 'Navy'),
(48, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-02.jpg', 'Leadcat Navy - Side', 0, 1, 1, 'Navy'),

(49, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'NB200Slide Black - Main', 1, 0, 1, 'Black'),
(49, 'https://bizweb.dktcdn.net/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'NB200Slide Black - Side', 0, 1, 1, 'Black'),
(49, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/dep-adilette-22-be-if3673-01-standard.jpg', 'NB200Slide Grey - Main', 1, 0, 1, 'Grey'),
(49, 'https://bizweb.dktcdn.net/100/347/092/products/adidas-gy9416-01.jpg', 'NB200Slide Grey - Side', 0, 1, 1, 'Grey'),

-- SP 50-53: Tennis - mỗi SP 2 màu × 2 ảnh = 4 ảnh
(50, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/evoride-women-s-1012a677-020-01-9a37e53d-622b-4d5c-a4a6-37b1a8848b2b.jpg', 'GelRes9 WhiteBlue - Main', 1, 0, 1, 'White Blue'),
(50, 'https://bizweb.dktcdn.net/100/347/092/products/evoride-women-s-1012a677-020-03.jpg', 'GelRes9 WhiteBlue - Side', 0, 1, 1, 'White Blue'),
(50, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/k1ga214401.jpg', 'GelRes9 BlackOrange - Main', 1, 0, 1, 'Black Orange'),
(50, 'https://bizweb.dktcdn.net/100/347/092/products/k1ga214401-1.jpg', 'GelRes9 BlackOrange - Side', 0, 1, 1, 'Black Orange'),

(51, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/m-plus-zoom-plus-gp-plus-challenge-plus-pro-plus-hc.jpg', 'VaporPro2 White - Main', 1, 0, 1, 'White'),
(51, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-vomero-18-hm6803-401-1.jpg', 'VaporPro2 White - Side', 0, 1, 1, 'White'),
(51, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-01-33f41548-eee8-493c-b25a-0656a44d0665.jpg', 'VaporPro2 Pink - Main', 1, 0, 1, 'Pink'),
(51, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-38-cw7358-601-02-c539f141-482a-4177-8c3f-c9d6b366c1f3.jpg', 'VaporPro2 Pink - Side', 0, 1, 1, 'Pink'),

(52, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/z-f36199-02-35ee1fca-baf2-4bfc-86c1-5c0abfbf920f.jpg', 'Barricade Black - Main', 1, 0, 1, 'Black'),
(52, 'https://bizweb.dktcdn.net/100/347/092/products/z-f36199-03-70b40d8a-8bd0-469b-84e3-6a4ba0a5d6f9.jpg', 'Barricade Black - Side', 0, 1, 1, 'Black'),
(52, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-01-standard.jpg', 'Barricade WhiteGreen - Main', 1, 0, 1, 'White Green'),
(52, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-02-standard.jpg', 'Barricade WhiteGreen - Side', 0, 1, 1, 'White Green'),

(53, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-3.jpg', 'FFLav WhitePink - Main', 1, 0, 1, 'White Pink'),
(53, 'https://bizweb.dktcdn.net/100/347/092/products/new-balance-fuelcell-996v6-wch996u6-2.jpg', 'FFLav WhitePink - Side', 0, 1, 1, 'White Pink'),
(53, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/mch796n4-nb-02-1.jpg', 'FFLav Navy - Main', 1, 0, 1, 'Navy'),
(53, 'https://bizweb.dktcdn.net/100/347/092/products/mch796n4-nb-02-2.jpg', 'FFLav Navy - Side', 0, 1, 1, 'Navy'),

-- SP 54-57: Training - mỗi SP 2-3 màu × 2-3 ảnh
(54, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-ebernon-low-aq1775-004-1.jpg', 'Metcon9 Black - Main', 1, 0, 1, 'Black'),
(54, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-ebernon-low-aq1775-004-2.jpg', 'Metcon9 Black - Side', 0, 1, 1, 'Black'),
(54, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/663c3749-e7a7-4a6d-8111-32398a36b1cf.jpg', 'Metcon9 White - Main', 1, 0, 1, 'White'),
(54, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-bq9647-101-02.jpg', 'Metcon9 White - Side', 0, 1, 1, 'White'),
(54, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-01.jpg', 'Metcon9 Olive - Main', 1, 0, 1, 'Olive'),
(54, 'https://bizweb.dktcdn.net/100/347/092/products/nike-air-zoom-pegasus-37-running-bq9646-004-02.jpg', 'Metcon9 Olive - Side', 0, 1, 1, 'Olive'),

(55, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-01-standard.jpg', 'NanoX3 Black - Main', 1, 0, 1, 'Black'),
(55, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-02-standard.jpg', 'NanoX3 Black - Side', 0, 1, 1, 'Black'),
(55, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-1-0-mau-xanh-la-if5258-03-standard.jpg', 'NanoX3 Black - Back', 0, 2, 1, 'Black'),
(55, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-ultraboost-21-be-fy0391-01.jpg', 'NanoX3 White - Main', 1, 0, 1, 'White'),
(55, 'https://bizweb.dktcdn.net/100/347/092/products/giay-ultraboost-21-be-fy0391-02.jpg', 'NanoX3 White - Side', 0, 1, 1, 'White'),

(56, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-nike-air-max-2017-849559-005-1.jpg', 'TriBase BlackGrey - Main', 1, 0, 1, 'Black Grey'),
(56, 'https://bizweb.dktcdn.net/100/347/092/products/giay-nike-air-max-2017-849559-005-2.jpg', 'TriBase BlackGrey - Side', 0, 1, 1, 'Black Grey'),
(56, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-adidas-supernova-rise-move-for-the-planet-ig8328-01-3.jpg', 'TriBase White - Main', 1, 0, 1, 'White'),
(56, 'https://bizweb.dktcdn.net/100/347/092/products/giay-adidas-supernova-rise-move-for-the-planet-ig8328-01-4.jpg', 'TriBase White - Side', 0, 1, 1, 'White'),

(57, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-1.jpg', 'Fuse3 WhitePink - Main', 1, 0, 1, 'White Pink'),
(57, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-2.jpg', 'Fuse3 WhitePink - Side', 0, 1, 1, 'White Pink'),
(57, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-3.jpg', 'Fuse3 WhitePink - Back', 0, 2, 1, 'White Pink'),
(57, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-4.jpg', 'Fuse3 Black - Main', 1, 0, 1, 'Black'),
(57, 'https://bizweb.dktcdn.net/100/347/092/products/giay-puma-pounce-lite-sneakers-310778-14-5.jpg', 'Fuse3 Black - Side', 0, 1, 1, 'Black'),

-- SP 58-60: Accessories
(58, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-01.jpg?v=1694779868303', 'ShoeKit - Bộ dụng cụ', 1, 0, 1, 'Default'),
(58, 'https://bizweb.dktcdn.net/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-02.jpg', 'ShoeKit - Chi tiết', 0, 1, 1, 'Default'),
(59, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-01.jpg?v=1694779868303', 'NanoSpray - Mặt trước', 1, 0, 1, 'Default'),
(59, 'https://bizweb.dktcdn.net/100/347/092/products/bot-ve-sinh-giay-tien-loi-150ml-02.jpg', 'NanoSpray - Chi tiết', 0, 1, 1, 'Default'),
(60, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/a068a1a8-ed4e-4ba2-b69b-be6d8986da29.jpg', 'Socks - Pack 3 đôi', 1, 0, 1, 'Multi'),
(60, 'https://bizweb.dktcdn.net/100/347/092/products/b8bfca5a-883a-44ec-a171-3e323ea07dd9.jpg', 'Socks - Chi tiết', 0, 1, 1, 'Multi');


-- ============ PHẦN 5: THÊM THÔNG SỐ KỸ THUẬT (SPECS) ============

INSERT INTO `product_specs` (`product_id`, `spec_key`, `spec_value`, `sort_order`) VALUES
-- Lifestyle
(11, 'Chất liệu Upper', 'Da tổng hợp full-grain', 1), (11, 'Đế ngoài', 'Cao su nguyên khối Pivot Circle', 2), (11, 'Công nghệ đệm', 'Nike Air ẩn (Encapsulated)', 3), (11, 'Form giày', 'Rộng hơn TTS 0.5 size', 4), (11, 'Xuất xứ', 'Việt Nam', 5), (11, 'Bảo hành', '6 tháng keo đế', 6),
(12, 'Chất liệu Upper', 'Da thật + Da lộn Suede', 1), (12, 'Đế ngoài', 'Cao su Gum Rubber', 2), (12, 'Lót giày', 'OrthoLite', 3), (12, 'Form giày', 'True to Size', 4), (12, 'Xuất xứ', 'Indonesia', 5),
(13, 'Chất liệu Upper', 'Da tổng hợp đục lỗ', 1), (13, 'Đế ngoài', 'Cao su chống mài mòn', 2), (13, 'Form giày', 'Rộng nhẹ (NB truyền thống)', 3), (13, 'Xuất xứ', 'Trung Quốc', 4),
(14, 'Chất liệu Upper', 'Da lộn Suede', 1), (14, 'Đế ngoài', 'Cao su Gum', 2), (14, 'Lót giày', 'SoftFoam+', 3), (14, 'Trọng lượng', '~280g', 4),
(17, 'Chất liệu Upper', 'Da tổng hợp Premium', 1), (17, 'Đế ngoài', 'Cao su Pivot Circle', 2), (17, 'Công nghệ đệm', 'Foam nhẹ', 3), (17, 'Form giày', 'TTS đến hơi chật 0.5', 4),

-- Running
(23, 'Chất liệu Upper', 'Flyknit siêu nhẹ', 1), (23, 'Đế ngoài', 'Cao su Waffle', 2), (23, 'Công nghệ đệm', 'ZoomX + Carbon Plate', 3), (23, 'Trọng lượng', '~188g (size 42)', 4), (23, 'Drop', '8mm', 5), (23, 'Tuổi thọ', '~400km', 6),
(24, 'Chất liệu Upper', 'Mesh kỹ thuật', 1), (24, 'Đế ngoài', 'Continental Rubber', 2), (24, 'Công nghệ đệm', 'Lightstrike Pro + Energyrods 2.0', 3), (24, 'Trọng lượng', '~240g (size 42)', 4), (24, 'Tuổi thọ', '~800-1000km', 5),
(25, 'Chất liệu Upper', 'Mesh Jacquard', 1), (25, 'Đế ngoài', 'AHAR Rubber', 2), (25, 'Công nghệ đệm', 'FF BLAST PLUS ECO', 3), (25, 'Trọng lượng', '~260g (size 42)', 4), (25, 'Drop', '8mm', 5),
(27, 'Chất liệu Upper', 'Mesh + Flywire', 1), (27, 'Đế ngoài', 'Waffle cải tiến', 2), (27, 'Công nghệ đệm', 'React X + Zoom Air', 3), (27, 'Trọng lượng', '~275g (size 42)', 4), (27, 'Drop', '10mm', 5),
(29, 'Chất liệu Upper', 'Primeknit', 1), (29, 'Đế ngoài', 'Continental Rubber', 2), (29, 'Công nghệ đệm', 'Light BOOST', 3), (29, 'Trọng lượng', '~280g (size 42)', 4),

-- Football
(33, 'Chất liệu Upper', 'Vaporposite+ siêu mỏng', 1), (33, 'Đế', 'FG (Firm Ground - Sân cỏ tự nhiên)', 2), (33, 'Công nghệ', 'Anti-Clog Traction', 3), (33, 'Cổ giày', 'Dynamic Fit Collar', 4),
(35, 'Chất liệu Upper', 'Textile + FUZIONFIT+', 1), (35, 'Đế', 'TF (Turf - Sân cỏ nhân tạo)', 2), (35, 'Công nghệ', 'GripControl Pro', 3),

-- Basketball
(39, 'Chất liệu Upper', 'Mesh đa lớp', 1), (39, 'Đế ngoài', 'EP (Engineered Performance)', 2), (39, 'Công nghệ đệm', 'Zoom Air Strobel + Air', 3), (39, 'Cổ giày', 'Low-top', 4),
(41, 'Chất liệu Upper', 'UA Warp Mesh', 1), (41, 'Đế ngoài', 'UA Flow (không cao su)', 2), (41, 'Công nghệ đệm', 'UA Flow toàn chiều dài', 3), (41, 'Trọng lượng', '~310g', 4),

-- Training
(54, 'Chất liệu Upper', 'Mesh siêu bền', 1), (54, 'Mục đích', 'Cử tạ, CrossFit, Gym', 2), (54, 'Công nghệ đệm', 'Hyperlift + React Foam', 3), (54, 'Đặc biệt', 'Rope Wrap hỗ trợ leo dây', 4), (54, 'Trọng lượng', '~340g', 5),
(55, 'Chất liệu Upper', 'Flexweave Knit', 1), (55, 'Mục đích', 'CrossFit, HIIT, Functional', 2), (55, 'Công nghệ đệm', 'Floatride Energy + Lift&Run', 3), (55, 'Đặc biệt', 'Heel Clip ổn định gót', 4);


-- ============ HOÀN TẤT! ============
-- Tổng cộng: 50 sản phẩm mới (ID 11-60)
-- + 10 sản phẩm cũ giữ nguyên (ID 1-10) 
-- = 60 sản phẩm trong hệ thống
-- ==============================================================================
