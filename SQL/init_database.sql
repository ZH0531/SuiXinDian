-- 初始化数据库
-- 创建数据库
CREATE DATABASE IF NOT EXISTS restaurant DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 使用数据库
USE restaurant;

-- 包含各表的创建和初始数据
-- 注意：执行顺序很重要，因为表之间有外键约束关系

-- 用户表
SOURCE user.sql;

-- 菜单表
SOURCE menu.sql;

-- 订单表
SOURCE order.sql;

-- 订单详情表
SOURCE order_detail.sql;

-- 数据库初始化完成
SELECT 'Database initialization completed successfully.' AS 'Status'; 