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

                            <div class="col-md-4">
                                <label class="form-label small text-muted">Tỉnh / Thành phố</label>
                                <select class="form-select" id="ghnProvince" required>
                                    <option value="" selected disabled>Chọn Tỉnh/Thành</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label small text-muted">Quận / Huyện</label>
                                <select class="form-select" id="ghnDistrict" required disabled>
                                    <option value="" selected disabled>Chọn Quận/Huyện</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label small text-muted">Phường / Xã</label>
                                <select class="form-select" id="ghnWard" required disabled>
                                    <option value="" selected disabled>Chọn Phường/Xã</option>
                                </select>
                            </div>

                            <input type="hidden" name="city" id="checkoutCity" value="<%= shipCity %>">
                            <input type="hidden" name="district" id="checkoutDistrict" value="">
                            <input type="hidden" name="ward" id="checkoutWard" value="<%= shipWard %>">
                            <input type="hidden" name="ghnDistrictId" id="ghnDistrictId">
                            <input type="hidden" name="ghnWardCode" id="ghnWardCode">
                            <input type="hidden" name="shippingFee" id="shippingFeeInput" value="0">

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

                            <div id="bankInfoPanel" class="border rounded p-3 mb-3" style="display: none; background-color: #f0f8ff;">
                                <div class="d-flex align-items-start">
                                    <i class="bi bi-shield-check text-primary fs-4 me-3"></i>
                                    <div>
                                        <h6 class="mb-1 text-primary">Thanh toán an toàn qua mã QR</h6>
                                        <p class="mb-0 small text-muted">
                                            Sau khi bạn kiểm tra thông tin và nhấn nút <strong>ĐẶT HÀNG</strong>, hệ thống sẽ tạo đơn và chuyển bạn đến trang <strong>quét mã QR (hỗ trợ tự động nhiều ngân hàng và ví điện tử)</strong>.
                                        </p>
                                    </div>
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

                        <input type="hidden" name="hashData" id="hiddenHashData" value="">
                        <input type="hidden" name="signature" id="hiddenSignature" value="">

                        <div class="mt-4 d-grid">
                            <button class="btn btn-danger btn-lg" type="button" id="btnOpenSignModal">XÁC NHẬN ĐẶT HÀNG</button>
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
                    <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Tạm tính</span>
                                <strong id="uiSubtotal" data-value="<%= subtotal %>"><%=String.format("%,.0f", subtotal)%>₫</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Phí vận chuyển</span>
                                <strong id="uiShippingFee">0₫</strong>
                            </div>
                            <hr class="my-3">
                    <% if (appliedVoucher != null && discountAmount.compareTo(BigDecimal.ZERO) > 0) { %>
                    <div class="sum-line d-flex justify-content-between text-success fw-semibold">
                        <span><i class="bi bi-tag-fill me-1"></i>Giảm giá</span>
                        <span>-<%=String.format("%,.0f", discountAmount)%>₫</span>
                    </div>
                    <% } %>
                    <div class="divider my-3 border-bottom"></div>
                    <div class="sum-line fs-5 d-flex justify-content-between">
                        <span><strong>Tổng cộng</strong></span>
                        <strong class="fs-5 text-primary" id="uiTotal"><%=String.format("%,.0f", finalTotal)%>₫</strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- MODAL CHỮ KÝ ĐIỆN TỬ -->
<div class="modal fade" id="signatureModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title"><i class="bi bi-shield-lock-fill me-2"></i>Xác thực chữ ký điện tử</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-info small mb-3">
                    <i class="bi bi-info-circle-fill me-1"></i>
                    Để đảm bảo an toàn, vui lòng ký xác nhận đơn hàng bằng khóa bí mật (Private Key) của bạn.
                </div>

                <!-- Link tải Tool Ký Offline -->
                <div class="border rounded p-3 mb-4" style="background: linear-gradient(135deg, #fff8f0, #fff3e6); border-color: #ffc107 !important;">
                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-box-arrow-down fs-4 text-warning"></i>
                        <div>
                            <div class="fw-bold small">Chưa có phần mềm ký?</div>
                            <a href="<%=ctx%>/assets/tools/OfflineSignTool.jar" download class="small text-decoration-none">
                                <i class="bi bi-download me-1"></i>Tải Tool Ký Offline (.jar) tại đây
                            </a>
                            <span class="text-muted small"> — Yêu cầu Java Runtime (JRE) để chạy</span>
                        </div>
                    </div>
                </div>

                <!-- Bước 1: Tải file dữ liệu -->
                <div class="mb-4">
                    <h6 class="fw-bold"><span class="badge bg-danger me-2">1</span>Tải file dữ liệu đơn hàng</h6>
                    <p class="small text-muted mb-2">File này chứa thông tin đơn hàng đã chốt (Tên, SĐT, Tổng tiền, Ngày mua, DS Sản phẩm). Hãy mở file này trong Tool Ký Offline.</p>
                    <button type="button" class="btn btn-outline-danger" id="btnDownloadOrderData">
                        <i class="bi bi-download me-2"></i>Tải file đơn hàng (.txt)
                    </button>
                    <span class="ms-2 text-success small" id="downloadStatus" style="display:none;"><i class="bi bi-check-circle-fill"></i> Đã tải</span>
                </div>

                <!-- Bước 2: Dán chữ ký -->
                <div class="mb-3">
                    <h6 class="fw-bold"><span class="badge bg-danger me-2">2</span>Dán mã chữ ký (Signature)</h6>
                    <p class="small text-muted mb-2">Mở Tool Ký Offline, chọn file vừa tải về và file Private Key, nhấn Ký. Sau đó dán kết quả vào đây.</p>
                    <textarea class="form-control font-monospace" id="modalSignature" rows="3" placeholder="Dán mã Base64 chữ ký vào đây..."></textarea>
                </div>

            <!-- Xem trước dữ liệu đơn hàng -->
                <div class="border rounded p-3 bg-light mb-3">
                    <h6 class="fw-bold text-muted mb-2"><i class="bi bi-eye me-1"></i>Xem trước dữ liệu đơn hàng</h6>
                    <pre class="mb-0 small" id="orderDataPreview" style="white-space: pre-wrap; word-break: break-all;"></pre>
                </div>

                <!-- Thông báo lỗi / thành công hiển thị ngay trong popup -->
                <div id="modalAlert" class="alert d-none mb-0" role="alert">
                    <div class="d-flex align-items-center gap-2">
                        <i class="bi" id="modalAlertIcon"></i>
                        <span id="modalAlertMsg"></span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger" id="btnFinalSubmit" disabled>
                    <i class="bi bi-pen-fill me-2"></i>HOÀN TẤT ĐẶT HÀNG
                </button>
            </div>
        </div>
    </div>
</div>

<style>
    @keyframes shakeModal {
        0%, 100% { transform: translateX(0); }
        15% { transform: translateX(-8px); }
        30% { transform: translateX(8px); }
        45% { transform: translateX(-6px); }
        60% { transform: translateX(6px); }
        75% { transform: translateX(-3px); }
        90% { transform: translateX(3px); }
    }
    .shake-it .modal-content {
        animation: shakeModal 0.5s ease-in-out;
    }
    #modalAlert {
        border-radius: 10px;
        transition: all 0.3s ease;
    }
</style>

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

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // 1. Validation logic
        const form = document.getElementById('checkoutForm');

        // 2. Load GHN Location API
        const ghnToken = "0e125c2f-697f-11f1-a973-aee5264794df";
        const ghnShopId = "200740";
        const ghnHeaders = { 'Token': ghnToken, 'ShopId': ghnShopId, 'Content-Type': 'application/json' };

        const provinceSelect = document.getElementById('ghnProvince');
        const districtSelect = document.getElementById('ghnDistrict');
        const wardSelect = document.getElementById('ghnWard');
        
        const inCity = document.getElementById('checkoutCity');
        const inDistrict = document.getElementById('checkoutDistrict');
        const inWard = document.getElementById('checkoutWard');
        const inGhnDistrictId = document.getElementById('ghnDistrictId');
        const inGhnWardCode = document.getElementById('ghnWardCode');

        // Load Tỉnh/Thành
        fetch('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province', { headers: ghnHeaders })
            .then(res => res.json())
            .then(data => {
                if (data.code === 200) {
                    provinceSelect.innerHTML = '<option value="" selected disabled>Chọn Tỉnh/Thành</option>';
                    data.data.forEach(p => {
                        provinceSelect.add(new Option(p.ProvinceName, p.ProvinceID));
                    });
                }
            })
            .catch(err => console.error("Lỗi tải Tỉnh GHN:", err));

        provinceSelect.addEventListener('change', function() {
            inCity.value = this.options[this.selectedIndex].text;
            districtSelect.innerHTML = '<option value="" selected disabled>Đang tải...</option>';
            districtSelect.disabled = true;
            wardSelect.innerHTML = '<option value="" selected disabled>Chọn Phường/Xã</option>';
            wardSelect.disabled = true;

            const provinceId = this.value;
            fetch('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district?province_id=' + provinceId, { headers: ghnHeaders })
                .then(res => res.json())
                .then(data => {
                    if (data.code === 200) {
                        districtSelect.innerHTML = '<option value="" selected disabled>Chọn Quận/Huyện</option>';
                        data.data.forEach(d => {
                            districtSelect.add(new Option(d.DistrictName, d.DistrictID));
                        });
                        districtSelect.disabled = false;
                    }
                });
        });

        districtSelect.addEventListener('change', function() {
            inDistrict.value = this.options[this.selectedIndex].text;
            inGhnDistrictId.value = this.value;
            wardSelect.innerHTML = '<option value="" selected disabled>Đang tải...</option>';
            wardSelect.disabled = true;

            const districtId = this.value;
            fetch('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + districtId, { headers: ghnHeaders })
                .then(res => res.json())
                .then(data => {
                    if (data.code === 200) {
                        wardSelect.innerHTML = '<option value="" selected disabled>Chọn Phường/Xã</option>';
                        data.data.forEach(w => {
                            wardSelect.add(new Option(w.WardName, w.WardCode));
                        });
                        wardSelect.disabled = false;
                    }
                });
        });

        wardSelect.addEventListener('change', function() {
            inWard.value = this.options[this.selectedIndex].text;
            inGhnWardCode.value = this.value;

            document.getElementById('uiShippingFee').innerText = 'Đang tính...';
            fetch('https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee', {
                method: 'POST',
                headers: ghnHeaders,
                body: JSON.stringify({
                    service_type_id: 2,
                    to_district_id: parseInt(inGhnDistrictId.value),
                    to_ward_code: this.value,
                    weight: 500, length: 20, width: 20, height: 10
                })
            })
            .then(res => res.json())
            .then(data => {
                if (data.code === 200) {
                    const fee = data.data.total;
                    document.getElementById('shippingFeeInput').value = fee;
                    document.getElementById('uiShippingFee').innerText = new Intl.NumberFormat('vi-VN').format(fee) + '₫';
                    const subtotal = parseFloat(document.getElementById('uiSubtotal').getAttribute('data-value'));
                    const newTotal = subtotal + fee;
                    document.getElementById('uiTotal').innerText = new Intl.NumberFormat('vi-VN').format(newTotal) + '₫';
                }
            })
            .catch(err => console.error("Lỗi tính phí GHN:", err));
        });

        // Toggle Bank Info
        function toggleBankInfo() {
            const payBank = document.getElementById('payBank');
            const panel = document.getElementById('bankInfoPanel');
            if (!payBank || !panel) return;
            panel.style.display = payBank.checked ? 'block' : 'none';
        }
        const radios = document.querySelectorAll('.payment-radio');
        radios.forEach(radio => radio.addEventListener('change', toggleBankInfo));
        toggleBankInfo();

        // ========== LUỒNG CHỮ KÝ ĐIỆN TỬ MỚI ==========
        let orderDataContent = '';

        // Hàm tạo nội dung dữ liệu đơn hàng (5 trường theo yêu cầu thầy)
        function buildOrderData() {
            const fullName = document.querySelector('input[name="fullName"]').value.trim();
            const phone = document.querySelector('input[name="phone"]').value.trim();
            const totalText = document.getElementById('uiTotal').innerText.replace(/[^0-9]/g, '');
            const total = totalText || '0';
            const now = new Date();
            const dateStr = now.getFullYear() + '-' + 
                            String(now.getMonth() + 1).padStart(2, '0') + '-' + 
                            String(now.getDate()).padStart(2, '0') + ' ' + 
                            String(now.getHours()).padStart(2, '0') + ':' + 
                            String(now.getMinutes()).padStart(2, '0') + ':' + 
                            String(now.getSeconds()).padStart(2, '0');

            // Lấy danh sách sản phẩm từ DOM
            let productList = [];
            document.querySelectorAll('#checkoutForm').forEach(() => {});
            const productEls = document.querySelectorAll('.item-thumb');
            productEls.forEach(el => {
                const row = el.closest('.d-flex');
                if (row) {
                    const nameEl = row.querySelector('.fw-semibold.small');
                    const qtyEl = row.querySelector('.qty-badge');
                    if (nameEl) {
                        const name = nameEl.textContent.trim();
                        const qty = qtyEl ? qtyEl.textContent.trim() : '1';
                        productList.push(name + ' x' + qty);
                    }
                }
            });
            const productStr = productList.join('; ');

            // Format: Tên|SĐT|TổngTiền|NgàyMua|DanhSáchSP
            return fullName + '|' + phone + '|' + total + '|' + dateStr + '|' + productStr;
        }

        // Bấm nút "XÁC NHẬN ĐẶT HÀNG" -> Validate form -> Mở Modal
        document.getElementById('btnOpenSignModal').addEventListener('click', function() {
            // Validate form trước
            if (!form.checkValidity()) {
                form.classList.add('was-validated');
                return;
            }

            // Tạo dữ liệu đơn hàng (chốt thời điểm này)
            orderDataContent = buildOrderData();
            document.getElementById('hiddenHashData').value = orderDataContent;
            document.getElementById('orderDataPreview').textContent = orderDataContent;
            document.getElementById('downloadStatus').style.display = 'none';
            document.getElementById('modalSignature').value = '';
            document.getElementById('btnFinalSubmit').disabled = true;

            // Mở Modal
            const modal = new bootstrap.Modal(document.getElementById('signatureModal'));
            modal.show();
        });

        // Bấm "Tải file đơn hàng"
        document.getElementById('btnDownloadOrderData').addEventListener('click', function() {
            const blob = new Blob([orderDataContent], { type: 'text/plain;charset=utf-8' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'don_hang.txt';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);

            document.getElementById('downloadStatus').style.display = 'inline';
        });

        // Khi dán chữ ký vào textarea -> enable nút Hoàn tất
        document.getElementById('modalSignature').addEventListener('input', function() {
            const sig = this.value.trim();
            document.getElementById('btnFinalSubmit').disabled = (sig.length < 10);
        });

        // Bấm "HOÀN TẤT ĐẶT HÀNG" -> Gửi AJAX thay vì submit form truyền thống
        document.getElementById('btnFinalSubmit').addEventListener('click', function() {
            const sig = document.getElementById('modalSignature').value.trim();
            if (!sig) {
                showModalAlert('error', 'Vui lòng dán mã chữ ký!');
                return;
            }

            // Gán chữ ký vào hidden input để FormData lấy được
            document.getElementById('hiddenSignature').value = sig;
            document.getElementById('hiddenHashData').value = orderDataContent;

            // Đổi nút thành trạng thái Loading (vô hiệu hóa bấm lần 2)
            const btn = this;
            const originalText = btn.innerHTML;
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang xử lý...';

            // Ẩn thông báo lỗi cũ (nếu có)
            hideModalAlert();

            // Gửi form bằng fetch (AJAX) thay vì tải lại trang
            // Dùng URLSearchParams thay vì FormData để Server đọc được req.getParameter()
            const formData = new URLSearchParams(new FormData(form));
            fetch(form.action, {
                method: 'POST',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: formData
            })
            .then(response => response.json().then(data => ({ ok: response.ok, data })))
            .then(({ ok, data }) => {
                if (ok && data.status === 'success') {
                    // Thành công: Hiện thông báo xanh rồi chuyển trang
                    showModalAlert('success', data.message + ' Đang chuyển hướng...');
                    btn.innerHTML = '<i class="bi bi-check-circle-fill me-2"></i>Thành công!';
                    btn.classList.remove('btn-danger');
                    btn.classList.add('btn-success');
                    setTimeout(() => { window.location.href = data.redirectUrl; }, 800);
                } else {
                    // Lỗi: Hiện thông báo đỏ ngay trong popup + rung popup
                    showModalAlert('error', data.message || 'Đã xảy ra lỗi không xác định.');
                    shakeModal();
                    btn.disabled = false;
                    btn.innerHTML = originalText;
                }
            })
            .catch(err => {
                showModalAlert('error', 'Lỗi kết nối đến Server. Vui lòng thử lại!');
                shakeModal();
                btn.disabled = false;
                btn.innerHTML = originalText;
            });
        });

        // Hàm hiển thị thông báo trong popup
        function showModalAlert(type, message) {
            const alertEl = document.getElementById('modalAlert');
            const iconEl = document.getElementById('modalAlertIcon');
            const msgEl = document.getElementById('modalAlertMsg');

            alertEl.className = 'alert mb-0';
            if (type === 'error') {
                alertEl.classList.add('alert-danger');
                iconEl.className = 'bi bi-exclamation-triangle-fill fs-5';
                msgEl.innerHTML = '<strong>Lỗi!</strong> ' + message;
            } else {
                alertEl.classList.add('alert-success');
                iconEl.className = 'bi bi-check-circle-fill fs-5';
                msgEl.innerHTML = '<strong>Thành công!</strong> ' + message;
            }
            alertEl.style.display = 'block';
            // Cuộn xuống để user thấy thông báo
            alertEl.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }

        function hideModalAlert() {
            const alertEl = document.getElementById('modalAlert');
            alertEl.className = 'alert d-none mb-0';
        }

        // Hiệu ứng rung popup khi lỗi
        function shakeModal() {
            const dialog = document.querySelector('#signatureModal .modal-dialog');
            dialog.classList.add('shake-it');
            setTimeout(() => dialog.classList.remove('shake-it'), 600);
        }
    });

    // Áp dụng voucher gợi ý
    function applyPayVoucher(code) {
        if (!code) return;
        const input = document.getElementById('payVoucherInput');
        const form  = document.getElementById('payVoucherForm');
        if (input && form) {
            input.value = code.toUpperCase();
            form.submit();
        }
    }
</script>
</body>
</html>
