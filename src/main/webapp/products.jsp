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
                    <% if (totalProducts > 0) { %>
                    <span class="text-muted ms-2" style="font-size:0.88rem;">
                        &mdash; Đang hiển thị <%= fromItem %>–<%= toItem %> / <%= totalProducts %> sản phẩm
                    </span>
                    <% } else { %>
                    <span class="text-muted ms-2" style="font-size:0.88rem;">— Không tìm thấy sản phẩm nào</span>
                    <% } %>
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
                    <select id="sortSelect" name="sort" class="form-select form-select-sm"
                            onchange="this.form.submit()">
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

                            <%-- ẢNH --%>
                            <a href="<%= ctx %>/product?id=<%= p.getId() %>" class="card-img-wrap">
                                <img src="<%= p.getImage_url() %>" alt="<%= p.getName() %>" class="card-img-top" loading="lazy">
                            </a>

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
                            <a class="page-link" href="<%= ctx %>/list-product?page=<%= currentPage - 1 %><%= baseQuery.toString() %>" aria-label="Previous">&laquo;</a>
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
                            <a class="page-link" href="<%= ctx %>/list-product?page=<%= pi %><%= baseQuery.toString() %>"><%= pi %></a>
                        </li>
                        <% } %>

                        <!-- Next -->
                        <li class="page-item <%= (currentPage >= totalPages) ? "disabled" : "" %>">
                            <a class="page-link" href="<%= ctx %>/list-product?page=<%= currentPage + 1 %><%= baseQuery.toString() %>" aria-label="Next">&raquo;</a>
                        </li>
                    </ul>
                </nav>
                <% } %>
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
<button class="btn btn-danger position-fixed bottom-0 end-0 m-4 rounded-circle"
        style="width:50px;height:50px;z-index:1000;"
        onclick="window.scrollTo({top:0,behavior:'smooth'})"
        title="Lên đầu trang" aria-label="Lên đầu trang">
    <i class="bi bi-arrow-up"></i>
</button>

<script>
    // Tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(el => new bootstrap.Tooltip(el));

    // ===== STT 29: Auto-submit bộ lọc khi tick checkbox/radio =====
    // Dùng debounce nhỏ để tránh submit nhiều lần liên tiếp
    (function() {
        const form = document.getElementById('filterForm');
        if (!form) return;

        let submitTimer = null;

        form.querySelectorAll('.filter-auto').forEach(function(el) {
            el.addEventListener('change', function() {
                clearTimeout(submitTimer);
                submitTimer = setTimeout(function() {
                    // Reset về trang 1 khi đổi bộ lọc
                    let pageInput = form.querySelector('input[name="page"]');
                    if (!pageInput) {
                        pageInput = document.createElement('input');
                        pageInput.type = 'hidden';
                        pageInput.name = 'page';
                        form.appendChild(pageInput);
                    }
                    pageInput.value = '1';
                    form.submit();
                }, 200);
            });
        });
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

            // Build custom range string (server sẽ parse)
            var rangeKey = from + '-' + to;

            // Clone hidden fields từ filterForm, thêm price custom
            var form = document.getElementById('filterForm');
            var url = new URL(form.action, window.location.origin);

            // Giữ lại category, sort, keyword, gender, sale
            var hiddens = form.querySelectorAll('input[type="hidden"]');
            hiddens.forEach(function(h) { url.searchParams.set(h.name, h.value); });

            // Bỏ hết price cũ, thêm price custom
            url.searchParams.delete('price');
            url.searchParams.append('price', rangeKey);
            url.searchParams.set('page', '1');

            window.location.href = url.toString();
        });
    })();
</script>
</body>
</html>