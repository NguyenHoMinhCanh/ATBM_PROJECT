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
    <c:if test="${param.error == 'missingreason'}">
        <div class="alert alert-danger">Vui lòng nhập lý do thay đổi trạng thái đơn hàng.</div>
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
                    <div class="mb-2"><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>đ</div>

                    <c:if test="${not empty refundRequest}">
                        <div class="alert alert-warning py-2 mb-0 mt-3 small">
                            <i class="bi bi-exclamation-triangle-fill me-1 text-warning"></i>
                            <strong>Yêu cầu hoàn tiền đang chờ:</strong><br/>
                            Số tiền: <strong class="text-danger"><fmt:formatNumber value="${refundRequest.amount}" pattern="#,###"/>đ</strong><br/>
                            Ghi chú: ${refundRequest.note}
                        </div>
                    </c:if>

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
                            <form method="post" action="${ctx}/admin/orders" class="row g-3">
                                <input type="hidden" name="action" value="updateStatus"/>
                                <input type="hidden" name="id" value="${order.id}"/>

                                <div class="col-12">
                                    <label class="form-label mb-1 fw-bold">Trạng thái mới</label>
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
                                                Chọn <strong>DONE</strong> để hoàn tất hoặc <strong>CANCEL</strong> để hủy (hoàn kho).
                                            </c:when>
                                            <c:otherwise>
                                                Nếu chọn <strong>CANCEL</strong> hệ thống sẽ hoàn tồn kho.
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label mb-1 fw-bold">Lý do thay đổi <span class="text-danger">*</span></label>
                                    <textarea class="form-control" name="reason" rows="3" placeholder="Nhập lý do thay đổi trạng thái bắt buộc..." required></textarea>
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

            </div>
        </div>
    </div>

    <!-- Timeline Lịch sử thay đổi trạng thái -->
    <div class="card mt-4">
        <div class="card-body">
            <h5 class="card-title mb-4 text-secondary"><i class="bi bi-clock-history me-1 text-primary"></i> Lịch sử thay đổi trạng thái</h5>
            <c:choose>
                <c:when test="${not empty statusLogs}">
                    <div class="position-relative ps-4 ms-2" style="border-left: 2px solid #dee2e6;">
                        <c:forEach items="${statusLogs}" var="log">
                            <div class="mb-4 position-relative">
                                <!-- Marker Dot -->
                                <div class="position-absolute rounded-circle bg-primary" 
                                     style="width: 12px; height: 12px; left: -31px; top: 6px; border: 2px solid #fff;"></div>
                                
                                <div class="fw-bold">
                                    <span class="badge bg-secondary">${log.fromStatusVi}</span> 
                                    <i class="bi bi-arrow-right mx-1 small text-muted"></i> 
                                    <span class="badge bg-primary">${log.toStatusVi}</span>
                                </div>
                                <div class="small text-muted mt-1">
                                    <span>Người thực hiện: <strong>${log.changedByName}</strong></span>
                                    <span class="mx-2">|</span>
                                    <span>Vào lúc: <fmt:formatDate value="${log.changedAt}" pattern="dd-MM-yyyy HH:mm:ss"/></span>
                                </div>
                                <c:if test="${not empty log.reason}">
                                    <div class="mt-2 p-2 bg-light rounded text-dark small" style="border-left: 3px solid #0d6efd;">
                                        <strong>Lý do:</strong> ${log.reason}
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-muted text-center py-2 small">Chưa có lịch sử thay đổi trạng thái cho đơn hàng này.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
        </div>
    </div>
</div>

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
