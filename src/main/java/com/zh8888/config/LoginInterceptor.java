package com.zh8888.config;

import com.zh8888.model.User;
import com.zh8888.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 登录拦截器，用于处理自动登录功能
 */
public class LoginInterceptor implements HandlerInterceptor {

    @Autowired
    private UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 检查会话中是否已有用户信息
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            return true; // 已登录，继续请求
        }
        
        // 检查是否有"记住我"的Cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_user".equals(cookie.getName())) {
                    String username = cookie.getValue();
                    // 根据Cookie中保存的用户名查找用户
                    User user = userService.findByUserId(username);
                    if (user != null) {
                        // 自动登录成功，将用户信息存入会话
                        session.setAttribute("user", user);
                        session.setAttribute("userId", user.getId());
                        session.setAttribute("username", user.getUsername());
                    }
                    break;
                }
            }
        }
        
        return true; // 继续处理请求
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // 如果有视图，添加用户信息
        if (modelAndView != null) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user != null) {
                modelAndView.addObject("user", user);
                modelAndView.addObject("isLoggedIn", true);
            } else {
                modelAndView.addObject("isLoggedIn", false);
            }
        }
    }
} 