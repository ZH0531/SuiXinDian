package com.zh8888.controller;

import com.zh8888.dao.TestDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 测试控制器
 */
@Controller
@RequestMapping("/test")
public class TestController {

    @Autowired
    private TestDao testDao;

    /**
     * 测试数据库连接
     * @return 当前时间
     */
    @GetMapping(value = "/time", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String getCurrentTime() {
        try {
            LocalDateTime now = testDao.getCurrentTime();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH:mm:ss");
            return "数据库连接成功，当前时间: " + now.format(formatter);
        } catch (Exception e) {
            return "数据库连接失败: " + e.getMessage();
        }
    }

    /**
     * 测试视图
     * @param model 模型
     * @return 视图名称
     */
    @GetMapping("/view")
    public String testView(Model model) {
        model.addAttribute("message", "Hello Spring MVC!");
        return "test";
    }
} 