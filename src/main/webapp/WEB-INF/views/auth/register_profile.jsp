<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>完善个人信息 - 在线订餐系统</title>
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
        
        .gender-group {
            display: flex;
            gap: 30px;
            padding: 8px 0;
        }
        
        .gender-option {
            display: flex;
            align-items: center;
            cursor: pointer;
        }
        
        .gender-option input {
            width: auto;
            margin-right: 8px;
            cursor: pointer;
        }

        .step-indicator {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 25px;
        }

        .step {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 15px;
            font-weight: bold;
            font-size: 16px;
        }

        .step.active {
            background-color: #ff6b6b;
            color: white;
            box-shadow: 0 3px 8px rgba(255, 107, 107, 0.3);
        }

        .step.completed {
            background-color: #4caf50;
            color: white;
        }

        .step-line {
            flex: 1;
            height: 3px;
            background-color: #f0f0f0;
        }

        .step-line.completed {
            background-color: #4caf50;
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
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-header">
            <h2>完善个人信息</h2>
            <p>请设置您的个人资料</p>
        </div>
        
        <div class="step-indicator">
            <div class="step completed">1</div>
            <div class="step-line completed"></div>
            <div class="step active">2</div>
        </div>
        
        <div id="errorMsg" class="error-message" style="display: none;">
            <i class="fas fa-exclamation-circle"></i> <span id="errorText"></span>
        </div>
        
        <form id="profileForm">
            <div class="form-group">
                <label for="name"><i class="fas fa-user"></i> 昵称</label>
                <input type="text" id="name" name="name" required placeholder="请输入您的昵称">
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-venus-mars"></i> 性别</label>
                <div class="gender-group">
                    <label class="gender-option">
                        <input type="radio" name="gender" value="1" checked> 男
                    </label>
                    <label class="gender-option">
                        <input type="radio" name="gender" value="0"> 女
                    </label>
                </div>
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-check-circle"></i> 完成注册
            </button>
        </form>
    </div>
    
    <script>
        // 检查是否有第一步的数据
        document.addEventListener('DOMContentLoaded', function() {
            const phone = sessionStorage.getItem('registerPhone');
            const password = sessionStorage.getItem('registerPassword');
            
            if (!phone || !password) {
                // 如果没有第一步数据，重定向到第一步
                window.location.href = '${pageContext.request.contextPath}/user/register';
            }
        });
        
        // 表单提交
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const name = document.getElementById('name').value.trim();
            const gender = document.querySelector('input[name="gender"]:checked').value;
            const phone = sessionStorage.getItem('registerPhone');
            const password = sessionStorage.getItem('registerPassword');
            
            // 错误消息显示函数
            function showError(message) {
                document.getElementById('errorText').textContent = message;
                document.getElementById('errorMsg').style.display = 'block';
                setTimeout(() => {
                    document.getElementById('errorMsg').style.display = 'none';
                }, 3000);
            }
            
            if (!name) {
                showError('请输入昵称');
                return;
            }
            
            // 构建注册数据
            const formData = new FormData();
            formData.append('phone', phone);
            formData.append('password', password);
            formData.append('name', name);
            formData.append('gender', gender);
            
            // 发送注册请求
            fetch('${pageContext.request.contextPath}/user/completeRegister', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 清除会话存储
                    sessionStorage.removeItem('registerPhone');
                    sessionStorage.removeItem('registerPassword');
                    
                    alert(data.message);
                    
                    // 跳转到首页
                    if (data.redirect) {
                        window.location.href = '${pageContext.request.contextPath}' + data.redirect;
                    } else {
                        window.location.href = '${pageContext.request.contextPath}/';
                    }
                } else {
                    showError(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showError('注册请求失败，请稍后再试');
            });
        });
    </script>
</body>
</html> 