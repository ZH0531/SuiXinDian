package com.zh8888.model;

import lombok.Data;

import java.util.Date;

/**
 * 用户实体类
 */
@Data
public class User {
    
    /**
     * 用户ID
     */
    private Integer id;
    
    /**
     * 用户ID（登录用的ID）
     */
    private String userId;
    
    /**
     * 密码
     */
    private String password;
    
    /**
     * 用户名（显示名称）
     */
    private String username;
    
    /**
     * 手机号
     */
    private String phone;
    
    /**
     * 邮箱
     */
    private String email;
    
    /**
     * 地址
     */
    private String address;
    
    /**
     * 性别(0-女，1-男)
     */
    private Integer gender;
    
    /**
     * 用户角色(0-普通用户，1-管理员)
     */
    private Integer role;
    
    /**
     * 创建时间
     */
    private Date createTime;
    
    /**
     * 更新时间
     */
    private Date updateTime;
} 