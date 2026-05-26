(() => {
    "use strict";

    // ===== Helpers =====
    const $ = (sel, root = document) => root.querySelector(sel);
    const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));

    const escapeHtml = (s) =>
        String(s ?? "")
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");

    const maskName = (name) => {
        const n = String(name ?? "").trim();
        if (!n) return "Ẩn danh";
        if (n.length <= 2) return n[0] + "*";
        return n.slice(0, 3) + "***";
    };

    const formatDate = (v) => {
        if (!v) return "";
        // hỗ trợ "2025-12-11 23:45:59" hoặc ISO
        const s = String(v).replace(" ", "T");
        const d = new Date(s);
        if (isNaN(d.getTime())) return String(v);
        const pad = (x) => String(x).padStart(2, "0");
        return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(
            d.getHours()
        )}:${pad(d.getMinutes())}`;
    };

    const starIcons = (rating) => {
        const r = Math.max(0, Math.min(5, Number(rating || 0)));
        let html = "";
        for (let i = 1; i <= 5; i++) {
            html += i <= r ? "★" : "☆";
        }
        return html;
    };

    // Render Bootstrap star icons (bi-star / bi-star-fill)
    function renderBsStars(rating) {
        const rounded = Math.round(Number(rating || 0));
        let html = "";
        for (let i = 1; i <= 5; i++) {
            html += i <= rounded
                ? '<i class="bi bi-star-fill"></i> '
                : '<i class="bi bi-star"></i> ';
        }
        return html;
    }

    // ===== Normalize API Response =====
    // Chấp nhận nhiều format:
    // 1) Array reviews
    // 2) {reviews:[], total, stats}
    // 3) {data:[], meta:{...}}
    // 4) {items:[]}
    function normalizeResponse(json) {
        if (Array.isArray(json)) {
            return { reviews: json, total: json.length, stats: null, viewer: null, page: null };
        }

        if (json && Array.isArray(json.reviews)) {
            return {
                reviews: json.reviews,
                total: json.total ?? json.reviews.length,
                stats: json.stats ?? null,
                viewer: json.viewer ?? null,
                page: json.page ?? null,
            };
        }

        if (json && Array.isArray(json.data)) {
            return {
                reviews: json.data,
                total: json.total ?? json.data.length,
                stats: json.stats ?? json.meta?.stats ?? null,
                viewer: json.viewer ?? null,
                page: json.page ?? null,
            };
        }

        if (json && Array.isArray(json.items)) {
            return { reviews: json.items, total: json.total ?? json.items.length, stats: json.stats ?? null, viewer: json.viewer ?? null, page: json.page ?? null };
        }

        return { reviews: [], total: 0, stats: null, viewer: null, page: null };
    }

    function computeStats(reviews) {
        const counts = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 };
        let sum = 0;

        for (const r of reviews) {
            const rating = Number(r.rating ?? r.stars ?? 0);
            if (rating >= 1 && rating <= 5) counts[rating] += 1;
            sum += rating;
        }

        const total = reviews.length;
        const avg = total ? sum / total : 0;

        return { avg, total, counts };
    }

    function renderStats(stats) {
        const avgEl = $("#rvAvg");
        const countTextEl = $("#rvCountText");
        const avgStarsEl = $("#rvAvgStars");
        const topAvgStarsEl = $("#topAvgStars");
        const topReviewCountEl = $("#topReviewCount");

        const avg = Number(stats?.avg ?? 0);
        const total = Number(stats?.total ?? stats?.count ?? 0);
        const counts = stats?.counts ?? { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 };

        if (avgEl) avgEl.textContent = avg.toFixed(1);
        if (countTextEl) countTextEl.textContent = `${total} đánh giá`;
        if (avgStarsEl) avgStarsEl.textContent = starIcons(Math.round(avg));

        // Đồng bộ stars ở phần header sản phẩm
        if (topReviewCountEl) topReviewCountEl.textContent = `(${total} đánh giá)`;
        if (topAvgStarsEl) topAvgStarsEl.innerHTML = renderBsStars(avg);

        for (let i = 1; i <= 5; i++) {
            const cntEl = $(`#rvCnt${i}`);
            const barEl = $(`#rvBar${i}`);
            const c = Number(counts[i] ?? 0);
            if (cntEl) cntEl.textContent = c;

            if (barEl) {
                const percent = total ? (c / total) * 100 : 0;
                barEl.style.width = `${percent}%`;
                barEl.setAttribute("aria-valuenow", String(percent));
            }
        }
    }

    function renderList(reviews) {
        const listEl = $("#rvList");
        if (!listEl) return;

        if (!reviews || reviews.length === 0) {
            listEl.innerHTML = `<div class="text-muted py-3">Chưa có đánh giá nào.</div>`;
            return;
        }

        const html = reviews
            .map((r) => {
                const name =
                    r.userName ?? r.username ?? r.fullName ?? r.name ?? r.user_name ?? "Ẩn danh";
                const rating = Number(r.rating ?? r.stars ?? 0);
                const comment = r.comment ?? r.content ?? "";
                const created = r.createdAt ?? r.created_at ?? r.created ?? "";
                const status = r.status ?? "";

                // Nếu review đang pending thì hiện badge "Chờ duyệt"
                let statusBadge = "";
                if (status === "pending") {
                    statusBadge = `<span class="badge bg-warning text-dark ms-2">Chờ duyệt</span>`;
                }

                return `
          <div class="border rounded-3 p-3 mb-3">
            <div class="d-flex justify-content-between align-items-start gap-3">
              <div>
                <div class="fw-bold">${escapeHtml(maskName(name))}${statusBadge}</div>
                <div class="text-muted small">${escapeHtml(formatDate(created))}</div>
              </div>
              <div class="text-end" style="color:#f5a623; font-size:18px; line-height:1;">
                ${starIcons(rating)}
                <div class="text-muted small" style="color:#6c757d;">${rating}/5</div>
              </div>
            </div>
            <div class="mt-2">${escapeHtml(comment)}</div>
          </div>
        `;
            })
            .join("");

        listEl.innerHTML = html;
    }

    // ===== Xử lý hiển thị form review dựa trên trạng thái đăng nhập =====
    function handleReviewFormVisibility(viewer, section) {
        const noticeEl = $("#rvWriteNotice");
        const formEl = $("#rvForm");
        if (!noticeEl || !formEl) return;

        const loginUrl = (section?.dataset?.loginUrl) || (window.location.pathname.replace(/\/[^/]*$/, '/login'));
        const backUrl = encodeURIComponent(window.location.pathname + window.location.search);

        // Ưu tiên dữ liệu từ API (nếu có viewer object)
        if (viewer) {
            if (!viewer.loggedIn) {
                noticeEl.innerHTML = `<div class="alert alert-info mb-0">
                    <i class="bi bi-info-circle me-1"></i>
                    Vui lòng <a href="${loginUrl}?back=${backUrl}" class="fw-bold">đăng nhập</a> để viết đánh giá.
                </div>`;
                formEl.classList.add("d-none");
                return;
            }

            if (!viewer.canReview) {
                noticeEl.innerHTML = `<div class="alert alert-warning mb-0">
                    <i class="bi bi-exclamation-triangle me-1"></i>
                    Bạn cần mua sản phẩm này trước khi đánh giá.
                </div>`;
                formEl.classList.add("d-none");
                return;
            }

            // Đã đăng nhập và được phép đánh giá
            noticeEl.innerHTML = "";
            formEl.classList.remove("d-none");
            return;
        }

        // Fallback: dùng data-logged-in từ JSP
        const isLoggedIn = section?.dataset?.loggedIn === "1";
        if (!isLoggedIn) {
            noticeEl.innerHTML = `<div class="alert alert-info mb-0">
                <i class="bi bi-info-circle me-1"></i>
                Vui lòng <a href="${loginUrl}?back=${backUrl}" class="fw-bold">đăng nhập</a> để viết đánh giá.
            </div>`;
            formEl.classList.add("d-none");
        } else {
            noticeEl.innerHTML = "";
            formEl.classList.remove("d-none");
        }
    }

    // ===== Pagination =====
    function renderPagination(pageInfo, onPageClick) {
        const pagerEl = $("#rvPager");
        if (!pagerEl || !pageInfo) return;

        const { page, totalPages } = pageInfo;
        if (!totalPages || totalPages <= 1) {
            pagerEl.innerHTML = "";
            return;
        }

        let html = "";
        // Nút Previous
        html += `<li class="page-item ${page <= 1 ? 'disabled' : ''}">
            <a class="page-link" href="#" data-pg="${page - 1}">&laquo;</a></li>`;

        // Các trang
        const maxVisible = 5;
        let startPg = Math.max(1, page - Math.floor(maxVisible / 2));
        let endPg = Math.min(totalPages, startPg + maxVisible - 1);
        startPg = Math.max(1, endPg - maxVisible + 1);

        for (let i = startPg; i <= endPg; i++) {
            html += `<li class="page-item ${i === page ? 'active' : ''}">
                <a class="page-link" href="#" data-pg="${i}">${i}</a></li>`;
        }

        // Nút Next
        html += `<li class="page-item ${page >= totalPages ? 'disabled' : ''}">
            <a class="page-link" href="#" data-pg="${page + 1}">&raquo;</a></li>`;

        pagerEl.innerHTML = html;

        // Event
        pagerEl.addEventListener("click", (e) => {
            e.preventDefault();
            const link = e.target.closest("[data-pg]");
            if (!link) return;
            const pg = Number(link.dataset.pg);
            if (pg >= 1 && pg <= totalPages && pg !== page) {
                onPageClick(pg);
            }
        });
    }

    // ===== Star Rating Picker =====
    function initStarPicker() {
        const pickStars = $("#rvPickStars");
        const ratingInput = $("#rvRatingInput");
        if (!pickStars || !ratingInput) return;

        const stars = $$("i", pickStars);

        function setRatingUI(rating) {
            ratingInput.value = rating;
            stars.forEach((star, idx) => {
                if (idx < rating) {
                    star.classList.remove("bi-star");
                    star.classList.add("bi-star-fill");
                } else {
                    star.classList.remove("bi-star-fill");
                    star.classList.add("bi-star");
                }
            });
        }

        // Click chọn sao
        pickStars.addEventListener("click", (e) => {
            const star = e.target.closest("i[data-value]");
            if (!star) return;
            setRatingUI(parseInt(star.dataset.value));
        });

        // Hover preview
        pickStars.addEventListener("mouseover", (e) => {
            const star = e.target.closest("i[data-value]");
            if (!star) return;
            const hoverVal = parseInt(star.dataset.value);
            stars.forEach((s, idx) => {
                if (idx < hoverVal) {
                    s.classList.remove("bi-star");
                    s.classList.add("bi-star-fill");
                } else {
                    s.classList.remove("bi-star-fill");
                    s.classList.add("bi-star");
                }
            });
        });

        pickStars.addEventListener("mouseleave", () => {
            // Trở lại đúng giá trị đã chọn
            setRatingUI(parseInt(ratingInput.value) || 5);
        });

        // Khởi tạo mặc định 5 sao
        setRatingUI(5);
    }

    // ===== Main =====
    document.addEventListener("DOMContentLoaded", async () => {
        const section = document.getElementById("reviewSection");
        if (!section) return;

        const productId =
            section.dataset.productId || new URLSearchParams(location.search).get("id");
        const apiUrl = section.dataset.api; // vd: /demo/api/reviews
        const submitUrl = section.dataset.submitApi; // vd: /demo/api/reviews/add
        if (!apiUrl || !productId) {
            console.warn("Missing data-api or productId for reviews");
            return;
        }

        const sortEl = document.getElementById("rvSort");
        const filterWrap = document.getElementById("rvFilters");

        const state = {
            rating: 0, // 0 = all
            sort: sortEl ? sortEl.value : "newest",
            page: 1,
        };

        const setLoading = (on) => {
            const loadingEl = document.getElementById("rvLoading");
            if (loadingEl) loadingEl.style.display = on ? "block" : "none";
        };

        const setError = (msg) => {
            const errEl = document.getElementById("rvError");
            if (!errEl) return;
            if (!msg) {
                errEl.style.display = "none";
                errEl.textContent = "";
            } else {
                errEl.style.display = "block";
                errEl.textContent = msg;
            }
        };

        const buildUrl = () => {
            const u = new URL(apiUrl, window.location.origin);
            u.searchParams.set("productId", productId);

            if (state.rating && Number(state.rating) > 0) {
                u.searchParams.set("rating", String(state.rating));
            }
            if (state.sort) {
                u.searchParams.set("sort", state.sort);
            }
            if (state.page && state.page > 1) {
                u.searchParams.set("page", String(state.page));
            }
            return u.toString();
        };

        async function loadReviews() {
            setError("");
            setLoading(true);

            try {
                const res = await fetch(buildUrl(), {
                    headers: { Accept: "application/json" },
                });

                if (!res.ok) throw new Error(`HTTP ${res.status}`);

                const json = await res.json();
                const norm = normalizeResponse(json);

                // Nếu API trả cả stats thì ưu tiên, không thì tự tính
                const stats = norm.stats
                    ? {
                        avg: Number(norm.stats.avg ?? norm.stats.average ?? 0),
                        total: Number(norm.stats.total ?? norm.stats.count ?? norm.total ?? norm.reviews.length),
                        counts:
                            norm.stats.counts ??
                            norm.stats.breakdown ??
                            norm.stats.byStar ??
                            computeStats(norm.reviews).counts,
                    }
                    : computeStats(norm.reviews);

                renderStats(stats);
                renderList(norm.reviews);

                // Hiển thị/ẩn form review dựa vào viewer info từ API
                handleReviewFormVisibility(norm.viewer, section);

                // Pagination
                if (norm.page) {
                    renderPagination(norm.page, (pg) => {
                        state.page = pg;
                        loadReviews();
                        // Scroll lên phần đánh giá
                        section.scrollIntoView({ behavior: "smooth", block: "start" });
                    });
                }
            } catch (e) {
                console.error(e);
                renderStats({ avg: 0, total: 0, counts: { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 } });
                renderList([]);
                setError(`Không tải được đánh giá. (${e.message})`);
                // Fallback hiển thị form dựa data attribute
                handleReviewFormVisibility(null, section);
            } finally {
                setLoading(false);
            }
        }

        // Filter buttons: bắt theo data-rating
        if (filterWrap) {
            filterWrap.addEventListener("click", (ev) => {
                const btn = ev.target.closest("[data-rating]");
                if (!btn) return;

                state.rating = Number(btn.dataset.rating || 0);
                state.page = 1; // Reset về trang 1 khi lọc

                // Active UI
                $$("#rvFilters [data-rating]").forEach((b) => b.classList.remove("active"));
                btn.classList.add("active");

                loadReviews();
            });
        }

        // Sort dropdown
        if (sortEl) {
            sortEl.addEventListener("change", () => {
                state.sort = sortEl.value;
                state.page = 1;
                loadReviews();
            });
        }

        // Star rating picker
        initStarPicker();

        // Submit review form
        const rvForm = $("#rvForm");
        if (rvForm && submitUrl) {
            rvForm.addEventListener("submit", async (e) => {
                e.preventDefault();
                const msgEl = $("#rvFormMsg");
                const submitBtn = rvForm.querySelector('button[type="submit"]');

                const formData = new FormData(rvForm);
                const rating = Number(formData.get("rating"));
                const comment = (formData.get("comment") || "").trim();

                // Validate phía client
                if (rating < 1 || rating > 5) {
                    if (msgEl) msgEl.innerHTML = `<div class="text-danger small">Vui lòng chọn số sao (1-5).</div>`;
                    return;
                }
                if (comment.length < 5) {
                    if (msgEl) msgEl.innerHTML = `<div class="text-danger small">Nội dung đánh giá tối thiểu 5 ký tự.</div>`;
                    return;
                }

                // Vô hiệu hóa nút khi đang gửi
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Đang gửi...';
                }

                try {
                    const res = await fetch(submitUrl, {
                        method: "POST",
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: new URLSearchParams(formData).toString(),
                    });

                    const json = await res.json();

                    if (json.ok) {
                        if (msgEl) msgEl.innerHTML = `<div class="text-success small"><i class="bi bi-check-circle me-1"></i>${escapeHtml(json.message)}</div>`;
                        rvForm.reset();
                        initStarPicker(); // Reset lại giao diện sao
                        // Tải lại reviews sau 1.5 giây
                        setTimeout(() => loadReviews(), 1500);
                    } else {
                        if (msgEl) msgEl.innerHTML = `<div class="text-danger small"><i class="bi bi-x-circle me-1"></i>${escapeHtml(json.message)}</div>`;
                    }
                } catch (err) {
                    if (msgEl) msgEl.innerHTML = `<div class="text-danger small">Lỗi kết nối. Vui lòng thử lại.</div>`;
                } finally {
                    if (submitBtn) {
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = 'Gửi đánh giá';
                    }
                }
            });
        }

        // First load
        loadReviews();
    });
})();
