<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.japansport.model.OrderSignature" %>
<%
    String ctx = request.getContextPath();
    List<OrderSignature> signatures = (List<OrderSignature>) request.getAttribute("signatures");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách xác nhận chữ ký điện tử</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
</head>
<body class="bg-light">

<%@ include file="/admin/includes/header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/admin/sidebar.jsp" %>
        
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 mt-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Danh sách xác nhận chữ ký số</h1>
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
                                <% if (signatures != null && !signatures.isEmpty()) { 
                                    for (OrderSignature os : signatures) { 
                                %>
                                <tr>
                                    <td><%= os.getId() %></td>
                                    <td><strong>#<%= os.getOrderId() %></strong></td>
                                    <td><%= os.getCustomerName() %></td>
                                    <td class="text-danger fw-bold"><%= String.format("%,.0f₫", os.getTotalAmount()) %></td>
                                    <td title="<%= os.getHashData() %>">
                                        <div class="hash-box"><%= os.getHashData() %></div>
                                    </td>
                                    <td title="<%= os.getSignature() %>">
                                        <div class="signature-box"><%= os.getSignature() %></div>
                                    </td>
                                    <td><%= os.getCreatedAt() %></td>
                                    <td>
                                        <% if (os.isValid()) { %>
                                            <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>Hợp lệ</span>
                                        <% } else { %>
                                            <span class="badge bg-danger"><i class="fas fa-exclamation-triangle me-1"></i>Bị giả mạo</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <a href="<%=ctx%>/admin/orders?id=<%= os.getOrderId() %>" class="btn btn-sm btn-primary">
                                            <i class="fas fa-eye"></i> Xem đơn
                                        </a>
                                    </td>
                                </tr>
                                <%  } 
                                   } else { %>
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-4">Chưa có giao dịch ký số nào.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
