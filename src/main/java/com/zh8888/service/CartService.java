package com.zh8888.service;

import com.zh8888.model.CartItem;

import java.math.BigDecimal;
import java.util.List;

/**
 * 购物车服务接口
 */
public interface CartService {
    
    /**
     * 添加菜品到购物车
     * @param userId 用户ID
     * @param menuId 菜品ID
     * @param quantity 数量
     * @return 添加成功返回true，失败返回false
     */
    boolean addToCart(Integer userId, Integer menuId, Integer quantity);
    
    /**
     * 从购物车移除菜品
     * @param userId 用户ID
     * @param menuId 菜品ID
     * @return 移除成功返回true，失败返回false
     */
    boolean removeFromCart(Integer userId, Integer menuId);
    
    /**
     * 更新购物车中菜品数量
     * @param userId 用户ID
     * @param menuId 菜品ID
     * @param quantity 新数量
     * @return 更新成功返回true，失败返回false
     */
    boolean updateCartItemQuantity(Integer userId, Integer menuId, Integer quantity);
    
    /**
     * 获取用户购物车列表
     * @param userId 用户ID
     * @return 购物车项列表
     */
    List<CartItem> getCartItems(Integer userId);
    
    /**
     * 计算购物车总金额
     * @param userId 用户ID
     * @return 总金额
     */
    BigDecimal calculateCartTotal(Integer userId);
    
    /**
     * 清空购物车
     * @param userId 用户ID
     * @return 清空成功返回true，失败返回false
     */
    boolean clearCart(Integer userId);
    
    /**
     * 获取购物车中菜品总数量
     * @param userId 用户ID
     * @return 总数量
     */
    int getCartItemCount(Integer userId);
} 