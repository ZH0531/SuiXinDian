package com.zh8888.controller;

import org.springframework.beans.factory.annotation.Value;
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

    @Value("${upload.path:}")
    private String uploadPath;

    @GetMapping("/static/images/dishes/{date}/{filename:.+}")
    public void viewImage(@PathVariable String date, 
                         @PathVariable String filename,
                         HttpServletRequest request,
                         HttpServletResponse response) throws IOException {
        
        File imageFile = null;
        boolean found = false;
        
        // 方法1：优先从外部配置目录查找（生产环境）
        if (uploadPath != null && !uploadPath.isEmpty()) {
            try {
                String externalImagePath = uploadPath + File.separator + "dishes" + File.separator + 
                                         date + File.separator + filename;
                imageFile = new File(externalImagePath);
                System.out.println("优先尝试外部路径: " + externalImagePath);
                
                if (imageFile.exists()) {
                    found = true;
                    System.out.println("✓ 在外部目录找到图片");
                }
            } catch (Exception e) {
                System.out.println("外部路径查找失败: " + e.getMessage());
            }
        }
        
        // 方法2：如果外部目录没找到，尝试源码目录（开发环境）
        if (!found) {
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
                System.out.println("尝试源码路径: " + sourceImagePath);
                
                if (imageFile.exists()) {
                    found = true;
                    System.out.println("✓ 在源码目录找到图片");
                }
            } catch (Exception e) {
                System.out.println("源码路径查找失败: " + e.getMessage());
            }
        }
        
        // 方法3：如果源码目录没找到，尝试Web部署目录
        if (!found) {
            try {
                String webRootPath = request.getServletContext().getRealPath("/");
                if (webRootPath != null) {
                    String webImagePath = webRootPath + "static" + File.separator + "images" + File.separator + 
                                        "dishes" + File.separator + date + File.separator + filename;
                    imageFile = new File(webImagePath);
                    
                    System.out.println("尝试Web部署路径: " + webImagePath);
                    if (imageFile.exists()) {
                        found = true;
                        System.out.println("✓ 在Web部署目录找到图片");
                    }
                }
            } catch (Exception e) {
                System.out.println("Web路径查找失败: " + e.getMessage());
            }
        }
        
        // 方法4：如果都没找到，使用默认图片
        if (!found) {
            System.out.println("× 图片文件不存在，使用默认图片");
            
            // 优先使用外部目录的默认图片
            if (uploadPath != null && !uploadPath.isEmpty()) {
                String defaultExternalPath = uploadPath + File.separator + "dishes" + File.separator + "default.jpg";
                File defaultExternalFile = new File(defaultExternalPath);
                if (defaultExternalFile.exists()) {
                    imageFile = defaultExternalFile;
                    found = true;
                    System.out.println("✓ 使用外部默认图片");
                }
            }
            
            // 如果外部默认图片不存在，使用源码目录的默认图片
            if (!found) {
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
                    System.out.println("✓ 使用源码默认图片");
                } else {
                    // 最后尝试Web部署目录的默认图片
                    String webRootPath2 = request.getServletContext().getRealPath("/");
                    if (webRootPath2 != null) {
                        String defaultWebPath = webRootPath2 + "static" + File.separator + "images" + File.separator + 
                                              "dishes" + File.separator + "default.jpg";
                        File defaultWebFile = new File(defaultWebPath);
                        if (defaultWebFile.exists()) {
                            imageFile = defaultWebFile;
                            found = true;
                            System.out.println("✓ 使用Web部署默认图片");
                        }
                    }
                }
            }
        }
        
        if (found && imageFile != null) {
            // 设置响应头
            response.setContentType("image/jpeg");
            response.setHeader("Cache-Control", "max-age=31536000");
            
            try (FileInputStream fis = new FileInputStream(imageFile);
                 OutputStream out = response.getOutputStream()) {
                
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                out.flush();
            }
        } else {
            System.out.println("× 所有路径都未找到图片文件");
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
} 