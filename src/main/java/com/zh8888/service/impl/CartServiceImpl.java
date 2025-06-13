package com.zh8888.service.impl;

import com.zh8888.model.CartItem;
import com.zh8888.model.Menu;
import com.zh8888.service.CartService;
import com.zh8888.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 购物车服务实现类
 * 使用Session存储购物车数据
 */
@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private MenuService menuService;

    private static final String CART_SESSION_KEY = "USER_CART_";

    /**
     * 获取当前Session
     */
    private HttpSession getCurrentSession() {
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        return attrs.getRequest().getSession();
    }

    /**
     * 获取用户购物车的Session Key
     */
    private String getCartKey(Integer userId) {
        return CART_SESSION_KEY + userId;
    }

    /**
     * 从Session获取购物车
     */
    @SuppressWarnings("unchecked")
    private Map<Integer, CartItem> getCartFromSession(Integer userId) {
        HttpSession session = getCurrentSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute(getCartKey(userId));
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute(getCartKey(userId), cart);
        }
        return cart;
    }

    @Override
    public boolean addToCart(Integer userId, Integer menuId, Integer quantity) {
        try {
            // 获取菜品信息
            Menu menu = menuService.getMenuById(menuId);
            if (menu == null) {
                return false;
            }

            // 获取购物车
            Map<Integer, CartItem> cart = getCartFromSession(userId);

            // 检查购物车中是否已有该菜品
            if (cart.containsKey(menuId)) {
                // 增加数量
                CartItem existingItem = cart.get(menuId);
                existingItem.addQuantity(quantity);
            } else {
                // 创建新的购物车项
                CartItem newItem = new CartItem(menu);
                newItem.setQuantity(quantity);
                cart.put(menuId, newItem);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean removeFromCart(Integer userId, Integer menuId) {
        try {
            Map<Integer, CartItem> cart = getCartFromSession(userId);
            cart.remove(menuId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateCartItemQuantity(Integer userId, Integer menuId, Integer quantity) {
        try {
            Map<Integer, CartItem> cart = getCartFromSession(userId);
            CartItem item = cart.get(menuId);
            if (item != null) {
                if (quantity <= 0) {
                    cart.remove(menuId);
                } else {
                    item.setQuantity(quantity);
                }
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<CartItem> getCartItems(Integer userId) {
        Map<Integer, CartItem> cart = getCartFromSession(userId);
        return new ArrayList<>(cart.values());
    }

    @Override
    public BigDecimal calculateCartTotal(Integer userId) {
        List<CartItem> items = getCartItems(userId);
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(item.calculateSubtotal());
        }
        return total;
    }

    @Override
    public boolean clearCart(Integer userId) {
        try {
            HttpSession session = getCurrentSession();
            session.removeAttribute(getCartKey(userId));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int getCartItemCount(Integer userId) {
        List<CartItem> items = getCartItems(userId);
        int totalCount = 0;
        for (CartItem item : items) {
            totalCount += item.getQuantity();
        }
        return totalCount;
    }
} 