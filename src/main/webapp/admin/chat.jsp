<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
    request.setAttribute("pageTitle", "Chat CSKH - Admin");
    request.setAttribute("activePage", "chat");
%>

<%@ include file="/admin/includes/_admin_layout_open.jspf" %>

<style>
    .chat-admin-wrap {
        display: flex;
        height: calc(100vh - 120px);
        border: 1px solid #ddd;
        border-radius: 8px;
        overflow: hidden;
        background: #fff;
    }
    /* Ben trai: danh sach khach hang */
    .chat-user-list {
        width: 280px;
        min-width: 280px;
        border-right: 1px solid #e0e0e0;
        overflow-y: auto;
        background: #fafafa;
    }
    .chat-user-item {
        padding: 12px 15px;
        border-bottom: 1px solid #eee;
        cursor: pointer;
        transition: background 0.15s;
    }
    .chat-user-item:hover,
    .chat-user-item.active {
        background-color: #fff3e0;
    }
    .chat-user-item .u-name {
        font-weight: 600;
        font-size: 14px;
        color: #333;
    }
    .chat-user-item .u-preview {
        font-size: 12px;
        color: #888;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 200px;
    }
    .chat-user-item .u-time {
        font-size: 11px;
        color: #aaa;
    }

    /* Ben phai: khung chat */
    .chat-main-area {
        flex: 1;
        display: flex;
        flex-direction: column;
    }
    .chat-main-header {
        padding: 12px 20px;
        background: #f5f5f5;
        border-bottom: 1px solid #e0e0e0;
        font-weight: 600;
    }
    .chat-main-body {
        flex: 1;
        padding: 15px;
        overflow-y: auto;
        background: #f9f9f9;
    }
    .chat-main-footer {
        padding: 10px 15px;
        border-top: 1px solid #eee;
        display: flex;
        gap: 10px;
    }
    .chat-main-footer input {
        flex: 1;
        padding: 10px 15px;
        border: 1px solid #ccc;
        border-radius: 20px;
        outline: none;
        font-size: 14px;
    }
    .chat-main-footer input:focus {
        border-color: #ee4d2d;
    }
    .chat-main-footer button {
        padding: 8px 20px;
        background: #ee4d2d;
        color: white;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        font-weight: 600;
    }
    .chat-main-footer button:hover {
        background: #d73a1e;
    }

    /* Tin nhan */
    .adm-msg {
        margin-bottom: 12px;
        max-width: 70%;
        padding: 10px 14px;
        font-size: 14px;
        line-height: 1.4;
        clear: both;
    }
    .adm-msg.from-user {
        background: #fff;
        border: 1px solid #ddd;
        float: left;
        border-radius: 15px 15px 15px 0;
        color: #333;
    }
    .adm-msg.from-admin {
        background: #ee4d2d;
        color: white;
        float: right;
        border-radius: 15px 15px 0 15px;
    }
    .adm-msg .msg-time-label {
        font-size: 10px;
        opacity: 0.7;
        display: block;
        margin-top: 4px;
    }

    .chat-empty-state {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100%;
        color: #aaa;
        font-size: 16px;
    }
</style>

<div class="container-fluid py-3">
    <h4 class="mb-3"><i class="bi bi-chat-dots me-2"></i>Chat CSKH</h4>

    <div class="chat-admin-wrap">
        <!-- Danh sach khach hang -->
        <div class="chat-user-list" id="danhSachKhach">
            <div class="p-3 text-muted text-center small">Dang tai...</div>
        </div>

        <!-- Khu vuc chat -->
        <div class="chat-main-area">
            <div class="chat-main-header" id="chatTieuDe">
                <i class="bi bi-chat-left-text me-1"></i> Chon khach hang de bat dau chat
            </div>
            <div class="chat-main-body" id="chatNoiDungAdmin">
                <div class="chat-empty-state">
                    <div class="text-center">
                        <i class="bi bi-chat-square-dots" style="font-size: 3rem; opacity: 0.3;"></i>
                        <p class="mt-2">Chon 1 khach hang ben trai de xem tin nhan</p>
                    </div>
                </div>
            </div>
            <div class="chat-main-footer" id="chatFooterAdmin" style="display:none;">
                <input type="text" id="txtAdminChat" placeholder="Nhap tin nhan tra loi..." autocomplete="off">
                <button id="btnAdminGui">Gui</button>
            </div>
        </div>
    </div>
</div>

<script>
    var CTX = '${pageContext.request.contextPath}';
    var dangChatUserId = 0;
    var adminLastMsgId = 0;
    var adminPollTimer = null;

    // --- 1. Tai danh sach khach hang da chat ---
    function taiDanhSachKhach() {
        var box = document.getElementById('danhSachKhach');
        fetch(CTX + '/api/chat?action=users')
            .then(function(r) { return r.json(); })
            .then(function(data) {
                var items = data.items || [];
                if (items.length === 0) {
                    box.innerHTML = '<div class="p-3 text-muted text-center small">Chua co ai nhan tin</div>';
                    return;
                }
                var html = '';
                for (var i = 0; i < items.length; i++) {
                    var u = items[i];
                    html += '<div class="chat-user-item" data-uid="' + u.userId + '" onclick="chonKhachChat(' + u.userId + ', this)">';
                    html += '<div class="d-flex justify-content-between">';
                    html += '<span class="u-name">' + (u.name || ('Khach #' + u.userId)) + '</span>';
                    html += '<span class="u-time">' + (u.time || '') + '</span>';
                    html += '</div>';
                    html += '<div class="u-preview">' + (u.lastMsg || '') + '</div>';
                    html += '</div>';
                }
                box.innerHTML = html;
            })
            .catch(function() {
                box.innerHTML = '<div class="p-3 text-danger text-center small">Loi tai du lieu</div>';
            });
    }

    // --- 2. Admin chon 1 khach hang ---
    function chonKhachChat(userId, element) {
        dangChatUserId = userId;
        adminLastMsgId = 0;

        // Highlight
        var allItems = document.querySelectorAll('.chat-user-item');
        for (var j = 0; j < allItems.length; j++) {
            allItems[j].classList.remove('active');
        }
        if (element) element.classList.add('active');

        // Tieu de
        var ten = element ? element.querySelector('.u-name').innerText : 'Khach #' + userId;
        document.getElementById('chatTieuDe').innerHTML = '<i class="bi bi-person-circle me-1"></i> Dang chat voi: <strong>' + ten + '</strong>';

        // Hien footer
        document.getElementById('chatFooterAdmin').style.display = 'flex';

        // Tai lich su
        taiLichSuChat(userId);

        // Bat dau polling
        batDauPollingAdmin();
    }

    // --- 3. Tai lich su chat ---
    function taiLichSuChat(userId) {
        var body = document.getElementById('chatNoiDungAdmin');
        body.innerHTML = '<div class="text-center text-muted py-3"><small>Dang tai lich su...</small></div>';

        fetch(CTX + '/api/chat?userId=' + userId)
            .then(function(r) { return r.json(); })
            .then(function(data) {
                var items = data.items || [];
                body.innerHTML = '';
                for (var i = 0; i < items.length; i++) {
                    themTinNhanAdmin(items[i].role, items[i].content, items[i].time);
                    if (items[i].id > adminLastMsgId) adminLastMsgId = items[i].id;
                }
                body.scrollTop = body.scrollHeight;
            })
            .catch(function() {
                body.innerHTML = '<div class="text-center text-danger py-3"><small>Loi khi tai lich su chat</small></div>';
            });
    }

    // --- 4. Them tin nhan len man hinh ---
    function themTinNhanAdmin(role, content, time) {
        var body = document.getElementById('chatNoiDungAdmin');
        var div = document.createElement('div');
        div.className = 'adm-msg ' + (role === 'ADMIN' ? 'from-admin' : 'from-user');
        div.innerText = content;
        if (time) {
            var sp = document.createElement('span');
            sp.className = 'msg-time-label';
            sp.innerText = time;
            div.appendChild(sp);
        }
        body.appendChild(div);
    }

    // --- 5. Polling moi 2 giay de nhan tin nhan moi tu khach ---
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
                        // Chi hien tin nhan USER (tin ADMIN minh da hien khi gui)
                        if (m.role === 'USER') {
                            themTinNhanAdmin(m.role, m.content, m.time);
                            body.scrollTop = body.scrollHeight;
                        }
                        if (m.id > adminLastMsgId) adminLastMsgId = m.id;
                        // Cap nhat preview ben trai
                        capNhatPreview(m.userId, m.content);
                    }
                })
                .catch(function() {});
        }, 2000);
    }

    // --- 6. Admin gui tin nhan ---
    function adminGuiTinNhan() {
        var input = document.getElementById('txtAdminChat');
        var ndung = input.value.trim();
        if (ndung === '' || dangChatUserId === 0) return;

        // Hien tin nhan len man hinh truoc
        themTinNhanAdmin('ADMIN', ndung, null);
        var body = document.getElementById('chatNoiDungAdmin');
        body.scrollTop = body.scrollHeight;
        input.value = '';

        // Gui len server
        fetch(CTX + '/api/chat', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ userId: dangChatUserId, content: ndung })
        })
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.ok && data.id > adminLastMsgId) {
                adminLastMsgId = data.id;
            }
        })
        .catch(function() {
            alert('Gui tin nhan that bai!');
        });
    }

    // --- 7. Cap nhat preview ---
    function capNhatPreview(userId, content) {
        var items = document.querySelectorAll('.chat-user-item');
        for (var i = 0; i < items.length; i++) {
            if (parseInt(items[i].getAttribute('data-uid')) === userId) {
                var preview = items[i].querySelector('.u-preview');
                if (preview) preview.innerText = content;
                break;
            }
        }
    }

    // --- 8. Bat su kien ---
    document.getElementById('btnAdminGui').onclick = adminGuiTinNhan;
    document.getElementById('txtAdminChat').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            adminGuiTinNhan();
        }
    });

    // Load danh sach
    taiDanhSachKhach();
    // Refresh danh sach khach moi 5 giay
    setInterval(taiDanhSachKhach, 5000);
</script>

<%@ include file="/admin/includes/_admin_layout_close.jspf" %>
