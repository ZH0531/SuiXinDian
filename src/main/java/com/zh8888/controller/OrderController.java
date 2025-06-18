package com.zh8888.controller;

import com.zh8888.model.Order;
import com.zh8888.model.User;
import com.zh8888.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 从购物车创建新订单
     */
    @PostMapping("/orders/create")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createOrder(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return ResponseEntity.status(401).body(response);
        }

        try {
            Order order = orderService.createOrderFromCart(currentUser);
            response.put("success", true);
            response.put("message", "订单创建成功");
            response.put("orderId", order.getId());
        } catch (IllegalStateException e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "创建订单时发生错误");
        }
        
        return ResponseEntity.ok(response);
    }

    /**
     * 显示单个订单的详情
     */
    @GetMapping("/user/order/{id}")
    public String viewOrder(@PathVariable("id") int orderId, Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        Order order = orderService.getOrderById(orderId);

        // 安全检查：确保订单属于当前用户
        if (order == null || !order.getUserId().equals(currentUser.getId())) {
            return "redirect:/user/dashboard?error=OrderNotFound";
        }

        model.addAttribute("order", order);
        model.addAttribute("user", currentUser);
        model.addAttribute("isLoggedIn", true);
        model.addAttribute("pageTitle", "订单详情 - 随心点");
        model.addAttribute("pageDescription", "查看订单详细信息");
        model.addAttribute("pageType", "user");
        model.addAttribute("currentPage", "orders");
        
        return "user/order-details";
    }

    /**
     * 显示用户的所有订单
     */
    @GetMapping("/user/orders")
    public String listOrders(Model model, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            return "redirect:/login";
        }
        
        List<Order> orders = orderService.getOrdersByUserId(currentUser.getId());
        model.addAttribute("orders", orders);
        model.addAttribute("user", currentUser);
        model.addAttribute("isLoggedIn", true);
        model.addAttribute("pageTitle", "我的订单 - 随心点");
        model.addAttribute("pageDescription", "查看您的所有订单");
        model.addAttribute("pageType", "user");
        model.addAttribute("currentPage", "orders");
        
        return "user/order-list";
    }
} 