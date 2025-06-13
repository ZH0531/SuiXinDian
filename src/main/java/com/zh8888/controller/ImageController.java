package com.zh8888.controller;

import com.zh8888.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
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
     * 上传菜品图片
     */
    @PostMapping("/upload")
    @ResponseBody
    public Map<String, Object> uploadImage(@RequestParam("file") MultipartFile file, 
                                         HttpServletRequest request, 
                                         HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 检查管理员权限
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != 1) {
            response.put("success", false);
            response.put("message", "权限不足，只有管理员可以上传图片");
            return response;
        }
        
        // 检查文件是否为空
        if (file.isEmpty()) {
            response.put("success", false);
            response.put("message", "请选择要上传的图片文件");
            return response;
        }
        
        try {
            // 检查文件类型
            String originalFilename = file.getOriginalFilename();
            if (originalFilename == null || !isImageFile(originalFilename)) {
                response.put("success", false);
                response.put("message", "只支持 JPG、JPEG、PNG、GIF 格式的图片");
                return response;
            }
            
            // 检查文件大小（限制为5MB）
            if (file.getSize() > 5 * 1024 * 1024) {
                response.put("success", false);
                response.put("message", "图片文件大小不能超过5MB");
                return response;
            }
            
            // 获取文件扩展名
            String fileExtension = getFileExtension(originalFilename);
            
            // 生成唯一文件名
            String fileName = UUID.randomUUID().toString() + "." + fileExtension;
            
            // 构建上传目录路径
            String uploadDir = request.getServletContext().getRealPath("/static/images/dishes/");
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }
            
            // 保存文件
            File destFile = new File(uploadDir + fileName);
            file.transferTo(destFile);
            
            // 返回图片URL
            String imageUrl = "/static/images/dishes/" + fileName;
            
            response.put("success", true);
            response.put("message", "图片上传成功");
            response.put("imageUrl", imageUrl);
            response.put("fileName", fileName);
            
        } catch (IOException e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "图片上传失败：" + e.getMessage());
        }
        
        return response;
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