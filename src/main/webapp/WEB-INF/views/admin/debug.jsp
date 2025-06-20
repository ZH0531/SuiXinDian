<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>系统调试 - 随心点</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 调试页面特定样式 */
        .debug-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 0;
        }
        
        .debug-header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .debug-header h1 {
            margin: 0;
            font-size: 28px;
        }
        
        .debug-header p {
            margin: 10px 0 0;
            opacity: 0.8;
        }
        
        .debug-section {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            overflow: hidden;
        }
        
        .section-header {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .section-header h2 {
            margin: 0;
            font-size: 20px;
            color: #333;
        }
        
        .section-body {
            padding: 20px;
        }
        
        .status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .status-item {
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 20px;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
        }
        
        .status-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .status-name {
            font-weight: 600;
            color: #2c3e50;
            font-size: 16px;
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-ok {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-error {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .status-info {
            font-size: 14px;
            color: #6c757d;
            margin-top: 8px;
        }
        
        .status-detail {
            display: flex;
            justify-content: space-between;
            margin-top: 5px;
            font-size: 13px;
        }
        
        .status-detail-label {
            color: #868e96;
        }
        
        .status-detail-value {
            color: #495057;
            font-weight: 500;
        }
        
        .info-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .info-table tr {
            border-bottom: 1px solid #e9ecef;
        }
        
        .info-table tr:last-child {
            border-bottom: none;
        }
        
        .info-table td {
            padding: 12px;
        }
        
        .info-table td:first-child {
            font-weight: 500;
            color: #495057;
            width: 200px;
        }
        
        .info-table td:last-child {
            color: #666;
            font-family: monospace;
        }
        
        .debug-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .debug-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .debug-btn-primary {
            background-color: #007bff;
            color: white;
        }
        
        .debug-btn-primary:hover {
            background-color: #0056b3;
        }
        
        .debug-btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        
        .debug-btn-warning:hover {
            background-color: #e0a800;
        }
        
        .debug-btn-success {
            background-color: #28a745;
            color: white;
        }
        
        .debug-btn-success:hover {
            background-color: #218838;
        }
        
        .debug-btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .debug-btn-danger:hover {
            background-color: #c82333;
        }
        
        .result-message {
            margin-top: 15px;
            padding: 12px 15px;
            border-radius: 6px;
            display: none;
        }
        
        .result-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .result-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .loading {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid #f3f3f3;
            border-top: 2px solid #333;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            color: #007bff;
            text-decoration: none;
            margin-bottom: 20px;
            transition: color 0.3s ease;
        }
        
        .back-link:hover {
            color: #0056b3;
        }
        
        .back-link i {
            margin-right: 5px;
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
        
        /* 原有样式 */
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
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
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> 仪表盘</a></li>
                    <li><a href="${pageContext.request.contextPath}/menu/admin"><i class="fas fa-book-open"></i> 菜品管理</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> 用户管理</a></li>
                    <li><a href="${pageContext.request.contextPath}/debug" class="active"><i class="fas fa-bug"></i> 系统调试</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/logout"><i class="fas fa-sign-out-alt"></i> 退出</a></li>
                </ul>
            </div>
        </div>
    </header>
    
    <div class="debug-container">
        <div class="container">
        <div class="debug-header">
            <h1><i class="fas fa-bug"></i> 系统调试中心</h1>
            <p>查看系统状态和执行调试操作</p>
        </div>
        
        <!-- 服务状态 -->
        <div class="debug-section">
            <div class="section-header">
                <h2><i class="fas fa-server"></i> 服务状态</h2>
            </div>
            <div class="section-body">
                <div class="status-grid">
                    <!-- 数据库连接状态 -->
                    <div class="status-item">
                        <div class="status-header">
                            <span class="status-name"><i class="fas fa-database"></i> 数据库连接</span>
                            <span class="status-badge ${dbStatus ? 'status-ok' : 'status-error'}">
                                ${dbStatus ? '正常运行' : '连接异常'}
                            </span>
                        </div>
                        <div class="status-info">
                            MySQL数据库连接池状态
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">状态：</span>
                            <span class="status-detail-value">${dbStatus ? '已连接' : '断开'}</span>
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">连接池：</span>
                            <span class="status-detail-value">HikariCP</span>
                        </div>
                    </div>
                    
                    <!-- UserService状态 -->
                    <div class="status-item">
                        <div class="status-header">
                            <span class="status-name"><i class="fas fa-users"></i> 用户服务</span>
                            <span class="status-badge ${serviceStatus['UserService'] ? 'status-ok' : 'status-error'}">
                                ${serviceStatus['UserService'] ? '正常运行' : '服务异常'}
                            </span>
                        </div>
                        <div class="status-info">
                            用户管理核心服务
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">状态：</span>
                            <span class="status-detail-value">${serviceStatus['UserService'] ? '已加载' : '未加载'}</span>
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">用户总数：</span>
                            <span class="status-detail-value">${userCount > 0 ? userCount : '-'}</span>
                        </div>
                    </div>
                    
                    <!-- MenuService状态 -->
                    <div class="status-item">
                        <div class="status-header">
                            <span class="status-name"><i class="fas fa-utensils"></i> 菜品服务</span>
                            <span class="status-badge ${serviceStatus['MenuService'] ? 'status-ok' : 'status-error'}">
                                ${serviceStatus['MenuService'] ? '正常运行' : '服务异常'}
                            </span>
                        </div>
                        <div class="status-info">
                            菜品管理核心服务
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">状态：</span>
                            <span class="status-detail-value">${serviceStatus['MenuService'] ? '已加载' : '未加载'}</span>
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">菜品总数：</span>
                            <span class="status-detail-value">${menuCount > 0 ? menuCount : '-'}</span>
                        </div>
                    </div>
                    
                    <!-- OrderService状态 -->
                    <div class="status-item">
                        <div class="status-header">
                            <span class="status-name"><i class="fas fa-clipboard-list"></i> 订单服务</span>
                            <span class="status-badge ${serviceStatus['OrderService'] ? 'status-ok' : 'status-error'}">
                                ${serviceStatus['OrderService'] ? '正常运行' : '服务异常'}
                            </span>
                        </div>
                        <div class="status-info">
                            订单处理核心服务
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">状态：</span>
                            <span class="status-detail-value">${serviceStatus['OrderService'] ? '已加载' : '未加载'}</span>
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">今日订单：</span>
                            <span class="status-detail-value">${orderCount >= 0 ? orderCount : '-'}</span>
                        </div>
                    </div>
                    
                    <!-- CartService状态 -->
                    <div class="status-item">
                        <div class="status-header">
                            <span class="status-name"><i class="fas fa-shopping-cart"></i> 购物车服务</span>
                            <span class="status-badge ${serviceStatus['CartService'] ? 'status-ok' : 'status-error'}">
                                ${serviceStatus['CartService'] ? '正常运行' : '服务异常'}
                            </span>
                        </div>
                        <div class="status-info">
                            购物车管理服务
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">状态：</span>
                            <span class="status-detail-value">${serviceStatus['CartService'] ? '已加载' : '未加载'}</span>
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">存储方式：</span>
                            <span class="status-detail-value">Session</span>
                        </div>
                    </div>
                    
                    <!-- Web服务器状态 -->
                    <div class="status-item">
                        <div class="status-header">
                            <span class="status-name"><i class="fas fa-globe"></i> Web服务器</span>
                            <span class="status-badge status-ok">正常运行</span>
                        </div>
                        <div class="status-info">
                            Tomcat应用服务器
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">状态：</span>
                            <span class="status-detail-value">运行中</span>
                        </div>
                        <div class="status-detail">
                            <span class="status-detail-label">端口：</span>
                            <span class="status-detail-value">8080</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 数据统计 -->
        <div class="debug-section">
            <div class="section-header">
                <h2><i class="fas fa-chart-bar"></i> 数据统计</h2>
            </div>
            <div class="section-body">
                <c:choose>
                    <c:when test="${not empty statsError}">
                        <p style="color: #dc3545;">获取统计数据失败: ${statsError}</p>
                    </c:when>
                    <c:otherwise>
                        <table class="info-table">
                            <tr>
                                <td>用户总数</td>
                                <td>${userCount}</td>
                            </tr>
                            <tr>
                                <td>菜品总数</td>
                                <td>${menuCount}</td>
                            </tr>
                            <tr>
                                <td>今日订单数</td>
                                <td>${orderCount}</td>
                            </tr>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- Session信息 -->
        <div class="debug-section">
            <div class="section-header">
                <h2><i class="fas fa-user-clock"></i> Session信息</h2>
            </div>
            <div class="section-body">
                <table class="info-table">
                    <tr>
                        <td>Session ID</td>
                        <td>${sessionId}</td>
                    </tr>
                    <tr>
                        <td>创建时间</td>
                        <td><fmt:formatDate value="${sessionCreationTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <td>最后访问时间</td>
                        <td><fmt:formatDate value="${sessionLastAccessTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    <tr>
                        <td>当前用户</td>
                        <td>${user.username} (ID: ${user.userId})</td>
                    </tr>
                </table>
            </div>
        </div>
        
        <!-- 系统信息 -->
        <div class="debug-section">
            <div class="section-header">
                <h2><i class="fas fa-info-circle"></i> 系统信息</h2>
                <button class="debug-btn debug-btn-primary" onclick="getSystemInfo()">
                    <i class="fas fa-sync"></i> 刷新
                </button>
            </div>
            <div class="section-body">
                <div id="systemInfo">
                    <p style="color: #666;">点击刷新按钮获取系统信息</p>
                </div>
            </div>
        </div>
        
        <!-- 调试操作 -->
        <div class="debug-section">
            <div class="section-header">
                <h2><i class="fas fa-tools"></i> 调试操作</h2>
            </div>
            <div class="section-body">
                <div class="debug-actions">
                    <button class="debug-btn debug-btn-success" onclick="testDatabase()">
                        <i class="fas fa-database"></i> 测试数据库
                    </button>
                    <button class="debug-btn debug-btn-warning" onclick="clearCache()">
                        <i class="fas fa-broom"></i> 清除缓存
                    </button>
                    <button class="debug-btn debug-btn-primary" onclick="reloadConfig()">
                        <i class="fas fa-redo"></i> 重载配置
                    </button>
                </div>
                <div id="actionResult" class="result-message"></div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function showResult(success, message) {
            const resultDiv = document.getElementById('actionResult');
            resultDiv.className = 'result-message ' + (success ? 'result-success' : 'result-error');
            resultDiv.textContent = message;
            resultDiv.style.display = 'block';
            
            setTimeout(() => {
                resultDiv.style.display = 'none';
            }, 5000);
        }
        
        function testDatabase() {
            fetch('${pageContext.request.contextPath}/debug/testDB')
                .then(response => response.json())
                .then(data => {
                    let message = data.message;
                    if (data.dbInfo) {
                        message += ' (' + data.dbInfo + ')';
                    }
                    showResult(data.success, message);
                })
                .catch(error => {
                    showResult(false, '请求失败: ' + error.message);
                });
        }
        
        function clearCache() {
            if (confirm('确定要清除所有缓存吗？')) {
                fetch('${pageContext.request.contextPath}/debug/clearCache', {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    showResult(data.success, data.message);
                })
                .catch(error => {
                    showResult(false, '请求失败: ' + error.message);
                });
            }
        }
        
        function reloadConfig() {
            if (confirm('确定要重新加载配置吗？')) {
                fetch('${pageContext.request.contextPath}/debug/reloadConfig', {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    showResult(data.success, data.message);
                })
                .catch(error => {
                    showResult(false, '请求失败: ' + error.message);
                });
            }
        }
        
        function getSystemInfo() {
            const systemInfoDiv = document.getElementById('systemInfo');
            systemInfoDiv.innerHTML = '<div class="loading"></div> 正在获取系统信息...';
            
            fetch('${pageContext.request.contextPath}/debug/systemInfo')
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const info = data.data;
                        let html = '<table class="info-table">';
                        html += '<tr><td>Java版本</td><td>' + info.javaVersion + '</td></tr>';
                        html += '<tr><td>Java供应商</td><td>' + info.javaVendor + '</td></tr>';
                        html += '<tr><td>操作系统</td><td>' + info.osName + ' ' + info.osVersion + '</td></tr>';
                        html += '<tr><td>总内存</td><td>' + info.totalMemory + '</td></tr>';
                        html += '<tr><td>可用内存</td><td>' + info.freeMemory + '</td></tr>';
                        html += '<tr><td>最大内存</td><td>' + info.maxMemory + '</td></tr>';
                        html += '<tr><td>处理器核心数</td><td>' + info.availableProcessors + '</td></tr>';
                        html += '<tr><td>工作目录</td><td>' + info.userDir + '</td></tr>';
                        html += '</table>';
                        systemInfoDiv.innerHTML = html;
                    } else {
                        systemInfoDiv.innerHTML = '<p style="color: #dc3545;">获取系统信息失败: ' + data.message + '</p>';
                    }
                })
                .catch(error => {
                    systemInfoDiv.innerHTML = '<p style="color: #dc3545;">请求失败: ' + error.message + '</p>';
                });
        }
    </script>
</body>
</html> 