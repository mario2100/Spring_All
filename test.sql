/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 06/09/2021 10:34:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `SNO` varchar(3) NOT NULL,
  `SNAME` varchar(10) NOT NULL,
  `SSEX` char(2) NOT NULL,
  `DATASOURCE` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
BEGIN;
INSERT INTO `student` VALUES ('001', 'KangKang', 'M', 'mysql');
INSERT INTO `student` VALUES ('002', 'Mike', 'M', 'mysql');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
