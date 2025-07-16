<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
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
    <link rel="icon" href="<c:url value="/static/images/favicon.ico"/>" type="image/x-icon">
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
            color: #4a5568; /* 舒服的深灰色 */
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
            background: #FF6B35;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s ease-in-out;
            position: relative;
            overflow: hidden;
        }
        
        .login-form button:hover {
            background-color: #E05A2A;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 107, 53, 0.4);
        }
        
        .login-form button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.5s ease-out, height 0.5s ease-out;
            z-index: 1;
        }
        
        .login-form button:hover::before {
            width: 300px;
            height: 300px;
        }
        
        .login-form button span {
            position: relative;
            z-index: 2;
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
            transition: transform 0.3s ease;
        }
        
        .nav-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
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
            gap: 12px;
            margin-bottom: 20px;
            background-color: transparent;
            padding: 0;
            border: none;
            height: auto;
            position: relative;
        }
        
        .login-slider {
            display: none; /* 移除滑块 */
        }
        
        .login-option {
            flex: 1;
            text-align: center;
            padding: 14px 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            color: #666;
            font-weight: 500;
            font-size: 14px;
            background: #ffffff;
            border: 1px solid #e1e8ed;
            border-radius: 12px;
            outline: none;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            transform: scale(1);
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }
        
        .login-option::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(255, 107, 53, 0.05), rgba(255, 107, 53, 0.1));
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1;
        }
        
        .login-option:hover {
            color: #333;
            border-color: #FF6B35;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.15);
            background: #fefefe;
        }
        
        .login-option:hover::before {
            opacity: 1;
        }
        
        .login-option.active {
            color: #FF6B35;
            background: #fff8f6;
            border-color: #FF6B35;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.2);
            font-weight: 600;
        }
        
        .login-option.active::before {
            opacity: 0;
        }
        
        .login-option span {
            position: relative;
            z-index: 2;
            transition: transform 0.2s ease;
        }
        
        .login-option:active span {
            transform: scale(0.98);
        }
        
        /* 移除过度动画，保持简约 */
        .login-option.clicked {
            transform: translateY(-1px) scale(0.98);
            transition: transform 0.15s ease;
        }
        
        /* 修改表单标签图标颜色 */
        .login-form label i {
            color: #FF6B35;
            margin-right: 8px;
        }
        
        /* 页脚样式 */
        .footer-content {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 60px;
            margin-bottom: 20px;
            padding: 0 40px;
            max-width: 1200px;
            margin: 0 auto 20px auto;
        }
        
        .footer-section {
            margin-bottom: 15px;
        }
        
        .footer-section:first-child {
            text-align: left;
        }
        
        .footer-section:nth-child(2) {
            text-align: left;
        }
        
        .footer-section:last-child {
            text-align: left;
        }
        
        .footer-section h3 {
            color: #dfe6e9;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 12px;
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 6px;
            display: inline-block;
            margin: 0 0 12px 0;
        }
        
        .footer-logo {
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 12px;
            color: #dfe6e9;
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0 0 12px 0;
        }
        
        .footer-logo i {
            color: var(--primary-color);
            font-size: 24px;
        }
        
        .footer-section p {
            color: #bdc3c7;
            margin-bottom: 12px;
            line-height: 1.5;
            margin: 0 0 12px 0;
        }
        
        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin: 0;
            padding: 0;
        }
        
        .footer-links a {
            color: #bdc3c7;
            text-decoration: none;
            transition: color 0.3s ease;
            padding: 3px 0;
            display: block;
            margin: 0;
        }
        
        .footer-links a:hover {
            color: var(--primary-color);
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 15px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: 10px;
        }
        
        /* 联系信息样式 */
        .footer-section .contact-info {
            display: flex;
            align-items: center;
            color: #bdc3c7;
            margin: 0 0 8px 0;
            line-height: 1.4;
        }
        
        .footer-section .contact-info i {
            color: var(--primary-color);
            margin-right: 10px;
            width: 16px;
            text-align: center;
            flex-shrink: 0;
        }
        
        .footer-section .contact-info:last-child {
            margin-bottom: 0;
        }
        
        /* 页脚描述样式 */
        .footer-description {
            color: #bdc3c7;
            margin: 0 0 12px 0;
            line-height: 1.5;
        }
        
        /* 备案信息样式 */
        .footer-beian {
            color: #bdc3c7;
            text-decoration: none;
            transition: color 0.3s ease;
            font-size: 14px;
            display: block;
            margin: 8px 0 0 0;
        }
        
        .footer-beian:hover {
            color: var(--primary-color);
        }
        
        .footer-beian span {
            text-decoration: underline;
        }
        
        /* 响应式布局 */
        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
            }
            
            .login-section {
                order: -1;
            }
            
            /* 移动端页脚样式 */
            .footer-content {
                display: flex;
                flex-direction: column;
                gap: 15px;
                padding: 0 15px;
                text-align: center;
                margin: 0 auto 15px auto;
            }
            
            .footer-section {
                margin-bottom: 20px;
            }
            
            .footer-section h3 {
                font-size: 16px;
                margin-bottom: 12px;
            }
            
            .footer-logo {
                font-size: 24px;
                justify-content: center;
            }
            
            .footer-description {
                font-size: 14px;
                text-align: center;
            }
            
            .footer-beian {
                font-size: 12px;
                text-align: center;
            }
            
            .footer-section:first-child,
            .footer-section:nth-child(2),
            .footer-section:last-child {
                text-align: center;
            }
            
            .footer-links a {
                padding: 8px 0;
                font-size: 14px;
            }
            
            .footer-bottom {
                padding: 15px 0;
                margin-top: 10px;
            }
            
            /* 移动端联系信息 */
            .footer-section .contact-info {
                justify-content: center;
                font-size: 14px;
            }
            
            .footer-section .contact-info i {
                margin-right: 6px;
            }
        }
        
        /* 平板端页脚样式 */
        @media (max-width: 1024px) and (min-width: 769px) {
            .footer-content {
                gap: 40px;
                padding: 0 20px;
            }
            
            .footer-logo {
                font-size: 24px;
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
                            
                            <!-- 登录选项按钮 -->
                            <div class="login-options">
                                <button type="button" class="login-option active" data-type="phone">
                                    <span>手机号</span>
                                </button>
                                <button type="button" class="login-option" data-type="user_id">
                                    <span>用户ID</span>
                                </button>
                                <button type="button" class="login-option" data-type="email">
                                    <span>邮箱</span>
                                </button>
                            </div>
                            
                            <form action="${pageContext.request.contextPath}/user/login" method="post" class="login-form">
                                <div class="form-group" id="username-group">
                                    <label for="username"><i class="fas fa-user"></i> <span id="login-label">手机号</span></label>
                                    <input type="text" id="username" name="username" placeholder="请输入手机号" pattern="[0-9]{11}" inputmode="numeric" required>
                                </div>
                                <div class="form-group">
                                    <label for="password"><i class="fas fa-lock"></i> 密码</label>
                                    <input type="password" id="password" name="password" placeholder="请输入密码" required>
                                </div>
                                
                                <div class="form-group" style="display: flex; align-items: center; margin-bottom: 15px;">
                                    <input type="checkbox" id="rememberMe" name="rememberMe" style="width: auto; margin-right: 8px;">
                                    <label for="rememberMe" style="margin-bottom: 0;">记住我</label>
                                </div>
                                
                                <input type="hidden" name="loginType" value="phone" id="loginTypeInput">
                                
                                <button type="submit"><span>登 录</span></button>
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
                    <p class="footer-description">让用户随时随地，想点就点！</p>
                    <a href="https://beian.miit.gov.cn/" target="_blank" rel="noopener noreferrer" class="footer-beian">备案号：<span>鄂ICP备2023022652号-1</span></a>
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
                    <p class="contact-info"><i class="fas fa-phone"></i> 400-123-4567</p>
                    <p class="contact-info"><i class="fas fa-envelope"></i> info@suixindian.com</p>
                    <p class="contact-info"><i class="fas fa-map-marker-alt"></i> 武汉信息传播职业技术学院</p>
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
            const loginTypeInput = document.getElementById('loginTypeInput');
            const usernameInput = document.getElementById('username');
            const errorMsg = document.getElementById('errorMsg');
            console.log('Login options:', loginOptions.length);
            
            if (loginOptions.length > 0) {
                loginOptions.forEach((option, index) => {
                    option.addEventListener('click', function() {
                        console.log('Clicked option index:', index);
                        console.log('Option type:', this.getAttribute('data-type'));
                        
                        // 添加点击动画
                        this.classList.add('clicked');
                        setTimeout(() => {
                            this.classList.remove('clicked');
                        }, 300);
                        
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
                        loginTypeInput.value = type;
                        
                        switch(type) {
                            case 'phone':
                                loginLabel.textContent = '手机号';
                                usernameInput.placeholder = '请输入手机号';
                                usernameInput.setAttribute('pattern', '[0-9]{11}');
                                usernameInput.setAttribute('inputmode', 'numeric');
                                break;
                            case 'email':
                                loginLabel.textContent = '邮箱';
                                usernameInput.placeholder = '请输入邮箱地址';
                                usernameInput.setAttribute('type', 'email');
                                usernameInput.removeAttribute('pattern');
                                usernameInput.removeAttribute('inputmode');
                                break;
                            case 'user_id':
                            default:
                                loginLabel.textContent = '用户ID';
                                usernameInput.placeholder = '请输入用户ID';
                                usernameInput.setAttribute('type', 'text');
                                usernameInput.removeAttribute('pattern');
                                usernameInput.removeAttribute('inputmode');
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
                    const loginType = document.getElementById('loginTypeInput').value;
                    
                    if (username === '') {
                        e.preventDefault();
                        showError('请输入' + (loginType === 'phone' ? '手机号' : (loginType === 'email' ? '邮箱' : '用户ID')));
                        return false;
                    }
                    
                    // 根据登录类型进行特定验证
                    if (loginType === 'phone') {
                        if (!/^1\d{10}$/.test(username)) {
                            e.preventDefault();
                            showError('请输入正确的手机号格式');
                            return false;
                        }
                    } else if (loginType === 'email') {
                        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(username)) {
                            e.preventDefault();
                            showError('请输入正确的邮箱格式');
                            return false;
                        }
                    } else if (loginType === 'user_id') {
                        if (username.length < 3) {
                            e.preventDefault();
                            showError('用户ID长度不能少于3位');
                            return false;
                        }
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