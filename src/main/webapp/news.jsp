<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Tin tức</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${ctx}/assets/css/style.css">
    <style>
        .news-container { max-width: 1100px; margin: 24px auto; padding: 0 12px; }
        .news-grid { display: grid; grid-template-columns: 1fr 320px; gap: 24px; }

        /*CẢI THIỆN THẺ TIN TỨC*/
        .news-card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        /* Hiệu ứng nổi lên và đổ bóng khi di chuột vào thẻ */
        .news-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.08);
            border-color: #ff9800;
        }

        /* Khung bọc ảnh đại diện để đồng nhất kích thước */
        .thumb-wrapper {
            width: 100%;
            height: 200px;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 14px;
        }

        /* Ảnh đại diện */
        .thumb {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        /* Hiệu ứng phóng to ảnh khi hover vào toàn bộ thẻ news-card */
        .news-card:hover .thumb {
            transform: scale(1.08);
        }

        .news-card h3 { margin: 0 0 8px 0; font-size: 1.25rem; font-weight: bold; line-height: 1.4; }
        .news-card p { margin: 0; color: #555; line-height: 1.6; }
        .side-box { background: #fff; border: 1px solid #eee; border-radius: 12px; padding: 20px; position: sticky; top: 20px;}
        .cat-link { display:block; padding:8px 0; color:#333; text-decoration:none; border-bottom: 1px dashed #eee; transition: color 0.2s;}
        .cat-link:last-child { border-bottom: none; }
        .cat-link:hover { color: #dc3545; padding-left: 5px; } /* Hiệu ứng lùi nhẹ chữ danh mục */
        .meta { font-size: 13px; color:#888; margin-top:10px; display: flex; align-items: center; gap: 12px;}
    </style>
</head>
<body>


<div class="topbar section hidden-xs hidden-sm">
    <a class="section block a-center" href="#">
        <img src="${ctx}/assets/images/banner.webp" alt="Siêu bão khuyến mãi cuối năm"
             style="width:100%;height:auto;display:flex;">
    </a>
</div>

<%@ include file="/WEB-INF/jspf/site_header.jspf" %>

<div class="news-container">
    <h2 class="fw-bold mb-4 border-bottom pb-2">Tin tức mới nhất</h2>

    <div class="news-grid">
        <div>
            <form method="get" action="${ctx}/news" class="d-flex gap-2 mb-4">
                <input type="hidden" name="categoryId" value="${categoryId}">
                <div class="input-group">
                    <span class="input-group-text bg-white text-muted border-end-0"><i class="bi bi-search"></i></span>
                    <input name="q" class="form-control border-start-0 ps-0 shadow-none" value="${q}" placeholder="Tìm kiếm bài viết...">
                </div>
                <button class="btn btn-danger px-4 rounded-3">Tìm</button>
            </form>

            <c:forEach var="n" items="${newsList}">
                <div class="news-card">
                    <c:if test="${not empty n.thumbnailUrl}">
                        <div class="thumb-wrapper">
                            <img class="thumb" src="${n.thumbnailUrl}" alt="${n.title}">
                        </div>
                    </c:if>

                    <h3>
                        <a href="${ctx}/news-detail?slug=${n.slug}" style="text-decoration:none; color:#111;">
                                ${n.title}
                        </a>
                    </h3>

                    <c:if test="${not empty n.summary}">
                        <p>${n.summary}</p>
                    </c:if>

                    <div class="meta">
                        <span><i class="bi bi-eye me-1"></i>${n.viewCount} lượt xem</span>
                        <span><i class="bi bi-clock me-1"></i>${n.createdAt}</span>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty newsList}">
                <div class="alert alert-light border text-center py-5 rounded-3">
                    <i class="bi bi-journal-x fs-1 text-muted mb-3 d-block"></i>
                    <h6 class="text-muted">Chưa có bài viết nào phù hợp.</h6>
                </div>
            </c:if>

            <div class="d-flex justify-content-center mt-4">
                <ul class="pagination">
                    <c:if test="${page > 1}">
                        <li class="page-item">
                            <a class="page-link text-dark" href="${ctx}/news?page=${page-1}&categoryId=${categoryId}&q=${q}">← Trang trước</a>
                        </li>
                    </c:if>
                    <c:if test="${not empty newsList}">
                        <li class="page-item">
                            <a class="page-link text-danger fw-bold" href="${ctx}/news?page=${page+1}&categoryId=${categoryId}&q=${q}">Trang sau →</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>

        <div>
            <div class="side-box shadow-sm">
                <h5 class="fw-bold mb-3"><i class="bi bi-list-ul me-2 text-danger"></i>Danh mục</h5>
                <a class="cat-link" href="${ctx}/news">
                    <i class="bi bi-chevron-right me-1 small"></i> Tất cả
                </a>
                <c:forEach var="c" items="${categories}">
                    <a class="cat-link" href="${ctx}/news?categoryId=${c.id}">
                        <i class="bi bi-chevron-right me-1 small"></i> ${c.name}
                    </a>
                </c:forEach>

                <c:if test="${empty categories}">
                    <div style="color:#777; font-size: 0.9rem;">Chưa có danh mục tin tức.</div>
                </c:if>
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