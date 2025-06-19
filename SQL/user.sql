-- 用户表结构
-- 删除表如果已存在
DROP TABLE IF EXISTS `user`;

-- 创建用户表
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID，主键',
  `user_id` varchar(50) NOT NULL COMMENT '用户账号',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `username` varchar(100) NOT NULL COMMENT '用户名称',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别：0-女，1-男',
  `role` tinyint(1) DEFAULT '0' COMMENT '角色：0-普通用户，1-管理员',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：0-已删除，1-正常',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_id` (`user_id`),
  UNIQUE KEY `idx_email` (`email`),
  UNIQUE KEY `idx_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- 添加初始管理员用户
-- 密码为123456的明文
INSERT INTO `user` (`user_id`, `password`, `username`, `phone`, `email`, `role`) 
VALUES ('admin', '123456', '系统管理员', '13800138000', 'admin@example.com', 1);

-- 添加测试用户
INSERT INTO `user` (`user_id`, `password`, `username`, `phone`, `email`, `role`) 
VALUES ('user01', '123456', '测试用户', '13900139001', 'test@example.com', 0); 