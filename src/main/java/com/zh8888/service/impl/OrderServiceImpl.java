package com.zh8888.service.impl;

import com.zh8888.dao.OrderDao;
import com.zh8888.dao.OrderItemDao;
import com.zh8888.model.CartItem;
import com.zh8888.model.Order;
import com.zh8888.model.OrderItem;
import com.zh8888.model.User;
import com.zh8888.service.CartService;
import com.zh8888.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private OrderItemDao orderItemDao;

    @Autowired
    private CartService cartService;
    
    // 用于生成递增的订单号
    private static final AtomicInteger counter = new AtomicInteger(1);
    
    /**
     * 生成新的订单号格式：ORD + yyyyMMdd + 0001(递增)
     */
    private String generateOrderNo() {
        // 获取当前日期
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String dateStr = dateFormat.format(new Date());
        
        // 获取序列号并确保是4位数
        int sequence = counter.getAndIncrement();
        if (sequence > 9999) {
            // 超过4位数时重置
            counter.set(1);
            sequence = 1;
        }
        
        // 格式化序列号为4位数，前面补0
        String sequenceStr = String.format("%04d", sequence);
        
        // 返回最终的订单号
        return "ORD" + dateStr + sequenceStr;
    }

    @Override
    @Transactional
    public Order createOrderFromCart(User user) {
        // 1. 获取购物车内容
        List<CartItem> cartItems = cartService.getCartItems(user.getId());
        if (cartItems == null || cartItems.isEmpty()) {
            throw new IllegalStateException("购物车是空的");
        }

        // 2. 计算总价
        BigDecimal totalAmount = cartService.calculateCartTotal(user.getId());

        // 生成新格式的订单号
        String orderNo = generateOrderNo();

        // 3. 创建订单
        Order order = new Order();
        order.setUserId(user.getId());
        order.setOrderNo(orderNo);
        order.setTotalAmount(totalAmount);
        order.setStatus(1); // 1 表示已完成
        orderDao.createOrder(order); // MyBatis 会将自增ID设置回order对象

        // 4. 创建订单项
        for (CartItem cartItem : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(order.getId());
            orderItem.setMenuId(cartItem.getMenuId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setTotalPrice(cartItem.getPrice().multiply(new BigDecimal(cartItem.getQuantity())));
            orderItem.setMenuNo(cartItem.getMenuNo());
            orderItem.setMenuName(cartItem.getMenuName());
            orderItem.setMenuImage(cartItem.getMenuImage());
            orderItem.setPrice(cartItem.getPrice());
            orderItemDao.createOrderItem(orderItem);
        }

        // 5. 清空购物车
        cartService.clearCart(user.getId());

        return order;
    }

    @Override
    public Order getOrderById(int orderId) {
        Order order = orderDao.findOrderById(orderId);
        if (order != null) {
            List<OrderItem> orderItems = orderItemDao.findOrderItemsByOrderId(orderId);
            order.setOrderItems(orderItems);
        }
        return order;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = orderDao.findOrdersByUserId(userId);
        for (Order order : orders) {
            List<OrderItem> orderItems = orderItemDao.findOrderItemsByOrderId(order.getId());
            order.setOrderItems(orderItems);
        }
        return orders;
    }
} 