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

        /*SIDEBAR TÙY CHỈNH (ARCHIVE & TAGS)*/
        .tag-badge {
            font-size: 0.85rem;
            font-weight: 500;
            color: #555;
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            transition: all 0.2s ease;
        }
        .tag-badge:hover {
            background-color: #dc3545;
            color: #fff;
            border-color: #dc3545;
            transform: translateY(-2px);
        }
        .archive-link {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            color: #444;
            text-decoration: none;
            border-bottom: 1px dashed #eee;
            transition: color 0.2s;
        }
        .archive-link:last-child { border-bottom: none; }
        .archive-link:hover { color: #dc3545; }
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
                <c:if test="${not empty categoryId}">
                    <input type="hidden" name="categoryId" value="${categoryId}">
                </c:if>
                <div class="input-group">
                    <span class="input-group-text bg-white text-muted border-end-0"><i class="bi bi-search"></i></span>
                    <input name="q" class="form-control border-start-0 ps-0 shadow-none" value="${q}" placeholder="Nhập từ khóa tìm kiếm...">
                </div>
                <button class="btn btn-danger px-4 rounded-3">Tìm</button>
            </form>

            <c:if test="${not empty q or not empty tag or (not empty month and not empty year)}">
                <div class="alert alert-info py-2 px-3 d-flex justify-content-between align-items-center rounded-3 mb-4">
                    <span>
                        <i class="bi bi-funnel me-2"></i>Kết quả cho:
                        <c:if test="${not empty q}">từ khóa <strong>"${q}"</strong></c:if>
                        <c:if test="${not empty tag}">thẻ <strong>#${tag}</strong></c:if>
                        <c:if test="${not empty month and not empty year}">tháng <strong>${month}/${year}</strong></c:if>
                    </span>
                    <a href="${ctx}/news${not empty categoryId ? '?categoryId='.concat(categoryId) : ''}" class="text-muted" title="Xóa bộ lọc"><i class="bi bi-x-circle-fill"></i></a>
                </div>
            </c:if>

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
                <div class="alert alert-light border text-center py-5 rounded-3 mb-4 shadow-sm">
                    <i class="bi bi-search text-muted mb-3 d-block" style="font-size: 3rem;"></i>
                    <h5 class="fw-bold text-dark mb-2">Không tìm thấy kết quả</h5>
                    <p class="text-muted mb-4">
                        Rất tiếc, chúng tôi không tìm thấy bài viết nào <c:if test="${not empty q}">chứa từ khóa "<strong>${q}</strong>"</c:if>. Vui lòng thử lại với từ khóa khác!
                    </p>
                    <a href="${ctx}/news" class="btn btn-outline-danger rounded-pill px-4">
                        <i class="bi bi-arrow-clockwise me-1"></i> Tải lại danh sách
                    </a>
                </div>
            </c:if>

            <div class="d-flex justify-content-center mt-4">
                <ul class="pagination">
                    <c:if test="${page > 1}">
                        <li class="page-item">
                            <a class="page-link text-dark" href="${ctx}/news?page=${page-1}&categoryId=${categoryId}&q=${q}&tag=${tag}&month=${month}&year=${year}">← Trang trước</a>
                        </li>
                    </c:if>
                    <c:if test="${not empty newsList}">
                        <li class="page-item">
                            <a class="page-link text-danger fw-bold" href="${ctx}/news?page=${page+1}&categoryId=${categoryId}&q=${q}&tag=${tag}&month=${month}&year=${year}">Trang sau →</a>
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

            <div class="side-box shadow-sm mt-4">
                <h5 class="fw-bold mb-3"><i class="bi bi-calendar3 me-2 text-danger"></i>Lưu trữ</h5>
                <a class="archive-link" href="${ctx}/news?month=06&year=2026">
                    <span><i class="bi bi-chevron-right me-1 small"></i> Tháng 6 / 2026</span>
                </a>
                <a class="archive-link" href="${ctx}/news?month=05&year=2026">
                    <span><i class="bi bi-chevron-right me-1 small"></i> Tháng 5 / 2026</span>
                </a>
                <a class="archive-link" href="${ctx}/news?month=04&year=2026">
                    <span><i class="bi bi-chevron-right me-1 small"></i> Tháng 4 / 2026</span>
                </a>
            </div>

            <div class="side-box shadow-sm mt-4">
                <h5 class="fw-bold mb-3"><i class="bi bi-tags me-2 text-danger"></i>Tags nổi bật</h5>
                <div class="d-flex flex-wrap gap-2">
                    <a href="${ctx}/news?tag=the-thao" class="badge tag-badge text-decoration-none py-2 px-3"># Thể thao</a>
                    <a href="${ctx}/news?tag=khuyen-mai" class="badge tag-badge text-decoration-none py-2 px-3"># Khuyến mãi</a>
                    <a href="${ctx}/news?tag=giay-chay-bo" class="badge tag-badge text-decoration-none py-2 px-3"># Giày chạy bộ</a>
                    <a href="${ctx}/news?tag=kien-thuc" class="badge tag-badge text-decoration-none py-2 px-3"># Kiến thức</a>
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