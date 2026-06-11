<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${not empty policy.title ? policy.title : 'Chính sách'} - Japan Sport</title>
    <meta name="description" content="${not empty policy.title ? policy.title : 'Chính sách Japan Sport'}">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- App CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <style>
        /* ===== Policy Page Styles ===== */
        .policy-page-wrap {
            background: #f8f9fa;
            min-height: 60vh;
            padding: 36px 0 60px;
        }

        /* Breadcrumb banner */
        .policy-hero {
            background: linear-gradient(135deg, #c0392b 0%, #e53e3e 50%, #ff6b47 100%);
            color: #fff;
            padding: 32px 0 28px;
            position: relative;
            overflow: hidden;
        }
        .policy-hero::before {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 220px; height: 220px;
            background: rgba(255,255,255,0.07);
            border-radius: 50%;
        }
        .policy-hero::after {
            content: '';
            position: absolute;
            bottom: -80px; left: -40px;
            width: 280px; height: 280px;
            background: rgba(255,255,255,0.05);
            border-radius: 50%;
        }
        .policy-hero h1 {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .policy-hero .breadcrumb {
            background: transparent;
            padding: 0;
            margin: 0;
        }
        .policy-hero .breadcrumb-item,
        .policy-hero .breadcrumb-item a {
            color: rgba(255,255,255,0.8);
            font-size: 13px;
            text-decoration: none;
        }
        .policy-hero .breadcrumb-item.active { color: #fff; }
        .policy-hero .breadcrumb-item + .breadcrumb-item::before { color: rgba(255,255,255,0.5); }

        /* Sidebar */
        .policy-sidebar {
            position: sticky;
            top: 80px;
        }
        .policy-nav-card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.07);
            overflow: hidden;
        }
        .policy-nav-card .nav-header {
            background: linear-gradient(135deg, #e53e3e, #ff6b47);
            color: #fff;
            padding: 14px 18px;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .policy-nav-list { list-style: none; padding: 8px 0; margin: 0; }
        .policy-nav-list li a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 18px;
            color: #555;
            text-decoration: none;
            font-size: 13.5px;
            transition: all 0.18s;
            border-left: 3px solid transparent;
        }
        .policy-nav-list li a:hover {
            background: #fff5f3;
            color: #e53e3e;
            border-left-color: #e53e3e;
            padding-left: 22px;
        }
        .policy-nav-list li a.active {
            background: #fff3f0;
            color: #e53e3e;
            font-weight: 600;
            border-left-color: #e53e3e;
        }
        .policy-nav-list li a i { font-size: 15px; opacity: 0.7; flex-shrink: 0; }
        .policy-nav-list li + li { border-top: 1px solid #f5f5f5; }

        /* Contact card */
        .policy-contact-card {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            color: #fff;
            border-radius: 14px;
            padding: 20px;
            margin-top: 16px;
        }
        .policy-contact-card h6 { font-weight: 700; margin-bottom: 12px; font-size: 13px; text-transform: uppercase; letter-spacing: 0.05em; }
        .policy-contact-card .contact-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
            font-size: 13px;
            color: rgba(255,255,255,0.85);
        }
        .policy-contact-card .contact-item i { color: #ff6b47; flex-shrink: 0; }

        /* Content card */
        .policy-content-card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.07);
            padding: 36px 40px;
        }
        .policy-content-card .policy-type-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background: #fff5f3;
            color: #e53e3e;
            border: 1px solid #fdd;
            margin-bottom: 16px;
        }
        .policy-content-card h1.policy-title {
            font-size: 1.65rem;
            font-weight: 800;
            color: #1a1a1a;
            margin-bottom: 8px;
            line-height: 1.3;
        }
        .policy-content-card .policy-meta {
            font-size: 12px;
            color: #aaa;
            margin-bottom: 28px;
            padding-bottom: 22px;
            border-bottom: 2px solid #f0f0f0;
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }
        .policy-content-card .policy-meta span { display: flex; align-items: center; gap: 5px; }

        /* Content typography */
        .policy-body {
            line-height: 1.85;
            color: #3a3a3a;
            font-size: 15px;
        }
        .policy-body h2 {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1a1a1a;
            margin-top: 32px;
            margin-bottom: 14px;
            padding-bottom: 8px;
            border-bottom: 2px solid #fff0ee;
            position: relative;
        }
        .policy-body h2::before {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 40px;
            height: 2px;
            background: #e53e3e;
        }
        .policy-body h3 {
            font-size: 1.05rem;
            font-weight: 700;
            color: #333;
            margin-top: 24px;
            margin-bottom: 10px;
        }
        .policy-body h4 {
            font-size: 0.95rem;
            font-weight: 600;
            color: #444;
            margin-top: 18px;
            margin-bottom: 8px;
        }
        .policy-body p { margin-bottom: 14px; }
        .policy-body ul, .policy-body ol {
            margin-bottom: 16px;
            padding-left: 24px;
        }
        .policy-body li { margin-bottom: 8px; }
        .policy-body strong { color: #1a1a1a; }
        .policy-body a { color: #e53e3e; }
        .policy-body a:hover { color: #c53030; }
        .policy-body table {
            width: 100%;
            border-collapse: collapse;
            margin: 16px 0;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }
        .policy-body table th {
            background: #f8f9fa;
            padding: 10px 14px;
            text-align: left;
            font-weight: 600;
            border: 1px solid #e0e0e0;
        }
        .policy-body table td {
            padding: 10px 14px;
            border: 1px solid #e0e0e0;
            vertical-align: top;
        }
        .policy-body table tr:nth-child(even) td { background: #fafafa; }

        /* Empty state */
        .policy-empty {
            text-align: center;
            padding: 60px 20px;
            color: #aaa;
        }
        .policy-empty i { font-size: 3rem; margin-bottom: 16px; opacity: 0.4; display: block; }

        /* Share buttons */
        .policy-share {
            display: flex;
            gap: 8px;
            align-items: center;
            margin-top: 32px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
            flex-wrap: wrap;
        }
        .policy-share span { font-size: 13px; color: #888; }
        .share-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            text-decoration: none;
            transition: opacity 0.2s;
        }
        .share-btn:hover { opacity: 0.85; }
        .share-btn.fb { background: #1877f2; color: #fff; }
        .share-btn.tw { background: #1da1f2; color: #fff; }
        .share-btn.copy { background: #f0f0f0; color: #555; }

        @media (max-width: 767px) {
            .policy-content-card { padding: 20px 16px; }
            .policy-content-card h1.policy-title { font-size: 1.35rem; }
            .policy-body { font-size: 14px; }
        }
    </style>
</head>
<body>

<%-- Header + Navbar --%>
<%@ include file="/WEB-INF/jspf/site_header.jspf" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="activePolicies" value="${applicationScope.APP_MENU_POLICIES}" />

<%-- Hero breadcrumb banner --%>
<div class="policy-hero">
    <div class="container">
        <h1>${not empty policy.title ? policy.title : 'Chính sách'}</h1>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${ctx}/home"><i class="bi bi-house me-1"></i>Trang chủ</a></li>
                <li class="breadcrumb-item active">${not empty policy.title ? policy.title : 'Chính sách'}</li>
            </ol>
        </nav>
    </div>
</div>

<div class="policy-page-wrap">
    <div class="container">
        <div class="row g-4">

            <%-- ===== SIDEBAR ===== --%>
            <div class="col-lg-3 col-md-4">
                <div class="policy-sidebar">
                    <%-- Nav danh sách chính sách --%>
                    <div class="policy-nav-card">
                        <div class="nav-header">
                            <i class="bi bi-list-ul"></i> Chính sách & Hỗ trợ
                        </div>
                        <c:choose>
                            <c:when test="${not empty activePolicies}">
                                <ul class="policy-nav-list">
                                    <c:forEach var="p" items="${activePolicies}">
                                        <li>
                                            <a href="${ctx}/policy?slug=${p.slug}"
                                               class="${policy != null && policy.slug == p.slug ? 'active' : ''}">
                                                <c:choose>
                                                    <c:when test="${p.policyType == 'SHIPPING'}"><i class="bi bi-truck"></i></c:when>
                                                    <c:when test="${p.policyType == 'RETURN'}"><i class="bi bi-arrow-return-left"></i></c:when>
                                                    <c:when test="${p.policyType == 'PAYMENT'}"><i class="bi bi-credit-card"></i></c:when>
                                                    <c:when test="${p.policyType == 'PRIVACY'}"><i class="bi bi-shield-lock"></i></c:when>
                                                    <c:when test="${p.policyType == 'TERMS'}"><i class="bi bi-file-text"></i></c:when>
                                                    <c:when test="${p.policyType == 'SUPPORT'}"><i class="bi bi-headset"></i></c:when>
                                                    <c:when test="${p.policyType == 'ORDER_GUIDE'}"><i class="bi bi-bag-check"></i></c:when>
                                                    <c:otherwise><i class="bi bi-chevron-right"></i></c:otherwise>
                                                </c:choose>
                                                ${p.title}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <ul class="policy-nav-list">
                                    <li><a href="${ctx}/policy?slug=chinh-sach-van-chuyen"><i class="bi bi-truck"></i>Chính sách vận chuyển</a></li>
                                    <li><a href="${ctx}/policy?slug=chinh-sach-doi-tra"><i class="bi bi-arrow-return-left"></i>Chính sách đổi trả</a></li>
                                    <li><a href="${ctx}/policy?slug=chinh-sach-thanh-toan"><i class="bi bi-credit-card"></i>Chính sách thanh toán</a></li>
                                    <li><a href="${ctx}/policy?slug=chinh-sach-bao-mat"><i class="bi bi-shield-lock"></i>Bảo mật thông tin</a></li>
                                    <li><a href="${ctx}/policy?slug=huong-dan-dat-hang"><i class="bi bi-bag-check"></i>Hướng dẫn đặt hàng</a></li>
                                </ul>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%-- Contact quick info --%>
                    <div class="policy-contact-card">
                        <h6><i class="bi bi-headset me-2"></i>Cần hỗ trợ?</h6>
                        <div class="contact-item">
                            <i class="bi bi-telephone-fill"></i>
                            <span>Hotline: <strong>0984 843 218</strong></span>
                        </div>
                        <div class="contact-item">
                            <i class="bi bi-envelope-fill"></i>
                            <span>cskh@japansport.vn</span>
                        </div>
                        <div class="contact-item">
                            <i class="bi bi-clock-fill"></i>
                            <span>8:00 - 22:00 hằng ngày</span>
                        </div>
                        <div class="contact-item">
                            <i class="bi bi-chat-dots-fill"></i>
                            <span>Chat trực tuyến trên website</span>
                        </div>
                    </div>
                </div>
            </div>

            <%-- ===== MAIN CONTENT ===== --%>
            <div class="col-lg-9 col-md-8">
                <div class="policy-content-card">
                    <c:choose>
                        <c:when test="${not empty policy}">
                            <%-- Type badge --%>
                            <div>
                                <span class="policy-type-badge">
                                    <c:choose>
                                        <c:when test="${policy.policyType == 'SHIPPING'}"><i class="bi bi-truck"></i> Vận chuyển</c:when>
                                        <c:when test="${policy.policyType == 'RETURN'}"><i class="bi bi-arrow-return-left"></i> Đổi trả</c:when>
                                        <c:when test="${policy.policyType == 'PAYMENT'}"><i class="bi bi-credit-card"></i> Thanh toán</c:when>
                                        <c:when test="${policy.policyType == 'PRIVACY'}"><i class="bi bi-shield-lock"></i> Bảo mật</c:when>
                                        <c:when test="${policy.policyType == 'TERMS'}"><i class="bi bi-file-text"></i> Điều khoản</c:when>
                                        <c:when test="${policy.policyType == 'SUPPORT'}"><i class="bi bi-headset"></i> Hỗ trợ KH</c:when>
                                        <c:when test="${policy.policyType == 'ORDER_GUIDE'}"><i class="bi bi-bag-check"></i> Đặt hàng</c:when>
                                        <c:otherwise><i class="bi bi-shield-check"></i> Chính sách</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <%-- Title --%>
                            <h1 class="policy-title">${policy.title}</h1>

                            <%-- Meta --%>
                            <div class="policy-meta">
                                <span><i class="bi bi-building"></i> Japan Sport</span>
                                <span><i class="bi bi-calendar3"></i>
                                    Cập nhật: <fmt:formatDate value="${not empty policy.updatedAt ? policy.updatedAt : policy.createdAt}" pattern="dd/MM/yyyy" />
                                </span>
                                <span><i class="bi bi-eye"></i> Chính sách chính thức</span>
                            </div>

                            <%-- Content --%>
                            <div class="policy-body">
                                <c:out value="${policy.content}" escapeXml="false" />
                            </div>

                            <%-- Share --%>
                            <div class="policy-share">
                                <span>Chia sẻ:</span>
                                <a href="https://www.facebook.com/sharer/sharer.php?u=${pageContext.request.requestURL}" target="_blank" class="share-btn fb">
                                    <i class="bi bi-facebook"></i> Facebook
                                </a>
                                <button class="share-btn copy" onclick="navigator.clipboard.writeText(window.location.href).then(function(){alert('Đã sao chép link!')})">
                                    <i class="bi bi-link-45deg"></i> Sao chép link
                                </button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="policy-empty">
                                <i class="bi bi-file-earmark-x"></i>
                                <h4 class="fw-bold text-muted">Không tìm thấy trang chính sách</h4>
                                <p class="text-muted">Trang bạn tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                                <a href="${ctx}/home" class="btn btn-danger mt-2">
                                    <i class="bi bi-house me-1"></i> Về trang chủ
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
</div>

<%-- Footer --%>
<%@ include file="/WEB-INF/jspf/site_footer.jspf" %>

<button class="btn btn-danger position-fixed bottom-0 end-0 m-4 rounded-circle"
        style="width:50px;height:50px;z-index:1000;"
        onclick="window.scrollTo({top:0,behavior:'smooth'})" title="Lên đầu trang" aria-label="Lên đầu trang">
    <i class="bi bi-arrow-up"></i>
</button>

<script>
    /* Tooltips */
    document.addEventListener('DOMContentLoaded', function () {
        if (typeof bootstrap !== 'undefined') {
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(el => new bootstrap.Tooltip(el));
        }
    });

    /* Search focus effect */
    document.addEventListener('DOMContentLoaded', function () {
        const searchInput = document.querySelector('.search-input');
        if (searchInput) {
            searchInput.addEventListener('focus', function () {
                this.parentElement.style.transform = 'scale(1.02)';
                this.parentElement.style.transition = 'transform 0.2s ease';
            });
            searchInput.addEventListener('blur', function () {
                this.parentElement.style.transform = 'scale(1)';
            });
        }
    });
</script>
</body>
</html>
