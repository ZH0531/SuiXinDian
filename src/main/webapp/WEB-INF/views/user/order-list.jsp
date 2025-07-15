<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的订单 - 随心点</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="icon" href="<c:url value="/static/images/favicon.ico"/>" type="image/x-icon">

    <style>
        /* 简约风格的订单列表页面 */
        .orders-container {
            max-width: 900px;
            margin: 2rem auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .page-title {
            margin-bottom: 1.5rem;
            font-size: 1.6rem;
            font-weight: 500;
            color: #333;
            display: flex;
            align-items: center;
        }
        .page-title i {
            margin-right: 0.8rem;
            color: #666;
        }
        .orders-table {
            width: 100%;
            border-collapse: collapse;
        }
        .orders-table th {
            text-align: left;
            padding: 0.8rem 1rem;
            background: #f9f9f9;
            font-weight: 500;
            color: #555;
            border-bottom: 1px solid #eee;
        }
        .orders-table td {
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
        }
        .orders-table tr:hover {
            background-color: #fafafa;
        }
        .detail-link {
            color: var(--primary-color);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        .detail-link i {
            margin-right: 0.4rem;
        }
        .detail-link:hover {
            color: var(--primary-dark);
        }
        .price {
            color: #e05a2a;
            font-weight: 500;
        }
        .status-tag {
            display: inline-block;
            padding: 0.3rem 0.7rem;
            border-radius: 4px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .status-completed {
            background-color: #e8f5e9;
            color: #388e3c;
        }
        .status-cancelled {
            background-color: #ffebee;
            color: #d32f2f;
        }
        .status-pending {
            background-color: #fff8e1;
            color: #f57c00;
        }
        .empty-message {
            text-align: center;
            padding: 2rem;
            color: #666;
            font-size: 1.1rem;
        }
        .empty-message i {
            display: block;
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #ddd;
        }
        .empty-message p {
            margin-bottom: 1.5rem;
        }
        .order-btn {
            display: inline-block;
            background: #FF6B35;
            color: white;
            padding: 8px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        .order-btn:hover {
            background: #E05A2A;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
            text-decoration: none;
            color: white;
        }
        .order-btn i {
            display: inline-block;
            font-size: 0.9rem;
            margin-left: 0.4rem;
            color: white;
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

<div class="orders-container">
    <h1 class="page-title"><i class="fas fa-clipboard-list"></i> 我的订单</h1>
    
    <c:choose>
        <c:when test="${empty orders}">
            <div class="empty-message">
                <i class="fas fa-shopping-bag"></i>
                <p>您还没有任何订单</p>
                <a href="${pageContext.request.contextPath}/menu" class="order-btn">
                    去点餐 <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="orders-table">
                <thead>
                <tr>
                    <th>订单号</th>
                    <th>创建时间</th>
                    <th>金额</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td>${order.orderNo}</td>
                        <td><fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td><span class="price">¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></span></td>
                        <td>
                            <c:choose>
                                <c:when test="${order.status == 1}">
                                    <span class="status-tag status-completed">已完成</span>
                                </c:when>
                                <c:when test="${order.status == 2}">
                                    <span class="status-tag status-cancelled">已取消</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-tag status-pending">未支付</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a class="detail-link" href="${pageContext.request.contextPath}/user/order/${order.id}">
                                <i class="fas fa-eye"></i> 查看详情
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
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