package com.zh8888.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

/**
 * Web资源配置
 * 处理静态资源映射，包括上传的图片
 */
@Configuration
public class WebResourceConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 配置静态资源映射
        registry.addResourceHandler("/static/**")
                .addResourceLocations("/static/", "classpath:/static/");
        
        // 获取项目根目录
        String projectRoot = System.getProperty("user.dir");
        String uploadPath = "file:" + projectRoot + File.separator + "src" + File.separator + 
                           "main" + File.separator + "webapp" + File.separator + "static" + File.separator;
        
        // 添加本地文件系统路径映射，用于开发环境
        registry.addResourceHandler("/static/images/dishes/**")
                .addResourceLocations("/static/images/dishes/", uploadPath + "images/dishes/");
        
        System.out.println("静态资源映射配置完成，上传路径: " + uploadPath);
    }
} 