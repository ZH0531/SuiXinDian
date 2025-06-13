<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>关于我们 - 随心点</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* 关于我们页面特定样式 */
        .about-header {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('${pageContext.request.contextPath}/static/images/about-bg.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 0;
            text-align: center;
            margin-bottom: 60px;
        }
        
        .about-header h1 {
            font-size: 40px;
            margin-bottom: 20px;
        }
        
        .about-header p {
            max-width: 700px;
            margin: 0 auto;
            font-size: 18px;
            line-height: 1.6;
        }
        
        .about-section {
            padding: 60px 0;
        }
        
        .about-section:nth-child(even) {
            background-color: var(--background-color);
        }
        
        .about-content {
            display: flex;
            align-items: center;
            gap: 50px;
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .about-image {
            flex: 1;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .about-image img {
            width: 100%;
            height: auto;
            display: block;
            transition: transform 0.5s ease;
        }
        
        .about-image:hover img {
            transform: scale(1.05);
        }
        
        .about-text {
            flex: 1;
        }
        
        .about-text h2 {
            font-size: 28px;
            color: var(--text-color);
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .about-text h2:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background-color: var(--primary-color);
        }
        
        .about-text p {
            color: var(--light-text);
            margin-bottom: 20px;
            line-height: 1.8;
        }
        
        .reversed .about-content {
            flex-direction: row-reverse;
        }
        
        /* 团队部分 */
        .team-section {
            padding: 60px 0;
            text-align: center;
            background-color: white;
        }
        
        .section-title {
            margin-bottom: 40px;
        }
        
        .section-title h2 {
            font-size: 32px;
            color: var(--text-color);
            margin-bottom: 15px;
        }
        
        .section-title p {
            color: var(--light-text);
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.6;
        }
        
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .team-member {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .member-photo {
            height: 250px;
            overflow: hidden;
        }
        
        .member-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .team-member:hover .member-photo img {
            transform: scale(1.1);
        }
        
        .member-info {
            padding: 20px;
        }
        
        .member-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
            color: var(--text-color);
        }
        
        .member-role {
            color: var(--primary-color);
            font-size: 14px;
            margin-bottom: 15px;
        }
        
        .member-bio {
            color: var(--light-text);
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .social-links {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        
        .social-links a {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: var(--background-color);
            color: var(--light-text);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        
        .social-links a:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-3px);
        }
        
        /* 特色部分 */
        .features-section {
            padding: 60px 0;
            background-color: var(--background-color);
            text-align: center;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .feature-card {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .feature-icon {
            width: 70px;
            height: 70px;
            background-color: var(--background-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 28px;
            color: var(--primary-color);
        }
        
        .feature-title {
            font-size: 20px;
            margin-bottom: 15px;
            color: var(--text-color);
        }
        
        .feature-desc {
            color: var(--light-text);
            line-height: 1.6;
        }
        
        /* 联系部分 */
        .contact-section {
            padding: 60px 0;
            background-color: white;
        }
        
        .contact-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .contact-info {
            padding: 20px;
        }
        
        .contact-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }
        
        .contact-icon {
            width: 40px;
            height: 40px;
            background-color: var(--background-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--primary-color);
            font-size: 16px;
        }
        
        .contact-details h3 {
            font-size: 16px;
            color: var(--text-color);
            margin-bottom: 5px;
        }
        
        .contact-details p {
            color: var(--light-text);
            line-height: 1.6;
        }
        
        .contact-form {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--text-color);
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(255, 107, 53, 0.2);
        }
        
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }
        
        .submit-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .submit-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 107, 53, 0.3);
        }
        
        /* 响应式调整 */
        @media (max-width: 768px) {
            .about-content {
                flex-direction: column;
                gap: 30px;
            }
            
            .reversed .about-content {
                flex-direction: column;
            }
            
            .about-image {
                width: 100%;
            }
            
            .about-header {
                padding: 60px 0;
            }
            
            .about-header h1 {
                font-size: 32px;
            }
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
                    <li><a href="${pageContext.request.contextPath}/" ><i class="fas fa-home"></i> 首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/menu"><i class="fas fa-book-open"></i> 菜单</a></li>
                    <li><a href="${pageContext.request.contextPath}/about" class="active"><i class="fas fa-info-circle"></i> 关于我们</a></li>

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
                                <a href="<c:url value="/"/>" onclick="showLoginTip();" class="header-user-area">
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
    
    <!-- 关于我们页面内容 -->
    <div class="about-header">
        <div class="container">
            <h1>关于随心点</h1>
            <p>我们致力于为您提供最便捷、最美味的在线订餐体验，让每一位用户都能随时随地享受美食的乐趣。</p>
        </div>
    </div>
    
    <!-- 我们的故事 -->
    <section class="about-section">
        <div class="about-content">
            <div class="about-image">
                <img src="${pageContext.request.contextPath}/static/images/about-story.jpg" alt="我们的故事">
            </div>
            <div class="about-text">
                <h2>我们的故事</h2>
                <p>随心点起源于2020年，由一群热爱美食和技术的年轻人创立。我们注意到，传统的点餐方式往往存在诸多不便：排队等候、菜单有限、难以了解菜品详情等。</p>
                <p>因此，我们决定创建一个全新的在线订餐平台，将现代科技与传统美食结合，让用户能够轻松浏览菜单、了解菜品详情、进行个性化选择，并享受快速配送服务。</p>
                <p>经过三年的发展，随心点已经成为了当地领先的在线订餐平台，服务超过50万用户，合作餐厅超过200家，日订单量突破1万单。我们将继续努力，为用户提供更好的服务体验。</p>
            </div>
        </div>
    </section>
    
    <!-- 我们的使命 -->
    <section class="about-section reversed">
        <div class="about-content">
            <div class="about-image">
                <img src="${pageContext.request.contextPath}/static/images/about-mission.jpg" alt="我们的使命">
            </div>
            <div class="about-text">
                <h2>我们的使命</h2>
                <p>随心点的使命是让每个人都能随时随地享受到美食的乐趣，不受时间、地点的限制。</p>
                <p>我们相信，美食不仅仅是满足饥饿的需求，更是一种生活方式、一种文化体验。通过我们的平台，用户可以发现各种各样的美食，尝试不同的口味，丰富自己的味蕾体验。</p>
                <p>同时，我们也致力于支持本地餐饮业的发展，为餐厅提供线上展示和销售渠道，帮助他们拓展客源，提升营业额。我们希望通过自己的努力，让美食文化更加繁荣，让更多人享受到美食的乐趣。</p>
            </div>
        </div>
    </section>
    
    <!-- 我们的团队 -->
    <section class="team-section">
        <div class="section-title">
            <h2>我们的团队</h2>
            <p>随心点的团队由一群充满激情、专业能力强的年轻人组成，他们来自不同的背景，但都有一个共同的目标：让用户享受最好的在线订餐体验。</p>
        </div>
        
        <div class="team-grid">
            <div class="team-member">
                <div class="member-photo">
                    <img src="${pageContext.request.contextPath}/static/images/team1.jpg" alt="张明">
                </div>
                <div class="member-info">
                    <h3 class="member-name">张明</h3>
                    <p class="member-role">创始人 & CEO</p>
                    <p class="member-bio">拥有10年互联网产品经验，曾在多家知名互联网公司担任产品总监，对用户体验和产品设计有独到见解。</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                    </div>
                </div>
            </div>
            
            <div class="team-member">
                <div class="member-photo">
                    <img src="${pageContext.request.contextPath}/static/images/team2.jpg" alt="李华">
                </div>
                <div class="member-info">
                    <h3 class="member-name">李华</h3>
                    <p class="member-role">技术总监</p>
                    <p class="member-bio">拥有12年软件开发经验，精通多种编程语言和技术框架，负责随心点平台的技术架构和开发管理。</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
            
            <div class="team-member">
                <div class="member-photo">
                    <img src="${pageContext.request.contextPath}/static/images/team3.jpg" alt="王芳">
                </div>
                <div class="member-info">
                    <h3 class="member-name">王芳</h3>
                    <p class="member-role">市场总监</p>
                    <p class="member-bio">拥有8年市场营销经验，擅长品牌建设和推广策略，负责随心点的市场拓展和品牌建设。</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
            
            <div class="team-member">
                <div class="member-photo">
                    <img src="${pageContext.request.contextPath}/static/images/team4.jpg" alt="刘强">
                </div>
                <div class="member-info">
                    <h3 class="member-name">刘强</h3>
                    <p class="member-role">运营总监</p>
                    <p class="member-bio">拥有7年互联网运营经验，熟悉用户增长和留存策略，负责随心点的日常运营和用户服务。</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- 我们的特色 -->
    <section class="features-section">
        <div class="section-title">
            <h2>我们的特色</h2>
            <p>随心点致力于为用户提供最优质的在线订餐体验，我们的服务有以下特点：</p>
        </div>
        
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-utensils"></i>
                </div>
                <h3 class="feature-title">多样化菜单</h3>
                <p class="feature-desc">我们提供丰富多样的菜品选择，从传统中餐到西式快餐，总有一款适合您的口味。</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-shipping-fast"></i>
                </div>
                <h3 class="feature-title">快速配送</h3>
                <p class="feature-desc">我们承诺30分钟内送达，让您不必等待太久就能享受美食。</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-mobile-alt"></i>
                </div>
                <h3 class="feature-title">便捷操作</h3>
                <p class="feature-desc">简洁直观的界面设计，让您轻松完成点餐，随时查看订单状态。</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-award"></i>
                </div>
                <h3 class="feature-title">品质保证</h3>
                <p class="feature-desc">我们精选合作餐厅，严格把控食品质量，确保每一份餐食都新鲜美味。</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-gift"></i>
                </div>
                <h3 class="feature-title">优惠活动</h3>
                <p class="feature-desc">我们定期推出各种优惠活动，让您享受美食的同时也能省钱。</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-headset"></i>
                </div>
                <h3 class="feature-title">贴心服务</h3>
                <p class="feature-desc">我们的客服团队24小时在线，随时为您解决点餐过程中遇到的问题。</p>
            </div>
        </div>
    </section>
    
    <!-- 联系我们 -->
    <section class="contact-section">
        <div class="section-title">
            <h2>联系我们</h2>
            <p>如果您有任何问题、建议或合作意向，请随时与我们联系，我们期待听到您的声音！</p>
        </div>
        
        <div class="contact-container">
            <div class="contact-info">
                <div class="contact-item">
                    <div class="contact-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="contact-details">
                        <h3>地址</h3>
                        <p>中国上海市闵行区莘庄工业区春东路508号</p>
                    </div>
                </div>
                
                <div class="contact-item">
                    <div class="contact-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <div class="contact-details">
                        <h3>电话</h3>
                        <p>400-123-4567</p>
                    </div>
                </div>
                
                <div class="contact-item">
                    <div class="contact-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="contact-details">
                        <h3>邮箱</h3>
                        <p>info@suixindian.com</p>
                    </div>
                </div>
                
                <div class="contact-item">
                    <div class="contact-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="contact-details">
                        <h3>工作时间</h3>
                        <p>周一至周五: 9:00 - 18:00<br>周六至周日: 10:00 - 16:00</p>
                    </div>
                </div>
            </div>
            
            <div class="contact-form">
                <form action="${pageContext.request.contextPath}/contact/submit" method="post">
                    <div class="form-group">
                        <label for="name">姓名</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">邮箱</label>
                        <input type="email" id="email" name="email" class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="subject">主题</label>
                        <input type="text" id="subject" name="subject" class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="message">留言</label>
                        <textarea id="message" name="message" class="form-control" required></textarea>
                    </div>
                    
                    <button type="submit" class="submit-btn">发送留言</button>
                </form>
            </div>
        </div>
    </section>
    
    <footer>
        <div class="container">
            <p>© 2023 随心点 | 让用户随时随地，想点就点！</p>
        </div>
    </footer>
</body>
</html> 