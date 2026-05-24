<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.japansport.model.Cart" %>
<%@ page import="com.japansport.model.CartItem" %>
<%@ page import="com.japansport.model.User" %>
<%@ page import="com.japansport.model.UserAddress" %>
<%@ page import="com.japansport.model.Voucher" %>
<%
    String ctx = request.getContextPath();

    Cart cart = (Cart) request.getAttribute("cart");
    List<CartItem> items = (List<CartItem>) request.getAttribute("cartItems");

    if (cart == null) {
        if (items == null) items = Collections.emptyList();
        cart = new Cart(0, 0, "ACTIVE", true, items);
    } else {
        items = cart.getItems();
    }

    User u = (User) session.getAttribute("currentUser");
    UserAddress defAddr = (UserAddress) request.getAttribute("defaultAddress");

    String shipEmail = (u != null ? u.getEmail() : "");
    String shipName = "";
    String shipPhone = "";
    String shipAddressLine = "";
    String shipCity = "";
    String shipWard = "";

    if (defAddr != null) {
        shipName = defAddr.getFullName();
        shipPhone = defAddr.getPhone();
        shipAddressLine = defAddr.getAddressLine();
        shipCity = defAddr.getCity();
        shipWard = defAddr.getWard();
    }

    shipName = (shipName == null || shipName.equals("null")) ? (u != null ? u.getName() : "") : shipName;
    shipPhone = (shipPhone == null || shipPhone.equals("null")) ? (u != null ? u.getPhone() : "") : shipPhone;
    shipAddressLine = (shipAddressLine == null || shipAddressLine.equals("null")) ? "" : shipAddressLine;
    shipCity = (shipCity == null || shipCity.equals("null")) ? "" : shipCity;
    shipWard = (shipWard == null || shipWard.equals("null")) ? "" : shipWard;

    String cityNormalized = shipCity == null ? "" : shipCity.trim();
    if (!cityNormalized.isBlank()) {
        String lc = cityNormalized.toLowerCase();
        if (lc.contains("hồ chí minh") || lc.contains("ho chi minh") || lc.contains("hcm") || lc.contains("tp.hcm") || lc.contains("tp hcm")) {
            cityNormalized = "TP. Hồ Chí Minh";
        } else if (lc.contains("hà nội") || lc.contains("ha noi")) {
            cityNormalized = "Hà Nội";
        } else if (lc.contains("đà nẵng") || lc.contains("da nang")) {
            cityNormalized = "Đà Nẵng";
        }
    }
    boolean cityInList = cityNormalized.equals("Hà Nội") || cityNormalized.equals("TP. Hồ Chí Minh") || cityNormalized.equals("Đà Nẵng") || cityNormalized.equals("Khác");
    if (!cityInList && !cityNormalized.isBlank()) cityNormalized = "Khác";

    double subtotal = cart.getSubtotal();
    int totalQty = cart.getTotalQty();
    String errorMessage = (String) request.getAttribute("errorMessage");

    // ===== VOUCHER =====
    Voucher appliedVoucher   = (Voucher)     request.getAttribute("appliedVoucher");
    BigDecimal discountAmount = (BigDecimal) request.getAttribute("discountAmount");
    BigDecimal finalTotal     = (BigDecimal) request.getAttribute("finalTotal");
    List<Voucher> suggestedVouchers = (List<Voucher>) request.getAttribute("suggestedVouchers");

    if (discountAmount == null) discountAmount = BigDecimal.ZERO;
    if (finalTotal     == null) finalTotal     = BigDecimal.valueOf(subtotal);
    if (suggestedVouchers == null) suggestedVouchers = new ArrayList<>();

    String voucherSuccess = (String) session.getAttribute("voucherSuccess");
    session.removeAttribute("voucherSuccess");
    String voucherError = (String) session.getAttribute("voucherError");
    session.removeAttribute("voucherError");
%>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Thanh toán</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="assets/css/style.css"/>
    <style>
        /* CSS cho Payment Method Cards */
        .payment-method-card {
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid #dee2e6 !important;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }

        .payment-radio:checked + .payment-method-card {
            border-color: #198754 !important;
            background-color: #f8fff9;
        }

        .check-mark {
            display: none;
            color: #198754;
            font-size: 1.25rem;
        }

        .payment-radio:checked + .payment-method-card .check-mark {
            display: block;
        }

        .payment-radio {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .payment-method-card:hover {
            border-color: #adb5bd !important;
        }
        .copy-btn {
            font-size: 0.75rem;
            transition: all 0.2s;
        }
        .copy-btn.copied {
            background-color: #198754;
            color: white;
            border-color: #198754;
        }

         .voucher-applied-pay {
             background: linear-gradient(135deg, #f0fff4, #e6ffee);
             border: 1.5px dashed #28a745;
         }
        .voucher-suggest-pay {
            background: #f8fff8;
            border: 1px dashed #9ed49e;
            cursor: pointer;
            transition: background 0.2s;
        }
        .voucher-suggest-pay:hover {
            background: #eaffea;
            border-color: #28a745;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/jspf/site_header.jspf" %>

<div class="container-narrow">
    <div class="d-flex align-items-center justify-content-between mb-3">
        <a href="<%=ctx%>/home" class="d-flex align-items-center gap-2 text-decoration-none">
            <img src="assets/images/logo.webp" alt="Japan Sport" class="logo"/>
        </a>
        <a href="<%=ctx%>/cart" class="text-decoration-none small">
            <i class="bi bi-chevron-left"></i> Quay về giỏ hàng
        </a>
    </div>

    <% if (errorMessage != null) { %>
    <div class="alert alert-danger"><%=errorMessage%></div>
    <% } %>

    <div class="row g-4">
        <div class="col-lg-7">
            <div class="panel">
                <div class="panel-body">
                    <h5 class="mb-3">Thông tin nhận hàng</h5>

                    <form id="checkoutForm" method="post" action="<%=ctx%>/checkout" novalidate>
                        <div class="row g-3">
                            <div class="col-12">
                                <input class="form-control" type="email" name="email" value="<%= shipEmail %>" placeholder="Email" required>
                                <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                            </div>

                            <div class="col-12">
                                <input class="form-control" type="text" name="fullName" value="<%= shipName %>" placeholder="Họ và tên" required>
                                <div class="invalid-feedback">Vui lòng nhập họ và tên.</div>
                            </div>

                            <div class="col-12">
                                <input class="form-control" type="tel" name="phone" value="<%= shipPhone %>" placeholder="Số điện thoại" required>
                                <div class="invalid-feedback">Vui lòng nhập số điện thoại.</div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small text-muted">Tỉnh / Thành phố</label>
                                <select class="form-select" id="city" name="city" required>
                                    <option value="" selected disabled>Chọn Tỉnh/Thành</option>
                                </select>
                                <div class="invalid-feedback">Vui lòng chọn Tỉnh/Thành.</div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small text-muted">Phường / Xã, Quận / Huyện</label>
                                <input type="text" class="form-control" name="ward" value="<%= shipWard %>" placeholder="Ví dụ: P.15, Q.10" required>
                                <div class="invalid-feedback">Vui lòng nhập Phường/Xã.</div>
                            </div>

                            <div class="col-12">
                                <label class="form-label small text-muted">Số nhà, tên đường...</label>
                                <input class="form-control" type="text" name="addressLine" value="<%= shipAddressLine %>" placeholder="Số nhà, tên đường..." required>
                                <div class="invalid-feedback">Vui lòng nhập số nhà, tên đường.</div>
                            </div>
                        </div>

                        <div class="mt-4">
                            <h5 class="mb-3">Phương thức thanh toán</h5>

                            <div class="mb-2">
                                <input class="payment-radio" type="radio" name="payMethod" id="payBank" value="bank" checked onchange="toggleBankInfo()">
                                <label class="payment-method-card border rounded p-3" for="payBank">
                                    <div>
                                        <i class="bi bi-bank me-2"></i>
                                        <span>Chuyển khoản / Quét mã QR</span>
                                    </div>
                                    <i class="bi bi-check-circle-fill check-mark"></i>
                                </label>
                            </div>

                            <div id="bankInfoPanel" class="border rounded p-3 mb-3" style="background-color: #f8f9fa;">
                                <div class="row align-items-center">
                                    <div class="col-sm-4 text-center mb-3 mb-sm-0">
                                        <img id="qrCodeImg" src="" alt="Mã QR Thanh Toán" class="img-fluid border rounded shadow-sm bg-white" style="max-width: 100%; height: auto; padding: 5px;">
                                    </div>
                                    <div class="col-sm-8">
                                        <p class="mb-2 small"><strong>Ngân hàng:</strong> Vietcombank</p>
                                        <p class="mb-2 small"><strong>Chủ tài khoản:</strong> JAPAN SPORT</p>

                                        <div class="d-flex justify-content-between align-items-center mb-2 small">
                                            <span><strong>Số tài khoản:</strong> 1234567890</span>
                                            <button type="button" class="btn btn-sm btn-outline-secondary py-0 px-2 rounded-pill copy-btn" onclick="copyText('1234567890', this)">
                                                <i class="bi bi-clipboard"></i> Copy
                                            </button>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-center mb-2 small">
                                            <span><strong>Số tiền:</strong> <strong class="text-danger"><%=String.format("%,.0f", finalTotal)%>₫</strong></span>
                                            <button type="button" class="btn btn-sm btn-outline-secondary py-0 px-2 rounded-pill copy-btn" onclick="copyText('<%=finalTotal.toPlainString()%>', this)">
                                                <i class="bi bi-clipboard"></i> Copy
                                            </button>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-center small">
                                            <span><strong>Nội dung:</strong> <span id="payContent">DH <%=shipPhone%></span></span>
                                            <button type="button" class="btn btn-sm btn-outline-secondary py-0 px-2 rounded-pill copy-btn" onclick="copyText('DH <%=shipPhone%>', this)">
                                                <i class="bi bi-clipboard"></i> Copy
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="alert alert-warning mt-3 mb-0 py-2 small border-0">
                                    <i class="bi bi-info-circle-fill text-warning me-1"></i> Sau khi chuyển khoản thành công, vui lòng nhấn nút <strong>ĐẶT HÀNG</strong> ở bên dưới.
                                </div>
                            </div>

                            <div class="mb-2">
                                <input class="payment-radio" type="radio" name="payMethod" id="payCOD" value="cod" onchange="toggleBankInfo()">
                                <label class="payment-method-card border rounded p-3" for="payCOD">
                                    <div>
                                        <i class="bi bi-truck me-2"></i>
                                        <span>Ship COD - Thanh toán tiền mặt khi nhận hàng</span>
                                    </div>
                                    <i class="bi bi-check-circle-fill check-mark"></i>
                                </label>
                            </div>
                        </div>

                        <div class="mt-4">
                            <textarea class="form-control" name="note" rows="3" placeholder="Ghi chú (tuỳ chọn)"></textarea>
                        </div>

                        <div class="mt-4 d-grid">
                            <button class="btn btn-primary" type="submit">ĐẶT HÀNG</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="panel">
                <div class="panel-body">
                    <h5 class="mb-3">Đơn hàng (<span><%=totalQty%></span> sản phẩm)</h5>
                    <div class="vstack gap-3">
                        <% for (CartItem it : items) { %>
                        <div class="d-flex align-items-center justify-content-between">
                            <div class="d-flex align-items-center gap-2 position-relative">
                                <img class="item-thumb" src="<%=it.getImageUrl()%>" alt="<%=it.getProductName()%>">
                                <span class="qty-badge text-white bg-secondary"><%=it.getQuantity()%></span>
                                <div class="ms-1" style="max-width:280px">
                                    <div class="fw-semibold small"><%=it.getProductName()%></div>
                                    <% if (it.getVariantId() != null) { %>
                                    <div class="small text-muted">Màu: <%=it.getColor()%> | Size: <%=it.getSize()%></div>
                                    <% } %>
                                </div>
                            </div>
                            <div class="fw-semibold"><%=String.format("%,.0f", it.getSubtotal())%>₫</div>
                        </div>
                        <% } %>
                    </div>

                    <div class="divider my-3 border-bottom"></div>

                    <%-- ===== VOUCHER SECTION ===== --%>
                    <% if (voucherSuccess != null) { %>
                    <div class="alert alert-success py-2 px-3 mb-2 small">
                        <i class="bi bi-check-circle-fill me-1"></i><%=voucherSuccess%>
                    </div>
                    <% } %>
                    <% if (voucherError != null) { %>
                    <div class="alert alert-danger py-2 px-3 mb-2 small">
                        <i class="bi bi-x-circle-fill me-1"></i><%=voucherError%>
                    </div>
                    <% } %>

                    <% if (appliedVoucher != null) { %>
                    <%-- Voucher đang áp dụng --%>
                    <div class="voucher-applied-pay d-flex align-items-center justify-content-between mb-3 p-2 rounded-3">
                        <div class="d-flex align-items-center gap-2">
                            <i class="bi bi-ticket-perforated-fill text-success"></i>
                            <div>
                                <div class="fw-bold text-success small"><%=appliedVoucher.getCode()%></div>
                                <div class="text-muted" style="font-size:0.75rem;"><%=appliedVoucher.getName()%></div>
                            </div>
                        </div>
                        <form method="post" action="<%=ctx%>/cart" class="mb-0">
                            <input type="hidden" name="action" value="removeVoucher"/>
                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-2 py-0"
                                    style="font-size:0.75rem;" title="Bỏ voucher">
                                <i class="bi bi-x"></i> Bỏ
                            </button>
                        </form>
                    </div>
                    <% } else { %>
                    <%-- Form nhập mã voucher trên trang thanh toán --%>
                    <div class="mb-2">
                        <form method="post" action="<%=ctx%>/cart" class="d-flex gap-2" id="payVoucherForm">
                            <input type="hidden" name="action" value="applyVoucher"/>
                            <input type="text" id="payVoucherInput" name="voucherCode"
                                   class="form-control form-control-sm text-uppercase"
                                   placeholder="Mã giảm giá..."
                                   maxlength="50" autocomplete="off"
                                   style="border-radius:8px;letter-spacing:1px;font-weight:600;"/>
                            <button type="submit" class="btn btn-sm btn-success px-3" style="white-space:nowrap;border-radius:8px;">
                                Áp dụng
                            </button>
                        </form>
                    </div>

                    <%-- Gợi ý voucher phù hợp --%>
                    <% if (!suggestedVouchers.isEmpty()) { %>
                    <div class="mb-2">
                        <div class="small text-muted mb-1"><i class="bi bi-lightbulb me-1 text-warning"></i>Voucher có thể dùng:</div>
                        <% for (Voucher sv : suggestedVouchers) {
                            String dDesc;
                            if ("percent".equals(sv.getDiscountType())) {
                                dDesc = sv.getDiscountValue().stripTrailingZeros().toPlainString() + "%";
                            } else {
                                dDesc = String.format("%,.0f₫", sv.getDiscountValue());
                            }
                        %>
                        <div class="voucher-suggest-pay d-flex align-items-center justify-content-between px-2 py-1 mb-1 rounded"
                             onclick="applyPayVoucher('<%=sv.getCode()%>')" title="Click để áp dụng">
                            <div>
                                <span class="fw-bold text-success" style="font-size:0.8rem;"><%=sv.getCode()%></span>
                                <span class="badge bg-success ms-1" style="font-size:0.7rem;">-<%=dDesc%></span>
                                <div class="text-muted" style="font-size:0.72rem;"><%=sv.getName()%></div>
                            </div>
                            <span class="text-success" style="font-size:0.75rem;cursor:pointer;">Dùng →</span>
                        </div>
                        <% } %>
                    </div>
                    <% } %>
                    <% } %>
                    <%-- ===== /VOUCHER SECTION ===== --%>

                    <div class="divider my-2 border-bottom"></div>
                    <div class="sum-line d-flex justify-content-between">
                        <span>Tạm tính</span>
                        <strong><%=String.format("%,.0f", subtotal)%>₫</strong>
                    </div>
                    <div class="sum-line d-flex justify-content-between">
                        <span>Phí vận chuyển</span>
                        <span>0₫</span>
                    </div>
                    <% if (appliedVoucher != null && discountAmount.compareTo(BigDecimal.ZERO) > 0) { %>
                    <div class="sum-line d-flex justify-content-between text-success fw-semibold">
                        <span><i class="bi bi-tag-fill me-1"></i>Giảm giá</span>
                        <span>-<%=String.format("%,.0f", discountAmount)%>₫</span>
                    </div>
                    <% } %>
                    <div class="divider my-3 border-bottom"></div>
                    <div class="sum-line fs-5 d-flex justify-content-between">
                        <span><strong>Tổng cộng</strong></span>
                        <strong class="text-primary"><%=String.format("%,.0f", finalTotal)%>₫</strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/site_footer.jspf" %>

<style>
    .voucher-applied-pay {
        background: linear-gradient(135deg, #f0fff4, #e6ffee);
        border: 1.5px dashed #28a745;
    }
    .voucher-suggest-pay {
        background: #f8fff8;
        border: 1px dashed #9ed49e;
        cursor: pointer;
        transition: background 0.2s;
    }
    .voucher-suggest-pay:hover {
        background: #eaffea;
        border-color: #28a745;
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // 1. Validation logic
        const form = document.getElementById('checkoutForm');
        form.addEventListener('submit', (e) => {
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
                form.classList.add('was-validated');
            }
        });

        // 2. Load Tỉnh/Thành
        const citySelect = document.getElementById('city');
        const savedCity = "<%= cityNormalized %>".trim();

        fetch('https://provinces.open-api.vn/api/p/')
            .then(res => res.json())
            .then(data => {
                citySelect.innerHTML = '<option value="" selected disabled>Chọn Tỉnh/Thành</option>';
                data.forEach(p => {
                    let opt = new Option(p.name, p.name);
                    if (p.name === savedCity) opt.selected = true;
                    citySelect.add(opt);
                });
            })
            .catch(err => {
                console.error("API Error:", err);
                citySelect.parentElement.innerHTML = `
                    <label class="form-label small text-muted">Tỉnh / Thành phố</label>
                    <input type="text" class="form-control" name="city" value="${savedCity}" required>
                `;
            });
    });

    // 3. Áp dụng voucher gợi ý trên trang thanh toán
    function applyPayVoucher(code) {
        if (!code) return;
        const input = document.getElementById('payVoucherInput');
        const form  = document.getElementById('payVoucherForm');
        if (input && form) {
            input.value = code.toUpperCase();
            form.submit();
        }
    }
    //4. Xử lý Toggle, Copy và Render QR động
    function toggleBankInfo() {
        const payBank = document.getElementById('payBank');
        const panel = document.getElementById('bankInfoPanel');

        if (!payBank || !panel) return;

        if (payBank.checked) {
            panel.style.display = 'block';
            generateDynamicQR();
        } else {
            panel.style.display = 'none';
        }
    }

    function generateDynamicQR() {
        const qrImg = document.getElementById('qrCodeImg');
        if (!qrImg) return;

        // Ép kiểu an toàn bằng ngoặc kép để tránh đứt gãy chuỗi trong JS
        const rawAmount = "<%= (finalTotal != null) ? finalTotal.toPlainString() : "0" %>";
        const rawPhone = "<%= (shipPhone != null && !shipPhone.isEmpty()) ? shipPhone : "KhachHang" %>";

        // Chuyển thành số nguyên sạch sẽ
        const cleanAmount = parseInt(rawAmount) || 0;

        // Ghép chuỗi nội dung (Dùng nối chuỗi cơ bản cho an toàn tuyệt đối)
        const qrText = "Chuyen khoan:\nNH: Vietcombank\nSTK: 1234567890\nTen: JAPAN SPORT\nTien: " + cleanAmount + " VND\nND: DH " + rawPhone;

        // Đổi sang dùng QuickChart API - Siêu ổn định
        const qrUrl = "https://quickchart.io/qr?size=300x300&text=" + encodeURIComponent(qrText);

        // Gán link vào thẻ img
        qrImg.src = qrUrl;

        // Log ra màn hình console để debug
        console.log("Đã tạo link QR:", qrUrl);
    }

    function copyText(text, btnElement) {
        let textArea = document.createElement("textarea");
        textArea.value = text;
        textArea.style.top = "0";
        textArea.style.left = "0";
        textArea.style.position = "fixed";
        textArea.style.opacity = "0";

        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();

        try {
            document.execCommand('copy');
            const originalHTML = btnElement.innerHTML;
            btnElement.innerHTML = '<i class="bi bi-check2"></i> Đã chép';
            btnElement.classList.replace('btn-outline-secondary', 'btn-success');

            setTimeout(() => {
                btnElement.innerHTML = originalHTML;
                btnElement.classList.replace('btn-success', 'btn-outline-secondary');
            }, 2000);
        } catch (err) {
            console.error('Lỗi khi copy', err);
        }

        document.body.removeChild(textArea);
    }

    document.addEventListener('DOMContentLoaded', function () {
        const radios = document.querySelectorAll('.payment-radio');
        radios.forEach(radio => {
            radio.addEventListener('change', toggleBankInfo);
        });

        // Gọi ngay khi web load xong
        toggleBankInfo();
    });
</script>
</body>
</html>
