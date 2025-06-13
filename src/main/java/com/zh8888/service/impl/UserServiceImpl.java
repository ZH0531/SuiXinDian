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
        return userDao.updateUser(user) > 0;
    }

    @Override
    @Transactional
    public boolean deleteUser(Integer id) {
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
        // 如果是新用户，插入
        if (user.getId() == null) {
            userDao.insertUser(user);
        } else {
            // 否则更新用户信息
            userDao.updateUser(user);
        }
    }
    
    @Override
    public String generateUniqueUserId() {
        // 获取所有用户，用于确定最大的序号
        List<User> allUsers = getAllUsers();
        int maxNum = 0;
        
        // 遍历所有用户，找出sxd开头的用户ID，并获取最大序号
        for (User user : allUsers) {
            String userId = user.getUserId();
            if (userId != null && userId.startsWith("sxd") && userId.length() >= 8) {
                try {
                    // 提取数字部分
                    String numStr = userId.substring(3);
                    int num = Integer.parseInt(numStr);
                    if (num > maxNum) {
                        maxNum = num;
                    }
                } catch (NumberFormatException e) {
                    // 忽略无法解析的用户ID
                }
            }
        }
        
        // 下一个序号
        int nextNum = maxNum + 1;
        
        // 格式化为5位数字，前面补0
        return "sxd" + String.format("%05d", nextNum);
    }
} 