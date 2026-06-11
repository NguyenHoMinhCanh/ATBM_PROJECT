<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
    request.setAttribute("pageTitle", "Thêm/Sửa Chính sách - Admin");
    request.setAttribute("activePage", "policies");
%>

<%@ include file="/admin/includes/_admin_layout_open.jspf" %>

<style>
    .policy-form-card {
        border: none;
        border-radius: 16px;
        box-shadow: 0 2px 16px rgba(0,0,0,0.08);
    }
    .policy-type-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
        gap: 10px;
    }
    .policy-type-option {
        display: none;
    }
    .policy-type-label {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 6px;
        padding: 14px 10px;
        border: 2px solid #e8eaed;
        border-radius: 12px;
        cursor: pointer;
        transition: all 0.2s;
        text-align: center;
        font-size: 12px;
        color: #555;
        background: #fafbfc;
    }
    .policy-type-label .type-icon {
        font-size: 22px;
        line-height: 1;
    }
    .policy-type-label:hover {
        border-color: #ee4d2d;
        background: #fff3f0;
        color: #ee4d2d;
    }
    .policy-type-option:checked + .policy-type-label {
        border-color: #ee4d2d;
        background: #fff3f0;
        color: #ee4d2d;
        font-weight: 600;
        box-shadow: 0 0 0 3px rgba(238,77,45,0.15);
    }

    .tox-tinymce { border-radius: 10px !important; border-color: #dee2e6 !important; }

    .slug-preview {
        font-family: 'Courier New', monospace;
        font-size: 12px;
        background: #f8f9fa;
        padding: 6px 10px;
        border-radius: 6px;
        color: #666;
        border: 1px solid #e8eaed;
        margin-top: 4px;
        word-break: break-all;
    }

    .active-toggle {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 14px 18px;
        border: 2px solid #e8eaed;
        border-radius: 12px;
        cursor: pointer;
        transition: all 0.2s;
        background: #fafbfc;
    }
    .active-toggle.active-on {
        border-color: #22c55e;
        background: #f0fdf4;
    }
    .form-switch .form-check-input {
        width: 44px;
        height: 22px;
    }

    .form-section-title {
        font-size: 12px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: #5f6368;
        margin-bottom: 12px;
        padding-bottom: 8px;
        border-bottom: 1px solid #f0f0f0;
    }

    .error-alert {
        border-radius: 10px;
        border: none;
        background: #fff5f5;
        color: #dc3545;
        border-left: 4px solid #dc3545;
        padding: 12px 16px;
    }
    .success-alert {
        border-radius: 10px;
        border: none;
        background: #f0fdf4;
        color: #166534;
        border-left: 4px solid #22c55e;
        padding: 12px 16px;
    }
</style>

<div class="container-fluid py-3">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-1">${pageTitle}</h2>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0" style="font-size:13px;">
                    <li class="breadcrumb-item"><a href="${ctx}/admin/policies" class="text-decoration-none text-muted">Chính sách</a></li>
                    <li class="breadcrumb-item active">${policy != null ? 'Chỉnh sửa' : 'Thêm mới'}</li>
                </ol>
            </nav>
        </div>
        <a href="${ctx}/admin/policies" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="error-alert mb-3">
            <i class="bi bi-exclamation-circle me-2"></i> ${error}
        </div>
    </c:if>

    <form method="post" action="${ctx}/admin/policies" id="policyForm">
        <input type="hidden" name="action" value="${policy != null ? 'update' : 'create'}">
        <c:if test="${policy != null}">
            <input type="hidden" name="id" value="${policy.id}">
        </c:if>
        <!-- Hidden textarea that will be submitted (TinyMCE will sync to this) -->
        <textarea name="content" id="contentHidden" style="display:none;">${policy != null ? policy.content : ''}</textarea>

        <div class="row g-4">
            <!-- Left Column: Main content -->
            <div class="col-lg-8">
                <div class="card policy-form-card mb-4">
                    <div class="card-body p-4">
                        <div class="form-section-title">Thông tin cơ bản</div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Tiêu đề <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-lg" name="title" id="titleInput"
                                   value="${policy != null ? policy.title : ''}"
                                   placeholder="Nhập tiêu đề chính sách..." required
                                   style="border-radius:10px; font-size:15px;">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold d-flex justify-content-between">
                                <span>Nội dung</span>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="toggleEditorMode()" id="btnToggleMode">
                                        <i class="bi bi-code-slash me-1"></i>HTML thô
                                    </button>
                                </div>
                            </label>
                            <!-- TinyMCE editor container -->
                            <div id="editorWrap">
                                <!-- TinyMCE will replace this textarea -->
                                <textarea id="tinyTarget" name="_tinyContent" style="width:100%; min-height:420px;"><c:out value="${policy != null ? policy.content : ''}" escapeXml="true"/></textarea>
                            </div>
                            <!-- Raw HTML mode textarea (hidden by default) -->
                            <textarea id="contentEditor" style="min-height:420px; width:100%; border-radius:10px; padding:12px; border:1px solid #dee2e6; font-family:'Courier New',monospace; font-size:13px; line-height:1.6; resize:vertical; display:none;"><c:out value="${policy != null ? policy.content : ''}" escapeXml="true"/></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Settings -->
            <div class="col-lg-4">
                <!-- Publish settings -->
                <div class="card policy-form-card mb-4">
                    <div class="card-body p-4">
                        <div class="form-section-title">Xuất bản</div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Trạng thái hiển thị</label>
                            <div class="active-toggle ${policy == null || policy.active ? 'active-on' : ''}" id="activeToggleWrap">
                                <div class="form-check form-switch mb-0">
                                    <input class="form-check-input" type="checkbox" role="switch"
                                           id="activeSwitch" name="active"
                                           ${policy == null || policy.active ? 'checked' : ''}
                                           onchange="updateActiveStyle()">
                                </div>
                                <div>
                                    <div class="fw-semibold" id="activeLabel">${policy == null || policy.active ? 'Hiển thị trên shop' : 'Đang ẩn'}</div>
                                    <div class="text-muted" style="font-size:12px;" id="activeDesc">${policy == null || policy.active ? 'Khách hàng có thể xem chính sách này' : 'Chính sách chưa được công khai'}</div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Thứ tự hiển thị</label>
                            <input type="number" class="form-control" name="displayOrder"
                                   value="${policy != null ? policy.displayOrder : 0}" min="0"
                                   style="border-radius:10px;">
                            <div class="form-text"><i class="bi bi-info-circle me-1"></i>Số nhỏ hiển thị trước trong footer</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Slug (URL)</label>
                            <input type="text" class="form-control" name="slug" id="slugInput"
                                   value="${policy != null ? policy.slug : ''}"
                                   placeholder="tu-dong-tao-tu-tieu-de"
                                   style="border-radius:10px; font-family:monospace; font-size:13px;">
                            <div class="slug-preview" id="slugPreview">
                                URL: /policy/<span id="slugDisplay">${policy != null ? policy.slug : 'slug-se-hien-o-day'}</span>
                            </div>
                        </div>

                        <div class="d-grid gap-2 mt-4">
                            <button class="btn btn-danger btn-lg" type="submit" style="border-radius:10px;">
                                <i class="bi bi-save me-2"></i>${policy != null ? 'Cập nhật chính sách' : 'Lưu chính sách'}
                            </button>
                            <a href="${ctx}/admin/policies" class="btn btn-outline-secondary" style="border-radius:10px;">Hủy bỏ</a>
                        </div>

                        <c:if test="${policy != null}">
                            <div class="mt-3 pt-3 border-top">
                                <a href="${ctx}/policy?slug=${policy.slug}" target="_blank" class="btn btn-sm btn-outline-secondary w-100" style="border-radius:8px;">
                                    <i class="bi bi-box-arrow-up-right me-1"></i> Xem trên shop
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Policy Type -->
                <div class="card policy-form-card">
                    <div class="card-body p-4">
                        <div class="form-section-title">Phân loại chính sách</div>
                        <div class="policy-type-grid">
                            <%
                                com.japansport.model.Policy __pol = (com.japansport.model.Policy) request.getAttribute("policy");
                                String __currentType = (__pol != null && __pol.getPolicyType() != null) ? __pol.getPolicyType() : "GENERAL";
                                String[][] types = {
                                    {"GENERAL",    "📋", "Chung"},
                                    {"TERMS",      "📜", "Điều khoản"},
                                    {"PRIVACY",    "🔒", "Bảo mật"},
                                    {"SHIPPING",   "🚚", "Vận chuyển"},
                                    {"RETURN",     "↩️", "Đổi trả"},
                                    {"PAYMENT",    "💳", "Thanh toán"},
                                    {"ORDER_GUIDE","📦", "Đặt hàng"},
                                    {"SUPPORT",    "🎧", "Hỗ trợ"},
                                };
                            %>
                            <% for (String[] t : types) { %>
                            <div>
                                <input type="radio" class="policy-type-option" name="policyType"
                                       id="type_<%= t[0] %>" value="<%= t[0] %>"
                                       <%= __currentType.equals(t[0]) ? "checked" : "" %>>
                                <label class="policy-type-label w-100" for="type_<%= t[0] %>">
                                    <span class="type-icon"><%= t[1] %></span>
                                    <span><%= t[2] %></span>
                                </label>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- TinyMCE CDN -->
<script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
<script>
    var useRawMode = false;

    // Init TinyMCE targeting the #tinyTarget textarea
    tinymce.init({
        selector: '#tinyTarget',
        plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount code fullscreen preview',
        toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat | code fullscreen preview',
        height: 440,
        menubar: false,
        branding: false,
        content_style: 'body { font-family: Inter, system-ui, sans-serif; font-size: 14px; line-height: 1.7; color: #333; }',
        skin: 'oxide',
        setup: function(editor) {
            editor.on('change keyup', function() {
                document.getElementById('contentHidden').value = editor.getContent();
            });
        },
        init_instance_callback: function(editor) {
            document.getElementById('contentHidden').value = editor.getContent();
        }
    });

    // Toggle raw HTML mode
    function toggleEditorMode() {
        useRawMode = !useRawMode;
        var btn = document.getElementById('btnToggleMode');
        var rawTextarea = document.getElementById('contentEditor');
        var editorWrap = document.getElementById('editorWrap');

        if (useRawMode) {
            var ed = tinymce.get('tinyTarget');
            var content = ed ? ed.getContent() : document.getElementById('contentHidden').value;
            rawTextarea.value = content;
            rawTextarea.style.display = 'block';
            editorWrap.style.display = 'none';
            if (ed) tinymce.remove('#tinyTarget');
            btn.innerHTML = '<i class="bi bi-pencil-square me-1"></i>Editor';
            btn.classList.remove('btn-outline-secondary');
            btn.classList.add('btn-outline-danger');
        } else {
            var rawContent = rawTextarea.value;
            rawTextarea.style.display = 'none';
            editorWrap.style.display = 'block';
            document.getElementById('contentHidden').value = rawContent;
            tinymce.init({
                selector: '#tinyTarget',
                height: 440,
                menubar: false,
                plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount code fullscreen preview',
                toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat | code fullscreen preview',
                content_style: 'body { font-family: Inter, system-ui, sans-serif; font-size: 14px; line-height: 1.7; color: #333; }',
                branding: false,
                setup: function(editor) {
                    editor.on('init', function() { editor.setContent(rawContent); });
                    editor.on('change keyup', function() {
                        document.getElementById('contentHidden').value = editor.getContent();
                    });
                }
            });
            btn.innerHTML = '<i class="bi bi-code-slash me-1"></i>HTML thô';
            btn.classList.remove('btn-outline-danger');
            btn.classList.add('btn-outline-secondary');
        }
    }

    // Submit handler - sync TinyMCE content to hidden field before submit
    document.getElementById('policyForm').addEventListener('submit', function() {
        var ed = tinymce.get('tinyTarget');
        if (ed) {
            document.getElementById('contentHidden').value = ed.getContent();
        } else if (useRawMode) {
            document.getElementById('contentHidden').value = document.getElementById('contentEditor').value;
        }
    });

    // Auto-slug from title
    var titleInput = document.getElementById('titleInput');
    var slugInput = document.getElementById('slugInput');
    var slugDisplay = document.getElementById('slugDisplay');

    titleInput.addEventListener('input', function() {
        if (slugInput.dataset.manual === 'true') return;
        var slug = slugify(this.value);
        slugInput.value = slug;
        slugDisplay.textContent = slug || 'slug-se-hien-o-day';
    });
    slugInput.addEventListener('input', function() {
        this.dataset.manual = 'true';
        var slug = slugify(this.value);
        this.value = slug;
        slugDisplay.textContent = slug || 'slug-se-hien-o-day';
    });

    function slugify(text) {
        // Simple JS slugify (Vietnamese to latin approximation for preview only)
        return text.toLowerCase()
            .replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, 'a')
            .replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, 'e')
            .replace(/ì|í|ị|ỉ|ĩ/g, 'i')
            .replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, 'o')
            .replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, 'u')
            .replace(/ỳ|ý|ỵ|ỷ|ỹ/g, 'y')
            .replace(/đ/g, 'd')
            .replace(/[^a-z0-9\s-]/g, '')
            .replace(/\s+/g, '-')
            .replace(/-+/g, '-')
            .replace(/^-|-$/g, '');
    }

    // Active toggle style
    function updateActiveStyle() {
        var sw = document.getElementById('activeSwitch');
        var wrap = document.getElementById('activeToggleWrap');
        var label = document.getElementById('activeLabel');
        var desc = document.getElementById('activeDesc');
        if (sw.checked) {
            wrap.classList.add('active-on');
            label.textContent = 'Hiển thị trên shop';
            desc.textContent = 'Khách hàng có thể xem chính sách này';
        } else {
            wrap.classList.remove('active-on');
            label.textContent = 'Đang ẩn';
            desc.textContent = 'Chính sách chưa được công khai';
        }
    }
</script>

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
