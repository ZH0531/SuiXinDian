package com.zh8888.controller;

import com.zh8888.model.User;
import com.zh8888.service.UserService;
import com.zh8888.service.OrderService;
import com.zh8888.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 管理员控制器
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private MenuService menuService;

    /**
     * 管理员仪表盘
     */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // 检查是否已登录且是管理员
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        
        if (user.getRole() != 1) { // 不是管理员 跳转到用户主页
            return "redirect:/user/dashboard";
        }
        
        // 传递用户信息到视图
        model.addAttribute("user", user);
        
        // 获取统计数据
        int userCount = userService.getUserCount();
        int menuCount = menuService.getMenuCount();
        int todayOrderCount = orderService.getTodayOrderCount();
        BigDecimal todayIncome = orderService.getTodayIncome();
        
        model.addAttribute("userCount", userCount);
        model.addAttribute("menuCount", menuCount);
        model.addAttribute("todayOrderCount", todayOrderCount);
        model.addAttribute("todayIncome", todayIncome != null ? todayIncome : BigDecimal.ZERO);
        
        return "admin/dashboard";
    }
    
    /**
     * 用户管理页面
     */
    @GetMapping("/users")
    public String userManagement(HttpSession session, Model model) {
        // 检查是否已登录且是管理员
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        
        if (user.getRole() != 1) { // 不是管理员
            return "redirect:/user/dashboard";
        }
        
        // 获取所有用户
        List<User> users = userService.getAllUsers();
        
        model.addAttribute("users", users);
        model.addAttribute("user", user);
        
        return "admin/users";
    }
    
    /**
     * 获取单个用户信息
     */
    @GetMapping("/user/{id}")
    @ResponseBody
    public Map<String, Object> getUser(@PathVariable Integer id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查权限
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || currentUser.getRole() != 1) {
            response.put("success", false);
            response.put("message", "无权限操作");
            return response;
        }
        
        try {
            User user = userService.getUserById(id);
            if (user != null) {
                // 不返回密码字段
                user.setPassword(null);
                
                response.put("success", true);
                response.put("data", user);
            } else {
                response.put("success", false);
                response.put("message", "用户不存在");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "获取用户信息失败：" + e.getMessage());
        }
        
        return response;
    }
    
    /**
     * 更新用户信息
     */
    @PostMapping("/user/update")
    @ResponseBody
    public Map<String, Object> updateUser(@RequestBody User user, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查权限
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || currentUser.getRole() != 1) {
            response.put("success", false);
            response.put("message", "无权限操作");
            return response;
        }
        
        try {
            boolean result = userService.updateUser(user);
            if (result) {
                response.put("success", true);
                response.put("message", "更新成功");
            } else {
                response.put("success", false);
                response.put("message", "更新失败");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "更新用户信息失败：" + e.getMessage());
        }
        
        return response;
    }
    
    /**
     * 删除用户
     */
    @DeleteMapping("/user/delete/{id}")
    @ResponseBody
    public Map<String, Object> deleteUser(@PathVariable Integer id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查权限
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || currentUser.getRole() != 1) {
            response.put("success", false);
            response.put("message", "无权限操作");
            return response;
        }
        
        // 不能删除自己
        if (currentUser.getId().equals(id)) {
            response.put("success", false);
            response.put("message", "不能删除当前登录用户");
            return response;
        }
        
        try {
            boolean result = userService.deleteUser(id);
            if (result) {
                response.put("success", true);
                response.put("message", "删除成功");
            } else {
                response.put("success", false);
                response.put("message", "删除失败");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "删除用户失败：" + e.getMessage());
        }
        
        return response;
    }
} 