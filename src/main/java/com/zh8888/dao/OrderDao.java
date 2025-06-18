package com.zh8888.dao;

import com.zh8888.model.Order;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface OrderDao {
    void createOrder(Order order);
    Order findOrderById(@Param("id") int id);
    List<Order> findOrdersByUserId(@Param("userId") int userId);
    void updateOrderStatus(@Param("id") int id, @Param("status") String status);
    Order findLatestOrderByUserId(@Param("userId") int userId);
} 