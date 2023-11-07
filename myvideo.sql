/*
Navicat MySQL Data Transfer

Source Server         : 本机
Source Server Version : 80028
Source Host           : localhost:3306
Source Database       : myvideo

Target Server Type    : MYSQL
Target Server Version : 80028
File Encoding         : 65001

Date: 2023-11-07 23:45:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `avatar_url` varchar(512) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'zwx', '123456', 'abc@qq.com', 'http://s36irpgud.hn-bkt.clouddn.com/sxc.jpg', '2023-10-25 17:46:47', '2023-10-29 20:33:46');
INSERT INTO `user` VALUES ('2', 'lk', '123456', '123@qq.com', 'http://s36irpgud.hn-bkt.clouddn.com/sxc.jpg', '2023-10-27 12:03:02', '2023-10-29 20:33:47');

-- ----------------------------
-- Table structure for user_favorite
-- ----------------------------
DROP TABLE IF EXISTS `user_favorite`;
CREATE TABLE `user_favorite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `video_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `user_favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_favorite_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_favorite
-- ----------------------------
INSERT INTO `user_favorite` VALUES ('1', '1', '1', '2023-10-27 11:50:16');
INSERT INTO `user_favorite` VALUES ('4', '1', '2', '2023-10-27 15:53:28');
INSERT INTO `user_favorite` VALUES ('7', '1', '16', '2023-11-07 16:53:37');
INSERT INTO `user_favorite` VALUES ('8', '1', '18', '2023-11-07 16:56:09');
INSERT INTO `user_favorite` VALUES ('9', '1', '53', '2023-11-07 17:00:07');
INSERT INTO `user_favorite` VALUES ('10', '2', '55', '2023-11-07 21:27:47');
INSERT INTO `user_favorite` VALUES ('11', '2', '16', '2023-11-07 21:27:57');
INSERT INTO `user_favorite` VALUES ('12', '2', '19', '2023-11-07 21:28:00');
INSERT INTO `user_favorite` VALUES ('13', '2', '21', '2023-11-07 21:28:04');
INSERT INTO `user_favorite` VALUES ('14', '2', '24', '2023-11-07 22:37:56');
INSERT INTO `user_favorite` VALUES ('15', '1', '43', '2023-11-07 22:49:48');

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
DROP TABLE IF EXISTS `user_follow`;
CREATE TABLE `user_follow` (
  `id` int NOT NULL AUTO_INCREMENT,
  `follower_id` int DEFAULT NULL,
  `followed_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `follower_id` (`follower_id`),
  KEY `followed_id` (`followed_id`),
  CONSTRAINT `user_follow_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_follow_ibfk_2` FOREIGN KEY (`followed_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_follow
-- ----------------------------
INSERT INTO `user_follow` VALUES ('5', '1', '2', '2023-10-30 19:38:43');
INSERT INTO `user_follow` VALUES ('6', '2', '1', '2023-10-30 20:24:42');

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `video_url` varchar(512) NOT NULL,
  `thumbnail_url` varchar(512) DEFAULT NULL,
  `views` int DEFAULT '0',
  `likes` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `video_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `video_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `video_categorie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES ('1', '1', '4', 'cat.mp4', null, 'http://xiaohu.hanshubo.com/cat.mp4', 'http://xiaohu.hanshubo.com/cat.mp4?vframe/jpg/offset/0', '0', '1', '2023-10-26 18:04:35', '2023-11-07 21:07:53');
INSERT INTO `video` VALUES ('2', '2', '4', 'work.mp4', null, 'http://xiaohu.hanshubo.com/work.mp4', 'http://xiaohu.hanshubo.com/work.mp4?vframe/jpg/offset/0', '0', '0', '2023-10-27 12:04:10', '2023-11-07 21:07:44');
INSERT INTO `video` VALUES ('13', '1', '4', 'lin.mp4', '阿斯顿', '\r\nhttp://xiaohu.hanshubo.com/lin.mp4', '\r\nhttp://xiaohu.hanshubo.com/lin.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-06 12:24:48', '2023-11-07 11:41:35');
INSERT INTO `video` VALUES ('14', '1', '3', 'kobi.mp4', '劳大', '\r\nhttp://xiaohu.hanshubo.com/kobi.mp4', '\r\nhttp://xiaohu.hanshubo.com/kobi.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 01:14:52', '2023-11-07 11:41:57');
INSERT INTO `video` VALUES ('15', '1', '2', 'country.mp4', '爱国', 'http://xiaohu.hanshubo.com/country.mp4', 'http://xiaohu.hanshubo.com/country.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 01:18:50', '2023-11-07 11:39:50');
INSERT INTO `video` VALUES ('16', '2', '5', 'WeChat_20231107120336.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120336.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120336.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:51:24', '2023-11-07 12:51:24');
INSERT INTO `video` VALUES ('17', '2', '5', 'WeChat_20231107120351.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120351.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120351.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:52:16', '2023-11-07 12:52:16');
INSERT INTO `video` VALUES ('18', '2', '5', 'WeChat_20231107120355.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120355.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120355.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:52:36', '2023-11-07 12:52:36');
INSERT INTO `video` VALUES ('19', '2', '5', 'WeChat_20231107120403.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120403.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120403.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:52:50', '2023-11-07 12:52:50');
INSERT INTO `video` VALUES ('20', '2', '5', 'WeChat_20231107120405.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120405.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120405.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:53:01', '2023-11-07 12:53:01');
INSERT INTO `video` VALUES ('21', '2', '5', 'WeChat_20231107120408.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120408.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120408.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:53:13', '2023-11-07 12:53:13');
INSERT INTO `video` VALUES ('22', '2', '5', 'WeChat_20231107120411.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120411.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120411.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:53:20', '2023-11-07 12:53:20');
INSERT INTO `video` VALUES ('23', '2', '5', 'WeChat_20231107120351.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120351.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120351.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:54:31', '2023-11-07 12:54:31');
INSERT INTO `video` VALUES ('24', '2', '5', 'WeChat_20231107120419.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120419.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120419.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:54:46', '2023-11-07 12:54:46');
INSERT INTO `video` VALUES ('25', '2', '5', 'WeChat_20231107120422.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120422.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120422.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:54:54', '2023-11-07 12:54:54');
INSERT INTO `video` VALUES ('26', '2', '5', 'WeChat_20231107120417.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120417.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120417.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:55:21', '2023-11-07 12:55:21');
INSERT INTO `video` VALUES ('28', '2', '1', 'WeChat_20231107121133.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121133.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121133.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 12:58:17', '2023-11-07 12:58:17');
INSERT INTO `video` VALUES ('30', '2', '1', 'WeChat_20231107121147.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121147.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121147.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:05:48', '2023-11-07 13:05:48');
INSERT INTO `video` VALUES ('31', '2', '1', 'WeChat_20231107121151.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121151.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121151.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:05:58', '2023-11-07 13:05:58');
INSERT INTO `video` VALUES ('33', '2', '1', 'WeChat_20231107121200.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121200.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121200.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:06:14', '2023-11-07 13:06:14');
INSERT INTO `video` VALUES ('39', '2', '5', 'WeChat_20231107120414.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120414.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120414.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:07:30', '2023-11-07 13:07:30');
INSERT INTO `video` VALUES ('40', '2', '2', 'WeChat_20231107114920.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107114920.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107114920.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:08:43', '2023-11-07 13:08:43');
INSERT INTO `video` VALUES ('41', '2', '2', 'WeChat_20231107114931.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107114931.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107114931.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:08:50', '2023-11-07 13:08:50');
INSERT INTO `video` VALUES ('42', '2', '2', 'WeChat_20231107114946.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107114946.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107114946.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:09:02', '2023-11-07 13:09:02');
INSERT INTO `video` VALUES ('43', '2', '2', 'WeChat_20231107115014.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115014.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115014.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:09:11', '2023-11-07 13:09:11');
INSERT INTO `video` VALUES ('44', '1', '3', 'WeChat_20231107114905.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107114905.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107114905.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:21:31', '2023-11-07 16:05:12');
INSERT INTO `video` VALUES ('45', '1', '3', 'WeChat_20231107115032.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115032.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115032.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:22:12', '2023-11-07 16:05:10');
INSERT INTO `video` VALUES ('46', '1', '3', 'WeChat_20231107115110.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115110.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115110.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:22:37', '2023-11-07 16:05:09');
INSERT INTO `video` VALUES ('47', '1', '3', 'WeChat_20231107115100.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115100.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115100.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:22:46', '2023-11-07 16:05:09');
INSERT INTO `video` VALUES ('48', '1', '3', 'WeChat_20231107120536.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120536.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120536.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:22:54', '2023-11-07 16:05:09');
INSERT INTO `video` VALUES ('49', '1', '3', 'WeChat_20231107115052.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115052.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115052.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:23:19', '2023-11-07 16:05:08');
INSERT INTO `video` VALUES ('50', '1', '3', 'WeChat_20231107115658.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115658.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115658.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:23:36', '2023-11-07 16:05:07');
INSERT INTO `video` VALUES ('51', '1', '4', 'WeChat_20231107114905.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107114905.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107114905.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:23:54', '2023-11-07 16:05:07');
INSERT INTO `video` VALUES ('52', '1', '4', 'WeChat_20231107115738.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115738.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115738.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:24:08', '2023-11-07 13:24:08');
INSERT INTO `video` VALUES ('53', '1', '4', 'WeChat_20231107115718.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115718.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115718.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:24:23', '2023-11-07 13:24:23');
INSERT INTO `video` VALUES ('54', '1', '4', 'WeChat_20231107115714.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115714.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115714.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:25:24', '2023-11-07 13:25:24');
INSERT INTO `video` VALUES ('55', '1', '4', 'WeChat_20231107115721.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115721.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115721.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:25:36', '2023-11-07 13:25:36');
INSERT INTO `video` VALUES ('56', '1', '4', 'WeChat_20231107115728.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115728.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115728.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 13:25:46', '2023-11-07 13:25:46');
INSERT INTO `video` VALUES ('57', '1', '5', 'WeChat_20231107120411.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120411.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120411.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 15:47:43', '2023-11-07 15:47:43');
INSERT INTO `video` VALUES ('58', '1', '5', 'WeChat_20231107115620.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115620.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115620.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 15:48:21', '2023-11-07 15:48:21');
INSERT INTO `video` VALUES ('59', '1', '2', 'WeChat_20231107115606.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115606.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115606.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 15:48:38', '2023-11-07 15:48:38');
INSERT INTO `video` VALUES ('60', '1', '2', 'WeChat_20231107115617.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115617.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115617.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 15:48:57', '2023-11-07 15:48:57');
INSERT INTO `video` VALUES ('61', '1', '2', 'WeChat_20231107115624.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115624.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115624.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 18:35:52', '2023-11-07 18:35:52');
INSERT INTO `video` VALUES ('62', '1', '2', 'WeChat_20231107115627.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115627.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115627.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 18:37:18', '2023-11-07 18:37:18');
INSERT INTO `video` VALUES ('63', '1', '2', 'WeChat_20231107115014.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115014.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115014.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 18:37:49', '2023-11-07 18:37:49');
INSERT INTO `video` VALUES ('64', '1', '1', 'WeChat_20231107121217.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121217.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121217.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 18:39:16', '2023-11-07 18:39:16');
INSERT INTO `video` VALUES ('65', '1', '5', 'WeChat_20231107120408.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120408.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120408.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 18:41:06', '2023-11-07 18:41:06');
INSERT INTO `video` VALUES ('66', '1', '1', 'WeChat_20231107121125.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121125.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121125.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:53:31', '2023-11-07 20:53:31');
INSERT INTO `video` VALUES ('67', '1', '1', 'WeChat_20231107121140.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121140.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121140.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:54:13', '2023-11-07 20:54:13');
INSERT INTO `video` VALUES ('68', '1', '1', 'WeChat_20231107121144.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121144.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121144.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:54:26', '2023-11-07 20:54:26');
INSERT INTO `video` VALUES ('69', '1', '1', 'WeChat_20231107121154.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121154.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121154.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:54:50', '2023-11-07 20:54:50');
INSERT INTO `video` VALUES ('70', '1', '1', 'WeChat_20231107121157.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121157.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121157.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:55:00', '2023-11-07 20:55:00');
INSERT INTO `video` VALUES ('71', '1', '1', 'WeChat_20231107121203.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121203.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121203.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:55:23', '2023-11-07 20:55:23');
INSERT INTO `video` VALUES ('72', '1', '1', 'WeChat_20231107121208.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121208.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121208.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:55:38', '2023-11-07 20:55:38');
INSERT INTO `video` VALUES ('73', '1', '1', 'WeChat_20231107121231.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121231.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121231.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:55:50', '2023-11-07 20:55:50');
INSERT INTO `video` VALUES ('74', '1', '1', 'WeChat_20231107121208.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121208.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121208.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:56:09', '2023-11-07 20:56:09');
INSERT INTO `video` VALUES ('75', '2', '3', 'WeChat_20231107120517.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107120517.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120517.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:57:14', '2023-11-07 20:59:27');
INSERT INTO `video` VALUES ('77', '2', '3', 'WeChat_20231107115110.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115110.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115110.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 20:57:44', '2023-11-07 20:59:31');
INSERT INTO `video` VALUES ('78', '2', '4', 'fish.mp4', '', 'http://xiaohu.hanshubo.com/fish.mp4', 'http://xiaohu.hanshubo.com/fish.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 21:00:45', '2023-11-07 21:00:45');
INSERT INTO `video` VALUES ('79', '2', '4', 'funny.mp4', '', 'http://xiaohu.hanshubo.com/funny.mp4', 'http://xiaohu.hanshubo.com/funny.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 21:01:15', '2023-11-07 21:01:15');
INSERT INTO `video` VALUES ('80', '2', '4', 'WeChat_20231107115735.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115735.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115735.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 21:01:48', '2023-11-07 21:01:48');
INSERT INTO `video` VALUES ('81', '1', '1', 'WeChat_20231107121208.mp4', '生活', 'http://xiaohu.hanshubo.com/WeChat_20231107121208.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121208.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 22:35:42', '2023-11-07 22:35:42');
INSERT INTO `video` VALUES ('82', '2', '5', 'WeChat_20231107120425.mp4', '风景视频', 'http://xiaohu.hanshubo.com/WeChat_20231107120425.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107120425.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 22:37:15', '2023-11-07 22:37:15');
INSERT INTO `video` VALUES ('83', '1', '1', 'WeChat_20231107121231.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107121231.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107121231.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 22:46:12', '2023-11-07 22:47:54');
INSERT INTO `video` VALUES ('84', '1', '4', 'WeChat_20231107115718.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115718.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115718.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 22:47:31', '2023-11-07 22:47:57');
INSERT INTO `video` VALUES ('85', null, '2', 'WeChat_20231107115627.mp4', '', 'http://xiaohu.hanshubo.com/WeChat_20231107115627.mp4', 'http://xiaohu.hanshubo.com/WeChat_20231107115627.mp4?vframe/jpg/offset/0', '0', '0', '2023-11-07 22:49:18', '2023-11-07 22:49:18');

-- ----------------------------
-- Table structure for video_categorie
-- ----------------------------
DROP TABLE IF EXISTS `video_categorie`;
CREATE TABLE `video_categorie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of video_categorie
-- ----------------------------
INSERT INTO `video_categorie` VALUES ('1', '运动', '2023-10-26 18:04:32', '2023-10-30 18:10:55');
INSERT INTO `video_categorie` VALUES ('2', '情感', '2023-10-30 18:10:59', '2023-10-30 18:10:59');
INSERT INTO `video_categorie` VALUES ('3', '娱乐', '2023-10-30 18:11:06', '2023-10-30 18:11:06');
INSERT INTO `video_categorie` VALUES ('4', '搞笑', '2023-10-30 18:11:13', '2023-10-30 18:11:13');
INSERT INTO `video_categorie` VALUES ('5', '风景', '2023-10-30 18:11:17', '2023-10-30 18:11:17');
