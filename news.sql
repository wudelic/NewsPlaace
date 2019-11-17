/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : news

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 16/11/2019 19:57:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `username` varchar(10) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '管理员账号',
  `password` varchar(10) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '管理员密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, '1', '1');

-- ----------------------------
-- Table structure for editor
-- ----------------------------
DROP TABLE IF EXISTS `editor`;
CREATE TABLE `editor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主编id',
  `password` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL DEFAULT '' COMMENT '密码',
  `name` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '姓名',
  `age` date DEFAULT NULL COMMENT '年龄',
  `gender` varchar(30) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '性别',
  `idNumber` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL DEFAULT '' COMMENT '证件号',
  `address` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL COMMENT '地址',
  `phoneNum` varchar(15) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '电话',
  `email` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL COMMENT '邮箱',
  `detail` varchar(255) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL COMMENT '主编介绍',
  `create_time` timestamp(0) DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of editor
-- ----------------------------
INSERT INTO `editor` VALUES (1, '1', '1', '2019-10-01', '男', '1', '', '1', '123@qq.com', '1', '2019-10-26 22:31:09');
INSERT INTO `editor` VALUES (2, '1', '1', '2019-10-01', '男', '1', '', '1', '123@qq.com', '1', '2019-10-26 22:32:43');
INSERT INTO `editor` VALUES (3, '2', '1', '2019-10-01', '男', '1', '', '1', '123@qq.com', '1', '2019-10-26 22:33:19');
INSERT INTO `editor` VALUES (4, '2', '3', '2019-09-30', '男', '2', '', '2', '123@qq.com', '2', '2019-10-26 22:35:16');
INSERT INTO `editor` VALUES (5, '4', '3', '2019-09-30', '男', '2', '', '2', '123@qq.com', '2', '2019-10-26 22:35:25');
INSERT INTO `editor` VALUES (6, '4', '4', '2019-10-10', '女', '441581199903031019', '', '13456232131', '123@qq.com', '1', '2019-10-26 22:38:27');
INSERT INTO `editor` VALUES (7, '3', '1', '0012-10-16', '女', '1231', '湖北武汉江岸区', '1', '123@QQ.COM', '321', '2019-10-26 22:43:59');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '新闻id',
  `topic` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '新闻主题',
  `reporterId` int(4) NOT NULL COMMENT '记者',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间//xiugai',
  `content` text CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '内容',
  `status` tinyint(10) NOT NULL DEFAULT 0 COMMENT '是否经过审核 0为未审核 1为发布',
  `click` int(6) NOT NULL DEFAULT 0 COMMENT '点击量',
  `tabId` tinyint(4) NOT NULL COMMENT '发布模块',
  `editorId` int(4) DEFAULT NULL COMMENT '主编名',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `reportorId`(`reporterId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (4, 'sss', 1, '2019-11-14 21:49:29', '12312312', 0, 0, 2, NULL);
INSERT INTO `news` VALUES (5, '123', 53, '2019-11-15 12:28:17', '<p>请输入新闻内容</p><p>123<br></p>', 1, 0, 1, 5);
INSERT INTO `news` VALUES (6, 'test2', 53, '2019-11-15 14:03:23', '<p>请输入新闻内容</p><p>qwe<br></p>', 0, 0, 1, NULL);
INSERT INTO `news` VALUES (7, 'test3', 53, '2019-11-15 14:03:41', '<p>请输入新闻内容</p><p><img src=\"http://localhost:8080/upload/201911151403381vxu3.jpg\" style=\"max-width:100%;\"></p>', 1, 1, 1, 3);
INSERT INTO `news` VALUES (8, 'test3', 53, '2019-11-15 20:43:27', '<p>请输入新闻内容</p><p>asd</p>', 0, 0, 1, NULL);
INSERT INTO `news` VALUES (9, 'test4', 53, '2019-11-15 20:43:46', '<p><img src=\"http://localhost:8080/upload/20191115204337kp3hj.jpg\" style=\"max-width: 100%;\"><br></p>', 0, 0, 1, NULL);
INSERT INTO `news` VALUES (10, '珂珂珂珂学', 53, '2019-11-16 11:28:08', '<p>请<span style=\"font-style: italic;\">输入新闻内容</span></p><p><span style=\"font-style: italic;\">请问</span></p>', 1, 1, 2, 2);
INSERT INTO `news` VALUES (11, '体体体与', 53, '2019-11-16 11:28:36', '<p>请输入新闻内容</p><p><br></p>', 1, 19, 3, 1);
INSERT INTO `news` VALUES (12, '去提', 53, '2019-11-16 11:28:50', '<p>请输入新闻内容</p><p><br></p>', 1, 27, 4, 6);

-- ----------------------------
-- Table structure for reporter
-- ----------------------------
DROP TABLE IF EXISTS `reporter`;
CREATE TABLE `reporter`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记者id',
  `password` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '密码',
  `name` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '名字',
  `age` date DEFAULT NULL COMMENT '年龄',
  `gender` varchar(30) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '性别',
  `idNumber` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '证件号',
  `address` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL COMMENT '地址',
  `phoneNum` varchar(15) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '电话',
  `email` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL COMMENT '邮箱',
  `detail` varchar(255) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL COMMENT '介绍',
  `create_time` timestamp(0) DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reporter
-- ----------------------------
INSERT INTO `reporter` VALUES (1, '123123', 'smo', '2019-11-12', '女', '321323123213123', '中国', '12312312', '213@qq。com', '123', '2019-11-16 16:27:26');
INSERT INTO `reporter` VALUES (53, '4297F44B13955235245B2497399D7A93', 'ww', '2019-11-14', '男', '441827776676671281', '广东中山中山市', '13265784611', '123@qq.com', '1231231', '2019-11-11 00:50:40');

-- ----------------------------
-- Table structure for tab
-- ----------------------------
DROP TABLE IF EXISTS `tab`;
CREATE TABLE `tab`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '板块id',
  `tabName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '板块名字',
  `tabNameEn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '板块名字英文',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tab
-- ----------------------------
INSERT INTO `tab` VALUES (1, '娱乐', 'play');
INSERT INTO `tab` VALUES (2, '科学', 'science');
INSERT INTO `tab` VALUES (3, '体育', 'sport');
INSERT INTO `tab` VALUES (4, '其他', 'other');

-- ----------------------------
-- View structure for n_o
-- ----------------------------
DROP VIEW IF EXISTS `n_o`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `n_o` AS select `news`.`topic` AS `topic`,`news`.`reportorId` AS `nRepId`,`news`.`create_time` AS `Ncreate_time`,`news`.`detail` AS `Ndetail`,`news`.`picture` AS `picture`,`news`.`status` AS `status`,`reporter`.`password` AS `Rpassword`,`reporter`.`name` AS `Rname`,`reporter`.`age` AS `Rage`,`reporter`.`gender` AS `Rgender`,`reporter`.`idNumber` AS `RidNumber`,`reporter`.`address` AS `Raddress`,`reporter`.`phoneNum` AS `RphoneNum`,`picture`.`newsId` AS `newsId`,`picture`.`reportorId` AS `pRepId`,`picture`.`pictureUrl` AS `pictureUrl`,`picture`.`id` AS `Pid`,`reporter`.`id` AS `Rid`,`reporter`.`email` AS `Remail`,`reporter`.`detail` AS `Rdetail`,`reporter`.`create_time` AS `Rcreate_time`,`news`.`id` AS `Nid`,`editor`.`id` AS `Eid`,`editor`.`password` AS `Epassword`,`editor`.`name` AS `Ename`,`editor`.`age` AS `Eage`,`editor`.`gender` AS `Egender`,`editor`.`idNumber` AS `EidNumber`,`editor`.`address` AS `Eaddress`,`editor`.`phoneNum` AS `EphoneNum`,`editor`.`email` AS `Eemail`,`editor`.`detail` AS `Edetail`,`editor`.`create_time` AS `Ecreate_time` from ((`admin` join `editor`) join ((`news` join `picture` on((`picture`.`newsId` = `news`.`id`))) join `reporter` on(((`news`.`reportorId` = `reporter`.`id`) and (`picture`.`reportorId` = `reporter`.`id`)))));

SET FOREIGN_KEY_CHECKS = 1;
