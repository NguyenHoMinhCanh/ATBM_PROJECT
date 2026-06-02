<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Chi tiết đơn hàng</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/account.css">
</head>

<body>

<%@ include file="/WEB-INF/jspf/site_header.jspf" %>


<section class="py-4">
    <div class="container account-wrap">
        <div class="d-flex align-items-center justify-content-between mb-3 flex-wrap gap-2">
            <div>
                <h4 class="mb-1 account-section-title">Chi tiết đơn #${order.id}</h4>
                <div class="text-muted small">
                    <i class="bi bi-clock me-1"></i> <c:out value="${order.createdAt}"/>
                </div>
            </div>
            <div class="d-flex gap-2">
                <a class="btn btn-outline-secondary rounded-pill" href="${ctx}/orders">
                    <i class="bi bi-arrow-left me-1"></i> Danh sách đơn
                </a>
                <a class="btn btn-outline-danger rounded-pill" href="${ctx}/home">
                    <i class="bi bi-bag me-1"></i> Mua thêm
                </a>

                <c:choose>
                    <%-- 1. Nếu đang CHỜ XỬ LÝ -> Hiện nút Hủy đơn (Mở Modal) --%>
                    <c:when test="${order.status == 'PENDING'}">
                        <button type="button" class="btn btn-outline-danger rounded-pill"
                                onclick="openCancelModal('${order.id}', '/order-detail?id=${order.id}')">
                            <i class="bi bi-x-circle me-1"></i> Hủy đơn
                        </button>
                    </c:when>

                    <%-- 2. Nếu ĐÃ GIAO hoặc ĐÃ HỦY -> Hiện nút Mua lại --%>
                    <c:when test="${order.status == 'DONE' || order.status == 'CANCEL'}">
                        <form method="post" action="${ctx}/reorder" style="display:inline-block;">
                            <input type="hidden" name="orderId" value="${order.id}"/>
                            <button type="submit" class="btn btn-reorder rounded-pill fw-bold">
                                <i class="bi bi-cart-plus me-1"></i> Mua lại đơn này
                            </button>
                        </form>
                    </c:when>
                </c:choose>

            </div>
        </div>

        <!-- Stepper trạng thái -->
        <c:set var="st" value="${order.status}"/>

        <div class="stepper-wrapper ${st == 'CANCEL' ? 'is-cancel' : ''}">
            <c:choose>
                <%-- Trạng thái: ĐÃ HỦY --%>
                <c:when test="${st == 'CANCEL'}">
                    <div class="step active">
                        <div class="icon-box"><i class="bi bi-receipt"></i></div>
                        <div class="text">Tạo đơn</div>
                        <div class="date"><c:out value="${order.createdAt}"/></div>
                    </div>
                    <div class="step cancel">
                        <div class="icon-box"><i class="bi bi-x-circle"></i></div>
                        <div class="text">Đã hủy</div>
                        <div class="date"><c:out value="${order.updatedAt}"/></div>
                    </div>
                </c:when>

                <%-- Trạng thái: BÌNH THƯỜNG --%>
                <c:otherwise>
                    <!-- Bước 1: Tạo đơn -->
                    <div class="step ${st=='PENDING' || st=='PAID' || st=='SHIPPING' || st=='DONE' ? 'active' : ''}">
                        <div class="icon-box"><i class="bi bi-receipt"></i></div>
                        <div class="text">Tạo đơn</div>
                        <div class="date"><c:out value="${order.createdAt}"/></div>
                    </div>

                    <!-- Bước 2: Đã thanh toán / Xử lý -->
                    <div class="step ${st=='PAID' || st=='SHIPPING' || st=='DONE' ? 'active' : ''}">
                        <div class="icon-box"><i class="bi bi-wallet2"></i></div>
                        <div class="text">Đã xác nhận</div>
                        <div class="date">${st=='PAID' || st=='SHIPPING' || st=='DONE' ? order.updatedAt : ''}</div>
                    </div>

                    <!-- Bước 3: Đang giao -->
                    <div class="step ${st=='SHIPPING' || st=='DONE' ? 'active' : ''}">
                        <div class="icon-box"><i class="bi bi-truck"></i></div>
                        <div class="text">Đang giao</div>
                        <div class="date">${st=='SHIPPING' || st=='DONE' ? order.updatedAt : ''}</div>
                    </div>

                    <!-- Bước 4: Hoàn tất -->
                    <div class="step ${st=='DONE' ? 'active' : ''}">
                        <div class="icon-box"><i class="bi bi-box-seam"></i></div>
                        <div class="text">Hoàn tất</div>
                        <div class="date">${st=='DONE' ? order.updatedAt : ''}</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="row g-3">
            <!-- Info -->
            <div class="col-lg-5">
                <div class="card soft-card mb-3">
                    <div class="card-header">
                        <i class="bi bi-truck me-2 text-danger"></i>Thông tin giao hàng
                    </div>
                    <div class="card-body">
                        <div class="fw-bold">${order.fullName}</div>
                        <div class="text-muted">${order.phone}</div>
                        <div class="mt-2">
                            <i class="bi bi-geo-alt me-1"></i>
                            <c:out value="${order.fullAddress}"/>
                        </div>

                        <hr class="my-3"/>

                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted">Trạng thái</div>
                            <div>
                                <c:choose>
                                    <c:when test="${st=='PENDING'}"><span class="badge-status badge-pending">Chờ xử lý</span></c:when>
                                    <c:when test="${st=='PAID'}"><span class="badge-status badge-paid">Đã thanh toán</span></c:when>
                                    <c:when test="${st=='SHIPPING'}"><span class="badge-status badge-shipping">Đang giao</span></c:when>
                                    <c:when test="${st=='DONE'}"><span class="badge-status badge-done">Hoàn tất</span></c:when>
                                    <c:when test="${st=='CANCEL'}"><span class="badge-status badge-cancel">Đã hủy</span></c:when>
                                    <c:otherwise><span class="badge-status badge-pending">${st}</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <hr class="my-3"/>

                        <div class="d-flex justify-content-between align-items-center">
                            <div class="text-muted">Tổng tiền</div>
                            <div class="fw-bold money" data-money="${order.totalAmount}"></div>
                        </div>
                    </div>
                </div>

                <div class="card soft-card">
                    <div class="card-header">
                        <i class="bi bi-info-circle me-2 text-danger"></i>Lưu ý
                    </div>
                    <div class="card-body text-muted small">
                        Nếu cần hỗ trợ đổi trả, vui lòng xem mục “Chính sách đổi trả” hoặc liên hệ hotline.
                    </div>
                </div>
            </div>

            <!-- Items -->
            <div class="col-lg-7">
                <div class="card soft-card">
                    <div class="card-header">
                        <i class="bi bi-bag-check me-2 text-danger"></i>Sản phẩm trong đơn
                    </div>
                    <div class="card-body">
                        <c:forEach var="it" items="${items}">
                            <div class="d-flex gap-3 py-3 border-bottom">
                                <img src="${it.productImageUrl}" alt="${it.productName}"
                                     style="width:84px;height:84px;object-fit:cover;border-radius:14px;"/>
                                <div class="flex-grow-1">
                                    <div class="fw-bold">${it.productName}</div>
                                    <div class="text-muted small">
                                        <c:if test="${not empty it.color}">Màu: ${it.color}</c:if>
                                        <c:if test="${not empty it.size}"> | Size: ${it.size}</c:if>
                                    </div>
                                    <div class="small mt-2">
                                        SL: <b>${it.quantity}</b>
                                        • Đơn giá: <span class="money" data-money="${it.unitPrice}"></span>
                                        • Tạm tính: <span class="money" data-money="${it.subtotal}"></span>
                                    </div>
                                    <c:if test="${st == 'DONE'}">
                                        <a href="${ctx}/product?id=${it.productId}#tab-review"
                                           class="btn btn-sm btn-outline-warning rounded-pill mt-2">
                                            <i class="bi bi-star me-1"></i>Đánh giá sản phẩm
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="pt-3 d-flex justify-content-between align-items-center">
                            <div class="text-muted fs-5">Tổng cộng</div>
                            <div class="fw-bold money fs-4 text-danger" data-money="${order.totalAmount}"></div>
                        </div>
                    </div>
                </div>

                <div class="mt-3 d-flex gap-2 flex-wrap">
                    <a class="btn btn-outline-secondary rounded-pill" href="${ctx}/orders">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại
                    </a>
                    <a class="btn btn-danger rounded-pill" href="${ctx}/home">
                        <i class="bi bi-bag me-1"></i> Mua sắm tiếp
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="modal fade" id="cancelOrderModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title fw-bold"><i class="bi bi-exclamation-triangle me-2"></i>Xác nhận hủy đơn hàng</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <form method="post" action="${ctx}/order-cancel">
                <div class="modal-body p-4">
                    <p class="fs-5 text-center">Bạn có chắc chắn muốn hủy đơn hàng <strong id="modalOrderIdDisplay" class="text-danger"></strong> không?</p>
                    <p class="text-muted text-center small mb-4">Lưu ý: Hành động này không thể hoàn tác.</p>

                    <div class="mb-3">
                        <label for="cancelReason" class="form-label fw-bold text-secondary small">Lý do hủy đơn (Tùy chọn):</label>
                        <select class="form-select rounded-3" name="reason" id="cancelReason">
                            <option value="Thay đổi ý định">Tôi thay đổi ý định mua hàng</option>
                            <option value="Cập nhật địa chỉ/SĐT">Tôi muốn cập nhật địa chỉ/SĐT nhận hàng</option>
                            <option value="Thêm/Bớt sản phẩm">Tôi muốn thêm/bớt sản phẩm</option>
                            <option value="Khác">Lý do khác</option>
                        </select>
                    </div>

                    <input type="hidden" name="id" id="modalOrderIdInput" value=""/>
                    <input type="hidden" name="redirect" id="modalRedirectInput" value=""/>
                    <input type="hidden" name="csrf" value="${sessionScope.CSRF_TOKEN}"/>
                </div>

                <div class="modal-footer border-0 justify-content-center bg-light rounded-bottom">
                    <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Không, giữ lại</button>
                    <button type="submit" class="btn btn-danger rounded-pill px-4">Đồng ý hủy đơn</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/site_footer.jspf" %>

<style>
    .stepper-wrapper {
        display: flex;
        justify-content: space-between;
        margin-bottom: 2rem;
        position: relative;
        padding: 0 20px;
        margin-top: 1.5rem;
    }
    .stepper-wrapper::before {
        content: "";
        position: absolute;
        top: 25px;
        left: 10%;
        width: 80%;
        height: 4px;
        background-color: #e0e0e0;
        z-index: 1;
    }
    .step {
        position: relative;
        z-index: 2;
        text-align: center;
        flex: 1;
    }
    .step .icon-box {
        width: 50px;
        height: 50px;
        background-color: #e0e0e0;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 10px;
        font-size: 1.5rem;
        color: white;
        border: 4px solid #fff;
        transition: all 0.3s;
    }
    .step .text { font-size: 0.95rem; color: #6c757d; font-weight: bold; }
    .step .date { font-size: 0.8rem; color: #adb5bd; margin-top: 4px; }

    /* Đổi màu khi Active (Xanh lá) */
    .step.active .icon-box { background-color: #198754; }
    .step.active .text { color: #198754; }

    /* Đổi màu khi Hủy (Đỏ) */
    .step.cancel .icon-box { background-color: #dc3545; }
    .step.cancel .text { color: #dc3545; }

    /* Rút ngắn thanh kẻ ngang nếu đơn bị hủy */
    .stepper-wrapper.is-cancel::before { width: 50%; left: 25%; }

    /* HIỆU ỨNG NÚT MUA LẠI PASTEL VÀNG NHẠT */
    .btn-reorder {
        background-color: #fff9e6;
        color: #d49a00 !important;
        border: 1px solid #ffe680;
        transition: all 0.3s ease;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02);
    }

    .btn-reorder:hover {
        background-color: #fff2cc;
        color: #b38000 !important;
        border-color: #ffd966;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(212, 154, 0, 0.1);
    }

    .btn-reorder:active {
        transform: translateY(0);
        background-color: #ffe699;
    }
</style>
<script>
    function qs(sel){ return document.querySelector(sel); }
    function getCart(){
        try { return JSON.parse(localStorage.getItem('cart') || '[]'); }
        catch(e){ return []; }
    }
    function updateCartCount() {
        const total = getCart().reduce((s, it) => s + (it.qty || 1), 0);
        const badge = qs('#cartCount');
        if (badge) { badge.textContent = total; badge.style.display = total>0?'inline-block':'none'; }
    }
    function fmtVND(n){ return (Number(n||0)).toLocaleString('vi-VN') + '₫'; }
    document.addEventListener('DOMContentLoaded', () => {
        updateCartCount();
        document.querySelectorAll('.money').forEach(el => el.textContent = fmtVND(el.getAttribute('data-money')));
    });
    // Hàm mở Modal và truyền dữ liệu ID đơn hàng vào Form
    function openCancelModal(orderId, redirectUrl) {
        // Cập nhật ID hiển thị trên màn hình
        document.getElementById('modalOrderIdDisplay').innerText = '#' + orderId;

        // Cập nhật dữ liệu vào các thẻ input ẩn
        document.getElementById('modalOrderIdInput').value = orderId;
        document.getElementById('modalRedirectInput').value = redirectUrl;

        // Hiển thị Modal của Bootstrap
        var myModal = new bootstrap.Modal(document.getElementById('cancelOrderModal'));
        myModal.show();
    }
</script>
</body>
</html>
