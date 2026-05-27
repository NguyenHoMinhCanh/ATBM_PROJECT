<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
    request.setAttribute("pageTitle", "Đánh giá - Admin");
    request.setAttribute("activePage", "reviews");
%>

<%@ include file="/admin/includes/_admin_layout_open.jspf" %>

<div class="container-fluid py-3">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">${pageTitle}</h2>
        <div class="d-flex gap-2">
            <a href="${ctx}/admin/reviews" class="btn ${empty currentStatus ? 'btn-primary' : 'btn-outline-primary'}">Tất cả</a>
            <a href="${ctx}/admin/reviews?status=PENDING" class="btn ${currentStatus == 'PENDING' ? 'btn-warning' : 'btn-outline-warning'}">Chờ duyệt</a>
            <a href="${ctx}/admin/reviews?status=APPROVED" class="btn ${currentStatus == 'APPROVED' ? 'btn-success' : 'btn-outline-success'}">Đã duyệt</a>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card">
        <div class="card-body">
            <form action="${ctx}/admin/reviews" method="POST" id="bulkForm">
                <input type="hidden" name="action" value="updateStatus">
                
                <div class="d-flex align-items-center mb-3 gap-2">
                    <select name="status" class="form-select w-auto" required>
                        <option value="">-- Chọn thao tác hàng loạt --</option>
                        <option value="APPROVED">Duyệt (APPROVED)</option>
                        <option value="PENDING">Bỏ duyệt (PENDING)</option>
                    </select>
                    <button type="submit" class="btn btn-primary" onclick="return confirm('Bạn có chắc chắn muốn thực hiện thao tác này?');">
                        Áp dụng
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th style="width: 40px;">
                                <input class="form-check-input" type="checkbox" id="checkAll">
                            </th>
                            <th>ID</th>
                            <th>Sản phẩm</th>
                            <th>Người dùng</th>
                            <th>Đánh giá</th>
                            <th>Nội dung</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th class="text-end">Xóa</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${reviews}" var="r">
                            <tr>
                                <td>
                                    <input class="form-check-input checkItem" type="checkbox" name="reviewIds" value="${r.id}">
                                </td>
                                <td>${r.id}</td>
                                <td>
                                    <a href="${ctx}/product?id=${r.productId}" target="_blank" class="text-decoration-none">
                                        <c:out value="${r.productName}" />
                                    </a>
                                </td>
                                <td>
                                    <c:out value="${r.userName}" />
                                </td>
                                <td class="text-warning">
                                    ${r.rating} <i class="bi bi-star-fill"></i>
                                </td>
                                <td style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                    <c:out value="${r.comment}" />
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.status == 'APPROVED'}">
                                            <span class="badge bg-success">Đã duyệt</span>
                                        </c:when>
                                        <c:when test="${r.status == 'PENDING'}">
                                            <span class="badge bg-warning text-dark">Chờ duyệt</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${r.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                </td>
                                <td class="text-end">
                                    <a href="${ctx}/admin/reviews?action=delete&id=${r.id}" 
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này không?');">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty reviews}">
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">Không có đánh giá nào</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const checkAll = document.getElementById("checkAll");
        const checkItems = document.querySelectorAll(".checkItem");
        
        if (checkAll) {
            checkAll.addEventListener("change", function() {
                checkItems.forEach(item => item.checked = checkAll.checked);
            });
        }
        
        checkItems.forEach(item => {
            item.addEventListener("change", function() {
                const allChecked = Array.from(checkItems).every(i => i.checked);
                const someChecked = Array.from(checkItems).some(i => i.checked);
                checkAll.checked = allChecked;
                checkAll.indeterminate = someChecked && !allChecked;
            });
        });
        
        document.getElementById("bulkForm").addEventListener("submit", function(e) {
            const hasChecked = Array.from(checkItems).some(i => i.checked);
            const action = document.querySelector('select[name="status"]').value;
            
            if (!hasChecked) {
                e.preventDefault();
                alert("Vui lòng chọn ít nhất 1 đánh giá để thao tác!");
                return;
            }
            if (!action) {
                e.preventDefault();
                alert("Vui lòng chọn thao tác (Duyệt/Bỏ duyệt)!");
                return;
            }
        });
    });
</script>

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
