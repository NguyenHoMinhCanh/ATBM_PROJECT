<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.japansport.model.Product" %>
<%@ page import="com.japansport.model.Category" %>
<%@ page import="com.japansport.model.Brand" %>
<%@ page import="com.japansport.model.Banner" %>
<%
    List<Product> list = (List<Product>) request.getAttribute("listProduct");
    if (list == null) {
        response.sendRedirect(request.getContextPath() + "/list-product");
        return;
    }
    String ctx = request.getContextPath();
    List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
    String selectedCategoryId = (String) request.getAttribute("selectedCategoryId");
    String selectedSort = (String) request.getAttribute("selectedSort");

    List<Brand> brandList = (List<Brand>) request.getAttribute("brandList");

    String[] selectedBrandIdsArr = (String[]) request.getAttribute("selectedBrandIds");
    Set<String> selectedBrandIdSet = new HashSet<>();
    if (selectedBrandIdsArr != null) {
        selectedBrandIdSet.addAll(Arrays.asList(selectedBrandIdsArr));
    }

    // Phân trang
    Integer currentPageObj = (Integer) request.getAttribute("currentPage");
    Integer totalPagesObj = (Integer) request.getAttribute("totalPages");
    Integer totalProductsObj = (Integer) request.getAttribute("totalProducts");

    int currentPage = (currentPageObj != null) ? currentPageObj : 1;
    int totalPages = (totalPagesObj != null) ? totalPagesObj : 0;
    int totalProducts = (totalProductsObj != null) ? totalProductsObj : list.size();

    Banner shopTopBanner = (Banner) request.getAttribute("shopTopBanner");

    // Từ khoá search
    String keywordAttr = (String) request.getAttribute("keyword");

    // Các khoảng giá đang được chọn (từ controller gửi xuống)
    String[] selectedPricesArr = (String[]) request.getAttribute("selectedPrices");
    Set<String> selectedPriceSet = new HashSet<>();
    if (selectedPricesArr != null) {
        selectedPriceSet.addAll(Arrays.asList(selectedPricesArr));
    }
    String pageTitle = (String) request.getAttribute("pageTitle");
    if (pageTitle == null || pageTitle.trim().isEmpty()) pageTitle = "Tất cả sản phẩm";

    String breadcrumbCurrent = (String) request.getAttribute("breadcrumbCurrent");
    if (breadcrumbCurrent == null || breadcrumbCurrent.trim().isEmpty()) breadcrumbCurrent = pageTitle;

    String selectedGender = (String) request.getAttribute("selectedGender");
    Boolean showGenderFilterObj = (Boolean) request.getAttribute("showGenderFilter");
    boolean showGenderFilter = (showGenderFilterObj != null && showGenderFilterObj);

    String saleParam = request.getParameter("sale");

    @SuppressWarnings("unchecked")
    Map<Integer, double[]> ratingMap = (Map<Integer, double[]>) request.getAttribute("ratingMap");
%>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Japan Sport - <%= pageTitle %></title>

    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css"
          rel="stylesheet"/>
    <!-- App CSS -->
    <link href="assets/css/style.css" rel="stylesheet"/>
</head>
<body>

<!-- ===== Banner (động từ DB: position = SHOP_TOP) ===== -->
<% if (shopTopBanner != null && shopTopBanner.getActive() == 1) { %>
<div class="container my-4">
    <a href="<%= (shopTopBanner.getLink() == null || shopTopBanner.getLink().trim().isEmpty()) ? "#" : shopTopBanner.getLink() %>">
        <%
            String img = shopTopBanner.getImage_url();
            String imgSrc = "";
            if (img != null) {
                img = img.trim();
                if (img.startsWith("http://") || img.startsWith("https://")) imgSrc = img;
                else if (img.startsWith("/")) imgSrc = ctx + img;
                else imgSrc = ctx + "/" + img;
            }
        %>
        <img src="<%= imgSrc %>" alt="<%= (shopTopBanner.getTitle() == null ? "banner" : shopTopBanner.getTitle()) %>"
             style="width: 100%; max-height: 320px; object-fit: cover; border-radius: 16px;">
    </a>
</div>
<% } %>

<!-- ===== Header + Navbar ===== -->
<%@ include file="/WEB-INF/jspf/site_header.jspf" %>

<!-- ===== Breadcrumb + Title ===== -->
<div class="bg-light py-3 border-bottom">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0 justify-content-center">
                <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                <li class="breadcrumb-item active text-danger" aria-current="page"><%= breadcrumbCurrent %></li>
            </ol>
        </nav>
    </div>
</div>

<div class="container my-4">
    <h2 class="text-center text-danger fw-bold mb-4"><%= pageTitle %></h2>

    <div class="row">
        <!-- ===== Sidebar ===== -->
        <aside class="col-lg-3 mb-4">
            <div class="widget-box mb-4">
                <div class="widget-title">DANH MỤC SẢN PHẨM</div>
                <ul class="category-list list-unstyled mb-0">

                    <!-- Tất cả -->
                    <li>
                        <a href="<%= ctx %>/list-product"
                           class="<% if (selectedCategoryId == null) { %>fw-bold text-danger<% } %>">
                            Tất cả sản phẩm
                        </a>
                        <i class="bi bi-chevron-right"></i>
                    </li>

                    <%
                        if (categoryList != null) {
                            for (Category c : categoryList) {
                                boolean active = (selectedCategoryId != null) &&
                                        selectedCategoryId.equals(String.valueOf(c.getId()));
                    %>
                    <li>
                        <a href="<%= ctx %>/list-product?categoryId=<%= c.getId() %>"
                           class="<% if (active) { %>fw-bold text-danger<% } %>">
                            <%= c.getName() %>
                        </a>
                        <i class="bi bi-chevron-right"></i>
                    </li>
                    <% }
                    }
                    %>
                </ul>
            </div>

            <!-- FORM LỌC (THƯƠNG HIỆU + MỨC GIÁ + GIỚI TÍNH) -->
            <form id="filterForm" method="get" action="<%= ctx %>/list-product">

                <!-- Giữ lại category, sort, keyword -->
                <% if (selectedCategoryId != null && !selectedCategoryId.isEmpty()) { %>
                <input type="hidden" name="categoryId" value="<%= selectedCategoryId %>">
                <% } %>
                <% if (selectedSort != null && !selectedSort.isEmpty()) { %>
                <input type="hidden" name="sort" value="<%= selectedSort %>">
                <% } %>
                <% if (keywordAttr != null && !keywordAttr.isEmpty()) { %>
                <input type="hidden" name="keyword" value="<%= keywordAttr %>">
                <% } %>

                <%-- GIỚI TÍNH --%>
                <% if (showGenderFilter) { %>
                <div class="widget-box mb-4">
                    <div class="widget-title">GIỚI TÍNH</div>
                    <label class="form-check">
                        <input class="form-check-input filter-auto" type="radio" name="gender" value=""
                            <%= (selectedGender == null) ? "checked" : "" %>>
                        <span class="form-check-label">Tất cả</span>
                    </label>
                    <label class="form-check">
                        <input class="form-check-input filter-auto" type="radio" name="gender" value="men"
                            <%= "men".equalsIgnoreCase(selectedGender) ? "checked" : "" %>>
                        <span class="form-check-label">Giày nam</span>
                    </label>
                    <label class="form-check">
                        <input class="form-check-input filter-auto" type="radio" name="gender" value="women"
                            <%= "women".equalsIgnoreCase(selectedGender) ? "checked" : "" %>>
                        <span class="form-check-label">Giày nữ</span>
                    </label>
                    <label class="form-check">
                        <input class="form-check-input filter-auto" type="radio" name="gender" value="unisex"
                            <%= "unisex".equalsIgnoreCase(selectedGender) ? "checked" : "" %>>
                        <span class="form-check-label">Unisex</span>
                    </label>
                </div>
                <% } else { %>
                <% if (selectedGender != null && !selectedGender.isEmpty()) { %>
                <input type="hidden" name="gender" value="<%= selectedGender %>">
                <% } %>
                <% } %>

                <!-- THƯƠNG HIỆU -->
                <div class="widget-box mb-4">
                    <div class="widget-title">THƯƠNG HIỆU</div>
                    <div class="px-3 pt-2 pb-1">
                        <input type="text" class="form-control form-control-sm" id="brandSearchInput"
                               placeholder="Tìm thương hiệu..." autocomplete="off">
                    </div>
                    <div class="brand-list" id="brandListWrap">
                        <% if (brandList != null) { for (Brand b : brandList) { %>
                        <label class="form-check brand-check-item" data-brand-name="<%= b.getName().toLowerCase() %>">
                            <input class="form-check-input filter-auto"
                                   type="checkbox" name="brandId" value="<%= b.getId() %>"
                                   <%= selectedBrandIdSet.contains(String.valueOf(b.getId())) ? "checked" : "" %>>
                            <span class="form-check-label"><%= b.getName() %></span>
                        </label>
                        <% } } else { %>
                        <p class="text-muted mb-0">Chưa có thương hiệu nào.</p>
                        <% } %>
                    </div>
                </div>

                <!-- MỨC GIÁ -->
                <div class="widget-box mb-4">
                    <div class="widget-title">MỨC GIÁ</div>
                    <div class="brand-list">
                        <label class="form-check"><input class="form-check-input filter-auto" type="checkbox" name="price" value="0-500" <%= selectedPriceSet.contains("0-500") ? "checked" : "" %>><span class="form-check-label">Dưới 500.000đ</span></label>
                        <label class="form-check"><input class="form-check-input filter-auto" type="checkbox" name="price" value="500-1000" <%= selectedPriceSet.contains("500-1000") ? "checked" : "" %>><span class="form-check-label">500K - 1.000.000đ</span></label>
                        <label class="form-check"><input class="form-check-input filter-auto" type="checkbox" name="price" value="1000-1500" <%= selectedPriceSet.contains("1000-1500") ? "checked" : "" %>><span class="form-check-label">1 - 1.5 triệu</span></label>
                        <label class="form-check"><input class="form-check-input filter-auto" type="checkbox" name="price" value="1500-2000" <%= selectedPriceSet.contains("1500-2000") ? "checked" : "" %>><span class="form-check-label">1.5 - 2 triệu</span></label>
                        <label class="form-check"><input class="form-check-input filter-auto" type="checkbox" name="price" value="2000-2500" <%= selectedPriceSet.contains("2000-2500") ? "checked" : "" %>><span class="form-check-label">2 - 2.5 triệu</span></label>
                        <label class="form-check"><input class="form-check-input filter-auto" type="checkbox" name="price" value="2500-3000" <%= selectedPriceSet.contains("2500-3000") ? "checked" : "" %>><span class="form-check-label">2.5 - 3 triệu</span></label>
                        <label class="form-check"><input class="form-check-input filter-auto" type="checkbox" name="price" value="3000+" <%= selectedPriceSet.contains("3000+") ? "checked" : "" %>><span class="form-check-label">Trên 3 triệu</span></label>
                    </div>
                    <!-- Khoảng giá tuỳ chỉnh -->
                    <div class="px-3 pb-3 pt-1">
                        <div class="text-muted" style="font-size:.8rem;margin-bottom:6px;">Hoặc nhập khoảng giá:</div>
                        <div class="d-flex align-items-center gap-2">
                            <input type="number" class="form-control form-control-sm" id="priceFrom"
                                   placeholder="Từ" min="0" style="width:45%;">
                            <span class="text-muted">–</span>
                            <input type="number" class="form-control form-control-sm" id="priceTo"
                                   placeholder="Đến" min="0" style="width:45%;">
                        </div>
                        <button type="button" class="btn btn-outline-danger btn-sm w-100 mt-2" id="btnApplyCustomPrice">
                            Áp dụng
                        </button>
                    </div>
                </div>

                <!-- Nút xoá bộ lọc (chỉ hiện khi đang có filter) -->
                <%
                    boolean hasActiveFilter = !selectedBrandIdSet.isEmpty() || !selectedPriceSet.isEmpty()
                            || (selectedGender != null && !selectedGender.isEmpty());
                %>
                <% if (hasActiveFilter) { %>
                <a href="<%= ctx %>/list-product<%= (selectedCategoryId != null ? "?categoryId=" + selectedCategoryId : "") %>"
                   class="btn btn-outline-secondary w-100 mt-2">
                    <i class="bi bi-x-circle me-1"></i>Xoá bộ lọc
                </a>
                <% } %>
            </form>

        </aside>

        <!-- ===== Product list ===== -->
        <section class="col-lg-9">
            <!-- STT 34: Hiển thị số kết quả -->
            <%
                int fromItem = (totalProducts == 0) ? 0 : (currentPage - 1) * 16 + 1;
                int toItem   = Math.min(currentPage * 16, totalProducts);
            %>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h4 class="mb-0 d-inline"><%= pageTitle.toUpperCase() %></h4>
                    <span id="productCountInfo" class="text-muted ms-2" style="font-size:0.88rem;">
                    <% if (totalProducts > 0) { %>
                        &mdash; Đang hiển thị <%= fromItem %>–<%= toItem %> / <%= totalProducts %> sản phẩm
                    <% } else { %>
                        — Không tìm thấy sản phẩm nào
                    <% } %>
                    </span>
                </div>
                <form method="get" action="<%= ctx %>/list-product" class="d-flex align-items-center gap-2">
                    <%-- Giữ lại categoryId nếu đang lọc theo danh mục --%>
                    <% if (selectedCategoryId != null) { %>
                    <input type="hidden" name="categoryId" value="<%= selectedCategoryId %>">
                    <% } %>


                    <% if (keywordAttr != null && !keywordAttr.isEmpty()) { %>
                    <input type="hidden" name="keyword" value="<%= keywordAttr %>">
                    <% } %>

                    <% if (selectedGender != null && !selectedGender.isEmpty()) { %>
                    <input type="hidden" name="gender" value="<%= selectedGender %>">
                    <% } %>

                    <% if (saleParam != null && !saleParam.isEmpty()) { %>
                    <input type="hidden" name="sale" value="<%= saleParam %>">
                    <% } %>

                    <% if (selectedBrandIdsArr != null) {
                        for (String bid : selectedBrandIdsArr) { %>
                    <input type="hidden" name="brandId" value="<%= bid %>">
                    <%  }
                    } %>

                    <% if (selectedPricesArr != null) {
                        for (String pr : selectedPricesArr) { %>
                    <input type="hidden" name="price" value="<%= pr %>">
                    <%  }
                    } %>

                    <label for="sortSelect" class="me-1 fw-semibold" style="white-space: nowrap;">Sắp xếp:</label>
                    <select id="sortSelect" name="sort" class="form-select form-select-sm">
                        <option value=""
                                <% if (selectedSort == null || selectedSort.isEmpty()) { %>selected<% } %>>
                            Mặc định
                        </option>
                        <option value="newest"
                                <% if ("newest".equals(selectedSort)) { %>selected<% } %>>
                            Mới nhất
                        </option>
                        <option value="price_asc"
                                <% if ("price_asc".equals(selectedSort)) { %>selected<% } %>>
                            Giá tăng dần
                        </option>
                        <option value="price_desc"
                                <% if ("price_desc".equals(selectedSort)) { %>selected<% } %>>
                            Giá giảm dần
                        </option>
                    </select>
                </form>
            </div>

            <% if (keywordAttr != null && !keywordAttr.isEmpty()) { %>
            <p class="text-muted mb-3">
                Kết quả tìm kiếm cho:
                <strong><%= keywordAttr %>
                </strong>
            </p>
            <% } %>

                <%-- ==== BẮT ĐẦU GRID DANH SÁCH ==== --%>
                <div id="productGridWrap">
                <div class="row g-4">
                    <% if (list.isEmpty()) { %>
                    <div class="col-12">
                        <div class="alert alert-warning mb-0">Chưa có sản phẩm nào.</div>
                    </div>
                    <% } else { %>
                    <% for (Product p : list) {
                        // Tính % giảm giá
                        int discountPct = 0;
                        if (p.getOld_price() > 0 && p.getOld_price() > p.getPrice()) {
                            discountPct = (int) Math.round((1 - p.getPrice() / p.getOld_price()) * 100);
                        }
                        // Rating
                        double avgRating = 0;
                        int reviewCount = 0;
                        if (ratingMap != null) {
                            double[] rd = ratingMap.get(p.getId());
                            if (rd != null) {
                                avgRating = rd[0];
                                reviewCount = (int) rd[1];
                            }
                        }
                    %>
                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="product-card h-100 d-flex flex-column">

                            <%-- BADGE: nhãn promotion hoặc % giảm --%>
                            <% if (p.isSale()) { %>
                            <span class="ribbon"><%= p.getPromotionLabel() %></span>
                            <% } else if (discountPct > 0) { %>
                            <span class="ribbon">-<%= discountPct %>%</span>
                            <% } %>

                            <%-- ẢNH + OVERLAY HOVER --%>
                            <div class="card-img-wrap position-relative">
                                <a href="<%= ctx %>/product?id=<%= p.getId() %>">
                                    <img src="<%= p.getImage_url() %>" alt="<%= p.getName() %>" class="card-img-top" loading="lazy">
                                </a>
                                <div class="card-hover-overlay">
                                    <button type="button" class="btn-quick-add"
                                            data-product-id="<%= p.getId() %>"
                                            title="Thêm vào giỏ hàng">
                                        <i class="bi bi-bag-plus"></i> Thêm vào giỏ
                                    </button>
                                </div>
                            </div>

                            <div class="card-body-custom d-flex flex-column flex-fill">
                                <%-- TÊN --%>
                                <h6 class="product-title line-clamp-2 mb-1">
                                    <a href="<%= ctx %>/product?id=<%= p.getId() %>"
                                       class="text-dark text-decoration-none">
                                        <%= p.getName() %>
                                    </a>
                                </h6>

                                <%-- RATING --%>
                                <% if (reviewCount > 0) { %>
                                <div class="star-rating mb-1">
                                    <span class="stars">
                                        <% for (int s = 1; s <= 5; s++) { %>
                                            <%= (s <= Math.round(avgRating)) ? "★" : "☆" %>
                                        <% } %>
                                    </span>
                                    <span class="review-count">(<%= reviewCount %>)</span>
                                </div>
                                <% } %>

                                <%-- GIÁ + NÚT --%>
                                <div class="product-footer mt-auto d-flex justify-content-between align-items-end gap-2">
                                    <div class="product-price text-danger">
                                        <div class="price-now">
                                            <%= String.format("%,.0f", p.getPrice()) %>đ
                                        </div>
                                        <% if (p.getOld_price() > 0) { %>
                                        <div class="old-price">
                                            <del><%= String.format("%,.0f", p.getOld_price()) %>đ</del>
                                        </div>
                                        <% } %>
                                    </div>
                                    <a class="btn btn-danger btn-sm px-3" href="<%= ctx %>/product?id=<%= p.getId() %>">Chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                    <% } %>
                </div>
                <%-- ==== HẾT GRID ==== --%>

                <!-- Pagination -->
                    <%
                // Xây query string giữ lại category, sort, keyword
                StringBuilder baseQuery = new StringBuilder();
                if (selectedCategoryId != null && !selectedCategoryId.isEmpty()) {
                    baseQuery.append("&categoryId=").append(selectedCategoryId);
                }
                if (selectedSort != null && !selectedSort.isEmpty()) {
                    baseQuery.append("&sort=").append(selectedSort);
                }
                if (keywordAttr != null && !keywordAttr.isEmpty()) {
                    baseQuery.append("&keyword=").append(keywordAttr);
                }
                                if (selectedGender != null && !selectedGender.isEmpty()) {
                    baseQuery.append("&gender=").append(selectedGender);
                }
                if (saleParam != null && !saleParam.isEmpty()) {
                    baseQuery.append("&sale=").append(saleParam);
                }
                if (selectedBrandIdsArr != null) {
                    for (String bid : selectedBrandIdsArr) {
                        baseQuery.append("&brandId=").append(bid);
                    }
                }
                if (selectedPricesArr != null) {
                    for (String pr : selectedPricesArr) {
                        baseQuery.append("&price=").append(pr);
                    }
                }

            %>
                    <% if (totalPages > 1) { %>
                <nav class="mt-4" aria-label="Pagination">
                    <ul class="pagination justify-content-center">

                        <!-- Previous -->
                        <li class="page-item <%= (currentPage <= 1) ? "disabled" : "" %>">
                            <a class="page-link" href="<%= ctx %>/list-product?page=<%= currentPage - 1 %><%= baseQuery.toString() %>" data-page="<%= currentPage - 1 %>" aria-label="Previous">&laquo;</a>
                        </li>

                        <%-- Phân trang thông minh: hiện tối đa 7 trang, dùng "..." ở giữa --%>
                        <%
                            int rangeSize = 2; // số trang xung quanh trang hiện tại
                            for (int pi = 1; pi <= totalPages; pi++) {
                                boolean isFirst = (pi == 1);
                                boolean isLast  = (pi == totalPages);
                                boolean inRange = (pi >= currentPage - rangeSize && pi <= currentPage + rangeSize);

                                if (!isFirst && !isLast && !inRange) {
                                    // In dấu "..." nhưng chỉ 1 lần mỗi khoảng
                                    boolean prevShown = (pi - 1 == 1)
                                            || (pi - 1 >= currentPage - rangeSize);
                                    if (!prevShown) {
                        %>
                        <li class="page-item disabled"><span class="page-link">…</span></li>
                        <%      }
                                    continue;
                                }
                        %>
                        <li class="page-item <%= (pi == currentPage) ? "active" : "" %>">
                            <a class="page-link" href="<%= ctx %>/list-product?page=<%= pi %><%= baseQuery.toString() %>" data-page="<%= pi %>"><%= pi %></a>
                        </li>
                        <% } %>

                        <!-- Next -->
                        <li class="page-item <%= (currentPage >= totalPages) ? "disabled" : "" %>">
                            <a class="page-link" href="<%= ctx %>/list-product?page=<%= currentPage + 1 %><%= baseQuery.toString() %>" data-page="<%= currentPage + 1 %>" aria-label="Next">&raquo;</a>
                        </li>
                    </ul>
                </nav>
                <% } %>
                </div><!-- end #productGridWrap -->
        </section>
    </div>
</div>
<!-- Features -->
<section class="bg-light py-4">
    <div class="container">
        <div class="row g-3">
            <div class="col-lg-3 col-6">  <!--srv1-->
                <div class="d-flex align-items-center">
                    <div class="feature-item d-flex align-items-start mb-4 p-3 bg-light rounded">
                        <div class="col-3 pt-2 ">
                            <img src="assets/images/footer/srv_1.png" alt="Service Item"
                                 class="img-fluid rounded ">
                        </div>
                        <div><h6 class="fw-bold mb-1">VẬN CHUYỂN SIÊU TỐC</h6>
                            <small class="text-muted">Vận chuyển nội thành HN trong 2 tiếng!</small></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-6">  <!--srv2-->
                <div class="d-flex align-items-center">
                    <div class="feature-item d-flex align-items-start mb-4 p-3 bg-light rounded">
                        <div class="col-3 p-0 ">
                            <img src="assets/images/footer/srv_2.png" alt="Service Item"
                                 class="img-fluid rounded ">
                        </div>
                        <div><h6 class="fw-bold mb-1">ĐỔI HÀNG</h6>
                            <small class="text-muted">Đổi hàng trong 7 ngày miễn phí!</small></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-6"> <!--srv3-->
                <div class="d-flex align-items-center">
                    <div class="feature-item d-flex align-items-start mb-4 p-3 bg-light rounded">
                        <div class="col-3 p-0 ">
                            <img src="assets/images/footer/srv_3.png" alt="Service Item"
                                 class="img-fluid rounded ">
                        </div>
                        <div><h6 class="fw-bold mb-1">TIẾT KIỆM THỜI GIAN</h6>
                            <small class="text-muted">Mua sắm dễ hơn khi online</small></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-6"> <!--srv4-->
                <div class="d-flex align-items-center">
                    <div class="feature-item d-flex align-items-start mb-4 p-3 bg-light rounded">
                        <div class="col-3 p-0 ">
                            <img src="assets/images/footer/srv_4.png" alt="Service Item"
                                 class="img-fluid rounded ">
                        </div>
                        <div><h6 class="fw-bold mb-1">ĐỊA CHỈ CỬA HÀNG</h6>
                            <small class="text-muted">Lotus 4, Vinhome Gardenia, Hàm Nghi, Từ Liêm, HN</small></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FOOTER -->
<%@ include file="/WEB-INF/jspf/site_footer.jspf" %>

<!-- Back to top -->
<button id="scrollTopBtn" class="scroll-top-btn"
        onclick="window.scrollTo({top:0,behavior:'smooth'})"
        title="Lên đầu trang" aria-label="Lên đầu trang">
    <i class="bi bi-arrow-up"></i>
</button>

<!-- ===== QUICK VIEW MODAL ===== -->
<div class="modal fade" id="quickViewModal" tabindex="-1" aria-labelledby="quickViewLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="quickViewLabel">Chọn phân loại</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row g-3">
                    <div class="col-md-5 text-center">
                        <img id="qvImage" src="" alt="" class="img-fluid rounded" style="max-height:320px;object-fit:contain;">
                    </div>
                    <div class="col-md-7">
                        <h5 id="qvName" class="fw-bold mb-2"></h5>
                        <div id="qvPrice" class="mb-3"></div>

                        <div id="qvColorSection" class="mb-3" style="display:none">
                            <label class="fw-semibold mb-1 d-block">Màu sắc:</label>
                            <div id="qvColorList" class="d-flex flex-wrap gap-2"></div>
                        </div>

                        <div id="qvSizeSection" class="mb-3" style="display:none">
                            <label class="fw-semibold mb-1 d-block">Kích cỡ:</label>
                            <div id="qvSizeList" class="d-flex flex-wrap gap-2"></div>
                        </div>

                        <div id="qvStockInfo" class="text-muted mb-3" style="font-size:0.85rem"></div>

                        <div class="d-flex align-items-center gap-2 mb-3">
                            <label class="fw-semibold">Số lượng:</label>
                            <div class="input-group" style="width:120px">
                                <button class="btn btn-outline-secondary btn-sm" type="button" id="qvQtyMinus">−</button>
                                <input type="number" id="qvQty" class="form-control form-control-sm text-center" value="1" min="1">
                                <button class="btn btn-outline-secondary btn-sm" type="button" id="qvQtyPlus">+</button>
                            </div>
                        </div>

                        <button type="button" id="qvAddToCart" class="btn btn-danger w-100">
                            <i class="bi bi-bag-plus me-1"></i>Thêm vào giỏ hàng
                        </button>
                        <div id="qvMsg" class="mt-2" style="display:none"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Toast thông báo thêm giỏ hàng -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index:9999">
    <div id="cartToast" class="toast align-items-center text-bg-success border-0" role="alert">
        <div class="d-flex">
            <div class="toast-body" id="cartToastMsg"></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>

<script>
    // Tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function(el) { return new bootstrap.Tooltip(el); });

    // ===== AJAX Product Filter System =====
    var __fetchProducts; // expose cho các module khác gọi
    (function() {
        var CTX = '<%= ctx %>';
        var API_URL = CTX + '/api/products';
        var gridWrap = document.getElementById('productGridWrap');
        var countInfo = document.getElementById('productCountInfo');
        var filterForm = document.getElementById('filterForm');
        var sortSelect = document.getElementById('sortSelect');
        var currentPage = <%= currentPage %>;
        var PAGE_SIZE = 16;

        if (!gridWrap || !filterForm) return;

        // Thu thập tất cả params hiện tại từ sidebar + sort + hidden fields
        function collectParams(page) {
            var params = new URLSearchParams();

            // Hidden fields trong filterForm (category, keyword, gender, sale)
            filterForm.querySelectorAll('input[type="hidden"]').forEach(function(h) {
                if (h.name && h.value) params.append(h.name, h.value);
            });

            // Checkbox brand
            filterForm.querySelectorAll('input[name="brandId"]:checked').forEach(function(cb) {
                params.append('brandId', cb.value);
            });

            // Checkbox price
            filterForm.querySelectorAll('input[name="price"]:checked').forEach(function(cb) {
                params.append('price', cb.value);
            });

            // Radio gender
            var genderRadio = filterForm.querySelector('input[name="gender"]:checked');
            if (genderRadio && genderRadio.value) {
                params.set('gender', genderRadio.value);
            }

            // Sort
            if (sortSelect && sortSelect.value) {
                params.set('sort', sortSelect.value);
            }

            params.set('page', page || 1);
            return params;
        }

        // Format giá
        function formatPrice(num) {
            return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + 'đ';
        }

        // Render sao
        function renderStars(avg, count) {
            if (count <= 0) return '';
            var html = '<div class="star-rating mb-1"><span class="stars">';
            for (var s = 1; s <= 5; s++) {
                html += (s <= Math.round(avg)) ? '★' : '☆';
            }
            html += '</span><span class="review-count">(' + count + ')</span></div>';
            return html;
        }

        // Render 1 product card
        function renderCard(p) {
            var badge = '';
            if (p.isSale && p.promotionLabel) {
                badge = '<span class="ribbon">' + p.promotionLabel + '</span>';
            } else if (p.discountPct > 0) {
                badge = '<span class="ribbon">-' + p.discountPct + '%</span>';
            }

            var oldPriceHtml = '';
            if (p.oldPrice > 0) {
                oldPriceHtml = '<div class="old-price"><del>' + formatPrice(p.oldPrice) + '</del></div>';
            }

            return '<div class="col-6 col-md-4 col-lg-3">' +
                '<div class="product-card h-100 d-flex flex-column">' +
                badge +
                '<div class="card-img-wrap position-relative">' +
                '<a href="' + CTX + '/product?id=' + p.id + '">' +
                '<img src="' + p.imageUrl + '" alt="' + p.name + '" class="card-img-top" loading="lazy">' +
                '</a>' +
                '<div class="card-hover-overlay">' +
                '<button type="button" class="btn-quick-add" data-product-id="' + p.id + '" title="Thêm vào giỏ hàng">' +
                '<i class="bi bi-bag-plus"></i> Thêm vào giỏ</button>' +
                '</div></div>' +
                '<div class="card-body-custom d-flex flex-column flex-fill">' +
                '<h6 class="product-title line-clamp-2 mb-1">' +
                '<a href="' + CTX + '/product?id=' + p.id + '" class="text-dark text-decoration-none">' + p.name + '</a></h6>' +
                renderStars(p.avgRating, p.reviewCount) +
                '<div class="product-footer mt-auto d-flex justify-content-between align-items-end gap-2">' +
                '<div class="product-price text-danger">' +
                '<div class="price-now">' + formatPrice(p.price) + '</div>' +
                oldPriceHtml +
                '</div>' +
                '<a class="btn btn-danger btn-sm px-3" href="' + CTX + '/product?id=' + p.id + '">Chi tiết</a>' +
                '</div></div></div></div>';
        }

        // Render pagination
        function renderPagination(cur, total, params) {
            if (total <= 1) return '';
            var html = '<nav class="mt-4" aria-label="Pagination"><ul class="pagination justify-content-center">';

            // Previous
            html += '<li class="page-item ' + (cur <= 1 ? 'disabled' : '') + '">';
            html += '<a class="page-link" href="#" data-page="' + (cur - 1) + '">&laquo;</a></li>';

            var rangeSize = 2;
            for (var pi = 1; pi <= total; pi++) {
                var isFirst = (pi === 1), isLast = (pi === total);
                var inRange = (pi >= cur - rangeSize && pi <= cur + rangeSize);
                if (!isFirst && !isLast && !inRange) {
                    var prevShown = (pi - 1 === 1) || (pi - 1 >= cur - rangeSize);
                    if (!prevShown) {
                        html += '<li class="page-item disabled"><span class="page-link">…</span></li>';
                    }
                    continue;
                }
                html += '<li class="page-item ' + (pi === cur ? 'active' : '') + '">';
                html += '<a class="page-link" href="#" data-page="' + pi + '">' + pi + '</a></li>';
            }

            // Next
            html += '<li class="page-item ' + (cur >= total ? 'disabled' : '') + '">';
            html += '<a class="page-link" href="#" data-page="' + (cur + 1) + '">&raquo;</a></li>';
            html += '</ul></nav>';
            return html;
        }

        // Hiệu ứng loading
        function showLoading() {
            gridWrap.style.opacity = '0.45';
            gridWrap.style.pointerEvents = 'none';
            gridWrap.style.transition = 'opacity 0.2s';
        }
        function hideLoading() {
            gridWrap.style.opacity = '1';
            gridWrap.style.pointerEvents = '';
        }

        // AJAX fetch & render
        function fetchProducts(page) {
            var params = collectParams(page);
            showLoading();

            fetch(API_URL + '?' + params.toString())
                .then(function(res) { return res.json(); })
                .then(function(data) {
                    currentPage = data.currentPage;

                    // Update count info
                    if (data.totalProducts > 0) {
                        var from = (data.currentPage - 1) * PAGE_SIZE + 1;
                        var to = Math.min(data.currentPage * PAGE_SIZE, data.totalProducts);
                        countInfo.innerHTML = '&mdash; Đang hiển thị ' + from + '–' + to + ' / ' + data.totalProducts + ' sản phẩm';
                    } else {
                        countInfo.innerHTML = '— Không tìm thấy sản phẩm nào';
                    }

                    // Render grid
                    var gridHtml = '<div class="row g-4">';
                    if (data.products.length === 0) {
                        gridHtml += '<div class="col-12"><div class="alert alert-warning mb-0">Chưa có sản phẩm nào.</div></div>';
                    } else {
                        data.products.forEach(function(p) { gridHtml += renderCard(p); });
                    }
                    gridHtml += '</div>';
                    gridHtml += renderPagination(data.currentPage, data.totalPages, params);

                    gridWrap.innerHTML = gridHtml;
                    hideLoading();

                    // Bind pagination click
                    bindPaginationLinks();

                    // Update browser URL (không reload)
                    var newUrl = CTX + '/list-product?' + params.toString();
                    history.replaceState(null, '', newUrl);

                    // Cuộn lên đầu grid khi chuyển trang
                    if (page && page !== 1) {
                        gridWrap.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                })
                .catch(function(err) {
                    console.error('Fetch error:', err);
                    hideLoading();
                });
        }

        // Bind pagination
        function bindPaginationLinks() {
            gridWrap.querySelectorAll('.page-link[data-page]').forEach(function(a) {
                a.addEventListener('click', function(e) {
                    e.preventDefault();
                    var pg = parseInt(this.getAttribute('data-page'));
                    if (pg >= 1) fetchProducts(pg);
                });
            });
        }

        // Filter form: intercept checkbox/radio changes
        var filterTimer = null;
        filterForm.querySelectorAll('.filter-auto').forEach(function(el) {
            el.addEventListener('change', function() {
                clearTimeout(filterTimer);
                filterTimer = setTimeout(function() { fetchProducts(1); }, 250);
            });
        });

        // Sort change
        if (sortSelect) {
            sortSelect.addEventListener('change', function() { fetchProducts(1); });
        }

        // Bind pagination lần đầu (cho HTML server-render)
        bindPaginationLinks();

        // Expose ra ngoài
        __fetchProducts = fetchProducts;
    })();

    // ===== Search thương hiệu nhanh =====
    (function() {
        var input = document.getElementById('brandSearchInput');
        if (!input) return;
        input.addEventListener('input', function() {
            var keyword = this.value.trim().toLowerCase();
            var items = document.querySelectorAll('.brand-check-item');
            items.forEach(function(label) {
                var name = label.getAttribute('data-brand-name') || '';
                label.style.display = name.indexOf(keyword) !== -1 ? '' : 'none';
            });
        });
    })();

    // ===== Khoảng giá tuỳ chỉnh =====
    (function() {
        var btn = document.getElementById('btnApplyCustomPrice');
        if (!btn) return;
        btn.addEventListener('click', function() {
            var fromVal = document.getElementById('priceFrom').value.trim();
            var toVal   = document.getElementById('priceTo').value.trim();
            if (!fromVal && !toVal) return;

            var from = fromVal ? parseInt(fromVal) : 0;
            var to   = toVal   ? parseInt(toVal)   : 999999999;
            if (from > to) { var tmp = from; from = to; to = tmp; }

            // Bỏ tick tất cả checkbox price cũ
            document.querySelectorAll('input[name="price"]').forEach(function(cb) {
                cb.checked = false;
            });

            // Tạo hidden input tạm cho custom range rồi gọi AJAX
            var customInput = document.createElement('input');
            customInput.type = 'hidden';
            customInput.name = 'price';
            customInput.value = from + '-' + to;
            customInput.className = 'custom-price-hidden';

            // Xóa hidden cũ nếu có
            var old = document.querySelector('.custom-price-hidden');
            if (old) old.remove();

            var filterForm = document.getElementById('filterForm');
            filterForm.appendChild(customInput);

            // Gọi AJAX ngay
            if (__fetchProducts) {
                __fetchProducts(1);
            }
        });
    })();

    // ===== QUICK ADD TO CART + QUICK VIEW =====
    (function() {
        var CTX = '<%= ctx %>';
        var CART_API = CTX + '/api/cart-quick';
        var qvModal = null;
        var qvProductId = null;
        var qvVariants = [];
        var selectedColor = null;
        var selectedVariantId = null;

        // Toast helper
        function showToast(msg, isError) {
            var toast = document.getElementById('cartToast');
            var toastMsg = document.getElementById('cartToastMsg');
            if (!toast || !toastMsg) return;
            toastMsg.textContent = msg;
            toast.className = 'toast align-items-center border-0 ' + (isError ? 'text-bg-danger' : 'text-bg-success');
            var bsToast = new bootstrap.Toast(toast, { delay: 2500 });
            bsToast.show();
        }

        // Cập nhật badge giỏ hàng trên header
        function updateCartBadge(count) {
            var badges = document.querySelectorAll('.cart-count-badge');
            badges.forEach(function(b) {
                b.textContent = count;
                b.style.display = count > 0 ? '' : 'none';
            });
        }

        // Format giá
        function fmtPrice(n) {
            return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + 'đ';
        }

        // Gọi API thêm vào giỏ
        function addToCart(productId, variantId, qty, callback) {
            var body = 'productId=' + productId + '&qty=' + (qty || 1);
            if (variantId) body += '&variantId=' + variantId;

            fetch(CART_API + '?action=add', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: body
            })
            .then(function(res) { return res.json(); })
            .then(function(data) {
                if (data.ok) {
                    showToast(data.msg);
                    if (data.cartCount !== undefined) updateCartBadge(data.cartCount);
                } else if (data.msg === 'login_required') {
                    window.location.href = CTX + '/login.jsp?back=' + encodeURIComponent(window.location.href);
                    return;
                } else if (data.msg === 'variant_required') {
                    // Mở Quick View modal để chọn variant
                    openQuickView(productId);
                    return;
                } else {
                    showToast(data.msg || 'Có lỗi xảy ra', true);
                }
                if (callback) callback(data);
            })
            .catch(function() { showToast('Lỗi kết nối, thử lại sau', true); });
        }

        // Mở Quick View modal
        function openQuickView(productId) {
            qvProductId = productId;
            selectedColor = null;
            selectedVariantId = null;

            // Reset modal
            document.getElementById('qvImage').src = '';
            document.getElementById('qvName').textContent = 'Đang tải...';
            document.getElementById('qvPrice').innerHTML = '';
            document.getElementById('qvColorSection').style.display = 'none';
            document.getElementById('qvSizeSection').style.display = 'none';
            document.getElementById('qvStockInfo').textContent = '';
            document.getElementById('qvMsg').style.display = 'none';
            document.getElementById('qvQty').value = 1;

            if (!qvModal) {
                qvModal = new bootstrap.Modal(document.getElementById('quickViewModal'));
            }
            qvModal.show();

            // Fetch variant data
            fetch(CART_API + '?action=variants&productId=' + productId)
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    if (!data.ok) { showToast(data.msg, true); return; }

                    var p = data.product;
                    qvVariants = data.variants;

                    document.getElementById('qvImage').src = p.imageUrl;
                    document.getElementById('qvName').textContent = p.name;

                    var priceHtml = '<span class="text-danger fw-bold fs-5">' + fmtPrice(p.price) + '</span>';
                    if (p.oldPrice > 0 && p.oldPrice > p.price) {
                        priceHtml += ' <del class="text-muted">' + fmtPrice(p.oldPrice) + '</del>';
                    }
                    document.getElementById('qvPrice').innerHTML = priceHtml;

                    // Lấy danh sách màu unique
                    var colors = [];
                    qvVariants.forEach(function(v) {
                        if (v.color && colors.indexOf(v.color) === -1) colors.push(v.color);
                    });

                    if (colors.length > 0) {
                        document.getElementById('qvColorSection').style.display = '';
                        var colorHtml = '';
                        colors.forEach(function(c) {
                            colorHtml += '<button type="button" class="btn btn-outline-dark btn-sm qv-color-btn" data-color="' + c + '">' + c + '</button>';
                        });
                        document.getElementById('qvColorList').innerHTML = colorHtml;

                        // Bind color click
                        document.querySelectorAll('.qv-color-btn').forEach(function(btn) {
                            btn.addEventListener('click', function() {
                                document.querySelectorAll('.qv-color-btn').forEach(function(b) { b.classList.remove('active', 'btn-dark'); b.classList.add('btn-outline-dark'); });
                                this.classList.add('active', 'btn-dark');
                                this.classList.remove('btn-outline-dark');
                                selectedColor = this.getAttribute('data-color');
                                renderSizes(selectedColor);
                            });
                        });

                        // Auto-select màu đầu tiên
                        document.querySelector('.qv-color-btn').click();
                    } else {
                        // Không có color, hiển thị sizes thẳng
                        renderSizes(null);
                    }
                });
        }

        // Render sizes theo color đã chọn
        function renderSizes(color) {
            var filtered = qvVariants.filter(function(v) {
                return color ? v.color === color : true;
            });

            if (filtered.length === 0) {
                document.getElementById('qvSizeSection').style.display = 'none';
                return;
            }

            document.getElementById('qvSizeSection').style.display = '';
            var sizeHtml = '';
            filtered.forEach(function(v) {
                var disabled = v.stockQty <= 0;
                sizeHtml += '<button type="button" class="btn btn-sm qv-size-btn ' +
                    (disabled ? 'btn-outline-secondary disabled' : 'btn-outline-dark') + '" ' +
                    'data-variant-id="' + v.id + '" data-stock="' + v.stockQty + '"' +
                    (disabled ? ' disabled' : '') + '>' +
                    v.size + (disabled ? ' (Hết)' : '') + '</button>';
            });
            document.getElementById('qvSizeList').innerHTML = sizeHtml;
            selectedVariantId = null;
            document.getElementById('qvStockInfo').textContent = '';

            // Bind size click
            document.querySelectorAll('.qv-size-btn:not(.disabled)').forEach(function(btn) {
                btn.addEventListener('click', function() {
                    document.querySelectorAll('.qv-size-btn').forEach(function(b) { b.classList.remove('active', 'btn-dark'); b.classList.add('btn-outline-dark'); });
                    this.classList.add('active', 'btn-dark');
                    this.classList.remove('btn-outline-dark');
                    selectedVariantId = parseInt(this.getAttribute('data-variant-id'));
                    var stock = parseInt(this.getAttribute('data-stock'));
                    document.getElementById('qvStockInfo').textContent = 'Còn ' + stock + ' sản phẩm';
                });
            });
        }

        // Qty buttons
        document.getElementById('qvQtyMinus').addEventListener('click', function() {
            var inp = document.getElementById('qvQty');
            var v = parseInt(inp.value) || 1;
            if (v > 1) inp.value = v - 1;
        });
        document.getElementById('qvQtyPlus').addEventListener('click', function() {
            var inp = document.getElementById('qvQty');
            var v = parseInt(inp.value) || 1;
            inp.value = v + 1;
        });

        // Add to cart từ modal
        document.getElementById('qvAddToCart').addEventListener('click', function() {
            if (!selectedVariantId && qvVariants.length > 0) {
                var msgEl = document.getElementById('qvMsg');
                msgEl.innerHTML = '<div class="alert alert-warning py-1 mb-0">Vui lòng chọn phân loại trước!</div>';
                msgEl.style.display = '';
                return;
            }
            var qty = parseInt(document.getElementById('qvQty').value) || 1;
            var btn = this;
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Đang thêm...';

            addToCart(qvProductId, selectedVariantId, qty, function() {
                btn.disabled = false;
                btn.innerHTML = '<i class="bi bi-bag-plus me-1"></i>Thêm vào giỏ hàng';
                if (qvModal) qvModal.hide();
            });
        });

        // Bind nút "Thêm vào giỏ" trên card (server-rendered)
        function bindQuickAddButtons(container) {
            (container || document).querySelectorAll('.btn-quick-add').forEach(function(btn) {
                // Tránh bind lại
                if (btn.dataset.bound) return;
                btn.dataset.bound = '1';
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    var pid = parseInt(this.getAttribute('data-product-id'));
                    addToCart(pid, null, 1);
                });
            });
        }

        // Bind lần đầu
        bindQuickAddButtons();

        // Khi AJAX render lại grid → cần bind lại
        var observer = new MutationObserver(function() {
            bindQuickAddButtons(document.getElementById('productGridWrap'));
        });
        var gridWrap = document.getElementById('productGridWrap');
        if (gridWrap) {
            observer.observe(gridWrap, { childList: true, subtree: true });
        }
    })();
</script>
</body>
</html>