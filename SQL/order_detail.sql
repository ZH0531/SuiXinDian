-- 订单详情表结构
-- 删除表如果已存在
DROP TABLE IF EXISTS `order_detail`;

-- 创建订单详情表
CREATE TABLE `order_detail` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单详情ID，主键',
  `order_id` int NOT NULL COMMENT '订单ID',
  `menu_id` int NOT NULL COMMENT '菜品ID',
  `menu_no` varchar(20) NOT NULL COMMENT '菜品编号',
  `menu_name` varchar(100) NOT NULL COMMENT '菜品名称',
  `menu_image` varchar(500) DEFAULT NULL COMMENT '菜品图片URL',
  `price` decimal(10,2) NOT NULL COMMENT '菜品单价',
  `quantity` int NOT NULL COMMENT '购买数量',
  `total_price` decimal(10,2) NOT NULL COMMENT '小计金额',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_menu_id` (`menu_id`),
  CONSTRAINT `fk_order_detail_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单详情表';

-- 添加测试数据
-- 注意：执行此SQL前需确保order表和menu表中有对应的ID
-- 订单1的详情
INSERT INTO `order_detail` (`order_id`, `menu_id`, `menu_no`, `menu_name`, `menu_image`, `price`, `quantity`, `total_price`) 
VALUES (1, 1, 'M001', '宫保鸡丁', '/static/images/menu/gongbao.jpg', 38.00, 2, 76.00);

INSERT INTO `order_detail` (`order_id`, `menu_id`, `menu_no`, `menu_name`, `menu_image`, `price`, `quantity`, `total_price`) 
VALUES (1, 5, 'M005', '酸辣汤', '/static/images/menu/suanlatang.jpg', 15.00, 1, 15.00);

-- 订单2的详情
INSERT INTO `order_detail` (`order_id`, `menu_id`, `menu_no`, `menu_name`, `menu_image`, `price`, `quantity`, `total_price`) 
VALUES (2, 3, 'M003', '清蒸大虾', '/static/images/menu/qingzhengdaxia.jpg', 88.00, 1, 88.00);

-- 订单3的详情
INSERT INTO `order_detail` (`order_id`, `menu_id`, `menu_no`, `menu_name`, `menu_image`, `price`, `quantity`, `total_price`) 
VALUES (3, 2, 'M002', '水煮鱼', '/static/images/menu/shuizhuyu.jpg', 58.00, 1, 58.00); 