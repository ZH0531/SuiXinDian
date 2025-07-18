package com.zh8888.config;

import org.springframework.beans.factory.annotation.Value;
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

    @Value("${upload.path:}")
    private String uploadPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 配置静态资源映射
        registry.addResourceHandler("/static/**")
                .addResourceLocations("/static/", "classpath:/static/");
        
        // 如果配置了外部上传路径，则使用外部路径
        if (uploadPath != null && !uploadPath.isEmpty()) {
            String externalPath = "file:" + uploadPath + File.separator;
            registry.addResourceHandler("/static/images/dishes/**")
                    .addResourceLocations(externalPath + "dishes/");
            System.out.println("使用外部图片存储路径: " + externalPath + "dishes/");
        } else {
            // 开发环境：使用项目内路径
            String projectRoot = System.getProperty("user.dir");
            String uploadPathLocal = "file:" + projectRoot + File.separator + "src" + File.separator + 
                               "main" + File.separator + "webapp" + File.separator + "static" + File.separator;
            
            registry.addResourceHandler("/static/images/dishes/**")
                    .addResourceLocations("/static/images/dishes/", uploadPathLocal + "images/dishes/");
            System.out.println("使用项目内图片存储路径: " + uploadPathLocal + "images/dishes/");
        }
    }
} 