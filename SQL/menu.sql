-- 菜单表结构
-- 删除表如果已存在
DROP TABLE IF EXISTS `menu`;

-- 创建菜单表
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '菜品ID，主键',
  `menu_no` varchar(20) NOT NULL COMMENT '菜品编号',
  `name` varchar(100) NOT NULL COMMENT '菜品名称',
  `price` decimal(10,2) NOT NULL COMMENT '菜品价格',
  `image_url` varchar(500) DEFAULT NULL COMMENT '菜品图片URL',
  `description` text COMMENT '菜品描述',
  `tags` varchar(200) DEFAULT NULL COMMENT '菜品标签，多个标签用逗号分隔',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_menu_no` (`menu_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜品信息表';

-- 添加测试数据
INSERT INTO `menu` (`menu_no`, `name`, `price`, `image_url`, `description`, `tags`) 
VALUES ('M001', '宫保鸡丁', 38.00, '/static/images/menu/gongbao.jpg', '选用优质鸡胸肉，配以花生、干辣椒等食材，酸辣可口', '热菜,辣,招牌');

INSERT INTO `menu` (`menu_no`, `name`, `price`, `image_url`, `description`, `tags`) 
VALUES ('M002', '水煮鱼', 58.00, '/static/images/menu/shuizhuyu.jpg', '新鲜草鱼片，配以豆芽、白菜等蔬菜，麻辣鲜香', '热菜,辣,招牌');

INSERT INTO `menu` (`menu_no`, `name`, `price`, `image_url`, `description`, `tags`) 
VALUES ('M003', '清蒸大虾', 88.00, '/static/images/menu/qingzhengdaxia.jpg', '选用新鲜基围虾，清蒸保留原汁原味', '海鲜,清淡');

INSERT INTO `menu` (`menu_no`, `name`, `price`, `image_url`, `description`, `tags`) 
VALUES ('M004', '蛋炒饭', 18.00, '/static/images/menu/danchaofan.jpg', '精选大米，配以鸡蛋、火腿等食材，香气扑鼻', '主食,招牌');

INSERT INTO `menu` (`menu_no`, `name`, `price`, `image_url`, `description`, `tags`) 
VALUES ('M005', '酸辣汤', 15.00, '/static/images/menu/suanlatang.jpg', '酸辣可口，开胃解腻', '汤,辣,酸'); 