package com.zh8888.dao;

import com.zh8888.model.OrderItem;
import java.util.List;

public interface OrderItemDao {
    void createOrderItem(OrderItem orderItem);
    List<OrderItem> findOrderItemsByOrderId(int orderId);
} 