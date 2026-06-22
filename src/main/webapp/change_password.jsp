<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

            <c:set var="ctx" value="${pageContext.request.contextPath}" />

            <!-- Nếu chưa login -> đá về login kèm back -->
            <c:if test="${empty sessionScope.currentUser}">
                <c:redirect url="/login.jsp">
                    <c:param name="back" value="/change-password" />
                </c:redirect>
            </c:if>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Bảo mật & Chữ ký điện tử</title>

                <!-- Bootstrap & Icons -->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css"
                    rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css"
                    rel="stylesheet">

                <!-- App CSS -->
                <link rel="stylesheet" href="assets/css/style.css">

                <style>
                    /* ===== Sidebar giống layout /orders ===== */
                    .acc-side {
                        border-radius: 18px;
                        box-shadow: 0 8px 18px rgba(0, 0, 0, .08);
                        overflow: hidden;
                        background: #fff;
                    }

                    .acc-side__head {
                        background: #1f2937;
                        color: #fff;
                        padding: 16px;
                    }

                    .acc-side__title {
                        font-weight: 700;
                    }

                    .acc-side__sub {
                        font-size: 12px;
                        opacity: .8;
                    }

                    /* Avatar: chỉ làm to lên + click upload */
                    .acc-avatar-wrap {
                        width: 64px;
                        height: 64px;
                        border-radius: 50%;
                        overflow: hidden;
                        position: relative;
                        flex: 0 0 auto;
                        cursor: pointer;
                        background: rgba(255, 255, 255, .12);
                        border: 2px solid rgba(255, 255, 255, .35);
                    }

                    .acc-avatar-img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        display: block;
                    }

                    .acc-avatar-fallback {
                        width: 100%;
                        height: 100%;
                        display: grid;
                        place-items: center;
                        font-weight: 800;
                        font-size: 22px;
                        color: #fff;
                        background: #374151;
                    }

                    .acc-avatar-edit {
                        position: absolute;
                        right: 3px;
                        bottom: 3px;
                        width: 22px;
                        height: 22px;
                        border-radius: 50%;
                        display: grid;
                        place-items: center;
                        background: #fff;
                        border: 1px solid rgba(0, 0, 0, .08);
                        box-shadow: 0 6px 14px rgba(0, 0, 0, .16);
                        font-size: 12px;
                        color: #111827;
                    }

                    .acc-avatar-wrap input[type="file"] {
                        display: none;
                    }

                    /* Menu items giống /orders (active nền hồng nhạt + icon đỏ) */
                    .acc-menu {
                        padding: 10px;
                    }

                    .acc-menu a {
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        padding: 10px 12px;
                        border-radius: 12px;
                        text-decoration: none;
                        color: #111827;
                    }

                    .acc-menu a i {
                        color: #ef4444;
                    }

                    .acc-menu a:hover {
                        background: #f8fafc;
                    }

                    .acc-menu a.active {
                        background: #ffecec;
                        border: 1px solid rgba(239, 68, 68, .22);
                    }

                    .acc-note {
                        padding: 0 14px 14px;
                        color: #6b7280;
                        font-size: 12px;
                    }

                    /* ===== Main cards ===== */
                    .acc-card {
                        border-radius: 18px;
                        box-shadow: 0 8px 18px rgba(0, 0, 0, .06);
                    }

                    .acc-soft {
                        background: #f3f4f6;
                    }
                </style>
            </head>

            <body>

                <!-- HEADER + navbar -->
                <%@ include file="/WEB-INF/jspf/site_header.jspf" %>

                    <section class="py-4">
                        <div class="container">

                            <!-- Flash / Error -->
                            <c:if test="${not empty sessionScope.FLASH_MSG}">
                                <c:set var="t" value="${sessionScope.FLASH_TYPE}" />
                                <div class="alert
                 ${t == 'success' ? 'alert-success' :
                   t == 'warning' ? 'alert-warning' :
                   t == 'info' ? 'alert-info' : 'alert-danger'}">
                                    ${sessionScope.FLASH_MSG}
                                </div>
                                <c:remove var="FLASH_MSG" scope="session" />
                                <c:remove var="FLASH_TYPE" scope="session" />
                            </c:if>

                            <c:if test="${not empty requestScope.errorMessage}">
                                <div class="alert alert-danger">${requestScope.errorMessage}</div>
                            </c:if>

                            <div class="row g-4">
                                <!-- ===== LEFT SIDEBAR ===== -->
                                <div class="col-lg-3">
                                    <div class="acc-side">
                                        <div class="acc-side__head">
                                            <div class="d-flex align-items-center gap-3">
                                                <!-- Avatar upload -->
                                                <form action="${ctx}/account/avatar" method="post"
                                                    enctype="multipart/form-data" class="m-0">
                                                    <input type="hidden" name="csrf"
                                                        value="${sessionScope.CSRF_TOKEN}" />
                                                    <label class="acc-avatar-wrap" title="Bấm để đổi avatar">
                                                        <c:choose>
                                                            <c:when test="${not empty sessionScope.currentUser.avatar}">
                                                                <img class="acc-avatar-img"
                                                                    src="${ctx}/${sessionScope.currentUser.avatar}"
                                                                    alt="avatar" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="acc-avatar-fallback">
                                                                    ${fn:substring(sessionScope.currentUser.name, 0, 1)}
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <span class="acc-avatar-edit"><i
                                                                class="bi bi-camera"></i></span>
                                                        <input type="file" name="avatar" accept="image/*"
                                                            onchange="this.form.submit()" />
                                                    </label>
                                                </form>

                                                <div>
                                                    <div class="acc-side__title">Tài khoản</div>
                                                    <div class="acc-side__sub">Quản lý hồ sơ</div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="acc-menu">
                                            <a href="${ctx}/account"><i class="bi bi-person"></i> Hồ sơ tài khoản</a>
                                            <a href="${ctx}/orders"><i class="bi bi-receipt"></i> Đơn hàng của tôi</a>
                                            <a class="active" href="${ctx}/change-password"><i
                                                    class="bi bi-shield-lock"></i> Bảo mật & chữ ký điện tử</a>
                                            <a href="#"><i class="bi bi-arrow-repeat"></i> Chính sách đổi trả</a>
                                            <a class="text-danger" href="${ctx}/logout"><i
                                                    class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                                        </div>

                                        <div class="acc-note">
                                            Mẹo: Bạn có thể xem lịch sử mua hàng trong mục “Đơn hàng của tôi”.
                                        </div>
                                    </div>
                                </div>

                                <!-- ===== RIGHT MAIN ===== -->
                                <div class="col-lg-9">
                                    <div class="d-flex align-items-start justify-content-between mb-3">
                                        <div>
                                            <h4 class="mb-1">Bảo mật & Chữ ký điện tử</h4>
                                            <div class="text-muted">Quản lý mật khẩu và thông tin chữ ký số RSA của bạn
                                            </div>
                                        </div>
                                        <a class="btn btn-outline-danger btn-sm" href="${ctx}/home">
                                            <i class="bi bi-bag me-1"></i> Tiếp tục mua sắm
                                        </a>
                                    </div>

                                    <!-- BẢO MẬT & CHỮ KÝ ĐIỆN TỬ CARD (MOVED FROM account.jsp) -->
                                    <div class="card acc-card mb-4 border-danger" style="border-width: 2px;">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center justify-content-between mb-3">
                                                <div class="fw-semibold">
                                                    <i class="bi bi-shield-lock-fill me-2 text-danger"></i> Bảo mật &
                                                    Chữ ký điện tử
                                                </div>
                                                <div class="text-muted small">Bắt buộc để đặt hàng</div>
                                            </div>

                                            <div
                                                class="alert alert-light border border-danger-subtle rounded-4 p-3 mb-3">
                                                <h6 class="text-danger fw-bold"><i
                                                        class="bi bi-exclamation-triangle-fill me-1"></i> Quan trọng:
                                                </h6>
                                                <p class="mb-1 small text-muted">Hệ thống yêu cầu bạn phải sử dụng chữ
                                                    ký điện tử để tạo đơn hàng. Vui lòng làm theo 2 bước sau:</p>
                                                <ol class="mb-0 small text-muted ps-3 mt-2">
                                                    <li class="mb-1">Tạo cặp khóa bảo mật (Hệ thống sẽ tải file Private
                                                        Key về máy bạn).</li>
                                                    <li>Tải công cụ Offline về máy tính để ký xác nhận đơn hàng khi
                                                        thanh toán.</li>
                                                </ol>
                                            </div>

                                            <div class="d-flex flex-column gap-3">

                                                <%--===TRẠNG THÁI KHÓA + CÁC NÚT HÀNH ĐỘNG===--%>
                                                    <div
                                                        class="d-flex align-items-center justify-content-between border-bottom pb-3 gap-2 flex-wrap">
                                                        <div>
                                                            <div class="fw-semibold">Trạng thái Public Key (Lưu trên
                                                                Server)</div>
                                                            <div class="small mt-1">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty sessionScope.currentUser.publicKey}">
                                                                        <span class="badge bg-success"><i
                                                                                class="bi bi-check-circle-fill"></i> Đã
                                                                            cài đặt – Khóa đang hoạt động</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-secondary"><i
                                                                                class="bi bi-x-circle"></i> Chưa cài đặt
                                                                            – Cần tạo khóa để đặt hàng</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex gap-2 flex-wrap">
                                                            <c:choose>
                                                                <%--===ĐÃ CÓ KHÓA: disable nút tạo, hiện nút báo
                                                                    mất===--%>
                                                                    <c:when
                                                                        test="${not empty sessionScope.currentUser.publicKey}">
                                                                        <%-- Nút tạo khóa – bị vô hiệu hóa --%>
                                                                            <button type="button"
                                                                                class="btn btn-danger btn-sm" disabled
                                                                                title="Bạn đã có khóa. Hãy báo mất khóa trước nếu muốn tạo lại.">
                                                                                <i class="bi bi-key"></i> Tạo cặp khóa
                                                                            </button>

                                                                            <%-- Nút báo mất khóa --%>
                                                                                <form method="post"
                                                                                    action="${ctx}/generate-key"
                                                                                    class="m-0">
                                                                                    <input type="hidden" name="action"
                                                                                        value="reset" />
                                                                                    <button type="submit"
                                                                                        class="btn btn-outline-warning btn-sm"
                                                                                        onclick="return confirm('⚠️ Bạn có chắc muốn báo MẤT KHÓA?\n\nPublic Key hiện tại sẽ bị XÓA khỏi hệ thống và bạn cần tạo cặp khóa mới.\nCác chữ ký cũ sẽ không còn hợp lệ.\n\nXác nhận báo mất?')">
                                                                                        <i
                                                                                            class="bi bi-exclamation-triangle-fill"></i>
                                                                                        Báo mất khóa
                                                                                    </button>
                                                                                </form>
                                                                    </c:when>

                                                                    <%--===CHƯA CÓ KHÓA: hiện nút tạo khóa===--%>
                                                                        <c:otherwise>
                                                                            <form method="post"
                                                                                action="${ctx}/generate-key"
                                                                                class="m-0">
                                                                                <button type="submit"
                                                                                    class="btn btn-danger btn-sm"
                                                                                    onclick="return confirm('Hệ thống sẽ tạo cặp khóa RSA cho bạn và tự động tải file Private Key về máy.\n\nHãy lưu file này cẩn thận – bạn sẽ cần nó để ký xác nhận đơn hàng.\n\nXác nhận tạo khóa?')">
                                                                                    <i class="bi bi-key-fill"></i> Tạo
                                                                                    cặp khóa
                                                                                </button>
                                                                            </form>
                                                                        </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>

                                                    <%--===HƯỚNG DẪN KHI ĐÃ CÓ KHÓA===--%>
                                                        <c:if test="${not empty sessionScope.currentUser.publicKey}">
                                                            <div
                                                                class="alert alert-success alert-sm py-2 px-3 mb-0 rounded-3 small">
                                                                <i class="bi bi-info-circle me-1"></i>
                                                                Khóa của bạn đang <strong>hoạt động bình
                                                                    thường</strong>.
                                                                Nếu bị mất file Private Key, hãy nhấn <strong>"Báo mất
                                                                    khóa"</strong>
                                                                để vô hiệu hóa khóa cũ và tạo cặp khóa mới.
                                                            </div>
                                                        </c:if>

                                                        <%--===HƯỚNG DẪN KHI CHƯA CÓ KHÓA===--%>
                                                            <c:if test="${empty sessionScope.currentUser.publicKey}">
                                                                <div
                                                                    class="alert alert-warning alert-sm py-2 px-3 mb-0 rounded-3 small">
                                                                    <i class="bi bi-exclamation-triangle me-1"></i>
                                                                    Bạn <strong>chưa có khóa bảo mật</strong>. Vui lòng
                                                                    tạo cặp khóa để có thể đặt hàng.
                                                                    File Private Key sẽ được tải về máy – hãy
                                                                    <strong>lưu cẩn thận</strong>, không chia sẻ cho ai.
                                                                </div>
                                                            </c:if>

                                                            <%--===CÔNG CỤ KÝ SỐ OFFLINE===--%>
                                                                <div
                                                                    class="d-flex align-items-center justify-content-between">
                                                                    <div>
                                                                        <div class="fw-semibold">Công cụ Ký Số Offline
                                                                            (Máy tính)</div>
                                                                        <div class="small text-muted mt-1">Sử dụng file
                                                                            Private Key tải ở trên để ký hóa đơn.</div>
                                                                    </div>
                                                                    <a href="${ctx}/assets/tools/JapanSport_SignTool.zip"
                                                                        class="btn btn-outline-primary btn-sm" download>
                                                                        <i class="bi bi-download"></i> Tải Tool (.zip)
                                                                    </a>
                                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- LỊCH SỬ KHÓA CARD -->
                                    <div class="card acc-card mb-4">
                                        <div class="card-body">
                                            <div class="fw-semibold mb-3">
                                                <i class="bi bi-clock-history me-2 text-danger"></i> Lịch sử khóa
                                            </div>
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-hover align-middle small mb-0">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th style="width: 80px;">STT</th>
                                                            <th>Khóa công khai (Public Key)</th>
                                                            <th style="width: 180px;">Ngày tạo</th>
                                                            <th style="width: 180px;">Ngày hết hạn</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:choose>
                                                            <c:when test="${not empty requestScope.keyHistory}">
                                                                <c:forEach var="h" items="${requestScope.keyHistory}"
                                                                    varStatus="loop">
                                                                    <tr>
                                                                        <td>${loop.index + 1}</td>
                                                                        <td class="text-truncate"
                                                                            style="max-width: 250px;"
                                                                            title="${h.publicKey}">
                                                                            <code class="user-select-all small">
                                                            <c:choose>
                                                                <c:when test="${not empty h.publicKey}">
                                                                    ${fn:substring(h.publicKey, 0, 15)}...${fn:substring(h.publicKey, fn:length(h.publicKey) - 20, fn:length(h.publicKey))}
                                                                </c:when>
                                                                <c:otherwise>N/A</c:otherwise>
                                                            </c:choose>
                                                        </code>
                                                                        </td>
                                                                        <td>
                                                                            <c:out value="${h.createdAt}" />
                                                                        </td>
                                                                        <td>
                                                                            <c:choose>
                                                                                <c:when test="${empty h.expiredAt}">
                                                                                    <span
                                                                                        class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1"><i
                                                                                            class="bi bi-check-circle-fill me-1"></i>Đang
                                                                                        hoạt động</span>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <c:out value="${h.expiredAt}" />
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <tr>
                                                                    <td colspan="4" class="text-center text-muted py-3">
                                                                        Chưa có lịch sử khóa nào.</td>
                                                                </tr>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- ĐỔI MẬT KHẨU CARD -->
                                    <div class="card acc-card">
                                        <div class="card-body">
                                            <div class="fw-semibold mb-3">
                                                <i class="bi bi-key-fill me-2 text-danger"></i> Thay đổi mật khẩu
                                            </div>

                                            <form method="post" action="${ctx}/change-password" class="row g-3">
                                                <input type="hidden" name="csrf" value="${sessionScope.CSRF_TOKEN}" />

                                                <div class="col-12">
                                                    <label class="form-label">Mật khẩu hiện tại</label>
                                                    <input type="password" class="form-control" name="old_password"
                                                        required>
                                                </div>

                                                <div class="col-md-6">
                                                    <label class="form-label">Mật khẩu mới</label>
                                                    <input type="password" class="form-control" name="new_password"
                                                        minlength="8" required>
                                                    <div class="form-text">Tối thiểu 8 ký tự.</div>
                                                </div>

                                                <div class="col-md-6">
                                                    <label class="form-label">Xác nhận mật khẩu mới</label>
                                                    <input type="password" class="form-control" name="confirm_password"
                                                        minlength="8" required>
                                                </div>

                                                <div class="col-12 d-flex gap-2 flex-wrap mt-2">
                                                    <button type="submit" class="btn btn-danger">Cập nhật mật
                                                        khẩu</button>
                                                    <a href="${ctx}/account" class="btn btn-outline-secondary">Hủy</a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </section>

                    <%@ include file="/WEB-INF/jspf/site_footer.jspf" %>

                        <script>
                            const STORAGE_KEY = 'cart';
                            const getCart = () => {
                                try {
                                    return JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]');
                                } catch (e) {
                                    return [];
                                }
                            };
                            const qs = (sel, root = document) => root.querySelector(sel);

                            function updateCartCount() {
                                const total = getCart().reduce((s, it) => s + (it.qty || 1), 0);
                                const badge = qs('#cartCount');
                                if (badge) {
                                    badge.textContent = total;
                                    badge.style.display = total > 0 ? 'inline-block' : 'none';
                                }
                            }
                            document.addEventListener('DOMContentLoaded', updateCartCount);
                        </script>

            </body>

            </html>