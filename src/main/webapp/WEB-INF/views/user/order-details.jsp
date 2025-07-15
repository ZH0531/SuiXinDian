<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单详情 - 随心点</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="icon" href="<c:url value="/static/images/favicon.ico"/>" type="image/x-icon">

    <style>
        /* 简约风格的订单详情页面 */
        .order-container {
            max-width: 800px;
            margin: 2rem auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .order-header {
            padding-bottom: 1.2rem;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid #f0f0f0;
        }
        .order-header h1 {
            margin: 0 0 0.8rem 0;
            font-size: 1.4rem;
            font-weight: 500;
            color: #333;
        }
        .order-meta {
            color: #666;
            font-size: 0.9rem;
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .order-meta-item {
            display: flex;
            align-items: center;
        }
        .order-meta-item i {
            margin-right: 0.4rem;
            color: #888;
        }
        .order-status {
            font-weight: 500;
            padding: 0.2rem 0.6rem;
            border-radius: 4px;
            background: #f8f8f8;
        }
        .order-items {
            width: 100%;
            border-collapse: collapse;
        }
        .order-items th {
            text-align: left;
            padding: 0.8rem 1rem;
            background: #f9f9f9;
            font-weight: 500;
            color: #555;
            border-bottom: 1px solid #eee;
        }
        .order-items td {
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
        }
        .order-items tr:last-child td {
            border-bottom: none;
        }
        .total-row td {
            padding-top: 1.2rem;
            font-weight: 500;
        }
        .price {
            color: #e05a2a;
            font-weight: 500;
        }
        .total-price {
            color: #e05a2a;
            font-weight: 600;
            font-size: 1.05rem;
        }
        .btn-group {
            margin-top: 1.8rem;
            display: flex;
            gap: 1rem;
        }
        .btn {
            padding: 0.6rem 1.2rem;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
        }
        .btn-primary {
            background: var(--primary-color);
            color: white;
        }
        .btn-secondary {
            background: #f5f5f5;
            color: #444;
        }
        .btn i {
            margin-right: 0.4rem;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
                                <a href="${pageContext.request.contextPath}/login" class="header-user-area">
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

<div class="order-container">
    <div class="order-header">
        <h1>订单详情</h1>
        <div class="order-meta">
            <div class="order-meta-item">
                <i class="fas fa-hashtag"></i>
                <span>订单号: ${order.orderNo}</span>
            </div>
            <div class="order-meta-item">
                <i class="far fa-calendar-alt"></i>
                <span>创建时间: <fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm"/></span>
            </div>
            <div class="order-meta-item">
                <i class="fas fa-info-circle"></i>
                <span>状态: <span class="order-status">${order.status == 1 ? '已完成' : (order.status == 2 ? '已取消' : '未支付')}</span></span>
            </div>
        </div>
    </div>

    <table class="order-items">
        <thead>
        <tr>
            <th>菜品名称</th>
            <th>数量</th>
            <th>单价</th>
            <th>小计</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${order.orderItems}" var="item">
            <tr>
                <td>${item.menuName}</td>
                <td>${item.quantity}</td>
                <td><span class="price">¥<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></span></td>
                <td><span class="price">¥<fmt:formatNumber value="${item.totalPrice}" pattern="#,##0.00"/></span></td>
            </tr>
        </c:forEach>
        <tr class="total-row">
            <td colspan="3">合计</td>
            <td><span class="total-price">¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></span></td>
        </tr>
        </tbody>
    </table>

    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> 返回订单列表
        </a>
        <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">
            <i class="fas fa-utensils"></i> 继续点餐
        </a>
    </div>
</div>

<script>
    // 显示用户下拉菜单
    document.addEventListener('DOMContentLoaded', function() {
        const userMenu = document.querySelector('.user-menu');
        if (userMenu) {
            const dropdown = userMenu.querySelector('.user-dropdown');
            if (dropdown) {
                userMenu.addEventListener('mouseenter', function() {
                    dropdown.style.display = 'block';
                });
                userMenu.addEventListener('mouseleave', function() {
                    dropdown.style.display = 'none';
                });
            }
        }
    });
</script>
</body>
</html> 