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
                    <thead class="table-dark">
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
                                        <td>${os.id}</td>
                                        <td><strong>#${os.orderId}</strong></td>
                                        <td><c:out value="${os.customerName}" /></td>
                                        <td class="text-danger fw-bold">
                                            <fmt:formatNumber value="${os.totalAmount}" pattern="#,##0" /> ₫
                                        </td>
                                        <td title="${os.hashData}">
                                            <div class="hash-box"><c:out value="${os.hashData}" /></div>
                                        </td>
                                        <td title="${os.signature}">
                                            <div class="signature-box"><c:out value="${os.signature}" /></div>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${os.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${os.valid}">
                                                    <span class="badge bg-success"><i class="bi bi-check-circle-fill me-1"></i>Hợp lệ</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger"><i class="bi bi-exclamation-triangle-fill me-1"></i>Bị giả mạo</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
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

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
