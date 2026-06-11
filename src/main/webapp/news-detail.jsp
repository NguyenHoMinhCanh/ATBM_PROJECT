<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${news.title}</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/assets/css/style.css">
    <style>
        /*CẢI THIỆN ĐỘ ĐỌC (TYPOGRAPHY)*/
        .article-content {
            line-height: 1.85;
            font-size: 1.1rem;
            color: #333;
            margin-top: 20px;
        }

        .article-content img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin: 16px 0;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .main-thumb {
            width: 100%;
            max-height: 450px;
            object-fit: cover;
            border-radius: 12px;
            margin: 16px 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .article-meta { color: #6c757d; font-size: 0.9rem; margin-top: 10px; padding-bottom: 15px; border-bottom: 1px solid #eee; }

        /* ================= SIDEBAR TIN TỨC MỚI ================= */
        .sidebar-wrap { position: sticky; top: 24px; }
        .sidebar-card { background: #fff; border: 1px solid #eee; border-radius: 12px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }

        .recent-news-item { display: flex; gap: 12px; margin-bottom: 16px; padding-bottom: 16px; border-bottom: 1px dashed #eee; align-items: flex-start; }
        .recent-news-item:last-child { margin-bottom: 0; padding-bottom: 0; border-bottom: none; }

        .recent-thumb { width: 85px; height: 85px; object-fit: cover; border-radius: 8px; flex-shrink: 0; }
        .recent-title { font-size: 0.95rem; font-weight: 600; line-height: 1.4; margin: 0 0 6px 0; }
        .recent-title a { color: #222; text-decoration: none; transition: color 0.2s; }
        .recent-title a:hover { color: #dc3545; }
        .recent-date { font-size: 0.75rem; color: #888; }

        /* Breadcrumb tùy chỉnh */
        .breadcrumb-item a { color: #6c757d; text-decoration: none; transition: color 0.2s; }
        .breadcrumb-item a:hover { color: #dc3545; }

        .btn-back-news { transition: all 0.3s ease; }
        .btn-back-news:hover { transform: translateY(-3px); box-shadow: 0 4px 10px rgba(220, 53, 69, 0.2); }

        .hover-danger:hover { color: #dc3545 !important; transition: color 0.2s; }
        .focus-ring-danger:focus { border-color: #dc3545; box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25); }
        .comment-avatar { width: 45px; height: 45px; object-fit: cover; border-radius: 50%; }
        .comment-box { background-color: #f8f9fa; border: 1px solid #eaeaea; transition: all 0.3s ease; }
        .comment-box:hover { background-color: #fff; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<div class="topbar section hidden-xs hidden-sm">
    <a class="section block a-center" href="#">
        <img src="${ctx}/assets/images/banner.webp" alt="Siêu bão khuyến mãi cuối năm" style="width:100%;height:auto;display:flex;">
    </a>
</div>

<%@ include file="/WEB-INF/jspf/site_header.jspf" %>

<div class="container my-4">
    <div class="row g-5">
        <div class="col-lg-8">

            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb small bg-light px-3 py-2 rounded-3">
                    <li class="breadcrumb-item"><a href="${ctx}/home"><i class="bi bi-house-door me-1"></i>Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${ctx}/news">Tin tức</a></li>
                    <li class="breadcrumb-item active text-truncate" aria-current="page" style="max-width: 250px;" title="${news.title}">${news.title}</li>
                </ol>
            </nav>

            <h1 class="fw-bold mb-3" style="font-size: 2rem; line-height: 1.3;">${news.title}</h1>

            <div class="article-meta d-flex align-items-center flex-wrap gap-3">
                <c:if test="${not empty news.author}">
                    <span><i class="bi bi-person-circle me-1"></i> Đăng bởi: <strong class="text-dark">${news.author}</strong></span>
                </c:if>
                <span><i class="bi bi-clock me-1"></i> ${news.createdAt}</span>
                <span><i class="bi bi-eye me-1"></i> ${news.viewCount} lượt xem</span>
            </div>

            <c:if test="${not empty news.thumbnailUrl}">
                <img class="main-thumb" src="${news.thumbnailUrl}" alt="${news.title}">
            </c:if>

            <c:if test="${not empty news.summary}">
                <div class="alert alert-secondary border-0 border-start border-4 border-danger rounded-0 mt-3 p-3">
                    <b style="font-size: 1.05rem; line-height: 1.6;">${news.summary}</b>
                </div>
            </c:if>

            <div class="article-content">
                <c:out value="${news.content}" escapeXml="false"/>
            </div>

            <div class="text-center mt-5 mb-2 border-top pt-5">
                <h6 class="text-muted mb-3">Bạn đã đọc xong bài viết!</h6>
                <a href="${ctx}/news" class="btn btn-outline-danger rounded-pill px-5 py-2 fw-bold btn-back-news">
                    <i class="bi bi-arrow-left-circle me-2"></i> Quay về danh sách tin tức
                </a>
            </div>

            <div class="comment-section mt-5 mb-4">
                <h4 class="fw-bold mb-4"><i class="bi bi-chat-dots me-2 text-danger"></i>Bình luận (${comments.size()})</h4>

                <!-- Form nhập bình luận -->
                <div class="d-flex gap-3 mb-5">
                    <div class="bg-secondary text-white rounded-circle d-flex justify-content-center align-items-center flex-shrink-0" style="width: 45px; height: 45px; font-weight: bold;">
                        U
                    </div>
                    <div class="flex-grow-1">
                        <form action="${ctx}/post-comment" method="POST">
                            <!-- Dữ liệu ngầm gửi kèm -->
                            <input type="hidden" name="newsId" value="${news.id}">
                            <input type="hidden" name="slug" value="${news.slug}">

                            <input type="text" name="userName" class="form-control mb-2 rounded-3 shadow-none focus-ring focus-ring-danger" placeholder="Tên của bạn (Tùy chọn)..." maxlength="50">
                            <textarea name="content" class="form-control mb-2 rounded-3 shadow-none focus-ring focus-ring-danger" rows="3" placeholder="Chia sẻ suy nghĩ của bạn về bài viết này..." required></textarea>
                            <div class="text-end">
                                <button type="submit" class="btn btn-danger rounded-pill px-4 fw-bold">Gửi bình luận</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Danh sách bình luận -->
                <div class="comment-list">
                    <c:forEach var="cmt" items="${comments}">
                        <div class="d-flex gap-3 mb-4">
                            <!-- Tạo avatar tự động từ tên -->
                            <img src="https://ui-avatars.com/api/?name=${cmt.userName}&background=random" alt="Avatar" class="comment-avatar">
                            <div class="comment-box p-3 rounded-4 flex-grow-1">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <h6 class="mb-0 fw-bold">${cmt.userName}</h6>
                                    <small class="text-muted">${cmt.createdAt}</small>
                                </div>
                                <p class="mb-2 text-dark">${cmt.content}</p>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty comments}">
                        <div class="text-center text-muted p-4 bg-light rounded-3">Chưa có bình luận nào. Hãy là người đầu tiên nhận xét!</div>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="sidebar-wrap">
                <div class="sidebar-card">
                    <h5 class="fw-bold border-bottom pb-3 mb-4"><i class="bi bi-newspaper me-2 text-danger"></i>Tin tức mới cập nhật</h5>

                    <c:forEach var="rn" items="${recentNews}">
                        <div class="recent-news-item">
                            <a href="${ctx}/news-detail?slug=${rn.slug}">
                                <img src="${rn.thumbnailUrl}" alt="${rn.title}" class="recent-thumb">
                            </a>
                            <div>
                                <h6 class="recent-title">
                                    <a href="${ctx}/news-detail?slug=${rn.slug}">${rn.title}</a>
                                </h6>
                                <div class="recent-date"><i class="bi bi-clock me-1"></i>${rn.createdAt}</div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty recentNews}">
                        <p class="text-muted small text-center mb-0">Đang cập nhật thêm tin tức mới...</p>
                    </c:if>
                </div>

                <div class="mt-4 rounded-3 overflow-hidden shadow-sm">
                    <img src="${ctx}/assets/images/banner.webp" class="img-fluid" alt="Khuyến mãi">
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/site_footer.jspf" %>

<button class="btn btn-danger position-fixed bottom-0 end-0 m-4 rounded-circle"
        style="width:50px;height:50px;z-index:1000;"
        onclick="window.scrollTo({top:0,behavior:'smooth'})"
        title="Lên đầu trang" aria-label="Lên đầu trang">
    <i class="bi bi-arrow-up"></i>
</button>

</body>
</html>