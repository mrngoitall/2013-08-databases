-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'users'
-- 
-- ---

DROP TABLE IF EXISTS `users`;
		
CREATE TABLE `users` (
  `user_id` MEDIUMINT NULL AUTO_INCREMENT DEFAULT NULL,
  `user_name` VARCHAR(200) NULL DEFAULT NULL,
  `user_joined_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`)
);

-- ---
-- Table 'rooms'
-- 
-- ---

DROP TABLE IF EXISTS `rooms`;
		
CREATE TABLE `rooms` (
  `room_id` MEDIUMINT NULL AUTO_INCREMENT DEFAULT NULL,
  `room_name` VARCHAR(200) NULL DEFAULT NULL,
  `room_create_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`)
);

-- ---
-- Table 'messages'
-- 
-- ---

DROP TABLE IF EXISTS `messages`;
		
CREATE TABLE `messages` (
  `message_id` INT NULL AUTO_INCREMENT DEFAULT NULL,
  `user_id` MEDIUMINT NULL DEFAULT NULL,
  `room_id` MEDIUMINT NULL DEFAULT NULL,
  `message` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`message_id`)
);

-- ---
-- Table 'friends'
-- 
-- ---

DROP TABLE IF EXISTS `friends`;
		
CREATE TABLE `friends` (
  `friend_relation_id` INT NULL AUTO_INCREMENT DEFAULT NULL,
  `user_id` MEDIUMINT NULL DEFAULT NULL,
  `friend_id` MEDIUMINT NULL DEFAULT NULL,
  `friended_date` TIMESTAMP NULL DEFAULT NULL,
  `unfriended_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`friend_relation_id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `messages` ADD FOREIGN KEY (user_id) REFERENCES `users` (`user_id`);
ALTER TABLE `messages` ADD FOREIGN KEY (room_id) REFERENCES `rooms` (`room_id`);
ALTER TABLE `friends` ADD FOREIGN KEY (user_id) REFERENCES `users` (`user_id`);
ALTER TABLE `friends` ADD FOREIGN KEY (friend_id) REFERENCES `users` (`user_id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `users` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `rooms` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `messages` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `friends` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `users` (`user_id`,`user_name`,`user_joined_date`) VALUES
-- ('','','');
-- INSERT INTO `rooms` (`room_id`,`room_name`,`room_create_date`) VALUES
-- ('','','');
-- INSERT INTO `messages` (`message_id`,`user_id`,`room_id`,`message`) VALUES
-- ('','','','');
-- INSERT INTO `friends` (`friend_relation_id`,`user_id`,`friend_id`,`friended_date`,`unfriended_date`) VALUES
-- ('','','','','');

