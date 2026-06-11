package com.japansport.filter;

import com.japansport.dao.VoucherDao;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * Scheduler tự động deactivate các voucher đã hết hạn.
 * Chạy mỗi 1 phút kể từ khi ứng dụng khởi động.
 */
@WebListener
public class VoucherExpiryScheduler implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor(r -> {
            Thread t = new Thread(r, "voucher-expiry-scheduler");
            t.setDaemon(true); // Không ngăn JVM shutdown
            return t;
        });

        // Chạy ngay lập tức, sau đó lặp mỗi 1 phút
        scheduler.scheduleAtFixedRate(() -> {
            try {
                VoucherDao dao = new VoucherDao();
                dao.deactivateExpiredVouchers();
            } catch (Exception e) {
                System.err.println("[VoucherExpiryScheduler] Lỗi khi kiểm tra voucher hết hạn: " + e.getMessage());
            }
        }, 0, 1, TimeUnit.MINUTES);

        System.out.println("[VoucherExpiryScheduler] Đã khởi động – kiểm tra voucher hết hạn mỗi 1 phút.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdownNow();
            System.out.println("[VoucherExpiryScheduler] Đã dừng scheduler.");
        }
    }
}
