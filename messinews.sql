/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 100427
 Source Host           : localhost:3306
 Source Schema         : messinews

 Target Server Type    : MySQL
 Target Server Version : 100427
 File Encoding         : 65001

 Date: 23/12/2022 17:00:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article_has_tag
-- ----------------------------
DROP TABLE IF EXISTS `article_has_tag`;
CREATE TABLE `article_has_tag`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag_id` int NULL DEFAULT NULL,
  `article_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tag_id`(`tag_id` ASC) USING BTREE,
  INDEX `article_id`(`article_id` ASC) USING BTREE,
  CONSTRAINT `article_has_tag_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `article_has_tag_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publish_date` datetime NULL DEFAULT NULL,
  `views` int NULL DEFAULT NULL,
  `abstract_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `categories_id` int NULL DEFAULT NULL,
  `premium` tinyint NULL DEFAULT NULL COMMENT '0: no; 1-yes',
  `writer_id` int NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL COMMENT '0 - deny; 1 - allow; -1 - draft',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `categories_id`(`categories_id` ASC) USING BTREE,
  INDEX `writer_id`(`writer_id` ASC) USING BTREE,
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `articles_ibfk_2` FOREIGN KEY (`writer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_cate_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parent_cate_id`(`parent_cate_id` ASC) USING BTREE,
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_cate_id`) REFERENCES `parent_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `article_id` int NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `article_id`(`article_id` ASC) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for editor_manage_categories
-- ----------------------------
DROP TABLE IF EXISTS `editor_manage_categories`;
CREATE TABLE `editor_manage_categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `editor_id` int NULL DEFAULT NULL,
  `category_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `editor_id`(`editor_id` ASC) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `editor_manage_categories_ibfk_1` FOREIGN KEY (`editor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `editor_manage_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for parent_categories
-- ----------------------------
DROP TABLE IF EXISTS `parent_categories`;
CREATE TABLE `parent_categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_parent_cate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_tags` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `issue_at` datetime NOT NULL,
  `expiration` int NULL DEFAULT NULL,
  `role` int NOT NULL COMMENT '1 - subscriber; 2 - writer; 3 - editor; 4 - admin',
  `dob` date NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `otp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `otp_exp` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
