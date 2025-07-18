package com.zh8888.controller;

import com.zh8888.model.User;
import org.springframework.beans.factory.annotation.Value;
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
    
    // 从配置文件读取，如果没有配置则使用默认值
    @Value("${upload.path:}")
    private String uploadPath;

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
            
            // 获取上传目录
            String uploadDir;
            
            // 调试信息：显示配置值
            System.out.println("=== 图片上传调试信息 ===");
            System.out.println("uploadPath配置值: '" + uploadPath + "'");
            System.out.println("uploadPath是否为空: " + (uploadPath == null || uploadPath.isEmpty()));
            System.out.println("日期路径: " + datePath);
            
            if (uploadPath != null && !uploadPath.isEmpty()) {
                // 使用配置的绝对路径
                uploadDir = uploadPath + File.separator + "dishes" + File.separator + datePath;
                System.out.println("使用外部路径: " + uploadDir);
            } else {
                // 智能查找项目源码路径
                String realPath = request.getServletContext().getRealPath("/");
                
                // 如果是在target目录中运行，尝试找到源码目录
                if (realPath != null && realPath.contains("target")) {
                    // 从 target 路径推断出项目根目录
                    String projectRoot = realPath.substring(0, realPath.indexOf("target"));
                    uploadDir = projectRoot + "src" + File.separator + 
                               "main" + File.separator + "webapp" + File.separator + 
                               "static" + File.separator + "images" + File.separator + 
                               "dishes" + File.separator + datePath;
                } else {
                    // 使用固定的项目源码路径作为后备方案
                    uploadDir = "D:" + File.separator + "Desktop" + File.separator + 
                               "WebShixun" + File.separator + "src" + File.separator + 
                               "main" + File.separator + "webapp" + File.separator + 
                               "static" + File.separator + "images" + File.separator + 
                               "dishes" + File.separator + datePath;
                }
                
                System.out.println("使用源码目录保存图片: " + uploadDir);
            }
            
            File dir = new File(uploadDir);
            System.out.println("尝试创建目录: " + uploadDir);
            System.out.println("目录是否存在: " + dir.exists());
            System.out.println("父目录是否存在: " + (dir.getParentFile() != null ? dir.getParentFile().exists() : "无父目录"));
            
            if (!dir.exists()) {
                boolean created = dir.mkdirs();
                if (!created) {
                    String errorMsg = "创建上传目录失败: " + uploadDir;
                    
                    // 提供更详细的错误信息
                    if (dir.getParentFile() != null && !dir.getParentFile().exists()) {
                        errorMsg += " (父目录不存在)";
                    }
                    if (!dir.getParentFile().canWrite()) {
                        errorMsg += " (无写入权限)";
                    }
                    
                    System.out.println("错误详情: " + errorMsg);
                    result.put("success", false);
                    result.put("message", errorMsg);
                    return result;
                }
                System.out.println("✓ 目录创建成功");
            } else {
                System.out.println("✓ 目录已存在");
            }
            
            // 保存文件
            File destFile = new File(uploadDir + File.separator + newFilename);
            image.transferTo(destFile);
            
            // 验证文件是否真的保存成功
            if (!destFile.exists()) {
                result.put("success", false);
                result.put("message", "文件保存失败");
                return result;
            }
            
            // 返回文件访问路径
            String filePath = "/static/images/dishes/" + datePath + "/" + newFilename;
            
            result.put("success", true);
            result.put("path", filePath);
            result.put("message", "上传成功");
            
            // 添加调试信息
            System.out.println("=== 图片上传成功 ===");
            System.out.println("文件已保存到: " + destFile.getAbsolutePath());
            System.out.println("文件大小: " + destFile.length() + " bytes");
            System.out.println("访问路径: " + filePath);
            System.out.println("==================");
            
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