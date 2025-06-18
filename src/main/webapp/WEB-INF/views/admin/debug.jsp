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
            padding: 20px;
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
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
        }
        
        .status-item {
            border: 1px solid #e9ecef;
            border-radius: 6px;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .status-name {
            font-weight: 500;
            color: #495057;
        }
        
        .status-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            flex-shrink: 0;
            margin-left: 10px;
        }
        
        .status-ok {
            background-color: #28a745;
        }
        
        .status-error {
            background-color: #dc3545;
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
    </style>
</head>
<body>
    <div class="debug-container">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-link">
            <i class="fas fa-arrow-left"></i> 返回管理后台
        </a>
        
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
                    <div class="status-item">
                        <span class="status-name">数据库连接</span>
                        <span class="status-indicator ${dbStatus ? 'status-ok' : 'status-error'}"></span>
                    </div>
                    <c:forEach items="${serviceStatus}" var="service">
                        <div class="status-item">
                            <span class="status-name">${service.key}</span>
                            <span class="status-indicator ${service.value ? 'status-ok' : 'status-error'}"></span>
                        </div>
                    </c:forEach>
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