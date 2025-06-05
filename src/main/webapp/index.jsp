<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<html>
<head>
    <title>在线订餐系统</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 5px;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        p {
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>欢迎使用在线订餐系统</h1>
        <p>系统正在开发中，敬请期待！</p>
        <p>当前时间: <%= new SimpleDateFormat("yyyy年MM月dd日").format(new Date()) %></p>
        <ul>
            <li><a href="${pageContext.request.contextPath}/test/time">测试数据库连接</a></li>
            <li><a href="${pageContext.request.contextPath}/test/view">测试视图</a></li>
        </ul>
    </div>
</body>
</html>
