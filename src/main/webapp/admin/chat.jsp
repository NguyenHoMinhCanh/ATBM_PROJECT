<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
    request.setAttribute("pageTitle", "Chat CSKH - Admin");
    request.setAttribute("activePage", "chat");
%>

<%@ include file="/admin/includes/_admin_layout_open.jspf" %>

<style>
    /* ===== CHAT ADMIN WRAPPER ===== */
    .chat-admin-wrap {
        display: flex;
        height: calc(100vh - 130px);
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 4px 24px rgba(0,0,0,0.10);
        background: #fff;
        border: 1px solid #e8eaed;
    }

    /* ===== LEFT: User List ===== */
    .chat-user-list {
        width: 300px;
        min-width: 300px;
        border-right: 1px solid #e8eaed;
        overflow-y: auto;
        background: #fafbfc;
        display: flex;
        flex-direction: column;
    }
    .chat-user-list-header {
        padding: 16px 18px 12px;
        border-bottom: 1px solid #e8eaed;
        background: #fff;
        position: sticky;
        top: 0;
        z-index: 10;
    }
    .chat-user-list-header h6 {
        font-size: 13px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: #5f6368;
        margin: 0 0 10px;
    }
    .chat-search-input {
        width: 100%;
        padding: 7px 12px 7px 32px;
        border: 1px solid #e0e0e0;
        border-radius: 20px;
        font-size: 13px;
        background: #f1f3f4 url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' fill='%23999' viewBox='0 0 16 16'%3E%3Cpath d='M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.099zm-5.44 1.399a5.5 5.5 0 1 1 0-11 5.5 5.5 0 0 1 0 11z'/%3E%3C/svg%3E") no-repeat 10px center;
        outline: none;
        transition: border-color 0.2s, box-shadow 0.2s;
        color: #333;
    }
    .chat-search-input:focus {
        border-color: #ee4d2d;
        box-shadow: 0 0 0 3px rgba(238,77,45,0.12);
        background-color: #fff;
    }

    .chat-user-item {
        padding: 12px 18px;
        border-bottom: 1px solid #f0f0f0;
        cursor: pointer;
        transition: background 0.15s;
        position: relative;
        display: flex;
        gap: 12px;
        align-items: center;
    }
    .chat-user-item:hover { background-color: #f5f5f5; }
    .chat-user-item.active { background-color: #fff3f0; border-left: 3px solid #ee4d2d; }
    .chat-user-item.has-unread .u-name::after {
        content: '';
        display: inline-block;
        width: 8px; height: 8px;
        background: #ee4d2d;
        border-radius: 50%;
        margin-left: 6px;
        vertical-align: middle;
    }

    .chat-avatar {
        width: 42px; height: 42px;
        border-radius: 50%;
        background: linear-gradient(135deg, #ee4d2d, #ff7f5e);
        display: flex; align-items: center; justify-content: center;
        color: #fff;
        font-weight: 700;
        font-size: 16px;
        flex-shrink: 0;
        position: relative;
    }
    .chat-avatar .online-dot {
        position: absolute;
        bottom: 1px; right: 1px;
        width: 10px; height: 10px;
        background: #22c55e;
        border-radius: 50%;
        border: 2px solid #fff;
    }

    .chat-user-meta { flex: 1; min-width: 0; }
    .u-name {
        font-weight: 600;
        font-size: 14px;
        color: #1a1a1a;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .u-preview {
        font-size: 12px;
        color: #999;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .u-time {
        font-size: 11px;
        color: #bbb;
        flex-shrink: 0;
        align-self: flex-start;
        margin-top: 2px;
    }
    .unread-badge {
        background: #ee4d2d;
        color: #fff;
        font-size: 10px;
        font-weight: 700;
        border-radius: 10px;
        padding: 1px 6px;
        min-width: 18px;
        text-align: center;
        flex-shrink: 0;
    }

    /* ===== RIGHT: Chat Area ===== */
    .chat-main-area {
        flex: 1;
        display: flex;
        flex-direction: column;
        min-width: 0;
    }
    .chat-main-header {
        padding: 14px 20px;
        background: #fff;
        border-bottom: 1px solid #e8eaed;
        display: flex;
        align-items: center;
        gap: 12px;
        box-shadow: 0 1px 4px rgba(0,0,0,0.04);
    }
    .chat-main-header .chat-header-avatar {
        width: 38px; height: 38px;
        border-radius: 50%;
        background: linear-gradient(135deg, #ee4d2d, #ff7f5e);
        display: flex; align-items: center; justify-content: center;
        color: #fff; font-weight: 700; font-size: 15px;
        flex-shrink: 0;
    }
    .chat-header-info .name { font-weight: 700; font-size: 15px; color: #1a1a1a; }
    .chat-header-info .status { font-size: 12px; color: #22c55e; }
    .chat-header-actions { margin-left: auto; display: flex; gap: 8px; }
    .chat-header-actions .btn-icon {
        width: 34px; height: 34px;
        border-radius: 50%; border: none;
        background: #f1f3f4;
        color: #666;
        display: flex; align-items: center; justify-content: center;
        cursor: pointer;
        transition: background 0.15s, color 0.15s;
    }
    .chat-header-actions .btn-icon:hover { background: #fee8e3; color: #ee4d2d; }

    /* ===== Messages ===== */
    .chat-main-body {
        flex: 1;
        padding: 20px;
        overflow-y: auto;
        background: #f9f9fb;
        display: flex;
        flex-direction: column;
        gap: 4px;
    }
    .chat-date-divider {
        text-align: center;
        margin: 14px 0 8px;
    }
    .chat-date-divider span {
        background: #e8eaed;
        color: #666;
        font-size: 11px;
        border-radius: 10px;
        padding: 3px 12px;
    }
    .adm-msg-wrapper {
        display: flex;
        gap: 8px;
        align-items: flex-end;
        max-width: 72%;
    }
    .adm-msg-wrapper.from-admin { margin-left: auto; flex-direction: row-reverse; }
    .adm-msg-wrapper.from-user { margin-right: auto; }

    .msg-avatar-sm {
        width: 28px; height: 28px;
        border-radius: 50%;
        background: linear-gradient(135deg, #ee4d2d, #ff7f5e);
        display: flex; align-items: center; justify-content: center;
        color: #fff; font-size: 11px; font-weight: 700;
        flex-shrink: 0;
    }
    .msg-avatar-sm.user-av { background: linear-gradient(135deg, #4f46e5, #7c73e6); }

    .adm-msg {
        padding: 10px 14px;
        font-size: 14px;
        line-height: 1.5;
        word-break: break-word;
        position: relative;
    }
    .adm-msg-wrapper.from-user .adm-msg {
        background: #fff;
        border: 1px solid #e8eaed;
        border-radius: 18px 18px 18px 4px;
        color: #333;
        box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    }
    .adm-msg-wrapper.from-admin .adm-msg {
        background: linear-gradient(135deg, #ee4d2d, #ff6b47);
        color: #fff;
        border-radius: 18px 18px 4px 18px;
        box-shadow: 0 2px 8px rgba(238,77,45,0.25);
    }
    .msg-time-label {
        font-size: 10px;
        opacity: 0.6;
        display: block;
        margin-top: 3px;
        text-align: right;
    }
    .adm-msg-wrapper.from-user .msg-time-label { text-align: left; }

    /* ===== Footer / Input ===== */
    .chat-main-footer {
        padding: 12px 16px;
        border-top: 1px solid #e8eaed;
        background: #fff;
    }
    .chat-input-row {
        display: flex;
        align-items: center;
        gap: 8px;
        background: #f1f3f4;
        border-radius: 24px;
        padding: 6px 6px 6px 16px;
        border: 1px solid transparent;
        transition: border-color 0.2s, box-shadow 0.2s;
    }
    .chat-input-row:focus-within {
        border-color: #ee4d2d;
        box-shadow: 0 0 0 3px rgba(238,77,45,0.12);
        background: #fff;
    }
    .chat-input-row input {
        flex: 1;
        border: none;
        background: transparent;
        outline: none;
        font-size: 14px;
        color: #333;
        min-width: 0;
    }
    .chat-input-row input::placeholder { color: #aaa; }
    .btn-emoji, .btn-send {
        width: 36px; height: 36px;
        border-radius: 50%;
        border: none;
        cursor: pointer;
        display: flex; align-items: center; justify-content: center;
        flex-shrink: 0;
        transition: background 0.15s, transform 0.1s;
        font-size: 16px;
    }
    .btn-emoji { background: transparent; color: #aaa; }
    .btn-emoji:hover { background: #fee8e3; color: #ee4d2d; }
    .btn-send { background: #ee4d2d; color: #fff; }
    .btn-send:hover { background: #d73a1e; transform: scale(1.05); }
    .btn-send:disabled { background: #ccc; cursor: not-allowed; transform: none; }

    /* ===== Empty State ===== */
    .chat-empty-state {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100%;
        flex-direction: column;
        color: #aaa;
        gap: 12px;
        user-select: none;
    }
    .chat-empty-state .icon-wrap {
        width: 80px; height: 80px;
        background: #f0f0f0;
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        font-size: 36px;
        color: #ccc;
    }

    /* Scrollbar */
    .chat-main-body::-webkit-scrollbar,
    .chat-user-list::-webkit-scrollbar { width: 4px; }
    .chat-main-body::-webkit-scrollbar-thumb,
    .chat-user-list::-webkit-scrollbar-thumb { background: #ddd; border-radius: 2px; }

    /* Typing indicator */
    .typing-indicator {
        display: none;
        padding: 8px 14px;
        background: #fff;
        border: 1px solid #e8eaed;
        border-radius: 18px 18px 18px 4px;
        width: fit-content;
        margin-bottom: 4px;
    }
    .typing-dot {
        display: inline-block;
        width: 6px; height: 6px;
        background: #ccc;
        border-radius: 50%;
        margin: 0 1px;
        animation: typingBounce 1.2s infinite;
    }
    .typing-dot:nth-child(2) { animation-delay: 0.2s; }
    .typing-dot:nth-child(3) { animation-delay: 0.4s; }
    @keyframes typingBounce {
        0%, 60%, 100% { transform: translateY(0); background: #ccc; }
        30% { transform: translateY(-5px); background: #ee4d2d; }
    }

    /* Emoji picker */
    .emoji-picker {
        position: absolute;
        bottom: 70px;
        right: 20px;
        background: #fff;
        border: 1px solid #e0e0e0;
        border-radius: 12px;
        padding: 10px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.12);
        display: none;
        z-index: 100;
        width: 240px;
    }
    .emoji-picker.show { display: flex; flex-wrap: wrap; gap: 4px; }
    .emoji-btn {
        font-size: 20px;
        cursor: pointer;
        padding: 4px;
        border-radius: 6px;
        transition: background 0.1s;
        line-height: 1;
        border: none;
        background: transparent;
    }
    .emoji-btn:hover { background: #f1f3f4; }

    /* Quick replies */
    .quick-replies {
        display: flex;
        gap: 6px;
        margin-bottom: 8px;
        flex-wrap: wrap;
    }
    .quick-reply-btn {
        background: #fff3f0;
        color: #ee4d2d;
        border: 1px solid #ffccc2;
        border-radius: 16px;
        padding: 4px 12px;
        font-size: 12px;
        cursor: pointer;
        transition: background 0.15s;
        white-space: nowrap;
    }
    .quick-reply-btn:hover { background: #fee8e3; }
</style>

<div class="container-fluid py-3">
    <div class="d-flex align-items-center mb-3 gap-3">
        <h4 class="mb-0 d-flex align-items-center gap-2">
            <i class="bi bi-chat-dots-fill text-danger"></i> Chat CSKH
        </h4>
        <span class="badge bg-success" id="badgeTongKhach" style="font-size:12px;">0 khách</span>
        <span class="badge bg-warning text-dark" id="badgeChoXuLy" style="display:none;font-size:12px;">0 chờ xử lý</span>
    </div>

    <div class="chat-admin-wrap" style="position:relative;">
        <!-- Left: Danh sach khach hang -->
        <div class="chat-user-list">
            <div class="chat-user-list-header">
                <h6><i class="bi bi-people-fill me-1"></i> Khách đang chat</h6>
                <input type="text" class="chat-search-input" id="searchKhach" placeholder="Tìm khách hàng...">
            </div>
            <div id="danhSachKhach">
                <div class="p-4 text-center text-muted">
                    <div class="spinner-border spinner-border-sm text-danger" role="status"></div>
                    <div class="mt-2 small">Đang tải...</div>
                </div>
            </div>
        </div>

        <!-- Right: Chat area -->
        <div class="chat-main-area">
            <!-- Header -->
            <div class="chat-main-header" id="chatHeader">
                <div class="d-flex align-items-center gap-2 w-100">
                    <div class="chat-header-avatar" id="headerAvatar" style="display:none;"></div>
                    <div class="chat-header-info" id="headerInfo">
                        <div class="name text-muted" id="chatTieuDe">
                            <i class="bi bi-chat-left-text me-1"></i> Chọn khách hàng để bắt đầu chat
                        </div>
                    </div>
                    <div class="chat-header-actions" id="headerActions" style="display:none;">
                        <button class="btn-icon" title="Lịch sử đơn hàng" onclick="xemDonHang()">
                            <i class="bi bi-receipt"></i>
                        </button>
                        <button class="btn-icon" title="Làm mới" onclick="lamMoi()">
                            <i class="bi bi-arrow-clockwise"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Messages body -->
            <div class="chat-main-body" id="chatNoiDungAdmin">
                <div class="chat-empty-state">
                    <div class="icon-wrap"><i class="bi bi-chat-square-dots"></i></div>
                    <div class="fw-semibold">Chưa có cuộc hội thoại nào được chọn</div>
                    <div class="small">Chọn 1 khách hàng bên trái để xem tin nhắn</div>
                </div>
            </div>

            <!-- Typing indicator -->
            <div style="padding: 0 20px 4px;" id="typingWrap" style="display:none;">
                <div class="typing-indicator" id="typingIndicator">
                    <span class="typing-dot"></span>
                    <span class="typing-dot"></span>
                    <span class="typing-dot"></span>
                </div>
            </div>

            <!-- Footer -->
            <div class="chat-main-footer" id="chatFooterAdmin" style="display:none;">
                <!-- Quick replies -->
                <div class="quick-replies" id="quickReplies">
                    <button class="quick-reply-btn" onclick="chonQuickReply(this)">Xin chào! 👋</button>
                    <button class="quick-reply-btn" onclick="chonQuickReply(this)">Cảm ơn bạn đã liên hệ!</button>
                    <button class="quick-reply-btn" onclick="chonQuickReply(this)">Vui lòng chờ chúng tôi kiểm tra.</button>
                    <button class="quick-reply-btn" onclick="chonQuickReply(this)">Chúng tôi sẽ xử lý ngay!</button>
                    <button class="quick-reply-btn" onclick="chonQuickReply(this)">Bạn có thể cho biết thêm chi tiết không?</button>
                </div>
                <!-- Input row -->
                <div class="chat-input-row" style="position:relative;">
                    <input type="text" id="txtAdminChat" placeholder="Nhập tin nhắn trả lời..." autocomplete="off">
                    <button class="btn-emoji" id="btnEmoji" type="button" title="Emoji">😊</button>
                    <button class="btn-send" id="btnAdminGui" type="button" title="Gửi (Enter)">
                        <i class="bi bi-send-fill"></i>
                    </button>
                </div>
                <!-- Emoji picker -->
                <div class="emoji-picker" id="emojiPicker">
                    <%-- list common emojis --%>
                    <% String[] emojis = {"😊","😄","👋","👍","❤️","🎉","😅","🙏","💯","✅","⚡","🔥","💪","😢","😡","🤔","📦","🚚","💰","🎁","📞","📧"}; %>
                    <% for (String e : emojis) { %>
                    <button class="emoji-btn" onclick="themEmoji('<%= e %>')" type="button"><%= e %></button>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var CTX = '${pageContext.request.contextPath}';
    var dangChatUserId = 0;
    var dangChatTen = '';
    var adminLastMsgId = 0;
    var adminPollTimer = null;
    var allUsers = [];

    // ===== 1. Tải danh sách khách hàng =====
    function taiDanhSachKhach() {
        fetch(CTX + '/api/chat?action=users')
            .then(function(r) { return r.json(); })
            .then(function(data) {
                allUsers = data.items || [];
                renderDanhSach(allUsers);
                document.getElementById('badgeTongKhach').textContent = allUsers.length + ' khách';
            })
            .catch(function() {
                document.getElementById('danhSachKhach').innerHTML =
                    '<div class="p-3 text-danger text-center small"><i class="bi bi-exclamation-circle"></i> Lỗi tải dữ liệu</div>';
            });
    }

    function renderDanhSach(users) {
        var box = document.getElementById('danhSachKhach');
        if (users.length === 0) {
            box.innerHTML = '<div class="p-4 text-center text-muted small"><i class="bi bi-inbox" style="font-size:2rem;opacity:0.3;display:block;margin-bottom:8px;"></i>Chưa có ai nhắn tin</div>';
            return;
        }
        var html = '';
        for (var i = 0; i < users.length; i++) {
            var u = users[i];
            var initials = (u.name || 'K').charAt(0).toUpperCase();
            var isActive = u.userId === dangChatUserId ? 'active' : '';
            html += '<div class="chat-user-item ' + isActive + '" data-uid="' + u.userId + '" data-name="' + (u.name || '') + '" onclick="chonKhachChat(' + u.userId + ', this)">';
            html += '<div class="chat-avatar"><span>' + initials + '</span></div>';
            html += '<div class="chat-user-meta">';
            html += '<div class="d-flex justify-content-between align-items-baseline">';
            html += '<div class="u-name">' + escHtml(u.name || ('Khách #' + u.userId)) + '</div>';
            html += '<div class="u-time">' + (u.time || '') + '</div>';
            html += '</div>';
            html += '<div class="u-preview">' + escHtml(u.lastMsg || '') + '</div>';
            html += '</div>';
            html += '</div>';
        }
        box.innerHTML = html;
    }

    // ===== 2. Tìm kiếm khách hàng =====
    document.getElementById('searchKhach').addEventListener('input', function() {
        var q = this.value.trim().toLowerCase();
        if (!q) { renderDanhSach(allUsers); return; }
        var filtered = allUsers.filter(function(u) {
            return (u.name || '').toLowerCase().includes(q) || String(u.userId).includes(q);
        });
        renderDanhSach(filtered);
    });

    // ===== 3. Admin chọn khách hàng =====
    function chonKhachChat(userId, element) {
        dangChatUserId = userId;
        adminLastMsgId = 0;
        dangChatTen = element ? element.getAttribute('data-name') || ('Khách #' + userId) : 'Khách #' + userId;

        // Highlight
        document.querySelectorAll('.chat-user-item').forEach(function(el) { el.classList.remove('active'); });
        if (element) element.classList.add('active');

        // Header
        var initials = dangChatTen.charAt(0).toUpperCase();
        document.getElementById('headerAvatar').textContent = initials;
        document.getElementById('headerAvatar').style.display = 'flex';
        document.getElementById('chatTieuDe').innerHTML =
            '<div class="name">' + escHtml(dangChatTen) + '</div>' +
            '<div class="status"><i class="bi bi-circle-fill" style="font-size:8px;"></i> Đang hoạt động</div>';
        document.getElementById('headerActions').style.display = 'flex';

        // Show footer & input
        document.getElementById('chatFooterAdmin').style.display = 'block';

        // Tải lịch sử
        taiLichSuChat(userId);

        // Bắt đầu polling
        batDauPollingAdmin();
    }

    // ===== 4. Tải lịch sử chat =====
    function taiLichSuChat(userId) {
        var body = document.getElementById('chatNoiDungAdmin');
        body.innerHTML = '<div class="chat-empty-state"><div class="spinner-border text-danger" role="status"></div><div class="mt-2 small text-muted">Đang tải lịch sử...</div></div>';

        fetch(CTX + '/api/chat?userId=' + userId)
            .then(function(r) { return r.json(); })
            .then(function(data) {
                var items = data.items || [];
                body.innerHTML = '';
                var prevDate = null;
                for (var i = 0; i < items.length; i++) {
                    var m = items[i];
                    // Date divider
                    if (m.time) {
                        var dateStr = m.time.split(' ')[0];
                        if (dateStr !== prevDate) {
                            themDateDivider(dateStr);
                            prevDate = dateStr;
                        }
                    }
                    themTinNhanAdmin(m.role, m.content, m.time, dangChatTen);
                    if (m.id > adminLastMsgId) adminLastMsgId = m.id;
                }
                if (items.length === 0) {
                    body.innerHTML = '<div class="chat-empty-state"><div class="icon-wrap"><i class="bi bi-chat"></i></div><div class="small text-muted">Chưa có tin nhắn nào</div></div>';
                }
                body.scrollTop = body.scrollHeight;
            })
            .catch(function() {
                body.innerHTML = '<div class="chat-empty-state"><div class="text-danger small"><i class="bi bi-exclamation-triangle"></i> Lỗi khi tải lịch sử chat</div></div>';
            });
    }

    // ===== 5. Hiển thị date divider =====
    function themDateDivider(dateStr) {
        var body = document.getElementById('chatNoiDungAdmin');
        var div = document.createElement('div');
        div.className = 'chat-date-divider';
        div.innerHTML = '<span>' + dateStr + '</span>';
        body.appendChild(div);
    }

    // ===== 6. Thêm tin nhắn lên màn hình =====
    function themTinNhanAdmin(role, content, time, tenKhach) {
        var body = document.getElementById('chatNoiDungAdmin');
        var isAdmin = role === 'ADMIN';

        var wrapper = document.createElement('div');
        wrapper.className = 'adm-msg-wrapper ' + (isAdmin ? 'from-admin' : 'from-user');

        // Avatar
        var avDiv = document.createElement('div');
        avDiv.className = 'msg-avatar-sm ' + (isAdmin ? '' : 'user-av');
        avDiv.textContent = isAdmin ? 'A' : (tenKhach || 'K').charAt(0).toUpperCase();

        // Bubble
        var msgDiv = document.createElement('div');
        msgDiv.className = 'adm-msg';

        var contentSpan = document.createElement('span');
        contentSpan.textContent = content;
        msgDiv.appendChild(contentSpan);

        if (time) {
            var sp = document.createElement('span');
            sp.className = 'msg-time-label';
            sp.textContent = time;
            msgDiv.appendChild(sp);
        }

        if (isAdmin) {
            wrapper.appendChild(msgDiv);
            wrapper.appendChild(avDiv);
        } else {
            wrapper.appendChild(avDiv);
            wrapper.appendChild(msgDiv);
        }

        body.appendChild(wrapper);
    }

    // ===== 7. Polling mỗi 2.5 giây =====
    function batDauPollingAdmin() {
        if (adminPollTimer) clearInterval(adminPollTimer);
        adminPollTimer = setInterval(function() {
            if (dangChatUserId === 0) return;
            fetch(CTX + '/api/chat?action=poll&userId=' + dangChatUserId + '&lastId=' + adminLastMsgId)
                .then(function(r) { return r.ok ? r.json() : null; })
                .then(function(data) {
                    if (!data) return;
                    var items = data.items || [];
                    var body = document.getElementById('chatNoiDungAdmin');
                    for (var i = 0; i < items.length; i++) {
                        var m = items[i];
                        if (m.role === 'USER') {
                            themTinNhanAdmin(m.role, m.content, m.time, dangChatTen);
                            body.scrollTop = body.scrollHeight;
                        }
                        if (m.id > adminLastMsgId) adminLastMsgId = m.id;
                        capNhatPreview(m.userId, m.content);
                    }
                })
                .catch(function() {});
        }, 2500);
    }

    // ===== 8. Admin gửi tin nhắn =====
    function adminGuiTinNhan() {
        var input = document.getElementById('txtAdminChat');
        var ndung = input.value.trim();
        if (ndung === '' || dangChatUserId === 0) return;

        // Tắt nút gửi tạm
        var btn = document.getElementById('btnAdminGui');
        btn.disabled = true;

        // Hiện tin nhắn lên màn hình trước
        themTinNhanAdmin('ADMIN', ndung, formatNow(), '');
        var body = document.getElementById('chatNoiDungAdmin');
        body.scrollTop = body.scrollHeight;
        input.value = '';

        // Gửi lên server
        fetch(CTX + '/api/chat', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ userId: dangChatUserId, content: ndung })
        })
        .then(function(r) { return r.json(); })
        .then(function(data) {
            btn.disabled = false;
            if (data.ok && data.id > adminLastMsgId) {
                adminLastMsgId = data.id;
            }
            capNhatPreview(dangChatUserId, ndung);
        })
        .catch(function() {
            btn.disabled = false;
            showToast('Gửi tin nhắn thất bại!', 'danger');
        });
    }

    // ===== 9. Cập nhật preview =====
    function capNhatPreview(userId, content) {
        document.querySelectorAll('.chat-user-item').forEach(function(el) {
            if (parseInt(el.getAttribute('data-uid')) === userId) {
                var preview = el.querySelector('.u-preview');
                if (preview) preview.textContent = content;
            }
        });
    }

    // ===== 10. Quick replies =====
    function chonQuickReply(btn) {
        var input = document.getElementById('txtAdminChat');
        input.value = btn.textContent;
        input.focus();
    }

    // ===== 11. Emoji =====
    document.getElementById('btnEmoji').addEventListener('click', function(e) {
        e.stopPropagation();
        var picker = document.getElementById('emojiPicker');
        picker.classList.toggle('show');
    });
    document.addEventListener('click', function() {
        document.getElementById('emojiPicker').classList.remove('show');
    });
    document.getElementById('emojiPicker').addEventListener('click', function(e) { e.stopPropagation(); });

    function themEmoji(emoji) {
        var input = document.getElementById('txtAdminChat');
        input.value += emoji;
        input.focus();
        document.getElementById('emojiPicker').classList.remove('show');
    }

    // ===== 12. Xem đơn hàng khách =====
    function xemDonHang() {
        if (dangChatUserId > 0) {
            window.open(CTX + '/admin/orders?userId=' + dangChatUserId, '_blank');
        }
    }

    function lamMoi() {
        if (dangChatUserId > 0) taiLichSuChat(dangChatUserId);
    }

    // ===== Helper =====
    function escHtml(s) {
        if (!s) return '';
        return s.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
    }

    function formatNow() {
        var d = new Date();
        var hh = String(d.getHours()).padStart(2,'0');
        var mm = String(d.getMinutes()).padStart(2,'0');
        var dd = String(d.getDate()).padStart(2,'0');
        var mo = String(d.getMonth()+1).padStart(2,'0');
        return dd + '/' + mo + ' ' + hh + ':' + mm;
    }

    function showToast(msg, type) {
        var div = document.createElement('div');
        div.style.cssText = 'position:fixed;top:20px;right:20px;z-index:9999;padding:10px 18px;border-radius:8px;color:#fff;font-size:14px;box-shadow:0 4px 12px rgba(0,0,0,0.15);';
        div.style.background = type === 'danger' ? '#dc3545' : '#198754';
        div.textContent = msg;
        document.body.appendChild(div);
        setTimeout(function() { div.remove(); }, 3000);
    }

    // ===== Event Listeners =====
    document.getElementById('btnAdminGui').addEventListener('click', adminGuiTinNhan);
    document.getElementById('txtAdminChat').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') { e.preventDefault(); adminGuiTinNhan(); }
    });

    // ===== Bootstrap =====
    taiDanhSachKhach();
    setInterval(taiDanhSachKhach, 8000);
</script>

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
