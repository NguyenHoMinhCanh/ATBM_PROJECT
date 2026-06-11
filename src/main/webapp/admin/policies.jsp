<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
    request.setAttribute("pageTitle", "Chính sách - Admin");
    request.setAttribute("activePage", "policies");
%>

<%@ include file="/admin/includes/_admin_layout_open.jspf" %>

<style>
    .policy-table th { font-size: 12px; text-transform: uppercase; letter-spacing: 0.04em; color: #5f6368; font-weight: 600; }
    .policy-badge-type {
        display: inline-flex; align-items: center; gap: 5px;
        padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 600;
    }
    .type-GENERAL    { background: #e8f4fd; color: #1a73e8; }
    .type-TERMS      { background: #f3e8fd; color: #7b1fa2; }
    .type-PRIVACY    { background: #e8fdf3; color: #1b7a4d; }
    .type-SHIPPING   { background: #fff3e0; color: #e65100; }
    .type-RETURN     { background: #fce4ec; color: #c62828; }
    .type-PAYMENT    { background: #e3f2fd; color: #0277bd; }
    .type-ORDER_GUIDE { background: #f9fbe7; color: #558b2f; }
    .type-SUPPORT    { background: #fdf3e8; color: #e67e22; }

    .policy-row:hover { background: #fafbfc; }
    .stat-card { border: none; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }
    .stat-card .stat-num { font-size: 28px; font-weight: 700; color: #1a1a1a; }
    .stat-card .stat-label { font-size: 12px; color: #888; margin-top: 2px; }
    .seed-btn { border-radius: 10px; }

    .empty-state-wrap {
        padding: 60px 20px;
        text-align: center;
    }
    .empty-state-wrap .empty-icon {
        font-size: 3.5rem;
        color: #d0d0d0;
        margin-bottom: 12px;
    }
    .empty-state-wrap h5 { color: #888; font-weight: 600; }
    .empty-state-wrap p { color: #aaa; font-size: 14px; }
</style>

<div class="container-fluid py-3">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-1">${pageTitle}</h2>
            <div class="text-muted" style="font-size:13px;">Quản lý các trang chính sách hiển thị trên website</div>
        </div>
        <div class="d-flex gap-2">
            <button class="btn btn-outline-secondary seed-btn" data-bs-toggle="modal" data-bs-target="#seedModal">
                <i class="bi bi-magic me-1"></i> Thêm chính sách mẫu
            </button>
            <a href="${ctx}/admin/policies?action=add" class="btn btn-danger seed-btn">
                <i class="bi bi-plus-circle me-1"></i> Thêm chính sách
            </a>
        </div>
    </div>

    <!-- Alert messages -->
    <c:if test="${param.success == 'create'}">
        <div class="alert alert-success border-0 rounded-3 mb-3" style="border-left:4px solid #22c55e!important;">
            <i class="bi bi-check-circle-fill me-2"></i> Đã thêm chính sách mới thành công!
        </div>
    </c:if>
    <c:if test="${param.success == 'update'}">
        <div class="alert alert-success border-0 rounded-3 mb-3" style="border-left:4px solid #22c55e!important;">
            <i class="bi bi-check-circle-fill me-2"></i> Đã cập nhật chính sách thành công!
        </div>
    </c:if>
    <c:if test="${param.success == 'delete'}">
        <div class="alert alert-warning border-0 rounded-3 mb-3" style="border-left:4px solid #f59e0b!important;">
            <i class="bi bi-trash-fill me-2"></i> Đã xóa chính sách.
        </div>
    </c:if>
    <c:if test="${param.success == 'seed'}">
        <div class="alert alert-success border-0 rounded-3 mb-3" style="border-left:4px solid #22c55e!important;">
            <i class="bi bi-magic me-2"></i> Đã tạo <strong>${param.count}</strong> chính sách mẫu thành công!
            <span class="text-muted ms-2" style="font-size:13px;">(Các chính sách đã tồn tại sẽ bị bỏ qua)</span>
        </div>
    </c:if>
    <c:if test="${param.error == 'notfound'}">
        <div class="alert alert-danger border-0 rounded-3 mb-3" style="border-left:4px solid #dc3545!important;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> Không tìm thấy chính sách.
        </div>
    </c:if>
    <c:if test="${param.error == 'seed_empty'}">
        <div class="alert alert-warning border-0 rounded-3 mb-3" style="border-left:4px solid #f59e0b!important;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> Vui lòng chọn ít nhất một loại chính sách mẫu.
        </div>
    </c:if>

    <!-- Stats Row -->
    <div class="row g-3 mb-4">
        <div class="col-sm-3">
            <div class="card stat-card p-3">
                <div class="stat-num text-danger">${policies.size()}</div>
                <div class="stat-label">Tổng chính sách</div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="card stat-card p-3">
                <div class="stat-num text-success">
                    <c:set var="activeCount" value="0" />
                    <c:forEach items="${policies}" var="p">
                        <c:if test="${p.active}"><c:set var="activeCount" value="${activeCount + 1}" /></c:if>
                    </c:forEach>
                    ${activeCount}
                </div>
                <div class="stat-label">Đang hiển thị</div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="card stat-card p-3">
                <div class="stat-num text-secondary">${policies.size() - activeCount}</div>
                <div class="stat-label">Đang ẩn</div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="card stat-card p-3 d-flex flex-row align-items-center gap-3">
                <i class="bi bi-shield-check text-primary" style="font-size:2rem;opacity:0.6;"></i>
                <div>
                    <div class="stat-label">Footer policy links</div>
                    <div style="font-size:12px; color:#aaa;">${activeCount} đang hiển thị</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Table -->
    <div class="card border-0 rounded-3" style="box-shadow:0 2px 12px rgba(0,0,0,0.07);">
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty policies}">
                    <div class="empty-state-wrap">
                        <div class="empty-icon"><i class="bi bi-shield-x"></i></div>
                        <h5>Chưa có chính sách nào</h5>
                        <p>Bắt đầu bằng cách thêm chính sách mới hoặc sử dụng chính sách mẫu có sẵn</p>
                        <div class="d-flex justify-content-center gap-2">
                            <button class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#seedModal">
                                <i class="bi bi-magic me-1"></i> Thêm chính sách mẫu
                            </button>
                            <a href="${ctx}/admin/policies?action=add" class="btn btn-danger">
                                <i class="bi bi-plus-circle me-1"></i> Thêm mới
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0 policy-table">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Tiêu đề</th>
                                    <th>Loại</th>
                                    <th>Slug</th>
                                    <th class="text-center">Thứ tự</th>
                                    <th class="text-center">Trạng thái</th>
                                    <th class="text-end pe-4">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${policies}" var="p">
                                <tr class="policy-row">
                                    <td class="ps-4 text-muted" style="font-size:13px;">#${p.id}</td>
                                    <td>
                                        <div class="fw-semibold">${p.title}</div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.policyType == 'GENERAL'}"><span class="policy-badge-type type-GENERAL">📋 Chung</span></c:when>
                                            <c:when test="${p.policyType == 'TERMS'}"><span class="policy-badge-type type-TERMS">📜 Điều khoản</span></c:when>
                                            <c:when test="${p.policyType == 'PRIVACY'}"><span class="policy-badge-type type-PRIVACY">🔒 Bảo mật</span></c:when>
                                            <c:when test="${p.policyType == 'SHIPPING'}"><span class="policy-badge-type type-SHIPPING">🚚 Vận chuyển</span></c:when>
                                            <c:when test="${p.policyType == 'RETURN'}"><span class="policy-badge-type type-RETURN">↩️ Đổi trả</span></c:when>
                                            <c:when test="${p.policyType == 'PAYMENT'}"><span class="policy-badge-type type-PAYMENT">💳 Thanh toán</span></c:when>
                                            <c:when test="${p.policyType == 'ORDER_GUIDE'}"><span class="policy-badge-type type-ORDER_GUIDE">📦 Đặt hàng</span></c:when>
                                            <c:when test="${p.policyType == 'SUPPORT'}"><span class="policy-badge-type type-SUPPORT">🎧 Hỗ trợ</span></c:when>
                                            <c:otherwise><span class="policy-badge-type type-GENERAL">${p.policyType}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><code style="font-size:12px; color:#888;">${p.slug}</code></td>
                                    <td class="text-center">
                                        <span class="badge bg-light text-dark border">${p.displayOrder}</span>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${p.active}">
                                                <span class="badge rounded-pill" style="background:#dcfce7;color:#166534;">
                                                    <i class="bi bi-circle-fill me-1" style="font-size:7px;"></i>Hiển thị
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge rounded-pill bg-light text-secondary border">
                                                    <i class="bi bi-circle me-1" style="font-size:7px;"></i>Ẩn
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end pe-4">
                                        <div class="d-flex gap-1 justify-content-end">
                                            <a href="${ctx}/policy?slug=${p.slug}" class="btn btn-sm btn-outline-secondary" target="_blank" title="Xem trên shop" style="border-radius:8px;">
                                                <i class="bi bi-box-arrow-up-right"></i>
                                            </a>
                                            <a href="${ctx}/admin/policies?action=edit&id=${p.id}" class="btn btn-sm btn-outline-primary" title="Chỉnh sửa" style="border-radius:8px;">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="${ctx}/admin/policies?action=delete&id=${p.id}"
                                               class="btn btn-sm btn-outline-danger"
                                               title="Xóa" style="border-radius:8px;"
                                               onclick="return confirm('Bạn có chắc muốn xóa chính sách «${p.title}»?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Seed Modal -->
<div class="modal fade" id="seedModal" tabindex="-1" aria-labelledby="seedModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4" style="box-shadow:0 8px 40px rgba(0,0,0,0.15);">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold" id="seedModalLabel">
                    <i class="bi bi-magic me-2 text-danger"></i>Thêm chính sách mẫu
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body pt-2">
                <p class="text-muted" style="font-size:14px;">
                    Chọn các chính sách mẫu bạn muốn thêm vào hệ thống. Hệ thống sẽ tạo sẵn nội dung mẫu phù hợp với cửa hàng thể thao Nhật.
                </p>
                <div class="list-group list-group-flush" id="seedList">
                    <label class="list-group-item list-group-item-action d-flex gap-3 py-3">
                        <input class="form-check-input flex-shrink-0 mt-0" type="checkbox" name="seedType" value="SHIPPING" checked>
                        <div>
                            <div class="fw-semibold">🚚 Chính sách vận chuyển</div>
                            <div class="text-muted" style="font-size:12px;">Thời gian giao hàng, phí ship, khu vực giao</div>
                        </div>
                    </label>
                    <label class="list-group-item list-group-item-action d-flex gap-3 py-3">
                        <input class="form-check-input flex-shrink-0 mt-0" type="checkbox" name="seedType" value="RETURN" checked>
                        <div>
                            <div class="fw-semibold">↩️ Chính sách đổi trả</div>
                            <div class="text-muted" style="font-size:12px;">Điều kiện đổi trả, thời gian, quy trình</div>
                        </div>
                    </label>
                    <label class="list-group-item list-group-item-action d-flex gap-3 py-3">
                        <input class="form-check-input flex-shrink-0 mt-0" type="checkbox" name="seedType" value="PAYMENT" checked>
                        <div>
                            <div class="fw-semibold">💳 Chính sách thanh toán</div>
                            <div class="text-muted" style="font-size:12px;">Các phương thức thanh toán chấp nhận</div>
                        </div>
                    </label>
                    <label class="list-group-item list-group-item-action d-flex gap-3 py-3">
                        <input class="form-check-input flex-shrink-0 mt-0" type="checkbox" name="seedType" value="PRIVACY">
                        <div>
                            <div class="fw-semibold">🔒 Chính sách bảo mật</div>
                            <div class="text-muted" style="font-size:12px;">Thu thập, bảo vệ thông tin khách hàng</div>
                        </div>
                    </label>
                    <label class="list-group-item list-group-item-action d-flex gap-3 py-3">
                        <input class="form-check-input flex-shrink-0 mt-0" type="checkbox" name="seedType" value="TERMS">
                        <div>
                            <div class="fw-semibold">📜 Điều khoản sử dụng</div>
                            <div class="text-muted" style="font-size:12px;">Quy định chung khi sử dụng website</div>
                        </div>
                    </label>
                    <label class="list-group-item list-group-item-action d-flex gap-3 py-3">
                        <input class="form-check-input flex-shrink-0 mt-0" type="checkbox" name="seedType" value="SUPPORT">
                        <div>
                            <div class="fw-semibold">🎧 Chính sách hỗ trợ khách hàng</div>
                            <div class="text-muted" style="font-size:12px;">Giờ hỗ trợ, kênh liên hệ, cam kết dịch vụ</div>
                        </div>
                    </label>
                    <label class="list-group-item list-group-item-action d-flex gap-3 py-3">
                        <input class="form-check-input flex-shrink-0 mt-0" type="checkbox" name="seedType" value="ORDER_GUIDE">
                        <div>
                            <div class="fw-semibold">📦 Hướng dẫn đặt hàng</div>
                            <div class="text-muted" style="font-size:12px;">Các bước đặt hàng trên website</div>
                        </div>
                    </label>
                </div>
            </div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                <form method="post" action="${ctx}/admin/policies/seed" id="seedForm" style="display:inline;">
                    <input type="hidden" name="types" id="seedTypesInput">
                    <button type="button" class="btn btn-danger" onclick="submitSeed()">
                        <i class="bi bi-magic me-1"></i> Tạo chính sách mẫu
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function submitSeed() {
        var checked = Array.from(document.querySelectorAll('input[name="seedType"]:checked'))
            .map(function(el) { return el.value; });
        if (checked.length === 0) {
            alert('Vui lòng chọn ít nhất 1 loại chính sách mẫu!');
            return;
        }
        document.getElementById('seedTypesInput').value = checked.join(',');
        document.getElementById('seedForm').submit();
    }

    // Auto-dismiss alerts after 4s
    document.querySelectorAll('.alert').forEach(function(el) {
        setTimeout(function() {
            el.style.transition = 'opacity 0.5s';
            el.style.opacity = '0';
            setTimeout(function() { el.remove(); }, 500);
        }, 4000);
    });
</script>

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
