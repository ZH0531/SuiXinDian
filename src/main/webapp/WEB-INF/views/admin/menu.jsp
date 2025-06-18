<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>菜品管理 - 随心点管理后台</title>
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
        
        /* 菜品管理特定样式 */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .menu-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .menu-image {
            height: 200px;
            overflow: hidden;
            position: relative;
        }
        
        .menu-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .menu-info {
            padding: 20px;
        }
        
        .menu-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .menu-desc {
            color: #666;
            margin-bottom: 10px;
            font-size: 14px;
            line-height: 1.4;
        }
        
        .menu-tags {
            margin-bottom: 15px;
        }
        
        .tag {
            background: #007bff;
            color: white;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 12px;
            margin-right: 5px;
            display: inline-block;
        }
        
        .menu-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .menu-price {
            font-size: 20px;
            font-weight: bold;
            color: #28a745;
        }
        
        .menu-no {
            font-size: 14px;
            color: #666;
        }
        
        .menu-actions {
            display: flex;
            gap: 10px;
        }
        
        .menu-actions .btn {
            flex: 1;
            padding: 8px 12px;
            font-size: 12px;
        }
        
        /* 页脚样式 */
        footer {
            background-color: #333;
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-top: 40px;
        }
        
        /* 表格样式 */
        .menu-table {
            margin-top: 20px;
            overflow-x: auto;
        }
        
        .menu-table table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .menu-table th, .menu-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .menu-table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
        }
        
        .menu-table tr:hover {
            background-color: #f9f9f9;
        }
        
        .menu-table .btn {
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
            width: 500px;
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
        .form-group {
            margin-bottom: 15px;
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
        
        .form-group textarea {
            height: 100px;
            resize: vertical;
        }
        
        /* 图片路径单元格样式 */
        .image-path {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
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
                <h2><i class="fas fa-book-open"></i> 菜品管理</h2>
                <button class="btn btn-primary" id="addMenuBtn">
                    <i class="fas fa-plus"></i> 添加新菜品
                </button>
            </div>
            
            <div class="search-section">
                <input type="text" id="menuSearch" placeholder="搜索菜品..." class="search-input">
            </div>
            
            <div class="menu-table">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>编号</th>
                            <th>菜品名称</th>
                            <th>价格</th>
                            <th>分类</th>
                            <th>图片路径</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="menuTableBody">
                        <c:forEach var="menu" items="${menus}">
                            <tr data-id="${menu.id}">
                                <td>${menu.id}</td>
                                <td>${menu.menuNo}</td>
                                <td>${menu.name}</td>
                                <td>¥${menu.price}</td>
                                <td>${menu.tags}</td>
                                <td class="image-path">${menu.imageUrl}</td>
                                <td>
                                    <button class="btn btn-success edit-btn" data-id="${menu.id}">
                                        <i class="fas fa-edit"></i> 编辑
                                    </button>
                                    <button class="btn btn-danger delete-btn" data-id="${menu.id}">
                                        <i class="fas fa-trash-alt"></i> 删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- 菜品编辑模态框 -->
    <div class="modal" id="menuModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">添加新菜品</h3>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <form id="menuForm">
                    <input type="hidden" id="menuId">
                    <div class="form-group">
                        <label for="menuNo">菜品编号</label>
                        <input type="text" id="menuNo" placeholder="系统自动生成" readonly>
                    </div>
                    <div class="form-group">
                        <label for="menuName">菜品名称 *</label>
                        <input type="text" id="menuName" placeholder="输入菜品名称" required>
                    </div>
                    <div class="form-group">
                        <label for="menuPrice">价格 *</label>
                        <input type="number" id="menuPrice" placeholder="输入价格" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="menuCategory">分类 *</label>
                        <select id="menuCategory" required>
                            <option value="">请选择分类</option>
                            <option value="热菜">热菜</option>
                            <option value="凉菜">凉菜</option>
                            <option value="汤类">汤类</option>
                            <option value="主食">主食</option>
                            <option value="饮品">饮品</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="menuTags">标签（多个标签用空格分隔）</label>
                        <input type="text" id="menuTags" placeholder="例如：辣 招牌">
                    </div>
                    <div class="form-group">
                        <label for="menuImage">图片路径</label>
                        <input type="text" id="menuImage" placeholder="/static/images/dishes/default.jpg">
                    </div>
                    <div class="form-group">
                        <label for="menuDesc">描述</label>
                        <textarea id="menuDesc" placeholder="输入菜品描述"></textarea>
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
                <p>确定要删除这个菜品吗？此操作不可恢复。</p>
            </div>
            <div class="modal-footer">
                <button class="btn" id="deleteCancelBtn">取消</button>
                <button class="btn btn-danger" id="deleteConfirmBtn">删除</button>
            </div>
        </div>
    </div>

    <footer>
        <div class="container">
            <p>© 2023 随心点 | 后台管理系统</p>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 获取模态框和按钮元素
            const menuModal = document.getElementById('menuModal');
            const deleteModal = document.getElementById('deleteModal');
            const addMenuBtn = document.getElementById('addMenuBtn');
            const cancelBtn = document.getElementById('cancelBtn');
            const saveBtn = document.getElementById('saveBtn');
            const deleteCancelBtn = document.getElementById('deleteCancelBtn');
            const deleteConfirmBtn = document.getElementById('deleteConfirmBtn');
            const closeBtns = document.querySelectorAll('.close');
            
            let currentMenuId = null;
            
            // 搜索功能
            document.getElementById('menuSearch').addEventListener('input', function() {
                const searchText = this.value.toLowerCase();
                const rows = document.querySelectorAll('#menuTableBody tr');
                
                rows.forEach(row => {
                    const name = row.cells[2].textContent.toLowerCase();
                    const menuNo = row.cells[1].textContent.toLowerCase();
                    const tags = row.cells[4].textContent.toLowerCase();
                    
                    if (name.includes(searchText) || menuNo.includes(searchText) || tags.includes(searchText)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
            
            // 添加新菜品按钮点击事件
            addMenuBtn.addEventListener('click', function() {
                // 重置表单
                document.getElementById('menuForm').reset();
                document.getElementById('menuId').value = '';
                document.getElementById('menuNo').value = '';
                document.getElementById('modalTitle').textContent = '添加新菜品';
                
                // 显示模态框
                menuModal.style.display = 'block';
            });
            
            // 编辑菜品按钮点击事件
            document.addEventListener('click', function(e) {
                if (e.target.classList.contains('edit-btn') || e.target.parentElement.classList.contains('edit-btn')) {
                    const btn = e.target.classList.contains('edit-btn') ? e.target : e.target.parentElement;
                    const menuId = btn.dataset.id;
                    
                    // 获取菜品数据
                    fetch('${pageContext.request.contextPath}/menu/detail/' + menuId)
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                const menu = data.data;
                                document.getElementById('menuId').value = menu.id;
                                document.getElementById('menuNo').value = menu.menuNo;
                                document.getElementById('menuName').value = menu.name;
                                document.getElementById('menuPrice').value = menu.price;
                                
                                // 设置分类
                                const categorySelect = document.getElementById('menuCategory');
                                if (menu.tags.includes('热菜')) {
                                    categorySelect.value = '热菜';
                                } else if (menu.tags.includes('凉菜')) {
                                    categorySelect.value = '凉菜';
                                } else if (menu.tags.includes('汤类')) {
                                    categorySelect.value = '汤类';
                                } else if (menu.tags.includes('主食')) {
                                    categorySelect.value = '主食';
                                } else if (menu.tags.includes('饮品')) {
                                    categorySelect.value = '饮品';
                                } else {
                                    categorySelect.value = '';
                                }
                                
                                // 设置其他标签
                                const mainCategories = ['热菜', '凉菜', '汤类', '主食', '饮品'];
                                const tagsArray = menu.tags.split(/\s+/);
                                const otherTags = tagsArray.filter(tag => !mainCategories.includes(tag));
                                document.getElementById('menuTags').value = otherTags.join(' ');
                                
                                document.getElementById('menuImage').value = menu.imageUrl || '';
                                document.getElementById('menuDesc').value = menu.description || '';
                                
                                document.getElementById('modalTitle').textContent = '编辑菜品';
                                menuModal.style.display = 'block';
                            } else {
                                alert('获取菜品详情失败：' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('获取菜品详情出错：', error);
                            alert('获取菜品详情失败，请重试');
                        });
                }
            });
            
            // 删除菜品按钮点击事件
            document.addEventListener('click', function(e) {
                if (e.target.classList.contains('delete-btn') || e.target.parentElement.classList.contains('delete-btn')) {
                    const btn = e.target.classList.contains('delete-btn') ? e.target : e.target.parentElement;
                    currentMenuId = btn.dataset.id;
                    deleteModal.style.display = 'block';
                }
            });
            
            // 确认删除按钮点击事件
            deleteConfirmBtn.addEventListener('click', function() {
                if (currentMenuId) {
                    fetch('${pageContext.request.contextPath}/menu/admin/delete/' + currentMenuId, {
                        method: 'DELETE'
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // 删除成功，移除表格中的对应行
                            const row = document.querySelector(`tr[data-id="${currentMenuId}"]`);
                            if (row) {
                                row.remove();
                            }
                            alert('删除成功');
                            deleteModal.style.display = 'none';
                        } else {
                            alert('删除失败：' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('删除菜品出错：', error);
                        alert('删除失败，请重试');
                    });
                }
            });
            
            // 保存菜品按钮点击事件
            saveBtn.addEventListener('click', function() {
                // 表单验证
                const menuName = document.getElementById('menuName').value;
                const menuPrice = document.getElementById('menuPrice').value;
                const menuCategory = document.getElementById('menuCategory').value;
                
                if (!menuName || !menuPrice || !menuCategory) {
                    alert('请填写必填字段');
                    return;
                }
                
                // 准备提交的数据
                const menuId = document.getElementById('menuId').value;
                const menu = {
                    name: menuName,
                    price: parseFloat(menuPrice),
                    tags: menuCategory + ' ' + document.getElementById('menuTags').value,
                    imageUrl: document.getElementById('menuImage').value || '/static/images/dishes/default.jpg',
                    description: document.getElementById('menuDesc').value || ''
                };
                
                // 如果是编辑模式，添加ID
                if (menuId) {
                    menu.id = parseInt(menuId);
                    menu.menuNo = document.getElementById('menuNo').value;
                }
                
                // 发送请求
                const url = menuId ? 
                    '${pageContext.request.contextPath}/menu/admin/update' : 
                    '${pageContext.request.contextPath}/menu/admin/add';
                
                fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(menu)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(menuId ? '更新成功' : '添加成功');
                        // 关闭模态框
                        menuModal.style.display = 'none';
                        // 刷新页面显示最新数据
                        location.reload();
                    } else {
                        alert((menuId ? '更新' : '添加') + '失败：' + data.message);
                    }
                })
                .catch(error => {
                    console.error('保存菜品出错：', error);
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
            cancelBtn.addEventListener('click', () => closeModal(menuModal));
            deleteCancelBtn.addEventListener('click', () => closeModal(deleteModal));
            
            // 点击模态框外部关闭
            window.addEventListener('click', function(e) {
                if (e.target === menuModal) {
                    closeModal(menuModal);
                }
                if (e.target === deleteModal) {
                    closeModal(deleteModal);
                }
            });
        });
    </script>
</body>
</html> 