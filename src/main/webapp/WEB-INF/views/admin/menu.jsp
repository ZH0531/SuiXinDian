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
                <div>
                    <i class="fas fa-book-open"></i> 菜品管理
                </div>
                <div>
                    <button class="btn btn-primary" onclick="showAddModal()">
                        <i class="fas fa-plus"></i> 添加菜品
                    </button>
                </div>
            </div>
            
            <div class="menu-grid" id="menuGrid">
                <c:forEach var="menu" items="${allMenus}">
                    <div class="menu-card" data-id="${menu.id}">
                        <div class="menu-image">
                            <img src="${pageContext.request.contextPath}${menu.imageUrl}" 
                                 alt="${menu.name}"
                                 onerror="this.src='${pageContext.request.contextPath}/static/images/dishes/default.jpg'">
                        </div>
                        <div class="menu-info">
                            <div class="menu-name">${menu.name}</div>
                            <div class="menu-desc">${menu.description}</div>
                            <c:if test="${not empty menu.tags}">
                                <div class="menu-tags">
                                    <c:forTokens items="${menu.tags}" delims="," var="tag">
                                        <span class="tag">${tag}</span>
                                    </c:forTokens>
                                </div>
                            </c:if>
                            <div class="menu-meta">
                                <div class="menu-price">¥${menu.price}</div>
                                <div class="menu-no">编号: ${menu.menuNo}</div>
                            </div>
                            <div class="menu-actions">
                                <button class="btn btn-primary" onclick="editMenu('${menu.id}')">
                                    <i class="fas fa-edit"></i> 编辑
                                </button>
                                <button class="btn btn-danger" onclick="deleteMenu('${menu.id}', '${menu.name}')">
                                    <i class="fas fa-trash"></i> 删除
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <c:if test="${empty allMenus}">
                <div style="text-align: center; padding: 50px; color: #666;">
                    <i class="fas fa-utensils" style="font-size: 48px; margin-bottom: 20px; opacity: 0.3;"></i>
                    <p>暂无菜品，点击上方按钮添加第一个菜品</p>
                </div>
            </c:if>
        </div>
    </div>
    
    <footer>
        <div class="container">
            <p>© 2023 随心点 | 后台管理系统</p>
        </div>
    </footer>

    <script>
        // 显示添加菜品模态框
        function showAddModal() {
            alert('添加菜品功能正在开发中...');
        }
        
        // 编辑菜品
        function editMenu(menuId) {
            alert('编辑菜品功能正在开发中...');
        }
        
        // 删除菜品
        function deleteMenu(menuId, menuName) {
            if (confirm('确定要删除菜品 "' + menuName + '" 吗？此操作不可恢复！')) {
                // 发送删除请求
                fetch('${pageContext.request.contextPath}/menu/admin/delete/' + menuId, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('删除成功！');
                        location.reload();
                    } else {
                        alert('删除失败：' + data.message);
                    }
                })
                .catch(error => {
                    alert('网络错误，请稍后重试');
                });
            }
        }
    </script>
</body>
</html> 