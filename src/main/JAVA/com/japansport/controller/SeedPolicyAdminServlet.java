package com.japansport.controller;

import com.japansport.dao.PolicyDao;
import com.japansport.filter.MenuFilter;
import com.japansport.model.Policy;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Servlet để tạo nhanh các chính sách mẫu cho cửa hàng thể thao.
 * URL: POST /admin/policies/seed
 */
@WebServlet(name = "SeedPolicyAdminServlet", urlPatterns = {"/admin/policies/seed"})
public class SeedPolicyAdminServlet extends HttpServlet {

    private PolicyDao dao;

    @Override
    public void init() {
        dao = new PolicyDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String typesParam = request.getParameter("types");

        // Nếu gọi từ trình duyệt qua GET (không có param types), mặc định tạo tất cả
        if (typesParam == null || typesParam.isBlank()) {
            typesParam = "SHIPPING,RETURN,PAYMENT,PRIVACY,TERMS,SUPPORT,ORDER_GUIDE";
        }

        String[] types = typesParam.split(",");
        int created = 0;

        for (String type : types) {
            type = type.trim();
            Policy p = buildSamplePolicy(type);
            if (p != null) {
                // Kiểm tra slug đã tồn tại chưa (tránh duplicate, kể cả khi đang ẩn)
                Policy existing = dao.getBySlugAny(p.getSlug());
                if (existing == null) {
                    dao.insert(p);
                    created++;
                }
            }
        }

        MenuFilter.invalidatePolicyCache(getServletContext());
        response.sendRedirect(request.getContextPath() + "/admin/policies?success=seed&count=" + created);
    }

    private Policy buildSamplePolicy(String type) {
        Policy p = new Policy();
        p.setPolicyType(type);
        p.setActive(true);
        p.setDisplayOrder(0);

        switch (type) {
            case "SHIPPING":
                p.setTitle("Chính Sách Vận Chuyển");
                p.setSlug("chinh-sach-van-chuyen");
                p.setDisplayOrder(1);
                p.setContent(
                    "<h5 class=\"mb-3\">CHÍNH SÁCH VẬN CHUYỂN:</h5>\n" +
                    "<ol class=\"ps-3\">\n" +
                    "    <li class=\"lead\">Điều khoản và điều kiện trả hàng</li>\n" +
                    "    <ul>\n" +
                    "        <li>Thời hạn đổi các mặt hàng đã mua tại <a href=\"#\">https://giaynhatchinhhang.vn/</a> là <strong>7 ngày</strong> kể từ ngày nhận hàng.</li>\n" +
                    "        <li>Hàng được đổi phải đảm bảo còn mới 100%, chưa được sử dụng, còn nguyên nhãn mác, nguyên hộp, phụ kiện, phiếu bảo hành (nếu có). Giày Nhật Chính Hãng không đổi hàng đã sử dụng hoặc đã kích hoạt bảo hành.</li>\n" +
                    "        <li>Sản phẩm mua ở tại showroom Giày Nhật Chính Hãng thì áp dụng đổi tại <strong>địa chỉ đã mua</strong> sản phẩm. Sản phẩm mua online thì liên hệ Zalo <strong>0984843218</strong> hoặc email <em>orders-confirm@giaynhatchinhhang.vn</em> để được hướng dẫn.</li>\n" +
                    "        <li>Tổng giá trị các mặt hàng muốn đổi phải có giá trị tương đương với mặt hàng trả lại. <a href=\"#\">https://giaynhatchinhhang.vn/</a> không hoàn lại tiền thừa trong trường hợp sản phẩm mới có giá trị thấp hơn sản phẩm đã mua.</li>\n" +
                    "        <li>Nếu sản phẩm có lỗi, quý khách cần thông báo cho <a href=\"#\">https://giaynhatchinhhang.vn/</a> trong vòng <strong>7 ngày</strong> kể từ ngày xuất bán.</li>\n" +
                    "        <li>Giày Nhật Chính Hãng cam kết sẽ nhanh chóng thay thế sản phẩm ngay tức thì cho khách hàng (nếu hàng lỗi). Nếu như sản phẩm đó không còn hàng Giày Nhật Chính Hãng sẽ hoàn lại tiền mà không có lời hối nào trong trường hợp (không áp dụng cho khách hàng đặt order).</li>\n" +
                    "        <li>Phí chuyển phát sẽ được hoàn trả trong trường hợp hàng hóa bán ra không đúng, lỗi hoặc hỏng hóc.</li>\n" +
                    "    </ul>\n" +
                    "    <li class=\"lead mt-3\"> Quy trình đổi/trả sản phẩm</li>\n" +
                    "    <ul>\n" +
                    "        <li>Bước 1: Khách hàng liên hệ trực tiếp tại địa chỉ cửa hàng hoặc Zalo <strong>0984843218</strong> hoặc email: <em>orders-confirm@giaynhatchinhhang.vn</em> để yêu cầu việc đổi sản phẩm. Giày Nhật Chính Hãng sẽ hướng dẫn bạn cách đổi sản phẩm. Nếu quá trình đổi sản phẩm của khách hợp lệ.</li>\n" +
                    "        <li>Bước 2: Khách hàng gửi sản phẩm hàng hóa cho Giày Nhật Chính Hãng tiếp nhận theo chỉ dẫn phía trên (có thể tại cửa hàng hoặc gửi theo đường bưu điện với sản phẩm mua online).</li>\n" +
                    "        <li>Bước 3: Giày Nhật Chính Hãng nhận sản phẩm và kiểm tra sản phẩm.</li>\n" +
                    "        <li>Bước 4: Khách hàng nhận sản phẩm thay thế hoặc nhận tiền hoàn lại.</li>\n" +
                    "    </ul>\n" +
                    "    <h6 class=\"mt-3\">Một số lưu ý khi gửi sản phẩm đến bưu điện:</h6>\n" +
                    "    <ol>\n" +
                    "        <li>Đóng gói, chèn lót sản phẩm như ban đầu, nhưng không niêm phong bề mặt thùng trước khi hoàn tất quá trình gửi hàng vì có thể bưu điện cần kiểm tra trước khi nhận hàng từ khách hàng.</li>\n" +
                    "        <li>Lưu ý không dán băng keo trực tiếp lên hộp sản phẩm vì yêu cầu đổi/trả có thể sẽ bị từ chối nếu hộp sản phẩm bị hư hỏng.</li>\n" +
                    "        <li>Ghi note: Tên + số điện thoại khách hàng + nội dung yêu cầu đổi đính trong sản phẩm.</li>\n" +
                    "    </ol>\n" +
                    "    <p><strong>Lưu ý:</strong> Khách hàng vui lòng chỉ gửi sản phẩm qua đường bưu điện và chịu trách nhiệm về trạng thái nguyên vẹn của sản phẩm khi gửi về Giày Nhật Chính Hãng. Shop không chấp nhận các lý do như: Nhân viên bưu điện báo không cần bọc...etc.</p>\n" +
                    "</ol>"
                );
                break;

            case "RETURN":
                p.setTitle("Chính sách đổi trả hàng");
                p.setSlug("chinh-sach-doi-tra");
                p.setDisplayOrder(2);
                p.setContent(
                    "<h5 class=\"mb-3\">CHÍNH SÁCH ĐỔI TRẢ:</h5>\n" +
                    "<ol class=\"ps-3\">\n" +
                    "    <li class=\"lead\">Điều khoản và điều kiện trả hàng</li>\n" +
                    "    <ul>\n" +
                    "        <li>Thời hạn đổi các mặt hàng đã mua tại <a href=\"#\">https://giaynhatchinhhang.vn/</a> là <strong>7 ngày</strong> kể từ ngày nhận hàng.</li>\n" +
                    "        <li>Hàng được đổi phải đảm bảo còn mới 100%, chưa được sử dụng, còn nguyên nhãn mác, nguyên hộp, phụ kiện, phiếu bảo hành (nếu có).</li>\n" +
                    "        <li>Sản phẩm mua ở tại showroom thì áp dụng đổi tại địa chỉ đã mua. Sản phẩm mua online thì liên hệ Zalo <strong>0984843218</strong>.</li>\n" +
                    "    </ul>\n" +
                    "    <li class=\"lead mt-3\">Quy trình đổi/trả sản phẩm</li>\n" +
                    "    <ul>\n" +
                    "        <li>Bước 1: Khách hàng liên hệ trực tiếp tại địa chỉ cửa hàng hoặc Zalo <strong>0984843218</strong>.</li>\n" +
                    "        <li>Bước 2: Gửi sản phẩm hàng hóa cho Giày Nhật Chính Hãng tiếp nhận.</li>\n" +
                    "        <li>Bước 3: Khách hàng nhận sản phẩm thay thế hoặc nhận tiền hoàn lại.</li>\n" +
                    "    </ul>\n" +
                    "</ol>"
                );
                break;

            case "PAYMENT":
                p.setTitle("Thông tin thanh toán");
                p.setSlug("thong-tin-thanh-toan");
                p.setDisplayOrder(3);
                p.setContent(
                    "<h4 style=\"font-size: medium\" class=\"fw-bold text-danger\">THÔNG TIN THANH TOÁN</h4>\n" +
                    "<h5 class=\"mt-3 fw-bold\">THÔNG TIN CHUYỂN KHOẢN</h5>\n" +
                    "<p>Quý khách hàng vui lòng chuyển khoản vào tài khoản số:</p>\n" +
                    "<ul>\n" +
                    "    <li><strong>1. Vietcombank</strong><br>Chủ TK: Lê Anh Tuấn<br>Số TK: 0011004133440<br>Chi nhánh: Vietcombank Sở Giao Dịch</li>\n" +
                    "    <li class=\"mt-3\"><strong>2. Vietinbank</strong><br>Chủ TK: Lê Anh Tuấn<br>Số TK: 105006875976<br>Chi nhánh: Vietinbank Thăng Long</li>\n" +
                    "    <li class=\"mt-3\"><strong>3. Agribank</strong><br>Chủ TK: Lê Anh Tuấn<br>Số TK: 3100205466231<br>Chi nhánh: Agribank Từ Liêm</li>\n" +
                    "</ul>\n" +
                    "<p class=\"mt-3 text-muted\"><strong>Giá sản phẩm chưa bao gồm phí vận chuyển nội thành / liên tỉnh.</strong> Phí vận chuyển cụ thể shop sẽ báo khi chốt đơn đặt hàng. Cảm ơn quý khách đã sử dụng dịch vụ.</p>"
                );
                break;

            case "PRIVACY":
                p.setTitle("Chính sách bảo mật thông tin");
                p.setSlug("chinh-sach-bao-mat");
                p.setDisplayOrder(4);
                p.setContent(
                    "<h2>Chính sách bảo mật thông tin</h2>\n" +
                    "<p>Japan Sport cam kết bảo vệ thông tin cá nhân của khách hàng theo đúng quy định pháp luật Việt Nam.</p>\n" +
                    "<h3>1. Thông tin chúng tôi thu thập</h3>\n" +
                    "<ul>\n" +
                    "<li>Họ tên, số điện thoại, địa chỉ email</li>\n" +
                    "<li>Địa chỉ giao hàng</li>\n" +
                    "<li>Lịch sử mua hàng và hành vi duyệt web trên website</li>\n" +
                    "</ul>\n" +
                    "<h3>2. Mục đích sử dụng thông tin</h3>\n" +
                    "<ul>\n" +
                    "<li>Xử lý đơn hàng và giao hàng</li>\n" +
                    "<li>Gửi thông báo về trạng thái đơn hàng</li>\n" +
                    "<li>Cải thiện trải nghiệm mua sắm cá nhân hóa</li>\n" +
                    "<li>Gửi thông tin khuyến mãi (nếu bạn đồng ý)</li>\n" +
                    "</ul>\n" +
                    "<h3>3. Chia sẻ thông tin</h3>\n" +
                    "<p>Chúng tôi <strong>không bán hoặc chia sẻ</strong> thông tin cá nhân của bạn với bên thứ ba, ngoại trừ các đối tác vận chuyển cần thiết để thực hiện giao hàng.</p>\n" +
                    "<h3>4. Bảo mật dữ liệu</h3>\n" +
                    "<p>Dữ liệu được lưu trữ trên máy chủ bảo mật với mã hóa AES-256. Chúng tôi thực hiện kiểm tra bảo mật định kỳ.</p>\n" +
                    "<h3>5. Quyền của bạn</h3>\n" +
                    "<p>Bạn có quyền yêu cầu xem, chỉnh sửa hoặc xóa thông tin cá nhân bất kỳ lúc nào bằng cách liên hệ email: <a href=\"mailto:privacy@japansport.vn\">privacy@japansport.vn</a></p>"
                );
                break;

            case "TERMS":
                p.setTitle("Điều khoản sử dụng");
                p.setSlug("dieu-khoan-su-dung");
                p.setDisplayOrder(5);
                p.setContent(
                    "<h2>Điều khoản sử dụng</h2>\n" +
                    "<p>Bằng việc truy cập và sử dụng website Japan Sport, bạn đồng ý tuân thủ các điều khoản và điều kiện dưới đây.</p>\n" +
                    "<h3>1. Tài khoản người dùng</h3>\n" +
                    "<ul>\n" +
                    "<li>Bạn phải cung cấp thông tin chính xác, đầy đủ khi đăng ký tài khoản</li>\n" +
                    "<li>Bạn chịu trách nhiệm bảo mật thông tin đăng nhập của mình</li>\n" +
                    "<li>Nghiêm cấm sử dụng tài khoản của người khác mà không có sự cho phép</li>\n" +
                    "</ul>\n" +
                    "<h3>2. Sản phẩm và giá cả</h3>\n" +
                    "<ul>\n" +
                    "<li>Japan Sport bảo lưu quyền thay đổi giá sản phẩm mà không cần thông báo trước</li>\n" +
                    "<li>Hình ảnh sản phẩm có thể khác đôi chút so với thực tế do màn hình thiết bị</li>\n" +
                    "<li>Trong trường hợp sản phẩm hết hàng sau khi đặt, chúng tôi sẽ liên hệ và hoàn tiền ngay</li>\n" +
                    "</ul>\n" +
                    "<h3>3. Quyền sở hữu trí tuệ</h3>\n" +
                    "<p>Toàn bộ nội dung trên website (hình ảnh, text, logo, thiết kế) thuộc sở hữu của Japan Sport và được bảo vệ bởi pháp luật về sở hữu trí tuệ. Nghiêm cấm sao chép, phát tán mà không có sự đồng ý bằng văn bản.</p>\n" +
                    "<h3>4. Giới hạn trách nhiệm</h3>\n" +
                    "<p>Japan Sport không chịu trách nhiệm về các thiệt hại gián tiếp phát sinh từ việc sử dụng website hoặc sản phẩm trong phạm vi pháp luật cho phép.</p>\n" +
                    "<h3>5. Luật áp dụng</h3>\n" +
                    "<p>Các điều khoản này được điều chỉnh bởi pháp luật nước Cộng hòa Xã hội Chủ nghĩa Việt Nam.</p>"
                );
                break;

            case "SUPPORT":
                p.setTitle("Chính sách hỗ trợ khách hàng");
                p.setSlug("chinh-sach-ho-tro-khach-hang");
                p.setDisplayOrder(6);
                p.setContent(
                    "<h2>Chính sách hỗ trợ khách hàng</h2>\n" +
                    "<p>Japan Sport luôn đặt sự hài lòng của khách hàng lên hàng đầu. Chúng tôi cung cấp nhiều kênh hỗ trợ để đảm bảo mọi thắc mắc của bạn được giải quyết nhanh chóng.</p>\n" +
                    "<h3>1. Kênh hỗ trợ</h3>\n" +
                    "<table style=\"width:100%; border-collapse:collapse; margin: 12px 0;\">\n" +
                    "<thead>\n" +
                    "<tr style=\"background:#f8f9fa;\">\n" +
                    "<th style=\"padding:10px 14px; text-align:left; border:1px solid #e0e0e0;\">Kênh liên hệ</th>\n" +
                    "<th style=\"padding:10px 14px; text-align:left; border:1px solid #e0e0e0;\">Thông tin</th>\n" +
                    "<th style=\"padding:10px 14px; text-align:left; border:1px solid #e0e0e0;\">Giờ hỗ trợ</th>\n" +
                    "</tr>\n" +
                    "</thead>\n" +
                    "<tbody>\n" +
                    "<tr><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">📞 Hotline</td><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\"><strong>1800-xxxx</strong> (miễn cước)</td><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">8:00 - 22:00 (T2-CN)</td></tr>\n" +
                    "<tr><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">📧 Email</td><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">support@japansport.vn</td><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">Phản hồi trong 24h</td></tr>\n" +
                    "<tr><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">💬 Chat trực tuyến</td><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">Trên website</td><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">8:00 - 22:00 hằng ngày</td></tr>\n" +
                    "<tr><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">📘 Facebook</td><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">fb.com/JapanSportVN</td><td style=\"padding:10px 14px; border:1px solid #e0e0e0;\">8:00 - 22:00 hằng ngày</td></tr>\n" +
                    "</tbody>\n" +
                    "</table>\n" +
                    "<h3>2. Cam kết dịch vụ</h3>\n" +
                    "<ul>\n" +
                    "<li>✅ Phản hồi hotline trong <strong>vòng 3 phút</strong> trong giờ hành chính</li>\n" +
                    "<li>✅ Phản hồi email trong <strong>vòng 4 giờ làm việc</strong></li>\n" +
                    "<li>✅ Giải quyết khiếu nại trong <strong>vòng 48 giờ</strong></li>\n" +
                    "<li>✅ Hoàn tiền 100% nếu sản phẩm bị lỗi do nhà sản xuất</li>\n" +
                    "</ul>\n" +
                    "<h3>3. Quy trình khiếu nại</h3>\n" +
                    "<ol>\n" +
                    "<li>Liên hệ qua một trong các kênh trên và cung cấp mã đơn hàng</li>\n" +
                    "<li>Mô tả rõ vấn đề, đính kèm hình ảnh/video nếu có</li>\n" +
                    "<li>Nhân viên sẽ liên hệ lại trong vòng 2 giờ làm việc</li>\n" +
                    "<li>Đưa ra phương án giải quyết phù hợp</li>\n" +
                    "</ol>\n" +
                    "<h3>4. Chương trình khách hàng thân thiết</h3>\n" +
                    "<p>Khách hàng mua hàng thường xuyên sẽ được tích điểm và nhận ưu đãi đặc biệt. Liên hệ CSKH để biết thêm chi tiết về chương trình thành viên.</p>"
                );
                break;

            case "ORDER_GUIDE":
                p.setTitle("Hướng dẫn đặt hàng");
                p.setSlug("huong-dan-dat-hang");
                p.setDisplayOrder(7);
                p.setContent(
                    "<div class=\"mb-3\"><h4 class=\"fw-bold text-danger\">HƯỚNG DẪN ĐẶT HÀNG</h4></div>\n" +
                    "<div class=\"guide-step mb-4\">\n" +
                    "    <h5 class=\"fw-bold\">Bước 1:</h5>\n" +
                    "    <p>Truy cập website và lựa chọn sản phẩm cần mua để mua hàng. Trên web hiển thị size nào là còn size đó. Ngoài size web hiển thị sẽ <strong>KHÔNG CÓ HÀNG SẴN</strong>.</p>\n" +
                    "    <figure class=\"text-center\"><img src=\"assets/images/return_policy/guide1.webp\" class=\"img-fluid guide-img\" alt=\"Hướng dẫn chọn size\"></figure>\n" +
                    "</div>\n" +
                    "<div class=\"guide-step mb-4\">\n" +
                    "    <h5 class=\"fw-bold\">Bước 2:</h5>\n" +
                    "    <p>Sau khi chọn sản phẩm và size phù hợp, nhấn <strong>“Mua ngay”</strong> để đưa sản phẩm vào giỏ hàng.</p>\n" +
                    "    <figure class=\"text-center\"><img src=\"assets/images/return_policy/guide2.webp\" class=\"img-fluid guide-img\" alt=\"Hướng dẫn thêm vào giỏ\"></figure>\n" +
                    "</div>\n" +
                    "<div class=\"guide-step mb-4\">\n" +
                    "    <h5 class=\"fw-bold\">Bước 3:</h5>\n" +
                    "    <p>Lựa chọn thông tin tài khoản đặt hàng. Nếu chưa có tài khoản, điền trực tiếp thông tin địa chỉ nhận hàng, tên và số điện thoại.</p>\n" +
                    "    <figure class=\"text-center\"><img src=\"assets/images/return_policy/guide3.webp\" class=\"img-fluid guide-img\" alt=\"Hướng dẫn bước 3\"></figure>\n" +
                    "</div>\n" +
                    "<div class=\"guide-step mb-4\">\n" +
                    "    <h5 class=\"fw-bold\">Bước 4 & Bước 5:</h5>\n" +
                    "    <p>Xem lại thông tin đặt hàng, điền chú thích sau đó bấm <strong>ĐẶT HÀNG</strong>.</p>\n" +
                    "    <figure class=\"text-center\"><img src=\"assets/images/return_policy/guide4.webp\" class=\"img-fluid guide-img\" alt=\"Hướng dẫn bước 5\"></figure>\n" +
                    "    <p>Sau khi nhận được đơn hàng bạn gửi chúng tôi sẽ liên hệ bằng cách gọi điện lại để xác nhận lại đơn hàng và địa chỉ của bạn. Trân trọng cảm ơn.</p>\n" +
                    "</div>"
                );
                break;

            default:
                return null;
        }

        return p;
    }
}
