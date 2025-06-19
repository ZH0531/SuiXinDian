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
        
        // 构建文件路径
        String projectRoot = System.getProperty("user.dir");
        String filePath = projectRoot + File.separator + "src" + File.separator + 
                         "main" + File.separator + "webapp" + File.separator + 
                         "static" + File.separator + "images" + File.separator + 
                         "dishes" + File.separator + date + File.separator + filename;
        
        File imageFile = new File(filePath);
        String realPath = null;
        
        // 如果文件不存在，尝试其他路径
        if (!imageFile.exists()) {
            realPath = request.getServletContext().getRealPath("/static/images/dishes/" + date + "/" + filename);
            if (realPath != null) {
                imageFile = new File(realPath);
            }
        }
        
        // 如果文件不存在，返回默认图片
        if (!imageFile.exists()) {
            System.out.println("图片文件不存在: " + filePath);
            
            // 尝试使用默认图片
            String defaultImagePath;
            if (realPath == null) {
                realPath = request.getServletContext().getRealPath("/");
            }
            
            if (realPath != null && realPath.contains("target")) {
                // 在target目录中运行，使用源码目录的默认图片
                String projectRootFromReal = realPath.substring(0, realPath.indexOf("target"));
                defaultImagePath = projectRootFromReal + "src" + File.separator + 
                                 "main" + File.separator + "webapp" + File.separator + 
                                 "static" + File.separator + "images" + File.separator + 
                                 "dishes" + File.separator + "default.jpg";
            } else {
                // 使用项目根目录的默认图片
                defaultImagePath = projectRoot + File.separator + "src" + File.separator + 
                                 "main" + File.separator + "webapp" + File.separator + 
                                 "static" + File.separator + "images" + File.separator + 
                                 "dishes" + File.separator + "default.jpg";
            }
            
            File defaultFile = new File(defaultImagePath);
            System.out.println("尝试使用默认图片: " + defaultImagePath);
            
            if (defaultFile.exists()) {
                imageFile = defaultFile;
            } else {
                // 如果默认图片也不存在，返回404
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
        }
        
        // 设置响应头
        String mimeType = request.getServletContext().getMimeType(filename);
        if (mimeType == null) {
            mimeType = "image/jpeg";
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