<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户中心 - 随心点</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 用户中心特定样式，不包含导航栏样式 */
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .main-content {
            padding: 30px 0;
        }
        
        .page-title {
            margin-bottom: 30px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        
        .page-title h1 {
            margin: 0;
            font-size: 28px;
            color: #333;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 20px;
        }
        
        .sidebar {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            padding: 20px;
        }
        
        .user-profile {
            text-align: center;
            padding-bottom: 20px;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 40px;
            color: #777;
        }
        
        .user-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .user-since {
            font-size: 14px;
            color: #777;
        }
        
        .menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .menu-item {
            margin-bottom: 10px;
        }
        
        .menu-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #333;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        
        .menu-link:hover {
            background-color: #f8f9fa;
            transform: translateX(5px);
        }
        
        .menu-link.active {
            background-color: #FF6B35;
            color: white;
        }
        
        .menu-icon {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .content-area {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            padding: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .content-area:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .welcome-message {
            background-color: #f8f9fa;
            border-left: 4px solid #FF6B35;
            padding: 15px;
            margin-bottom: 30px;
            border-radius: 0 5px 5px 0;
            position: relative;
        }
        
        .welcome-message h2 {
            margin-bottom: 10px;
            font-size: 20px;
        }
        
        .welcome-message p {
            margin-bottom: 0;
            color: #666;
        }
        
        .start-order-btn {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 14px;
            padding: 8px 15px;
            background-color: #FF6B35;
            color: white;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s ease;
        }
        
        .start-order-btn:hover {
            background-color: #E05A2A;
            transform: translateY(-50%) translateX(-2px);
            box-shadow: 0 4px 8px rgba(255, 107, 53, 0.3);
        }
        
        .start-order-btn i {
            margin-right: 8px;
        }
        
        .stats-row {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background-color: white;
            border: 1px solid #eee;
            border-radius: 5px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            flex: 1;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .stat-card:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transform: translateY(-5px);
        }
        
        .stat-icon {
            font-size: 32px;
            margin-bottom: 15px;
            color: #FF6B35;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .stat-value {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .stat-label {
            color: #777;
            font-size: 15px;
        }
        
        .recent-orders {
            margin-top: 30px;
        }
        
        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .section-title h2 {
            margin: 0;
            font-size: 18px;
            color: #333;
        }
        
        .view-all {
            color: #FF6B35;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.2s ease;
        }
        
        .view-all:hover {
            color: #E05A2A;
            text-decoration: underline;
        }
        
        .order-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .order-item {
            border: 1px solid #eee;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 10px;
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            align-items: center;
            transition: all 0.3s ease;
        }
        
        .order-item:hover {
            border-color: #FF6B35;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .order-info .order-id {
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .order-date {
            font-size: 14px;
            color: #777;
        }
        
        .order-status {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            text-align: center;
            width: 80px;
            display: inline-block;
        }
        
        .status-completed {
            background-color: #e3fcef;
            color: #00a854;
        }
        
        .status-processing {
            background-color: #e6f7ff;
            color: #1890ff;
        }
        
        .status-pending {
            background-color: #fff7e6;
            color: #fa8c16;
        }
        
        .order-amount {
            font-weight: bold;
            font-size: 16px;
            color: #333;
            text-align: center;
        }
        
        .btn {
            background-color: #FF6B35;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .btn:hover {
            background-color: #E05A2A;
            transform: translateY(-2px);
        }
        
        .order-action {
            text-align: center;
        }
        
        /* 自定义用户菜单样式 */
        .header-user-area {
            display: flex;
            align-items: center;
            color: var(--text-color);
            text-decoration: none;
            border-radius: 4px;
            padding: 5px 10px;
            transition: all 0.3s ease;
            background: transparent;
        }
        
        .header-user-area:hover {
            background-color: rgba(0, 0, 0, 0.05);
        }
        
        .header-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #777;
            margin-left: 8px;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <a href="${pageContext.request.contextPath}/" class="logo">
                    <i class="fas fa-utensils"></i> 随心点
                </a>
                <nav>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> 首页</a></li>
                        <li><a href="${pageContext.request.contextPath}/menu"><i class="fas fa-book-open"></i> 菜单</a></li>
                        <li><a href="${pageContext.request.contextPath}/about"><i class="fas fa-info-circle"></i> 关于我们</a></li>
                        
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <!-- 已登录状态 -->
                                <li class="user-menu">
                                    <a href="${pageContext.request.contextPath}/user/dashboard" class="header-user-area">
                                        <span class="user-name">${user.username}</span>
                                        <div class="header-avatar">
                                            <i class="fas fa-user"></i>
                                        </div>
                                    </a>
                                    <div class="user-dropdown">
                                        <div class="user-dropdown-header">
                                            <div class="user-dropdown-name">${user.username}</div>
                                            <div class="user-dropdown-role">
                                                <c:choose>
                                                    <c:when test="${user.role == 1}">管理员</c:when>
                                                    <c:otherwise>普通用户</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <c:if test="${user.role == 1}">
                                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-link"><i class="fas fa-tachometer-alt"></i> 管理后台</a>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/user/dashboard"><i class="fas fa-user-circle"></i> 个人中心</a>
                                        <a href="${pageContext.request.contextPath}/user/orders"><i class="fas fa-clipboard-list"></i> 我的订单</a>
                                        <div class="divider"></div>
                                        <a href="${pageContext.request.contextPath}/user/logout"><i class="fas fa-sign-out-alt"></i> 退出登录</a>
                                    </div>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <!-- 未登录状态 -->
                                <li class="user-menu">
                                    <a href="javascript:void(0);" onclick="showLoginTip();" class="header-user-area">
                                        <span class="user-name">未登录</span>
                                        <div class="header-avatar" style="background-color: #ccc;">
                                            <i class="fas fa-user"></i>
                                        </div>
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </nav>
            </div>
        </div>
    </header>
    <!-- 主要内容 -->
    <main class="main-content">
        <div class="container">
            <div class="page-title">
                <h1>用户中心</h1>
            </div>
            
            <div class="dashboard-grid">
                <div class="sidebar">
                    <div class="user-profile">
                        <div class="avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="user-name">${user.username != null ? user.username : user.userId}</div>
                    </div>
                    
                    <ul class="menu">
                        <li class="menu-item">
                            <a href="javascript:void(0);" class="menu-link active" onclick="showContent('welcome')">
                                <span class="menu-icon"><i class="fas fa-tachometer-alt"></i></span>
                                控制面板
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="${pageContext.request.contextPath}/user/orders" class="menu-link">
                                <span class="menu-icon"><i class="fas fa-clipboard-list"></i></span>
                                我的订单
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="javascript:void(0);" class="menu-link" onclick="showNotSupported('我的收藏')">
                                <span class="menu-icon"><i class="fas fa-heart"></i></span>
                                我的收藏
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="javascript:void(0);" class="menu-link" onclick="showContent('profile')">
                                <span class="menu-icon"><i class="fas fa-user-cog"></i></span>
                                个人资料
                            </a>
                        </li>
                        <li class="menu-item">
                            <a href="javascript:void(0);" class="menu-link" onclick="showNotSupported('收货地址')">
                                <span class="menu-icon"><i class="fas fa-map-marker-alt"></i></span>
                                收货地址
                            </a>
                        </li>
                    </ul>
                </div>
                
                <div class="content-area" id="contentArea">
                    <!-- 默认控制面板内容 -->
                    <div id="welcome-content">
                        <div class="welcome-message">
                            <h2>欢迎回来，${user.username}！</h2>
                            <p>今天想吃点什么呢？浏览我们的菜单，开始点餐吧！</p>
                            <a href="${pageContext.request.contextPath}/menu" class="start-order-btn">
                                <i class="fas fa-utensils"></i> 开始点餐
                            </a>
                        </div>
                        
                        <div class="stats-row">
                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-shopping-cart"></i>
                                </div>
                                <div class="stat-value">8</div>
                                <div class="stat-label">历史订单</div>
                            </div>
                            
                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-heart"></i>
                                </div>
                                <div class="stat-value">12</div>
                                <div class="stat-label">收藏菜品</div>
                            </div>
                            
                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="stat-value">5</div>
                                <div class="stat-label">我的评价</div>
                            </div>
                        </div>
                        
                        <div class="recent-orders">
                            <div class="section-title">
                                <h2>最近订单</h2>
                                <a href="${pageContext.request.contextPath}/user/orders" class="view-all">查看全部</a>
                            </div>
                            
                            <div class="order-list">
                                <c:choose>
                                    <c:when test="${latestOrder != null}">
                                        <div class="order-item">
                                            <div class="order-info">
                                                <div class="order-id">订单号: ${latestOrder.orderNo}</div>
                                                <div class="order-date">
                                                    <fmt:formatDate value="${latestOrder.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                                                </div>
                                            </div>
                                            <div class="order-status status-completed">
                                                <c:choose>
                                                    <c:when test="${latestOrder.status == 1}">已完成</c:when>
                                                    <c:when test="${latestOrder.status == 0}">处理中</c:when>
                                                    <c:otherwise>未知</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="order-amount">¥${latestOrder.totalAmount}</div>
                                            <div class="order-action">
                                                <a href="${pageContext.request.contextPath}/user/order/${latestOrder.id}" class="btn">订单详情</a>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-orders">
                                            <p>您还没有订单记录</p>
                                            <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">去下单</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- 页面底部 -->
    <footer class="main-footer">
        <div class="footer-bottom">
            <p>&copy; 2023 随心点餐厅. 保留所有权利.</p>
        </div>
    </footer>

    <script>
        function showContent(type) {
            console.log('showContent called with type:', type);
            const contentArea = document.getElementById('contentArea');
            const menuLinks = document.querySelectorAll('.menu-link');
            
            if (!contentArea) {
                console.error('Content area not found!');
                return;
            }
            
            // 移除所有菜单项的active类
            menuLinks.forEach(link => link.classList.remove('active'));
            
            if (type === 'welcome') {
                // 显示默认控制面板内容
                const welcomeContent = document.getElementById('welcome-content');
                if (welcomeContent) {
                    contentArea.innerHTML = welcomeContent.outerHTML;
                }
                // 添加active类到控制面板
                const welcomeLink = document.querySelector('a[onclick*="welcome"]');
                if (welcomeLink) {
                    welcomeLink.classList.add('active');
                }
            } else if (type === 'profile') {
                // 加载个人资料内容
                loadProfileContent();
                // 添加active类到个人资料
                const profileLink = document.querySelector('a[onclick*="profile"]');
                if (profileLink) {
                    profileLink.classList.add('active');
                }
            }
        }
        
        function loadProfileContent() {
            const contentArea = document.getElementById('contentArea');
            contentArea.innerHTML = '<div style="text-align: center; padding: 50px;"><i class="fas fa-spinner fa-spin"></i> 加载中...</div>';
            
            // 使用fetch加载个人资料页面
            fetch('${pageContext.request.contextPath}/user/profile')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.text();
                })
                .then(html => {
                    console.log('Profile content loaded successfully');
                    
                    // 提取HTML内容和script内容
                    const tempDiv = document.createElement('div');
                    tempDiv.innerHTML = html;
                    
                    // 查找script标签
                    const scripts = tempDiv.querySelectorAll('script');
                    
                    // 先设置HTML内容（排除script标签）
                    const scriptElements = Array.from(scripts);
                    scriptElements.forEach(script => script.remove());
                    contentArea.innerHTML = tempDiv.innerHTML;
                    
                    // 然后执行script内容
                    setTimeout(function() {
                        console.log('Executing profile page scripts...');
                        
                        scriptElements.forEach(function(script) {
                            try {
                                // 创建新的script元素并执行
                                const newScript = document.createElement('script');
                                newScript.textContent = script.textContent;
                                document.head.appendChild(newScript);
                                
                                // 执行完后立即移除，避免重复
                                setTimeout(() => document.head.removeChild(newScript), 100);
                            } catch (e) {
                                console.error('Error executing script:', e);
                            }
                        });
                        
                        // 等待脚本执行完成后检查函数
                        setTimeout(function() {
                            console.log('Checking for profile functions...');
                            console.log('editField available:', typeof window.editField);
                            console.log('closeEditModal available:', typeof window.closeEditModal);
                            console.log('changePassword available:', typeof window.changePassword);
                            console.log('backToDashboard available:', typeof window.backToDashboard);
                            
                            // 如果函数还是不可用，手动定义必要的函数
                            if (typeof window.editField !== 'function') {
                                console.log('Manually defining profile functions...');
                                defineProfileFunctions();
                            }
                            
                            // 测试编辑按钮
                            const editButtons = document.querySelectorAll('.edit-btn');
                            console.log('Found ' + editButtons.length + ' edit buttons');
                            
                            // 为编辑按钮重新绑定事件作为后备方案
                            editButtons.forEach(function(button, index) {
                                const onclickAttr = button.getAttribute('onclick');
                                console.log('Button ' + index + ' onclick:', onclickAttr);
                                
                                // 如果onclick不起作用，添加直接的事件监听器
                                if (onclickAttr) {
                                    button.addEventListener('click', function(e) {
                                        e.preventDefault();
                                        try {
                                            // 解析onclick属性中的函数调用
                                            const match = onclickAttr.match(/editField\('([^']+)'\)/);
                                            if (match && window.editField) {
                                                window.editField(match[1]);
                                            }
                                        } catch (error) {
                                            console.error('Error in button click handler:', error);
                                        }
                                    });
                                }
                            });
                            
                            // 初始化表单事件
                            if (window.initProfilePage) {
                                try {
                                    window.initProfilePage();
                                } catch (e) {
                                    console.error('Error initializing profile page:', e);
                                }
                            }
                        }, 500);
                    }, 100);
                })
                .catch(error => {
                    console.error('Error loading profile:', error);
                    contentArea.innerHTML = '<div style="text-align: center; padding: 50px; color: #dc3545;"><i class="fas fa-exclamation-triangle"></i> 加载失败，请稍后重试<br><small>' + error.message + '</small></div>';
                });
        }
        
        // 手动定义profile页面的核心函数作为后备方案
        function defineProfileFunctions() {
            window.currentField = '';
            
            window.editField = function(field) {
                try {
                    console.log('Manual editField called with:', field);
                    window.currentField = field;
                    
                    const modal = document.getElementById('editModal');
                    if (!modal) {
                        alert('模态框元素未找到，请刷新页面重试');
                        return;
                    }
                    
                    const title = document.getElementById('modalTitle');
                    const label = document.getElementById('fieldLabel');
                    const input = document.getElementById('fieldValue');
                    const select = document.getElementById('fieldSelect');
                    const currentValue = document.getElementById(field + '-display').textContent.trim();
                    
                    // 重置表单
                    input.style.display = 'block';
                    select.style.display = 'none';
                    input.type = 'text';
                    
                    switch(field) {
                        case 'username':
                            title.textContent = '编辑用户名';
                            label.textContent = '用户名:';
                            input.value = currentValue === '未设置' ? '' : currentValue;
                            break;
                        case 'phone':
                            title.textContent = '编辑手机号码';
                            label.textContent = '手机号码:';
                            input.value = currentValue === '未设置' ? '' : currentValue;
                            input.type = 'tel';
                            break;
                        case 'email':
                            title.textContent = '编辑邮箱地址';
                            label.textContent = '邮箱地址:';
                            input.value = currentValue === '未设置' ? '' : currentValue;
                            input.type = 'email';
                            break;
                        case 'gender':
                            title.textContent = '设置性别';
                            label.textContent = '性别:';
                            input.style.display = 'none';
                            select.style.display = 'block';
                            const genderValue = currentValue === '男' ? '1' : (currentValue === '女' ? '0' : '');
                            select.value = genderValue;
                            break;
                    }
                    
                    modal.style.display = 'flex';
                    modal.style.zIndex = '10000';
                    
                    // 聚焦到输入框
                    setTimeout(() => {
                        if (input.style.display !== 'none') {
                            input.focus();
                        } else {
                            select.focus();
                        }
                    }, 100);
                    
                } catch (error) {
                    console.error('Error in manual editField:', error);
                    alert('发生错误：' + error.message);
                }
            };
            
            window.closeEditModal = function() {
                const modal = document.getElementById('editModal');
                if (modal) {
                    modal.style.display = 'none';
                }
            };
            
            window.backToDashboard = function() {
                // 直接重定向到用户面板
                window.location.href = '${pageContext.request.contextPath}/user/dashboard';
            };
            
            window.changePassword = function() {
                const modal = document.getElementById('editModal');
                const title = document.getElementById('modalTitle');
                const modalBody = document.querySelector('.modal-body');
                
                if (!modal || !title || !modalBody) {
                    alert('页面元素未找到，请刷新页面重试');
                    return;
                }
                
                title.textContent = '修改密码';
                
                modalBody.innerHTML = '<form id="passwordForm">' +
                    '<div class="form-group">' +
                        '<label>当前密码:</label>' +
                        '<input type="password" id="currentPassword" class="form-control" required>' +
                    '</div>' +
                    '<div class="form-group">' +
                        '<label>新密码:</label>' +
                        '<input type="password" id="newPassword" class="form-control" required minlength="6">' +
                        '<small class="form-text">至少6位字符</small>' +
                    '</div>' +
                    '<div class="form-group">' +
                        '<label>确认新密码:</label>' +
                        '<input type="password" id="confirmPassword" class="form-control" required>' +
                    '</div>' +
                    '<div class="form-actions">' +
                        '<button type="button" class="btn btn-secondary" onclick="closeEditModal()">取消</button>' +
                        '<button type="submit" class="btn">确定</button>' +
                    '</div>' +
                '</form>';
                
                modal.style.display = 'flex';
                
                // 绑定密码表单提交事件
                setTimeout(function() {
                    const passwordForm = document.getElementById('passwordForm');
                    if (passwordForm) {
                        passwordForm.addEventListener('submit', function(e) {
                            e.preventDefault();
                            
                            const currentPassword = document.getElementById('currentPassword').value;
                            const newPassword = document.getElementById('newPassword').value;
                            const confirmPassword = document.getElementById('confirmPassword').value;
                            
                            if (newPassword !== confirmPassword) {
                                alert('两次输入的密码不一致');
                                return;
                            }
                            
                            if (newPassword.length < 6) {
                                alert('新密码至少需要6位字符');
                                return;
                            }
                            
                            // 发送密码修改请求
                            fetch('${pageContext.request.contextPath}/user/profile/update', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'currentPassword=' + encodeURIComponent(currentPassword) + 
                                      '&newPassword=' + encodeURIComponent(newPassword)
                            })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    alert('密码修改成功！');
                                    window.closeEditModal();
                                } else {
                                    alert(data.message || '密码修改失败');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                alert('网络错误，请稍后重试');
                            });
                        });
                    }
                }, 100);
            };
            
            window.updateUserField = function(field, value) {
                fetch('${pageContext.request.contextPath}/user/updateProfile', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: field + '=' + encodeURIComponent(value)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // 更新显示值
                        let displayValue = value;
                        if (field === 'gender') {
                            displayValue = value === '1' ? '男' : (value === '0' ? '女' : '未设置');
                        }
                        
                        const displayElement = document.getElementById(field + '-display');
                        if (displayElement) {
                            displayElement.textContent = displayValue || '未设置';
                        }
                        
                        window.closeEditModal();
                        alert('更新成功！');
                    } else {
                        alert(data.message || '更新失败');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('网络错误，请稍后重试');
                });
            };
            
            // 绑定表单提交事件
            setTimeout(function() {
                const editForm = document.getElementById('editForm');
                if (editForm) {
                    editForm.addEventListener('submit', function(e) {
                        e.preventDefault();
                        
                        const fieldValue = document.getElementById('fieldValue').style.display === 'none' 
                            ? document.getElementById('fieldSelect').value 
                            : document.getElementById('fieldValue').value;
                        
                        if (!fieldValue.trim() && window.currentField !== 'gender') {
                            alert('请输入有效的值');
                            return;
                        }
                        
                        window.updateUserField(window.currentField, fieldValue);
                    });
                    
                    console.log('Form submit handler bound');
                }
            }, 100);
            
            console.log('Manual profile functions defined');
        }
        
        // 显示功能暂不支持的提示
        function showNotSupported(featureName) {
            alert('抱歉，' + featureName + ' 功能暂未开放，敬请期待！');
        }

        // 页面加载完成后的初始化
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Dashboard page loaded');
            
            // 确保默认显示控制面板
            showContent('welcome');
        });
    </script>
</body>
</html> 