-- 为现有用户表添加status字段的更新脚本
-- 如果字段不存在则添加
ALTER TABLE `user` 
ADD COLUMN `status` tinyint(1) DEFAULT '1' COMMENT '状态：0-已删除，1-正常' AFTER `role`;

-- 更新所有现有用户的状态为正常
UPDATE `user` SET `status` = 1 WHERE `status` IS NULL; 