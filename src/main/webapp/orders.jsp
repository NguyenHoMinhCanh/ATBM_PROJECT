<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Đơn hàng của tôi</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/account.css">
</head>

<body>
<%@ include file="/WEB-INF/jspf/site_header.jspf" %>


<section class="py-4">
    <div class="container account-wrap">

        <c:if test="${not empty sessionScope.FLASH_MSG}">
            <div class="alert ${sessionScope.FLASH_TYPE == 'success' ? 'alert-success' : 'alert-danger'}">
                    ${sessionScope.FLASH_MSG}
            </div>
            <c:remove var="FLASH_MSG" scope="session"/>
            <c:remove var="FLASH_TYPE" scope="session"/>
        </c:if>

        <div class="row g-4">
            <!-- Sidebar -->
            <div class="col-lg-4 col-xl-3">
                <div class="account-sidebar">
                    <div class="account-card">
                        <div class="account-hero d-flex align-items-center gap-3">
                            <div class="account-avatar">
                                <i class="bi bi-person"></i>
                            </div>
                            <div>
                                <p class="account-user-name mb-0">Tài khoản</p>
                                <p class="account-user-email mb-0">Quản lý đơn hàng</p>
                            </div>
                        </div>
                        <div class="p-3">
                            <div class="account-nav d-grid gap-2">
                                <a href="${ctx}/account"><i class="bi bi-person-badge"></i> Hồ sơ tài khoản</a>
                                <a class="active" href="${ctx}/orders"><i class="bi bi-receipt"></i> Đơn hàng của
                                    tôi</a>
                                <a href="${ctx}/change-password"><i class="bi bi-shield-lock"></i> Bảo mật & mật
                                    khẩu</a>
                                <a href="${ctx}/logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Content -->
            <div class="col-lg-8 col-xl-9">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <div>
                        <h4 class="mb-1 account-section-title">Đơn hàng của tôi</h4>
                        <div class="text-muted">Xem trạng thái, chi tiết và sản phẩm đã mua</div>
                    </div>
                    <a class="btn btn-outline-danger rounded-pill" href="${ctx}/home">
                        <i class="bi bi-bag me-1"></i> Mua thêm
                    </a>
                </div>

                <!-- Search / Filter UI (client-side) -->
                <div class="card soft-card mb-3">
                    <div class="card-body">
                        <div class="row g-2 align-items-center">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                                    <input id="orderSearch" class="form-control"
                                           placeholder="Tìm theo mã đơn (ví dụ: 12)">
                                </div>
                            </div>
                            <div class="col-md-6 d-flex gap-2 justify-content-md-end flex-wrap">
                                <button class="btn btn-outline-secondary rounded-pill btn-sm" data-filter="ALL">Tất cả
                                </button>
                                <button class="btn btn-outline-secondary rounded-pill btn-sm" data-filter="PENDING">Chờ
                                    xử lý
                                </button>
                                <button class="btn btn-outline-secondary rounded-pill btn-sm" data-filter="SHIPPING">
                                    Đang giao
                                </button>
                                <button class="btn btn-outline-secondary rounded-pill btn-sm" data-filter="DONE">Hoàn
                                    tất
                                </button>
                                <button class="btn btn-outline-secondary rounded-pill btn-sm" data-filter="CANCEL">Đã
                                    hủy
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <c:if test="${empty orders}">
                    <div class="card soft-card">
                        <div class="card-body text-center py-5">
                            <h6 class="mb-2">Bạn chưa có đơn hàng nào</h6>
                            <div class="text-muted mb-3">Hãy chọn sản phẩm bạn thích và đặt hàng nhé.</div>
                            <a class="btn btn-danger rounded-pill px-4" href="${ctx}/home">
                                <i class="bi bi-bag me-1"></i> Mua sắm ngay
                            </a>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty orders}">
                    <div class="d-grid gap-3" id="ordersList">
                        <c:forEach var="o" items="${orders}">
                            <c:set var="st" value="${o.status}"/>
                            <c:set var="badgeClass" value="badge-status badge-pending"/>

                            <c:choose>
                                <c:when test="${st == 'PAID'}"><c:set var="badgeClass" value="badge-status badge-paid"/></c:when>
                                <c:when test="${st == 'SHIPPING'}"><c:set var="badgeClass"
                                                                          value="badge-status badge-shipping"/></c:when>
                                <c:when test="${st == 'DONE'}"><c:set var="badgeClass" value="badge-status badge-done"/></c:when>
                                <c:when test="${st == 'CANCEL'}"><c:set var="badgeClass"
                                                                        value="badge-status badge-cancel"/></c:when>
                                <c:otherwise><c:set var="badgeClass" value="badge-status badge-pending"/></c:otherwise>
                            </c:choose>

                            <div class="order-card order-item" data-orderid="${o.id}" data-status="${st}">
                                <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
                                    <div>
                                        <div class="order-meta">
                                            <div class="fw-bold">Đơn #${o.id}</div>
                                            <span class="${badgeClass}">
                                                <c:choose>
                                                    <c:when test="${st=='PENDING'}">Chờ xử lý</c:when>
                                                    <c:when test="${st=='PAID'}">Đã thanh toán</c:when>
                                                    <c:when test="${st=='SHIPPING'}">Đang giao</c:when>
                                                    <c:when test="${st=='DONE'}">Hoàn tất</c:when>
                                                    <c:when test="${st=='CANCEL'}">Đã hủy</c:when>
                                                    <c:otherwise>${st}</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span class="text-muted small">
                                                <i class="bi bi-clock me-1"></i><c:out value="${o.createdAt}"/>
                                            </span>
                                        </div>
                                        <div class="text-muted small mt-1">
                                            <i class="bi bi-geo-alt me-1"></i>
                                            <c:out value="${o.fullAddress}"/>
                                        </div>
                                    </div>

                                    <div class="text-end">
                                        <div class="fw-bold money fs-4 text-danger" data-money="${o.totalAmount}"></div>
                                        <a class="btn btn-outline-danger rounded-pill btn-sm mt-2"
                                           href="${ctx}/order-detail?id=${o.id}">
                                            Xem chi tiết <i class="bi bi-arrow-right ms-1"></i>
                                        </a>

                                        <c:choose>
                                            <%-- 1. Nếu đang CHỜ XỬ LÝ -> Hiện nút Hủy đơn (Mở Modal) --%>
                                            <c:when test="${st == 'PENDING'}">
                                                <button type="button" class="btn btn-outline-danger rounded-pill btn-sm mt-2"
                                                        onclick="openCancelModal('${o.id}', '/orders')">
                                                    <i class="bi bi-x-circle me-1"></i> Hủy đơn
                                                </button>
                                            </c:when>

                                            <%-- 2. Nếu ĐÃ GIAO hoặc ĐÃ HỦY -> Hiện nút Mua lại --%>
                                            <c:when test="${st == 'DONE' || st == 'CANCEL'}">
                                                <form method="post" action="${ctx}/reorder" class="mt-2">
                                                    <input type="hidden" name="orderId" value="${o.id}"/>
                                                    <button type="submit" class="btn btn-reorder rounded-pill fw-bold">
                                                        <i class="bi bi-cart-plus me-1"></i> Mua lại đơn này
                                                    </button>
                                                </form>
                                            </c:when>
                                        </c:choose>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
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
    .order-card {
        background: #fff;
        border: 1px solid #eaeaea;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 16px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        transition: all 0.3s ease;
    }
    .order-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        border-color: #dc3545;
    }

    .badge-status {
        padding: 6px 14px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.85rem;
        display: inline-block;
        margin-top: 5px;
    }
    .badge-pending { background-color: #fd7e14; color: #fff; }
    .badge-paid { background-color: #0dcaf0; color: #000; }
    .badge-shipping { background-color: #0d6efd; color: #fff; }
    .badge-done { background-color: #198754; color: #fff; }
    .badge-cancel { background-color: #dc3545; color: #fff; }

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
    function qs(sel) {
        return document.querySelector(sel);
    }

    function qsa(sel) {
        return document.querySelectorAll(sel);
    }

    function getCart() {
        try {
            return JSON.parse(localStorage.getItem('cart') || '[]');
        } catch (e) {
            return [];
        }
    }

    function updateCartCount() {
        const total = getCart().reduce((s, it) => s + (it.qty || 1), 0);
        const badge = qs('#cartCount');
        if (badge) {
            badge.textContent = total;
            badge.style.display = total > 0 ? 'inline-block' : 'none';
        }
    }

    function fmtVND(n) {
        return (Number(n || 0)).toLocaleString('vi-VN') + '₫';
    }

    document.addEventListener('DOMContentLoaded', () => {
        updateCartCount();
        qsa('.money').forEach(el => el.textContent = fmtVND(el.getAttribute('data-money')));

        // client-side filter
        const buttons = qsa('[data-filter]');
        const items = qsa('.order-item');
        let active = 'ALL';

        function apply() {
            const q = (qs('#orderSearch')?.value || '').trim();
            items.forEach(it => {
                const st = it.getAttribute('data-status') || '';
                const id = it.getAttribute('data-orderid') || '';
                const okStatus = (active === 'ALL') || (st === active);
                const okQuery = (!q) || id.includes(q);
                it.style.display = (okStatus && okQuery) ? '' : 'none';
            });
        }

        buttons.forEach(b => {
            b.addEventListener('click', () => {
                active = b.getAttribute('data-filter');
                buttons.forEach(x => x.classList.remove('btn-danger'));
                buttons.forEach(x => x.classList.add('btn-outline-secondary'));
                b.classList.remove('btn-outline-secondary');
                b.classList.add('btn-danger');
                apply();
            });
        });

        const inp = qs('#orderSearch');
        if (inp) inp.addEventListener('input', apply);

        // default highlight ALL
        const first = qs('[data-filter="ALL"]');
        if (first) first.click();
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
