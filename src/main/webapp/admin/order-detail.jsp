<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />


<%
    request.setAttribute("pageTitle", "Chi tiết Đơn hàng - Admin");
    request.setAttribute("activePage", "orders");
%>

<%@ include file="/admin/includes/_admin_layout_open.jspf" %>

<div class="container-fluid py-3">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">${pageTitle}</h2>
        <a href="${ctx}/admin/orders?action=list" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-1"></i> Quay lại
        </a>
    </div>


    <c:if test="${param.error == 'badstatus'}">
        <div class="alert alert-warning">Không thể thay đổi trạng thái hoặc hủy đơn hàng do luồng trạng thái không hợp lệ.</div>
    </c:if>
    <c:if test="${param.error == 'error'}">
        <div class="alert alert-danger">Có lỗi khi hủy đơn. Vui lòng thử lại.</div>
    </c:if>
    <c:if test="${param.success == '1'}">
        <div class="alert alert-success">Đã cập nhật trạng thái đơn hàng.</div>
    </c:if>

    <div class="row g-3">
        <div class="col-lg-4">
            <div class="card">
                <div class="card-body">
                    <h6 class="text-muted">Thông tin đơn hàng</h6>
                    <div class="mb-2"><strong>Mã đơn:</strong> #${order.id}</div>
                    <div class="mb-2"><strong>Khách:</strong> ${order.fullName}</div>
                    <div class="mb-2"><strong>SĐT:</strong> ${order.phone}</div>
                    <div class="mb-2"><strong>Địa chỉ:</strong> ${order.fullAddress}</div>
                    <div class="mb-2"><strong>Trạng thái:</strong> ${order.statusVi} <span class="text-muted">(${order.status})</span></div>
                    <div class="mb-2"><strong>Ngày tạo:</strong> ${order.createdAt}</div>
                    <div class="mb-0"><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>đ</div>

                    <hr class="my-3"/>

                    <h6 class="text-muted">Cập nhật trạng thái</h6>
                    <c:choose>
                        <c:when test="${order.status == 'DONE' || order.status == 'CANCEL'}">
                            <div class="alert alert-light text-center border-0 py-3 mb-0" style="background-color: #f8f9fa;">
                                <c:choose>
                                    <c:when test="${order.status == 'DONE'}">
                                        <i class="bi bi-check-circle-fill text-success fs-3 d-block mb-2"></i>
                                        <span class="fw-bold text-success">Đơn hàng đã hoàn tất</span>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-x-circle-fill text-danger fs-3 d-block mb-2"></i>
                                        <span class="fw-bold text-danger">Đơn hàng đã hủy</span>
                                    </c:otherwise>
                                </c:choose>
                                <div class="text-muted small mt-1">Trạng thái cuối không thể thay đổi nữa.</div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <form method="post" action="${ctx}/admin/orders" class="row g-2 align-items-end">
                                <input type="hidden" name="action" value="updateStatus"/>
                                <input type="hidden" name="id" value="${order.id}"/>

                                <div class="col-12">
                                    <label class="form-label mb-1">Trạng thái mới</label>
                                    <select class="form-select" name="status" required>
                                        <c:if test="${order.status == 'PENDING'}">
                                            <option value="PENDING" selected>PENDING - Chờ xử lý</option>
                                            <option value="PAID">PAID - Đã thanh toán</option>
                                            <option value="SHIPPING">SHIPPING - Đang giao</option>
                                            <option value="CANCEL">CANCEL - Đã hủy</option>
                                        </c:if>
                                        <c:if test="${order.status == 'PAID'}">
                                            <option value="PAID" selected>PAID - Đã thanh toán</option>
                                            <option value="SHIPPING">SHIPPING - Đang giao</option>
                                            <option value="CANCEL">CANCEL - Đã hủy</option>
                                        </c:if>
                                        <c:if test="${order.status == 'SHIPPING'}">
                                            <option value="SHIPPING" selected>SHIPPING - Đang giao</option>
                                            <option value="DONE">DONE - Hoàn tất</option>
                                            <option value="CANCEL">CANCEL - Đã hủy</option>
                                        </c:if>
                                    </select>
                                    <div class="form-text">
                                        <c:choose>
                                            <c:when test="${order.status == 'SHIPPING'}">
                                                Chọn <strong>DONE</strong> để hoàn tất đơn hàng hoặc <strong>CANCEL</strong> để hủy giao hàng (hoàn kho).
                                            </c:when>
                                            <c:otherwise>
                                                Nếu chọn <strong>CANCEL</strong> hệ thống sẽ hoàn tồn kho cho sản phẩm đã đặt.
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="col-12 d-grid">
                                    <button class="btn btn-primary" type="submit" onclick="return confirm('Cập nhật trạng thái đơn hàng?')">
                                        <i class="bi bi-save me-1"></i> Lưu trạng thái
                                    </button>
                                </div>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card">
                <div class="card-body">
                    <h6 class="text-muted">Danh sách sản phẩm</h6>
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Size</th>
                                <th>Màu</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                                <th>Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${items}" var="it">
                                <tr>
                                    <td>${it.productName}</td>
                                    <td>${it.size}</td>
                                    <td>${it.color}</td>
                                    <td>${it.quantity}</td>
                                    <td><fmt:formatNumber value="${it.unitPrice}" pattern="#,###"/>đ</td>
                                    <td><fmt:formatNumber value="${it.subtotal}" pattern="#,###"/>đ</td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty items}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-3">
                                        Không có sản phẩm trong đơn
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-end mt-3 gap-2">

                <c:choose>
                    <c:when test="${order.status == 'PENDING' || order.status == 'PAID' || order.status == 'SHIPPING'}">
                        <a href="${ctx}/admin/orders?action=cancel&id=${order.id}"
                           class="btn btn-outline-danger"
                           onclick="return confirm('Bạn chắc chắn muốn hủy đơn hàng này và hoàn kho?')">
                            <i class="bi bi-x-circle me-1"></i> Hủy đơn
                        </a>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-outline-secondary" disabled title="Đơn hàng đã đóng">
                            <i class="bi bi-x-circle me-1"></i> Không thể hủy
                        </button>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>
</div>

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
