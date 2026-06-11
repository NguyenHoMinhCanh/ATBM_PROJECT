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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String typesParam = request.getParameter("types");

        if (typesParam == null || typesParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/admin/policies?error=seed_empty");
            return;
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
                p.setTitle("Chính sách vận chuyển");
                p.setSlug("chinh-sach-van-chuyen");
                p.setDisplayOrder(1);
                p.setContent(
                    "<h2>Chính sách vận chuyển</h2>\n" +
                    "<h3>1. Phạm vi giao hàng</h3>\n" +
                    "<p>Japan Sport giao hàng toàn quốc tới tất cả 63 tỉnh thành trên cả nước thông qua các đối tác vận chuyển uy tín như GHN, GHTK, VNPost.</p>\n" +
                    "<h3>2. Thời gian giao hàng</h3>\n" +
                    "<ul>\n" +
                    "<li><strong>Nội thành Hà Nội &amp; TP.HCM:</strong> 1 - 2 ngày làm việc</li>\n" +
                    "<li><strong>Các tỉnh thành khác:</strong> 3 - 5 ngày làm việc</li>\n" +
                    "<li><strong>Khu vực vùng sâu, vùng xa:</strong> 5 - 7 ngày làm việc</li>\n" +
                    "</ul>\n" +
                    "<h3>3. Phí vận chuyển</h3>\n" +
                    "<ul>\n" +
                    "<li><strong>Miễn phí vận chuyển</strong> cho đơn hàng từ <strong>500.000đ</strong> trở lên</li>\n" +
                    "<li>Đơn hàng dưới 500.000đ: phí ship theo bảng giá của đơn vị vận chuyển (thường từ 20.000đ - 35.000đ)</li>\n" +
                    "</ul>\n" +
                    "<h3>4. Theo dõi đơn hàng</h3>\n" +
                    "<p>Sau khi đơn hàng được xác nhận, bạn sẽ nhận được mã vận đơn qua email và SMS để theo dõi trạng thái giao hàng theo thời gian thực.</p>\n" +
                    "<h3>5. Lưu ý</h3>\n" +
                    "<p>Trong trường hợp bất khả kháng (thiên tai, dịch bệnh, ngày lễ tết), thời gian giao hàng có thể bị ảnh hưởng. Chúng tôi sẽ thông báo cho bạn ngay khi có thay đổi.</p>"
                );
                break;

            case "RETURN":
                p.setTitle("Chính sách đổi trả hàng");
                p.setSlug("chinh-sach-doi-tra");
                p.setDisplayOrder(2);
                p.setContent(
                    "<h2>Chính sách đổi trả hàng</h2>\n" +
                    "<p>Japan Sport cam kết mang đến trải nghiệm mua sắm tốt nhất. Chúng tôi hỗ trợ đổi trả trong các trường hợp sau:</p>\n" +
                    "<h3>1. Điều kiện đổi trả</h3>\n" +
                    "<ul>\n" +
                    "<li>Sản phẩm còn nguyên tem, nhãn, chưa qua sử dụng</li>\n" +
                    "<li>Sản phẩm bị lỗi do nhà sản xuất hoặc vận chuyển</li>\n" +
                    "<li>Giao sai mẫu, sai size, sai màu so với đơn đặt hàng</li>\n" +
                    "<li>Có hóa đơn mua hàng hoặc mã đơn hàng hợp lệ</li>\n" +
                    "</ul>\n" +
                    "<h3>2. Thời gian đổi trả</h3>\n" +
                    "<ul>\n" +
                    "<li><strong>Đổi size/màu:</strong> trong vòng <strong>7 ngày</strong> kể từ ngày nhận hàng</li>\n" +
                    "<li><strong>Trả hàng hoàn tiền (lỗi sản xuất):</strong> trong vòng <strong>30 ngày</strong></li>\n" +
                    "<li><strong>Bảo hành sản phẩm:</strong> theo chính sách của nhà sản xuất</li>\n" +
                    "</ul>\n" +
                    "<h3>3. Quy trình đổi trả</h3>\n" +
                    "<ol>\n" +
                    "<li>Liên hệ hotline <strong>1800-xxxx</strong> hoặc email <strong>support@japansport.vn</strong> trong giờ hành chính</li>\n" +
                    "<li>Cung cấp mã đơn hàng và lý do đổi trả, kèm ảnh/video sản phẩm lỗi (nếu có)</li>\n" +
                    "<li>Nhân viên xác nhận và cấp mã đổi trả</li>\n" +
                    "<li>Gửi sản phẩm về kho theo địa chỉ được cung cấp</li>\n" +
                    "<li>Nhận sản phẩm mới hoặc hoàn tiền trong 3-5 ngày làm việc</li>\n" +
                    "</ol>\n" +
                    "<h3>4. Trường hợp không áp dụng đổi trả</h3>\n" +
                    "<ul>\n" +
                    "<li>Sản phẩm đã qua sử dụng, giặt, tẩy</li>\n" +
                    "<li>Sản phẩm thuộc danh mục đồ lót, tất, phụ kiện nhỏ</li>\n" +
                    "<li>Sản phẩm mua trong chương trình khuyến mãi đặc biệt (có ghi rõ không đổi trả)</li>\n" +
                    "</ul>"
                );
                break;

            case "PAYMENT":
                p.setTitle("Chính sách thanh toán");
                p.setSlug("chinh-sach-thanh-toan");
                p.setDisplayOrder(3);
                p.setContent(
                    "<h2>Chính sách thanh toán</h2>\n" +
                    "<p>Japan Sport hỗ trợ nhiều phương thức thanh toán linh hoạt, an toàn và tiện lợi.</p>\n" +
                    "<h3>1. Các phương thức thanh toán</h3>\n" +
                    "<h4>🏦 Chuyển khoản ngân hàng</h4>\n" +
                    "<ul>\n" +
                    "<li>Ngân hàng: Vietcombank, Techcombank, MB Bank, VPBank, BIDV</li>\n" +
                    "<li>Chủ tài khoản: CÔNG TY TNHH JAPAN SPORT VIỆT NAM</li>\n" +
                    "<li>Nội dung chuyển khoản: [Mã đơn hàng] - [Họ tên]</li>\n" +
                    "</ul>\n" +
                    "<h4>💳 Thanh toán thẻ trực tuyến</h4>\n" +
                    "<p>Chấp nhận thẻ Visa, Mastercard, JCB, American Express qua cổng thanh toán bảo mật.</p>\n" +
                    "<h4>📱 Ví điện tử</h4>\n" +
                    "<p>MoMo, ZaloPay, VNPay, ShopeePay</p>\n" +
                    "<h4>🏠 Thanh toán khi nhận hàng (COD)</h4>\n" +
                    "<p>Áp dụng cho đơn hàng dưới 5.000.000đ tại các tỉnh thành có hỗ trợ COD.</p>\n" +
                    "<h4>💰 Trả góp 0%</h4>\n" +
                    "<p>Hỗ trợ trả góp 0% lãi suất qua thẻ tín dụng các ngân hàng đối tác cho đơn hàng từ 3.000.000đ.</p>\n" +
                    "<h3>2. Bảo mật thanh toán</h3>\n" +
                    "<p>Mọi giao dịch được mã hóa bằng công nghệ SSL 256-bit, đảm bảo thông tin thanh toán của bạn an toàn tuyệt đối.</p>\n" +
                    "<h3>3. Xác nhận thanh toán</h3>\n" +
                    "<p>Sau khi thanh toán thành công, hệ thống sẽ gửi email xác nhận đơn hàng trong vòng 5-15 phút. Nếu không nhận được, vui lòng kiểm tra hộp thư rác hoặc liên hệ hỗ trợ.</p>"
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
                    "<h2>Hướng dẫn đặt hàng trực tuyến</h2>\n" +
                    "<p>Việc mua sắm tại Japan Sport rất đơn giản. Làm theo các bước sau để đặt hàng thành công:</p>\n" +
                    "<h3>Bước 1: Tìm sản phẩm</h3>\n" +
                    "<ul>\n" +
                    "<li>Duyệt qua các danh mục hoặc sử dụng thanh tìm kiếm</li>\n" +
                    "<li>Lọc theo thương hiệu, kích cỡ, màu sắc, giá tiền</li>\n" +
                    "<li>Click vào sản phẩm để xem chi tiết, ảnh và thông số</li>\n" +
                    "</ul>\n" +
                    "<h3>Bước 2: Chọn và thêm vào giỏ hàng</h3>\n" +
                    "<ul>\n" +
                    "<li>Chọn size, màu sắc phù hợp</li>\n" +
                    "<li>Điều chỉnh số lượng</li>\n" +
                    "<li>Nhấn <strong>\"Thêm vào giỏ hàng\"</strong> hoặc <strong>\"Mua ngay\"</strong></li>\n" +
                    "</ul>\n" +
                    "<h3>Bước 3: Xem giỏ hàng và thanh toán</h3>\n" +
                    "<ul>\n" +
                    "<li>Click icon giỏ hàng ở góc trên phải để xem</li>\n" +
                    "<li>Kiểm tra lại sản phẩm, số lượng</li>\n" +
                    "<li>Nhập mã voucher nếu có</li>\n" +
                    "<li>Nhấn <strong>\"Thanh toán\"</strong></li>\n" +
                    "</ul>\n" +
                    "<h3>Bước 4: Điền thông tin giao hàng</h3>\n" +
                    "<ul>\n" +
                    "<li>Đăng nhập hoặc tiếp tục với tư cách khách</li>\n" +
                    "<li>Điền địa chỉ giao hàng đầy đủ và chính xác</li>\n" +
                    "<li>Chọn phương thức vận chuyển</li>\n" +
                    "</ul>\n" +
                    "<h3>Bước 5: Chọn phương thức thanh toán và xác nhận</h3>\n" +
                    "<ul>\n" +
                    "<li>Chọn COD, chuyển khoản, ví điện tử hoặc thẻ tín dụng</li>\n" +
                    "<li>Xem lại tóm tắt đơn hàng</li>\n" +
                    "<li>Nhấn <strong>\"Đặt hàng\"</strong> để hoàn tất</li>\n" +
                    "</ul>\n" +
                    "<h3>Sau khi đặt hàng</h3>\n" +
                    "<p>Bạn sẽ nhận được email xác nhận đơn hàng. Theo dõi trạng thái đơn hàng trong mục <strong>\"Đơn hàng của tôi\"</strong> trên website. Nếu cần hỗ trợ, hãy liên hệ CSKH của chúng tôi!</p>"
                );
                break;

            default:
                return null;
        }

        return p;
    }
}
