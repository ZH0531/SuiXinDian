package com.zh8888.controller;

import com.zh8888.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * 首页控制器
 */
@Controller
public class HomeController {

    /**
     * 网站首页
     */
    @GetMapping("/")
    public String index(HttpSession session, Model model) {
        // 从会话中获取用户信息
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("isLoggedIn", true);
        } else {
            model.addAttribute("isLoggedIn", false);
        }
        
        // 设置页面元信息
        model.addAttribute("pageTitle", "随心点 - 时尚快餐点餐系统");
        model.addAttribute("pageDescription", "随心点是面向年轻人的时尚快餐点餐系统，提供便捷的在线点餐服务");
        model.addAttribute("pageType", "public");
        
        return "public/index";
    }
    

    
    /**
     * 关于我们页面
     */
    @GetMapping("/about")
    public String about(HttpSession session, Model model) {
        // 从会话中获取用户信息
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
            model.addAttribute("isLoggedIn", true);
        } else {
            model.addAttribute("isLoggedIn", false);
        }
        
        // 设置页面元信息
        model.addAttribute("pageTitle", "关于我们 - 随心点");
        model.addAttribute("pageDescription", "了解随心点的故事、理念和团队");
        model.addAttribute("pageType", "public");
        
        return "public/about";
    }
    
    /**
     * 处理index.html访问，重定向到首页
     */
    @GetMapping("/index.html")
    public String indexHtml() {
        return "redirect:/";
    }

    @GetMapping("/hello")
    @ResponseBody
    public String hello() {
        return "Hello, Spring MVC!";
    }
    
    @GetMapping("/login")
    public String home() {
        // 重定向到登录页面
        return "redirect:/";
    }
    
    @GetMapping("/admin-dashboard")
    public String adminDashboard() {
        // 重定向到管理员仪表盘
        return "redirect:/admin/dashboard";
    }
    
    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "测试接口正常!";
    }
} 