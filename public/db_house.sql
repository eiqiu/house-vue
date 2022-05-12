/*
 Navicat MySQL Data Transfer

 Source Server         : eiqiu
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : db_house

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 12/05/2022 16:27:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (2, '学区房');
INSERT INTO `category` VALUES (3, '医院房');
INSERT INTO `category` VALUES (4, '老年房');
INSERT INTO `category` VALUES (5, '急售房');
INSERT INTO `category` VALUES (7, '郊区房');
INSERT INTO `category` VALUES (8, '市区房');
INSERT INTO `category` VALUES (9, '市中心房');

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection`  (
  `collection_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `house_id` int NULL DEFAULT NULL,
  `collection_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`collection_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `house_id`(`house_id`) USING BTREE,
  CONSTRAINT `house_id` FOREIGN KEY (`house_id`) REFERENCES `house` (`house_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection
-- ----------------------------

-- ----------------------------
-- Table structure for house
-- ----------------------------
DROP TABLE IF EXISTS `house`;
CREATE TABLE `house`  (
  `house_id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int NULL DEFAULT NULL,
  `category_id` int NULL DEFAULT NULL,
  `house_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房屋主页的标题',
  `house_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房屋地址',
  `house_price` float NOT NULL COMMENT '房屋价格',
  `bargain` tinyint NULL DEFAULT NULL COMMENT '是否可议价',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `house_area` float NULL DEFAULT NULL COMMENT '房屋面积',
  `house_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房屋户型（2室2厅1厨1卫）',
  `house_structure` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户型结构',
  `building_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '建筑类型（板楼）',
  `building_structure` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '建筑结构（砖混结构）',
  `house_towards` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房屋朝向（南北）',
  `house_decoration` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '装修情况（简装）',
  `house_ladder` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '梯户比例（一梯三户）',
  `heating_mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供暖方式',
  `elevator` tinyint NULL DEFAULT NULL COMMENT '是否配备电梯',
  `viewing_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '看房时间',
  `transportation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交通出行',
  `surrounding_facilities` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '周边设施（医院、商场）',
  `house_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房屋描述，核心卖点',
  `house_state` tinyint NULL DEFAULT NULL COMMENT '房屋出售状态',
  `hot` tinyint NULL DEFAULT NULL COMMENT '是否是热门',
  PRIMARY KEY (`house_id`) USING BTREE,
  INDEX `category`(`category_id`) USING BTREE,
  INDEX `owner`(`owner_id`) USING BTREE,
  CONSTRAINT `category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `owner` FOREIGN KEY (`owner_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house
-- ----------------------------
INSERT INTO `house` VALUES (1, 1, 2, '学区房出租1', '山东省,烟台市,莱山区,新世界', 135.2, 0, '2022-04-25 19:39:30', 150.9, '5室3厅1厨2卫1其他', '板房', '板楼', '砖混结构', '南北', '精装', '一梯两户', '集体供暖', 1, '白天9:00到下午6:00', '周围交通很好', '有医院、学校、商场', '绝对号', 0, 1);
INSERT INTO `house` VALUES (2, 2, 2, '学区房出租2', '山东省,烟台市,莱山区,新世界', 65.9, 0, '2022-04-06 19:39:30', 200, '5室3厅1厨2卫1其他', '板房', '板楼', '砖混结构', '南北', '精装', '一梯两户', '精装', 1, '白天9:00到下午6:00', '周围交通很好', '有医院、学校、商场', '绝对号', 0, 0);
INSERT INTO `house` VALUES (3, 4, 3, '医院房出租1', '山东省,烟台市,莱山区,新世界', 99.5, 1, '2022-05-04 08:43:29', 160, '5室3厅1厨2卫1其他', '板房', '板楼', '钢混结构', '南北', '精装', '一梯两户', '简装', 1, '全天', '方便啊', '绝对顺利', '非常好', 0, 1);
INSERT INTO `house` VALUES (4, 5, 4, '老年房出租', '山东省,烟台市,莱山区,新世界', 99.5, 1, '2022-05-04 08:43:29', 160, '5室3厅1厨2卫1其他', '板房', '板楼', '钢混结构', '南北', '精装', '一梯两户', '简装', 1, '全天', '方便啊', '绝对顺利', '非常好', 0, 0);
INSERT INTO `house` VALUES (5, 6, 2, '学区房出租3', '山东省,烟台市,莱山区,新世界', 65.9, 0, '2022-04-06 19:39:30', 200, '5室3厅1厨2卫1其他', '板房', '板楼', '砖混结构', '南北', '精装', '一梯两户', '精装', 1, '白天9:00到下午6:00', '周围交通很好', '有医院、学校、商场', '绝对号', 0, 1);
INSERT INTO `house` VALUES (6, 7, 2, '学区房出租4', '山东省,烟台市,莱山区,新世界', 65.9, 0, '2022-04-06 19:39:30', 200, '5室3厅1厨2卫1其他', '板房', '板楼', '砖混结构', '南北', '精装', '一梯两户', '精装', 1, '白天9:00到下午6:00', '周围交通很好', '有医院、学校、商场', '绝对号', 0, 0);
INSERT INTO `house` VALUES (7, 8, 2, '学区房出租5', '山东省,烟台市,莱山区,新世界', 65.9, 0, '2022-04-06 19:39:30', 200, '5室3厅1厨2卫1其他', '板房', '板楼', '砖混结构', '南北', '精装', '一梯两户', '精装', 1, '白天9:00到下午6:00', '周围交通很好', '有医院、学校、商场', '绝对号', 0, 0);
INSERT INTO `house` VALUES (8, 9, 2, '学区房出租6', '山东省,烟台市,莱山区,新世界', 65.9, 0, '2022-04-06 19:39:30', 200, '5室3厅1厨2卫1其他', '板房', '板楼', '砖混结构', '南北', '精装', '一梯两户', '精装', 1, '白天9:00到下午6:00', '周围交通很好', '有医院、学校、商场', '绝对号', 0, 1);
INSERT INTO `house` VALUES (9, 10, 2, '学区房出租7', '山东省,烟台市,莱山区,新世界', 65.9, 0, '2022-04-06 19:39:30', 200, '5室3厅1厨2卫1其他', '板房', '板楼', '砖混结构', '南北', '很好', '一梯两户', '精装', 1, '白天9:00到下午6:00', '周围交通很好', '有医院、学校、商场', '绝对号', 0, 0);
INSERT INTO `house` VALUES (10, 11, 2, '学区房出租8', '山东省,烟台市,莱山区,新世界', 65.9, 0, '2022-04-06 19:39:30', 200, '5室3厅1厨2卫1其他', '板房', '板楼', '砖混结构', '南北', '很好', '一梯两户', '精装', 1, '白天9:00到下午6:00', '周围交通很好', '有医院、学校、商场', '绝对号', 0, 0);
INSERT INTO `house` VALUES (11, 12, 2, '学区房出租9', '山东省,烟台市,莱山区,新世界', 65.9, 0, '2022-04-06 19:39:30', 200, '5室3厅1厨2卫1其他', '板房', '板楼', '砖混结构', '南北', '很好', '一梯两户', '精装', 1, '白天9:00到下午6:00', '周围交通很好', '有医院、学校、商场', '绝对号', 0, 0);
INSERT INTO `house` VALUES (12, 13, 3, '医院房出租2', '山东省,烟台市,莱山区,新世界', 99.5, 1, '2022-05-04 08:43:29', 160, '5室3厅1厨2卫1其他', '板房', '板楼', '钢混结构', '南北', '666', '一梯两户', '简装', 1, '全天', '方便啊', '绝对顺利', '非常好', 0, 1);
INSERT INTO `house` VALUES (13, 14, 3, '医院房出租3', '山东省,烟台市,莱山区,新世界', 99.5, 1, '2022-05-04 08:43:29', 160, '5室3厅1厨2卫1其他', '板房', '板楼', '钢混结构', '南北', '666', '一梯两户', '简装', 1, '全天', '方便啊', '绝对顺利', '非常好', 0, 1);
INSERT INTO `house` VALUES (14, 15, 3, '医院房出租4', '山东省,烟台市,莱山区,新世界', 99.5, 1, '2022-05-04 08:43:29', 160, '5室3厅1厨2卫1其他', '板房', '板楼', '钢混结构', '南北', '666', '一梯两户', '简装', 1, '全天', '方便啊', '绝对顺利', '非常好', 0, 1);
INSERT INTO `house` VALUES (15, 16, 3, '医院房出租5', '山东省,烟台市,莱山区,新世界', 99.5, 1, '2022-05-04 08:43:29', 160, '5室3厅1厨2卫1其他', '板房', '板楼', '钢混结构', '南北', '666', '一梯两户', '简装', 1, '全天', '方便啊', '绝对顺利', '非常好', 0, 0);
INSERT INTO `house` VALUES (16, 1, 8, '河北房子', '河北省,秦皇岛市,北戴河区,北戴河区1', 135, 1, '2022-05-12 07:51:46', 1, '2室1厅1厨2卫0其他', '板房', '板楼', '钢混结构', '1', '精修', '1', '1', 1, '1', '方案斌', '上传', '1', 0, 0);
INSERT INTO `house` VALUES (18, 1, 8, '酷酷的房子', '天津市,河东区1', 158, 1, '2022-05-10 13:40:06', 1, '5室3厅1厨2卫1其他', '板房', '板楼', '钢混结构', '1', '1', '1', '1', 1, '1', '1', '1', '1', 0, 0);
INSERT INTO `house` VALUES (19, 1, 8, '美丽房子', '天津市,河东区11', 198, 1, '2022-05-10 13:41:09', 1, '0室1厅0厨1卫1其他', '板房', '板楼', '钢混结构', '1', '1', '1', '1', 1, '1', '1', '1', '1', 0, 0);
INSERT INTO `house` VALUES (21, 1, 3, '居家房子', '河北省,石家庄市,长安区22', 200, 1, '2022-05-11 08:16:12', 2, '2室2厅1厨1卫0其他', '板房', '板楼', '钢混结构', '2', '2', '2', '2', 1, '2', '2', '2', '22', 0, 0);
INSERT INTO `house` VALUES (22, 1, 7, '测试1', '河北省,邯郸市,邯山区,大街道社区', 165, 1, '2022-05-12 07:01:50', 135, '2室1厅1厨1卫1其他', '板房', '板房', '板楼', '南北', '精修', '一梯三户', '集体供暖', 1, '全天', '1111111', '2222222', '666', 0, 0);

-- ----------------------------
-- Table structure for house_picture
-- ----------------------------
DROP TABLE IF EXISTS `house_picture`;
CREATE TABLE `house_picture`  (
  `picture_id` int NOT NULL AUTO_INCREMENT,
  `house_id` int NULL DEFAULT NULL,
  `src` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  PRIMARY KEY (`picture_id`) USING BTREE,
  INDEX `picture`(`house_id`) USING BTREE,
  CONSTRAINT `picture` FOREIGN KEY (`house_id`) REFERENCES `house` (`house_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of house_picture
-- ----------------------------
INSERT INTO `house_picture` VALUES (2, 1, '01.jpg');
INSERT INTO `house_picture` VALUES (3, 1, '02.jpg');
INSERT INTO `house_picture` VALUES (4, 1, '03.jpg');
INSERT INTO `house_picture` VALUES (5, 2, '01.jpg');
INSERT INTO `house_picture` VALUES (6, 2, '01.jpg');
INSERT INTO `house_picture` VALUES (7, 2, '01.jpg');
INSERT INTO `house_picture` VALUES (8, 3, '01.jpg');
INSERT INTO `house_picture` VALUES (9, 4, '01.jpg');
INSERT INTO `house_picture` VALUES (10, 5, '01.jpg');
INSERT INTO `house_picture` VALUES (11, 6, '01.jpg');
INSERT INTO `house_picture` VALUES (12, 7, '01.jpg');
INSERT INTO `house_picture` VALUES (13, 8, '01.jpg');
INSERT INTO `house_picture` VALUES (14, 9, '01.jpg');
INSERT INTO `house_picture` VALUES (15, 10, '01.jpg');
INSERT INTO `house_picture` VALUES (16, 11, '01.jpg');
INSERT INTO `house_picture` VALUES (17, 12, '01.jpg');
INSERT INTO `house_picture` VALUES (18, 13, '01.jpg');
INSERT INTO `house_picture` VALUES (19, 14, '01.jpg');
INSERT INTO `house_picture` VALUES (20, 1, '01.jpg');
INSERT INTO `house_picture` VALUES (21, 21, '01.jpg');
INSERT INTO `house_picture` VALUES (22, 21, '02.jpg');
INSERT INTO `house_picture` VALUES (23, 21, '03.jpg');
INSERT INTO `house_picture` VALUES (24, 15, '03.jpg');
INSERT INTO `house_picture` VALUES (27, 18, '03.jpg');
INSERT INTO `house_picture` VALUES (28, 19, '03.jpg');
INSERT INTO `house_picture` VALUES (29, 22, '51.jpg');
INSERT INTO `house_picture` VALUES (30, 22, '44.jpg');
INSERT INTO `house_picture` VALUES (31, 22, '56.jpg');
INSERT INTO `house_picture` VALUES (32, 22, '14.jpg');
INSERT INTO `house_picture` VALUES (33, 16, '52.jpg');
INSERT INTO `house_picture` VALUES (34, 16, '53.jpg');

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`  (
  `item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `img_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片地址',
  `title` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `price` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '价格',
  `item_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类别',
  `quantity` bigint NOT NULL COMMENT '数量',
  PRIMARY KEY (`item_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of item
-- ----------------------------

-- ----------------------------
-- Table structure for item_sku
-- ----------------------------
DROP TABLE IF EXISTS `item_sku`;
CREATE TABLE `item_sku`  (
  `sku_id` bigint NOT NULL AUTO_INCREMENT COMMENT '规格ID',
  `item_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品ID',
  `sku_price` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'SKU价格',
  `sku_unique_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规格唯一标识',
  `quantity` bigint NOT NULL COMMENT '数量',
  PRIMARY KEY (`sku_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品SKU' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of item_sku
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `user_tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户电话',
  `user_sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `user_age` int NULL DEFAULT NULL COMMENT '年龄',
  `user_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `user_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '15666699669', '李大爷', '17688888888', '男', 65, '山东省,烟台市,莱山区,山东工商学院', '1');
INSERT INTO `user` VALUES (2, '17658085889', '张大爷', '10086', '男', 48, '北京市', '1');
INSERT INTO `user` VALUES (4, '15066699889', '用户15066', NULL, NULL, NULL, NULL, 'a12345');
INSERT INTO `user` VALUES (5, '15066699878', '王大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (6, '15066699899', '刘大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (7, '16978495956', '楚大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (8, '15066489489', '谢大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (9, '16524568944', '宋大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (10, '15579845478', '孔大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (11, '15068797545', '孟大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (12, '15879754545', '朱大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (13, '15989564575', '吴大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (14, '16598456874', '管大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (15, '13457545454', '秦大爷', NULL, NULL, NULL, NULL, '123');
INSERT INTO `user` VALUES (16, '17894654987', '孙大爷', NULL, NULL, NULL, NULL, '123');

SET FOREIGN_KEY_CHECKS = 1;
