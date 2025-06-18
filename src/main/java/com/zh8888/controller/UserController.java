package com.zh8888.controller;

import com.zh8888.model.User;
import com.zh8888.service.UserService;
import com.zh8888.service.OrderService;
import com.zh8888.model.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * 用户控制器
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    /**
     * 跳转到登录页面
     */
    @GetMapping("/login")
    public String login(Model model) {
        // 设置页面元信息
        model.addAttribute("pageTitle", "用户登录 - 随心点");
        model.addAttribute("pageDescription", "登录您的随心点账户");
        model.addAttribute("pageType", "auth");
        
        return "public/index";
    }

    /**
     * 跳转到注册页面第一步
     */
    @GetMapping("/register")
    public String register(Model model) {
        // 设置页面元信息
        model.addAttribute("pageTitle", "用户注册 - 随心点");
        model.addAttribute("pageDescription", "注册随心点账户，开始您的美食之旅");
        model.addAttribute("pageType", "auth");
        
        return "auth/register";
    }

    /**
     * 跳转到注册页面第二步（完善个人信息）
     */
    @GetMapping("/register_profile")
    public String registerProfile(Model model) {
        // 设置页面元信息
        model.addAttribute("pageTitle", "完善个人信息 - 随心点");
        model.addAttribute("pageDescription", "完善您的个人信息");
        model.addAttribute("pageType", "auth");
        
        return "auth/register_profile";
    }
    
    /**
     * 检查手机号是否存在
     */
    @GetMapping("/checkPhone")
    @ResponseBody
    public Map<String, Boolean> checkPhone(@RequestParam String phone) {
        Map<String, Boolean> result = new HashMap<>();
        result.put("exist", userService.findByPhone(phone) != null);
        return result;
    }
    
    /**
     * 完成用户注册
     */
    @PostMapping("/completeRegister")
    @ResponseBody
    public Map<String, Object> completeRegister(@RequestParam Map<String, String> params) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 提取表单数据
            String phone = params.get("phone");
            String password = params.get("password");
            String name = params.get("name");
            int gender = Integer.parseInt(params.get("gender"));
            
            // 验证手机号唯一性
            if (userService.findByPhone(phone) != null) {
                response.put("success", false);
                response.put("message", "手机号已被注册");
                return response;
            }
            
            // 生成用户ID sxd00001, sxd00002, ...
            String userId = userService.generateUniqueUserId();
            
            // 创建用户对象
            User user = new User();
            user.setUserId(userId);
            user.setPassword(userService.encryptPassword(password));
            user.setPhone(phone);
            user.setUsername(name);
            user.setGender(gender);
            user.setRole(0); // 默认为普通用户
            
            // 保存用户
            userService.save(user);
            
            response.put("success", true);
            response.put("message", "注册成功，请登录");
            response.put("redirect", "/");
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "注册失败：" + e.getMessage());
        }
        
        return response;
    }

    /**
     * 处理用户登录请求
     */
    @PostMapping("/login")
    public String login(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam(value = "loginType", defaultValue = "username") String loginType,
            @RequestParam(value = "rememberMe", required = false) String rememberMe,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {

        try {
            User user;
            // 根据登录类型选择不同的验证方式
            switch (loginType) {
                case "phone":
                    user = userService.findByPhone(username);
                    break;
                case "email":
                    user = userService.findByEmail(username);
                    break;
                case "username":
                default:
                    // 尝试使用用户ID/手机号/邮箱登录
                    user = userService.findByUserId(username);
                    if (user == null) {
                        user = userService.findByPhone(username);
                    }
                    if (user == null) {
                        user = userService.findByEmail(username);
                    }
                    break;
            }

            if (user == null) {
                // 获取请求URL，判断是否来自主页登录框
                String referer = request.getHeader("Referer");
                
                if (referer != null && referer.endsWith("/")) {
                    // 来自首页的请求，重定向回首页并显示错误
                    return "redirect:/?error=" + java.net.URLEncoder.encode("用户不存在", "UTF-8");
                } else {
                    model.addAttribute("error", "用户不存在");
                    model.addAttribute("pageTitle", "用户登录 - 随心点");
                    model.addAttribute("pageType", "auth");
                    return "public/index";
                }
            }

            if (!userService.verifyPassword(user, password)) {
                // 获取请求URL，判断是否来自主页登录框
                String referer = request.getHeader("Referer");
                
                if (referer != null && referer.endsWith("/")) {
                    // 来自首页的请求，重定向回首页并显示错误
                    return "redirect:/?error=" + java.net.URLEncoder.encode("密码错误", "UTF-8");
                } else {
                    model.addAttribute("error", "密码错误");
                    model.addAttribute("pageTitle", "用户登录 - 随心点");
                    model.addAttribute("pageType", "auth");
                    return "public/index";
                }
            }

            // 设置会话信息
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userIdString", user.getUserId());
            
            // 如果选择"记住我"，设置Cookie
            if (rememberMe != null) {
                // 创建持久化Cookie，有效期7天
                Cookie userCookie = new Cookie("remember_user", user.getUserId());
                userCookie.setMaxAge(7 * 24 * 60 * 60); // 7天有效期
                userCookie.setPath("/");
                response.addCookie(userCookie);
            }

            // 根据用户角色返回不同页面
            if (user.getRole() == 1) { // 管理员
                return "redirect:/admin/dashboard";
            } else { // 普通用户
                return "redirect:/user/dashboard";
            }
        } catch (Exception e) {
            // 获取请求URL，判断是否来自主页登录框
            String referer = request.getHeader("Referer");
            
            if (referer != null && referer.endsWith("/")) {
                try {
                    // 来自首页的请求，重定向回首页并显示错误
                    return "redirect:/?error=" + java.net.URLEncoder.encode("登录失败: " + e.getMessage(), "UTF-8");
                } catch (Exception ex) {
                    return "redirect:/?error=登录失败";
                }
            } else {
                model.addAttribute("error", "登录失败: " + e.getMessage());
                model.addAttribute("pageTitle", "用户登录 - 随心点");
                model.addAttribute("pageType", "auth");
                return "public/index";
            }
        }
    }
    
    /**
     * 检查用户ID是否存在
     */
    @GetMapping("/checkUserId")
    @ResponseBody
    public Map<String, Boolean> checkUserId(@RequestParam String userId) {
        Map<String, Boolean> result = new HashMap<>();
        result.put("exist", userService.findByUserId(userId) != null);
        return result;
    }
    
    /**
     * 退出登录
     */
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        // 清除会话
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // 清除Cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_user".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    break;
                }
            }
        }
        
        return "redirect:/";
    }
    
    /**
     * 个人中心页面
     */
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        // 检查用户是否已登录
        User loginUser = (User) session.getAttribute("user");
        if (loginUser == null) {
            // 未登录，重定向到首页
            return "redirect:/";
        }
        
        // 设置页面元信息
        model.addAttribute("user", loginUser);
        model.addAttribute("isLoggedIn", true); // 添加登录状态
        model.addAttribute("pageTitle", "个人资料 - 随心点");
        model.addAttribute("pageDescription", "管理您的个人信息");
        model.addAttribute("pageType", "user");
        
        // 已登录，展示个人资料页面
        return "user/profile";
    }

    // 用户仪表盘
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        
        // 设置页面元信息
        model.addAttribute("user", user);
        model.addAttribute("isLoggedIn", true); // 添加登录状态
        model.addAttribute("pageTitle", "用户中心 - 随心点");
        model.addAttribute("pageDescription", "欢迎回到您的个人中心");
        model.addAttribute("pageType", "user");
        
        // 获取最近一条订单
        Order latestOrder = orderService.getLatestOrderByUserId(user.getId());
        model.addAttribute("latestOrder", latestOrder);
        
        return "user/dashboard";
    }
    
    /**
     * 更新用户个人资料
     */
    @PostMapping("/updateProfile")
    @ResponseBody
    public Map<String, Object> updateProfile(HttpServletRequest request, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 检查用户是否已登录
            User loginUser = (User) session.getAttribute("user");
            if (loginUser == null) {
                response.put("success", false);
                response.put("message", "用户未登录");
                return response;
            }
            
            // 获取当前用户的完整信息
            User user = userService.getUserById(loginUser.getId());
            if (user == null) {
                response.put("success", false);
                response.put("message", "用户不存在");
                return response;
            }
            
            // 处理更新字段
            boolean updated = false;
            
            // 更新用户名（显示名称）
            String username = request.getParameter("username");
            if (username != null) {
                user.setUsername(username.trim().isEmpty() ? null : username.trim());
                updated = true;
            }
            
            // 更新性别
            String gender = request.getParameter("gender");
            if (gender != null && !gender.trim().isEmpty()) {
                user.setGender(Integer.parseInt(gender));
                updated = true;
            }
            
            // 更新手机号
            String phone = request.getParameter("phone");
            if (phone != null) {
                if (!phone.trim().isEmpty()) {
                    // 检查手机号是否已被其他用户使用
                    User existingUser = userService.findByPhone(phone.trim());
                    if (existingUser != null && !existingUser.getId().equals(user.getId())) {
                        response.put("success", false);
                        response.put("message", "手机号已被使用");
                        return response;
                    }
                    user.setPhone(phone.trim());
                } else {
                    user.setPhone(null);
                }
                updated = true;
            }
            
            // 更新邮箱
            String email = request.getParameter("email");
            if (email != null) {
                if (!email.trim().isEmpty()) {
                    // 检查邮箱是否已被其他用户使用
                    User existingUser = userService.findByEmail(email.trim());
                    if (existingUser != null && !existingUser.getId().equals(user.getId())) {
                        response.put("success", false);
                        response.put("message", "邮箱已被使用");
                        return response;
                    }
                    user.setEmail(email.trim());
                } else {
                    user.setEmail(null);
                }
                updated = true;
            }
            
            if (updated) {
                // 保存更新
                userService.updateUser(user);
                
                // 更新session中的用户信息
                session.setAttribute("user", user);
                
                response.put("success", true);
                response.put("message", "更新成功");
            } else {
                response.put("success", false);
                response.put("message", "没有需要更新的内容");
            }
            
        } catch (NumberFormatException e) {
            response.put("success", false);
            response.put("message", "性别参数格式错误");
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "更新失败：" + e.getMessage());
        }
        
        return response;
    }
    
    /**
     * 更新用户个人资料（包含密码修改和头像上传）
     */
    @PostMapping("/profile/update")
    @ResponseBody
    public Map<String, Object> updateProfileAdvanced(HttpServletRequest request, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 检查用户是否已登录
            User loginUser = (User) session.getAttribute("user");
            if (loginUser == null) {
                response.put("success", false);
                response.put("message", "用户未登录");
                return response;
            }
            
            // 获取当前用户的完整信息
            User user = userService.getUserById(loginUser.getId());
            if (user == null) {
                response.put("success", false);
                response.put("message", "用户不存在");
                return response;
            }
            
            boolean updated = false;
            
            // 更新基本信息
            String username = request.getParameter("username");
            if (username != null && !username.trim().isEmpty()) {
                user.setUsername(username.trim());
                updated = true;
            }
            
            String email = request.getParameter("email");
            if (email != null && !email.trim().isEmpty()) {
                // 检查邮箱是否已被其他用户使用
                User existingUser = userService.findByEmail(email.trim());
                if (existingUser != null && !existingUser.getId().equals(user.getId())) {
                    response.put("success", false);
                    response.put("message", "邮箱已被使用");
                    return response;
                }
                user.setEmail(email.trim());
                updated = true;
            }
            
            String phone = request.getParameter("phone");
            if (phone != null && !phone.trim().isEmpty()) {
                // 检查手机号是否已被其他用户使用
                User existingUser = userService.findByPhone(phone.trim());
                if (existingUser != null && !existingUser.getId().equals(user.getId())) {
                    response.put("success", false);
                    response.put("message", "手机号已被使用");
                    return response;
                }
                user.setPhone(phone.trim());
                updated = true;
            }
            
            // 处理密码修改
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            
            if (currentPassword != null && !currentPassword.trim().isEmpty() && 
                newPassword != null && !newPassword.trim().isEmpty()) {
                
                // 验证当前密码
                if (!userService.verifyPassword(user, currentPassword)) {
                    response.put("success", false);
                    response.put("message", "当前密码不正确");
                    return response;
                }
                
                // 更新密码
                user.setPassword(userService.encryptPassword(newPassword));
                updated = true;
            }
            
            if (updated) {
                // 保存更新
                userService.updateUser(user);
                
                // 更新session中的用户信息
                session.setAttribute("user", user);
                
                response.put("success", true);
                response.put("message", "个人资料更新成功");
            } else {
                response.put("success", false);
                response.put("message", "没有需要更新的内容");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "更新失败：" + e.getMessage());
        }
        
        return response;
    }
} 