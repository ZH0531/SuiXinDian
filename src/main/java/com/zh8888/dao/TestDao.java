package com.zh8888.dao;

import java.time.LocalDateTime;

/**
 * 测试用DAO接口
 */
public interface TestDao {
    /**
     * 测试数据库连接
     * @return 当前时间
     */
    String getCurrentTime();
} 