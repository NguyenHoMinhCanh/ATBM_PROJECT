<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
    request.setAttribute("pageTitle", "Xác nhận chữ ký số - Admin");
    request.setAttribute("activePage", "signatures");
%>

<%@ include file="/admin/includes/_admin_layout_open.jspf" %>

<style>
    .hash-box {
        max-width: 200px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        font-family: monospace;
        cursor: pointer;
    }
    .signature-box {
        max-width: 150px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        font-family: monospace;
    }
</style>

<div class="container-fluid py-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">Danh sách xác nhận chữ ký số</h2>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <p class="text-muted">Bảng này lưu trữ toàn bộ lịch sử xác nhận chữ ký điện tử của khách hàng khi đặt hàng. 
                Bạn có thể đối chiếu mã Hash để đảm bảo đơn hàng không bị giả mạo.</p>
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead style="background:#f8f9fc;" class="text-center">
                        <tr>
                            <th>ID</th>
                            <th>Mã Đơn</th>
                            <th>Khách hàng</th>
                            <th>Giá trị</th>
                            <th>Dữ liệu gốc (Hash Data)</th>
                            <th>Chữ ký (Base64)</th>
                            <th>Thời gian ký</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty signatures}">
                                <c:forEach items="${signatures}" var="os">
                                    <tr>
                                        <td class="text-center">${os.id}</td>
                                        <td class="text-center"><strong>#${os.orderId}</strong></td>
                                        <td class="text-center"><c:out value="${os.customerName}" /></td>
                                        <td class="text-center text-danger fw-bold">
                                            <fmt:formatNumber value="${os.totalAmount}" pattern="#,##0" /> ₫
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex align-items-center justify-content-center">
                                                <div class="text-truncate font-monospace text-muted" style="max-width: 120px;" title="${os.hashData}">
                                                    <c:out value="${os.hashData}" />
                                                </div>
                                                <button class="btn btn-sm btn-link text-secondary p-1 ms-1 text-decoration-none" onclick="copyToClipboard('${os.hashData}', this)" title="Copy Mã băm">
                                                    <i class="bi bi-copy"></i>
                                                </button>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex align-items-center justify-content-center">
                                                <div class="text-truncate font-monospace text-muted" style="max-width: 120px;" title="${os.signature}">
                                                    <c:out value="${os.signature}" />
                                                </div>
                                                <button class="btn btn-sm btn-link text-secondary p-1 ms-1 text-decoration-none" onclick="copyToClipboard('${os.signature}', this)" title="Copy Chữ ký">
                                                    <i class="bi bi-copy"></i>
                                                </button>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <fmt:formatDate value="${os.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${os.valid}">
                                                    <div class="d-flex align-items-center justify-content-center text-success fw-bold" title="Hợp lệ">
                                                        <i class="bi bi-check-circle-fill fs-4"></i>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="d-flex align-items-center justify-content-center text-danger fw-bold" title="Bị giả mạo">
                                                        <i class="bi bi-x-circle-fill fs-4"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <a href="${ctx}/admin/orders?action=detail&id=${os.orderId}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-eye"></i> Xem đơn
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-4">Chưa có giao dịch ký số nào.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
function copyToClipboard(text, btn) {
    navigator.clipboard.writeText(text).then(() => {
        const icon = btn.querySelector('i');
        icon.classList.replace('bi-copy', 'bi-check2');
        icon.classList.add('text-success');
        setTimeout(() => {
            icon.classList.replace('bi-check2', 'bi-copy');
            icon.classList.remove('text-success');
        }, 1500);
    }).catch(err => {
        console.error('Lỗi khi copy: ', err);
    });
}
</script>

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
