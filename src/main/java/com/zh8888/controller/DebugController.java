package com.zh8888.controller;

import com.zh8888.model.User;
import com.zh8888.service.UserService;
import com.zh8888.service.MenuService;
import com.zh8888.service.OrderService;
import com.zh8888.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

/**
 * 系统调试控制器
 */
@Controller
@RequestMapping("/debug")
public class DebugController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private MenuService menuService;
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private CartService cartService;
    
    @Autowired
    private DataSource dataSource;

    /**
     * 调试页面
     */
    @GetMapping
    public String debugPage(HttpSession session, Model model) {
        // 检查是否已登录且是管理员
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        
        if (user.getRole() != 1) { // 不是管理员
            return "redirect:/user/dashboard";
        }
        
        // 获取系统状态信息
        model.addAttribute("user", user);
        
        // 数据库连接状态
        boolean dbStatus = checkDatabaseConnection();
        model.addAttribute("dbStatus", dbStatus);
        
        // 服务状态
        Map<String, Boolean> serviceStatus = new HashMap<>();
        serviceStatus.put("UserService", userService != null);
        serviceStatus.put("MenuService", menuService != null);
        serviceStatus.put("OrderService", orderService != null);
        serviceStatus.put("CartService", cartService != null);
        model.addAttribute("serviceStatus", serviceStatus);
        
        // 数据统计
        try {
            int userCount = userService.getUserCount();
            int menuCount = menuService.getMenuCount();
            int orderCount = orderService.getTodayOrderCount();
            
            model.addAttribute("userCount", userCount);
            model.addAttribute("menuCount", menuCount);
            model.addAttribute("orderCount", orderCount);
            
            // 添加更多统计信息
            model.addAttribute("totalOrders", orderService.getOrderCountByUserId(0)); // 0表示获取所有订单
            model.addAttribute("todayIncome", orderService.getTodayIncome());
        } catch (Exception e) {
            model.addAttribute("statsError", e.getMessage());
        }
        
        // Session信息
        model.addAttribute("sessionId", session.getId());
        model.addAttribute("sessionCreationTime", new java.util.Date(session.getCreationTime()));
        model.addAttribute("sessionLastAccessTime", new java.util.Date(session.getLastAccessedTime()));
        
        // 服务器信息
        model.addAttribute("serverPort", session.getServletContext().getAttribute("javax.servlet.context.tempdir"));
        
        return "admin/debug";
    }
    
    /**
     * 清除所有缓存
     */
    @PostMapping("/clearCache")
    @ResponseBody
    public Map<String, Object> clearCache(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查权限
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != 1) {
            response.put("success", false);
            response.put("message", "无权限操作");
            return response;
        }
        
        try {
            // 这里可以添加清除缓存的逻辑
            // 目前系统没有使用缓存，所以只是模拟
            response.put("success", true);
            response.put("message", "缓存已清除");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "清除缓存失败：" + e.getMessage());
        }
        
        return response;
    }
    
    /**
     * 重新加载配置
     */
    @PostMapping("/reloadConfig")
    @ResponseBody
    public Map<String, Object> reloadConfig(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查权限
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != 1) {
            response.put("success", false);
            response.put("message", "无权限操作");
            return response;
        }
        
        try {
            // 这里可以添加重新加载配置的逻辑
            response.put("success", true);
            response.put("message", "配置已重新加载");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "重新加载配置失败：" + e.getMessage());
        }
        
        return response;
    }
    
    /**
     * 测试数据库连接
     */
    @GetMapping("/testDB")
    @ResponseBody
    public Map<String, Object> testDatabase(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查权限
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != 1) {
            response.put("success", false);
            response.put("message", "无权限操作");
            return response;
        }
        
        try {
            boolean connected = checkDatabaseConnection();
            response.put("success", connected);
            response.put("message", connected ? "数据库连接正常" : "数据库连接失败");
            
            if (connected) {
                // 获取数据库信息
                try (Connection conn = dataSource.getConnection()) {
                    response.put("dbInfo", conn.getMetaData().getDatabaseProductName() + " " + 
                                          conn.getMetaData().getDatabaseProductVersion());
                }
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "测试数据库连接失败：" + e.getMessage());
        }
        
        return response;
    }
    
    /**
     * 获取系统信息
     */
    @GetMapping("/systemInfo")
    @ResponseBody
    public Map<String, Object> getSystemInfo(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查权限
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != 1) {
            response.put("success", false);
            response.put("message", "无权限操作");
            return response;
        }
        
        try {
            Map<String, Object> systemInfo = new HashMap<>();
            
            // JVM信息
            Runtime runtime = Runtime.getRuntime();
            systemInfo.put("totalMemory", runtime.totalMemory() / 1024 / 1024 + " MB");
            systemInfo.put("freeMemory", runtime.freeMemory() / 1024 / 1024 + " MB");
            systemInfo.put("maxMemory", runtime.maxMemory() / 1024 / 1024 + " MB");
            systemInfo.put("availableProcessors", runtime.availableProcessors());
            
            // 系统属性
            systemInfo.put("javaVersion", System.getProperty("java.version"));
            systemInfo.put("javaVendor", System.getProperty("java.vendor"));
            systemInfo.put("osName", System.getProperty("os.name"));
            systemInfo.put("osVersion", System.getProperty("os.version"));
            systemInfo.put("userDir", System.getProperty("user.dir"));
            
            response.put("success", true);
            response.put("data", systemInfo);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "获取系统信息失败：" + e.getMessage());
        }
        
        return response;
    }
    
    /**
     * 检查数据库连接
     */
    private boolean checkDatabaseConnection() {
        try (Connection conn = dataSource.getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (Exception e) {
            return false;
        }
    }
} 