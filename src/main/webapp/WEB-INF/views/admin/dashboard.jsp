<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理后台 - 随心点</title>
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
        
        /* 导航栏样式 */
        .admin-header {
            background-color: #333;
            color: white;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .admin-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .admin-nav .logo {
            font-size: 20px;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        
        .admin-nav .logo i {
            margin-right: 10px;
            font-size: 24px;
        }
        
        .admin-nav ul {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        
        .admin-nav ul li {
            margin-left: 5px;
        }
        
        .admin-nav ul li a {
            color: #ddd;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 4px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }
        
        .admin-nav ul li a i {
            margin-right: 8px;
        }
        
        .admin-nav ul li a:hover {
            background-color: rgba(255,255,255,0.1);
            color: white;
        }
        
        .admin-nav ul li a.active {
            background-color: white;
            color: #333;
            font-weight: 500;
        }
        
        .section-title {
            margin: 30px 0 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            margin-right: 10px;
            color: #333;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .card-header {
            background-color: #333;
            color: white;
            padding: 15px 20px;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        
        .card-header i {
            margin-right: 10px;
            font-size: 20px;
        }
        
        .card-body {
            padding: 20px;
            text-align: center;
        }
        
        .stats-value {
            font-size: 36px;
            font-weight: bold;
            margin: 15px 0;
            color: #333;
        }
        
        .stats-label {
            color: #777;
            margin-bottom: 15px;
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
                    <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> 首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="fas fa-tachometer-alt"></i> 仪表盘</a></li>
                    <li><a href="${pageContext.request.contextPath}/menu/admin"><i class="fas fa-book-open"></i> 菜品管理</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> 用户管理</a></li>
                    <li><a href="${pageContext.request.contextPath}/debug"><i class="fas fa-bug"></i> 系统调试</a></li>
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
            
            <h2 class="section-title"><i class="fas fa-chart-line"></i> 系统概览</h2>
            
            <div class="dashboard-grid">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-users"></i> 用户统计
                    </div>
                    <div class="card-body">
                        <div class="stats-value">${userCount}</div>
                        <div class="stats-label">注册用户</div>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn">
                            <i class="fas fa-cog"></i> 管理用户
                        </a>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-utensils"></i> 菜品统计
                    </div>
                    <div class="card-body">
                        <div class="stats-value">${menuCount}</div>
                        <div class="stats-label">在售菜品</div>
                        <a href="${pageContext.request.contextPath}/menu/admin" class="btn">
                            <i class="fas fa-cog"></i> 管理菜品
                        </a>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-clipboard-list"></i> 订单统计
                    </div>
                    <div class="card-body">
                        <div class="stats-value">${todayOrderCount}</div>
                        <div class="stats-label">今日订单</div>
                        <a href="javascript:void(0);" onclick="showNotAvailable('订单管理')" class="btn">
                            <i class="fas fa-cog"></i> 管理订单
                        </a>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-money-bill-wave"></i> 收入统计
                    </div>
                    <div class="card-body">
                        <div class="stats-value">¥<fmt:formatNumber value="${todayIncome}" pattern="#,##0.00"/></div>
                        <div class="stats-label">今日收入</div>
                        <a href="javascript:void(0);" onclick="showNotAvailable('财务报表')" class="btn">
                            <i class="fas fa-chart-bar"></i> 查看报表
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <div class="container">
            <p>© 2025 随心点 | 后台管理系统</p>
        </div>
    </footer>
    
    <script>
        function showNotAvailable(feature) {
            alert('抱歉，' + feature + '功能暂未开放，敬请期待！');
        }
    </script>
</body>
</html> 