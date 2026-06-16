<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
    String orderId = request.getParameter("orderId");

    // Kiểm tra nếu không có mã đơn hàng thì quay về trang chủ
    if (orderId == null || orderId.trim().isEmpty()) {
        response.sendRedirect(ctx + "/home");
        return;
    }

    // Đọc số tiền từ URL và xử lý an toàn
    long totalAmount = 0;
    try {
        String amountParam = request.getParameter("amount");
        if (amountParam != null && !amountParam.isEmpty()) {
            totalAmount = Math.round(Double.parseDouble(amountParam));
        }
    } catch (Exception e) {
        totalAmount = 0;
    }

    // Nội dung chuyển khoản chuẩn hóa gắn liền với mã đơn hàng
    String paymentContent = "DH" + orderId;
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Thanh toán đơn hàng #<%= orderId %></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" rel="stylesheet"/>
    <style>
        .qr-container {
            max-width: 600px;
            margin: 40px auto;
        }
        .copy-btn {
            font-size: 0.8rem;
            cursor: pointer;
        }
        #qrCodeImg {
            max-width: 100%;
            height: auto;
            transition: all 0.3s ease;
        }
        .loading-dots:after {
            content: ' .';
            animation: dots 1.5s steps(5, end) infinite;
        }
        @keyframes dots {
            0%, 20% { content: ' .'; }
            40% { content: ' . .'; }
            60% { content: ' . . .'; }
            80%, 100% { content: ''; }
        }
    </style>
</head>
<body class="bg-light">

<div class="container">
    <div class="qr-container">
        <div class="card shadow-sm border-0 rounded-3">
            <div class="card-body p-4 p-md-5">

                <div class="text-center mb-4">
                    <h4 class="fw-bold text-success"><i class="bi bi-qr-code-scan me-2"></i>Quét Mã QR Thanh Toán</h4>
                    <p class="text-muted small">Đơn hàng <strong class="text-dark">#<%= orderId %></strong> đã được khởi tạo thành công</p>
                </div>

                <div class="row g-4 align-items-center">
                    <div class="col-md-6 text-center">
                        <div class="mb-3">
                            <label class="form-label small text-muted fw-semibold">Chọn ngân hàng / Ví điện tử</label>
                            <select class="form-select form-select-sm backend-select" id="bankSelect" onchange="generateDynamicQR()">
                                <option value="vietinbank" selected>VietinBank</option>
                                <option value="bidv">BIDV</option>
                                <option value="momo">Ví MoMo</option>
                                <option value="vietcombank">Vietcombank</option>
                            </select>
                        </div>

                        <div class="p-2 bg-white border rounded shadow-sm d-inline-block position-relative">
                            <img id="qrCodeImg" src="" alt="Mã QR VietQR">
                        </div>

                        <div class="mt-3 text-primary small fw-semibold">
                            <span class="spinner-border spinner-border-sm me-1" role="status"></span>
                            <span class="loading-dots">Hệ thống đang tự động kiểm tra tiền về</span>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="bg-light p-3 rounded-3 border">
                            <h6 class="fw-bold mb-3 small text-uppercase text-secondary">Thông tin thanh toán</h6>

                            <div class="mb-2 small">
                                <span class="text-muted d-block">Chủ tài khoản:</span>
                                <strong class="text-dark text-uppercase">JAPAN SPORT</strong>
                            </div>

                            <div class="mb-2 small">
                                <span class="text-muted d-block">Số tài khoản:</span>
                                <div class="d-flex justify-content-between align-items-center">
                                    <strong id="stkText" class="text-dark">113366668888</strong>
                                    <button type="button" class="btn btn-sm btn-link p-0 text-decoration-none copy-btn" onclick="copyText('113366668888', this)">
                                        <i class="bi bi-clipboard"></i> Sao chép
                                    </button>
                                </div>
                            </div>

                            <div class="mb-2 small">
                                <span class="text-muted d-block">Số tiền cần thanh toán:</span>
                                <div class="d-flex justify-content-between align-items-center">
                                    <strong class="text-danger fs-5"><%= String.format("%,d", totalAmount) %>₫</strong>
                                    <button type="button" class="btn btn-sm btn-link p-0 text-decoration-none copy-btn" onclick="copyText('<%= totalAmount %>', this)">
                                        <i class="bi bi-clipboard"></i> Sao chép
                                    </button>
                                </div>
                            </div>

                            <div class="mb-0 small">
                                <span class="text-muted d-block">Nội dung chuyển khoản (Bắt buộc chính xác):</span>
                                <div class="d-flex justify-content-between align-items-center bg-white p-2 rounded border border-warning mt-1">
                                    <strong class="text-primary fs-6"><%= paymentContent %></strong>
                                    <button type="button" class="btn btn-sm btn-link p-0 text-decoration-none copy-btn" onclick="copyText('<%= paymentContent %>', this)">
                                        <i class="bi bi-clipboard"></i> Sao chép
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="alert alert-warning border-0 mt-3 p-2 mb-0 small">
                            <i class="bi bi-exclamation-triangle-fill me-1 text-warning"></i> <strong>Chú ý:</strong> Vui lòng giữ nguyên nội dung chuyển khoản <strong><%= paymentContent %></strong> để hệ thống tự động xác nhận đơn hàng trong 30 giây.
                        </div>
                    </div>
                </div>

                <div class="hr border-bottom my-4"></div>
                <div class="text-center">
                    <a href="<%= ctx %>/home" class="btn btn-sm btn-outline-secondary rounded-pill px-3">
                        <i class="bi bi-house-door"></i> Quay về trang chủ
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    // 1. Hàm tạo QR động chuẩn VietQR dựa trên lựa chọn ngân hàng
    function generateDynamicQR() {
        const bank = document.getElementById('bankSelect').value;
        const stk = "113366668888";
        const amount = "<%= totalAmount %>";
        const note = "<%= paymentContent %>";

        // Tạo URL ảnh VietQR tương ứng
        const qrUrl = "https://img.vietqr.io/image/" + bank + "-" + stk + "-compact.jpg?amount=" + amount + "&addInfo=" + encodeURIComponent(note);

        // Gán vào thẻ img
        document.getElementById('qrCodeImg').src = qrUrl;
    }

    // 2. Hàm sao chép văn bản nhanh
    function copyText(text, btnElement) {
        let textArea = document.createElement("textarea");
        textArea.value = text;
        textArea.style.position = "fixed";
        textArea.style.opacity = "0";
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();
        try {
            document.execCommand('copy');
            const originalHTML = btnElement.innerHTML;
            btnElement.innerHTML = '<i class="bi bi-check-lg"></i> Đã chép';
            setTimeout(() => { btnElement.innerHTML = originalHTML; }, 2000);
        } catch (err) {
            console.error('Lỗi khi sao chép', err);
        }
        document.body.removeChild(textArea);
    }

    // 3. AJAX Polling: Cứ mỗi 3 giây gửi yêu cầu hỏi Server xem đơn hàng này đã được thanh toán chưa
    function startPaymentChecking() {
        const orderId = "<%= orderId %>";

        const checkInterval = setInterval(() => {
            fetch('<%= ctx %>/check-order-status?orderId=' + orderId)
                .then(response => response.json())
                .then(data => {
                    // Nếu Server phản hồi trạng thái là đã thanh toán thành công (PAID)
                    if (data && data.status === 'PAID') {
                        clearInterval(checkInterval); // Dừng việc gửi request ngầm
                        // Chuyển hướng người dùng sang thẳng trang chi tiết đơn hàng thành công
                        window.location.href = '<%= ctx %>/order-detail?id=' + orderId;
                    }
                })
                .catch(err => console.error("Lỗi kiểm tra trạng thái đơn hàng:", err));
        }, 3000);
    }

    // Khởi chạy ngay khi trang tải xong
    document.addEventListener('DOMContentLoaded', function () {
        generateDynamicQR();
        startPaymentChecking();
    });
</script>
</body>
</html>