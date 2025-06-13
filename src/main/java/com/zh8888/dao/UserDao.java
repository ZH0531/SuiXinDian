package com.zh8888.dao;

import com.zh8888.model.User;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 用户数据访问接口
 */
public interface UserDao {
    
    /**
     * 添加新用户
     * @param user 用户对象
     * @return 受影响的行数
     */
    int insertUser(User user);
    
    /**
     * 根据ID删除用户
     * @param id 用户ID
     * @return 受影响的行数
     */
    int deleteUser(Integer id);
    
    /**
     * 更新用户信息
     * @param user 用户对象
     * @return 受影响的行数
     */
    int updateUser(User user);
    
    /**
     * 根据ID查询用户
     * @param id 用户ID
     * @return 用户对象
     */
    User getUserById(Integer id);
    
    /**
     * 根据用户ID查询用户
     * @param userId 用户ID
     * @return 用户对象
     */
    User getUserByUserId(String userId);
    
    /**
     * 查询所有用户列表
     * @return 用户列表
     */
    List<User> getAllUsers();
    
    /**
     * 根据用户ID和密码查询用户（登录用）
     * @param userId 用户ID
     * @param password 密码
     * @return 用户对象
     */
    User login(@Param("userId") String userId, @Param("password") String password);
    
    /**
     * 根据手机号和密码查询用户（登录用）
     * @param phone 手机号
     * @param password 密码
     * @return 用户对象
     */
    User loginByPhone(@Param("phone") String phone, @Param("password") String password);
    
    /**
     * 根据邮箱和密码查询用户（登录用）
     * @param email 邮箱
     * @param password 密码
     * @return 用户对象
     */
    User loginByEmail(@Param("email") String email, @Param("password") String password);
    
    /**
     * 根据手机号查询用户
     * @param phone 手机号
     * @return 用户对象
     */
    User getUserByPhone(String phone);
    
    /**
     * 根据邮箱查询用户
     * @param email 邮箱
     * @return 用户对象
     */
    User getUserByEmail(String email);
} 