<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : '菜单浏览 - 随心点'}</title>
    <meta name="description"
          content="${pageDescription != null ? pageDescription : '浏览随心点精选美食菜单，发现您喜爱的美味佳肴'}">

    <!-- 基础样式 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/pages.css">

    <!-- Font Awesome图标 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        /* 主体布局样式 */
        .menu-container {
            display: flex;
            gap: 2rem;
            padding: 2rem 0;
            background: #f8f9fa;
            min-height: 100vh;
        }
        
        /* 左侧菜品区域 */
        .menu-left {
            flex: 1;
            min-width: 0;
        }
        
        /* 右侧购物车区域 */
        .cart-sidebar {
            width: 350px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            position: sticky;
            top: 6rem;
            height: fit-content;
            max-height: calc(100vh - 8rem);
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        .cart-header {
            padding: 1.5rem;
            border-bottom: 1px solid #e9ecef;
            background: linear-gradient(135deg, #ff6b35, #f7931e);
            color: white;
            border-radius: 15px 15px 0 0;
        }
        
        .cart-title {
            font-size: 1.3rem;
            font-weight: bold;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .cart-count {
            background: rgba(255,255,255,0.2);
            padding: 0.2rem 0.5rem;
            border-radius: 15px;
            font-size: 0.9rem;
            min-width: 1.5rem;
            text-align: center;
        }
        
        .cart-content {
            flex: 1;
            overflow-y: auto;
            max-height: 400px;
        }
        
        .cart-items {
            padding: 1rem;
        }
        
        .cart-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .cart-item-image {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            object-fit: cover;
        }
        
        .cart-item-info {
            flex: 1;
            min-width: 0;
        }
        
        .cart-item-name {
            font-weight: bold;
            font-size: 0.9rem;
            margin-bottom: 0.2rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .cart-item-price {
            color: #ff6b35;
            font-size: 0.9rem;
        }
        
        .cart-item-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .quantity-btn {
            width: 24px;
            height: 24px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 0.8rem;
            transition: all 0.2s ease;
        }
        
        .quantity-btn:hover {
            background: #ff6b35;
            color: white;
            border-color: #ff6b35;
        }
        
        .quantity-display {
            min-width: 30px;
            text-align: center;
            font-weight: bold;
            font-size: 0.9rem;
        }
        
        .cart-empty {
            text-align: center;
            padding: 2rem;
            color: #999;
        }
        
        .cart-empty i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.3;
        }
        
        .cart-footer {
            padding: 1.5rem;
            border-top: 1px solid #e9ecef;
            background: #f8f9fa;
            border-radius: 0 0 15px 15px;
        }
        
        .cart-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            font-size: 1.1rem;
            font-weight: bold;
        }
        
        .cart-total-amount {
            color: #ff6b35;
            font-size: 1.3rem;
        }
        
        .cart-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        .btn-clear {
            flex: 1;
            background: #dc3545;
            color: white;
            border: none;
            padding: 0.7rem;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background 0.3s ease;
        }
        
        .btn-clear:hover {
            background: #c82333;
        }
        
        .btn-checkout {
            flex: 2;
            background: #28a745;
            color: white;
            border: none;
            padding: 0.7rem;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: bold;
            transition: background 0.3s ease;
        }
        
        .btn-checkout:hover {
            background: #218838;
        }
        
        /* 菜品筛选区域 */
        .menu-filters {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }
        
        .filter-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .category-filters {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .category-btn {
            padding: 0.5rem 1rem;
            border: 2px solid #e0e0e0;
            background: white;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        
        .category-btn:hover,
        .category-btn.active {
            background: #ff6b35;
            color: white;
            border-color: #ff6b35;
        }
        
        .search-container {
            position: relative;
        }
        
        .search-input {
            padding: 0.5rem 2.5rem 0.5rem 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            width: 250px;
            font-size: 0.9rem;
        }
        
        .search-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }
        
        /* 菜品网格 */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
        }
        
        .dish-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .dish-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .dish-image {
            position: relative;
            height: 180px;
            overflow: hidden;
        }
        
        .dish-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .dish-card:hover .dish-image img {
            transform: scale(1.05);
        }
        
        .dish-info {
            padding: 1.2rem;
        }
        
        .dish-title {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #333;
        }
        
        .dish-desc {
            color: #666;
            font-size: 0.85rem;
            line-height: 1.4;
            margin-bottom: 0.8rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .dish-tags {
            display: flex;
            gap: 0.3rem;
            margin-bottom: 0.8rem;
            flex-wrap: wrap;
        }
        
        .tag {
            background: #ff6b35;
            color: white;
            padding: 0.2rem 0.4rem;
            border-radius: 10px;
            font-size: 0.7rem;
        }
        
        .dish-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .dish-price {
            font-size: 1.3rem;
            font-weight: bold;
            color: #ff6b35;
        }
        
        .add-to-cart {
            background: #ff6b35;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        
        .add-to-cart:hover {
            background: #e55a2b;
            transform: scale(1.05);
        }
        
        .category-section {
            margin-bottom: 2rem;
        }
        
        .category-title {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
            color: #333;
            border-bottom: 3px solid #ff6b35;
            padding-bottom: 0.5rem;
            display: inline-block;
        }
        
        .page-hero {
            background: linear-gradient(135deg, #ff6b35, #f7931e);
            color: white;
            padding: 3rem 0;
            text-align: center;
        }
        
        .hero-title {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }
        
        .hero-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .menu-container {
                flex-direction: column;
                gap: 1rem;
            }
            
            .cart-sidebar {
                width: 100%;
                position: relative;
                top: 0;
                order: -1;
            }
            
            .menu-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
            
            .filter-row {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-input {
                width: 100%;
            }
        }
    </style>
</head>
<body class="page-menu">
<header>
    <div class="container">
        <div class="header-content">
            <a href="${pageContext.request.contextPath}/" class="logo">
                <i class="fas fa-utensils"></i> 随心点
            </a>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> 首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/menu" class="active"><i class="fas fa-book-open"></i> 菜单</a></li>
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
                            </li>
                        </c:when>
                        <c:otherwise>
                            <!-- 未登录状态 -->
                            <li class="user-menu">
                                <a href="${pageContext.request.contextPath}/user/login" class="header-user-area">
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

<!-- 主要内容区域 -->
<main id="main-content" role="main">
    <!-- 页面头部横幅 -->
    <section class="page-hero">
        <div class="hero-content">
            <div class="container">
                <h1 class="hero-title">精选美食菜单</h1>
                <p class="hero-subtitle">发现美味，享受生活的每一餐</p>
            </div>
        </div>
    </section>

    <!-- 菜单和购物车区域 -->
    <div class="container">
        <div class="menu-container">
            <!-- 左侧菜品区域 -->
            <div class="menu-left">
                <!-- 筛选和搜索栏 -->
                <div class="menu-filters">
                    <div class="filter-row">
                        <!-- 分类筛选 -->
                        <div class="category-filters">
                            <button class="category-btn active" data-category="all">
                                <i class="fas fa-utensils"></i> 全部
                            </button>
                            <button class="category-btn" data-category="热菜">
                                <i class="fas fa-fire"></i> 热菜
                            </button>
                            <button class="category-btn" data-category="凉菜">
                                <i class="fas fa-leaf"></i> 凉菜
                            </button>
                            <button class="category-btn" data-category="汤类">
                                <i class="fas fa-soup"></i> 汤类
                            </button>
                            <button class="category-btn" data-category="主食">
                                <i class="fas fa-bowl-rice"></i> 主食
                            </button>
                            <button class="category-btn" data-category="饮品">
                                <i class="fas fa-coffee"></i> 饮品
                            </button>
                        </div>

                        <!-- 搜索框 -->
                        <div class="search-container">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" class="search-input" placeholder="搜索您喜爱的菜品..." id="dishSearch">
                        </div>
                    </div>
                </div>

                <!-- 动态菜品显示 -->
                <div id="menuContent">
                    <c:if test="${not empty categorizedMenus}">
                        <c:forEach var="categoryEntry" items="${categorizedMenus}">
                            <c:if test="${not empty categoryEntry.value}">
                                <div class="category-section" data-category="${categoryEntry.key}">
                                    <h2 class="category-title">${categoryEntry.key}</h2>
                                    <div class="menu-grid">
                                        <c:forEach var="menu" items="${categoryEntry.value}">
                                            <div class="dish-card" data-id="${menu.id}" data-category="${categoryEntry.key}">
                                                <div class="dish-image">
                                                    <img src="${pageContext.request.contextPath}${menu.imageUrl}" 
                                                         alt="${menu.name}"
                                                         onerror="this.src='${pageContext.request.contextPath}/static/images/头像.jpg'">
                                                </div>
                                                <div class="dish-info">
                                                    <h3 class="dish-title">${menu.name}</h3>
                                                    <p class="dish-desc">
                                                        <c:choose>
                                                            <c:when test="${not empty menu.description}">
                                                                ${menu.description}
                                                            </c:when>
                                                            <c:otherwise>
                                                                美味可口的${menu.name}，值得品尝！
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <c:if test="${not empty menu.tags}">
                                                        <div class="dish-tags">
                                                            <c:forTokens items="${menu.tags}" delims="," var="tag">
                                                                <span class="tag">${tag}</span>
                                                            </c:forTokens>
                                                        </div>
                                                    </c:if>
                                                    <div class="dish-footer">
                                                        <div class="dish-price">¥${menu.price}</div>
                                                        <button class="add-to-cart" 
                                                                data-dish-id="${menu.id}"
                                                                data-dish-name="${menu.name}"
                                                                data-dish-price="${menu.price}"
                                                                data-dish-image="${menu.imageUrl}">
                                                            <i class="fas fa-cart-plus"></i> 添加
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:if>

                    <c:if test="${empty categorizedMenus}">
                        <div style="text-align: center; padding: 3rem; color: #666;">
                            <i class="fas fa-utensils" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.3;"></i>
                            <p>暂无菜品数据，请稍后再试</p>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- 右侧购物车 -->
            <div class="cart-sidebar">
                <div class="cart-header">
                    <h3 class="cart-title">
                        <i class="fas fa-shopping-cart"></i>
                        购物车
                        <span class="cart-count" id="cartCount">0</span>
                    </h3>
                </div>
                
                <div class="cart-content">
                    <div class="cart-items" id="cartItems">
                        <div class="cart-empty">
                            <i class="fas fa-shopping-cart"></i>
                            <p>购物车为空</p>
                            <small>添加一些美味的菜品吧！</small>
                        </div>
                    </div>
                </div>
                
                <div class="cart-footer">
                    <div class="cart-total">
                        <span>总计：</span>
                        <span class="cart-total-amount" id="cartTotal">¥0.00</span>
                    </div>
                    <div class="cart-actions">
                        <button class="btn-clear" id="clearCart">
                            <i class="fas fa-trash"></i> 清空
                        </button>
                        <button class="btn-checkout" id="checkout">
                            <i class="fas fa-credit-card"></i> 结算
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var isUserLoggedIn = <c:out value="${isLoggedIn}" default="false"/>;
var contextPath = '<c:out value="${pageContext.request.contextPath}"/>';

// 购物车对象
const cart = {
    items: [],
    
    // 添加商品到购物车
    addItem: function(item) {
        const existingItem = this.items.find(cartItem => cartItem.id === item.id);
        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            this.items.push({
                id: item.id,
                name: item.name,
                price: parseFloat(item.price),
                image: item.image,
                quantity: 1
            });
        }
        this.updateDisplay();
        this.saveToSession();
    },
    
    // 更新商品数量
    updateQuantity: function(id, quantity) {
        const item = this.items.find(cartItem => cartItem.id === id);
        if (item) {
            if (quantity <= 0) {
                this.removeItem(id);
            } else {
                item.quantity = quantity;
                this.updateDisplay();
                this.saveToSession();
            }
        }
    },
    
    // 移除商品
    removeItem: function(id) {
        this.items = this.items.filter(item => item.id !== id);
        this.updateDisplay();
        this.saveToSession();
    },
    
    // 清空购物车
    clear: function() {
        this.items = [];
        this.updateDisplay();
        this.saveToSession();
    },
    
    // 获取总金额
    getTotal: function() {
        return this.items.reduce((total, item) => total + (item.price * item.quantity), 0);
    },
    
    // 获取总数量
    getTotalCount: function() {
        return this.items.reduce((total, item) => total + item.quantity, 0);
    },
    
    // 更新显示
    updateDisplay: function() {
        const cartItems = $('#cartItems');
        const cartCount = $('#cartCount');
        const cartTotal = $('#cartTotal');
        
        // 更新数量和总金额
        cartCount.text(this.getTotalCount());
        cartTotal.text('¥' + this.getTotal().toFixed(2));
        
        // 更新购物车内容
        if (this.items.length === 0) {
            cartItems.html('<div class="cart-empty"><i class="fas fa-shopping-cart"></i><p>购物车为空</p><small>添加一些美味的菜品吧！</small></div>');
        } else {
            let itemsHtml = '';
            this.items.forEach(item => {
                itemsHtml += '<div class="cart-item" data-id="' + item.id + '">';
                itemsHtml += '<img src="' + contextPath + item.image + '" alt="' + item.name + '" class="cart-item-image" onerror="this.src=\'' + contextPath + '/static/images/头像.jpg\'">';
                itemsHtml += '<div class="cart-item-info">';
                itemsHtml += '<div class="cart-item-name">' + item.name + '</div>';
                itemsHtml += '<div class="cart-item-price">¥' + item.price.toFixed(2) + '</div>';
                itemsHtml += '</div>';
                itemsHtml += '<div class="cart-item-controls">';
                itemsHtml += '<button class="quantity-btn" onclick="cart.updateQuantity(' + item.id + ', ' + (item.quantity - 1) + ')"><i class="fas fa-minus"></i></button>';
                itemsHtml += '<span class="quantity-display">' + item.quantity + '</span>';
                itemsHtml += '<button class="quantity-btn" onclick="cart.updateQuantity(' + item.id + ', ' + (item.quantity + 1) + ')"><i class="fas fa-plus"></i></button>';
                itemsHtml += '</div></div>';
            });
            cartItems.html(itemsHtml);
        }
    },
    
    // 保存到后端Session
    saveToSession: function() {
        if (this.items.length === 0) return;
        
        // 发送到后端更新Session
        $.ajax({
            url: contextPath + '/cart/sync',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(this.items),
            success: function(response) {
                console.log('购物车已同步到服务器');
            },
            error: function() {
                console.log('购物车同步失败');
            }
        });
    },
    
    // 从后端加载
    loadFromSession: function() {
        $.ajax({
            url: contextPath + '/cart/info',
            method: 'GET',
            success: function(response) {
                if (response.success && response.cartItems) {
                    cart.items = response.cartItems.map(item => ({
                        id: item.menuId,
                        name: item.menuName,
                        price: item.price,
                        image: item.menuImage,
                        quantity: item.quantity
                    }));
                    cart.updateDisplay();
                }
            }
        });
    }
};

$(document).ready(function() {
    // 页面加载时从服务器获取购物车数据
    cart.loadFromSession();
    
    // 分类过滤
    $('.category-btn').click(function() {
        $('.category-btn').removeClass('active');
        $(this).addClass('active');
        
        const category = $(this).data('category');
        
        if (category === 'all') {
            $('.category-section').show();
        } else {
            $('.category-section').hide();
            $('.category-section[data-category="' + category + '"]').show();
        }
    });
    
    // 搜索功能
    $('#dishSearch').on('input', function() {
        const keyword = $(this).val().toLowerCase();
        
        if (keyword === '') {
            $('.dish-card').show();
            $('.category-section').show();
        } else {
            $('.dish-card').each(function() {
                const dishName = $(this).find('.dish-title').text().toLowerCase();
                const dishDesc = $(this).find('.dish-desc').text().toLowerCase();
                const dishTags = $(this).find('.dish-tags').text().toLowerCase();

                if (dishName.includes(keyword) || dishDesc.includes(keyword) || dishTags.includes(keyword)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });

            // 隐藏没有可见菜品的分类
            $('.category-section').each(function() {
                if ($(this).find('.dish-card:visible').length === 0) {
                    $(this).hide();
                } else {
                    $(this).show();
                }
            });
        }
    });

    // 添加到购物车功能
    $(document).on('click', '.add-to-cart', function() {
        if (!isUserLoggedIn) {
            alert('请先登录后再添加到购物车');
            window.location.href = contextPath + '/user/login';
            return;
        }

        const dishId = parseInt($(this).data('dish-id'));
        const dishName = $(this).data('dish-name');
        const dishPrice = $(this).data('dish-price');
        const dishImage = $(this).data('dish-image');

        // 添加到购物车
        cart.addItem({
            id: dishId,
            name: dishName,
            price: dishPrice,
            image: dishImage
        });

        // 发送到后端
        const currentButton = $(this);
        $.ajax({
            url: contextPath + '/cart/add',
            method: 'POST',
            data: {
                menuId: dishId,
                quantity: 1
            },
            success: function(response) {
                if (response.success) {
                    // 显示添加成功的视觉反馈
                    const originalText = currentButton.html();
                    currentButton.html('<i class="fas fa-check"></i> 已添加').css('background', '#28a745');
                    setTimeout(function() {
                        currentButton.html(originalText).css('background', '#ff6b35');
                    }, 1000);
                }
            }
        });
    });

    // 清空购物车
    $('#clearCart').click(function() {
        if (cart.items.length > 0) {
            if (confirm('确定要清空购物车吗？')) {
                cart.clear();
                
                // 发送到后端
                $.ajax({
                    url: contextPath + '/cart/clear',
                    method: 'POST',
                    success: function(response) {
                        console.log('购物车已清空');
                    }
                });
            }
        }
    });

    // 结算
    $('#checkout').click(function() {
        if (cart.items.length === 0) {
            alert('购物车为空，请先添加商品');
            return;
        }
        
        if (!isUserLoggedIn) {
            alert('请先登录');
            window.location.href = contextPath + '/user/login';
            return;
        }
        
        // TODO: 跳转到结算页面
        alert('结算功能待实现\n总金额：¥' + cart.getTotal().toFixed(2));
    });
});
</script>
</body>
</html> 