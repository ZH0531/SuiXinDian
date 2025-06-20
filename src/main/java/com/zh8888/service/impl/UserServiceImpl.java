package com.zh8888.service.impl;

import com.zh8888.dao.UserDao;
import com.zh8888.model.User;
import com.zh8888.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户服务实现类
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    @Transactional
    public boolean register(User user) {
        // 设置默认角色为普通用户
        if (user.getRole() == null) {
            user.setRole(0);
        }
        
        // 检查用户ID是否已存在
        if (isUserIdExist(user.getUserId())) {
            return false;
        }
        
        // 不对密码进行加密，直接存储
        
        return userDao.insertUser(user) > 0;
    }

    @Override
    public User login(String userId, String password) {
        // 直接使用数据库中的login方法，传入明文用户ID和密码
        return userDao.login(userId, password);
    }

    @Override
    public User loginByPhone(String phone, String password) {
        // 直接使用数据库中的loginByPhone方法
        return userDao.loginByPhone(phone, password);
    }

    @Override
    public User loginByEmail(String email, String password) {
        // 直接使用数据库中的loginByEmail方法 
        return userDao.loginByEmail(email, password);
    }

    @Override
    public boolean isUserIdExist(String userId) {
        return userDao.getUserByUserId(userId) != null;
    }

    @Override
    public User getUserById(Integer id) {
        return userDao.getUserById(id);
    }

    @Override
    @Transactional
    public boolean updateUser(User user) {
        if (user == null || user.getId() == null) {
            return false;
        }
        
        // 检查用户是否存在
        User existingUser = userDao.getUserById(user.getId());
        if (existingUser == null) {
            return false;
        }
        
        // 处理空字符串，将其转换为 null 以避免唯一性约束冲突
        if (user.getPhone() != null && user.getPhone().trim().isEmpty()) {
            user.setPhone(null);
        }
        if (user.getEmail() != null && user.getEmail().trim().isEmpty()) {
            user.setEmail(null);
        }
        if (user.getAddress() != null && user.getAddress().trim().isEmpty()) {
            user.setAddress(null);
        }
        if (user.getUsername() != null && user.getUsername().trim().isEmpty()) {
            user.setUsername(null);
        }
        
        // 如果有提供新密码，需要加密
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(encryptPassword(user.getPassword()));
        } else {
            // 不更新密码字段
            user.setPassword(null);
        }
        
        return userDao.updateUser(user) > 0;
    }

    @Override
    @Transactional
    public boolean deleteUser(Integer id) {
        if (id == null) {
            return false;
        }
        
        return userDao.deleteUser(id) > 0;
    }

    @Override
    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }
    
    @Override
    public User findByUserId(String userId) {
        return userDao.getUserByUserId(userId);
    }
    
    @Override
    public User findByPhone(String phone) {
        return userDao.getUserByPhone(phone);
    }
    
    @Override
    public User findByEmail(String email) {
        return userDao.getUserByEmail(email);
    }
    
    @Override
    public String encryptPassword(String rawPassword) {
        // 不进行加密，直接返回明文密码
        return rawPassword;
    }
    
    @Override
    public boolean verifyPassword(User user, String rawPassword) {
        // 直接比较明文密码
        return user.getPassword().equals(rawPassword);
    }
    
    @Override
    @Transactional
    public void save(User user) {
        userDao.insertUser(user);
    }
    
    @Override
    public String generateUniqueUserId() {
        // 获取最后一个用户ID
        String lastUserId = userDao.getLastUserId();
        
        int nextNum = 1;
        if (lastUserId != null && lastUserId.length() >= 8) {
            try {
                // 提取用户ID中的数字部分
                String numPart = lastUserId.substring(3);
                nextNum = Integer.parseInt(numPart) + 1;
            } catch (NumberFormatException e) {
                // 如果解析失败，默认从1开始
                nextNum = 1;
            }
        }
        
        // 格式化为5位数，不足前面补0
        return "sxd" + String.format("%05d", nextNum);
    }
    
    @Override
    public int getUserCount() {
        return userDao.getUserCount();
    }
} 