package com.zh8888.service;

import com.zh8888.model.User;
import java.util.List;

/**
 * 用户服务接口
 */
public interface UserService {
    
    /**
     * 注册新用户
     * @param user 用户信息
     * @return 注册成功返回true，失败返回false
     */
    boolean register(User user);
    
    /**
     * 使用用户ID和密码登录
     * @param userId 用户ID
     * @param password 密码
     * @return 登录成功返回用户对象，失败返回null
     */
    User login(String userId, String password);
    
    /**
     * 使用手机号和密码登录
     * @param phone 手机号
     * @param password 密码
     * @return 登录成功返回用户对象，失败返回null
     */
    User loginByPhone(String phone, String password);
    
    /**
     * 使用邮箱和密码登录
     * @param email 邮箱
     * @param password 密码
     * @return 登录成功返回用户对象，失败返回null
     */
    User loginByEmail(String email, String password);
    
    /**
     * 检查用户ID是否已存在
     * @param userId 用户ID
     * @return 存在返回true，不存在返回false
     */
    boolean isUserIdExist(String userId);
    
    /**
     * 获取用户信息
     * @param id 用户ID
     * @return 用户对象
     */
    User getUserById(Integer id);
    
    /**
     * 更新用户信息
     * @param user 用户对象
     * @return 更新成功返回true，失败返回false
     */
    boolean updateUser(User user);
    
    /**
     * 删除用户
     * @param id 用户ID
     * @return 删除成功返回true，失败返回false
     */
    boolean deleteUser(Integer id);
    
    /**
     * 获取所有用户列表
     * @return 用户列表
     */
    List<User> getAllUsers();
    
    /**
     * 根据用户ID查找用户
     * @param userId 用户ID
     * @return 用户对象，未找到返回null
     */
    User findByUserId(String userId);
    
    /**
     * 根据手机号查找用户
     * @param phone 手机号
     * @return 用户对象，未找到返回null
     */
    User findByPhone(String phone);
    
    /**
     * 根据邮箱查找用户
     * @param email 邮箱
     * @return 用户对象，未找到返回null
     */
    User findByEmail(String email);
    
    /**
     * 密码加密
     * @param rawPassword 原始密码
     * @return 加密后的密码
     */
    String encryptPassword(String rawPassword);
    
    /**
     * 验证密码
     * @param user 用户对象
     * @param rawPassword 原始密码
     * @return 密码正确返回true，错误返回false
     */
    boolean verifyPassword(User user, String rawPassword);
    
    /**
     * 保存用户
     * @param user 用户对象
     */
    void save(User user);
    
    /**
     * 生成唯一的用户ID
     * 格式为sxd开头，后面跟5位数字，从00001开始递增
     * @return 唯一的用户ID
     */
    String generateUniqueUserId();
} 