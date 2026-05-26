<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.japansport.model.Cart" %>
<%@ page import="com.japansport.model.CartItem" %>
<%@ page import="com.japansport.model.Voucher" %>
<%
    String ctx = request.getContextPath();

    Cart cart = (Cart) request.getAttribute("cart");
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");

    // Fallback để không vỡ nếu controller chưa set "cart"
    if (cart == null) {
        if (cartItems == null) cartItems = Collections.emptyList();
        cart = new Cart(0, 0, "ACTIVE", true, cartItems);
    } else {
        cartItems = cart.getItems();
    }

    double subtotal = cart.getSubtotal();
    int totalQty = cart.getTotalQty();

    // Voucher attributes từ CartController
    Voucher appliedVoucher = (Voucher) request.getAttribute("appliedVoucher");
    BigDecimal discountAmount = (BigDecimal) request.getAttribute("discountAmount");
    BigDecimal finalTotal    = (BigDecimal) request.getAttribute("finalTotal");
    String appliedVoucherCode = (String) request.getAttribute("voucherCode");
    List<Voucher> suggestedVouchers = (List<Voucher>) request.getAttribute("suggestedVouchers");
    if (suggestedVouchers == null) suggestedVouchers = new java.util.ArrayList<>();

    if (discountAmount == null) discountAmount = BigDecimal.ZERO;
    if (finalTotal    == null) finalTotal    = BigDecimal.valueOf(subtotal);

    String cartError = (String) session.getAttribute("cartError");
    session.removeAttribute("cartError");

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
    <title>Japan Sport - Giỏ hàng</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet"/>
    <link href="assets/css/style.css" rel="stylesheet"/>
</head>
<body>
<div class="topbar section hidden-xs hidden-sm">
    <a class="section block a-center" href="#">
        <img src="assets/images/banner.webp" alt="Siêu bão khuyến mãi cuối năm" style="width:100%;height:auto;display:flex;">
    </a>
</div>

<%@ include file="/WEB-INF/jspf/site_header.jspf" %>

<main class="bg-light py-5">
    <div class="cart-container">
        <div class="d-flex align-items-center justify-content-between mb-3">
            <h1 class="cart-title">Giỏ hàng của bạn</h1>
            <a href="${ctx}/list-product" class="continue-link btn btn-outline-dark">Tiếp tục mua hàng</a>
        </div>

        <% if (cartError != null) { %>
        <div class="alert alert-danger"><%=cartError%></div>
        <% } %>

        <% if (cartItems.isEmpty()) { %>
        <div class="alert alert-info">Giỏ hàng đang trống.</div>
        <% } else { %>
        <div class="table-responsive bg-white rounded shadow-sm p-3">
            <table class="table align-middle mb-0">
                <thead>
                <tr>
                    <th style="width:120px">Sản phẩm</th>
                    <th>Tên</th>
                    <th style="width:140px">Giá</th>
                    <th style="width:260px">Số lượng</th>
                    <th style="width:140px">Thành tiền</th>
                    <th style="width:70px"></th>
                </tr>
                </thead>
                <tbody>
                <% for (CartItem it : cartItems) { %>
                <tr>
                    <td>
                        <a href="<%=ctx%>/product-detail?id=<%=it.getProductId()%>">
                            <img src="<%=it.getImageUrl()%>" style="width:90px;height:90px;object-fit:cover;border-radius:10px;" class="cart-img-link">
                        </a>
                    </td>
                    <td>
                        <div class="fw-semibold">
                            <a href="<%=ctx%>/product-detail?id=<%=it.getProductId()%>" class="text-decoration-none text-dark product-detail-link">
                                <%=it.getProductName()%>
                            </a>
                        </div>
                        <% if (it.getVariantId() != null) { %>
                        <div class="text-muted small">Màu: <%=it.getColor()%> | Size: <%=it.getSize()%></div>
                        <% } %>
                    </td>
                    <td><%=String.format("%,.0f", it.getUnitPrice())%>₫</td>
                    <td>
                        <input type="number" class="form-control qty-input" style="max-width:110px"
                               name="qty" min="1" value="<%=it.getQuantity()%>"
                               data-price="<%=it.getUnitPrice()%>"
                               data-id="<%=it.getCartItemId()%>"
                               onchange="updateCartItemQty(this)"/>
                    </td>
                    <td id="item-subtotal-<%=it.getCartItemId()%>">
                        <%=String.format("%,.0f", it.getSubtotal())%>₫
                    </td>
                    <td class="text-center">
                        <form method="post" action="<%=ctx%>/cart" id="delete-form-<%=it.getCartItemId()%>">
                            <input type="hidden" name="action" value="remove"/>
                            <input type="hidden" name="cartItemId" value="<%=it.getCartItemId()%>"/>
                            <button class="btn btn-delete-item rounded-circle" type="button" title="Xóa sản phẩm"
                                    data-item-id="<%=it.getCartItemId()%>"
                                    onclick="openDeleteModal(this.dataset.itemId)">
                                <i class="bi bi-trash"></i>
                            </button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>

        <div class="row mt-4 g-4">
            <div class="col-lg-7">
                <form method="post" action="<%=ctx%>/cart" id="clear-cart-form">
                    <input type="hidden" name="action" value="clear"/>
                    <button class="btn btn-accent-outline" type="button" onclick="confirmClearCart()">
                        <i class="bi bi-trash3 me-1"></i> Xoá toàn bộ giỏ hàng
                    </button>
                </form>
            </div>

            <div class="col-lg-5">
                <div class="totals-box p-4 bg-white rounded shadow-sm border">

                    <%-- ======== VOUCHER SECTION ======== --%>
                    <% if (voucherSuccess != null) { %>
                    <div class="alert alert-success alert-dismissible fade show py-2 px-3 mb-3" role="alert" id="voucherSuccessAlert">
                        <i class="bi bi-check-circle-fill me-1"></i><%=voucherSuccess%>
                        <button type="button" class="btn-close btn-close-sm" data-bs-dismiss="alert" aria-label="Đóng"></button>
                    </div>
                    <% } %>
                    <% if (voucherError != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show py-2 px-3 mb-3" role="alert" id="voucherErrorAlert">
                        <i class="bi bi-x-circle-fill me-1"></i><%=voucherError%>
                        <button type="button" class="btn-close btn-close-sm" data-bs-dismiss="alert" aria-label="Đóng"></button>
                    </div>
                    <% } %>

                    <% if (appliedVoucher == null) { %>
                    <%-- Form nhập mã voucher --%>
                    <div class="voucher-section mb-2">
                        <label class="form-label fw-semibold text-uppercase small text-muted mb-1" for="voucherCodeInput">
                            <i class="bi bi-ticket-perforated me-1"></i>Mã giảm giá
                        </label>
                        <form method="post" action="<%=ctx%>/cart" class="d-flex gap-2" id="applyVoucherForm">
                            <input type="hidden" name="action" value="applyVoucher"/>
                            <input type="text" id="voucherCodeInput" name="voucherCode"
                                   class="form-control voucher-input text-uppercase"
                                   placeholder="Nhập mã voucher..."
                                   maxlength="50" autocomplete="off"/>
                            <button type="submit" class="btn btn-voucher-apply px-3" id="btnApplyVoucher">
                                Áp dụng
                            </button>
                        </form>
                    </div>

                    <%-- Gợi ý voucher phù hợp --%>
                    <% if (!suggestedVouchers.isEmpty()) { %>
                    <div class="suggested-vouchers mb-3">
                        <div class="small text-muted mb-1"><i class="bi bi-lightbulb me-1 text-warning"></i>Voucher có thể dùng cho đơn hàng này:</div>
                        <% for (Voucher sv : suggestedVouchers) {
                            String discDesc;
                            if ("percent".equals(sv.getDiscountType())) {
                                discDesc = sv.getDiscountValue().stripTrailingZeros().toPlainString() + "%";
                            } else {
                                discDesc = String.format("%,.0f₫", sv.getDiscountValue());
                            }
                        %>
                        <div class="voucher-suggest-card d-flex align-items-center justify-content-between p-2 mb-1 rounded-3"
                             onclick="applyVoucherCode('<%=sv.getCode()%>')" title="Click để áp dụng">
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-ticket-perforated text-success"></i>
                                <div>
                                    <span class="fw-bold text-success small"><%=sv.getCode()%></span>
                                    <span class="badge bg-success ms-1">-<%=discDesc%></span>
                                    <div class="text-muted" style="font-size:0.75rem;"><%=sv.getName()%></div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-sm btn-outline-success py-0 px-2" style="font-size:0.75rem;">
                                Dùng
                            </button>
                        </div>
                        <% } %>
                    </div>
                    <% } %>

                    <% } else { %>
                    <%-- Voucher đang áp dụng --%>
                    <div class="voucher-applied-badge d-flex align-items-center justify-content-between mb-3 p-2 rounded-3">
                        <div class="d-flex align-items-center gap-2">
                            <i class="bi bi-ticket-perforated-fill text-success fs-5"></i>
                            <div>
                                <div class="fw-bold text-success small"><%=appliedVoucher.getCode()%></div>
                                <div class="text-muted" style="font-size:0.78rem;"><%=appliedVoucher.getName()%></div>
                            </div>
                        </div>
                        <form method="post" action="<%=ctx%>/cart" class="mb-0">
                            <input type="hidden" name="action" value="removeVoucher"/>
                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-2 py-0" title="Bỏ voucher">
                                <i class="bi bi-x"></i> Bỏ
                            </button>
                        </form>
                    </div>
                    <% } %>
                    <%-- ======== /VOUCHER SECTION ======== --%>

                    <hr class="text-muted opacity-25 mt-2 mb-3">

                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="text-muted">Tạm tính</span>
                        <strong id="subtotal" class="fs-6"><%=String.format("%,.0f", subtotal)%>₫</strong>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="text-muted">Phí vận chuyển</span>
                        <span id="shipping" class="fw-semibold">0₫</span>
                    </div>

                    <% if (appliedVoucher != null && discountAmount.compareTo(BigDecimal.ZERO) > 0) { %>
                    <div class="d-flex justify-content-between align-items-center mb-2" id="discountRow">
                        <span class="text-success fw-semibold">
                            <i class="bi bi-tag-fill me-1"></i>Giảm giá
                        </span>
                        <span class="text-success fw-bold" id="discountDisplay">
                            -<%=String.format("%,.0f", discountAmount)%>₫
                        </span>
                    </div>
                    <% } else { %>
                    <div class="d-flex justify-content-between align-items-center mb-2" id="discountRow" style="display:none!important;">
                        <span class="text-success fw-semibold"><i class="bi bi-tag-fill me-1"></i>Giảm giá</span>
                        <span class="text-success fw-bold" id="discountDisplay">-0₫</span>
                    </div>
                    <% } %>

                    <hr class="text-muted opacity-25 my-2">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fs-5 fw-bold text-uppercase">Thành tiền</span>
                        <strong class="fs-3 text-danger fw-bolder" id="grandTotal"><%=String.format("%,.0f", finalTotal)%>₫</strong>
                    </div>
                    <div class="mt-3 d-grid gap-2">
                        <a class="btn btn-buy-now btn-lg checkout-btn fw-bold shadow-sm text-white w-100"
                           href="javascript:void(0);"
                           onclick="goToCheckout('<%=ctx%>/checkout')">
                            MUA NGAY
                        </a>
                        <a class="btn btn-warning checkout-btn fw-semibold" href="<%=request.getContextPath()%>/installment_payment.jsp">
                            HƯỚNG DẪN TRẢ GÓP
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<section class="bg-light py-4">
    <div class="container">
        <div class="row g-3">
            <div class="col-lg-3 col-6">
                <div class="d-flex align-items-center">
                    <div class="feature-item d-flex align-items-start mb-4 p-3 bg-light rounded">
                        <div class="col-3 pt-2">
                            <img src="assets/images/footer/srv_1.png" alt="Service Item" class="img-fluid rounded">
                        </div>
                        <div><h6 class="fw-bold mb-1">VẬN CHUYỂN SIÊU TỐC</h6>
                            <small class="text-muted">Vận chuyển nội thành HN trong 2 tiếng!</small></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-6">
                <div class="d-flex align-items-center">
                    <div class="feature-item d-flex align-items-start mb-4 p-3 bg-light rounded">
                        <div class="col-3 p-0">
                            <img src="assets/images/footer/srv_2.png" alt="Service Item" class="img-fluid rounded">
                        </div>
                        <div><h6 class="fw-bold mb-1">ĐỔI HÀNG</h6>
                            <small class="text-muted">Đổi hàng trong 7 ngày miễn phí!</small></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-6">
                <div class="d-flex align-items-center">
                    <div class="feature-item d-flex align-items-start mb-4 p-3 bg-light rounded">
                        <div class="col-3 p-0">
                            <img src="assets/images/footer/srv_3.png" alt="Service Item" class="img-fluid rounded">
                        </div>
                        <div><h6 class="fw-bold mb-1">TIẾT KIỆM THỜI GIAN</h6>
                            <small class="text-muted">Mua sắm dễ hơn khi online</small></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-6">
                <div class="d-flex align-items-center">
                    <div class="feature-item d-flex align-items-start mb-4 p-3 bg-light rounded">
                        <div class="col-3 p-0">
                            <img src="assets/images/footer/srv_4.png" alt="Service Item" class="img-fluid rounded">
                        </div>
                        <div><h6 class="fw-bold mb-1">ĐỊA CHỈ CỬA HÀNG</h6>
                            <small class="text-muted">Lotus 4, Vinhome Gardenia, Hàm Nghi, Từ Liêm, HN</small></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%-- Modal xác nhận xóa item --%>
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger rounded-pill px-4" id="btnConfirmDelete">Đồng ý xóa</button>
            </div>
        </div>
    </div>
</div>

<%-- Modal xác nhận xóa toàn bộ --%>
<div class="modal fade" id="clearCartModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title fw-bold">Xác nhận</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center py-4">
                Bạn có chắc chắn muốn <b>xóa sạch</b> giỏ hàng không?
            </div>
            <div class="modal-footer border-0 justify-content-center">
                <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger rounded-pill px-4" onclick="submitClearCart()">Đồng ý xóa</button>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/site_footer.jspf" %>

<button class="btn btn-danger position-fixed bottom-0 end-0 m-4 rounded-circle"
        style="width:50px;height:50px;z-index:1000;"
        onclick="window.scrollTo({top:0,behavior:'smooth'})"
        title="Lên đầu trang" aria-label="Lên đầu trang">
    <i class="bi bi-arrow-up"></i>
</button>

<style>
    :root {
        --accent-color: #ee4d2d;
        --accent-hover: #d73211;
        --accent-light: #fff1f0;
        --shadow-smooth: 0 8px 24px rgba(0,0,0,0.08);
    }

    .table-responsive {
        border-radius: 12px !important;
        overflow: hidden;
        border: 1px solid #eee;
        background: #fff;
        transition: all 0.3s ease;
    }
    .table-responsive:hover {
        box-shadow: var(--shadow-smooth) !important;
    }

    .btn-delete-item {
        color: #999;
        border: 1px solid #eee;
        background: #fff;
        width: 36px;
        height: 36px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
    }
    .btn-delete-item:hover {
        background-color: var(--accent-light);
        color: var(--accent-color);
        border-color: var(--accent-color);
        transform: rotate(90deg);
    }

    .btn-accent-outline {
        color: var(--accent-color);
        border: 1px solid var(--accent-color);
        background: transparent;
        font-weight: 600;
        padding: 8px 16px;
        border-radius: 8px;
        transition: all 0.3s ease;
    }
    .btn-accent-outline:hover {
        background-color: var(--accent-color);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(238, 77, 45, 0.2);
    }

    .btn-buy-now {
        background: linear-gradient(135deg, #ff7337 0%, var(--accent-color) 100%);
        border: none;
        color: white !important;
        transition: all 0.3s ease;
    }
    .btn-buy-now:hover {
        transform: scale(1.02);
        box-shadow: 0 6px 15px rgba(238, 77, 45, 0.3) !important;
    }

    .qty-input {
        border-radius: 6px;
        border: 1px solid #ddd;
        text-align: center;
        font-weight: 600;
        transition: all 0.2s;
    }
    .qty-input:focus {
        border-color: var(--accent-color);
        box-shadow: 0 0 0 0.2rem rgba(238, 77, 45, 0.1);
        outline: none;
    }

    .product-detail-link {
        color: #333;
        font-weight: 600;
        text-decoration: none;
        transition: color 0.2s;
    }
    .product-detail-link:hover {
        color: var(--accent-color) !important;
        text-decoration: underline !important;
    }

    .modal-content {
        border-radius: 15px;
        border: none;
    }

    /* Voucher */
    .voucher-input {
        border-radius: 8px;
        border: 1.5px solid #ddd;
        font-weight: 600;
        letter-spacing: 1px;
        transition: border-color 0.2s, box-shadow 0.2s;
    }
    .voucher-input:focus {
        border-color: #28a745;
        box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.15);
        outline: none;
    }

    .btn-voucher-apply {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: #fff;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        white-space: nowrap;
        transition: all 0.25s ease;
    }
    .btn-voucher-apply:hover {
        background: linear-gradient(135deg, #1e8e35, #17a882);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
        color: #fff;
    }

    .voucher-applied-badge {
        background: linear-gradient(135deg, #f0fff4, #e6ffee);
        border: 1.5px dashed #28a745;
        animation: fadeInBadge 0.4s ease;
    }
    @keyframes fadeInBadge {
        from { opacity: 0; transform: translateY(-6px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .voucher-section label {
        font-size: 0.82rem;
    }

    /* Voucher gợi ý */
    .voucher-suggest-card {
        background: #f8fff8;
        border: 1.5px dashed #9ed49e;
        cursor: pointer;
        transition: all 0.2s ease;
    }
    .voucher-suggest-card:hover {
        background: #eaffea;
        border-color: #28a745;
        transform: translateX(2px);
        box-shadow: 0 2px 8px rgba(40,167,69,0.15);
    }
</style>


<script>
    // Giá trị giảm từ server (đọc 1 lần khi load trang)
    const SERVER_DISCOUNT = <%=discountAmount.doubleValue()%>;
    const formatVND = (n) => new Intl.NumberFormat('vi-VN').format(Math.round(n)) + '₫';

    // --- 1. CẬP NHẬT SỐ LƯỢNG (AJAX) ---
    function updateCartItemQty(input) {
        const cartItemId = input.getAttribute('data-id');
        const newQty = parseInt(input.value);
        const unitPrice = parseFloat(input.getAttribute('data-price'));

        if (newQty < 1) return;

        // Cập nhật "Thành tiền" của dòng
        const rowSubtotal = newQty * unitPrice;
        const subtotalEl = document.getElementById('item-subtotal-' + cartItemId);
        if (subtotalEl) subtotalEl.innerText = formatVND(rowSubtotal);

        // Tính lại tổng tiền
        let total = 0;
        document.querySelectorAll('.qty-input').forEach(inp => {
            total += parseFloat(inp.getAttribute('data-price')) * parseInt(inp.value);
        });

        // Hiển thị subtotal
        const subtotalTotalEl = document.getElementById('subtotal');
        if (subtotalTotalEl) subtotalTotalEl.innerText = formatVND(total);

        // Tính grandTotal (trừ discount nếu có)
        const grandTotalEl = document.getElementById('grandTotal');
        if (grandTotalEl) grandTotalEl.innerText = formatVND(Math.max(0, total - SERVER_DISCOUNT));

        fetch("<%=ctx%>/cart", {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: "action=update&cartItemId=" + cartItemId + "&qty=" + newQty
        }).then(response => {
            if (!response.ok) console.error("Lỗi: Không thể lưu dữ liệu vào máy chủ.");
        }).catch(error => console.error('Lỗi kết nối:', error));
    }

    // --- 2. CHUYỂN TRANG THANH TOÁN AN TOÀN ---
    async function goToCheckout(checkoutUrl) {
        const btn = document.querySelector('.checkout-btn');
        if (!btn) return;

        const originalText = btn.innerHTML;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Đang xử lý...';
        btn.style.pointerEvents = 'none';

        try {
            const inputs = document.querySelectorAll('.qty-input');
            const promises = [];
            inputs.forEach(input => {
                const cartItemId = input.getAttribute('data-id');
                const qty = input.value;
                if (qty >= 1) {
                    promises.push(fetch("<%=ctx%>/cart", {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: "action=update&cartItemId=" + cartItemId + "&qty=" + qty
                    }));
                }
            });
            await Promise.all(promises);
            window.location.href = checkoutUrl;
        } catch (error) {
            console.error('Lỗi khi chuẩn bị thanh toán:', error);
            btn.innerHTML = originalText;
            btn.style.pointerEvents = 'auto';
            alert('Có lỗi xảy ra khi lưu giỏ hàng, vui lòng thử lại!');
        }
    }

    // --- 3. MODAL XÁC NHẬN XÓA ITEM ---
    let currentDeleteId = null;
    let deleteModal = null;
    let clearCartModal = null;

    document.addEventListener('DOMContentLoaded', function() {
        const deleteModalEl = document.getElementById('deleteConfirmModal');
        if (deleteModalEl) deleteModal = new bootstrap.Modal(deleteModalEl);

        const clearModalEl = document.getElementById('clearCartModal');
        if (clearModalEl) clearCartModal = new bootstrap.Modal(clearModalEl);

        const confirmBtn = document.getElementById('btnConfirmDelete');
        if (confirmBtn) {
            confirmBtn.addEventListener('click', function() {
                if (currentDeleteId) {
                    const form = document.getElementById('delete-form-' + currentDeleteId);
                    if (form) form.submit();
                }
            });
        }
    });

    function openDeleteModal(cartItemId) {
        currentDeleteId = cartItemId;
        if (deleteModal) deleteModal.show();
    }

    // --- 4. MODAL XÓA TOÀN BỘ ---
    function confirmClearCart() {
        if (clearCartModal) clearCartModal.show();
    }

    function submitClearCart() {
        document.getElementById('clear-cart-form').submit();
    }

    // --- 5. ÁP DỤNG NGAY VOUCHER GỢI Ý ---
    function applyVoucherCode(code) {
        if (!code) return;
        const input = document.getElementById('voucherCodeInput');
        const form  = document.getElementById('applyVoucherForm');
        if (input && form) {
            input.value = code.toUpperCase();
            form.submit();
        }
    }
</script>
</body>
</html>