package com.zh8888.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

    @GetMapping("/hello")
    @ResponseBody
    public String hello() {
        return "Hello, Spring MVC!";
    }
    
    @GetMapping("/")
    public String home() {
        return "index";
    }
    
    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "测试接口正常!";
    }
} 