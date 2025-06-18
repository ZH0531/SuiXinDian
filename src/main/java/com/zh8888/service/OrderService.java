package com.zh8888.service;

import com.zh8888.model.Order;
import com.zh8888.model.User;

import java.math.BigDecimal;
import java.util.List;

public interface OrderService {

    /**
     * 从购物车创建订单
     * @param user a full user object
     * @return the created order
     */
    Order createOrderFromCart(User user);

    /**
     * 根据ID查找订单
     * @param orderId the order id
     * @return the order, including order items
     */
    Order getOrderById(int orderId);

    /**
     * 查找用户的所有订单
     * @param userId the user id
     * @return a list of orders
     */
    List<Order> getOrdersByUserId(int userId);

    Order getLatestOrderByUserId(int userId);
    
    /**
     * 获取用户的订单总数
     * @param userId the user id
     * @return the total count of orders
     */
    int getOrderCountByUserId(int userId);
    
    /**
     * 获取今日订单数
     * @return 今日订单数
     */
    int getTodayOrderCount();
    
    /**
     * 获取今日收入
     * @return 今日收入总额
     */
    BigDecimal getTodayIncome();
}