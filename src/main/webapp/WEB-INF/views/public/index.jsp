<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>随心点 - 时尚快餐点餐系统</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 首页特定样式 */
        .main-content {
            display: flex;
            margin: 40px 0;
            gap: 40px;
            min-height: calc(100vh - 250px);
        }
        
        .intro-section {
            flex: 3;
        }
        
        .login-section {
            flex: 2;
        }
        
        /* 介绍部分 */
        .intro-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 30px;
            margin-bottom: 30px;
            transition: transform 0.3s ease;
        }
        
        .intro-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        
        .section-title {
            font-size: 24px;
            margin-bottom: 15px;
            color: var(--primary-dark);
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            margin-right: 10px;
            color: var(--primary-color);
        }
        
        .intro-text {
            margin-bottom: 20px;
            color: var(--light-text);
        }
        
        .feature-list {
            list-style: none;
        }
        
        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .feature-content p {
            color: var(--light-text);
            font-size: 14px;
        }
        
        /* 登录卡片 */
        .login-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 30px;
            margin-bottom: 30px;
            transition: transform 0.3s ease;
        }
        
        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 25px;
        }
        
        .login-header h2 {
            color: var(--primary-color);
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .login-header p {
            color: var(--light-text);
            font-size: 14px;
        }
        
        .login-form .form-group {
            margin-bottom: 20px;
        }
        
        .login-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        .login-form input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .login-form input:focus {
            border-color: var(--primary-color);
            outline: none;
        }
        
        .login-form button {
            width: 100%;
            padding: 12px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        
        .login-form button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .login-links {
            text-align: center;
            margin-top: 20px;
        }
        
        .login-links a {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 14px;
            margin: 0 10px;
            transition: color 0.3s ease;
        }
        
        .login-links a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        
        /* 页面导航卡片 */
        .nav-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 20px;
        }
        
        .nav-list {
            list-style: none;
        }
        
        .nav-item {
            margin-bottom: 10px;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
            text-decoration: none;
            color: var(--text-color);
            transition: all 0.3s ease;
        }
        
        .nav-link:hover {
            background-color: var(--primary-light);
            color: white;
            transform: translateX(5px);
        }
        
        .nav-icon {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        /* 登录选项卡 */
        .login-options {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        
        .login-option {
            flex: 1;
            text-align: center;
            padding: 8px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .login-option.active {
            background-color: rgba(255, 107, 53, 0.2);
            font-weight: bold;
        }
        
        .login-option:hover {
            background-color: rgba(255, 107, 53, 0.1);
            transform: translateY(-2px);
        }
        
        /* 页脚样式 */
        .footer-content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        
        .footer-section {
            flex: 1;
            min-width: 200px;
            margin-bottom: 20px;
        }
        
        .footer-logo {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #dfe6e9;
        }
        
        .footer-links a {
            display: block;
            margin-bottom: 10px;
            color: #dfe6e9;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .footer-links a:hover {
            color: var(--primary-color);
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        /* 响应式布局 */
        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
            }
            
            .login-section {
                order: -1;
            }
        }
        
        /* 动画效果 */
        @keyframes shake {
            0% { transform: translateX(0); }
            20% { transform: translateX(-10px); }
            40% { transform: translateX(10px); }
            60% { transform: translateX(-10px); }
            80% { transform: translateX(10px); }
            100% { transform: translateX(0); }
        }
        
        .shake-animation {
            animation: shake 0.5s linear;
        }
        
        /* 添加快捷入口链接的悬停特效 */
        .feature-link-wrapper {
            text-decoration: none;
            color: inherit;
            display: block;
            margin-bottom: 15px;
        }
        
        .feature-link-wrapper:hover .feature-item {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: rgba(255, 255, 255, 0.8);
        }
        
        .feature-link-wrapper:hover h3 {
            color: var(--primary-color);
        }
        
        .admin-feature:hover h3 {
            color: #333;
        }
        
        .feature-item {
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            padding: 10px;
        }
        
        .admin-item:hover {
            background-color: rgba(51, 51, 51, 0.05);
        }
        
        .feature-icon {
            margin-right: 15px;
            width: 40px;
            height: 40px;
            background-color: var(--primary-light);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        
        .admin-icon {
            background-color: #333;
        }
        
        .feature-content h3 {
            font-size: 18px;
            margin-bottom: 5px;
            transition: color 0.3s ease;
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
                        <li><a href="${pageContext.request.contextPath}/" class="active"><i class="fas fa-home"></i> 首页</a></li>
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

    <div class="container">
        <div class="main-content">
            <div class="intro-section">
                <div class="intro-card">
                    <h2 class="section-title"><i class="fas fa-star"></i> 随心点 - 让点餐更简单</h2>
                    <p class="intro-text">
                        "随心点"是面向年轻人的时尚快餐点餐系统，旨在提供极简、便捷的点餐体验。用户可轻松注册登录、浏览菜品、在线点餐支付、查询订单。同时，展示餐厅信息，并提供强大的后台管理系统。让用户随时随地，想点就点！
                    </p>
                    
                    <ul class="feature-list">
                        <li class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="feature-content">
                                <h3>便捷登录与注册</h3>
                                <p>支持用户名、手机号和邮箱多种方式登录，新用户可快速注册账号。</p>
                            </div>
                        </li>
                        <li class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-utensils"></i>
                            </div>
                            <div class="feature-content">
                                <h3>丰富的菜品选择</h3>
                                <p>多种菜品分类，详细的菜品信息，图文并茂，让您挑选更轻松。</p>
                            </div>
                        </li>
                        <li class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <div class="feature-content">
                                <h3>便捷的订单流程</h3>
                                <p>快速添加购物车，一键下单，支持多种支付方式。</p>
                            </div>
                        </li>
                        <li class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-history"></i>
                            </div>
                            <div class="feature-content">
                                <h3>订单追踪与历史</h3>
                                <p>实时追踪订单状态，查看历史订单，一目了然。</p>
                            </div>
                        </li>
                    </ul>
                </div>
                
                <div class="nav-card">
                    <h2 class="section-title"><i class="fas fa-link"></i> 页面导航</h2>
                    <ul class="nav-list">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/" class="nav-link">
                                <span class="nav-icon"><i class="fas fa-home"></i></span>
                                <span>首页</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/menu" class="nav-link">
                                <span class="nav-icon"><i class="fas fa-book-open"></i></span>
                                <span>菜单</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/about" class="nav-link">
                                <span class="nav-icon"><i class="fas fa-info-circle"></i></span>
                                <span>关于我们</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            
            <div class="login-section">
                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <!-- 已登录用户显示快捷入口 -->
                        <div class="intro-card">
                            <h2 class="section-title"><i class="fas fa-user-circle"></i> 欢迎回来，${user.username}</h2>
                            <p class="intro-text">您可以通过以下快捷入口访问系统功能：</p>
                            
                            <ul class="feature-list">
                                <c:if test="${user.role == 1}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="feature-link-wrapper admin-feature">
                                        <li class="feature-item admin-item">
                                            <div class="feature-icon admin-icon">
                                                <i class="fas fa-tachometer-alt"></i>
                                            </div>
                                            <div class="feature-content">
                                                <h3>管理后台</h3>
                                                <p>管理系统设置、用户、菜品和订单。</p>
                                            </div>
                                        </li>
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/user/dashboard" class="feature-link-wrapper">
                                    <li class="feature-item">
                                        <div class="feature-icon">
                                            <i class="fas fa-user-circle"></i>
                                        </div>
                                        <div class="feature-content">
                                            <h3>个人中心</h3>
                                            <p>查看和编辑个人信息、收货地址等。</p>
                                        </div>
                                    </li>
                                </a>
                                <a href="${pageContext.request.contextPath}/user/orders" class="feature-link-wrapper">
                                    <li class="feature-item">
                                        <div class="feature-icon">
                                            <i class="fas fa-clipboard-list"></i>
                                        </div>
                                        <div class="feature-content">
                                            <h3>我的订单</h3>
                                            <p>查看订单历史和当前订单状态。</p>
                                        </div>
                                    </li>
                                </a>
                                <a href="${pageContext.request.contextPath}/menu" class="feature-link-wrapper">
                                    <li class="feature-item">
                                        <div class="feature-icon">
                                            <i class="fas fa-utensils"></i>
                                        </div>
                                        <div class="feature-content">
                                            <h3>浏览菜单</h3>
                                            <p>查看最新菜品，开始点餐。</p>
                                        </div>
                                    </li>
                                </a>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 未登录用户显示登录表单 -->
                        <div class="login-card">
                            <div class="login-header">
                                <h2>登录账号</h2>
                                <p>登录后享受更多服务</p>
                            </div>
                            
                            <div id="errorMsg" class="error-message" style="display: none;">
                                <i class="fas fa-exclamation-circle"></i> <span id="errorText"></span>
                            </div>
                            
                            <!-- 登录选项卡 -->
                            <div class="login-options">
                                <div class="login-option active" data-type="username">用户名</div>
                                <div class="login-option" data-type="phone">手机号</div>
                                <div class="login-option" data-type="email">邮箱</div>
                            </div>
                            
                            <form action="${pageContext.request.contextPath}/user/login" method="post" class="login-form">
                                <div class="form-group" id="username-group">
                                    <label for="username"><i class="fas fa-user"></i> <span id="login-label">用户名</span></label>
                                    <input type="text" id="username" name="username" placeholder="请输入用户名/手机号/邮箱" required>
                                </div>
                                <div class="form-group">
                                    <label for="password"><i class="fas fa-lock"></i> 密码</label>
                                    <input type="password" id="password" name="password" placeholder="请输入密码" required>
                                </div>
                                
                                <div class="form-group" style="display: flex; align-items: center; margin-bottom: 15px;">
                                    <input type="checkbox" id="rememberMe" name="rememberMe" style="width: auto; margin-right: 8px;">
                                    <label for="rememberMe" style="margin-bottom: 0;">记住我</label>
                                </div>
                                
                                <input type="hidden" id="loginType" name="loginType" value="username">
                                
                                <button type="submit">
                                    <i class="fas fa-sign-in-alt"></i> 登 录
                                </button>
                            </form>
                            <div class="login-links">
                                <a href="${pageContext.request.contextPath}/user/register">注册新账号</a>
                            </div>
                        </div>
                        
                        <div class="intro-card">
                            <h2 class="section-title"><i class="fas fa-info-circle"></i> 管理员登录提示</h2>
                            <p class="intro-text">
                                管理员账号: <strong>admin</strong><br>
                                默认密码: <strong>123456</strong>
                            </p>
                            <p class="intro-text">
                                使用上述账号和密码登录后，将自动跳转至管理后台。
                            </p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <div class="footer-logo">
                        <i class="fas fa-utensils"></i> 随心点
                    </div>
                    <p>让用户随时随地，想点就点！</p>
                </div>
                <div class="footer-section">
                    <h3>快速链接</h3>
                    <div class="footer-links">
                        <a href="${pageContext.request.contextPath}/">首页</a>
                        <a href="${pageContext.request.contextPath}/menu">菜单</a>
                        <a href="${pageContext.request.contextPath}/about">关于我们</a>
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <a href="${pageContext.request.contextPath}/user/dashboard">个人中心</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/user/login">登录</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="footer-section">
                    <h3>联系我们</h3>
                    <p><i class="fas fa-phone"></i> 400-123-4567</p>
                    <p><i class="fas fa-envelope"></i> info@suixindian.com</p>
                    <p><i class="fas fa-map-marker-alt"></i> 武汉信息传播职业技术学院</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 随心点-点餐系统 | 保留所有权利</p>
            </div>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 登录选项卡切换
            const loginOptions = document.querySelectorAll('.login-option');
            const loginLabel = document.getElementById('login-label');
            const loginType = document.getElementById('loginType');
            const usernameInput = document.getElementById('username');
            const errorMsg = document.getElementById('errorMsg');
            
            if (loginOptions.length > 0) {
                loginOptions.forEach(option => {
                    option.addEventListener('click', function() {
                        // 移除所有active状态
                        loginOptions.forEach(opt => {
                            opt.classList.remove('active');
                        });
                        
                        // 当前选项添加active状态
                        this.classList.add('active');
                        
                        // 隐藏错误消息
                        if (errorMsg) {
                            errorMsg.style.display = 'none';
                        }
                        
                        // 更新登录类型和标签
                        const type = this.getAttribute('data-type');
                        loginType.value = type;
                        
                        switch(type) {
                            case 'phone':
                                loginLabel.textContent = '手机号';
                                usernameInput.placeholder = '请输入手机号';
                                break;
                            case 'email':
                                loginLabel.textContent = '邮箱';
                                usernameInput.placeholder = '请输入邮箱地址';
                                break;
                            case 'username':
                            default:
                                loginLabel.textContent = '用户名';
                                usernameInput.placeholder = '请输入用户名/手机号/邮箱';
                                break;
                        }
                    });
                });
            }
            
            // 简单的登录表单验证
            const loginForm = document.querySelector('.login-form');
            if (loginForm) {
                loginForm.addEventListener('submit', function(e) {
                    const username = document.getElementById('username').value.trim();
                    const password = document.getElementById('password').value;
                    const loginType = document.getElementById('loginType').value;
                    
                    if (username === '') {
                        e.preventDefault();
                        showError('请输入' + (loginType === 'phone' ? '手机号' : (loginType === 'email' ? '邮箱' : '用户名')));
                        return false;
                    }
                    
                    if (password === '') {
                        e.preventDefault();
                        showError('请输入密码');
                        return false;
                    }
                    
                    // 表单验证通过，提交表单
                    return true;
                });
            }
            
            // 错误提示函数
            function showError(message) {
                const errorMsg = document.getElementById('errorMsg');
                const errorText = document.getElementById('errorText');
                
                if (errorMsg && errorText) {
                    errorText.textContent = message;
                    errorMsg.style.display = 'block';
                    
                    // 添加shake动画
                    errorMsg.classList.remove('shake-animation');
                    void errorMsg.offsetWidth; // 触发重绘
                    errorMsg.classList.add('shake-animation');
                }
            }
            
            // 添加未登录提示功能
            window.showLoginTip = function() {
                // 高亮显示登录框
                const loginCard = document.querySelector('.login-card');
                if (loginCard) {
                    loginCard.style.boxShadow = '0 0 20px rgba(255, 107, 53, 0.5)';
                    
                    // 添加抖动动画
                    loginCard.classList.remove('shake-animation');
                    void loginCard.offsetWidth; // 触发重绘
                    loginCard.classList.add('shake-animation');
                    
                    // 1.5秒后恢复正常状态
                    setTimeout(() => {
                        loginCard.style.boxShadow = '';
                    }, 1500);
                }
                
                // 显示提示消息
                const errorMsg = document.getElementById('errorMsg');
                const errorText = document.getElementById('errorText');
                
                if (errorMsg && errorText) {
                    errorText.textContent = '请在下方登录';
                    errorMsg.style.display = 'block';
                    errorMsg.style.backgroundColor = '#e3f2fd';
                    errorMsg.style.color = '#1565c0';
                    
                    // 添加shake动画
                    errorMsg.classList.remove('shake-animation');
                    void errorMsg.offsetWidth; // 触发重绘
                    errorMsg.classList.add('shake-animation');
                    
                    // 3秒后隐藏提示
                    setTimeout(() => {
                        errorMsg.style.display = 'none';
                    }, 3000);
                }
            };
            
            // 如果URL中有错误提示，显示错误
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            if (error && errorMsg) {
                showError(decodeURIComponent(error));
            }
        });
    </script>
</body>
</html> 