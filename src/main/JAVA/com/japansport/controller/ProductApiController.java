package com.japansport.controller;

import com.japansport.dao.ProductDao;
import com.japansport.dao.ReviewDao;
import com.japansport.model.Product;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * API endpoint trả JSON cho trang danh sách sản phẩm.
 * Dùng bởi AJAX filter/sort/pagination phía client,
 * tránh full page reload khi user thay đổi bộ lọc.
 */
@WebServlet(name = "ProductApiController", value = "/api/products")
public class ProductApiController extends HttpServlet {

    private final ProductDao productDao = new ProductDao();
    private final ReviewDao reviewDao = new ReviewDao();

    private static final int PAGE_SIZE = 16;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");

        // Parse params (giống ProductListController)
        String keyword      = req.getParameter("keyword");
        String categoryIdP  = req.getParameter("categoryId");
        String sortParam     = req.getParameter("sort");
        String pageParam     = req.getParameter("page");
        String genderParam   = req.getParameter("gender");
        String saleParam     = req.getParameter("sale");
        String[] priceParams = req.getParameterValues("price");
        String[] brandParams = req.getParameterValues("brandId");

        int page = 1;
        try { page = Integer.parseInt(pageParam); } catch (Exception ignore) {}
        if (page < 1) page = 1;

        Integer categoryId = null;
        try { categoryId = Integer.parseInt(categoryIdP); } catch (Exception ignore) {}

        String gender = normalizeGender(genderParam);
        boolean saleOnly = "1".equals(saleParam) || "true".equalsIgnoreCase(saleParam);

        // Brand filter
        List<Integer> brandIds = new ArrayList<>();
        if (brandParams != null) {
            for (String s : brandParams) {
                try { brandIds.add(Integer.parseInt(s)); } catch (NumberFormatException ignore) {}
            }
        }

        // Price ranges
        List<ProductDao.PriceRange> priceRanges = parsePriceRanges(priceParams);

        String kw = (keyword != null && !keyword.trim().isEmpty()) ? keyword.trim() : null;

        // Query SQL
        int totalProducts = productDao.countSearchAndFilterProducts(categoryId, kw, brandIds, priceRanges, gender, saleOnly);
        int totalPages = 0;
        List<Product> products = new ArrayList<>();

        if (totalProducts > 0) {
            totalPages = (int) Math.ceil(totalProducts * 1.0 / PAGE_SIZE);
            if (page > totalPages) page = totalPages;
            int offset = (page - 1) * PAGE_SIZE;
            products = productDao.searchAndFilterProducts(categoryId, kw, brandIds, priceRanges, gender, saleOnly, sortParam, offset, PAGE_SIZE);
        }

        // Rating batch
        Map<Integer, double[]> ratingMap = null;
        if (!products.isEmpty()) {
            List<Integer> ids = products.stream().map(Product::getId).collect(Collectors.toList());
            ratingMap = reviewDao.getAvgRatingBatch(ids);
        }

        // Build JSON thủ công (không cần thư viện bên ngoài)
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"currentPage\":").append(page).append(",");
        json.append("\"totalPages\":").append(totalPages).append(",");
        json.append("\"totalProducts\":").append(totalProducts).append(",");
        json.append("\"products\":[");

        for (int i = 0; i < products.size(); i++) {
            Product p = products.get(i);
            if (i > 0) json.append(",");

            // Tính discount %
            int discountPct = 0;
            if (p.getOld_price() > 0 && p.getOld_price() > p.getPrice()) {
                discountPct = (int) Math.round((1 - p.getPrice() / p.getOld_price()) * 100);
            }

            // Rating
            double avgRating = 0;
            int reviewCount = 0;
            if (ratingMap != null) {
                double[] rd = ratingMap.get(p.getId());
                if (rd != null) { avgRating = rd[0]; reviewCount = (int) rd[1]; }
            }

            json.append("{");
            json.append("\"id\":").append(p.getId()).append(",");
            json.append("\"name\":").append(escapeJson(p.getName())).append(",");
            json.append("\"imageUrl\":").append(escapeJson(p.getImage_url())).append(",");
            json.append("\"price\":").append(p.getPrice()).append(",");
            json.append("\"oldPrice\":").append(p.getOld_price()).append(",");
            json.append("\"discountPct\":").append(discountPct).append(",");
            json.append("\"promotionLabel\":").append(p.getPromotionLabel() != null ? escapeJson(p.getPromotionLabel()) : "null").append(",");
            json.append("\"isSale\":").append(p.isSale()).append(",");
            json.append("\"avgRating\":").append(String.format("%.1f", avgRating)).append(",");
            json.append("\"reviewCount\":").append(reviewCount);
            json.append("}");
        }

        json.append("]}");

        PrintWriter out = resp.getWriter();
        out.print(json);
        out.flush();
    }

    // Escape JSON string
    private String escapeJson(String s) {
        if (s == null) return "null";
        return "\"" + s.replace("\\", "\\\\")
                       .replace("\"", "\\\"")
                       .replace("\n", "\\n")
                       .replace("\r", "\\r")
                       .replace("\t", "\\t") + "\"";
    }

    private String normalizeGender(String g) {
        if (g == null) return null;
        g = g.trim().toLowerCase();
        if (g.isEmpty()) return null;
        if ("m".equals(g) || "male".equals(g)) return "men";
        if ("f".equals(g) || "female".equals(g)) return "women";
        if ("men".equals(g) || "women".equals(g) || "unisex".equals(g)) return g;
        return null;
    }

    private List<ProductDao.PriceRange> parsePriceRanges(String[] priceParams) {
        List<ProductDao.PriceRange> ranges = new ArrayList<>();
        if (priceParams == null) return ranges;
        for (String range : priceParams) {
            if ("0-500".equals(range))        ranges.add(new ProductDao.PriceRange(0, 500_000));
            else if ("500-1000".equals(range)) ranges.add(new ProductDao.PriceRange(500_000, 1_000_000));
            else if ("1000-1500".equals(range)) ranges.add(new ProductDao.PriceRange(1_000_000, 1_500_000));
            else if ("1500-2000".equals(range)) ranges.add(new ProductDao.PriceRange(1_500_000, 2_000_000));
            else if ("2000-2500".equals(range)) ranges.add(new ProductDao.PriceRange(2_000_000, 2_500_000));
            else if ("2500-3000".equals(range)) ranges.add(new ProductDao.PriceRange(2_500_000, 3_000_000));
            else if ("3000+".equals(range))    ranges.add(new ProductDao.PriceRange(3_000_000, Double.MAX_VALUE));
            else if (range.contains("-")) {
                try {
                    String[] parts = range.split("-", 2);
                    ranges.add(new ProductDao.PriceRange(Double.parseDouble(parts[0]), Double.parseDouble(parts[1])));
                } catch (NumberFormatException ignore) {}
            }
        }
        return ranges;
    }
}
