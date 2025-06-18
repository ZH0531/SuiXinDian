<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理 - 随心点管理后台</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 管理后台特定样式 */
        .main-content {
            padding: 30px 0;
        }
        
        .user-panel {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            align-items: center;
        }
        
        .user-info {
            margin-left: 20px;
        }
        
        .user-name {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 5px;
        }
        
        .user-role {
            font-size: 14px;
            color: #777;
            background-color: #f0f0f0;
            padding: 3px 8px;
            border-radius: 12px;
            display: inline-block;
        }
        
        .avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: #333;
            border: 2px solid #f0f0f0;
        }
        
        .section-title {
            margin: 30px 0 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .section-title i {
            margin-right: 10px;
            color: #333;
        }
        
        .btn {
            background-color: #333;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn i {
            margin-right: 6px;
        }
        
        .btn:hover {
            background-color: #555;
            transform: translateY(-2px);
        }
        
        .btn-primary {
            background-color: #007bff;
        }
        
        .btn-primary:hover {
            background-color: #0056b3;
        }
        
        .btn-danger {
            background-color: #dc3545;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        .btn-success {
            background-color: #28a745;
        }
        
        .btn-success:hover {
            background-color: #218838;
        }
        
        /* 表格样式 */
        .users-table {
            margin-top: 20px;
            overflow-x: auto;
        }
        
        .users-table table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .users-table th, .users-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .users-table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
        }
        
        .users-table tr:hover {
            background-color: #f9f9f9;
        }
        
        .users-table .btn {
            padding: 6px 10px;
            font-size: 12px;
            margin-right: 5px;
        }
        
        /* 搜索框样式 */
        .search-section {
            margin-bottom: 20px;
        }
        
        .search-input {
            width: 300px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        /* 模态框样式 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        
        .modal-content {
            background-color: white;
            margin: 10% auto;
            width: 700px;
            max-width: 90%;
            border-radius: 5px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            animation: modalFadeIn 0.3s;
        }
        
        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-50px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .modal-header {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-header h3 {
            margin: 0;
            color: #333;
        }
        
        .close {
            font-size: 24px;
            cursor: pointer;
            color: #aaa;
        }
        
        .close:hover {
            color: #333;
        }
        
        .modal-body {
            padding: 20px;
        }
        
        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        /* 表单样式 */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-column {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        .form-group {
            margin-bottom: 0;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #333;
        }
        
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .badge-admin {
            background-color: #ffd700;
            color: #333;
        }
        
        .badge-user {
            background-color: #e0e0e0;
            color: #333;
        }
        
        /* 页脚样式 */
        footer {
            background-color: #333;
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-top: 40px;
        }
        .admin-nav ul li a.active {
            background-color: white;
            color: #333;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <header class="admin-header">
        <div class="container">
            <div class="admin-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="logo">
                    <i class="fas fa-utensils"></i> 随心点 管理后台
                </a>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> 仪表盘</a></li>
                    <li><a href="${pageContext.request.contextPath}/menu/admin"><i class="fas fa-book-open"></i> 菜品管理</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users" class="active"><i class="fas fa-users"></i> 用户管理</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/logout"><i class="fas fa-sign-out-alt"></i> 退出</a></li>
                </ul>
            </div>
        </div>
    </header>
    
    <div class="main-content">
        <div class="container">
            <div class="user-panel">
                <div class="avatar">
                    <i class="fas fa-user-shield"></i>
                </div>
                <div class="user-info">
                    <div class="user-name">${user.username}</div>
                    <div class="user-role">系统管理员</div>
                </div>
            </div>

            <div class="section-title">
                <h2><i class="fas fa-users"></i> 用户管理</h2>
            </div>

            <div class="search-section">
                <input type="text" id="userSearch" placeholder="搜索用户..." class="search-input">
            </div>

            <div class="users-table">
                <table>
                    <thead>
                        <tr>
                            <th>数据库ID</th>
                            <th>用户ID</th>
                            <th>用户名</th>
                            <th>手机号</th>
                            <th>邮箱</th>
                            <th>角色</th>
                            <th>注册时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="userTableBody">
                        <c:forEach var="u" items="${users}">
                            <tr data-id="${u.id}">
                                <td>${u.id}</td>
                                <td>${u.userId}</td>
                                <td>${u.username}</td>
                                <td>${u.phone}</td>
                                <td>${u.email != null ? u.email : '未设置'}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.role == 1}">
                                            <span class="badge badge-admin">管理员</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-user">普通用户</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${u.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td>
                                    <button class="btn btn-success edit-btn" data-id="${u.id}">
                                        <i class="fas fa-edit"></i> 编辑
                                    </button>
                                    <c:if test="${u.id != user.id}">
                                        <button class="btn btn-danger delete-btn" data-id="${u.id}">
                                            <i class="fas fa-trash-alt"></i> 删除
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 用户编辑模态框 -->
    <div class="modal" id="userModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">编辑用户</h3>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <form id="userForm">
                    <input type="hidden" id="userId" name="id">
                    <div class="form-grid">
                        <div class="form-column">
                            <div class="form-group">
                                <label for="userNo">用户编号</label>
                                <input type="text" id="userNo" name="userId" readonly>
                            </div>
                            <div class="form-group">
                                <label for="username">用户名 *</label>
                                <input type="text" id="username" name="username" placeholder="输入用户名" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">手机号 *</label>
                                <input type="text" id="phone" name="phone" placeholder="输入手机号" required>
                            </div>
                        </div>
                        <div class="form-column">
                            <div class="form-group">
                                <label for="email">邮箱</label>
                                <input type="email" id="email" name="email" placeholder="输入邮箱">
                            </div>
                            <div class="form-group">
                                <label for="role">角色 *</label>
                                <select id="role" name="role" required>
                                    <option value="0">普通用户</option>
                                    <option value="1">管理员</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="gender">性别</label>
                                <select id="gender" name="gender">
                                    <option value="0">未知</option>
                                    <option value="1">男</option>
                                    <option value="2">女</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn" id="cancelBtn">取消</button>
                <button class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </div>
    </div>

    <!-- 删除确认模态框 -->
    <div class="modal" id="deleteModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>确认删除</h3>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <p>确定要删除这个用户吗？此操作不可恢复。</p>
            </div>
            <div class="modal-footer">
                <button class="btn" id="deleteCancelBtn">取消</button>
                <button class="btn btn-danger" id="deleteConfirmBtn">删除</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 获取模态框和按钮元素
            const userModal = document.getElementById('userModal');
            const deleteModal = document.getElementById('deleteModal');
            const cancelBtn = document.getElementById('cancelBtn');
            const saveBtn = document.getElementById('saveBtn');
            const deleteCancelBtn = document.getElementById('deleteCancelBtn');
            const deleteConfirmBtn = document.getElementById('deleteConfirmBtn');
            const closeBtns = document.querySelectorAll('.close');
            
            let currentUserId = null;
            
            // 搜索功能
            document.getElementById('userSearch').addEventListener('input', function() {
                const searchText = this.value.toLowerCase();
                const rows = document.querySelectorAll('#userTableBody tr');
                
                rows.forEach(row => {
                    const username = row.cells[2].textContent.toLowerCase();
                    const userNo = row.cells[1].textContent.toLowerCase();
                    const phone = row.cells[3].textContent.toLowerCase();
                    const email = row.cells[4].textContent.toLowerCase();
                    
                    if (username.includes(searchText) || 
                        userNo.includes(searchText) || 
                        phone.includes(searchText) || 
                        email.includes(searchText)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
            
            // 编辑用户按钮点击事件
            document.addEventListener('click', function(e) {
                if (e.target.classList.contains('edit-btn') || e.target.parentElement.classList.contains('edit-btn')) {
                    const btn = e.target.classList.contains('edit-btn') ? e.target : e.target.parentElement;
                    const userId = btn.dataset.id;
                    
                    // 获取用户数据
                    fetch('${pageContext.request.contextPath}/admin/user/' + userId)
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                const user = data.data;
                                document.getElementById('userId').value = user.id;
                                document.getElementById('userNo').value = user.userId;
                                document.getElementById('username').value = user.username;
                                document.getElementById('phone').value = user.phone;
                                document.getElementById('email').value = user.email || '';
                                document.getElementById('role').value = user.role;
                                document.getElementById('gender').value = user.gender;
                                
                                document.getElementById('modalTitle').textContent = '编辑用户';
                                userModal.style.display = 'block';
                            } else {
                                alert('获取用户详情失败：' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('获取用户详情出错：', error);
                            alert('获取用户详情失败，请重试');
                        });
                }
            });
            
            // 删除用户按钮点击事件
            document.addEventListener('click', function(e) {
                if (e.target.classList.contains('delete-btn') || e.target.parentElement.classList.contains('delete-btn')) {
                    const btn = e.target.classList.contains('delete-btn') ? e.target : e.target.parentElement;
                    currentUserId = btn.dataset.id;
                    deleteModal.style.display = 'block';
                }
            });
            
            // 确认删除按钮点击事件
            deleteConfirmBtn.addEventListener('click', function() {
                if (currentUserId) {
                    fetch('${pageContext.request.contextPath}/admin/user/delete/' + currentUserId, {
                        method: 'DELETE'
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // 删除成功，刷新页面
                            alert('删除成功');
                            deleteModal.style.display = 'none';
                            location.reload();
                        } else {
                            alert('删除失败：' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('删除用户出错：', error);
                        alert('删除失败，请重试');
                    });
                }
            });
            
            // 保存用户按钮点击事件
            saveBtn.addEventListener('click', function() {
                // 表单验证
                const username = document.getElementById('username').value;
                const phone = document.getElementById('phone').value;
                const role = document.getElementById('role').value;
                
                if (!username || !phone || role === '') {
                    alert('请填写必填字段');
                    return;
                }
                
                // 准备提交的数据
                const formData = new FormData(document.getElementById('userForm'));
                const user = {};
                
                formData.forEach((value, key) => {
                    user[key] = value;
                });
                
                // 发送请求
                fetch('${pageContext.request.contextPath}/admin/user/update', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(user)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('更新成功');
                        // 关闭模态框
                        userModal.style.display = 'none';
                        // 刷新页面显示最新数据
                        location.reload();
                    } else {
                        alert('更新失败：' + data.message);
                    }
                })
                .catch(error => {
                    console.error('保存用户出错：', error);
                    alert('保存失败，请重试');
                });
            });
            
            // 关闭模态框的方法
            function closeModal(modal) {
                modal.style.display = 'none';
            }
            
            // 关闭按钮点击事件
            closeBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    closeModal(this.closest('.modal'));
                });
            });
            
            // 取消按钮点击事件
            cancelBtn.addEventListener('click', () => closeModal(userModal));
            deleteCancelBtn.addEventListener('click', () => closeModal(deleteModal));
            
            // 点击模态框外部关闭
            window.addEventListener('click', function(e) {
                if (e.target === userModal) {
                    closeModal(userModal);
                }
                if (e.target === deleteModal) {
                    closeModal(deleteModal);
                }
            });
        });
    </script>

    <footer>
        <div class="container">
            <p>© 2025 随心点 | 后台管理系统</p>
        </div>
    </footer>
</body>
</html> 