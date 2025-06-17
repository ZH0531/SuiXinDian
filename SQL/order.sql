-- 订单表结构
-- 删除表如果已存在
DROP TABLE IF EXISTS `order`;

-- 创建订单表
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单ID，主键',
  `order_no` varchar(32) NOT NULL COMMENT '订单号',
  `user_id` int NOT NULL COMMENT '用户ID',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总金额',
  `remark` varchar(500) DEFAULT NULL COMMENT '订单备注',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '订单状态：0-未支付 1-已完成 2-已取消',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单信息表';

-- 添加测试数据
-- 注意：执行此SQL前需确保user表中有对应的用户ID
INSERT INTO `order` (`order_no`, `user_id`, `total_amount`, `status`, `create_time`) 
VALUES ('ORD2023080100001', 2, 94.00, 1, '2023-08-01 12:30:00');

INSERT INTO `order` (`order_no`, `user_id`, `total_amount`, `status`, `remark`, `create_time`) 
VALUES ('ORD2023080200001', 2, 88.00, 1, '不要辣', '2023-08-02 18:45:00');

INSERT INTO `order` (`order_no`, `user_id`, `total_amount`, `status`, `create_time`) 
VALUES ('ORD2023080300001', 2, 58.00, 2, '2023-08-03 20:15:00'); 