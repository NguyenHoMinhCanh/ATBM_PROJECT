package com.japansport.controller;

import com.japansport.dao.ProductDao;
import com.japansport.dao.CategoryDao;
import com.japansport.dao.BrandDao;
import com.japansport.dao.BannerDao;
import com.japansport.dao.ReviewDao;
import com.japansport.model.Banner;
import com.japansport.model.Product;
import com.japansport.model.Category;
import com.japansport.model.Brand;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "ProductListController", value = "/list-product")
public class ProductListController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();
    private final CategoryDao categoryDao = new CategoryDao();
    private final BrandDao brandDao = new BrandDao();
    private final ReviewDao reviewDao = new ReviewDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String keywordParam    = req.getParameter("keyword");
        String categoryIdParam = req.getParameter("categoryId");
        String sortParam       = req.getParameter("sort");
        String pageParam       = req.getParameter("page");

        // NEW
        String genderParam     = req.getParameter("gender"); // men/women/unisex
        String saleParam       = req.getParameter("sale");   // 1/true

        String[] priceParams   = req.getParameterValues("price");
        String[] brandIdParams = req.getParameterValues("brandId");

        final int PAGE_SIZE = 16;

        int page = 1;
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignore) {
                page = 1;
            }
        }

        // Parse categoryId sớm để dùng nhiều chỗ
        Integer categoryId = null;
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdParam);
            } catch (NumberFormatException ignore) {
                categoryId = null;
            }
        }

        // Normalize gender + sale
        String normalizedGender = normalizeGender(genderParam); // men/women/unisex hoặc null
        boolean saleOnly = "1".equals(saleParam) || "true".equalsIgnoreCase(saleParam);

        // Chuẩn bị các tham số filter cho SQL
        List<Integer> brandIdFilter = new ArrayList<>();
        if (brandIdParams != null) {
            for (String s : brandIdParams) {
                try {
                    brandIdFilter.add(Integer.parseInt(s));
                } catch (NumberFormatException ignore) {}
            }
        }

        List<ProductDao.PriceRange> priceRanges = new ArrayList<>();
        if (priceParams != null) {
            for (String range : priceParams) {
                if ("0-500".equals(range)) priceRanges.add(new ProductDao.PriceRange(0, 500_000));
                else if ("500-1000".equals(range)) priceRanges.add(new ProductDao.PriceRange(500_000, 1_000_000));
                else if ("1000-1500".equals(range)) priceRanges.add(new ProductDao.PriceRange(1_000_000, 1_500_000));
                else if ("1500-2000".equals(range)) priceRanges.add(new ProductDao.PriceRange(1_500_000, 2_000_000));
                else if ("2000-2500".equals(range)) priceRanges.add(new ProductDao.PriceRange(2_000_000, 2_500_000));
                else if ("2500-3000".equals(range)) priceRanges.add(new ProductDao.PriceRange(2_500_000, 3_000_000));
                else if ("3000+".equals(range)) priceRanges.add(new ProductDao.PriceRange(3_000_000, Double.MAX_VALUE));
                else if (range.contains("-")) {
                    try {
                        String[] parts = range.split("-", 2);
                        priceRanges.add(new ProductDao.PriceRange(Double.parseDouble(parts[0]), Double.parseDouble(parts[1])));
                    } catch (NumberFormatException ignore) {}
                }
            }
        }

        String kw = (keywordParam != null) ? keywordParam.trim() : null;

        // 1) Lấy tổng số lượng sản phẩm thỏa mãn để tính TotalPages
        int totalProducts = productDao.countSearchAndFilterProducts(categoryId, kw, brandIdFilter, priceRanges, normalizedGender, saleOnly);
        int totalPages = 0;
        List<Product> productsPage = new ArrayList<>();

        if (totalProducts > 0) {
            totalPages = (int) Math.ceil(totalProducts * 1.0 / PAGE_SIZE);
            if (page > totalPages) page = totalPages;
            int offset = (page - 1) * PAGE_SIZE;

            // 2) Lấy chính xác 12 sản phẩm của trang hiện tại bằng SQL LIMIT/OFFSET
            productsPage = productDao.searchAndFilterProducts(categoryId, kw, brandIdFilter, priceRanges, normalizedGender, saleOnly, sortParam, offset, PAGE_SIZE);
        }

        // Set lại attribute cho các filter hiện tại
        if (kw != null && !kw.isEmpty()) req.setAttribute("keyword", kw);
        if (categoryId != null) req.setAttribute("selectedCategoryId", categoryIdParam);
        if (normalizedGender != null) req.setAttribute("selectedGender", normalizedGender);
        if (saleOnly) req.setAttribute("selectedSale", "1");

        // 6) sidebar data
        List<Category> categories = categoryDao.getAllActive();
        List<Brand> brands = brandDao.getAllActive();

        req.setAttribute("categoryList", categories);
        req.setAttribute("brandList", brands);

        // NEW: show gender filter chỉ khi vào theo THỂ LOẠI hoặc THƯƠNG HIỆU
        boolean showGenderFilter = (categoryId != null) || (brandIdParams != null && brandIdParams.length > 0);
        req.setAttribute("showGenderFilter", showGenderFilter);

        // NEW: title + breadcrumb
        String pageTitle = buildPageTitle(
                keywordParam, saleOnly, categoryId, categories,
                brandIdParams, brands, normalizedGender
        );
        req.setAttribute("pageTitle", pageTitle);
        req.setAttribute("breadcrumbCurrent", pageTitle);

        // 7) send data
        req.setAttribute("selectedSort", sortParam);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalProducts", totalProducts);

        req.setAttribute("selectedPrices", priceParams);
        req.setAttribute("selectedBrandIds", brandIdParams);

        req.setAttribute("listProduct", productsPage);

        // Rating batch cho danh sách hiện tại (cùng pattern với HomeController)
        if (productsPage != null && !productsPage.isEmpty()) {
            List<Integer> pageIds = productsPage.stream()
                    .map(Product::getId)
                    .collect(Collectors.toList());
            Map<Integer, double[]> ratingMap = reviewDao.getAvgRatingBatch(pageIds);
            req.setAttribute("ratingMap", ratingMap);
        }

        // Banner trang shop (products.jsp)
        BannerDao bannerDao = new BannerDao();
        Banner shopTopBanner = bannerDao.getOneBannerByPosition("SHOP_TOP");
        req.setAttribute("shopTopBanner", shopTopBanner);

        req.getRequestDispatcher("products.jsp").forward(req, resp);
    }

    private String buildPageTitle(
            String keywordParam,
            boolean saleOnly,
            Integer categoryId,
            List<Category> categories,
            String[] brandIdParams,
            List<Brand> brands,
            String gender
    ) {
        // gender label
        String genderLabel = toGenderLabel(gender);

        // base title theo ưu tiên
        String base;
        if (keywordParam != null && !keywordParam.trim().isEmpty()) {
            base = "Kết quả tìm kiếm: " + keywordParam.trim();
        } else if (saleOnly) {
            base = "Khuyến mãi";
        } else if (categoryId != null) {
            base = findCategoryName(categories, categoryId, "Thể loại");
        } else if (brandIdParams != null && brandIdParams.length == 1) {
            Integer brandId = tryParseInt(brandIdParams[0]);
            base = (brandId != null) ? findBrandName(brands, brandId, "Thương hiệu") : "Thương hiệu";
        } else if (brandIdParams != null && brandIdParams.length > 1) {
            base = "Nhiều thương hiệu";
        } else if (gender != null) {
            base = genderLabel; // “Giày nam/giày nữ/unisex”
        } else {
            base = "Tất cả sản phẩm";
        }

        // Nếu đang ở category/brand/sale/search mà có gender -> append để ra đúng context
        boolean baseIsGenderOnly = (gender != null && (categoryId == null) && (brandIdParams == null || brandIdParams.length == 0) && !saleOnly
                && (keywordParam == null || keywordParam.trim().isEmpty()));

        if (!baseIsGenderOnly && genderLabel != null) {
            // ví dụ: "Running - Giày nam" / "Nike - Giày nữ"
            base = base + " - " + genderLabel;
        }

        return base;
    }

    private String findCategoryName(List<Category> list, int id, String fallback) {
        if (list != null) {
            for (Category c : list) {
                if (c.getId() == id) return c.getName();
            }
        }
        return fallback;
    }

    private String findBrandName(List<Brand> list, int id, String fallback) {
        if (list != null) {
            for (Brand b : list) {
                if (b.getId() == id) return b.getName();
            }
        }
        return fallback;
    }

    private Integer tryParseInt(String s) {
        try { return Integer.parseInt(s); } catch (Exception e) { return null; }
    }

    private String toGenderLabel(String g) {
        if (g == null) return null;
        switch (g.toLowerCase()) {
            case "men": return "Giày nam";
            case "women": return "Giày nữ";
            case "unisex": return "Unisex";
            default: return null;
        }
    }

    private String normalizeGender(String genderParam) {
        if (genderParam == null) return null;
        String g = genderParam.trim().toLowerCase();
        if (g.isEmpty()) return null;

        if (g.equals("m") || g.equals("male")) return "men";
        if (g.equals("f") || g.equals("female")) return "women";

        if (g.equals("men") || g.equals("women") || g.equals("unisex")) return g;
        return null;
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
