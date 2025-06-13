package com.zh8888.controller;

import com.zh8888.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * 管理员控制器
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

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
        
        return "admin/dashboard";
    }
} 