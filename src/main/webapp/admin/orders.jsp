<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
    request.setAttribute("pageTitle", "Đơn hàng - Admin");
    request.setAttribute("activePage", "orders");
%>

<%@ include file="/admin/includes/_admin_layout_open.jspf" %>

<style>
.order-filter-bar {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 1px 4px rgba(0,0,0,.07);
    padding: 1rem 1.25rem;
    margin-bottom: 1.25rem;
}
.status-badge {
    display: inline-block;
    padding: .3em .75em;
    border-radius: 50px;
    font-size: .78rem;
    font-weight: 600;
    letter-spacing: .02em;
}
.status-PENDING  { background: #fff3cd; color: #856404; }
.status-PAID     { background: #cff4fc; color: #0c6678; }
.status-SHIPPING { background: #d1ecf1; color: #0c5460; }
.status-DONE     { background: #d4edda; color: #155724; }
.status-CANCEL   { background: #f8d7da; color: #721c24; }
.pagination .page-link { border-radius: 8px !important; margin: 0 2px; }
.table > tbody > tr { transition: background .15s; }
.table > tbody > tr:hover { background: #f5f7ff; }
.filter-tab { border-radius: 20px !important; padding: .3rem .9rem; font-size: .85rem; }
.filter-tab.active { font-weight: 600; }
</style>

<div class="container-fluid py-3">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="mb-0">${pageTitle}</h2>
        <span class="text-muted small">Tổng: <strong>${totalRecords}</strong> đơn hàng</span>
    </div>

    <%-- Flash messages --%>
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-1"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-1"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <%-- Filter & Search bar --%>
    <div class="order-filter-bar">
        <form method="get" action="${ctx}/admin/orders" id="filterForm" class="row g-2 align-items-end">
            <input type="hidden" name="action" value="list"/>
            <input type="hidden" name="page" value="1" id="pageInput"/>

            <%-- Tìm kiếm --%>
            <div class="col-md-5 col-12">
                <label class="form-label mb-1 small fw-semibold text-muted">Tìm kiếm</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0">
                        <i class="bi bi-search text-muted"></i>
                    </span>
                    <input type="text" class="form-control border-start-0 ps-0"
                           name="q" id="searchInput"
                           placeholder="Tên khách, SĐT, email..."
                           value="${filterKeyword}"/>
                    <c:if test="${not empty filterKeyword}">
                        <a href="${ctx}/admin/orders?action=list&status=${filterStatus}"
                           class="btn btn-outline-secondary" title="Xóa tìm kiếm">
                            <i class="bi bi-x"></i>
                        </a>
                    </c:if>
                </div>
            </div>

            <%-- Lọc trạng thái --%>
            <div class="col-md-5 col-12">
                <label class="form-label mb-1 small fw-semibold text-muted">Trạng thái</label>
                <div class="d-flex flex-wrap gap-1">
                    <a href="${ctx}/admin/orders?action=list&q=${filterKeyword}"
                       class="btn btn-sm filter-tab ${empty filterStatus ? 'btn-dark active' : 'btn-outline-secondary'}">
                        Tất cả
                    </a>
                    <a href="${ctx}/admin/orders?action=list&status=PENDING&q=${filterKeyword}"
                       class="btn btn-sm filter-tab ${filterStatus == 'PENDING' ? 'btn-warning active' : 'btn-outline-warning'}">
                        Chờ xử lý
                    </a>
                    <a href="${ctx}/admin/orders?action=list&status=PAID&q=${filterKeyword}"
                       class="btn btn-sm filter-tab ${filterStatus == 'PAID' ? 'btn-info active' : 'btn-outline-info'}">
                        Đã thanh toán
                    </a>
                    <a href="${ctx}/admin/orders?action=list&status=SHIPPING&q=${filterKeyword}"
                       class="btn btn-sm filter-tab ${filterStatus == 'SHIPPING' ? 'btn-primary active' : 'btn-outline-primary'}">
                        Đang giao
                    </a>
                    <a href="${ctx}/admin/orders?action=list&status=DONE&q=${filterKeyword}"
                       class="btn btn-sm filter-tab ${filterStatus == 'DONE' ? 'btn-success active' : 'btn-outline-success'}">
                        Hoàn tất
                    </a>
                    <a href="${ctx}/admin/orders?action=list&status=CANCEL&q=${filterKeyword}"
                       class="btn btn-sm filter-tab ${filterStatus == 'CANCEL' ? 'btn-danger active' : 'btn-outline-danger'}">
                        Đã hủy
                    </a>
                </div>
            </div>

            <%-- Nút tìm --%>
            <div class="col-md-2 col-12">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-funnel me-1"></i> Tìm kiếm
                </button>
            </div>
        </form>
    </div>

    <%-- Bảng đơn hàng --%>
    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead style="background:#f8f9fc;">
                    <tr>
                        <th class="ps-3" style="width:60px;">ID</th>
                        <th>Khách hàng</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th class="text-end pe-3" style="width:90px;">Thao tác</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${orders}" var="o">
                        <tr>
                            <td class="ps-3 text-muted small fw-bold">#${o.id}</td>

                            <td>
                                <div class="fw-semibold"><c:out value="${o.fullName}" /></div>
                                <c:if test="${not empty o.phone}">
                                    <div class="text-muted small">${o.phone}</div>
                                </c:if>
                            </td>

                            <td class="fw-semibold">
                                <fmt:formatNumber value="${o.totalAmount}" pattern="#,##0" /> ₫
                            </td>

                            <td>
                                <span class="status-badge status-${o.status}">
                                    <c:out value="${o.statusVi}" />
                                </span>
                            </td>

                            <td class="text-muted small">
                                <fmt:formatDate value="${o.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                            </td>

                            <td class="text-end pe-3">
                                <a href="${ctx}/admin/orders?action=detail&id=${o.id}"
                                   class="btn btn-sm btn-outline-primary" title="Xem chi tiết">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="6" class="text-center text-muted py-5">
                                <i class="bi bi-inbox fs-2 d-block mb-2 opacity-30"></i>
                                Không tìm thấy đơn hàng nào
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <%-- Phân trang --%>
        <c:if test="${totalPages > 1}">
            <div class="card-footer bg-transparent d-flex justify-content-between align-items-center py-2 px-3">
                <span class="text-muted small">
                    Trang <strong>${currentPage}</strong> / ${totalPages}
                </span>
                <nav>
                    <ul class="pagination pagination-sm mb-0">

                        <%-- Trang đầu / Trước --%>
                        <c:choose>
                            <c:when test="${currentPage <= 1}">
                                <li class="page-item disabled">
                                    <span class="page-link"><i class="bi bi-chevron-double-left"></i></span>
                                </li>
                                <li class="page-item disabled">
                                    <span class="page-link"><i class="bi bi-chevron-left"></i></span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="${ctx}/admin/orders?action=list&page=1&status=${filterStatus}&q=${filterKeyword}">
                                        <i class="bi bi-chevron-double-left"></i>
                                    </a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="${ctx}/admin/orders?action=list&page=${currentPage-1}&status=${filterStatus}&q=${filterKeyword}">
                                        <i class="bi bi-chevron-left"></i>
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>

                        <%-- Số trang (hiện tối đa 5 trang xung quanh trang hiện tại) --%>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:set var="diff" value="${i - currentPage}"/>
                            <c:if test="${diff >= -2 && diff <= 2}">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <li class="page-item active">
                                            <span class="page-link">${i}</span>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="${ctx}/admin/orders?action=list&page=${i}&status=${filterStatus}&q=${filterKeyword}">${i}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>

                        <%-- Sau / Trang cuối --%>
                        <c:choose>
                            <c:when test="${currentPage >= totalPages}">
                                <li class="page-item disabled">
                                    <span class="page-link"><i class="bi bi-chevron-right"></i></span>
                                </li>
                                <li class="page-item disabled">
                                    <span class="page-link"><i class="bi bi-chevron-double-right"></i></span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="${ctx}/admin/orders?action=list&page=${currentPage+1}&status=${filterStatus}&q=${filterKeyword}">
                                        <i class="bi bi-chevron-right"></i>
                                    </a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="${ctx}/admin/orders?action=list&page=${totalPages}&status=${filterStatus}&q=${filterKeyword}">
                                        <i class="bi bi-chevron-double-right"></i>
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
