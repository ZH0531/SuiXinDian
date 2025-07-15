<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册 - 在线订餐系统</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="icon" href="<c:url value="/static/images/favicon.ico"/>" type="image/x-icon">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        
        .auth-container {
            width: 380px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            padding: 30px;
            box-sizing: border-box;
        }
        
        .auth-header {
            text-align: center;
            margin-bottom: 25px;
        }
        
        .auth-header h2 {
            color: #333;
            margin-bottom: 8px;
            font-size: 24px;
        }
        
        .auth-header p {
            color: #777;
            margin: 0;
            font-size: 14px;
        }
        
        .error-message {
            background-color: #ffebee;
            color: #d32f2f;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .error-message i {
            margin-right: 8px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 6px;
            color: #333;
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            border-color: #ff6b6b;
            outline: none;
        }
        
        .form-group i {
            margin-right: 6px;
            color: #777;
        }
        
        .input-message {
            font-size: 12px;
            min-height: 20px;
            margin-top: 5px;
        }
        
        .btn {
            display: block;
            width: 100%;
            background-color: #ff6b6b;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 12px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            margin-top: 20px;
        }
        
        .btn:hover {
            background-color: #e74c3c;
            transform: translateY(-2px);
        }
        
        .links {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
        
        .links a {
            color: #ff6b6b;
            text-decoration: none;
        }
        
        .links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-header">
            <h2>创建账号</h2>
            <p>注册成为会员，享受更多服务</p>
        </div>
        
        <div id="errorMsg" class="error-message" style="display: none;">
            <i class="fas fa-exclamation-circle"></i> <span id="errorText"></span>
        </div>
        
        <form id="registerForm" action="${pageContext.request.contextPath}/user/register" method="post">
            <div class="form-group">
                <label for="phone"><i class="fas fa-mobile-alt"></i> 手机号码</label>
                <input type="tel" id="phone" name="phone" pattern="[0-9]{11}" placeholder="请输入手机号" required>
            </div>
            
            <div class="form-group">
                <label for="password"><i class="fas fa-lock"></i> 密码</label>
                <input type="password" id="password" name="password" required placeholder="请输入密码">
            </div>
            
            <div class="form-group">
                <label for="confirmPassword"><i class="fas fa-check-circle"></i> 确认密码</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="请再次输入密码">
                <div id="passwordMsg" class="input-message"></div>
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-user-plus"></i> 下一步
            </button>
        </form>
        
        <div class="links">
            <a href="${pageContext.request.contextPath}/">
                <i class="fas fa-sign-in-alt"></i> 已有账号？立即登录
            </a>
        </div>
    </div>
    
    <script>
        // 表单验证
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            e.preventDefault(); // 阻止默认表单提交
            
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const phone = document.getElementById('phone').value.trim();
            
            // 错误消息显示函数
            function showError(message) {
                document.getElementById('errorText').textContent = messager;
                document.getElementById('errorMsg').style.display = 'block';
                setTimeout(() => {
                    document.getElementById('errorMsg').style.display = 'none';
                }, 3000);
            }
            
            if (password === '') {
                showError('请输入密码');
                return;
            }
            
            if (password !== confirmPassword) {
                document.getElementById('passwordMsg').innerText = '两次密码输入不一致';
                document.getElementById('passwordMsg').style.color = 'var(--error-color)';
                return;
            }
            
            if (phone === '' || !(/^1\d{10}$/.test(phone))) {
                showError('请输入有效的11位手机号码');
                return;
            }
            
            // 检查手机号是否已存在
            fetch('${pageContext.request.contextPath}/user/checkPhone?phone=' + encodeURIComponent(phone))
                .then(response => response.json())
                .then(data => {
                    if (data.exist) {
                        showError('该手机号已被注册');
                        return;
                    } else {
                        // 存储第一步数据并前往第二步
                        sessionStorage.setItem('registerPhone', phone);
                        sessionStorage.setItem('registerPassword', password);
                        window.location.href = '${pageContext.request.contextPath}/user/register_profile';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showError('请求失败，请稍后再试');
                });
        });
        
        // 实时检查密码一致性
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const msgElem = document.getElementById('passwordMsg');
            
            if (this.value === password) {
                msgElem.innerText = '密码一致';
                msgElem.style.color = '#4caf50';
            } else {
                msgElem.innerText = '密码不一致';
                msgElem.style.color = '#f44336';
            }
        });
    </script>
</body>
</html> 