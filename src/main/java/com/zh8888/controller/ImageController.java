package com.zh8888.controller;

import com.zh8888.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 图片上传控制器
 */
@Controller
@RequestMapping("/image")
public class ImageController {

    /**
     * 上传图片
     * @param image 图片文件
     * @param request HTTP请求
     * @return 上传结果
     */
    @PostMapping("/upload")
    @ResponseBody
    public Map<String, Object> upload(@RequestParam("image") MultipartFile image, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        
        // 检查文件是否为空
        if (image.isEmpty()) {
            result.put("success", false);
            result.put("message", "请选择图片");
            return result;
        }
        
        // 检查文件类型
        String contentType = image.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            result.put("success", false);
            result.put("message", "只支持图片文件");
            return result;
        }
        
        try {
            // 获取文件后缀
            String originalFilename = image.getOriginalFilename();
            String suffix = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            
            // 生成新文件名
            String newFilename = UUID.randomUUID().toString().replace("-", "") + suffix;
            
            // 按日期创建目录
            String datePath = new SimpleDateFormat("yyyyMMdd").format(new Date());
            
            // 获取上传目录的真实路径
            String uploadDir = request.getServletContext().getRealPath("/static/images/dishes/") + datePath;
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            // 保存文件
            File destFile = new File(uploadDir + File.separator + newFilename);
            image.transferTo(destFile);
            
            // 返回文件访问路径
            String filePath = "/static/images/dishes/" + datePath + "/" + newFilename;
            
            result.put("success", true);
            result.put("path", filePath);
            result.put("message", "上传成功");
        } catch (IOException e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "上传失败：" + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 删除菜品图片
     */
    @PostMapping("/delete")
    @ResponseBody
    public Map<String, Object> deleteImage(@RequestParam("imageUrl") String imageUrl, 
                                         HttpServletRequest request, 
                                         HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查管理员权限
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != 1) {
            response.put("success", false);
            response.put("message", "权限不足，只有管理员可以删除图片");
            return response;
        }
        
        try {
            // 构建文件路径
            String filePath = request.getServletContext().getRealPath(imageUrl);
            File file = new File(filePath);
            
            if (file.exists()) {
                boolean deleted = file.delete();
                if (deleted) {
                    response.put("success", true);
                    response.put("message", "图片删除成功");
                } else {
                    response.put("success", false);
                    response.put("message", "图片删除失败");
                }
            } else {
                response.put("success", false);
                response.put("message", "图片文件不存在");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "图片删除失败：" + e.getMessage());
        }
        
        return response;
    }
    
    /**
     * 检查是否为图片文件
     */
    private boolean isImageFile(String filename) {
        String extension = getFileExtension(filename).toLowerCase();
        return extension.equals("jpg") || extension.equals("jpeg") || 
               extension.equals("png") || extension.equals("gif");
    }
    
    /**
     * 获取文件扩展名
     */
    private String getFileExtension(String filename) {
        int lastDotIndex = filename.lastIndexOf(".");
        if (lastDotIndex > 0 && lastDotIndex < filename.length() - 1) {
            return filename.substring(lastDotIndex + 1);
        }
        return "";
    }
} 