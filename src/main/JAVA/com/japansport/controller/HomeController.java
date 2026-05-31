package com.japansport.controller;

import com.japansport.dao.BrandDao;
import com.japansport.dao.CategoryDao;
import com.japansport.dao.BannerDao;
import com.japansport.dao.ProductDao;
import com.japansport.dao.ReviewDao;
import com.japansport.model.Banner;
import com.japansport.model.Brand;
import com.japansport.model.Category;
import com.japansport.model.Product;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "HomeController", value = "/home")
public class HomeController extends HttpServlet {

    private ProductDao productDao;
    private BannerDao bannerDao;
    private CategoryDao categoryDao;
    private BrandDao brandDao;
    private ReviewDao reviewDao;

    @Override
    public void init() throws ServletException {
        productDao = new ProductDao();
        bannerDao  = new BannerDao();
        categoryDao = new CategoryDao();
        brandDao   = new BrandDao();
        reviewDao  = new ReviewDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Product> productList       = productDao.getLatest(12);
            List<Product> bestSellerProducts = productDao.getBestSellers(12);
            List<Product> menProducts        = productDao.getByGender("M", 8);
            List<Product> womenProducts      = productDao.getByGender("F", 8);

            // Gom toàn bộ productId cần lấy rating — 1 query duy nhất (batch)
            List<Integer> allIds = new ArrayList<>();
            for (Product p : productList)       allIds.add(p.getId());
            for (Product p : bestSellerProducts) allIds.add(p.getId());
            for (Product p : menProducts)        allIds.add(p.getId());
            for (Product p : womenProducts)      allIds.add(p.getId());
            allIds = allIds.stream().distinct().collect(Collectors.toList());

            // Map<productId, [avgRating, reviewCount]>
            Map<Integer, double[]> ratingMap = reviewDao.getAvgRatingBatch(allIds);

            // Banners
            List<Banner> topBanners       = bannerDao.getBannersByPosition("HOME_TOP");
            Banner menBanner              = bannerDao.getOneBannerByPosition("HOME_MEN");
            Banner womenRightBanner       = bannerDao.getOneBannerByPosition("HOME_WOMEN_RIGHT");
            Banner womenBottomBanner      = bannerDao.getOneBannerByPosition("HOME_WOMEN_BOTTOM");

            // Danh mục nổi bật (mở rộng lên 6 để hiển thị grid đẹp)
            List<Category> featuredCategories = categoryDao.getFeaturedCategories(6);

            List<Brand> brands = brandDao.getAllActive();

            // Bind vào request
            request.setAttribute("productList",        productList);
            request.setAttribute("bestSellerProducts", bestSellerProducts);
            request.setAttribute("menProducts",        menProducts);
            request.setAttribute("womenProducts",      womenProducts);
            request.setAttribute("ratingMap",          ratingMap);

            request.setAttribute("topBanners",         topBanners);
            request.setAttribute("menBanner",          menBanner);
            request.setAttribute("womenRightBanner",   womenRightBanner);
            request.setAttribute("womenBottomBanner",  womenBottomBanner);

            request.setAttribute("featuredCategories", featuredCategories);
            request.setAttribute("brands",             brands);

            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Lỗi truy xuất dữ liệu trang chủ");
        }
    }
}
