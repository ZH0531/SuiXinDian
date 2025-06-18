package com.zh8888.dao;

import com.zh8888.model.Order;
import org.apache.ibatis.annotations.Param;
import java.math.BigDecimal;
import java.util.List;

public interface OrderDao {
    void createOrder(Order order);
    Order findOrderById(@Param("id") int id);
    List<Order> findOrdersByUserId(@Param("userId") int userId);
    void updateOrderStatus(@Param("id") int id, @Param("status") String status);
    Order findLatestOrderByUserId(@Param("userId") int userId);
    int countOrdersByUserId(@Param("userId") int userId);
    
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