package com.zh8888.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * 图片查看控制器
 * 用于处理图片的显示
 */
@Controller
public class ImageViewController {

    @GetMapping("/static/images/dishes/{date}/{filename:.+}")
    public void viewImage(@PathVariable String date, 
                         @PathVariable String filename,
                         HttpServletRequest request,
                         HttpServletResponse response) throws IOException {
        
        File imageFile = null;
        boolean found = false;
        
        // 方法1：优先从源码目录查找（开发环境优先）
        try {
            String webRootPath = request.getServletContext().getRealPath("/");
            String projectRoot;
            
            if (webRootPath != null && webRootPath.contains("target")) {
                // 在target目录中运行，获取项目根目录
                projectRoot = webRootPath.substring(0, webRootPath.indexOf("target"));
            } else {
                // 使用当前工作目录作为备选
                projectRoot = System.getProperty("user.dir");
                // 如果工作目录是tomcat bin目录，需要回退到项目目录
                if (projectRoot.contains("apache-tomcat") && projectRoot.endsWith("bin")) {
                    projectRoot = projectRoot.substring(0, projectRoot.lastIndexOf("apache-tomcat"));
                }
            }
            
            String sourceImagePath = projectRoot + "src" + File.separator + 
                                   "main" + File.separator + "webapp" + File.separator + 
                                   "static" + File.separator + "images" + File.separator + 
                                   "dishes" + File.separator + date + File.separator + filename;
            
            imageFile = new File(sourceImagePath);
            System.out.println("优先尝试源码路径: " + sourceImagePath);
            
            if (imageFile.exists()) {
                found = true;
                System.out.println("✓ 在源码目录找到图片");
            }
        } catch (Exception e) {
            System.out.println("源码路径查找失败: " + e.getMessage());
        }
        
        // 方法2：如果源码目录没找到，尝试Web部署目录
        if (!found) {
            try {
                String webRootPath = request.getServletContext().getRealPath("/");
                if (webRootPath != null) {
                    String webImagePath = webRootPath + "static" + File.separator + "images" + File.separator + 
                                        "dishes" + File.separator + date + File.separator + filename;
                    imageFile = new File(webImagePath);
                    
                    System.out.println("备选Web部署路径: " + webImagePath);
                    if (imageFile.exists()) {
                        found = true;
                        System.out.println("✓ 在Web部署目录找到图片");
                    }
                }
            } catch (Exception e) {
                System.out.println("Web路径查找失败: " + e.getMessage());
            }
        }
        
        // 方法3：如果都没找到，使用默认图片
        if (!found) {
            System.out.println("× 图片文件不存在，使用默认图片");
            
            // 优先使用源码目录的默认图片
            String webRootPath = request.getServletContext().getRealPath("/");
            String projectRoot;
            
            if (webRootPath != null && webRootPath.contains("target")) {
                projectRoot = webRootPath.substring(0, webRootPath.indexOf("target"));
            } else {
                projectRoot = System.getProperty("user.dir");
                if (projectRoot.contains("apache-tomcat") && projectRoot.endsWith("bin")) {
                    projectRoot = projectRoot.substring(0, projectRoot.lastIndexOf("apache-tomcat"));
                }
            }
            
            String defaultSourcePath = projectRoot + "src" + File.separator + 
                                     "main" + File.separator + "webapp" + File.separator + 
                                     "static" + File.separator + "images" + File.separator + 
                                     "dishes" + File.separator + "default.jpg";
            
            File defaultSourceFile = new File(defaultSourcePath);
            System.out.println("尝试源码默认图片: " + defaultSourcePath);
            
            if (defaultSourceFile.exists()) {
                imageFile = defaultSourceFile;
                found = true;
                System.out.println("✓ 使用源码目录的默认图片");
            } else {
                // 如果源码默认图片不存在，尝试Web部署目录的默认图片
                if (webRootPath != null) {
                    String defaultWebPath = webRootPath + "static" + File.separator + "images" + File.separator + 
                                           "dishes" + File.separator + "default.jpg";
                    File defaultWebFile = new File(defaultWebPath);
                    System.out.println("尝试Web默认图片: " + defaultWebPath);
                    
                    if (defaultWebFile.exists()) {
                        imageFile = defaultWebFile;
                        found = true;
                        System.out.println("✓ 使用Web部署目录的默认图片");
                    } else {
                        // 如果默认图片也不存在，返回404
                        System.out.println("× 默认图片也不存在，返回404");
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        return;
                    }
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
            }
        }
        
        // 设置响应头
        String mimeType = request.getServletContext().getMimeType(filename);
        if (mimeType == null) {
            if (filename.toLowerCase().endsWith(".png")) {
                mimeType = "image/png";
            } else if (filename.toLowerCase().endsWith(".jpg") || filename.toLowerCase().endsWith(".jpeg")) {
                mimeType = "image/jpeg";
            } else {
                mimeType = "image/jpeg"; // 默认
            }
        }
        response.setContentType(mimeType);
        response.setContentLength((int) imageFile.length());
        
        // 输出图片
        try (FileInputStream in = new FileInputStream(imageFile);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
            out.flush();
        }
    }
} 