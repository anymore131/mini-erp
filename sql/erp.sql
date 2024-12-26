/*
 Navicat Premium Dump SQL

 Source Server         : spring
 Source Server Type    : MySQL
 Source Server Version : 80012 (8.0.12)
 Source Host           : localhost:3306
 Source Schema         : erp

 Target Server Type    : MySQL
 Target Server Version : 80012 (8.0.12)
 File Encoding         : 65001

 Date: 22/12/2024 22:14:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for client
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client`  (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户名称',
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户联系方式',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户邮箱',
  `sum` int(255) NULL DEFAULT NULL COMMENT '交易总次数',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '客户交易相关员工负责人',
  `create_time` datetime NULL DEFAULT NULL,
  `last_time` datetime NULL DEFAULT NULL COMMENT '最近更新时间',
  `status` int(11) NULL DEFAULT NULL COMMENT '客户状态，是否正在合作',
  `is_delete` int(11) NULL DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `client_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `client_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for client_rfm
-- ----------------------------
DROP TABLE IF EXISTS `client_rfm`;
CREATE TABLE `client_rfm`  (
                               `client_id` int(11) NOT NULL,
                               `last_order_time` datetime NULL DEFAULT NULL COMMENT '最近一次消费时间',
                               `order_frequency` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '消费频率(订单数)',
                               `total_amount` int(11) NULL DEFAULT NULL COMMENT '消费总额(分)',
                               `rfm_score` int(11) NULL DEFAULT NULL COMMENT 'RFM得分',
                               `customer_level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户等级 (ABCD)',
                               `user_id` int(11) NULL DEFAULT NULL,
                               PRIMARY KEY (`client_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
-- Records of client
-- ----------------------------
INSERT INTO `client` VALUES (-2147360766, 'avababananha', '15867404571', '1628512812@qq.com', 0, 3, '2024-12-21 16:24:02', '2024-12-21 16:24:02', 0, 0);
INSERT INTO `client` VALUES (-1656627198, 'mpinoip;', '15867404571', '1628512812@qq.com', 0, 0, '2024-12-21 16:39:40', '2024-12-21 16:39:40', 0, 0);
INSERT INTO `client` VALUES (-1199472638, 'strkjgeh', '15867404571', '1628512812@qq.com', 0, 1, '2024-12-21 20:28:45', '2024-12-21 20:29:23', 0, 0);
INSERT INTO `client` VALUES (-742293502, 'bsdbae', '15867404571', '1628512812@qq.com', 0, 1, '2024-12-21 20:38:51', '2024-12-21 20:38:51', 0, 0);
INSERT INTO `client` VALUES (-578691070, 'abebeab', '15867404571', '1628512812@qq.com', 0, 4, '2024-12-21 16:31:19', '2024-12-21 16:31:19', 0, 0);
INSERT INTO `client` VALUES (-386695167, '荀萍', '18244781352', 'lm1sbt.spe@foxmail.com', 0, 3, NULL, NULL, 0, NULL);
INSERT INTO `client` VALUES (-348012542, 'aionoiv', '15867404571', '1628512812@qq.com', 0, 3, NULL, NULL, 0, NULL);
INSERT INTO `client` VALUES (1, 'Yung Ka Fai', '151-8464-0177', 'yung2@outlook.com', 496925, 454, '2023-10-17 13:02:45', '2000-01-10 21:56:08', 1, 1);
INSERT INTO `client` VALUES (2, 'Irene Freeman', '135-8823-3519', 'freemanire@mail.com', 38177, 401, '2006-11-23 15:58:47', '2005-03-15 12:52:12', 0, 0);
INSERT INTO `client` VALUES (3, 'Nishimura Sara', '15867404571', 'nsa111@gmail.com', 3297, 441, '2010-07-01 14:05:20', '2024-12-21 15:55:15', 1, 0);
INSERT INTO `client` VALUES (4, 'Sasaki Sara', '15867404571', '1628512812@outlook.com', 538362, 0, '2020-10-10 16:49:59', '2024-12-21 15:55:50', 1, 0);
INSERT INTO `client` VALUES (5, 'Che Cho Yee', '5267 176843', 'choyee2019@outlook.com', 857169, 839, '2014-07-05 06:10:26', '2003-08-15 18:46:01', 1, 0);
INSERT INTO `client` VALUES (6, 'Yu Lan', '20-537-0431', 'yula75@yahoo.com', 947062, 1050, '2004-05-08 17:50:37', '2016-07-18 18:02:16', 2, 0);
INSERT INTO `client` VALUES (7, 'Wang Anqi', '90-0493-5880', 'anqiwang@icloud.com', 757337, 0, '2016-02-02 11:02:08', '2009-12-04 07:14:34', 1, 0);
INSERT INTO `client` VALUES (8, 'Vincent Owens', '760-241-2875', 'owensvincent10@icloud.com', 918777, 0, '2017-12-27 17:43:32', '2005-11-27 00:55:33', 2, 0);
INSERT INTO `client` VALUES (9, '侯杰宏', '212-564-7551', 'jiehonghou112@icloud.com', 303831, 1186, '2020-10-19 14:43:52', '2006-10-23 15:33:13', 2, 0);
INSERT INTO `client` VALUES (10, '朱子异', '213-571-0985', 'zhuzi@hotmail.com', 876619, 1114, '2011-05-05 20:57:01', '2019-04-04 13:52:45', 1, 0);
INSERT INTO `client` VALUES (11, 'Su Xiaoming', '74-517-8248', 'suxi821@icloud.com', 626001, 0, '2012-01-12 15:47:12', '2020-03-19 02:17:34', 2, 0);
INSERT INTO `client` VALUES (12, '刘秀英', '(151) 277 9531', 'liu130@icloud.com', 824182, 746, '2017-03-02 13:53:58', '2016-05-17 05:01:41', 1, 0);
INSERT INTO `client` VALUES (13, 'Ding Xiuying', '173-5596-0477', 'xidi@yahoo.com', 952464, 1050, '2007-08-23 23:22:23', '2017-04-25 13:04:26', 0, 1);
INSERT INTO `client` VALUES (14, 'Yeung Wai San', '7942 792037', 'yeungws@hotmail.com', 584666, 1101, '2013-09-17 14:51:44', '2014-09-14 08:42:17', 2, 0);
INSERT INTO `client` VALUES (15, '彭晓明', '3-2734-9704', 'xiaomingpe@hotmail.com', 14476, 1042, '2006-07-02 10:07:37', '2004-11-02 23:50:59', 0, 0);
INSERT INTO `client` VALUES (16, 'Cheng Kwok Wing', '70-0245-0054', 'kwokwing2020@gmail.com', 105226, 0, '2023-04-22 07:22:37', '2017-08-22 19:07:24', 0, 0);
INSERT INTO `client` VALUES (17, '江子韬', '(151) 285 6357', 'jzitao401@gmail.com', 545975, 1042, '2010-03-25 18:12:43', '2000-10-20 16:04:34', 0, 0);
INSERT INTO `client` VALUES (18, 'James Wilson', '212-040-0739', 'james99@outlook.com', 241786, 572, '2004-08-26 16:44:15', '2014-06-18 03:10:30', 1, 0);
INSERT INTO `client` VALUES (19, 'Shen Zhiyuan', '188-2797-8378', 'zhiyuanshe@hotmail.com', 272294, 896, '2002-05-19 15:13:32', '2012-08-25 03:17:45', 1, 1);
INSERT INTO `client` VALUES (20, 'Lui Wai Yee', '11-825-2232', 'luwaiyee@gmail.com', 749918, 0, '2005-05-15 07:13:34', '2019-08-29 02:52:06', 1, 0);
INSERT INTO `client` VALUES (21, '崔秀英', '5897 353632', 'cuix@icloud.com', 739466, 767, '2003-12-08 21:47:54', '2007-09-22 00:13:47', 0, 0);
INSERT INTO `client` VALUES (22, 'Zeng Jialun', '213-632-4913', 'jialunzen@icloud.com', 902883, 926, '2008-12-10 05:03:16', '2009-03-13 18:32:29', 0, 1);
INSERT INTO `client` VALUES (23, 'Deng Lan', '74-048-9969', 'denglan@mail.com', 264022, 0, '2023-04-30 17:51:40', '2016-07-04 01:31:24', 1, 0);
INSERT INTO `client` VALUES (24, 'Tang Sau Man', '5839 648624', 'smt57@outlook.com', 399847, 647, '2024-10-08 21:38:17', '2013-11-03 02:26:09', 2, 1);
INSERT INTO `client` VALUES (25, 'Yuan Jiehong', '136-7156-4259', 'jieyuan122@icloud.com', 449557, 0, '2012-07-28 21:37:45', '2003-10-23 22:53:52', 1, 0);
INSERT INTO `client` VALUES (26, '郑嘉伦', '90-5436-6427', 'zhengj@mail.com', 607376, 837, '2004-01-17 19:47:01', '2019-07-24 12:10:38', 1, 1);
INSERT INTO `client` VALUES (27, 'Liang Zitao', '7083 449262', 'zl02@icloud.com', 888727, 782, '2015-08-23 05:42:28', '2010-02-22 05:33:56', 1, 1);
INSERT INTO `client` VALUES (28, '邹晓明', '5646 886374', 'xiaoz@outlook.com', 178742, 1014, '2018-01-07 08:52:23', '2017-03-02 03:14:36', 0, 0);
INSERT INTO `client` VALUES (29, 'Zhou Shihan', '190-3863-6266', 'zhos@outlook.com', 757065, 1026, '2024-03-03 23:39:15', '2002-06-07 14:02:16', 0, 1);
INSERT INTO `client` VALUES (30, '戴安琪', '614-712-0879', 'daia2@outlook.com', 122172, 950, '2024-05-09 01:50:11', '2017-09-10 05:05:07', 1, 1);
INSERT INTO `client` VALUES (31, 'Lam Tin Lok', '330-054-0166', 'lam9@gmail.com', 609851, 873, '2024-10-21 19:06:45', '2010-01-25 03:01:32', 0, 1);
INSERT INTO `client` VALUES (32, '阎晓明', '10-8772-9050', 'yanx@gmail.com', 525532, 0, '2022-11-16 20:49:00', '2019-03-13 07:17:49', 2, 0);
INSERT INTO `client` VALUES (33, 'Nakamura Kazuma', '80-3869-4541', 'kazumnakamura@hotmail.com', 711451, 516, '2024-06-18 03:15:41', '2012-06-02 23:34:22', 1, 0);
INSERT INTO `client` VALUES (34, 'Yan Xiuying', '213-566-6984', 'xiuyingya@gmail.com', 459289, 0, '2024-07-07 19:31:31', '2009-12-06 17:06:02', 1, 0);
INSERT INTO `client` VALUES (35, 'Mao Zitao', '66-439-7129', 'maozita@mail.com', 530888, 586, '2019-09-28 15:36:41', '2021-01-16 08:56:29', 1, 0);
INSERT INTO `client` VALUES (36, 'He Shihan', '330-811-4007', 'he93@yahoo.com', 522972, 0, '2000-01-27 09:19:36', '2021-03-25 18:24:59', 1, 0);
INSERT INTO `client` VALUES (37, '崔安琪', '(161) 002 3316', 'cui504@yahoo.com', 105144, 1075, '2010-02-23 00:34:36', '2005-04-11 05:38:58', 1, 0);
INSERT INTO `client` VALUES (38, '秦杰宏', '330-956-4349', 'qin1958@outlook.com', 313447, 622, '2023-09-04 22:24:15', '2002-11-06 01:41:43', 1, 1);
INSERT INTO `client` VALUES (39, 'Lee Wai Yee', '70-5356-6154', 'leewaiyee@outlook.com', 622511, 0, '2005-02-18 03:22:00', '2000-02-06 04:41:06', 0, 0);
INSERT INTO `client` VALUES (40, 'Yip Hiu Tung', '183-8061-1970', 'htyip@gmail.com', 312702, 594, '2001-12-23 23:30:47', '2004-04-16 15:14:11', 0, 0);
INSERT INTO `client` VALUES (41, '许杰宏', '28-9492-8585', 'xujiehong@outlook.com', 276731, 0, '2014-08-07 22:59:10', '2010-11-04 13:46:18', 0, 0);
INSERT INTO `client` VALUES (42, '范嘉伦', '66-855-3665', 'jialfan518@icloud.com', 849186, 382, '2008-04-26 23:19:00', '2011-04-24 13:18:07', 1, 1);
INSERT INTO `client` VALUES (43, 'Joel Miller', '11-858-7505', 'joelmille5@hotmail.com', 981810, 382, '2020-10-20 13:58:04', '2009-10-18 05:35:49', 1, 0);
INSERT INTO `client` VALUES (44, 'Meng On Na', '5356 078205', 'mengon3@gmail.com', 590227, 1161, '2019-12-13 07:44:21', '2014-06-03 16:13:48', 0, 1);
INSERT INTO `client` VALUES (45, 'Ho Ling Ling', '213-313-7878', 'llh54@gmail.com', 865657, 222, '2006-03-30 22:34:38', '2012-11-23 03:14:03', 1, 1);
INSERT INTO `client` VALUES (46, 'Miguel Alexander', '66-705-1296', 'miguel808@mail.com', 774281, 1114, '2022-12-16 14:38:02', '2007-03-05 14:48:45', 1, 1);
INSERT INTO `client` VALUES (47, '傅嘉伦', '330-154-9650', 'jialufu@gmail.com', 922706, 301, '2004-05-18 16:17:30', '2007-05-31 19:13:45', 1, 0);
INSERT INTO `client` VALUES (48, '江嘉伦', '66-102-1230', 'jiangj4@outlook.com', 502127, 1067, '2006-08-10 17:40:14', '2014-05-06 23:12:34', 1, 1);
INSERT INTO `client` VALUES (49, '孔璐', '90-2281-4892', 'kong621@outlook.com', 484638, 0, '2004-10-22 06:31:46', '2024-05-14 17:46:56', 1, 0);
INSERT INTO `client` VALUES (50, 'Ikeda Yuito', '70-0813-5721', 'yuito605@outlook.com', 687228, 1085, '2010-09-02 11:47:33', '2013-06-22 23:17:15', 1, 0);
INSERT INTO `client` VALUES (51, '姚嘉伦', '(1223) 11 7879', 'jialuyao@yahoo.com', 493887, 882, '2019-12-16 22:14:13', '2019-10-08 01:06:40', 0, 0);
INSERT INTO `client` VALUES (52, 'Long Zhiyuan', '154-2011-0683', 'lozhiyuan95@yahoo.com', 422458, 592, '2004-10-04 12:28:42', '2016-03-19 21:05:15', 1, 1);
INSERT INTO `client` VALUES (53, 'Nakamura Aoi', '66-482-2419', 'aon@icloud.com', 224224, 721, '2003-01-03 13:13:14', '2018-08-22 12:49:16', 1, 0);
INSERT INTO `client` VALUES (54, '石子韬', '(151) 106 9243', 'shizita@outlook.com', 713141, 0, '2016-09-09 10:31:44', '2012-02-26 08:11:22', 0, 0);
INSERT INTO `client` VALUES (55, 'Arai Kasumi', '70-8091-9550', 'kasumi43@gmail.com', 13726, 1054, '2005-01-10 20:12:26', '2020-03-05 18:16:23', 1, 1);
INSERT INTO `client` VALUES (56, '方子韬', '330-256-7867', 'zitao406@icloud.com', 688779, 0, '2010-07-02 05:15:24', '2017-03-06 16:23:18', 0, 0);
INSERT INTO `client` VALUES (57, 'Yang Yuning', '760-177-2492', 'yuningyang@gmail.com', 952026, 874, '2012-04-21 22:02:30', '2006-01-25 14:19:38', 2, 1);
INSERT INTO `client` VALUES (58, '熊子异', '838-792-7121', 'ziyi9@gmail.com', 292611, 836, '2002-07-17 09:09:44', '2018-09-18 20:04:10', 2, 1);
INSERT INTO `client` VALUES (59, '杨秀英', '70-0301-0782', 'xiuya@hotmail.com', 753109, 1003, '2024-12-03 13:28:13', '2013-06-04 20:58:46', 1, 1);
INSERT INTO `client` VALUES (60, 'Shi Xiaoming', '769-4915-6541', 'xiaoming607@gmail.com', 405572, 863, '2013-12-21 18:07:48', '2003-06-21 03:45:36', 2, 1);
INSERT INTO `client` VALUES (61, 'Zhu Zhiyuan', '28-366-7496', 'zzhiyuan915@gmail.com', 624415, 360, '2008-04-09 18:45:28', '2022-02-20 18:55:52', 1, 1);
INSERT INTO `client` VALUES (62, 'Ma Yunxi', '11-934-9763', 'yunxi1@gmail.com', 934386, 929, '2003-11-16 06:59:11', '2016-10-01 17:59:12', 0, 0);
INSERT INTO `client` VALUES (63, 'Julie Rivera', '(151) 659 2709', 'jr3@outlook.com', 307072, 254, '2001-04-02 05:29:23', '2020-11-27 18:21:06', 1, 1);
INSERT INTO `client` VALUES (64, '向杰宏', '614-711-5422', 'xiangj84@gmail.com', 255055, 0, '2023-04-24 15:53:54', '2022-09-30 06:03:17', 1, 0);
INSERT INTO `client` VALUES (65, 'Wang Jiehong', '90-2395-9706', 'jiwan@yahoo.com', 795954, 505, '2012-11-30 14:01:26', '2018-06-14 17:00:42', 1, 0);
INSERT INTO `client` VALUES (66, '贾宇宁', '614-631-0984', 'jiayuni@icloud.com', 222082, 558, '2007-03-02 12:43:34', '2010-11-02 06:28:42', 2, 1);
INSERT INTO `client` VALUES (67, '杜睿', '21-3571-5452', 'rui83@outlook.com', 400441, 641, '2003-10-14 21:24:41', '2007-06-12 10:53:38', 1, 1);
INSERT INTO `client` VALUES (68, 'Wong Yu Ling', '614-316-0126', 'yuling7@mail.com', 379800, 548, '2011-06-05 05:45:57', '2008-12-16 19:25:38', 0, 1);
INSERT INTO `client` VALUES (69, 'Tang Anqi', '(116) 846 6656', 'tang55@gmail.com', 443192, 471, '2011-05-28 22:07:09', '2018-06-25 03:55:27', 1, 0);
INSERT INTO `client` VALUES (70, 'Otsuka Takuya', '3-6333-7982', 'takuyaotsuka@mail.com', 427423, 0, '2013-08-03 18:55:02', '2013-12-03 18:04:22', 0, 0);
INSERT INTO `client` VALUES (71, '吴震南', '80-4570-8800', 'wuzh@icloud.com', 628972, 0, '2002-11-20 02:21:53', '2009-10-18 22:06:45', 1, 0);
INSERT INTO `client` VALUES (72, 'Morita Itsuki', '66-736-2142', 'itsum@gmail.com', 709894, 1086, '2009-03-19 18:28:29', '2019-08-03 18:05:58', 1, 0);
INSERT INTO `client` VALUES (73, 'Ren Lu', '74-055-8274', 'rlu@icloud.com', 755287, 1105, '2018-03-26 06:37:58', '2024-03-05 04:55:52', 1, 0);
INSERT INTO `client` VALUES (74, 'Shibata Mai', '74-241-5627', 'shibatamai@yahoo.com', 450944, 211, '2021-04-14 09:07:45', '2007-11-08 15:50:40', 2, 1);
INSERT INTO `client` VALUES (75, 'Anne Schmidt', '20-990-4992', 'anneschmidt@hotmail.com', 142809, 1048, '2004-04-30 23:47:38', '2003-05-07 13:20:55', 1, 1);
INSERT INTO `client` VALUES (76, 'Zhang Zitao', '(1223) 23 8342', 'zitao310@outlook.com', 260088, 707, '2004-12-21 16:56:12', '2019-04-08 14:51:45', 1, 1);
INSERT INTO `client` VALUES (77, 'Yam Wing Fat', '5014 655097', 'wingfaty@icloud.com', 555682, 845, '2015-03-04 20:53:22', '2020-04-04 05:30:23', 1, 1);
INSERT INTO `client` VALUES (78, 'Yu Rui', '190-7379-5593', 'ruiyu10@outlook.com', 968352, 1088, '2019-02-21 00:36:35', '2010-06-05 03:29:07', 1, 0);
INSERT INTO `client` VALUES (79, 'Matsui Nanami', '213-285-5576', 'matsuinana3@gmail.com', 812696, 1145, '2017-11-07 20:11:06', '2014-08-18 09:01:12', 2, 1);
INSERT INTO `client` VALUES (80, 'Miu Lik Sun', '199-3242-3324', 'miu126@icloud.com', 700969, 526, '2002-11-06 07:51:49', '2016-06-22 09:23:22', 1, 1);
INSERT INTO `client` VALUES (81, 'Miu Kwok Wing', '330-516-1942', 'mkw1214@icloud.com', 726600, 413, '2019-02-15 01:12:21', '2010-09-29 14:07:52', 2, 1);
INSERT INTO `client` VALUES (82, '韩嘉伦', '70-7096-8749', 'jialun9@icloud.com', 756751, 540, '2012-04-27 10:42:59', '2007-08-05 14:19:42', 1, 0);
INSERT INTO `client` VALUES (83, 'Ueno Airi', '330-947-0012', 'uenoa4@gmail.com', 406666, 0, '2016-12-15 21:45:12', '2019-02-21 01:56:12', 2, 0);
INSERT INTO `client` VALUES (84, 'Ho Fat', '838-707-8468', 'ho1@hotmail.com', 255899, 225, '2024-06-23 18:17:06', '2010-03-09 05:10:41', 0, 1);
INSERT INTO `client` VALUES (85, 'Takeda Kaito', '7904 070450', 'takedakaito09@gmail.com', 442458, 0, '2005-12-01 00:44:51', '2013-02-17 10:13:22', 1, 0);
INSERT INTO `client` VALUES (86, '朱宇宁', '139-0031-6830', 'zhyuning@gmail.com', 629535, 985, '2005-11-07 04:03:09', '2018-03-11 22:52:37', 0, 0);
INSERT INTO `client` VALUES (87, 'Yan Lu', '74-403-1686', 'yanlu311@mail.com', 515467, 884, '2001-06-14 02:04:53', '2003-03-06 22:33:40', 2, 0);
INSERT INTO `client` VALUES (88, 'Yan Jiehong', '838-823-4191', 'yajieho@gmail.com', 154472, 0, '2011-05-06 02:18:50', '2006-06-23 02:05:23', 1, 0);
INSERT INTO `client` VALUES (89, 'Ishida Mai', '(1223) 50 9595', 'maiishida47@yahoo.com', 771130, 856, '2017-11-15 03:41:08', '2015-06-22 13:13:27', 2, 1);
INSERT INTO `client` VALUES (90, 'Wu Ming Sze', '(1865) 43 9235', 'mingszewu221@yahoo.com', 640582, 585, '2001-09-18 01:29:31', '2022-07-19 20:26:32', 1, 1);
INSERT INTO `client` VALUES (91, 'Murakami Momoe', '20-889-7969', 'momoemu1@outlook.com', 522223, 962, '2022-09-23 21:03:43', '2020-06-01 04:16:29', 1, 1);
INSERT INTO `client` VALUES (92, 'Peter Rice', '769-2283-8387', 'rpeter@gmail.com', 378760, 620, '2020-11-19 06:48:49', '2018-10-29 15:49:27', 1, 1);
INSERT INTO `client` VALUES (93, 'Kudo Aoshi', '5348 604917', 'kudoaos@outlook.com', 635890, 1134, '2012-09-07 12:07:36', '2011-06-27 20:52:47', 2, 0);
INSERT INTO `client` VALUES (94, 'Jia Zitao', '137-5375-6562', 'zijia@icloud.com', 619597, 464, '2021-02-21 06:56:20', '2017-04-29 07:45:59', 0, 1);
INSERT INTO `client` VALUES (95, 'Hou Yunxi', '5111 152895', 'hoyunxi03@gmail.com', 828503, 1110, '2002-10-28 14:07:30', '2008-01-15 11:49:39', 2, 1);
INSERT INTO `client` VALUES (96, 'Francis Hunter', '755-5351-2442', 'francishunt@yahoo.com', 875475, 904, '2021-09-10 00:09:16', '2005-07-27 03:43:50', 0, 1);
INSERT INTO `client` VALUES (97, 'Stephanie Brooks', '156-0991-6193', 'stephanie5@icloud.com', 592460, 272, '2000-04-18 13:31:52', '2014-02-10 06:57:59', 0, 1);
INSERT INTO `client` VALUES (98, 'So Sai Wing', '138-8061-4643', 'ssw@outlook.com', 878956, 0, '2010-10-18 13:30:14', '2003-05-28 03:17:24', 2, 0);
INSERT INTO `client` VALUES (99, '严璐', '614-919-9031', 'yl1@yahoo.com', 778860, 427, '2017-11-15 11:23:45', '2010-07-17 10:39:40', 1, 1);
INSERT INTO `client` VALUES (100, 'Ku Wing Fat', '70-9988-4264', 'wingfat1952@hotmail.com', 139171, 653, '2009-06-24 00:34:38', '2016-03-18 13:14:30', 2, 0);
INSERT INTO `client` VALUES (101, '韩秀英', '755-0080-2461', 'xiuyingha@outlook.com', 530444, 279, '2014-04-15 10:36:44', '2003-06-18 04:54:22', 2, 1);
INSERT INTO `client` VALUES (102, '江詩涵', '175-8435-5815', 'shij@gmail.com', 7102, 418, '2017-03-06 00:33:51', '2008-11-03 06:50:48', 1, 0);
INSERT INTO `client` VALUES (103, 'Aaron Sanders', '(1865) 67 2782', 'aaron8@gmail.com', 423212, 447, '2016-12-02 00:50:35', '2001-01-05 13:11:19', 1, 1);
INSERT INTO `client` VALUES (104, 'Mui Kwok Kuen', '330-366-5618', 'kkmu@icloud.com', 294783, 0, '2019-06-22 13:15:19', '2001-09-05 22:19:23', 0, 0);
INSERT INTO `client` VALUES (105, 'Tam Kwok Wing', '769-0389-9484', 'tamkwokwing2012@gmail.com', 518936, 0, '2001-11-29 18:07:18', '2011-10-15 03:09:28', 0, 0);
INSERT INTO `client` VALUES (106, 'Dai Ka Ling', '7472 985157', 'dkl919@icloud.com', 275911, 604, '2006-08-10 05:04:14', '2003-09-26 21:51:21', 0, 0);
INSERT INTO `client` VALUES (107, 'Norman Hayes', '149-6170-3951', 'normhaye48@gmail.com', 431194, 570, '2024-08-02 07:24:29', '2022-06-25 19:13:10', 0, 0);
INSERT INTO `client` VALUES (108, 'Wang Zitao', '(1223) 55 7582', 'zitwang206@outlook.com', 189157, 0, '2003-01-22 16:15:27', '2022-03-05 07:50:11', 1, 0);
INSERT INTO `client` VALUES (109, 'Deng Zhiyuan', '718-188-7774', 'dz09@yahoo.com', 494113, 6, '2006-07-24 07:19:52', '2023-05-07 21:46:41', 0, 1);
INSERT INTO `client` VALUES (110, 'Man Wing Sze', '838-766-5669', 'wsma@outlook.com', 125388, 800, '2018-07-21 09:10:40', '2006-11-09 01:27:51', 1, 1);
INSERT INTO `client` VALUES (111, 'Shao Xiaoming', '3-8262-2329', 'xshao@gmail.com', 20116, 882, '2010-07-15 09:39:44', '2020-08-25 03:50:33', 2, 1);
INSERT INTO `client` VALUES (112, 'Shibata Mitsuki', '183-2866-4013', 'shibata1952@outlook.com', 439428, 891, '2000-06-26 14:16:47', '2017-02-26 06:42:47', 0, 1);
INSERT INTO `client` VALUES (113, 'Han Lu', '52-003-0100', 'luhan1003@icloud.com', 839339, 975, '2023-02-17 06:51:44', '2008-07-26 10:56:39', 1, 0);
INSERT INTO `client` VALUES (114, 'Morita Ayato', '7612 471343', 'amorit6@outlook.com', 354724, 1185, '2023-01-29 18:39:36', '2008-03-05 06:45:40', 1, 1);
INSERT INTO `client` VALUES (115, 'Chan Suk Yee', '718-021-5356', 'chansukyee1964@outlook.com', 5591, 533, '2010-12-09 07:24:40', '2017-07-23 16:27:45', 2, 0);
INSERT INTO `client` VALUES (116, 'Sano Hina', '838-809-7680', 'sanoh19@gmail.com', 220758, 777, '2014-06-26 07:17:04', '2009-03-12 11:09:48', 1, 0);
INSERT INTO `client` VALUES (117, 'Dai Anqi', '212-209-2576', 'daianqi@hotmail.com', 576813, 436, '2019-12-09 12:46:19', '2021-08-25 02:42:46', 2, 1);
INSERT INTO `client` VALUES (118, 'Glenn Allen', '718-103-6791', 'aglenn53@outlook.com', 232829, 1114, '2016-07-01 23:17:06', '2009-07-14 22:58:12', 1, 0);
INSERT INTO `client` VALUES (119, 'Koon Chi Ming', '130-4239-5391', 'chimingkoon@hotmail.com', 166884, 1064, '2018-08-27 14:06:02', '2000-05-06 06:11:59', 1, 1);
INSERT INTO `client` VALUES (120, 'Peng Lan', '213-500-1115', 'lanp@icloud.com', 488353, 0, '2016-05-20 22:31:28', '2006-08-25 16:21:17', 1, 0);
INSERT INTO `client` VALUES (121, 'Maruyama Yuto', '614-998-2496', 'mayuto4@gmail.com', 711422, 279, '2005-08-25 22:22:16', '2013-01-29 14:59:40', 1, 0);
INSERT INTO `client` VALUES (122, 'Kwok Ka Fai', '718-358-1914', 'kwokkafai@gmail.com', 838276, 325, '2022-04-22 06:28:06', '2004-08-11 13:35:22', 2, 1);
INSERT INTO `client` VALUES (123, 'Morita Ryota', '(121) 211 5369', 'rymorita1972@outlook.com', 732901, 0, '2008-11-26 00:14:15', '2018-12-10 22:55:37', 1, 0);
INSERT INTO `client` VALUES (124, '陈詩涵', '718-751-7183', 'shihanchen4@icloud.com', 205172, 0, '2014-08-30 01:52:22', '2019-07-27 11:59:15', 2, 0);
INSERT INTO `client` VALUES (125, 'Ralph Flores', '(121) 883 2420', 'ralphflores@mail.com', 330155, 657, '2019-08-21 06:20:40', '2020-10-25 06:40:46', 2, 0);
INSERT INTO `client` VALUES (126, 'Zhou Lu', '718-241-4726', 'luz@hotmail.com', 779997, 835, '2012-07-23 15:10:32', '2015-06-03 20:11:15', 1, 1);
INSERT INTO `client` VALUES (127, '彭晓明', '74-936-5341', 'xiaomingp@gmail.com', 290876, 684, '2006-11-01 18:08:23', '2015-06-25 00:32:56', 1, 1);
INSERT INTO `client` VALUES (128, 'Lee Fu Shing', '11-811-0453', 'fslee@gmail.com', 716726, 1026, '2000-02-28 08:39:49', '2018-06-17 22:27:33', 1, 0);
INSERT INTO `client` VALUES (129, 'Karen Wright', '90-7305-2230', 'wrightkar@hotmail.com', 638830, 294, '2012-06-04 02:50:35', '2008-06-29 09:54:46', 2, 0);
INSERT INTO `client` VALUES (130, 'Steven Guzman', '80-7145-9487', 'stevenguz1106@gmail.com', 642900, 1058, '2017-02-21 11:27:33', '2010-06-22 21:00:27', 2, 0);
INSERT INTO `client` VALUES (131, 'Hsuan Lai Yan', '212-551-0255', 'hsulaiyan@icloud.com', 59360, 343, '2021-02-14 19:40:49', '2024-10-15 14:33:00', 1, 1);
INSERT INTO `client` VALUES (132, 'Li Shihan', '213-453-5945', 'shihali@gmail.com', 579475, 916, '2006-07-25 20:33:48', '2005-08-17 14:07:45', 1, 1);
INSERT INTO `client` VALUES (133, 'Ishikawa Yuito', '(121) 624 0285', 'ishikyuito@yahoo.com', 430047, 0, '2020-02-12 07:26:29', '2015-05-03 05:15:25', 1, 0);
INSERT INTO `client` VALUES (134, '赵詩涵', '80-6195-9603', 'zhsh3@mail.com', 513316, 912, '2005-08-12 23:43:49', '2000-04-04 17:52:58', 1, 1);
INSERT INTO `client` VALUES (135, 'Xu Yunxi', '(1865) 83 3391', 'xuyunxi@mail.com', 388066, 0, '2004-08-09 14:49:48', '2008-12-31 22:24:00', 2, 0);
INSERT INTO `client` VALUES (136, 'Inoue Airi', '838-949-3437', 'iairi1983@gmail.com', 505632, 447, '2002-07-28 14:02:13', '2003-10-30 00:39:27', 1, 0);
INSERT INTO `client` VALUES (137, 'Murakami Kazuma', '80-3946-8836', 'murakazuma@hotmail.com', 969332, 780, '2008-04-23 11:55:27', '2005-10-31 20:41:14', 1, 1);
INSERT INTO `client` VALUES (138, 'Taniguchi Rena', '7003 143239', 'taniguchir3@gmail.com', 127, 0, '2002-06-10 19:10:35', '2020-07-01 21:41:52', 0, 0);
INSERT INTO `client` VALUES (139, 'Fan Ming', '5011 192996', 'mfan@gmail.com', 234364, 676, '2013-11-02 20:11:24', '2000-12-05 10:06:30', 1, 1);
INSERT INTO `client` VALUES (140, 'Xu Xiaoming', '(1865) 59 4665', 'xxu@mail.com', 823938, 1198, '2024-01-22 15:53:26', '2021-12-09 15:11:10', 1, 1);
INSERT INTO `client` VALUES (141, 'Chin Hiu Tung', '330-182-5523', 'hiutungc9@yahoo.com', 369521, 271, '2022-09-08 03:19:39', '2000-09-14 19:50:26', 0, 1);
INSERT INTO `client` VALUES (142, 'Choi Wai Yee', '142-6658-8086', 'waiyee9@yahoo.com', 348620, 608, '2001-05-15 17:54:55', '2004-04-03 03:42:02', 2, 1);
INSERT INTO `client` VALUES (143, '董璐', '330-082-0634', 'ludon1110@hotmail.com', 368288, 0, '2008-02-24 19:55:54', '2022-05-18 06:24:04', 1, 0);
INSERT INTO `client` VALUES (144, 'Clara Patterson', '7507 505103', 'clarapatterson@yahoo.com', 702252, 336, '2001-08-04 15:53:38', '2020-10-22 14:50:32', 1, 1);
INSERT INTO `client` VALUES (145, 'Zhao Rui', '(161) 996 5869', 'ruzha@gmail.com', 613562, 737, '2016-04-01 15:18:58', '2012-07-25 08:46:18', 2, 0);
INSERT INTO `client` VALUES (146, '于岚', '5625 866720', 'yulan@gmail.com', 495120, 985, '2001-12-16 22:14:59', '2013-11-19 06:46:15', 2, 1);
INSERT INTO `client` VALUES (147, '雷睿', '7163 012581', 'rui53@yahoo.com', 834641, 382, '2001-05-28 22:40:35', '2020-04-08 09:14:37', 2, 0);
INSERT INTO `client` VALUES (148, 'Liao Jialun', '213-923-4810', 'lijial@hotmail.com', 386450, 235, '2020-08-14 04:40:18', '2003-12-27 03:24:07', 1, 0);
INSERT INTO `client` VALUES (149, 'Carol Brown', '(116) 206 3530', 'bcar@gmail.com', 509699, 0, '2002-07-23 16:32:03', '2009-10-06 21:03:52', 0, 0);
INSERT INTO `client` VALUES (150, '郭璐', '(116) 375 8134', 'lguo4@yahoo.com', 979508, 969, '2024-10-10 20:30:39', '2000-11-01 10:47:53', 1, 0);
INSERT INTO `client` VALUES (151, 'Lok Ka Ling', '171-3111-4349', 'lok1979@outlook.com', 541576, 0, '2012-06-29 18:02:55', '2002-06-20 09:53:04', 1, 0);
INSERT INTO `client` VALUES (152, '吴晓明', '312-135-4138', 'xiwu@hotmail.com', 849077, 961, '2019-03-21 09:38:33', '2017-07-26 02:52:20', 2, 1);
INSERT INTO `client` VALUES (153, 'Andrew Dunn', '769-8337-2323', 'andrewdunn@mail.com', 142565, 629, '2014-03-10 03:02:09', '2002-12-25 06:34:24', 0, 0);
INSERT INTO `client` VALUES (154, '姜致远', '28-3593-1496', 'zhjian1107@hotmail.com', 264635, 975, '2008-03-22 18:00:08', '2017-12-12 18:38:25', 1, 1);
INSERT INTO `client` VALUES (155, 'Yung Wai Han', '80-2158-6467', 'ywaihan@outlook.com', 468202, 273, '2003-12-10 13:07:04', '2010-07-17 05:44:06', 2, 1);
INSERT INTO `client` VALUES (156, 'Joseph Mills', '28-5545-1360', 'jm1105@gmail.com', 50758, 304, '2009-11-10 02:34:40', '2020-03-02 03:31:18', 0, 1);
INSERT INTO `client` VALUES (157, 'Xiong Xiuying', '838-235-8686', 'xiuyx@outlook.com', 873731, 1068, '2013-07-13 06:56:29', '2004-04-10 05:07:29', 0, 0);
INSERT INTO `client` VALUES (158, 'Chan Suk Yee', '70-2997-5429', 'chansy@mail.com', 421119, 708, '2021-02-01 10:18:55', '2023-09-24 18:10:53', 0, 1);
INSERT INTO `client` VALUES (159, 'Shen Lan', '212-743-1994', 'shen13@icloud.com', 480883, 904, '2013-01-25 11:49:49', '2014-12-23 19:37:28', 0, 0);
INSERT INTO `client` VALUES (160, 'Grace Lopez', '80-3107-3258', 'grace96@outlook.com', 439728, 485, '2000-05-09 01:30:21', '2007-09-30 23:21:48', 0, 0);
INSERT INTO `client` VALUES (161, 'Tian Zitao', '614-797-9767', 'zitao214@mail.com', 61322, 462, '2016-04-10 09:25:49', '2013-09-15 08:33:49', 1, 1);
INSERT INTO `client` VALUES (162, 'Lui Yun Fat', '330-743-7143', 'yflui@mail.com', 630281, 1119, '2021-07-08 17:27:48', '2003-05-12 03:29:50', 2, 0);
INSERT INTO `client` VALUES (163, 'Hsuan Suk Yee', '(20) 9473 1880', 'syhsuan603@gmail.com', 208868, 882, '2003-05-04 09:39:37', '2008-03-25 00:38:47', 1, 0);
INSERT INTO `client` VALUES (164, '尹云熙', '614-615-5708', 'yinyunxi@gmail.com', 963833, 1183, '2008-09-05 04:31:55', '2006-07-14 00:30:18', 1, 0);
INSERT INTO `client` VALUES (165, '蒋宇宁', '10-899-5043', 'jiayu@gmail.com', 149722, 749, '2002-06-13 00:16:09', '2005-07-26 21:39:22', 1, 1);
INSERT INTO `client` VALUES (166, '萧璐', '196-9447-8487', 'xiao1@gmail.com', 661942, 1069, '2008-06-25 23:03:46', '2000-11-05 00:42:42', 0, 0);
INSERT INTO `client` VALUES (167, '石嘉伦', '330-947-4773', 'shijialun@outlook.com', 754815, 776, '2021-12-04 15:52:48', '2015-07-30 01:02:39', 1, 0);
INSERT INTO `client` VALUES (168, 'Benjamin Robinson', '5864 848546', 'robinsonbenjamin@mail.com', 262089, 816, '2023-11-22 03:57:35', '2022-01-10 05:49:15', 1, 1);
INSERT INTO `client` VALUES (169, 'Irene Smith', '70-5283-5876', 'sirene10@gmail.com', 161235, 722, '2021-08-23 13:11:15', '2020-09-25 09:47:38', 1, 0);
INSERT INTO `client` VALUES (170, 'Chan Tak Wah', '769-987-0713', 'chan69@gmail.com', 429637, 0, '2014-04-11 23:55:52', '2020-01-15 16:54:14', 2, 0);
INSERT INTO `client` VALUES (171, '邵子韬', '212-047-3153', 'shao527@yahoo.com', 999332, 1079, '2011-11-30 17:42:29', '2001-05-17 18:47:06', 2, 0);
INSERT INTO `client` VALUES (172, 'Chan Chieh Lun', '150-6112-8651', 'chan67@hotmail.com', 729511, 954, '2010-02-08 07:57:10', '2003-09-09 01:42:35', 2, 1);
INSERT INTO `client` VALUES (173, 'Yin Ming Sze', '7706 336919', 'msy@outlook.com', 81944, 732, '2007-02-19 09:13:01', '2012-04-02 17:42:06', 0, 1);
INSERT INTO `client` VALUES (174, 'Wu Zhennan', '718-824-1316', 'zhennanwu@hotmail.com', 784619, 296, '2013-06-20 21:35:37', '2001-04-26 10:43:43', 0, 1);
INSERT INTO `client` VALUES (175, 'Takeda Daichi', '330-540-7232', 'tdaichi128@gmail.com', 476715, 0, '2001-02-18 09:24:41', '2003-12-20 15:56:16', 1, 0);
INSERT INTO `client` VALUES (176, 'Zeng Jialun', '70-8350-2092', 'zej6@outlook.com', 448497, 1086, '2022-05-31 11:36:48', '2017-03-04 12:02:43', 0, 1);
INSERT INTO `client` VALUES (177, 'Tang Sze Kwan', '3-4293-0868', 'tansk1204@yahoo.com', 244900, 802, '2017-10-25 03:21:23', '2018-05-14 04:27:03', 2, 1);
INSERT INTO `client` VALUES (178, 'Juan Walker', '312-396-7169', 'walkerju@yahoo.com', 545020, 0, '2014-04-03 19:36:35', '2015-07-29 13:33:49', 2, 0);
INSERT INTO `client` VALUES (179, 'Hui Wai Man', '(1865) 40 3909', 'wmhui709@hotmail.com', 694910, 372, '2020-07-04 14:17:50', '2001-11-03 09:28:47', 1, 1);
INSERT INTO `client` VALUES (180, 'Ogawa Seiko', '330-614-9719', 'seiko1974@icloud.com', 90601, 0, '2010-01-08 16:54:48', '2000-08-08 10:05:10', 1, 0);
INSERT INTO `client` VALUES (181, 'Feng Shihan', '7273 067889', 'fengsh1230@hotmail.com', 128005, 326, '2016-02-29 21:58:00', '2018-06-14 22:43:00', 0, 0);
INSERT INTO `client` VALUES (182, 'Yan Lu', '80-4207-0774', 'yanlu@icloud.com', 640050, 1122, '2020-01-16 09:19:57', '2004-09-23 03:34:18', 2, 0);
INSERT INTO `client` VALUES (183, '尹岚', '212-395-7712', 'lanyin212@gmail.com', 460548, 871, '2006-09-29 10:09:07', '2001-06-06 02:40:39', 1, 1);
INSERT INTO `client` VALUES (184, 'Takahashi Akina', '5911 919797', 'takahashi1967@icloud.com', 917288, 600, '2023-04-08 14:15:16', '2005-09-28 13:24:28', 2, 0);
INSERT INTO `client` VALUES (185, '金嘉伦', '155-1267-2934', 'jialuji@icloud.com', 850348, 914, '2008-06-30 10:53:31', '2015-10-29 03:09:14', 1, 0);
INSERT INTO `client` VALUES (186, 'Yang Shihan', '213-133-6743', 'yansh@icloud.com', 971229, 397, '2016-01-25 18:45:35', '2018-05-02 00:41:12', 1, 1);
INSERT INTO `client` VALUES (187, '常璐', '212-703-1278', 'lu55@outlook.com', 589842, 219, '2003-01-21 19:07:12', '2015-12-06 10:55:07', 1, 0);
INSERT INTO `client` VALUES (188, 'Tan Zitao', '213-741-8605', 'tan55@outlook.com', 496790, 0, '2009-06-07 06:22:20', '2005-08-08 22:29:45', 0, 0);
INSERT INTO `client` VALUES (189, 'Cho Yu Ling', '5105 928598', 'cho08@yahoo.com', 411708, 0, '2015-10-31 00:01:21', '2011-10-18 09:40:02', 2, 0);
INSERT INTO `client` VALUES (190, 'Xiong Jiehong', '760-2458-4496', 'xiongjieh2020@hotmail.com', 667534, 893, '2008-06-18 02:10:59', '2015-05-02 23:43:39', 1, 0);
INSERT INTO `client` VALUES (191, 'Douglas Wallace', '718-723-7389', 'douglas3@icloud.com', 79179, 1042, '2011-09-10 18:59:09', '2009-05-17 14:49:16', 0, 1);
INSERT INTO `client` VALUES (192, 'Gong Yunxi', '718-834-7527', 'yunxg812@mail.com', 978678, 452, '2006-10-28 18:02:45', '2001-03-13 10:14:32', 0, 1);
INSERT INTO `client` VALUES (193, 'Justin Simpson', '755-746-5437', 'jussim@icloud.com', 94829, 1025, '2018-10-01 18:00:29', '2019-03-04 12:05:53', 2, 0);
INSERT INTO `client` VALUES (194, 'Fred Fernandez', '5675 604869', 'fredfernandez@mail.com', 125519, 0, '2002-03-19 07:38:50', '2018-02-08 01:24:08', 0, 0);
INSERT INTO `client` VALUES (195, 'Jia Xiaoming', '(20) 4696 2272', 'xiaomingj@gmail.com', 84843, 229, '2013-12-28 07:15:50', '2009-01-12 02:07:15', 1, 1);
INSERT INTO `client` VALUES (196, 'Zhao Xiuying', '312-867-5755', 'xzhao@icloud.com', 60727, 731, '2013-05-02 09:04:12', '2003-02-24 22:06:41', 0, 1);
INSERT INTO `client` VALUES (197, 'Kwok Tsz Ching', '(151) 641 0559', 'tck@icloud.com', 19499, 0, '2015-08-26 04:18:48', '2024-09-16 17:38:37', 1, 0);
INSERT INTO `client` VALUES (198, 'Wang Lu', '21-887-4144', 'wanglu@gmail.com', 361015, 1111, '2003-03-09 04:16:34', '2006-09-07 03:30:54', 0, 0);
INSERT INTO `client` VALUES (199, '何宇宁', '11-626-3596', 'yuninhe2017@yahoo.com', 368802, 395, '2010-11-15 08:31:55', '2003-07-12 04:25:11', 1, 1);
INSERT INTO `client` VALUES (200, 'Yuen Chieh Lun', '171-6347-0067', 'yuencl@gmail.com', 175521, 0, '2020-10-28 16:42:34', '2015-10-12 16:34:44', 1, 0);
INSERT INTO `client` VALUES (201, '贺晓明', '5229 021189', 'hexiaoming5@gmail.com', 896349, 943, '2020-08-28 06:39:51', '2008-04-10 15:56:29', 2, 1);
INSERT INTO `client` VALUES (202, 'Fung On Na', '5126 048649', 'onf@hotmail.com', 368659, 728, '2000-11-19 04:08:28', '2024-05-15 06:05:58', 1, 1);
INSERT INTO `client` VALUES (203, 'Mao Xiaoming', '3-8703-3205', 'xiaommao06@icloud.com', 860105, 352, '2002-11-20 03:13:18', '2023-12-19 15:19:08', 2, 1);
INSERT INTO `client` VALUES (204, 'Ogawa Ren', '(151) 373 2754', 'ren925@gmail.com', 606041, 0, '2017-04-11 21:37:09', '2017-07-03 05:04:58', 2, 0);
INSERT INTO `client` VALUES (205, 'Tam Fat', '132-8361-3698', 'tamfa427@hotmail.com', 337964, 1161, '2012-05-27 07:56:51', '2007-02-24 03:36:14', 1, 1);
INSERT INTO `client` VALUES (206, 'Raymond Schmidt', '213-158-1311', 'scraymond67@icloud.com', 374739, 1034, '2013-01-03 09:13:51', '2019-01-28 18:10:17', 0, 1);
INSERT INTO `client` VALUES (207, 'Pak Wing Fat', '20-7084-2730', 'pakwf@icloud.com', 991998, 369, '2010-04-27 17:58:42', '2000-09-22 22:22:45', 1, 1);
INSERT INTO `client` VALUES (208, 'Nakajima Ikki', '70-4387-9114', 'nakaikk2@gmail.com', 288853, 1100, '2003-04-15 00:58:37', '2001-12-01 21:59:16', 1, 0);
INSERT INTO `client` VALUES (209, '何子韬', '136-6889-0289', 'zitaoh@icloud.com', 420076, 703, '2010-06-20 03:27:00', '2020-11-12 19:50:07', 2, 1);
INSERT INTO `client` VALUES (210, 'Nakano Miu', '70-5925-8514', 'namiu7@hotmail.com', 861747, 0, '2021-06-04 13:12:09', '2001-07-18 00:56:11', 1, 0);
INSERT INTO `client` VALUES (211, 'Carmen Wallace', '70-7312-8698', 'cwal919@hotmail.com', 822524, 232, '2015-03-08 19:57:11', '2004-07-05 20:41:28', 1, 1);
INSERT INTO `client` VALUES (212, 'Yoshida Riku', '162-5583-0725', 'yoshida09@mail.com', 681239, 0, '2010-10-26 03:27:32', '2008-11-14 01:46:32', 2, 0);
INSERT INTO `client` VALUES (213, 'Wei Anqi', '5487 269048', 'weianqi@yahoo.com', 699355, 1021, '2007-09-16 08:38:00', '2017-03-04 07:14:05', 2, 0);
INSERT INTO `client` VALUES (214, 'Song Jialun', '330-429-8362', 'jialsong@icloud.com', 69223, 940, '2004-02-27 10:59:30', '2021-05-28 21:47:12', 0, 1);
INSERT INTO `client` VALUES (215, 'Victoria Vasquez', '80-8969-6426', 'vasquez4@outlook.com', 544880, 397, '2000-06-09 13:00:30', '2021-09-14 01:31:18', 1, 1);
INSERT INTO `client` VALUES (216, 'Jiang Jiehong', '838-981-5215', 'jiehongjia9@icloud.com', 199917, 508, '2023-10-10 13:02:58', '2012-08-20 22:44:40', 1, 1);
INSERT INTO `client` VALUES (217, 'Sharon Stevens', '(121) 771 4995', 'stevenssharon84@hotmail.com', 980248, 560, '2024-08-06 23:17:29', '2015-03-21 22:40:43', 2, 1);
INSERT INTO `client` VALUES (218, 'Li Lu', '(1223) 56 9509', 'li407@outlook.com', 722554, 0, '2004-01-08 11:06:36', '2009-03-04 14:45:05', 2, 0);
INSERT INTO `client` VALUES (219, 'Tse Ling Ling', '90-0110-2234', 'linglingtse04@gmail.com', 510750, 621, '2018-11-20 18:40:30', '2021-11-14 04:01:07', 2, 1);
INSERT INTO `client` VALUES (220, 'Morita Takuya', '755-7716-6527', 'takuyamorita@gmail.com', 930281, 525, '2016-03-12 15:36:05', '2011-07-30 09:52:35', 2, 0);
INSERT INTO `client` VALUES (221, 'Morita Mio', '168-0710-2776', 'miom@gmail.com', 126283, 706, '2020-04-12 12:27:49', '2016-07-03 15:51:40', 1, 1);
INSERT INTO `client` VALUES (222, 'Tin Fu Shing', '330-962-7462', 'fstin@outlook.com', 733246, 827, '2019-07-26 18:19:25', '2023-01-13 09:04:04', 1, 1);
INSERT INTO `client` VALUES (223, 'Ti Ka Man', '80-2284-7609', 'kamti@gmail.com', 712725, 323, '2014-11-16 08:33:04', '2019-01-15 09:35:54', 1, 1);
INSERT INTO `client` VALUES (224, 'Frances Martin', '312-314-7236', 'frances1006@outlook.com', 781426, 0, '2018-12-08 21:18:00', '2018-05-28 01:09:34', 1, 0);
INSERT INTO `client` VALUES (225, '廖安琪', '80-1336-9244', 'liaoanqi@gmail.com', 868686, 962, '2024-03-03 02:41:25', '2006-09-26 17:54:34', 1, 0);
INSERT INTO `client` VALUES (226, 'Yeow Kwok Yin', '143-5655-0474', 'yeowky44@gmail.com', 651844, 0, '2010-08-10 14:04:29', '2015-11-13 13:47:38', 2, 0);
INSERT INTO `client` VALUES (227, '毛嘉伦', '(1865) 31 0929', 'jialunmao@icloud.com', 352629, 496, '2006-01-25 01:04:35', '2017-05-07 09:18:35', 1, 1);
INSERT INTO `client` VALUES (228, 'Kong Ziyi', '769-0790-1462', 'zko@gmail.com', 495304, 0, '2011-12-08 11:55:23', '2004-01-22 12:19:07', 1, 0);
INSERT INTO `client` VALUES (229, '汪宇宁', '755-2467-8438', 'wayunin@outlook.com', 593272, 225, '2016-10-20 08:03:37', '2022-08-18 03:57:51', 2, 1);
INSERT INTO `client` VALUES (230, '唐宇宁', '74-959-9052', 'yuningta2004@icloud.com', 85935, 1005, '2001-10-09 19:00:41', '2021-09-17 00:20:23', 1, 1);
INSERT INTO `client` VALUES (231, '赵嘉伦', '74-677-0553', 'zhaojialun@gmail.com', 549984, 0, '2021-06-02 06:29:01', '2023-09-25 08:02:14', 1, 0);
INSERT INTO `client` VALUES (232, 'Lee Burns', '(1223) 44 1965', 'leebur@gmail.com', 267717, 326, '2019-08-25 07:53:25', '2012-04-06 02:00:08', 1, 1);
INSERT INTO `client` VALUES (233, 'Inoue Yamato', '197-0669-8542', 'yamatoino89@gmail.com', 607440, 0, '2010-10-27 04:03:36', '2006-03-12 06:04:30', 1, 0);
INSERT INTO `client` VALUES (234, '石子韬', '838-324-0374', 'shizitao58@gmail.com', 157312, 0, '2008-07-06 01:34:59', '2000-05-05 15:23:06', 1, 0);
INSERT INTO `client` VALUES (235, 'Ogawa Takuya', '312-481-3036', 'taogaw314@mail.com', 315862, 248, '2022-06-04 06:01:27', '2000-08-31 10:03:36', 1, 1);
INSERT INTO `client` VALUES (236, 'Hao Lu', '5377 504833', 'luhao1977@outlook.com', 811384, 724, '2018-08-25 20:37:15', '2012-04-20 19:58:14', 1, 1);
INSERT INTO `client` VALUES (237, '董宇宁', '66-308-9156', 'ydon204@mail.com', 707002, 1172, '2006-06-28 12:24:28', '2020-04-11 10:04:40', 1, 1);
INSERT INTO `client` VALUES (238, 'Wei Rui', '196-5883-4718', 'ruiw1996@mail.com', 65005, 969, '2017-03-15 22:51:38', '2011-11-06 03:13:46', 1, 0);
INSERT INTO `client` VALUES (239, 'Long Lu', '7489 478423', 'longlu@gmail.com', 153653, 829, '2023-01-06 18:12:33', '2019-07-12 15:07:02', 1, 1);
INSERT INTO `client` VALUES (240, 'Sugiyama Hina', '3-3133-3961', 'hsugi@outlook.com', 426056, 0, '2006-04-24 08:40:26', '2000-01-12 18:27:45', 1, 0);
INSERT INTO `client` VALUES (241, '向安琪', '21-783-3595', 'anqixiang@gmail.com', 631290, 872, '2002-02-10 06:30:48', '2017-09-06 22:35:40', 2, 0);
INSERT INTO `client` VALUES (242, 'Siu Chi Yuen', '(151) 551 7483', 'chiyuen8@gmail.com', 153678, 568, '2010-09-21 10:41:43', '2022-08-20 02:42:56', 1, 1);
INSERT INTO `client` VALUES (243, 'Theodore Ramirez', '(121) 245 6679', 'theodoreram701@yahoo.com', 625937, 291, '2024-06-18 21:43:25', '2001-08-09 19:09:54', 1, 1);
INSERT INTO `client` VALUES (244, 'Justin Ruiz', '11-502-8552', 'ruizjustin5@outlook.com', 205487, 646, '2010-03-20 09:11:42', '2023-03-20 04:55:57', 1, 1);
INSERT INTO `client` VALUES (245, '汪晓明', '312-657-9872', 'xiaomingwan@gmail.com', 888757, 209, '2011-11-24 05:39:03', '2008-12-22 12:18:30', 2, 0);
INSERT INTO `client` VALUES (246, 'Zhou Lu', '139-6791-1844', 'luz@yahoo.com', 418523, 317, '2003-05-24 00:25:17', '2017-12-08 10:17:50', 2, 1);
INSERT INTO `client` VALUES (247, 'Wu On Kay', '614-065-6252', 'okw515@gmail.com', 106536, 423, '2020-08-02 23:30:28', '2019-03-26 19:13:25', 1, 1);
INSERT INTO `client` VALUES (248, 'Mike Wood', '3-0230-5939', 'mikewoo@yahoo.com', 804514, 0, '2017-01-02 11:15:08', '2021-02-15 03:04:39', 1, 0);
INSERT INTO `client` VALUES (249, 'Rhonda Gomez', '614-456-8526', 'rhondagom1946@outlook.com', 150058, 800, '2003-12-06 11:17:31', '2011-10-20 09:50:57', 2, 0);
INSERT INTO `client` VALUES (250, 'Yuen Tsz Hin', '134-2293-4790', 'tszhiyuen1014@icloud.com', 391330, 0, '2021-01-29 02:37:47', '2005-01-14 22:35:02', 2, 0);
INSERT INTO `client` VALUES (251, 'Marie Shaw', '212-989-6079', 'smari@gmail.com', 402499, 0, '2020-01-21 09:32:38', '2001-03-12 12:25:02', 1, 0);
INSERT INTO `client` VALUES (252, 'Jin Lu', '(151) 154 7128', 'jinlu@gmail.com', 819569, 0, '2004-03-13 03:03:52', '2000-09-14 20:35:52', 1, 0);
INSERT INTO `client` VALUES (253, 'Kojima Daisuke', '74-513-2291', 'kdaisuke@outlook.com', 599554, 392, '2016-06-29 09:23:40', '2012-06-01 05:29:14', 1, 0);
INSERT INTO `client` VALUES (254, 'Ishida Itsuki', '7510 092801', 'ishida109@gmail.com', 187621, 0, '2009-06-12 01:54:19', '2003-11-08 11:47:52', 2, 0);
INSERT INTO `client` VALUES (255, 'Noguchi Sakura', '7684 699757', 'noguchisakur@outlook.com', 53153, 829, '2023-11-18 00:20:27', '2000-11-20 00:42:31', 0, 1);
INSERT INTO `client` VALUES (256, 'Xiao Rui', '212-721-6208', 'ruixiao927@hotmail.com', 783397, 820, '2018-05-02 03:21:51', '2002-07-26 16:42:22', 1, 1);
INSERT INTO `client` VALUES (257, 'Tang Tin Lok', '(1865) 38 9057', 'tinlta819@outlook.com', 427907, 1162, '2008-09-25 08:54:38', '2003-06-09 09:36:46', 2, 0);
INSERT INTO `client` VALUES (258, 'Che On Kay', '90-8454-6388', 'cok10@gmail.com', 383814, 909, '2015-05-31 11:22:50', '2004-04-17 03:21:42', 0, 1);
INSERT INTO `client` VALUES (259, 'Xue Ziyi', '138-4400-0799', 'zixu@gmail.com', 258036, 1117, '2004-04-26 14:11:58', '2006-10-20 17:34:01', 1, 0);
INSERT INTO `client` VALUES (260, '武睿', '212-564-2349', 'ruwu@icloud.com', 103051, 1142, '2016-04-04 07:53:29', '2022-02-06 16:37:19', 2, 0);
INSERT INTO `client` VALUES (261, '杨秀英', '213-080-1138', 'yangxiuy@icloud.com', 783071, 382, '2010-09-04 21:02:12', '2013-03-13 04:58:26', 1, 1);
INSERT INTO `client` VALUES (262, 'Thelma Medina', '213-462-8416', 'thelmame@icloud.com', 364251, 445, '2004-12-02 14:38:03', '2016-03-28 14:51:55', 1, 1);
INSERT INTO `client` VALUES (263, '钟璐', '90-0741-8999', 'lzhong8@icloud.com', 757635, 343, '2013-04-12 22:50:53', '2024-09-08 12:35:11', 1, 1);
INSERT INTO `client` VALUES (264, 'Yin Yunxi', '838-795-3468', 'yiny@outlook.com', 492907, 0, '2013-10-06 14:46:04', '2004-03-18 08:31:48', 1, 0);
INSERT INTO `client` VALUES (265, 'Kojima Hazuki', '(116) 407 0996', 'kojima1@mail.com', 152900, 1023, '2002-12-26 22:47:07', '2002-10-21 03:56:53', 0, 0);
INSERT INTO `client` VALUES (266, '谭睿', '90-2652-6058', 'tar@icloud.com', 362978, 417, '2023-08-08 19:29:37', '2009-11-03 08:51:45', 0, 1);
INSERT INTO `client` VALUES (267, 'Russell King', '11-996-9183', 'ruking@icloud.com', 595917, 1168, '2017-03-13 10:11:13', '2008-09-28 16:07:30', 0, 1);
INSERT INTO `client` VALUES (268, 'Randall Freeman', '52-435-7889', 'randallfreeman@gmail.com', 496015, 510, '2020-10-12 02:57:09', '2020-08-13 23:06:44', 2, 0);
INSERT INTO `client` VALUES (269, '杜睿', '11-888-9963', 'durui@outlook.com', 62117, 0, '2022-11-29 21:51:51', '2001-03-05 04:47:38', 0, 0);
INSERT INTO `client` VALUES (270, 'Zhao Rui', '(121) 315 1616', 'zhaorui519@icloud.com', 808472, 856, '2005-02-08 13:36:49', '2005-05-10 23:11:27', 1, 1);
INSERT INTO `client` VALUES (271, 'Jiang Yunxi', '70-8171-3630', 'jiangyunxi1967@gmail.com', 717690, 1171, '2013-06-17 15:45:32', '2007-07-16 19:51:40', 0, 1);
INSERT INTO `client` VALUES (272, 'Lin Anqi', '838-521-1124', 'anqi03@outlook.com', 125287, 0, '2019-07-14 14:32:00', '2001-08-16 02:43:22', 2, 0);
INSERT INTO `client` VALUES (273, 'Jesus Cooper', '7438 713378', 'jesus90@outlook.com', 638353, 645, '2019-09-23 02:50:25', '2008-10-21 01:55:46', 1, 0);
INSERT INTO `client` VALUES (274, 'Dai Yunxi', '66-343-8976', 'yunxidai8@icloud.com', 675001, 1143, '2002-09-26 06:12:49', '2024-12-16 16:11:01', 0, 0);
INSERT INTO `client` VALUES (275, 'Russell Ryan', '74-883-8438', 'rryan6@gmail.com', 826020, 684, '2005-03-17 07:54:40', '2003-05-26 17:45:02', 1, 1);
INSERT INTO `client` VALUES (276, 'Su Lan', '755-444-9998', 'lsu1223@yahoo.com', 831404, 418, '2014-05-23 10:21:29', '2007-03-30 17:47:32', 1, 0);
INSERT INTO `client` VALUES (277, 'Loui Ho Yin', '145-4004-7780', 'louihoyi8@yahoo.com', 106234, 1099, '2009-12-23 15:29:26', '2008-08-10 07:09:52', 2, 1);
INSERT INTO `client` VALUES (278, 'Liao Siu Wai', '769-6316-9025', 'swliao1977@outlook.com', 768993, 394, '2011-05-15 00:10:36', '2005-05-10 11:56:06', 1, 1);
INSERT INTO `client` VALUES (279, 'Fujii Hana', '614-826-0225', 'hfujii@icloud.com', 457959, 289, '2001-09-09 08:25:53', '2004-09-14 02:51:55', 2, 1);
INSERT INTO `client` VALUES (280, '宋晓明', '182-9212-2419', 'xiaosong@gmail.com', 429945, 516, '2008-12-10 08:21:55', '2008-12-28 15:30:22', 1, 1);
INSERT INTO `client` VALUES (281, 'Martin Taylor', '838-871-4080', 'taymartin95@gmail.com', 509971, 406, '2004-06-10 17:16:26', '2022-10-29 02:27:57', 0, 1);
INSERT INTO `client` VALUES (282, 'Tao Wing Sze', '138-0028-7050', 'taws@outlook.com', 161835, 0, '2016-01-18 21:47:38', '2014-12-29 18:27:30', 1, 0);
INSERT INTO `client` VALUES (283, 'Shannon Cruz', '718-337-0929', 'shacruz@gmail.com', 178565, 782, '2003-09-27 07:38:01', '2012-07-24 10:03:13', 1, 0);
INSERT INTO `client` VALUES (284, 'Sano Seiko', '(1223) 04 1799', 'seikos@gmail.com', 874608, 610, '2001-11-29 23:09:56', '2018-07-06 19:17:26', 2, 1);
INSERT INTO `client` VALUES (285, 'Hou Xiuying', '212-716-7214', 'houxiuyi1988@gmail.com', 42391, 893, '2015-12-30 17:33:00', '2001-11-02 16:31:34', 1, 0);
INSERT INTO `client` VALUES (286, 'Eva Salazar', '74-745-6984', 'seva4@outlook.com', 87114, 501, '2024-12-13 20:04:27', '2006-10-22 00:06:19', 2, 1);
INSERT INTO `client` VALUES (287, 'Liang Zitao', '718-709-8349', 'liangzitao20@outlook.com', 790042, 483, '2007-01-05 11:56:58', '2016-07-18 04:05:22', 0, 0);
INSERT INTO `client` VALUES (288, 'Brian Wilson', '139-5722-1369', 'wilsonbr5@mail.com', 555620, 0, '2006-04-28 15:20:15', '2018-12-28 20:26:06', 2, 0);
INSERT INTO `client` VALUES (289, 'Yuan Lu', '20-2314-4790', 'lu66@outlook.com', 925871, 0, '2017-06-01 05:06:19', '2015-06-20 18:58:08', 0, 0);
INSERT INTO `client` VALUES (290, '彭詩涵', '21-1692-4056', 'pengs5@outlook.com', 673071, 1193, '2019-06-27 13:18:10', '2007-02-25 06:17:16', 2, 1);
INSERT INTO `client` VALUES (291, 'Masuda Shino', '330-291-2166', 'masudshino@icloud.com', 485268, 1172, '2006-12-28 21:35:27', '2015-03-23 21:58:11', 1, 1);
INSERT INTO `client` VALUES (292, 'Aoki Rin', '7146 330124', 'rinaoki@icloud.com', 926957, 387, '2019-09-25 12:55:02', '2001-09-07 18:55:05', 2, 0);
INSERT INTO `client` VALUES (293, 'Tang Rui', '769-0579-5024', 'tang41@gmail.com', 720080, 1139, '2007-01-09 21:57:26', '2008-07-17 03:33:58', 2, 1);
INSERT INTO `client` VALUES (294, 'Chiba Hikari', '28-000-0092', 'hikari09@outlook.com', 471213, 0, '2010-11-03 19:17:01', '2019-05-14 20:01:22', 0, 0);
INSERT INTO `client` VALUES (295, 'He Ziyi', '74-876-6563', 'ziyihe1@icloud.com', 75163, 298, '2006-03-25 19:23:13', '2013-01-16 01:01:06', 1, 0);
INSERT INTO `client` VALUES (296, '汪晓明', '66-346-7882', 'wang56@hotmail.com', 332491, 470, '2012-09-03 07:22:52', '2018-10-15 08:50:24', 1, 1);
INSERT INTO `client` VALUES (297, 'Ti Tsz Hin', '614-427-7079', 'thti@outlook.com', 73520, 826, '2013-09-21 05:07:00', '2004-05-10 06:24:41', 0, 1);
INSERT INTO `client` VALUES (298, 'Zheng Yunxi', '312-207-0275', 'yunxizheng@icloud.com', 740738, 301, '2021-01-12 19:44:41', '2006-10-19 02:25:53', 0, 1);
INSERT INTO `client` VALUES (299, 'Sheila Thomas', '838-885-0280', 'thomas7@icloud.com', 247579, 0, '2012-12-11 23:02:09', '2014-10-31 02:24:43', 1, 0);
INSERT INTO `client` VALUES (300, 'Wayne Henderson', '7941 071489', 'wayne7@icloud.com', 457101, 837, '2024-07-11 16:52:56', '2014-11-28 14:13:30', 2, 0);
INSERT INTO `client` VALUES (301, 'Gary Campbell', '90-5693-3456', 'campbgar@icloud.com', 581734, 352, '2007-07-22 07:27:35', '2024-01-31 03:30:13', 1, 1);
INSERT INTO `client` VALUES (302, 'Alice Sullivan', '330-026-4206', 'salice@outlook.com', 151540, 1072, '2011-01-27 11:15:22', '2020-05-14 23:19:29', 1, 0);
INSERT INTO `client` VALUES (303, 'Okada Ren', '80-2358-9901', 'ren1@mail.com', 607128, 1065, '2013-02-01 18:42:12', '2009-09-11 04:03:21', 0, 1);
INSERT INTO `client` VALUES (304, '陶子韬', '20-087-6537', 'zta4@icloud.com', 653914, 0, '2006-09-18 02:25:50', '2005-01-19 18:46:23', 1, 0);
INSERT INTO `client` VALUES (305, '黄璐', '160-8822-1036', 'huanglu@icloud.com', 938745, 819, '2016-01-02 20:41:21', '2014-05-31 21:05:04', 1, 1);
INSERT INTO `client` VALUES (306, 'Hui Wai Lam', '(121) 993 3084', 'huiwl78@outlook.com', 37540, 1185, '2015-08-02 01:14:35', '2022-02-06 18:45:35', 2, 0);
INSERT INTO `client` VALUES (307, 'George Rivera', '5368 843135', 'riverage1@gmail.com', 272166, 976, '2001-05-19 03:13:20', '2002-11-16 00:31:04', 2, 1);
INSERT INTO `client` VALUES (308, 'Leonard Ellis', '755-3544-2101', 'ellisleonard6@outlook.com', 499363, 330, '2018-10-12 15:49:09', '2014-10-07 19:07:28', 1, 1);
INSERT INTO `client` VALUES (309, 'Chiang Ka Fai', '755-0004-8473', 'kafai1@gmail.com', 53769, 806, '2020-07-26 04:18:24', '2013-08-02 13:40:27', 1, 1);
INSERT INTO `client` VALUES (310, 'Lee Cho Yee', '718-457-1863', 'cyle00@gmail.com', 481981, 702, '2010-05-12 03:31:46', '2008-07-04 11:37:05', 2, 1);
INSERT INTO `client` VALUES (311, '邱震南', '66-841-7733', 'qiuzhe@gmail.com', 654467, 1003, '2016-08-22 05:12:23', '2006-09-26 12:03:29', 0, 0);
INSERT INTO `client` VALUES (312, 'Xiang Ziyi', '66-216-2737', 'zxia@icloud.com', 44444, 1174, '2018-09-22 09:41:01', '2005-08-21 00:27:55', 1, 0);
INSERT INTO `client` VALUES (313, 'Rebecca Weaver', '90-7116-0918', 'rebeccaweaver@icloud.com', 25827, 874, '2000-05-20 01:33:07', '2020-06-23 14:54:18', 1, 0);
INSERT INTO `client` VALUES (314, 'Sheh Wai Lam', '21-980-9625', 'wailams104@gmail.com', 663284, 701, '2021-11-13 14:07:25', '2021-04-12 23:56:24', 1, 0);
INSERT INTO `client` VALUES (315, 'Cai Yunxi', '138-9379-7978', 'caiy@hotmail.com', 687858, 945, '2007-06-23 22:21:13', '2004-08-06 10:42:46', 0, 1);
INSERT INTO `client` VALUES (316, 'Ryan Weaver', '70-9545-3310', 'weaverryan@yahoo.com', 461337, 6, '2013-06-07 11:39:54', '2020-01-29 01:59:51', 1, 1);
INSERT INTO `client` VALUES (317, '董晓明', '(121) 946 9124', 'xiaomingdo@hotmail.com', 263621, 670, '2003-01-17 04:06:14', '2005-05-28 09:53:28', 1, 1);
INSERT INTO `client` VALUES (318, '钱子异', '66-321-6684', 'zq3@hotmail.com', 85720, 367, '2015-01-17 04:03:09', '2019-12-15 16:39:53', 1, 0);
INSERT INTO `client` VALUES (319, 'Linda Campbell', '180-0194-6080', 'lindac@gmail.com', 8128, 1168, '2016-06-26 09:41:57', '2024-07-31 15:16:54', 0, 0);
INSERT INTO `client` VALUES (320, 'Luo Shihan', '312-367-0168', 'luoshihan06@gmail.com', 721886, 1093, '2000-10-19 00:14:42', '2002-06-08 00:09:45', 2, 1);
INSERT INTO `client` VALUES (321, 'Raymond Woods', '7198 956840', 'rw9@hotmail.com', 121242, 1095, '2000-01-09 08:18:39', '2021-04-20 20:08:24', 2, 0);
INSERT INTO `client` VALUES (322, 'Fang Yuning', '66-011-1894', 'fang722@outlook.com', 225315, 0, '2008-06-29 13:40:50', '2004-02-11 01:22:15', 1, 0);
INSERT INTO `client` VALUES (323, 'Shimada Ayato', '10-2521-7452', 'shimada2@icloud.com', 979744, 1136, '2004-05-30 02:29:24', '2015-01-13 07:00:34', 0, 0);
INSERT INTO `client` VALUES (324, 'Ueda Mitsuki', '838-869-6034', 'uedam8@gmail.com', 965415, 780, '2009-11-21 00:23:06', '2010-08-16 16:15:15', 1, 1);
INSERT INTO `client` VALUES (325, 'Danielle Fernandez', '212-769-1960', 'ferdanielle@gmail.com', 712559, 857, '2010-10-28 05:57:41', '2021-07-28 03:53:38', 2, 1);
INSERT INTO `client` VALUES (326, 'Edith Hill', '195-3791-0533', 'hedith818@icloud.com', 669446, 1088, '2008-08-10 09:49:19', '2020-06-01 20:24:41', 1, 1);
INSERT INTO `client` VALUES (327, 'Lori Perez', '52-151-9136', 'lope1231@outlook.com', 874266, 511, '2022-06-02 22:19:25', '2019-09-07 18:56:45', 2, 1);
INSERT INTO `client` VALUES (328, '傅子异', '66-036-7265', 'fuz1@outlook.com', 787344, 618, '2023-04-11 04:48:26', '2022-01-07 10:38:40', 2, 0);
INSERT INTO `client` VALUES (329, 'Fred Mitchell', '20-966-7690', 'mitchfre6@outlook.com', 726531, 1017, '2013-08-07 15:54:23', '2024-11-09 08:51:56', 2, 0);
INSERT INTO `client` VALUES (330, 'Taniguchi Misaki', '74-211-2886', 'tanimisak@outlook.com', 85091, 263, '2013-08-05 13:45:48', '2023-03-06 09:11:42', 1, 0);
INSERT INTO `client` VALUES (331, 'Shimizu Kasumi', '769-217-6461', 'kasushi6@icloud.com', 297564, 449, '2019-04-07 21:26:52', '2001-04-21 12:32:47', 2, 1);
INSERT INTO `client` VALUES (332, 'Shao Zitao', '(1223) 78 0021', 'szi@icloud.com', 339626, 0, '2023-08-12 06:57:30', '2012-02-16 19:22:56', 0, 0);
INSERT INTO `client` VALUES (333, '崔詩涵', '90-8216-4775', 'shihancu723@yahoo.com', 168775, 971, '2003-01-15 15:19:54', '2005-08-23 02:10:14', 1, 0);
INSERT INTO `client` VALUES (334, 'Christine Wood', '7508 914726', 'chriswood@mail.com', 851054, 1193, '2023-04-22 07:50:00', '2017-01-15 09:23:20', 1, 1);
INSERT INTO `client` VALUES (335, 'Theresa Smith', '198-5713-7042', 'tsmi@icloud.com', 966843, 0, '2015-08-28 19:22:59', '2015-01-21 22:56:24', 1, 0);
INSERT INTO `client` VALUES (336, 'Nakajima Mio', '80-2964-6653', 'mio82@outlook.com', 553890, 277, '2010-04-22 00:29:46', '2015-01-26 18:43:12', 1, 0);
INSERT INTO `client` VALUES (337, 'Hashimoto Yuna', '760-954-5004', 'hayuna@hotmail.com', 38040, 836, '2007-11-11 04:47:59', '2003-07-01 08:40:56', 1, 0);
INSERT INTO `client` VALUES (338, 'Rita Long', '52-437-8947', 'rita624@gmail.com', 989812, 1067, '2013-05-26 15:45:28', '2005-04-09 14:32:07', 1, 0);
INSERT INTO `client` VALUES (339, 'Andrew Campbell', '147-8256-8278', 'camandrew922@outlook.com', 515030, 671, '2003-03-06 20:16:15', '2018-10-27 01:25:26', 1, 0);
INSERT INTO `client` VALUES (340, 'Bonnie Romero', '146-7603-8849', 'bonnie1941@outlook.com', 11084, 430, '2009-08-09 11:38:04', '2002-01-29 17:21:08', 1, 0);
INSERT INTO `client` VALUES (341, '黄璐', '614-826-0257', 'lhuang@icloud.com', 233872, 660, '2011-06-06 21:41:07', '2013-07-11 19:08:25', 1, 1);
INSERT INTO `client` VALUES (342, 'Mao Zitao', '213-835-5292', 'zitao10@outlook.com', 129615, 0, '2023-06-11 16:38:03', '2015-03-11 06:45:19', 2, 0);
INSERT INTO `client` VALUES (343, 'Yuan Rui', '28-908-1564', 'yuan414@gmail.com', 714436, 0, '2021-05-04 19:20:07', '2002-08-24 06:24:23', 1, 0);
INSERT INTO `client` VALUES (344, '苏杰宏', '330-669-0193', 'sujieho@outlook.com', 768440, 540, '2019-05-26 23:34:32', '2008-10-03 18:07:49', 2, 1);
INSERT INTO `client` VALUES (345, 'Emma Murray', '330-305-2428', 'murraemma1984@yahoo.com', 399316, 401, '2009-07-03 22:23:34', '2018-04-23 13:42:42', 0, 0);
INSERT INTO `client` VALUES (346, '薛子异', '312-690-4392', 'zxue711@yahoo.com', 519972, 0, '2024-05-17 09:09:59', '2008-07-05 08:50:28', 1, 0);
INSERT INTO `client` VALUES (347, '邹杰宏', '7174 729665', 'jiezou2@outlook.com', 932962, 1066, '2008-01-18 04:16:39', '2006-12-01 03:45:03', 1, 0);
INSERT INTO `client` VALUES (348, 'Lei Jiehong', '7178 833970', 'jiehong1@gmail.com', 20687, 817, '2014-04-13 12:46:13', '2006-03-05 15:11:15', 1, 0);
INSERT INTO `client` VALUES (349, 'Juan Marshall', '755-040-7410', 'mjuan126@mail.com', 935094, 657, '2010-08-16 13:48:04', '2011-08-07 11:04:30', 1, 0);
INSERT INTO `client` VALUES (350, 'Fu Ka Fai', '7768 325527', 'fuka@gmail.com', 501848, 486, '2010-03-29 03:05:55', '2011-08-11 10:32:40', 0, 1);
INSERT INTO `client` VALUES (351, 'Hasegawa Daichi', '7931 575078', 'hdaichi@outlook.com', 295757, 223, '2024-08-10 06:28:02', '2013-06-10 04:16:33', 1, 1);
INSERT INTO `client` VALUES (352, 'Otsuka Ryota', '70-4248-7983', 'ryotsu@gmail.com', 463097, 773, '2001-05-04 01:05:54', '2015-11-30 01:05:11', 2, 1);
INSERT INTO `client` VALUES (353, 'Cai Jiehong', '838-373-5019', 'cji6@gmail.com', 608866, 448, '2004-09-09 05:07:58', '2006-04-15 05:52:26', 0, 1);
INSERT INTO `client` VALUES (354, '薛嘉伦', '(116) 470 5829', 'xuej@icloud.com', 198838, 0, '2021-09-09 12:21:43', '2024-10-09 05:37:11', 1, 0);
INSERT INTO `client` VALUES (355, 'Wu Hok Yau', '(161) 094 8811', 'wuho@hotmail.com', 442913, 0, '2004-09-28 21:20:28', '2003-02-04 08:45:55', 2, 0);
INSERT INTO `client` VALUES (356, 'Koyama Momoka', '90-0148-2479', 'momokakoyama@gmail.com', 323545, 913, '2003-04-19 18:22:18', '2004-06-07 17:38:46', 1, 1);
INSERT INTO `client` VALUES (357, 'Lo Tsz Ching', '614-996-3793', 'lotc@hotmail.com', 275062, 479, '2009-09-20 17:44:53', '2023-01-31 13:04:00', 2, 1);
INSERT INTO `client` VALUES (358, 'Heung On Na', '66-399-7473', 'heuonna@gmail.com', 2692, 1081, '2013-05-15 15:14:21', '2010-02-27 06:54:57', 1, 1);
INSERT INTO `client` VALUES (359, 'Hao Ziyi', '74-808-1355', 'ziyih@mail.com', 389593, 293, '2002-10-12 12:50:38', '2007-07-28 07:11:50', 0, 1);
INSERT INTO `client` VALUES (360, '廖璐', '133-5634-7096', 'liao07@gmail.com', 909416, 959, '2024-04-27 00:26:35', '2001-01-08 07:39:18', 1, 1);
INSERT INTO `client` VALUES (361, '孙子异', '28-8851-0375', 'ziyi41@gmail.com', 15283, 989, '2001-07-29 23:47:29', '2004-09-20 21:35:32', 0, 1);
INSERT INTO `client` VALUES (362, 'Kimura Aoshi', '7958 371041', 'kimaos@icloud.com', 430842, 836, '2005-06-01 08:00:51', '2009-05-12 03:44:33', 1, 1);
INSERT INTO `client` VALUES (363, '孟子异', '90-1377-6041', 'menzi@gmail.com', 153546, 1094, '2023-02-17 13:45:46', '2004-08-23 15:53:18', 1, 0);
INSERT INTO `client` VALUES (364, 'Tang Zhennan', '66-081-4658', 'tanzhenn@hotmail.com', 729223, 298, '2011-02-18 21:04:31', '2014-10-30 16:23:46', 1, 1);
INSERT INTO `client` VALUES (365, '郑震南', '213-659-6731', 'zhzhe@gmail.com', 456685, 0, '2018-08-05 22:23:08', '2017-08-30 23:42:20', 1, 0);
INSERT INTO `client` VALUES (366, '廖云熙', '90-8736-6302', 'yunxil@outlook.com', 656187, 0, '2014-07-11 01:32:20', '2002-12-20 20:27:53', 1, 0);
INSERT INTO `client` VALUES (367, '傅致远', '70-0398-4689', 'zhiyuanfu@gmail.com', 43254, 1023, '2014-03-31 18:48:53', '2015-10-23 09:39:39', 1, 1);
INSERT INTO `client` VALUES (368, 'Kwok Tsz Hin', '160-9445-5411', 'thkwok@icloud.com', 436867, 297, '2024-09-14 03:16:09', '2020-12-26 04:40:58', 1, 1);
INSERT INTO `client` VALUES (369, '孔岚', '(121) 404 0219', 'lankong@outlook.com', 518303, 1092, '2001-12-04 20:14:51', '2017-05-29 17:02:24', 1, 1);
INSERT INTO `client` VALUES (370, '韩宇宁', '90-6538-2730', 'yunihan1958@gmail.com', 216046, 866, '2003-02-14 00:40:08', '2009-09-21 00:56:32', 2, 0);
INSERT INTO `client` VALUES (371, 'Elizabeth Richardson', '70-0132-5649', 'relizabeth@mail.com', 397752, 395, '2024-07-26 05:34:15', '2022-06-05 10:10:00', 1, 1);
INSERT INTO `client` VALUES (372, 'Arai Takuya', '213-183-9070', 'at1@yahoo.com', 228982, 0, '2010-03-13 12:44:17', '2003-07-10 23:37:28', 0, 0);
INSERT INTO `client` VALUES (373, '史岚', '(161) 769 0850', 'lan94@gmail.com', 266537, 1129, '2021-09-01 09:57:37', '2021-06-25 14:21:04', 1, 0);
INSERT INTO `client` VALUES (374, '曾震南', '(1865) 78 6581', 'zenzhennan@icloud.com', 855300, 0, '2007-03-10 15:50:40', '2021-03-19 14:55:28', 1, 0);
INSERT INTO `client` VALUES (375, 'Watanabe Yamato', '20-509-9635', 'watay@outlook.com', 208169, 0, '2004-09-02 12:14:13', '2012-01-10 12:10:23', 1, 0);
INSERT INTO `client` VALUES (376, 'Ma Yuning', '(20) 5941 7303', 'yuninma@gmail.com', 278531, 255, '2011-04-11 19:39:50', '2022-11-05 18:01:36', 2, 0);
INSERT INTO `client` VALUES (377, 'Hazel Warren', '21-367-1822', 'hwa@icloud.com', 418154, 801, '2013-06-03 12:08:10', '2012-11-27 09:32:10', 0, 1);
INSERT INTO `client` VALUES (378, 'Zhu Zitao', '5934 970317', 'zitaozhu10@mail.com', 945824, 462, '2012-06-05 06:54:52', '2020-06-03 07:28:18', 0, 1);
INSERT INTO `client` VALUES (379, 'Xu Jiehong', '330-811-0785', 'jiehongxu4@gmail.com', 591642, 1170, '2022-06-28 10:22:31', '2024-11-14 23:19:32', 1, 0);
INSERT INTO `client` VALUES (380, '何子韬', '5656 540386', 'hzitao@gmail.com', 683028, 0, '2016-09-10 02:48:41', '2018-07-29 22:17:06', 0, 0);
INSERT INTO `client` VALUES (381, 'Tanaka Ayano', '11-558-4310', 'ayano46@gmail.com', 674520, 0, '2008-01-11 18:35:50', '2013-07-29 13:23:30', 0, 0);
INSERT INTO `client` VALUES (382, '雷致远', '90-5431-6277', 'lzhiyu99@mail.com', 867807, 376, '2002-01-12 00:22:01', '2015-03-07 17:58:17', 0, 0);
INSERT INTO `client` VALUES (383, 'Sun Zhennan', '90-2726-9569', 'zsun@gmail.com', 816186, 0, '2018-10-01 07:13:19', '2018-09-20 23:29:02', 0, 0);
INSERT INTO `client` VALUES (384, 'Roger Rose', '66-655-8206', 'rogerr1130@gmail.com', 36825, 605, '2008-04-20 20:31:36', '2013-09-01 22:12:09', 0, 1);
INSERT INTO `client` VALUES (385, 'Cheng Suk Yee', '90-5556-7156', 'chengsukyee@gmail.com', 734866, 653, '2015-09-18 13:52:54', '2023-03-22 21:03:53', 2, 1);
INSERT INTO `client` VALUES (386, 'Xu Lu', '20-744-1934', 'xulu@icloud.com', 404535, 1130, '2006-08-03 07:28:28', '2016-05-29 06:57:32', 0, 1);
INSERT INTO `client` VALUES (387, '余詩涵', '5171 627932', 'yush@gmail.com', 293695, 1129, '2008-05-06 10:57:54', '2008-10-02 02:12:30', 1, 1);
INSERT INTO `client` VALUES (388, '蔡岚', '10-3989-9037', 'cai3@gmail.com', 799198, 0, '2012-10-13 07:14:14', '2013-01-10 02:52:00', 1, 0);
INSERT INTO `client` VALUES (389, 'Ueda Yuna', '181-9205-0575', 'uedy5@gmail.com', 835181, 1097, '2009-06-10 10:09:49', '2018-08-09 16:41:06', 2, 0);
INSERT INTO `client` VALUES (390, 'Xia Anqi', '20-8663-1726', 'anqixia421@icloud.com', 118959, 1151, '2007-02-27 03:57:02', '2009-04-29 17:17:33', 0, 0);
INSERT INTO `client` VALUES (391, 'Fan Zhennan', '74-617-4103', 'zhennanfan611@gmail.com', 721826, 0, '2021-03-20 16:04:57', '2012-09-19 07:23:28', 1, 0);
INSERT INTO `client` VALUES (392, '顾子韬', '(1223) 16 4460', 'guzitao65@gmail.com', 620815, 0, '2015-04-01 03:56:42', '2015-11-12 11:33:07', 1, 0);
INSERT INTO `client` VALUES (393, '侯安琪', '213-046-4007', 'han@mail.com', 743125, 206, '2005-03-22 04:01:08', '2005-08-26 17:09:44', 0, 1);
INSERT INTO `client` VALUES (394, 'Lam Yu Ling', '52-731-4851', 'yuling7@mail.com', 897090, 1066, '2019-04-02 11:12:32', '2006-02-26 02:54:50', 1, 1);
INSERT INTO `client` VALUES (395, 'Wu Jiehong', '755-4842-1925', 'wu2002@icloud.com', 619389, 0, '2013-06-18 11:52:32', '2012-09-03 08:26:41', 2, 0);
INSERT INTO `client` VALUES (396, 'Kaneko Yota', '66-513-3834', 'yotak1@icloud.com', 638609, 578, '2024-07-02 19:00:12', '2001-07-07 09:59:33', 1, 0);
INSERT INTO `client` VALUES (397, 'Herbert Sullivan', '5531 970938', 'sullivanh809@icloud.com', 378648, 1057, '2010-08-03 07:06:59', '2019-08-31 20:48:20', 0, 0);
INSERT INTO `client` VALUES (398, 'Lo Ka Man', '212-983-2787', 'lokaman@gmail.com', 907223, 427, '2011-11-19 07:22:16', '2010-08-03 07:12:21', 1, 1);
INSERT INTO `client` VALUES (399, 'Tang Shihan', '162-3604-6220', 'tashihan4@outlook.com', 77947, 0, '2009-10-19 21:40:22', '2022-09-02 11:56:17', 1, 0);
INSERT INTO `client` VALUES (400, '贾晓明', '90-2593-3549', 'xiaoming4@outlook.com', 781349, 285, '2019-10-07 05:04:11', '2022-04-05 08:42:56', 1, 1);
INSERT INTO `client` VALUES (401, '龚嘉伦', '(20) 1547 5019', 'gojialun1212@outlook.com', 750908, 487, '2013-11-09 10:45:50', '2024-05-06 04:17:06', 1, 0);
INSERT INTO `client` VALUES (402, 'Diana Wood', '153-2802-9456', 'dianawood@outlook.com', 296101, 1126, '2017-03-03 22:26:04', '2019-10-07 10:12:05', 1, 1);
INSERT INTO `client` VALUES (403, '汪璐', '(1865) 06 8563', 'luw@gmail.com', 992472, 971, '2009-03-09 13:42:57', '2013-06-28 02:38:21', 1, 1);
INSERT INTO `client` VALUES (404, 'Tong Lik Sun', '760-526-5026', 'tongls513@yahoo.com', 823577, 1173, '2011-08-23 19:59:10', '2016-05-31 22:07:07', 1, 1);
INSERT INTO `client` VALUES (405, 'Patrick Gonzales', '760-3686-7368', 'gp626@hotmail.com', 85582, 971, '2014-07-15 10:32:39', '2016-07-27 18:43:50', 1, 1);
INSERT INTO `client` VALUES (406, 'Hu Xiuying', '21-757-3299', 'hu1@gmail.com', 147725, 365, '2003-11-18 05:41:09', '2009-01-12 03:19:14', 2, 1);
INSERT INTO `client` VALUES (407, 'Tam Sze Yu', '5501 032355', 'tam3@gmail.com', 831615, 234, '2005-06-14 07:38:22', '2003-03-16 22:32:50', 0, 1);
INSERT INTO `client` VALUES (408, 'Lo Tak Wah', '838-177-2400', 'takwahlo@outlook.com', 97406, 1140, '2007-08-31 10:19:24', '2018-04-21 13:02:23', 0, 0);
INSERT INTO `client` VALUES (409, 'Nakayama Daichi', '74-800-0841', 'nakayama8@gmail.com', 324199, 0, '2023-03-17 16:02:29', '2000-05-18 23:47:50', 1, 0);
INSERT INTO `client` VALUES (410, 'Peter Simmons', '(1865) 49 6165', 'petersimm@gmail.com', 681167, 1090, '2018-06-12 12:01:38', '2021-08-24 23:55:23', 0, 1);
INSERT INTO `client` VALUES (411, '贾震南', '7808 488793', 'jz9@gmail.com', 298002, 1036, '2014-05-15 22:38:39', '2011-06-30 03:39:45', 1, 1);
INSERT INTO `client` VALUES (412, '石子韬', '(1865) 13 9024', 'zitaos3@gmail.com', 965209, 597, '2007-02-22 03:17:56', '2008-06-07 22:26:07', 1, 0);
INSERT INTO `client` VALUES (413, '冯宇宁', '614-000-0397', 'feyun@icloud.com', 701344, 1145, '2006-11-30 22:09:43', '2006-10-03 19:16:31', 0, 0);
INSERT INTO `client` VALUES (414, 'Shi Jialun', '718-357-5915', 'shij@yahoo.com', 605902, 639, '2008-01-28 09:07:29', '2003-12-15 08:41:15', 1, 1);
INSERT INTO `client` VALUES (415, 'Deng Zhennan', '164-2670-3787', 'denz@outlook.com', 547868, 1145, '2005-08-12 06:43:04', '2016-01-28 20:54:03', 2, 0);
INSERT INTO `client` VALUES (416, 'Tse Sai Wing', '151-6550-7692', 'saiwingt@icloud.com', 831645, 1038, '2021-01-29 22:15:51', '2001-02-12 10:28:00', 1, 0);
INSERT INTO `client` VALUES (417, 'Song Rui', '52-106-9893', 'rui45@icloud.com', 253000, 414, '2012-04-15 21:39:54', '2000-11-05 16:55:13', 1, 1);
INSERT INTO `client` VALUES (418, 'Antonio Meyer', '151-5335-2416', 'antonio527@gmail.com', 75909, 702, '2012-09-05 00:09:52', '2000-11-27 12:01:06', 2, 1);
INSERT INTO `client` VALUES (419, 'Lau Chieh Lun', '90-5776-7450', 'lchiehlun45@gmail.com', 460423, 0, '2017-03-22 20:44:10', '2009-06-01 18:20:27', 2, 0);
INSERT INTO `client` VALUES (420, 'Feng Jialun', '212-971-7448', 'feng5@outlook.com', 866607, 421, '2005-03-05 03:37:10', '2016-05-16 06:46:23', 0, 0);
INSERT INTO `client` VALUES (421, 'Kong Chiu Wai', '160-8703-0441', 'kchiuwai@icloud.com', 199890, 275, '2005-10-11 20:07:59', '2011-10-15 16:35:24', 1, 1);
INSERT INTO `client` VALUES (422, '陶杰宏', '7083 110229', 'taojiehong@gmail.com', 658435, 1145, '2002-08-25 22:48:41', '2007-04-20 16:12:49', 0, 0);
INSERT INTO `client` VALUES (423, '戴秀英', '145-6837-1274', 'xiuyidai@yahoo.com', 409156, 1166, '2001-07-11 22:33:43', '2020-07-17 18:40:45', 0, 1);
INSERT INTO `client` VALUES (424, 'Yuen Kwok Kuen', '170-8197-2398', 'kkyuen@gmail.com', 160672, 0, '2017-07-30 14:33:30', '2014-01-18 16:31:40', 1, 0);
INSERT INTO `client` VALUES (425, 'Lee Carter', '213-784-9372', 'lcarter303@icloud.com', 327751, 1015, '2014-02-18 03:47:58', '2023-03-03 15:43:53', 0, 0);
INSERT INTO `client` VALUES (426, 'Nomura Mai', '150-6302-7417', 'nomurmai@icloud.com', 196435, 433, '2016-03-23 05:31:12', '2002-03-14 10:36:07', 1, 0);
INSERT INTO `client` VALUES (427, 'Ueda Hana', '212-588-8510', 'uedahana89@yahoo.com', 531080, 882, '2002-07-21 03:44:58', '2017-03-14 05:41:56', 1, 0);
INSERT INTO `client` VALUES (428, 'Troy Ward', '769-0572-3899', 'wartro@gmail.com', 494537, 1097, '2010-09-16 18:55:46', '2015-10-10 12:10:56', 2, 1);
INSERT INTO `client` VALUES (429, 'Yuen Wai Man', '5564 050343', 'yuewm@icloud.com', 933042, 552, '2020-03-15 13:56:00', '2020-07-22 04:13:36', 2, 0);
INSERT INTO `client` VALUES (430, 'Liang Zhiyuan', '614-393-1159', 'zhiliang@outlook.com', 567201, 0, '2010-09-08 12:32:58', '2020-02-25 21:50:26', 0, 0);
INSERT INTO `client` VALUES (431, 'Okada Hikari', '330-265-4910', 'okadhikari@outlook.com', 682003, 616, '2011-07-02 00:51:37', '2020-04-09 16:42:08', 2, 1);
INSERT INTO `client` VALUES (432, 'Frances Alvarez', '173-6764-3811', 'fa11@hotmail.com', 121623, 0, '2017-03-10 11:30:45', '2012-11-25 17:45:42', 0, 0);
INSERT INTO `client` VALUES (433, 'Miyazaki Hina', '330-326-9480', 'miyazakihina@gmail.com', 47937, 1123, '2010-02-12 06:49:21', '2006-04-13 11:16:00', 1, 1);
INSERT INTO `client` VALUES (434, 'Yokoyama Yuna', '330-668-8439', 'yunayok1@yahoo.com', 862175, 0, '2024-09-19 03:26:54', '2020-01-10 10:49:51', 0, 0);
INSERT INTO `client` VALUES (435, 'Nishimura Mai', '312-471-3396', 'nma@hotmail.com', 176178, 470, '2010-11-24 21:37:36', '2009-04-16 22:21:27', 1, 1);
INSERT INTO `client` VALUES (436, '赵宇宁', '838-546-2077', 'yuning2@icloud.com', 144054, 647, '2005-03-19 05:17:46', '2019-10-20 04:54:11', 2, 1);
INSERT INTO `client` VALUES (437, 'Chu Ming Sze', '5631 100184', 'chu721@icloud.com', 563915, 829, '2011-03-11 22:20:31', '2005-10-04 12:47:57', 1, 1);
INSERT INTO `client` VALUES (438, '史云熙', '11-943-9634', 'yshi@outlook.com', 241714, 1090, '2010-09-06 17:41:37', '2000-10-24 13:13:10', 1, 1);
INSERT INTO `client` VALUES (439, '郝晓明', '21-0891-0532', 'xiaoming1992@gmail.com', 747503, 361, '2012-02-20 06:24:31', '2016-01-23 00:32:05', 0, 1);
INSERT INTO `client` VALUES (440, 'Kojima Misaki', '3-6246-4833', 'kojimamis225@yahoo.com', 326630, 707, '2021-09-09 16:37:11', '2001-09-27 18:41:51', 1, 1);
INSERT INTO `client` VALUES (441, 'Wan Wai Lam', '(20) 2157 7995', 'wlw@gmail.com', 131327, 947, '2022-01-02 05:37:44', '2001-06-03 00:49:14', 2, 1);
INSERT INTO `client` VALUES (442, 'Yu Rui', '330-257-0537', 'rui205@outlook.com', 663067, 630, '2008-08-08 01:12:42', '2020-05-01 23:59:53', 1, 1);
INSERT INTO `client` VALUES (443, 'Inoue Ryota', '5553 240591', 'ri1996@gmail.com', 7277, 848, '2012-12-30 01:45:37', '2020-02-22 15:13:31', 2, 1);
INSERT INTO `client` VALUES (444, 'Loui Ting Fung', '755-1424-0463', 'louitf@mail.com', 430990, 765, '2019-06-07 01:26:15', '2022-03-24 00:15:08', 1, 0);
INSERT INTO `client` VALUES (445, 'Ishii Yuto', '20-549-4434', 'ishyut@outlook.com', 590527, 637, '2017-06-09 15:45:31', '2004-02-09 14:48:44', 2, 0);
INSERT INTO `client` VALUES (446, '王秀英', '145-8311-5707', 'xiuwa423@icloud.com', 279912, 1169, '2023-08-20 04:50:06', '2001-06-04 03:08:13', 1, 0);
INSERT INTO `client` VALUES (447, '沈子韬', '614-723-3582', 'shen729@gmail.com', 313983, 0, '2004-09-30 04:21:31', '2007-03-09 07:15:15', 0, 0);
INSERT INTO `client` VALUES (448, 'Valerie Cook', '70-1206-5825', 'coovalerie@yahoo.com', 179011, 0, '2019-05-19 15:47:51', '2007-07-12 05:20:06', 2, 0);
INSERT INTO `client` VALUES (449, '向云熙', '(1223) 26 9937', 'xiangy@gmail.com', 89536, 252, '2003-04-03 09:59:15', '2010-04-05 18:44:21', 0, 1);
INSERT INTO `client` VALUES (450, '孙致远', '(20) 4781 6435', 'sunzhi@mail.com', 278575, 0, '2000-01-22 09:48:47', '2015-07-05 09:10:14', 2, 0);
INSERT INTO `client` VALUES (451, '程震南', '163-1324-0153', 'zc69@gmail.com', 916008, 557, '2020-05-09 18:50:56', '2019-08-20 11:15:39', 1, 0);
INSERT INTO `client` VALUES (452, 'Siu Chung Yin', '28-464-7146', 'cysiu@hotmail.com', 767101, 0, '2011-05-19 03:07:38', '2013-10-28 16:16:19', 0, 0);
INSERT INTO `client` VALUES (453, 'Takada Seiko', '718-409-0889', 'seikotak@outlook.com', 926925, 0, '2002-11-13 14:18:01', '2006-08-02 04:05:00', 1, 0);
INSERT INTO `client` VALUES (454, 'Sato Eita', '70-3977-4636', 'es520@outlook.com', 40898, 0, '2007-02-13 00:29:28', '2011-12-17 07:43:26', 1, 0);
INSERT INTO `client` VALUES (455, 'Nakamori Takuya', '212-797-6599', 'takuya3@outlook.com', 857201, 940, '2007-05-18 03:56:48', '2018-02-27 12:14:18', 1, 1);
INSERT INTO `client` VALUES (456, 'Yan Xiuying', '(116) 234 6999', 'yanxiuying@outlook.com', 512032, 1112, '2006-10-14 23:46:08', '2016-06-09 22:49:36', 0, 1);
INSERT INTO `client` VALUES (457, 'George Foster', '52-563-0606', 'gfoster913@yahoo.com', 829656, 1014, '2003-03-31 09:47:39', '2020-01-27 21:51:23', 2, 0);
INSERT INTO `client` VALUES (458, 'Sheh Sze Yu', '90-1983-2754', 'shehsy@mail.com', 215554, 0, '2017-05-21 04:20:32', '2005-11-02 09:12:55', 2, 0);
INSERT INTO `client` VALUES (459, 'Diane Wright', '838-244-5290', 'wdian@outlook.com', 160048, 717, '2021-02-05 00:07:12', '2011-12-16 07:51:52', 1, 1);
INSERT INTO `client` VALUES (460, '邹嘉伦', '187-1701-0015', 'zojialun41@yahoo.com', 277305, 0, '2018-12-15 09:04:02', '2017-03-19 13:32:10', 1, 0);
INSERT INTO `client` VALUES (461, '侯睿', '70-5844-6982', 'ruihou47@hotmail.com', 54836, 1086, '2013-11-28 12:20:03', '2016-06-07 02:33:18', 0, 1);
INSERT INTO `client` VALUES (462, 'Chen Zhennan', '(121) 918 2922', 'zhennanch@gmail.com', 12567, 1116, '2021-01-15 03:13:09', '2017-10-01 06:18:23', 1, 1);
INSERT INTO `client` VALUES (463, 'Heung Ming Sze', '80-8894-8626', 'msheung@mail.com', 6794, 1164, '2006-04-23 11:00:57', '2022-01-01 18:52:58', 1, 0);
INSERT INTO `client` VALUES (464, '严宇宁', '5056 678044', 'yanyuning@icloud.com', 885337, 365, '2002-06-29 20:09:30', '2002-12-01 18:07:39', 0, 1);
INSERT INTO `client` VALUES (465, 'Walter Stone', '155-7654-8913', 'stone8@gmail.com', 79363, 328, '2019-05-17 04:21:49', '2007-05-05 23:11:00', 1, 0);
INSERT INTO `client` VALUES (466, 'Wu Lu', '312-447-9989', 'wul@gmail.com', 755456, 701, '2001-06-27 00:55:09', '2001-11-28 16:40:31', 2, 0);
INSERT INTO `client` VALUES (467, 'Takagi Riku', '3-7984-8695', 'riku6@icloud.com', 757907, 255, '2014-02-21 20:44:59', '2000-05-04 19:25:32', 0, 1);
INSERT INTO `client` VALUES (468, 'Tang Chi Ming', '(116) 953 0546', 'chimingtang928@hotmail.com', 314094, 0, '2008-03-18 18:54:19', '2000-09-11 13:07:47', 1, 0);
INSERT INTO `client` VALUES (469, 'Loui Ho Yin', '3-9289-8523', 'louihy@icloud.com', 693959, 916, '2006-03-12 10:32:29', '2003-08-30 16:57:50', 1, 0);
INSERT INTO `client` VALUES (470, 'Guo Jialun', '177-2735-9848', 'guo8@gmail.com', 51956, 921, '2023-04-18 05:37:17', '2002-10-04 04:12:19', 2, 0);
INSERT INTO `client` VALUES (471, 'Uchida Aoshi', '11-664-2050', 'uchidaa@gmail.com', 781777, 561, '2011-10-11 18:45:35', '2008-03-27 02:44:21', 1, 1);
INSERT INTO `client` VALUES (472, '武子异', '5739 325094', 'ziw86@outlook.com', 222832, 874, '2006-01-09 11:20:51', '2019-05-02 05:50:55', 1, 1);
INSERT INTO `client` VALUES (473, 'Sakamoto Itsuki', '80-2396-8453', 'sakamoto8@mail.com', 753912, 1037, '2011-06-17 16:06:46', '2001-11-20 12:06:59', 0, 0);
INSERT INTO `client` VALUES (474, 'Zhang Lu', '212-393-4533', 'luzha@gmail.com', 424875, 1116, '2002-03-11 13:47:33', '2010-02-17 07:16:17', 0, 0);
INSERT INTO `client` VALUES (475, 'Liao Wing Sze', '7399 804076', 'liaowingsze@outlook.com', 74038, 0, '2002-10-27 19:25:39', '2004-01-16 04:10:49', 0, 0);
INSERT INTO `client` VALUES (476, '丁震南', '3-2886-5118', 'ding76@icloud.com', 975798, 1033, '2019-06-24 13:10:10', '2000-02-22 17:19:40', 1, 0);
INSERT INTO `client` VALUES (477, 'Tse Wai Man', '52-790-2649', 'tsewm@icloud.com', 427029, 428, '2023-01-19 19:55:07', '2002-08-04 07:46:36', 2, 1);
INSERT INTO `client` VALUES (478, '蒋震南', '156-4737-1348', 'zhennan8@gmail.com', 493734, 969, '2008-01-12 18:12:26', '2020-01-20 18:41:58', 0, 1);
INSERT INTO `client` VALUES (479, 'Yau Fu Shing', '10-3167-1897', 'yafushing123@gmail.com', 680399, 767, '2008-02-05 13:33:29', '2014-07-13 21:23:23', 0, 0);
INSERT INTO `client` VALUES (480, 'Chung On Kay', '11-321-6772', 'chungok@icloud.com', 630403, 0, '2024-05-03 11:20:54', '2013-11-08 23:21:47', 1, 0);
INSERT INTO `client` VALUES (481, 'Zhang Xiaoming', '838-128-9037', 'zhang1227@outlook.com', 424229, 0, '2020-10-11 12:18:37', '2021-11-26 15:59:00', 1, 0);
INSERT INTO `client` VALUES (482, 'Inoue Kaito', '838-605-4447', 'inouekaito1@yahoo.com', 561932, 0, '2007-03-19 21:16:26', '2017-04-07 23:47:57', 1, 0);
INSERT INTO `client` VALUES (483, 'Sheila Foster', '(20) 4481 6693', 'shefoster417@gmail.com', 635056, 593, '2002-02-21 15:03:56', '2005-07-10 19:30:09', 0, 1);
INSERT INTO `client` VALUES (484, 'Ishikawa Tsubasa', '755-755-4451', 'tishikawa919@hotmail.com', 952954, 273, '2007-01-11 16:50:07', '2013-03-05 22:43:22', 1, 1);
INSERT INTO `client` VALUES (485, 'Chung Fu Shing', '66-768-3059', 'chfushing@gmail.com', 168816, 1050, '2008-04-14 18:20:38', '2020-11-12 00:11:22', 1, 0);
INSERT INTO `client` VALUES (486, 'Gong Zhennan', '718-732-7745', 'zgong1940@gmail.com', 212061, 978, '2022-10-29 15:47:41', '2021-04-02 12:22:39', 2, 1);
INSERT INTO `client` VALUES (487, 'Yue Wing Suen', '330-870-9971', 'wingsuenyue@icloud.com', 651511, 996, '2019-05-03 02:58:51', '2013-12-17 04:23:33', 2, 1);
INSERT INTO `client` VALUES (488, 'Chen Anqi', '11-474-9498', 'chenanq@outlook.com', 873688, 0, '2014-04-21 10:32:18', '2008-09-07 15:56:37', 0, 0);
INSERT INTO `client` VALUES (489, 'Gerald Hall', '66-149-9439', 'hall8@mail.com', 766499, 751, '2017-06-03 11:56:28', '2005-01-02 12:46:25', 0, 1);
INSERT INTO `client` VALUES (490, 'Ng Chiu Wai', '28-6136-5976', 'ncw@hotmail.com', 301768, 0, '2011-09-22 03:16:12', '2015-12-16 21:18:46', 2, 0);
INSERT INTO `client` VALUES (491, '黎致远', '(161) 415 3931', 'zhiyuan6@hotmail.com', 140452, 969, '2011-12-18 02:01:03', '2010-01-29 22:42:05', 2, 1);
INSERT INTO `client` VALUES (492, 'Yoshida Hikaru', '5280 618714', 'hiyos4@icloud.com', 68733, 651, '2006-08-05 19:17:02', '2008-12-17 21:08:48', 0, 1);
INSERT INTO `client` VALUES (493, 'Feng Lu', '212-131-3515', 'lufen5@gmail.com', 847261, 843, '2010-06-16 21:26:24', '2018-11-29 20:29:04', 1, 1);
INSERT INTO `client` VALUES (494, 'Mao Jiehong', '7989 578222', 'mjiehong@outlook.com', 573746, 446, '2010-07-26 00:07:34', '2000-04-16 02:40:21', 0, 0);
INSERT INTO `client` VALUES (495, 'Mo Ching Wan', '90-9040-9425', 'cwmo@yahoo.com', 128345, 713, '2005-01-13 15:37:47', '2023-12-10 00:05:19', 0, 1);
INSERT INTO `client` VALUES (496, 'Leung Ka Keung', '154-9891-7891', 'lekk1020@icloud.com', 214810, 476, '2009-08-30 09:06:09', '2023-08-28 00:04:05', 0, 1);
INSERT INTO `client` VALUES (497, 'Antonio Henderson', '90-4661-1027', 'henda1101@yahoo.com', 913767, 308, '2010-12-05 12:54:14', '2013-12-12 06:03:51', 1, 1);
INSERT INTO `client` VALUES (498, '汤云熙', '614-792-8820', 'tyunxi812@icloud.com', 58237, 826, '2018-11-30 19:47:42', '2006-04-30 11:01:48', 1, 1);
INSERT INTO `client` VALUES (499, '史子韬', '90-3942-8285', 'zitaoshi@gmail.com', 615123, 0, '2014-08-12 12:11:51', '2003-05-24 17:26:30', 1, 0);
INSERT INTO `client` VALUES (500, 'Yan Rui', '718-406-6707', 'yan630@yahoo.com', 146427, 299, '2015-08-15 13:58:21', '2001-01-08 04:17:47', 1, 0);
INSERT INTO `client` VALUES (501, '董子异', '755-912-4025', 'donziy10@gmail.com', 737103, 1059, '2016-08-11 10:07:55', '2015-04-07 23:06:40', 1, 1);
INSERT INTO `client` VALUES (502, 'Wu Zhennan', '213-714-7965', 'wzhenn8@gmail.com', 320860, 0, '2017-01-25 08:38:55', '2003-10-17 11:16:25', 2, 0);
INSERT INTO `client` VALUES (503, 'Zhang Xiaoming', '7566 571759', 'zhxiaom@gmail.com', 784132, 542, '2012-04-29 01:38:10', '2024-08-20 12:13:06', 0, 0);
INSERT INTO `client` VALUES (504, '戴璐', '5985 393546', 'ludai@hotmail.com', 501154, 0, '2006-05-29 17:10:57', '2007-10-19 11:40:47', 1, 0);
INSERT INTO `client` VALUES (505, '戴嘉伦', '136-1839-2582', 'daijia@icloud.com', 482291, 310, '2015-10-13 17:29:23', '2011-07-13 03:00:24', 1, 0);
INSERT INTO `client` VALUES (506, 'Kwan Wing Suen', '718-190-6004', 'wskwa103@gmail.com', 212682, 1175, '2019-05-15 19:29:34', '2022-02-28 01:55:25', 1, 1);
INSERT INTO `client` VALUES (507, 'Liu Shihan', '213-230-7914', 'liu7@outlook.com', 357785, 0, '2004-11-17 19:10:47', '2012-09-29 11:18:32', 1, 0);
INSERT INTO `client` VALUES (508, '胡震南', '7954 407680', 'hz2@mail.com', 637378, 1073, '2016-10-25 18:05:55', '2009-09-20 07:01:38', 2, 0);
INSERT INTO `client` VALUES (509, '莫璐', '80-9090-5131', 'lmo1226@outlook.com', 416565, 332, '2013-08-21 06:56:08', '2022-02-18 03:30:00', 1, 1);
INSERT INTO `client` VALUES (510, '孙子韬', '144-9988-3971', 'zs3@gmail.com', 885561, 619, '2009-04-22 01:57:35', '2004-04-22 12:20:10', 0, 1);
INSERT INTO `client` VALUES (511, 'Norma Williams', '838-013-9090', 'winorma@yahoo.com', 279055, 327, '2005-10-14 06:28:13', '2015-01-31 13:48:52', 1, 0);
INSERT INTO `client` VALUES (512, 'Yuen Kwok Yin', '(161) 425 5206', 'ykwokyin78@mail.com', 809910, 0, '2018-05-19 22:57:00', '2006-12-12 04:42:13', 1, 0);
INSERT INTO `client` VALUES (513, 'He Lu', '74-907-3009', 'he10@mail.com', 30318, 1061, '2004-03-08 06:47:14', '2023-05-14 14:42:23', 0, 0);
INSERT INTO `client` VALUES (514, 'Debbie Reyes', '718-852-5175', 'debbiereyes@icloud.com', 777401, 1195, '2006-01-18 05:10:38', '2000-03-27 16:24:05', 1, 0);
INSERT INTO `client` VALUES (515, 'Sakurai Seiko', '166-8502-9458', 'sakuraiseiko@yahoo.com', 991281, 1123, '2020-12-05 07:40:32', '2013-09-12 23:31:26', 2, 1);
INSERT INTO `client` VALUES (516, '何子异', '7731 839744', 'hezi@yahoo.com', 810415, 527, '2024-01-28 19:53:01', '2006-04-27 00:55:40', 0, 1);
INSERT INTO `client` VALUES (517, 'Kondo Takuya', '80-7846-7697', 'kondot@icloud.com', 582646, 1197, '2017-09-17 00:14:09', '2015-09-09 14:02:57', 1, 1);
INSERT INTO `client` VALUES (518, 'Ikeda Yuito', '330-576-4815', 'yikeda10@gmail.com', 736978, 954, '2022-03-01 04:47:20', '2003-10-05 10:12:50', 0, 1);
INSERT INTO `client` VALUES (519, 'Zhu Jiehong', '212-217-5341', 'jiehongzhu98@outlook.com', 860981, 0, '2024-04-04 00:01:11', '2012-02-04 16:43:54', 0, 0);
INSERT INTO `client` VALUES (520, 'Ichikawa Shino', '(20) 6914 5132', 'shino50@yahoo.com', 945861, 996, '2008-05-28 12:40:25', '2003-07-26 20:20:33', 2, 1);
INSERT INTO `client` VALUES (521, 'Yin Zhiyuan', '213-377-5310', 'zhiyuan809@icloud.com', 275495, 0, '2004-12-11 10:18:20', '2009-05-03 21:09:46', 0, 0);
INSERT INTO `client` VALUES (522, 'Endo Aoshi', '212-861-7560', 'enaoshi@icloud.com', 84207, 803, '2005-06-10 12:09:30', '2016-06-28 06:11:51', 1, 1);
INSERT INTO `client` VALUES (523, 'Joanne Parker', '760-7010-5869', 'parkerjoanne@gmail.com', 917486, 716, '2001-01-15 08:51:00', '2024-11-17 14:56:00', 0, 0);
INSERT INTO `client` VALUES (524, 'Ku Ming', '(121) 634 2297', 'ming104@mail.com', 242171, 1018, '2003-10-31 02:38:58', '2015-05-20 13:13:16', 1, 0);
INSERT INTO `client` VALUES (525, 'Yuen Wing Kuen', '718-423-3853', 'wingkuen5@icloud.com', 915736, 1200, '2012-05-22 03:15:03', '2014-07-18 15:14:56', 0, 1);
INSERT INTO `client` VALUES (526, '程杰宏', '614-213-9079', 'chengjie1203@outlook.com', 971037, 1196, '2010-08-28 03:15:20', '2011-08-15 04:23:38', 0, 0);
INSERT INTO `client` VALUES (527, '史璐', '10-6670-5650', 'slu@gmail.com', 126811, 0, '2004-06-13 17:26:48', '2004-06-23 07:32:55', 0, 0);
INSERT INTO `client` VALUES (528, '于云熙', '212-569-1141', 'yuyunxi@yahoo.com', 245075, 941, '2004-09-02 02:23:35', '2023-01-03 00:01:08', 2, 1);
INSERT INTO `client` VALUES (529, 'Duan Xiuying', '7044 571902', 'dxiuyi@gmail.com', 738094, 645, '2011-06-28 18:59:43', '2020-09-09 07:18:05', 2, 0);
INSERT INTO `client` VALUES (530, 'Lee Ling Ling', '5216 100147', 'lll520@gmail.com', 204604, 263, '2004-09-14 22:59:23', '2004-11-19 16:43:45', 2, 1);
INSERT INTO `client` VALUES (531, 'Duan Zhennan', '90-1705-9753', 'duan607@gmail.com', 777815, 793, '2000-09-24 21:36:28', '2023-09-26 03:04:29', 1, 1);
INSERT INTO `client` VALUES (532, 'Endo Airi', '330-177-4898', 'endo916@gmail.com', 900485, 0, '2012-01-02 07:16:08', '2010-06-27 06:02:57', 1, 0);
INSERT INTO `client` VALUES (533, 'Che Wing Sze', '20-859-5262', 'cwingsze@mail.com', 247729, 521, '2009-07-26 22:35:41', '2005-07-09 04:44:57', 2, 1);
INSERT INTO `client` VALUES (534, 'Qian Jiehong', '769-1202-4310', 'qjiehong@gmail.com', 757414, 610, '2004-08-26 11:12:18', '2009-11-15 00:43:04', 1, 0);
INSERT INTO `client` VALUES (535, 'Keith Morris', '213-586-7478', 'morrkeith9@icloud.com', 201513, 804, '2009-12-16 20:54:22', '2021-06-09 20:26:30', 0, 1);
INSERT INTO `client` VALUES (536, 'Chan Siu Wai', '70-4424-8865', 'chan1940@icloud.com', 173798, 0, '2024-07-05 15:28:19', '2002-09-01 23:03:58', 1, 0);
INSERT INTO `client` VALUES (537, 'Anthony Porter', '5779 837123', 'porta49@gmail.com', 844222, 999, '2016-06-05 06:21:05', '2015-06-12 18:37:49', 1, 1);
INSERT INTO `client` VALUES (538, 'Lui Ka Man', '70-1323-5292', 'lkaman@icloud.com', 614543, 659, '2002-01-06 09:24:44', '2017-07-07 21:15:17', 2, 1);
INSERT INTO `client` VALUES (539, 'Harry Jenkins', '(151) 961 0494', 'jenkharry@yahoo.com', 647425, 1047, '2020-06-17 13:37:48', '2011-11-01 14:03:59', 2, 1);
INSERT INTO `client` VALUES (540, 'Jean Kennedy', '213-114-7979', 'jeankenne1977@hotmail.com', 614548, 605, '2010-10-30 02:43:43', '2019-10-19 09:49:56', 2, 1);
INSERT INTO `client` VALUES (541, 'Dong Jialun', '80-9032-4633', 'jdon4@outlook.com', 971965, 1192, '2000-09-19 16:33:22', '2010-09-12 19:43:20', 2, 1);
INSERT INTO `client` VALUES (542, 'He Xiuying', '212-429-9883', 'xihe@gmail.com', 240125, 0, '2023-01-28 12:04:07', '2016-07-26 09:42:28', 2, 0);
INSERT INTO `client` VALUES (543, '张云熙', '213-130-6251', 'zhyunx1@gmail.com', 399117, 0, '2024-07-05 23:37:38', '2017-10-21 20:26:45', 0, 0);
INSERT INTO `client` VALUES (544, 'Xu Anqi', '144-6828-6672', 'anqixu1111@icloud.com', 446447, 0, '2012-12-23 16:39:55', '2006-09-06 14:53:12', 1, 0);
INSERT INTO `client` VALUES (545, 'Uchida Minato', '163-8271-1285', 'mu3@gmail.com', 407843, 947, '2023-08-08 10:03:15', '2015-04-21 02:26:55', 2, 1);
INSERT INTO `client` VALUES (546, 'Gerald Clark', '183-5488-0756', 'clarkge8@gmail.com', 552647, 416, '2018-11-28 23:04:37', '2007-01-07 20:45:40', 0, 1);
INSERT INTO `client` VALUES (547, 'Bryan Barnes', '755-164-2097', 'barnebr10@yahoo.com', 140097, 0, '2003-05-08 04:13:23', '2008-10-18 02:45:21', 1, 0);
INSERT INTO `client` VALUES (548, 'Miyamoto Rin', '755-1811-4864', 'miyamrin3@yahoo.com', 780708, 483, '2019-07-19 17:58:37', '2018-01-07 16:00:13', 2, 0);
INSERT INTO `client` VALUES (549, 'Xiao Yunxi', '212-226-9258', 'xiao68@outlook.com', 473911, 939, '2016-02-19 04:12:03', '2013-04-03 05:03:59', 1, 1);
INSERT INTO `client` VALUES (550, 'Kong Anqi', '(121) 363 5603', 'anqi6@gmail.com', 177978, 361, '2024-05-13 05:56:13', '2016-05-16 01:33:38', 0, 1);
INSERT INTO `client` VALUES (551, 'Tin Wing Kuen', '7334 704587', 'twk8@gmail.com', 509265, 786, '2018-03-26 10:28:45', '2005-12-07 15:28:44', 0, 1);
INSERT INTO `client` VALUES (552, 'Yuen Sze Kwan', '90-5701-7725', 'skyu1943@mail.com', 356907, 1048, '2002-03-10 00:58:44', '2002-02-03 18:18:36', 0, 1);
INSERT INTO `client` VALUES (553, 'Jin Jiehong', '(116) 383 6850', 'jiehongj@gmail.com', 144221, 375, '2010-12-06 11:39:00', '2004-11-23 13:24:15', 1, 1);
INSERT INTO `client` VALUES (554, '于秀英', '80-7193-6493', 'xiuying80@icloud.com', 451170, 1124, '2011-11-09 05:58:15', '2018-10-06 17:10:28', 2, 0);
INSERT INTO `client` VALUES (555, '赵岚', '198-3126-8703', 'lanzhao@outlook.com', 840755, 1153, '2011-07-06 08:26:26', '2007-12-28 23:33:37', 1, 1);
INSERT INTO `client` VALUES (556, '杜震南', '80-0239-6918', 'duzhennan114@gmail.com', 233568, 412, '2020-01-14 13:09:59', '2021-03-01 16:32:53', 1, 0);
INSERT INTO `client` VALUES (557, 'Che Wing Fat', '194-0456-6130', 'chwin1008@gmail.com', 3932, 973, '2003-02-04 02:10:28', '2016-08-03 12:39:13', 2, 1);
INSERT INTO `client` VALUES (558, 'Matsui Ikki', '5541 028563', 'ikkimatsui@icloud.com', 661277, 788, '2002-06-04 23:11:44', '2022-02-09 23:40:36', 2, 1);
INSERT INTO `client` VALUES (559, 'Saito Riku', '838-904-6726', 'riku15@yahoo.com', 416188, 0, '2007-01-03 08:19:55', '2019-06-09 01:55:50', 1, 0);
INSERT INTO `client` VALUES (560, 'Marilyn Murphy', '5062 597152', 'mm321@yahoo.com', 661648, 694, '2013-07-17 17:35:21', '2021-12-24 16:28:21', 0, 1);
INSERT INTO `client` VALUES (561, 'Phillip Adams', '20-0080-7464', 'adamsphillip@gmail.com', 976740, 629, '2000-01-10 04:35:39', '2022-09-11 07:31:15', 1, 1);
INSERT INTO `client` VALUES (562, 'Tao Wing Kuen', '66-841-2726', 'wingkuen6@icloud.com', 103437, 564, '2021-02-03 22:48:24', '2023-01-11 23:13:36', 0, 1);
INSERT INTO `client` VALUES (563, 'Nakamori Aoi', '52-309-7447', 'aoi326@icloud.com', 169138, 352, '2020-03-12 11:58:52', '2013-10-14 00:01:27', 1, 1);
INSERT INTO `client` VALUES (564, 'Xiao Shihan', '312-781-1180', 'xiao10@outlook.com', 28113, 298, '2009-08-08 18:07:33', '2017-10-21 11:28:24', 2, 0);
INSERT INTO `client` VALUES (565, '毛晓明', '760-732-6946', 'xiama@gmail.com', 812111, 377, '2022-01-26 20:01:34', '2002-06-12 16:18:21', 0, 1);
INSERT INTO `client` VALUES (566, 'David Mitchell', '(161) 356 8650', 'davidmitc6@icloud.com', 730685, 502, '2002-01-27 04:37:24', '2014-11-16 03:26:50', 1, 1);
INSERT INTO `client` VALUES (567, 'Phillip Patel', '188-7131-7194', 'patelphi9@mail.com', 72805, 832, '2011-02-28 21:22:32', '2021-12-13 03:08:13', 1, 1);
INSERT INTO `client` VALUES (568, 'Tao Shihan', '312-276-8819', 'stao@yahoo.com', 174820, 982, '2002-07-30 23:52:16', '2019-04-24 11:35:22', 0, 1);
INSERT INTO `client` VALUES (569, '方子韬', '312-000-3534', 'zitaofang@gmail.com', 621453, 0, '2016-04-15 07:51:48', '2020-06-24 01:33:53', 1, 0);
INSERT INTO `client` VALUES (570, 'Mario Wood', '718-260-7958', 'mariow@gmail.com', 204370, 873, '2012-08-18 23:15:09', '2004-08-09 23:09:56', 1, 0);
INSERT INTO `client` VALUES (571, 'Ding Shihan', '212-954-6750', 'shihadin@gmail.com', 578257, 387, '2013-12-04 21:59:00', '2017-04-03 00:38:20', 2, 0);
INSERT INTO `client` VALUES (572, 'Richard Collins', '198-3629-9913', 'collirichard@gmail.com', 439945, 896, '2002-01-20 21:50:36', '2021-02-10 01:24:34', 0, 1);
INSERT INTO `client` VALUES (573, 'Wada Hazuki', '(121) 378 8632', 'hazwa06@gmail.com', 588652, 0, '2009-11-19 01:34:20', '2019-06-19 15:40:41', 1, 0);
INSERT INTO `client` VALUES (574, 'Gary Woods', '(1223) 16 2180', 'wog@icloud.com', 56913, 1092, '2003-12-02 16:51:22', '2023-05-31 01:18:23', 1, 1);
INSERT INTO `client` VALUES (575, 'Su Ziyi', '10-4811-4779', 'suziyi63@outlook.com', 62037, 0, '2004-12-19 00:35:33', '2008-05-31 15:36:08', 1, 0);
INSERT INTO `client` VALUES (576, 'Ichikawa Yuna', '7416 567335', 'iyuna@hotmail.com', 749275, 0, '2014-05-17 02:37:15', '2003-02-26 11:55:48', 2, 0);
INSERT INTO `client` VALUES (577, 'Alan Lewis', '3-5308-5107', 'lalan8@icloud.com', 267412, 456, '2014-06-19 22:46:25', '2003-02-27 05:14:02', 0, 0);
INSERT INTO `client` VALUES (578, 'Kong Wing Kuen', '74-890-6197', 'wkko@icloud.com', 335376, 1034, '2007-09-23 01:33:54', '2009-01-22 15:51:54', 1, 1);
INSERT INTO `client` VALUES (579, 'Wu Ling Ling', '(1865) 41 3904', 'linglingwu@mail.com', 73788, 219, '2007-08-03 03:24:27', '2014-09-21 07:52:44', 2, 1);
INSERT INTO `client` VALUES (580, 'Shimada Momoka', '164-5751-7756', 'shimada72@gmail.com', 317012, 1084, '2004-10-02 22:33:23', '2001-06-10 17:12:54', 2, 1);
INSERT INTO `client` VALUES (581, 'Harry Herrera', '312-970-5470', 'harry4@outlook.com', 670638, 1196, '2001-01-13 22:12:14', '2019-08-14 01:02:58', 0, 0);
INSERT INTO `client` VALUES (582, 'Nakayama Momoe', '614-364-9699', 'nakayama2@outlook.com', 731178, 0, '2012-10-15 05:10:34', '2020-10-25 02:28:12', 2, 0);
INSERT INTO `client` VALUES (583, 'Che Chun Yu', '28-5859-0618', 'che82@mail.com', 35512, 456, '2012-01-08 03:27:07', '2005-10-30 05:29:40', 2, 0);
INSERT INTO `client` VALUES (584, '田嘉伦', '5771 398364', 'tijialun4@outlook.com', 24767, 786, '2023-06-03 19:30:34', '2014-05-24 17:16:57', 1, 1);
INSERT INTO `client` VALUES (585, 'Sato Misaki', '3-4164-7955', 'smi85@mail.com', 275804, 915, '2001-06-19 02:14:22', '2018-06-03 17:35:41', 1, 0);
INSERT INTO `client` VALUES (586, 'Zeng Zhiyuan', '194-0648-0243', 'zz79@gmail.com', 380629, 1112, '2005-11-11 10:27:26', '2023-02-03 05:25:36', 2, 0);
INSERT INTO `client` VALUES (587, '何安琪', '80-7072-5554', 'anhe@gmail.com', 148211, 417, '2001-05-13 18:50:34', '2016-09-25 11:03:09', 2, 0);
INSERT INTO `client` VALUES (588, 'Aoki Daichi', '(161) 055 9580', 'aoki8@gmail.com', 4104, 344, '2020-11-28 17:43:30', '2003-03-07 18:57:13', 2, 0);
INSERT INTO `client` VALUES (589, 'Liang Zitao', '760-7105-3039', 'zitaoliang705@icloud.com', 241248, 678, '2005-05-04 19:24:35', '2012-12-21 17:43:32', 0, 1);
INSERT INTO `client` VALUES (590, 'Jose Stevens', '212-708-2817', 'josteve71@mail.com', 309157, 0, '2023-01-06 03:25:47', '2012-07-21 16:31:13', 1, 0);
INSERT INTO `client` VALUES (591, 'Shen Zhiyuan', '7680 178310', 'zhiyuan320@gmail.com', 797021, 925, '2014-04-29 21:49:48', '2010-09-26 07:09:37', 1, 0);
INSERT INTO `client` VALUES (592, 'Tong Chiu Wai', '838-390-0982', 'chiuwtong9@outlook.com', 977304, 1065, '2014-06-22 23:52:55', '2023-12-30 06:20:13', 0, 0);
INSERT INTO `client` VALUES (593, 'Chen Zhiyuan', '180-4808-4486', 'zchen10@gmail.com', 166902, 449, '2000-11-17 04:36:05', '2003-04-01 05:08:44', 0, 0);
INSERT INTO `client` VALUES (594, 'Yu Zitao', '312-145-6017', 'zitaoy62@outlook.com', 474247, 922, '2004-01-30 11:13:44', '2021-09-10 09:45:13', 0, 0);
INSERT INTO `client` VALUES (595, 'Alexander Chen', '5571 642620', 'calexander@gmail.com', 317021, 0, '2002-09-19 05:55:02', '2010-02-11 08:40:41', 1, 0);
INSERT INTO `client` VALUES (596, 'Xu Anqi', '90-2955-4264', 'anqi1209@gmail.com', 963820, 603, '2007-12-17 02:01:07', '2001-04-21 16:33:25', 0, 1);
INSERT INTO `client` VALUES (597, 'Ishii Daichi', '52-515-3518', 'ishida@gmail.com', 820756, 1068, '2019-07-03 20:08:47', '2017-12-31 00:20:08', 0, 0);
INSERT INTO `client` VALUES (598, 'Koyama Kazuma', '718-240-3600', 'koyamak@icloud.com', 448335, 1030, '2022-02-13 03:20:36', '2001-05-10 02:29:59', 2, 1);
INSERT INTO `client` VALUES (599, 'Chin Lai Yan', '(1865) 67 0609', 'laiyanchin@icloud.com', 923264, 240, '2001-03-07 01:50:12', '2001-02-25 22:39:29', 1, 1);
INSERT INTO `client` VALUES (600, '马秀英', '(20) 0266 2885', 'maxiuying@gmail.com', 472393, 869, '2011-02-27 15:22:00', '2000-01-03 15:47:33', 1, 1);
INSERT INTO `client` VALUES (601, 'Kao Kar Yan', '170-6603-8037', 'karyanka425@mail.com', 429273, 330, '2021-05-29 09:17:52', '2013-05-15 09:32:49', 0, 1);
INSERT INTO `client` VALUES (602, 'Song Zhiyuan', '140-0796-5784', 'song1202@yahoo.com', 279704, 1167, '2020-11-21 03:06:33', '2013-01-03 11:15:42', 1, 0);
INSERT INTO `client` VALUES (603, 'Yokoyama Nanami', '171-6765-3116', 'nanyok92@outlook.com', 181122, 357, '2002-09-09 14:45:03', '2004-11-02 21:31:32', 0, 1);
INSERT INTO `client` VALUES (604, 'Sun Zitao', '(151) 304 0986', 'zitao17@outlook.com', 876909, 341, '2018-05-29 14:52:03', '2005-10-07 06:35:48', 1, 1);
INSERT INTO `client` VALUES (605, '廖致远', '7039 539142', 'liaozhiyuan@gmail.com', 299277, 569, '2001-11-28 16:27:21', '2000-02-23 04:12:32', 2, 1);
INSERT INTO `client` VALUES (606, '姚秀英', '5633 047056', 'yxiuying@icloud.com', 434002, 548, '2001-07-27 22:34:52', '2020-06-30 09:43:54', 2, 1);
INSERT INTO `client` VALUES (607, 'Mo Zitao', '90-9238-3702', 'mo43@gmail.com', 902040, 0, '2014-06-16 10:29:02', '2002-02-27 14:38:11', 0, 0);
INSERT INTO `client` VALUES (608, 'Kudo Aoshi', '213-362-8695', 'kudoao@gmail.com', 695164, 0, '2012-05-02 20:48:31', '2023-11-08 20:18:21', 1, 0);
INSERT INTO `client` VALUES (609, 'Suzuki Sakura', '5592 693781', 'ssakura5@icloud.com', 952692, 1135, '2004-10-01 01:07:52', '2014-06-22 09:50:53', 1, 0);
INSERT INTO `client` VALUES (610, 'Gong Xiaoming', '(1865) 75 2452', 'xiaomingg77@outlook.com', 199461, 716, '2013-10-24 22:07:02', '2013-04-24 13:52:52', 2, 0);
INSERT INTO `client` VALUES (611, 'Jin Yuning', '7537 310817', 'yuningjin@icloud.com', 614674, 0, '2008-06-09 21:59:56', '2023-02-18 18:25:53', 2, 0);
INSERT INTO `client` VALUES (612, 'Cheng Yunxi', '74-464-1649', 'yunxicheng9@outlook.com', 642145, 723, '2018-12-02 18:56:25', '2006-01-08 17:38:56', 2, 1);
INSERT INTO `client` VALUES (613, 'Shen Jiehong', '760-805-1186', 'shenjie@icloud.com', 276112, 957, '2012-04-15 10:40:49', '2022-12-04 10:56:15', 0, 0);
INSERT INTO `client` VALUES (614, 'Hirano Ryota', '11-750-9689', 'hiranr@gmail.com', 2192, 617, '2015-06-06 02:53:48', '2003-07-17 16:10:44', 1, 1);
INSERT INTO `client` VALUES (615, '严云熙', '7512 538078', 'yayunx7@icloud.com', 160414, 1002, '2014-10-26 03:33:46', '2004-06-03 02:48:05', 1, 0);
INSERT INTO `client` VALUES (616, 'Ren Lu', '5383 016502', 'relu@mail.com', 371564, 381, '2024-04-14 18:55:17', '2020-12-20 02:04:14', 2, 1);
INSERT INTO `client` VALUES (617, 'Jean Mitchell', '614-906-3666', 'mijean@gmail.com', 305200, 0, '2012-09-25 15:47:42', '2000-08-22 05:44:35', 2, 0);
INSERT INTO `client` VALUES (618, 'Grace Nelson', '212-847-4941', 'gracnelson07@gmail.com', 660010, 731, '2021-05-14 20:02:57', '2015-06-11 19:55:16', 2, 1);
INSERT INTO `client` VALUES (619, '罗子异', '5421 492245', 'ziyiluo@gmail.com', 125592, 0, '2004-11-15 04:12:58', '2016-08-07 17:58:35', 2, 0);
INSERT INTO `client` VALUES (620, 'Matsumoto Kenta', '330-772-9361', 'kentama823@outlook.com', 832849, 699, '2010-11-25 14:05:54', '2019-10-06 19:08:56', 2, 1);
INSERT INTO `client` VALUES (621, 'Takagi Yota', '(1223) 09 4110', 'takagyo@gmail.com', 956457, 942, '2000-04-26 22:12:43', '2016-09-07 02:59:14', 0, 1);
INSERT INTO `client` VALUES (622, 'Ruth Gonzalez', '169-2777-3845', 'gonzalez929@mail.com', 532747, 0, '2013-04-07 07:07:03', '2015-08-17 22:05:58', 1, 0);
INSERT INTO `client` VALUES (623, 'Ueda Kazuma', '20-312-5167', 'kazueda6@gmail.com', 249426, 325, '2018-02-08 16:41:23', '2020-10-06 04:18:47', 0, 1);
INSERT INTO `client` VALUES (624, 'Hashimoto Kazuma', '330-742-6430', 'hask@gmail.com', 451806, 570, '2007-10-11 10:11:13', '2020-01-05 22:52:20', 1, 1);
INSERT INTO `client` VALUES (625, 'Man Chiu Wai', '196-6610-5249', 'mchiuwai@mail.com', 39376, 5, '2006-06-04 11:00:26', '2022-07-14 22:55:19', 0, 1);
INSERT INTO `client` VALUES (626, 'Sato Ayano', '769-275-2796', 'aysat@gmail.com', 464586, 5, '2010-08-02 00:23:49', '2019-08-26 15:14:11', 2, 1);
INSERT INTO `client` VALUES (627, 'Christine Morales', '7411 005284', 'christinemorales1123@mail.com', 604954, 905, '2018-05-11 06:11:15', '2024-07-26 15:05:04', 2, 1);
INSERT INTO `client` VALUES (628, 'Hu Xiaoming', '(20) 3353 2853', 'hxia@gmail.com', 783431, 0, '2012-11-18 17:44:15', '2017-06-04 06:21:54', 1, 0);
INSERT INTO `client` VALUES (629, 'Kong Xiuying', '171-1628-8300', 'kong1994@outlook.com', 145214, 379, '2016-03-24 13:12:15', '2010-08-14 12:11:17', 2, 1);
INSERT INTO `client` VALUES (630, 'Julia Rose', '7736 650176', 'rjuli4@icloud.com', 747632, 568, '2014-05-01 16:28:12', '2000-04-17 12:28:24', 1, 1);
INSERT INTO `client` VALUES (631, 'Irene Ward', '5626 259770', 'irene630@gmail.com', 521219, 745, '2006-10-26 13:32:07', '2006-10-11 09:15:36', 1, 1);
INSERT INTO `client` VALUES (632, '谢震南', '184-9019-7003', 'xizhennan@gmail.com', 26782, 1042, '2004-12-26 10:11:26', '2001-01-21 15:33:46', 1, 1);
INSERT INTO `client` VALUES (633, 'Endo Tsubasa', '66-205-7635', 'endotsuba@icloud.com', 835969, 880, '2008-02-04 19:55:22', '2008-06-12 14:07:54', 0, 1);
INSERT INTO `client` VALUES (634, 'Frank Chen', '11-877-8852', 'chen01@outlook.com', 227435, 302, '2001-04-16 21:45:48', '2000-03-28 13:23:47', 1, 1);
INSERT INTO `client` VALUES (635, 'Watanabe Misaki', '70-6705-5813', 'misakiw@outlook.com', 971091, 796, '2004-09-09 01:24:09', '2023-01-16 06:59:13', 2, 1);
INSERT INTO `client` VALUES (636, '丁詩涵', '760-6981-8770', 'sding@outlook.com', 844378, 376, '2012-11-29 18:18:10', '2004-01-11 12:27:27', 0, 0);
INSERT INTO `client` VALUES (637, 'Anita Martinez', '(161) 293 9402', 'anitam@hotmail.com', 629998, 547, '2006-10-27 10:43:02', '2005-09-21 08:03:16', 2, 1);
INSERT INTO `client` VALUES (638, 'Huang Ziyi', '330-372-6472', 'hzi1111@icloud.com', 851159, 1178, '2022-06-05 00:24:53', '2012-11-02 19:02:13', 0, 1);
INSERT INTO `client` VALUES (639, 'Kathryn Gray', '169-1886-9597', 'graykathryn@yahoo.com', 465862, 505, '2018-06-01 09:40:24', '2018-07-06 11:14:05', 1, 0);
INSERT INTO `client` VALUES (640, 'Sugawara Misaki', '5346 826762', 'missu@gmail.com', 957086, 0, '2020-05-21 11:04:23', '2003-05-06 00:05:40', 2, 0);
INSERT INTO `client` VALUES (641, '张岚', '80-0573-5350', 'lanz@yahoo.com', 741150, 1145, '2002-10-17 13:12:59', '2007-03-21 02:04:55', 0, 1);
INSERT INTO `client` VALUES (642, '李宇宁', '21-7880-6096', 'li61@gmail.com', 94474, 1121, '2006-10-05 05:10:01', '2004-01-24 18:04:47', 1, 0);
INSERT INTO `client` VALUES (643, 'Eleanor Martin', '213-422-7564', 'eleanorma@icloud.com', 215483, 864, '2003-10-05 23:58:08', '2021-03-27 17:45:53', 1, 1);
INSERT INTO `client` VALUES (644, 'Endo Shino', '66-591-8513', 'endo85@mail.com', 967876, 1028, '2015-05-13 18:05:55', '2016-08-31 17:52:34', 0, 1);
INSERT INTO `client` VALUES (645, 'To Wing Fat', '186-6174-8654', 'wingfatto@gmail.com', 453197, 618, '2022-09-21 03:11:32', '2003-05-14 10:20:45', 1, 0);
INSERT INTO `client` VALUES (646, 'Yau Wing Fat', '7024 648932', 'yau428@yahoo.com', 599495, 542, '2008-12-08 19:20:31', '2001-09-18 11:26:26', 0, 1);
INSERT INTO `client` VALUES (647, 'Cai Zhennan', '90-4554-8037', 'zhennanc@gmail.com', 411238, 1141, '2000-02-05 00:39:04', '2011-01-16 07:07:27', 1, 1);
INSERT INTO `client` VALUES (648, '余晓明', '181-3833-0037', 'xiayu88@gmail.com', 785545, 674, '2016-06-03 03:42:46', '2005-08-17 21:40:56', 1, 1);
INSERT INTO `client` VALUES (649, 'Todd Ward', '131-8549-4831', 'wt1@gmail.com', 735637, 1153, '2018-08-12 22:55:45', '2022-11-10 16:11:10', 1, 1);
INSERT INTO `client` VALUES (650, 'Sano Akina', '5404 991086', 'sanoa@outlook.com', 112185, 510, '2007-11-21 23:04:12', '2002-05-24 12:44:38', 0, 0);
INSERT INTO `client` VALUES (651, 'Cheng Zitao', '760-7313-6158', 'zitaoc@yahoo.com', 722097, 1091, '2003-05-26 19:28:04', '2005-01-14 22:07:13', 0, 0);
INSERT INTO `client` VALUES (652, '吕晓明', '7164 410442', 'xiaomlu@mail.com', 70907, 1189, '2000-04-05 08:50:07', '2012-01-31 08:26:51', 1, 1);
INSERT INTO `client` VALUES (653, 'Lo Ting Fung', '7952 395254', 'loti@yahoo.com', 563315, 0, '2020-10-20 22:07:01', '2015-12-26 09:55:21', 1, 0);
INSERT INTO `client` VALUES (654, 'Yeung Tsz Ching', '90-2616-7114', 'ytszching@outlook.com', 744398, 1010, '2006-03-24 12:17:05', '2015-11-10 09:49:01', 1, 0);
INSERT INTO `client` VALUES (655, 'Fan Chieh Lun', '(1865) 27 9523', 'fanchieh@gmail.com', 934408, 1125, '2014-03-30 10:03:44', '2010-12-09 05:55:44', 0, 1);
INSERT INTO `client` VALUES (656, 'Kong Yunxi', '21-728-2143', 'koyunx10@outlook.com', 716155, 608, '2024-01-15 04:30:53', '2004-04-08 06:45:23', 1, 0);
INSERT INTO `client` VALUES (657, 'Lui Sum Wing', '(116) 595 8242', 'luisumwing430@outlook.com', 559170, 0, '2005-04-06 22:43:40', '2008-08-21 15:59:32', 1, 0);
INSERT INTO `client` VALUES (658, 'Rose Dixon', '74-745-5133', 'rosedixon@gmail.com', 893017, 978, '2022-08-11 17:46:54', '2013-11-20 20:25:10', 1, 1);
INSERT INTO `client` VALUES (659, 'Cheryl Munoz', '212-613-2956', 'cherylmunoz8@outlook.com', 149791, 934, '2020-01-27 00:53:42', '2000-11-29 13:33:55', 1, 1);
INSERT INTO `client` VALUES (660, '贾致远', '213-701-3385', 'jiazh5@outlook.com', 666208, 0, '2008-06-30 07:06:32', '2000-01-30 09:45:23', 1, 0);
INSERT INTO `client` VALUES (661, '薛嘉伦', '139-6386-1498', 'jialunxu@gmail.com', 751093, 592, '2020-12-12 20:40:08', '2018-01-02 22:20:02', 0, 1);
INSERT INTO `client` VALUES (662, 'Lois Crawford', '52-939-0781', 'lcrawf@hotmail.com', 669795, 943, '2022-03-22 11:23:04', '2000-04-29 21:40:29', 1, 1);
INSERT INTO `client` VALUES (663, 'Kikuchi Hina', '143-0546-2908', 'kikuchih@outlook.com', 212356, 212, '2021-08-28 06:00:27', '2008-02-26 00:37:52', 2, 1);
INSERT INTO `client` VALUES (664, 'Angela Dunn', '5108 091099', 'angeladunn7@mail.com', 742567, 1083, '2000-09-29 01:18:00', '2007-01-06 02:38:40', 2, 1);
INSERT INTO `client` VALUES (665, '尹子韬', '70-4295-7289', 'zitaoyin4@outlook.com', 789530, 919, '2004-04-06 12:06:40', '2017-08-18 00:28:35', 2, 1);
INSERT INTO `client` VALUES (666, 'Ota Rin', '(121) 924 2661', 'ota8@yahoo.com', 680167, 0, '2011-03-17 18:31:47', '2006-02-25 12:43:56', 2, 0);
INSERT INTO `client` VALUES (667, 'Xiao Jiehong', '718-710-5865', 'xiaoji@gmail.com', 834354, 978, '2015-06-24 02:56:29', '2009-06-16 11:44:47', 0, 1);
INSERT INTO `client` VALUES (668, 'Zou Yunxi', '614-202-0905', 'yunxizo@outlook.com', 389385, 338, '2005-03-07 01:41:24', '2024-07-11 11:26:45', 2, 1);
INSERT INTO `client` VALUES (669, 'Lo Hui Mei', '174-6156-6647', 'huimeilo03@outlook.com', 521189, 0, '2021-01-13 14:31:45', '2013-03-13 20:58:35', 2, 0);
INSERT INTO `client` VALUES (670, '萧璐', '330-644-6805', 'luxiao1@icloud.com', 776326, 701, '2022-05-23 18:31:16', '2017-03-24 01:31:47', 0, 0);
INSERT INTO `client` VALUES (671, 'Gu Zhennan', '3-1230-3385', 'zhegu@outlook.com', 118896, 838, '2006-06-12 18:30:29', '2012-06-25 02:57:08', 0, 1);
INSERT INTO `client` VALUES (672, 'Gao Yunxi', '7243 775039', 'yung59@icloud.com', 997699, 418, '2004-04-27 17:47:15', '2002-09-20 09:14:21', 2, 1);
INSERT INTO `client` VALUES (673, 'Shing On Kay', '(161) 396 5333', 'shinok@gmail.com', 635840, 753, '2002-11-17 13:06:17', '2020-04-13 09:17:08', 1, 0);
INSERT INTO `client` VALUES (674, 'Bradley Stephens', '212-535-3057', 'bradlste@icloud.com', 525857, 406, '2022-02-24 14:43:38', '2007-05-11 04:43:09', 2, 1);
INSERT INTO `client` VALUES (675, '史岚', '90-7829-9785', 'lanshi3@hotmail.com', 585238, 473, '2015-12-22 01:13:30', '2008-05-11 07:55:51', 0, 1);
INSERT INTO `client` VALUES (676, 'Tang Yunxi', '312-062-0645', 'tany8@gmail.com', 951854, 511, '2018-08-05 20:26:50', '2001-06-13 14:15:29', 1, 0);
INSERT INTO `client` VALUES (677, 'Angela Henry', '760-266-6573', 'henange@icloud.com', 295213, 581, '2002-02-12 23:54:10', '2011-01-10 14:30:52', 1, 1);
INSERT INTO `client` VALUES (678, 'Troy Spencer', '10-3585-4670', 'spetr@gmail.com', 270724, 0, '2023-06-04 19:55:14', '2000-08-29 02:31:04', 0, 0);
INSERT INTO `client` VALUES (679, 'Miu Hok Yau', '7770 822334', 'hym@outlook.com', 158904, 1109, '2018-01-04 18:24:21', '2000-01-08 11:00:52', 0, 0);
INSERT INTO `client` VALUES (680, 'Wu Jialun', '213-279-4283', 'wujial10@outlook.com', 359194, 1008, '2023-06-29 14:43:04', '2022-02-17 10:23:29', 1, 0);
INSERT INTO `client` VALUES (681, 'Paul Marshall', '135-8405-2140', 'pamarshall@mail.com', 411271, 907, '2012-06-20 02:08:29', '2012-12-01 04:19:11', 1, 0);
INSERT INTO `client` VALUES (682, 'Kobayashi Aoshi', '141-3905-9208', 'aoshiko@mail.com', 775102, 835, '2013-10-31 02:00:28', '2008-06-15 11:26:36', 1, 1);
INSERT INTO `client` VALUES (683, 'Lu Shihan', '614-736-4084', 'lushih95@mail.com', 725081, 650, '2005-02-22 03:17:06', '2013-10-07 21:20:24', 0, 1);
INSERT INTO `client` VALUES (684, 'Dai Ziyi', '5277 802891', 'dai69@icloud.com', 136809, 0, '2005-07-30 09:07:04', '2024-01-12 10:57:20', 1, 0);
INSERT INTO `client` VALUES (685, 'Lo Tsz Hin', '(20) 9173 4386', 'lo1@gmail.com', 243900, 1199, '2003-03-22 21:15:55', '2017-10-12 01:35:02', 1, 1);
INSERT INTO `client` VALUES (686, 'Fujii Rin', '7871 954884', 'fujiiri@hotmail.com', 63933, 0, '2007-03-14 20:14:18', '2004-03-22 04:50:08', 0, 0);
INSERT INTO `client` VALUES (687, 'Ernest Scott', '21-765-5216', 'scott5@gmail.com', 637691, 774, '2007-06-22 09:16:30', '2020-06-18 10:44:52', 1, 0);
INSERT INTO `client` VALUES (688, 'Lok Wing Sze', '755-962-1240', 'wsl@hotmail.com', 253630, 0, '2003-12-24 17:27:41', '2000-09-21 10:57:17', 1, 0);
INSERT INTO `client` VALUES (689, '薛晓明', '21-911-4314', 'xiaomingxue97@outlook.com', 401546, 1099, '2024-05-21 12:06:14', '2013-07-04 12:58:31', 1, 1);
INSERT INTO `client` VALUES (690, 'Tina Daniels', '312-704-1467', 'danielst97@mail.com', 557833, 1157, '2021-01-13 02:56:43', '2012-09-17 09:00:29', 1, 0);
INSERT INTO `client` VALUES (691, 'Zheng Shihan', '(1865) 19 2418', 'shizheng1@outlook.com', 238099, 915, '2005-07-09 18:09:01', '2009-05-03 21:42:32', 2, 1);
INSERT INTO `client` VALUES (692, 'Yeow Lik Sun', '312-613-4138', 'liky7@icloud.com', 705468, 279, '2005-06-20 18:56:41', '2009-11-12 01:58:25', 0, 0);
INSERT INTO `client` VALUES (693, '金嘉伦', '(1865) 09 9886', 'jjialun19@yahoo.com', 692766, 1057, '2007-04-30 14:47:02', '2024-07-26 11:17:45', 1, 0);
INSERT INTO `client` VALUES (694, 'Gong Lu', '330-650-0927', 'lugong@outlook.com', 218312, 1000, '2016-04-26 12:53:33', '2024-09-17 21:30:45', 2, 1);
INSERT INTO `client` VALUES (695, 'Shi Zitao', '90-7205-2701', 'shizitao@mail.com', 690617, 900, '2004-10-01 03:19:02', '2005-12-16 00:22:01', 1, 1);
INSERT INTO `client` VALUES (696, 'Kwan Ching Wan', '144-1856-9223', 'cwkw04@outlook.com', 98112, 846, '2021-01-16 04:59:27', '2011-10-09 19:00:59', 2, 0);
INSERT INTO `client` VALUES (697, 'Alan Bell', '(1223) 61 5965', 'alan93@gmail.com', 507153, 458, '2013-01-27 10:03:31', '2016-11-06 15:56:43', 0, 1);
INSERT INTO `client` VALUES (698, '彭子异', '183-3933-3804', 'pengziyi6@outlook.com', 137500, 0, '2010-09-28 17:00:22', '2013-12-07 19:42:55', 2, 0);
INSERT INTO `client` VALUES (699, 'Ma Jialun', '142-3572-6634', 'ma1960@outlook.com', 933324, 0, '2018-12-20 04:51:54', '2021-07-18 04:35:03', 2, 0);
INSERT INTO `client` VALUES (700, 'Tong Wai Lam', '312-124-7253', 'twl@hotmail.com', 34369, 462, '2002-02-06 08:36:56', '2012-07-03 01:48:26', 2, 1);
INSERT INTO `client` VALUES (701, 'Wada Itsuki', '199-6167-4803', 'wi88@gmail.com', 575576, 640, '2000-05-07 15:57:31', '2013-09-06 07:11:18', 2, 0);
INSERT INTO `client` VALUES (702, 'Scott Carter', '90-9399-2965', 'scocarter@icloud.com', 899976, 1161, '2018-08-03 14:19:25', '2020-12-27 06:10:40', 2, 0);
INSERT INTO `client` VALUES (703, 'Miyamoto Ayano', '3-1846-8501', 'aymi@icloud.com', 185992, 1084, '2010-09-29 11:53:40', '2022-05-26 00:00:07', 2, 1);
INSERT INTO `client` VALUES (704, 'Lok Siu Wai', '755-862-8365', 'siuwai18@hotmail.com', 11149, 307, '2013-06-19 15:53:11', '2004-11-27 05:51:38', 2, 1);
INSERT INTO `client` VALUES (705, '冯子异', '760-2472-8476', 'zf15@icloud.com', 614476, 761, '2007-11-05 13:48:49', '2015-04-09 01:00:16', 0, 1);
INSERT INTO `client` VALUES (706, 'Fan Ho Yin', '3-8393-4356', 'fanhy1@mail.com', 340548, 1172, '2002-03-14 04:45:59', '2023-05-15 07:49:44', 2, 0);
INSERT INTO `client` VALUES (707, 'Liang Ziyi', '330-832-9360', 'ziylia1@hotmail.com', 776746, 961, '2020-07-22 10:53:32', '2004-11-26 21:55:25', 1, 0);
INSERT INTO `client` VALUES (708, 'Pang Ka Ling', '52-864-4835', 'klpang93@outlook.com', 402743, 441, '2013-06-28 04:09:42', '2013-01-31 01:45:33', 1, 1);
INSERT INTO `client` VALUES (709, 'Man Wai Han', '175-6684-2846', 'man307@icloud.com', 19466, 651, '2016-09-15 19:57:46', '2020-10-05 20:10:20', 0, 1);
INSERT INTO `client` VALUES (710, 'Feng Xiaoming', '7736 112590', 'fenxia@icloud.com', 615130, 1198, '2014-05-14 07:21:52', '2017-05-19 18:57:35', 1, 0);
INSERT INTO `client` VALUES (711, 'Nishimura Itsuki', '182-3796-4142', 'itsuki53@yahoo.com', 666969, 737, '2002-04-25 00:22:03', '2021-02-08 03:55:07', 1, 1);
INSERT INTO `client` VALUES (712, 'Shi Xiaoming', '160-1896-1950', 'xiaomshi@hotmail.com', 104786, 1140, '2022-03-28 20:43:01', '2002-01-21 19:37:22', 2, 1);
INSERT INTO `client` VALUES (713, 'Murata Hazuki', '171-1080-5926', 'muratahazuki@gmail.com', 772908, 1198, '2006-03-27 18:40:45', '2022-07-05 09:17:49', 1, 1);
INSERT INTO `client` VALUES (714, 'Yau Hiu Tung', '90-3373-8482', 'yaht76@outlook.com', 112464, 1140, '2001-12-07 21:30:50', '2020-10-17 11:42:12', 1, 0);
INSERT INTO `client` VALUES (715, 'Qin Xiaoming', '70-6028-9693', 'xiaomingqin220@hotmail.com', 302404, 227, '2022-12-06 19:46:19', '2000-09-15 22:41:35', 0, 0);
INSERT INTO `client` VALUES (716, 'Gladys Dunn', '80-3202-9219', 'gladysdunn2018@hotmail.com', 87784, 388, '2005-02-27 10:30:25', '2014-02-24 07:30:07', 2, 1);
INSERT INTO `client` VALUES (717, 'Jamie Lopez', '(151) 421 1919', 'ljamie7@icloud.com', 312678, 500, '2009-10-15 08:02:31', '2007-03-24 01:26:40', 2, 1);
INSERT INTO `client` VALUES (718, 'Koyama Aoi', '80-5427-7065', 'koya@yahoo.com', 598433, 442, '2006-12-06 17:25:25', '2010-06-05 07:38:34', 0, 0);
INSERT INTO `client` VALUES (719, 'Aoki Ryota', '755-9110-9777', 'ryotaaoki723@gmail.com', 903159, 221, '2005-09-24 17:03:29', '2009-12-17 21:17:49', 2, 0);
INSERT INTO `client` VALUES (720, 'Valerie Simmons', '3-3902-6574', 'valerie72@gmail.com', 694972, 1174, '2008-02-08 23:39:40', '2011-08-05 07:37:34', 2, 1);
INSERT INTO `client` VALUES (721, 'Tamura Daisuke', '10-451-6512', 'tamud@mail.com', 424985, 0, '2009-09-03 04:42:13', '2005-05-16 07:05:33', 1, 0);
INSERT INTO `client` VALUES (722, 'Lu Ziyi', '212-624-4846', 'ziylu@gmail.com', 221618, 0, '2022-10-30 05:56:36', '2005-02-02 21:25:02', 1, 0);
INSERT INTO `client` VALUES (723, 'Sakurai Takuya', '838-588-5624', 'sata3@icloud.com', 941906, 804, '2007-07-25 22:14:27', '2019-03-17 11:32:33', 1, 1);
INSERT INTO `client` VALUES (724, 'Xiong Yunxi', '5200 636723', 'yxiong9@outlook.com', 951657, 392, '2004-12-15 06:11:08', '2017-05-04 17:31:14', 2, 0);
INSERT INTO `client` VALUES (725, '谭云熙', '191-2124-7707', 'yunxitan@mail.com', 889336, 1103, '2006-07-02 07:28:17', '2009-10-11 09:12:08', 1, 1);
INSERT INTO `client` VALUES (726, 'Takada Ayato', '136-5147-2329', 'ayattak@gmail.com', 203361, 0, '2014-04-10 19:37:12', '2012-07-14 01:44:32', 2, 0);
INSERT INTO `client` VALUES (727, 'Ogawa Ayato', '838-567-3665', 'ayatogawa629@gmail.com', 241886, 0, '2015-03-15 04:12:48', '2023-05-27 12:20:09', 2, 0);
INSERT INTO `client` VALUES (728, 'Lu Yunxi', '330-644-2013', 'ylu6@outlook.com', 423566, 0, '2006-12-22 10:26:09', '2008-04-01 04:40:44', 1, 0);
INSERT INTO `client` VALUES (729, 'Shen Xiaoming', '5131 195343', 'shexiao@icloud.com', 86623, 352, '2010-01-21 17:44:20', '2012-03-09 03:09:52', 2, 1);
INSERT INTO `client` VALUES (730, '刘震南', '3-1972-5620', 'liu8@outlook.com', 537252, 836, '2023-02-02 19:30:52', '2023-06-23 01:05:13', 1, 1);
INSERT INTO `client` VALUES (731, 'Pan Zhennan', '330-741-5459', 'zhepan@gmail.com', 2846, 461, '2010-07-18 05:01:24', '2005-01-09 09:49:57', 2, 1);
INSERT INTO `client` VALUES (732, 'Miura Yuto', '5795 266556', 'miura3@yahoo.com', 645719, 979, '2022-10-27 03:54:21', '2005-12-22 00:58:31', 0, 1);
INSERT INTO `client` VALUES (733, 'Siu Chun Yu', '5792 486476', 'cysi@gmail.com', 578919, 566, '2005-12-07 13:57:01', '2004-09-28 08:21:46', 0, 0);
INSERT INTO `client` VALUES (734, 'Roy Jones', '312-029-9624', 'jonesroy@gmail.com', 349317, 614, '2016-10-23 17:25:55', '2013-02-24 04:43:01', 1, 1);
INSERT INTO `client` VALUES (735, 'Kwok Wai Lam', '312-324-6794', 'kwokwailam@outlook.com', 699253, 445, '2023-11-28 10:44:23', '2014-08-19 20:37:37', 1, 1);
INSERT INTO `client` VALUES (736, 'Yin Ho Yin', '(121) 895 4954', 'yihoyin@hotmail.com', 18057, 475, '2008-07-04 21:10:03', '2002-11-18 16:34:07', 2, 1);
INSERT INTO `client` VALUES (737, 'Nomura Kaito', '212-240-5010', 'kain08@hotmail.com', 199067, 536, '2003-10-19 05:32:20', '2006-12-18 04:03:12', 2, 0);
INSERT INTO `client` VALUES (738, '卢秀英', '66-143-4144', 'luxiuying10@mail.com', 867153, 233, '2007-09-20 16:51:33', '2004-10-05 09:57:35', 1, 0);
INSERT INTO `client` VALUES (739, 'Takeuchi Hikari', '(20) 8026 8918', 'hikaritakeuchi@outlook.com', 466283, 588, '2006-11-21 14:54:43', '2016-07-23 19:05:53', 2, 1);
INSERT INTO `client` VALUES (740, '高云熙', '212-744-0812', 'yunxig08@hotmail.com', 802933, 501, '2002-07-31 15:18:24', '2007-02-22 15:39:42', 1, 1);
INSERT INTO `client` VALUES (741, '段子韬', '(1223) 30 2987', 'zitaoduan10@icloud.com', 707299, 0, '2007-11-21 14:27:42', '2001-01-14 03:34:02', 1, 0);
INSERT INTO `client` VALUES (742, 'Yuen Chun Yu', '90-6823-0602', 'yuenchunyu86@outlook.com', 195883, 1183, '2009-03-07 10:46:14', '2009-09-17 01:35:28', 2, 0);
INSERT INTO `client` VALUES (743, 'Dai Wai Lam', '133-8309-2780', 'dawl@gmail.com', 408713, 824, '2021-09-11 07:01:17', '2002-11-30 17:11:41', 0, 1);
INSERT INTO `client` VALUES (744, '蔡璐', '330-291-2954', 'clu7@gmail.com', 498600, 897, '2012-02-18 20:51:23', '2014-07-13 18:18:42', 1, 0);
INSERT INTO `client` VALUES (745, 'Su Xiuying', '755-8560-4285', 'xs1014@hotmail.com', 934648, 396, '2010-12-12 19:05:44', '2001-09-21 00:34:13', 0, 1);
INSERT INTO `client` VALUES (746, '汪詩涵', '838-915-6747', 'swa@mail.com', 797252, 0, '2000-09-19 11:47:23', '2007-10-06 00:55:19', 0, 0);
INSERT INTO `client` VALUES (747, 'Dorothy Carter', '10-7796-1998', 'carterdoro@hotmail.com', 650535, 385, '2007-06-23 00:25:17', '2019-09-30 03:47:55', 1, 1);
INSERT INTO `client` VALUES (748, 'Yue Fu Shing', '718-506-3800', 'yufs1229@gmail.com', 503439, 1010, '2015-01-26 21:12:29', '2019-07-12 10:43:05', 1, 1);
INSERT INTO `client` VALUES (749, '黎安琪', '70-6709-1342', 'anqili1@hotmail.com', 852248, 839, '2016-12-25 06:00:48', '2006-10-13 19:10:59', 2, 0);
INSERT INTO `client` VALUES (750, 'Kinoshita Ikki', '(20) 4366 8344', 'kinoshitaik@mail.com', 566608, 772, '2016-12-27 12:46:29', '2004-02-18 18:51:07', 2, 0);
INSERT INTO `client` VALUES (751, 'Diane Robertson', '74-246-4099', 'robedi@hotmail.com', 23496, 0, '2021-12-29 17:47:38', '2008-02-01 19:51:03', 0, 0);
INSERT INTO `client` VALUES (752, 'Ueno Hazuki', '74-243-8999', 'uenoha18@icloud.com', 897011, 0, '2001-01-10 13:48:57', '2011-04-27 22:35:47', 1, 0);
INSERT INTO `client` VALUES (753, '梁安琪', '(161) 655 0106', 'anqiliang8@icloud.com', 656021, 963, '2019-12-22 22:46:53', '2016-09-18 00:35:33', 1, 0);
INSERT INTO `client` VALUES (754, 'Douglas Boyd', '80-7050-2741', 'boyddouglas825@outlook.com', 663576, 988, '2018-01-29 16:11:20', '2008-09-10 00:33:35', 1, 1);
INSERT INTO `client` VALUES (755, 'Endo Riku', '312-317-8921', 'rikuendo@outlook.com', 710397, 850, '2014-03-15 17:40:35', '2005-12-23 02:18:46', 1, 1);
INSERT INTO `client` VALUES (756, 'Yoshida Kasumi', '213-770-0496', 'kasumiy@gmail.com', 311095, 0, '2023-05-30 04:59:41', '2017-05-28 20:02:14', 0, 0);
INSERT INTO `client` VALUES (757, '林致远', '(1865) 42 4528', 'lizhi214@icloud.com', 50687, 0, '2024-03-28 02:48:43', '2022-05-19 07:32:32', 1, 0);
INSERT INTO `client` VALUES (758, 'Pan Xiuying', '20-809-4243', 'px7@outlook.com', 40671, 0, '2004-10-13 14:24:03', '2023-07-16 21:26:24', 1, 0);
INSERT INTO `client` VALUES (759, 'Wan Ming', '838-523-7747', 'mwan@mail.com', 117533, 518, '2014-02-28 12:19:50', '2021-03-05 11:19:57', 2, 1);
INSERT INTO `client` VALUES (760, 'Han Jialun', '212-019-3245', 'jialun1020@yahoo.com', 947521, 993, '2001-03-27 19:49:02', '2008-09-22 03:17:23', 1, 1);
INSERT INTO `client` VALUES (761, '侯子韬', '7340 339327', 'zitaoho@gmail.com', 8656, 981, '2023-08-19 06:19:24', '2021-07-12 06:36:00', 2, 1);
INSERT INTO `client` VALUES (762, 'Sasaki Minato', '158-5717-4092', 'sminato5@icloud.com', 813104, 483, '2013-05-12 00:21:02', '2022-04-22 05:59:59', 2, 1);
INSERT INTO `client` VALUES (763, 'Xiao Zhiyuan', '90-7259-3675', 'zhiyuan87@mail.com', 340991, 401, '2015-01-01 01:20:34', '2018-05-03 05:26:42', 1, 0);
INSERT INTO `client` VALUES (764, 'Sit Fu Shing', '755-2203-3272', 'fushingsit@yahoo.com', 790478, 0, '2007-10-01 11:19:18', '2011-01-23 19:00:10', 0, 0);
INSERT INTO `client` VALUES (765, 'Paula Ross', '20-9223-2383', 'ross813@gmail.com', 993895, 293, '2002-11-03 14:45:30', '2012-11-06 12:48:10', 2, 0);
INSERT INTO `client` VALUES (766, 'Takeda Ikki', '(161) 540 2090', 'ikkit@icloud.com', 742121, 272, '2018-01-10 16:48:35', '2007-01-24 22:17:47', 2, 0);
INSERT INTO `client` VALUES (767, '吕子韬', '195-3022-6237', 'zitaolu919@mail.com', 44923, 481, '2024-09-06 16:21:24', '2003-10-12 06:08:37', 1, 0);
INSERT INTO `client` VALUES (768, 'Jin Xiaoming', '66-009-0668', 'jin2@icloud.com', 147155, 1064, '2004-12-15 14:37:51', '2013-01-10 18:02:41', 0, 0);
INSERT INTO `client` VALUES (769, 'Morita Aoshi', '3-1417-1951', 'aoshim@gmail.com', 512866, 1128, '2023-12-10 21:11:36', '2014-11-19 18:55:30', 1, 1);
INSERT INTO `client` VALUES (770, 'Sheh Wing Kuen', '(161) 908 1043', 'sheh2018@outlook.com', 687649, 381, '2013-04-18 14:09:31', '2005-01-29 08:47:32', 1, 1);
INSERT INTO `client` VALUES (771, 'Ying Ching Wan', '213-006-9190', 'ycw@icloud.com', 921660, 936, '2017-11-16 15:52:38', '2012-10-19 22:13:26', 2, 1);
INSERT INTO `client` VALUES (772, 'Tanaka Akina', '(1223) 45 9338', 'akinat@gmail.com', 166461, 0, '2016-06-10 09:19:43', '2008-04-10 17:24:45', 1, 0);
INSERT INTO `client` VALUES (773, 'Hashimoto Kaito', '312-224-3213', 'kaitoh308@gmail.com', 853493, 1101, '2000-08-12 13:08:55', '2008-11-01 09:34:47', 0, 1);
INSERT INTO `client` VALUES (774, 'Matsuda Itsuki', '212-887-0737', 'matsuda304@icloud.com', 697283, 0, '2011-01-26 22:16:54', '2005-09-29 10:06:32', 0, 0);
INSERT INTO `client` VALUES (775, 'Fu Zhennan', '5178 897687', 'fz1012@gmail.com', 125432, 0, '2019-01-23 21:07:32', '2002-12-13 05:52:57', 1, 0);
INSERT INTO `client` VALUES (776, 'Fujii Nanami', '760-4964-9653', 'fujiin1210@outlook.com', 343350, 1138, '2004-04-25 05:41:33', '2002-06-02 14:52:50', 1, 1);
INSERT INTO `client` VALUES (777, 'Lee Ka Ming', '184-0672-9931', 'lee3@mail.com', 427039, 477, '2024-02-04 02:24:07', '2013-08-11 04:57:44', 0, 1);
INSERT INTO `client` VALUES (778, '顾云熙', '66-570-8265', 'ygu@outlook.com', 180017, 1113, '2002-01-21 05:28:17', '2007-10-31 23:52:48', 0, 0);
INSERT INTO `client` VALUES (779, 'Meng Ziyi', '5959 529666', 'mziyi@hotmail.com', 496771, 902, '2000-11-01 01:51:32', '2023-07-04 19:41:14', 0, 1);
INSERT INTO `client` VALUES (780, 'Lee Hunter', '161-8324-6338', 'huntl@gmail.com', 182236, 675, '2006-07-15 04:02:33', '2020-03-12 05:10:42', 1, 1);
INSERT INTO `client` VALUES (781, 'Mok Tsz Ching', '74-002-2405', 'mok9@yahoo.com', 404702, 852, '2014-06-08 16:48:33', '2024-09-04 14:21:57', 0, 1);
INSERT INTO `client` VALUES (782, 'Kong Xiuying', '614-227-0313', 'xiuyingkong@outlook.com', 821265, 584, '2003-12-25 13:04:06', '2017-02-11 15:45:56', 1, 1);
INSERT INTO `client` VALUES (783, 'Mo Chun Yu', '90-1785-7267', 'cymo@outlook.com', 328238, 231, '2001-07-05 03:18:49', '2022-07-06 03:40:06', 1, 1);
INSERT INTO `client` VALUES (784, 'Carmen Simpson', '80-4470-2894', 'simpsonc5@outlook.com', 853740, 596, '2022-03-29 07:11:25', '2022-02-17 12:46:35', 0, 1);
INSERT INTO `client` VALUES (785, 'Miura Airi', '769-952-6588', 'airmiura@outlook.com', 443542, 0, '2022-10-23 09:16:57', '2015-10-07 17:05:37', 2, 0);
INSERT INTO `client` VALUES (786, 'Ma Zhiyuan', '312-257-9703', 'zm6@yahoo.com', 884298, 1103, '2001-07-23 21:53:34', '2016-03-19 11:43:35', 1, 1);
INSERT INTO `client` VALUES (787, 'Rosa Hunter', '90-6099-2390', 'hunterrosa43@mail.com', 576411, 671, '2004-06-12 02:46:57', '2021-11-10 08:47:27', 0, 1);
INSERT INTO `client` VALUES (788, '姚晓明', '(20) 5008 1317', 'yaoxiaom@outlook.com', 496617, 323, '2015-04-04 12:36:08', '2015-01-18 12:24:49', 0, 1);
INSERT INTO `client` VALUES (789, 'Tang Fat', '312-143-0105', 'tangfat616@mail.com', 781320, 449, '2006-02-21 16:22:57', '2024-11-14 13:25:19', 2, 1);
INSERT INTO `client` VALUES (790, 'Norman Dunn', '760-3019-2480', 'dunnnorman@icloud.com', 894731, 389, '2021-05-13 18:27:36', '2008-01-28 19:34:56', 1, 1);
INSERT INTO `client` VALUES (791, 'Valerie Mitchell', '5790 534877', 'vmitchell@hotmail.com', 817696, 334, '2013-12-13 08:54:57', '2008-08-09 05:12:31', 1, 1);
INSERT INTO `client` VALUES (792, 'Sato Kenta', '7939 538134', 'satokenta3@icloud.com', 585962, 0, '2018-02-13 14:32:51', '2018-08-17 17:06:13', 0, 0);
INSERT INTO `client` VALUES (793, 'Mo Sai Wing', '5807 579061', 'swmo@gmail.com', 989696, 1060, '2015-02-14 10:20:40', '2014-06-29 15:48:16', 0, 1);
INSERT INTO `client` VALUES (794, '熊致远', '212-918-0596', 'zhiyuan1103@gmail.com', 144297, 781, '2008-03-23 05:18:33', '2008-07-29 07:34:09', 0, 1);
INSERT INTO `client` VALUES (795, 'Suzuki Daisuke', '90-7369-3234', 'dasuzuki@yahoo.com', 279336, 741, '2009-04-15 10:33:19', '2022-02-22 01:29:17', 2, 0);
INSERT INTO `client` VALUES (796, '萧岚', '838-470-5556', 'xiaolan@mail.com', 362106, 951, '2023-10-23 02:01:44', '2013-01-23 20:35:25', 1, 1);
INSERT INTO `client` VALUES (797, '钟震南', '192-4596-1698', 'zhennanzhon@hotmail.com', 551278, 872, '2021-10-30 03:45:37', '2001-06-20 02:27:36', 1, 1);
INSERT INTO `client` VALUES (798, 'Cui Yuning', '312-398-5185', 'cuy@outlook.com', 236767, 0, '2007-04-20 16:27:13', '2008-10-31 17:06:23', 1, 0);
INSERT INTO `client` VALUES (799, 'Fujita Mitsuki', '20-763-5790', 'fujitam@gmail.com', 559439, 1059, '2012-10-03 04:43:49', '2015-01-27 18:09:20', 1, 0);
INSERT INTO `client` VALUES (800, 'So Sum Wing', '212-154-5940', 'sumwing10@outlook.com', 123979, 531, '2009-04-21 08:32:45', '2023-08-04 23:36:00', 2, 1);
INSERT INTO `client` VALUES (801, 'Tin Tak Wah', '(116) 191 1412', 'tin720@outlook.com', 822862, 731, '2017-11-20 05:36:15', '2024-08-08 04:43:45', 1, 0);
INSERT INTO `client` VALUES (802, 'Debbie Garcia', '143-5651-3785', 'garciade@icloud.com', 593022, 403, '2002-08-30 01:51:40', '2013-12-08 16:10:18', 0, 0);
INSERT INTO `client` VALUES (803, 'Cheng Xiuying', '5707 559593', 'cxiu819@icloud.com', 311739, 595, '2006-06-04 15:09:31', '2006-11-09 08:51:25', 2, 0);
INSERT INTO `client` VALUES (804, 'Qiu Lan', '20-125-3929', 'laqiu@yahoo.com', 618287, 1163, '2020-02-10 15:24:48', '2009-01-26 02:24:17', 1, 1);
INSERT INTO `client` VALUES (805, 'Hu Rui', '212-218-8168', 'ruh1219@hotmail.com', 996454, 1108, '2007-10-20 04:48:37', '2000-04-12 17:58:58', 1, 0);
INSERT INTO `client` VALUES (806, 'Tsui Wing Kuen', '838-373-1831', 'tsui1979@icloud.com', 611367, 483, '2010-10-24 13:12:34', '2016-12-08 19:06:34', 1, 0);
INSERT INTO `client` VALUES (807, 'Chiba Ikki', '718-619-3879', 'chiik811@outlook.com', 538753, 0, '2004-11-15 00:17:40', '2001-04-21 01:05:36', 1, 0);
INSERT INTO `client` VALUES (808, 'Lau Hok Yau', '80-5072-3105', 'hylau53@hotmail.com', 896567, 737, '2009-08-16 12:17:32', '2022-03-18 15:26:38', 0, 1);
INSERT INTO `client` VALUES (809, 'Sara Peterson', '330-346-3765', 'peterson403@gmail.com', 8951, 311, '2003-12-30 12:01:24', '2022-12-23 22:58:33', 1, 1);
INSERT INTO `client` VALUES (810, 'Tan Shihan', '194-4575-8553', 'tan85@outlook.com', 674793, 0, '2010-07-25 02:44:11', '2004-11-30 23:42:44', 1, 0);
INSERT INTO `client` VALUES (811, 'Monica Chen', '133-2432-6925', 'chen308@mail.com', 628331, 367, '2004-01-28 11:06:39', '2004-06-21 22:49:12', 2, 0);
INSERT INTO `client` VALUES (812, 'Liang Jialun', '163-8299-3594', 'liangj215@mail.com', 689288, 376, '2000-07-17 10:24:54', '2003-02-06 09:19:23', 0, 1);
INSERT INTO `client` VALUES (813, 'Rosa Roberts', '137-7114-6772', 'roberros705@gmail.com', 760501, 976, '2003-05-10 16:04:52', '2003-11-07 04:50:40', 1, 0);
INSERT INTO `client` VALUES (814, '邱安琪', '70-0930-4156', 'anqi1125@hotmail.com', 810853, 535, '2018-12-15 04:53:18', '2009-09-27 12:07:47', 0, 1);
INSERT INTO `client` VALUES (815, '孟秀英', '838-163-2013', 'xiuyingm@yahoo.com', 152018, 795, '2018-02-26 11:55:02', '2002-10-29 02:35:42', 0, 1);
INSERT INTO `client` VALUES (816, '毛子异', '7892 595326', 'ziyimao@gmail.com', 429931, 498, '2017-11-08 22:08:30', '2020-01-23 12:06:56', 2, 1);
INSERT INTO `client` VALUES (817, '薛秀英', '614-732-7519', 'xiuyingxu@icloud.com', 810940, 949, '2020-05-27 19:53:12', '2016-06-21 08:33:08', 2, 0);
INSERT INTO `client` VALUES (818, 'Ho Ching Wan', '138-9901-4742', 'hochingwan110@gmail.com', 704506, 1170, '2015-01-13 01:53:46', '2011-11-14 23:12:51', 0, 1);
INSERT INTO `client` VALUES (819, 'Jiang Yuning', '74-107-6748', 'yuninj@mail.com', 266016, 441, '2012-03-16 09:45:44', '2002-09-04 21:49:34', 1, 0);
INSERT INTO `client` VALUES (820, 'Kimura Yota', '3-1404-2354', 'kimurayota@icloud.com', 558666, 338, '2011-05-21 19:46:06', '2010-02-05 21:48:01', 2, 1);
INSERT INTO `client` VALUES (821, 'Mak Fat', '171-1322-0350', 'mafat@hotmail.com', 283035, 454, '2011-10-13 05:10:53', '2021-11-02 06:52:46', 2, 0);
INSERT INTO `client` VALUES (822, 'Lawrence Hicks', '52-551-9290', 'lawhick@gmail.com', 583923, 1185, '2011-05-21 07:09:19', '2007-06-24 03:56:35', 1, 0);
INSERT INTO `client` VALUES (823, '马子异', '(121) 284 2524', 'maz@icloud.com', 902262, 233, '2015-10-29 07:53:42', '2022-03-08 19:56:10', 0, 0);
INSERT INTO `client` VALUES (824, 'Margaret Chen', '330-889-0100', 'chenmargaret15@gmail.com', 991956, 389, '2020-03-02 04:36:27', '2004-10-04 09:27:21', 0, 1);
INSERT INTO `client` VALUES (825, 'Jia Lan', '(1865) 03 7855', 'jialan@gmail.com', 342833, 1101, '2019-04-22 15:51:06', '2023-07-13 09:55:28', 1, 0);
INSERT INTO `client` VALUES (826, 'Lei Xiuying', '192-6173-1163', 'xle@icloud.com', 247560, 244, '2000-12-22 23:09:55', '2023-06-17 14:51:38', 0, 0);
INSERT INTO `client` VALUES (827, '谢詩涵', '11-856-9056', 'xieshi7@icloud.com', 670860, 504, '2011-07-25 11:14:23', '2000-03-04 13:50:40', 1, 0);
INSERT INTO `client` VALUES (828, 'Saito Hina', '213-000-7068', 'sahin@outlook.com', 906970, 361, '2017-08-09 07:34:43', '2005-09-11 14:13:39', 2, 0);
INSERT INTO `client` VALUES (829, 'Allen Herrera', '7899 345019', 'herreraa@gmail.com', 664779, 0, '2006-09-09 18:06:46', '2005-03-07 08:31:22', 2, 0);
INSERT INTO `client` VALUES (830, 'Kojima Ikki', '150-2046-4108', 'kikki@yahoo.com', 415094, 0, '2013-04-04 09:36:00', '2017-10-25 19:20:34', 1, 0);
INSERT INTO `client` VALUES (831, 'Mui Tin Wing', '5306 310458', 'tinwingm@mail.com', 747994, 0, '2002-12-31 18:18:22', '2000-01-03 17:20:10', 2, 0);
INSERT INTO `client` VALUES (832, '吕嘉伦', '11-049-5380', 'lujialun@gmail.com', 257511, 428, '2015-11-09 17:26:32', '2014-03-09 22:38:57', 0, 1);
INSERT INTO `client` VALUES (833, 'Vincent Mitchell', '193-8633-5450', 'mitchvi17@yahoo.com', 28433, 1126, '2002-10-05 01:43:27', '2018-05-08 09:08:56', 1, 1);
INSERT INTO `client` VALUES (834, '郑岚', '312-738-7544', 'zhenglan@gmail.com', 329112, 875, '2021-02-05 17:37:16', '2009-06-03 01:00:42', 1, 1);
INSERT INTO `client` VALUES (835, 'Wu Zhennan', '760-955-0544', 'wuz@outlook.com', 647897, 467, '2017-10-12 09:49:08', '2004-11-04 01:40:11', 0, 1);
INSERT INTO `client` VALUES (836, 'Harada Rin', '21-3075-5525', 'haradarin@outlook.com', 852896, 882, '2015-07-13 09:14:26', '2006-11-16 21:30:44', 0, 1);
INSERT INTO `client` VALUES (837, '熊震南', '20-620-2938', 'zhennan3@icloud.com', 581872, 0, '2017-03-05 09:14:08', '2004-08-30 06:16:48', 2, 0);
INSERT INTO `client` VALUES (838, 'Ying Fu Shing', '5766 413639', 'fushingy56@hotmail.com', 659006, 281, '2011-12-19 01:42:07', '2004-12-21 00:58:19', 0, 1);
INSERT INTO `client` VALUES (839, '严秀英', '760-2822-9262', 'yanxiuying@mail.com', 405415, 0, '2013-02-26 18:03:13', '2024-03-15 08:10:18', 1, 0);
INSERT INTO `client` VALUES (840, 'Choi Ka Keung', '212-782-8110', 'chkk2@gmail.com', 721416, 378, '2021-08-06 15:46:48', '2006-11-17 14:53:50', 1, 1);
INSERT INTO `client` VALUES (841, 'Xia Zhennan', '7828 800168', 'zhennanxia@yahoo.com', 288179, 762, '2015-07-08 13:10:05', '2009-05-05 16:23:31', 1, 1);
INSERT INTO `client` VALUES (842, '丁岚', '312-712-3936', 'ladin@mail.com', 500910, 667, '2022-03-25 00:13:49', '2022-11-12 15:56:51', 1, 1);
INSERT INTO `client` VALUES (843, 'He Xiuying', '838-496-2210', 'hex609@icloud.com', 478971, 451, '2017-12-25 20:04:13', '2001-06-18 05:05:12', 1, 1);
INSERT INTO `client` VALUES (844, 'Liang Lu', '28-5042-7723', 'lulian3@gmail.com', 715676, 1063, '2022-05-06 08:48:26', '2012-05-04 07:43:43', 1, 0);
INSERT INTO `client` VALUES (845, 'Ito Ryota', '7919 774076', 'itor5@outlook.com', 206107, 289, '2013-06-05 13:38:06', '2010-11-07 14:45:12', 1, 0);
INSERT INTO `client` VALUES (846, 'Siu Tak Wah', '80-5742-5402', 'takwah6@outlook.com', 612056, 689, '2013-12-22 23:55:57', '2010-10-26 11:43:46', 1, 1);
INSERT INTO `client` VALUES (847, 'Lu Jialun', '66-759-8887', 'jialun1949@yahoo.com', 724663, 398, '2022-12-28 20:04:39', '2010-01-15 06:18:54', 0, 1);
INSERT INTO `client` VALUES (848, 'Inoue Ayano', '70-3168-4392', 'inoueayan@gmail.com', 690748, 1171, '2022-04-16 16:05:57', '2021-04-25 05:09:26', 2, 0);
INSERT INTO `client` VALUES (849, 'Hayashi Misaki', '213-119-2525', 'hayashi8@yahoo.com', 63940, 722, '2004-05-13 04:24:15', '2012-10-09 23:47:00', 0, 0);
INSERT INTO `client` VALUES (850, 'Sato Kaito', '183-5147-4285', 'satkaito@icloud.com', 862723, 748, '2020-10-03 18:47:20', '2022-08-17 06:38:22', 2, 1);
INSERT INTO `client` VALUES (851, '林云熙', '66-647-1753', 'yunxil@hotmail.com', 168019, 0, '2007-08-17 13:05:30', '2000-12-27 01:35:13', 0, 0);
INSERT INTO `client` VALUES (852, 'Morita Yuto', '5170 557781', 'yumorita1109@hotmail.com', 233325, 0, '2001-01-14 23:51:56', '2011-12-24 02:25:02', 0, 0);
INSERT INTO `client` VALUES (853, 'Kathy Freeman', '7917 154496', 'kathyfreeman@outlook.com', 119813, 1141, '2013-06-10 02:18:08', '2013-12-24 17:51:38', 1, 1);
INSERT INTO `client` VALUES (854, '郭詩涵', '74-529-6565', 'guoshih209@outlook.com', 133173, 0, '2019-12-09 14:00:00', '2001-10-24 06:01:45', 0, 0);
INSERT INTO `client` VALUES (855, 'Ito Rin', '(151) 523 0187', 'rit@outlook.com', 826274, 532, '2018-12-01 19:58:15', '2017-05-24 17:44:13', 1, 1);
INSERT INTO `client` VALUES (856, 'Arimura Mio', '(1223) 77 8625', 'arimuramio@yahoo.com', 355013, 611, '2023-09-09 22:45:32', '2007-07-07 01:18:01', 2, 0);
INSERT INTO `client` VALUES (857, '韦杰宏', '213-733-0701', 'jwei@gmail.com', 492796, 0, '2016-09-01 00:24:43', '2007-03-26 03:33:15', 2, 0);
INSERT INTO `client` VALUES (858, 'Liang Rui', '11-896-3508', 'liangrui507@outlook.com', 399247, 1038, '2015-11-02 09:37:05', '2011-12-20 08:21:39', 1, 0);
INSERT INTO `client` VALUES (859, 'Liang Zhennan', '755-168-8692', 'zhennanlia@mail.com', 834065, 318, '2007-12-28 21:07:29', '2013-06-24 11:04:51', 0, 0);
INSERT INTO `client` VALUES (860, 'Anita Jordan', '174-4344-4016', 'anitajordan5@outlook.com', 357304, 0, '2021-04-18 09:32:44', '2017-09-20 21:21:15', 1, 0);
INSERT INTO `client` VALUES (861, 'Takagi Mitsuki', '74-370-1985', 'mitsutak@outlook.com', 66074, 279, '2008-09-09 01:35:53', '2008-02-03 19:38:38', 1, 1);
INSERT INTO `client` VALUES (862, '陈致远', '11-454-6183', 'zhiyuan74@gmail.com', 381635, 380, '2016-10-19 08:23:15', '2002-03-10 14:43:26', 2, 0);
INSERT INTO `client` VALUES (863, '孟云熙', '760-9437-6881', 'mengyun@icloud.com', 452710, 243, '2005-03-21 08:07:45', '2008-07-31 03:44:18', 1, 1);
INSERT INTO `client` VALUES (864, '薛秀英', '(151) 351 8620', 'xx4@outlook.com', 546301, 857, '2015-10-30 00:38:11', '2012-01-16 00:07:46', 0, 1);
INSERT INTO `client` VALUES (865, 'Kao Hiu Tung', '52-664-4313', 'hiutung1003@outlook.com', 902799, 228, '2004-01-15 07:14:56', '2019-06-09 19:19:40', 1, 1);
INSERT INTO `client` VALUES (866, 'Yip Kwok Wing', '147-1326-8994', 'kwokwing113@yahoo.com', 553715, 0, '2013-09-18 06:42:18', '2015-11-15 12:59:25', 2, 0);
INSERT INTO `client` VALUES (867, 'Kaneko Mitsuki', '718-841-6049', 'mitsuki710@icloud.com', 255722, 508, '2006-09-15 18:48:31', '2011-01-24 21:50:36', 1, 1);
INSERT INTO `client` VALUES (868, 'Kikuchi Riku', '52-773-2344', 'riku7@gmail.com', 262064, 1010, '2011-04-29 23:13:38', '2008-01-26 00:10:30', 0, 0);
INSERT INTO `client` VALUES (869, 'Ti Tak Wah', '7342 521858', 'takwah722@outlook.com', 60664, 1003, '2014-06-06 02:33:12', '2022-04-15 09:10:55', 0, 1);
INSERT INTO `client` VALUES (870, '戴子异', '140-0556-0008', 'ziyidai2@icloud.com', 851593, 1038, '2023-05-05 06:44:33', '2008-08-02 13:36:31', 1, 0);
INSERT INTO `client` VALUES (871, 'Lam Wai Yee', '164-0466-9465', 'waiyeelam@icloud.com', 702527, 305, '2001-12-27 14:43:03', '2017-04-26 02:19:56', 1, 1);
INSERT INTO `client` VALUES (872, 'Zhu Ziyi', '312-778-9770', 'zhuziyi1943@hotmail.com', 193671, 941, '2002-06-08 05:17:25', '2022-05-03 03:23:21', 0, 1);
INSERT INTO `client` VALUES (873, 'Dai Ho Yin', '718-359-3008', 'hodai3@mail.com', 787164, 1162, '2001-09-15 04:02:22', '2020-12-11 10:39:07', 0, 1);
INSERT INTO `client` VALUES (874, 'Ando Itsuki', '66-366-5296', 'itsuki5@outlook.com', 953733, 800, '2013-11-30 19:49:07', '2004-12-14 00:15:08', 0, 0);
INSERT INTO `client` VALUES (875, 'Tang Chi Ming', '90-6283-4670', 'chimingtang@hotmail.com', 448183, 819, '2006-04-29 06:26:01', '2004-06-17 14:34:51', 2, 0);
INSERT INTO `client` VALUES (876, '杜嘉伦', '760-989-5993', 'jialund6@gmail.com', 366073, 948, '2018-09-01 21:21:23', '2019-11-23 15:13:34', 1, 1);
INSERT INTO `client` VALUES (877, '严秀英', '(151) 011 0651', 'yan8@icloud.com', 367240, 817, '2004-10-06 06:56:30', '2014-08-18 08:17:21', 2, 0);
INSERT INTO `client` VALUES (878, '任致远', '66-383-7783', 'rez608@yahoo.com', 38954, 0, '2024-06-24 17:24:59', '2018-07-20 20:10:56', 1, 0);
INSERT INTO `client` VALUES (879, 'Siu Kwok Ming', '52-263-5679', 'siukm@outlook.com', 268057, 881, '2018-09-26 20:46:28', '2006-10-17 01:51:53', 1, 1);
INSERT INTO `client` VALUES (880, 'Taniguchi Hana', '(116) 771 7519', 'hanat@icloud.com', 327401, 1149, '2007-06-21 05:23:07', '2020-12-15 11:44:04', 0, 1);
INSERT INTO `client` VALUES (881, 'Wu Lan', '213-129-5768', 'wul7@outlook.com', 854189, 0, '2017-03-03 14:02:11', '2019-08-25 10:47:07', 2, 0);
INSERT INTO `client` VALUES (882, 'Dong Lu', '191-9666-5153', 'donlu2015@icloud.com', 424282, 789, '2023-07-17 21:54:29', '2012-06-28 05:15:08', 2, 1);
INSERT INTO `client` VALUES (883, 'Leung Sau Man', '(161) 571 7773', 'lsm@gmail.com', 678008, 897, '2002-05-27 12:54:19', '2007-07-16 12:37:48', 2, 0);
INSERT INTO `client` VALUES (884, 'Lam Tsz Ching', '614-654-1186', 'lamtc@outlook.com', 199316, 218, '2006-02-20 20:58:55', '2017-07-20 02:08:07', 2, 1);
INSERT INTO `client` VALUES (885, 'Tong Ka Keung', '760-641-4697', 'tkk@yahoo.com', 684706, 0, '2009-12-18 22:57:32', '2022-11-04 17:45:49', 2, 0);
INSERT INTO `client` VALUES (886, 'Loui Sze Kwan', '52-710-3596', 'szekwanloui@outlook.com', 262247, 614, '2001-01-28 06:13:22', '2009-10-29 03:17:25', 1, 1);
INSERT INTO `client` VALUES (887, '龙晓明', '74-998-4287', 'lxia@gmail.com', 480814, 288, '2005-03-03 01:45:52', '2014-01-08 22:34:51', 2, 1);
INSERT INTO `client` VALUES (888, 'Xiao Jiehong', '70-2659-0630', 'jiehongxia921@icloud.com', 145125, 0, '2013-07-05 21:21:02', '2011-03-16 10:58:29', 1, 0);
INSERT INTO `client` VALUES (889, 'Timothy Reynolds', '172-3679-2471', 'reynotimothy1980@gmail.com', 47746, 1187, '2016-01-14 21:16:07', '2023-05-07 02:08:32', 0, 0);
INSERT INTO `client` VALUES (890, 'Ota Hikari', '7707 413546', 'hikaota@gmail.com', 413971, 391, '2013-03-15 06:22:07', '2014-11-30 12:46:29', 2, 1);
INSERT INTO `client` VALUES (891, 'Fan Lu', '10-901-7938', 'fanlu@gmail.com', 958001, 0, '2009-09-26 07:15:01', '2005-07-03 09:50:26', 2, 0);
INSERT INTO `client` VALUES (892, 'Imai Ayato', '614-148-6421', 'ayatoi@gmail.com', 580165, 935, '2008-04-23 16:24:12', '2019-09-23 23:45:31', 1, 1);
INSERT INTO `client` VALUES (893, 'Yamada Yuto', '166-5191-9581', 'yutoy@hotmail.com', 811182, 791, '2012-01-15 23:48:34', '2014-04-06 22:33:38', 1, 1);
INSERT INTO `client` VALUES (894, 'Ueno Sara', '70-9009-3918', 'saraueno708@mail.com', 615020, 1062, '2006-01-13 06:01:35', '2000-05-08 05:55:42', 0, 0);
INSERT INTO `client` VALUES (895, 'Douglas Cooper', '(161) 641 1766', 'douglasc@icloud.com', 346277, 525, '2012-09-17 05:34:08', '2020-05-05 13:22:47', 0, 1);
INSERT INTO `client` VALUES (896, 'Feng Shihan', '52-591-1341', 'fengshihan2005@outlook.com', 385433, 449, '2004-02-02 20:04:45', '2000-07-13 08:25:32', 0, 1);
INSERT INTO `client` VALUES (897, 'Lok Tin Lok', '146-1134-3940', 'tinlok3@hotmail.com', 290757, 864, '2002-03-25 13:29:37', '2001-01-11 20:32:24', 1, 1);
INSERT INTO `client` VALUES (898, 'Kimberly Hall', '(1865) 75 0820', 'hallkimberly2006@mail.com', 18360, 538, '2013-12-14 04:07:47', '2010-10-26 09:01:24', 2, 1);
INSERT INTO `client` VALUES (899, 'Sakurai Minato', '70-5173-1434', 'minatosakurai@hotmail.com', 663646, 1131, '2019-08-19 03:29:42', '2006-09-02 19:59:16', 1, 0);
INSERT INTO `client` VALUES (900, 'Jack Edwards', '70-5918-3041', 'jack2@gmail.com', 723264, 0, '2006-11-30 12:32:27', '2007-12-06 04:05:28', 2, 0);
INSERT INTO `client` VALUES (901, 'Goto Nanami', '176-4503-3368', 'nanamigoto@icloud.com', 202862, 1186, '2003-12-27 04:59:03', '2018-08-14 00:11:34', 1, 0);
INSERT INTO `client` VALUES (902, 'Arimura Rin', '760-0075-8945', 'rinarimura@outlook.com', 240381, 877, '2000-01-20 14:42:00', '2014-08-04 07:24:11', 1, 1);
INSERT INTO `client` VALUES (903, 'Tang Wai Han', '838-722-3677', 'tangwaihan922@outlook.com', 998849, 928, '2018-09-13 21:15:24', '2007-05-03 23:10:04', 2, 1);
INSERT INTO `client` VALUES (904, 'Xiang Xiaoming', '5163 400769', 'xiaomingxiang9@mail.com', 742038, 0, '2017-08-29 21:59:50', '2022-10-15 07:03:30', 1, 0);
INSERT INTO `client` VALUES (905, '史云熙', '614-909-5964', 'yushi@icloud.com', 793103, 538, '2021-08-05 05:09:18', '2008-08-02 00:37:27', 1, 0);
INSERT INTO `client` VALUES (906, 'Cho Ming', '80-2733-7667', 'cmin@icloud.com', 67733, 533, '2020-08-29 19:22:44', '2015-08-08 04:04:12', 2, 0);
INSERT INTO `client` VALUES (907, 'Xia Zitao', '5159 677919', 'zitao9@icloud.com', 437938, 0, '2021-08-26 19:17:17', '2000-05-25 11:29:03', 2, 0);
INSERT INTO `client` VALUES (908, 'Xue Rui', '20-657-8548', 'rui2015@icloud.com', 956093, 655, '2010-06-05 08:48:25', '2018-06-19 12:55:56', 1, 0);
INSERT INTO `client` VALUES (909, 'Endo Kasumi', '199-2494-2605', 'endo6@outlook.com', 985375, 1084, '2016-02-06 07:38:50', '2020-07-04 12:51:00', 1, 0);
INSERT INTO `client` VALUES (910, 'Takagi Takuya', '760-925-6967', 'takuya4@hotmail.com', 836575, 497, '2002-04-27 14:00:39', '2016-11-11 10:48:22', 0, 0);
INSERT INTO `client` VALUES (911, 'Sato Aoshi', '70-5466-0964', 'satoaoshi@outlook.com', 946818, 0, '2001-08-29 18:59:14', '2011-06-03 09:49:29', 2, 0);
INSERT INTO `client` VALUES (912, 'Hashimoto Ayato', '70-5625-0458', 'ayatoha@yahoo.com', 66570, 615, '2017-10-05 01:08:45', '2001-01-02 05:51:02', 0, 1);
INSERT INTO `client` VALUES (913, 'Judy Taylor', '769-7662-5708', 'judtaylo824@gmail.com', 264894, 299, '2009-03-31 04:24:27', '2015-03-11 00:34:30', 1, 1);
INSERT INTO `client` VALUES (914, 'Amy Price', '212-229-4805', 'aprice8@hotmail.com', 521953, 355, '2024-09-14 05:58:23', '2011-09-26 08:24:05', 1, 1);
INSERT INTO `client` VALUES (915, 'Choi Ho Yin', '7261 248025', 'choi1217@gmail.com', 384149, 1179, '2022-07-17 01:27:02', '2020-09-10 08:36:55', 1, 1);
INSERT INTO `client` VALUES (916, 'Albert Simpson', '66-302-9644', 'albesimpson2@gmail.com', 126847, 758, '2020-08-15 10:12:36', '2007-02-09 13:37:57', 1, 1);
INSERT INTO `client` VALUES (917, 'Kim Wagner', '141-9242-1439', 'wagki324@outlook.com', 618762, 235, '2003-03-20 02:00:05', '2011-06-06 01:39:47', 1, 0);
INSERT INTO `client` VALUES (918, 'Yamamoto Yuito', '70-8807-1540', 'yamamoto97@yahoo.com', 430461, 539, '2020-11-02 12:18:12', '2013-05-24 02:12:33', 2, 1);
INSERT INTO `client` VALUES (919, 'Fan Wai Han', '188-7114-9297', 'fawh88@hotmail.com', 226920, 822, '2013-01-08 13:02:49', '2002-12-11 12:58:06', 1, 1);
INSERT INTO `client` VALUES (920, 'Jiang Zitao', '5138 978138', 'zij@yahoo.com', 627889, 0, '2011-01-17 19:48:11', '2016-02-01 17:41:39', 2, 0);
INSERT INTO `client` VALUES (921, 'Rebecca Reyes', '10-6710-0318', 'reyes7@gmail.com', 87005, 0, '2024-09-24 12:02:33', '2012-02-14 08:38:09', 1, 0);
INSERT INTO `client` VALUES (922, 'Wu Shihan', '(20) 6406 2814', 'wshihan@icloud.com', 225837, 384, '2006-01-29 20:58:40', '2007-06-29 22:31:23', 1, 1);
INSERT INTO `client` VALUES (923, '马致远', '90-2422-7774', 'mazhiyuan@icloud.com', 714398, 0, '2003-04-08 00:45:50', '2019-07-11 22:01:21', 2, 0);
INSERT INTO `client` VALUES (924, 'Hirano Rena', '11-501-3398', 'hir9@gmail.com', 751219, 0, '2011-04-09 05:49:49', '2007-02-15 20:23:40', 0, 0);
INSERT INTO `client` VALUES (925, 'Cheung Sum Wing', '(20) 8424 1007', 'cheung4@outlook.com', 809742, 848, '2019-05-03 22:36:57', '2004-05-21 22:34:11', 0, 0);
INSERT INTO `client` VALUES (926, 'Jimmy Robertson', '3-5395-5135', 'jirob@icloud.com', 630011, 730, '2020-04-08 23:29:25', '2001-05-25 20:00:47', 1, 0);
INSERT INTO `client` VALUES (927, 'Dai Sau Man', '(151) 243 9133', 'sauman818@mail.com', 961664, 0, '2020-12-08 16:11:57', '2013-11-11 06:49:38', 1, 0);
INSERT INTO `client` VALUES (928, 'Ku Wing Fat', '(151) 705 8752', 'wfku1959@gmail.com', 983729, 653, '2011-06-12 23:48:15', '2001-12-08 02:55:18', 2, 0);
INSERT INTO `client` VALUES (929, 'Yung Fat', '5942 764575', 'fyung@mail.com', 40811, 205, '2024-09-18 09:15:11', '2007-07-19 08:12:48', 2, 0);
INSERT INTO `client` VALUES (930, 'Mori Yuna', '7923 099138', 'mori7@gmail.com', 884595, 0, '2006-09-20 00:58:21', '2023-04-30 15:49:33', 1, 0);
INSERT INTO `client` VALUES (931, '潘璐', '614-250-4214', 'lupan@icloud.com', 966769, 872, '2012-04-18 14:16:09', '2012-07-20 21:21:49', 1, 1);
INSERT INTO `client` VALUES (932, 'Lillian Dixon', '74-371-7851', 'dixonl1223@yahoo.com', 355606, 1034, '2016-02-04 11:41:13', '2014-10-18 01:51:41', 1, 0);
INSERT INTO `client` VALUES (933, 'Sakai Seiko', '(121) 910 9257', 'ssakai8@hotmail.com', 557737, 988, '2015-11-12 18:26:56', '2016-08-13 12:01:37', 2, 1);
INSERT INTO `client` VALUES (934, '雷璐', '66-241-2384', 'lul1940@outlook.com', 717736, 863, '2013-12-20 23:42:45', '2009-08-10 06:52:29', 2, 1);
INSERT INTO `client` VALUES (935, '廖杰宏', '181-4006-0246', 'jiehol@gmail.com', 931031, 632, '2018-11-28 04:47:51', '2013-08-26 20:08:19', 0, 1);
INSERT INTO `client` VALUES (936, '叶安琪', '(116) 156 5421', 'aye@mail.com', 191243, 256, '2013-03-09 21:04:55', '2008-02-04 19:38:54', 0, 0);
INSERT INTO `client` VALUES (937, 'Endo Hana', '755-2219-5538', 'endohana526@mail.com', 562924, 1180, '2009-09-09 01:35:24', '2003-04-20 00:04:22', 1, 1);
INSERT INTO `client` VALUES (938, 'Yuen Ka Keung', '718-648-8655', 'ykakeung@gmail.com', 795184, 425, '2024-10-23 02:28:40', '2022-01-21 10:29:13', 2, 1);
INSERT INTO `client` VALUES (939, 'Abe Aoshi', '(151) 122 2470', 'aoabe@mail.com', 281295, 329, '2019-08-04 20:41:41', '2022-02-15 12:03:22', 1, 1);
INSERT INTO `client` VALUES (940, 'Joan Ferguson', '80-7607-8630', 'ferguson8@gmail.com', 438698, 973, '2008-08-22 05:19:14', '2008-04-16 13:23:56', 1, 1);
INSERT INTO `client` VALUES (941, 'Yin Chun Yu', '90-0319-3357', 'yin43@yahoo.com', 926892, 228, '2010-04-06 21:26:50', '2022-07-04 19:29:59', 2, 1);
INSERT INTO `client` VALUES (942, 'Yung Fu Shing', '(121) 658 2394', 'yungfs@mail.com', 894135, 0, '2021-03-06 23:43:53', '2000-07-26 16:58:48', 0, 0);
INSERT INTO `client` VALUES (943, 'Liao Yunxi', '760-8226-3252', 'liayu@outlook.com', 897755, 1110, '2016-04-26 03:53:41', '2024-06-09 10:38:07', 2, 0);
INSERT INTO `client` VALUES (944, 'Dai Zhiyuan', '330-030-2646', 'dai228@icloud.com', 928104, 963, '2023-12-27 10:44:23', '2006-07-31 23:26:14', 1, 1);
INSERT INTO `client` VALUES (945, '林睿', '213-207-8479', 'lin3@gmail.com', 26328, 559, '2020-01-30 06:51:29', '2013-04-12 13:29:55', 1, 0);
INSERT INTO `client` VALUES (946, '林宇宁', '52-859-8529', 'yuninglin@yahoo.com', 314229, 0, '2000-03-02 12:51:58', '2018-05-23 03:44:26', 1, 0);
INSERT INTO `client` VALUES (947, '贺杰宏', '28-454-6232', 'hjieho@hotmail.com', 997207, 0, '2010-07-24 00:04:50', '2014-07-18 06:12:46', 0, 0);
INSERT INTO `client` VALUES (948, 'Stephen Turner', '838-512-4607', 'stur@hotmail.com', 260636, 272, '2020-10-16 10:11:51', '2023-05-26 05:12:57', 1, 0);
INSERT INTO `client` VALUES (949, 'Daniel Chavez', '28-8063-9005', 'dchavez@gmail.com', 389198, 328, '2005-11-06 06:36:54', '2002-01-15 10:23:30', 1, 1);
INSERT INTO `client` VALUES (950, 'Kong Yunxi', '7355 915700', 'ykong@icloud.com', 993260, 1048, '2012-07-08 08:05:40', '2022-02-04 06:03:50', 1, 0);
INSERT INTO `client` VALUES (951, 'Yung Chi Ming', '7219 106005', 'chiming930@mail.com', 193625, 803, '2011-02-25 21:16:15', '2015-05-06 22:58:24', 0, 1);
INSERT INTO `client` VALUES (952, 'Gu Anqi', '212-012-4864', 'guan@icloud.com', 572868, 246, '2010-03-26 17:33:29', '2011-06-10 04:26:09', 2, 1);
INSERT INTO `client` VALUES (953, 'Allen Evans', '614-029-6001', 'allenev@icloud.com', 68520, 567, '2005-06-18 19:26:48', '2010-02-11 19:24:52', 2, 1);
INSERT INTO `client` VALUES (954, '严子韬', '614-104-2304', 'yanzi7@hotmail.com', 572660, 0, '2004-07-20 02:59:25', '2003-11-22 19:11:10', 0, 0);
INSERT INTO `client` VALUES (955, '邱嘉伦', '70-1395-7054', 'jialunq@icloud.com', 84886, 0, '2008-05-29 01:20:21', '2010-07-28 04:42:00', 0, 0);
INSERT INTO `client` VALUES (956, 'Okamoto Tsubasa', '213-643-3945', 'toka@hotmail.com', 102157, 426, '2000-12-13 09:15:05', '2003-04-10 07:45:46', 2, 1);
INSERT INTO `client` VALUES (957, 'Sakai Hikaru', '(116) 925 7324', 'sakaih@yahoo.com', 217114, 1098, '2014-01-06 16:46:57', '2006-06-10 02:39:14', 0, 1);
INSERT INTO `client` VALUES (958, 'Ma Tak Wah', '28-652-9019', 'ma9@gmail.com', 224946, 446, '2002-12-29 22:28:07', '2004-03-13 09:18:59', 0, 0);
INSERT INTO `client` VALUES (959, 'Yuen Wing Sze', '(1223) 88 4806', 'yuenws@outlook.com', 105778, 1114, '2000-05-01 19:28:44', '2013-02-11 21:57:51', 0, 1);
INSERT INTO `client` VALUES (960, 'Miyazaki Momoka', '614-855-9552', 'mim2@outlook.com', 977605, 1099, '2019-09-09 19:45:28', '2015-12-17 02:49:33', 0, 1);
INSERT INTO `client` VALUES (961, '孟秀英', '3-1950-0767', 'mengxiuying@gmail.com', 628578, 566, '2017-07-03 17:51:02', '2011-05-25 09:16:18', 2, 1);
INSERT INTO `client` VALUES (962, 'Yamada Yamato', '28-8914-8329', 'yamatoyama2001@icloud.com', 666687, 344, '2000-07-10 08:14:37', '2021-01-06 20:46:27', 2, 1);
INSERT INTO `client` VALUES (963, '黎杰宏', '312-111-4706', 'jiehong54@outlook.com', 570534, 242, '2017-10-17 13:24:16', '2016-07-08 05:53:43', 1, 1);
INSERT INTO `client` VALUES (964, '莫睿', '7518 309667', 'mor04@icloud.com', 650848, 0, '2009-03-23 06:28:27', '2022-12-10 12:53:58', 1, 0);
INSERT INTO `client` VALUES (965, 'Lu Zhennan', '755-3750-7908', 'luzhennan@icloud.com', 922970, 1092, '2018-11-14 09:35:47', '2002-12-20 06:25:45', 2, 0);
INSERT INTO `client` VALUES (966, 'Fujii Yuna', '70-4425-3089', 'yunfujii@gmail.com', 333904, 0, '2012-07-09 17:38:21', '2002-02-14 06:56:29', 1, 0);
INSERT INTO `client` VALUES (967, '余岚', '838-147-1670', 'lanyu@icloud.com', 855975, 1153, '2010-11-11 04:38:18', '2023-04-05 14:37:28', 2, 1);
INSERT INTO `client` VALUES (968, 'Pauline Wright', '614-392-3331', 'pwright50@outlook.com', 246062, 1028, '2020-04-11 23:52:05', '2013-06-03 13:48:48', 0, 1);
INSERT INTO `client` VALUES (969, 'Yamada Mai', '769-4543-0273', 'mai6@icloud.com', 614287, 0, '2013-12-19 13:53:20', '2018-05-22 19:47:09', 2, 0);
INSERT INTO `client` VALUES (970, 'Shibata Yuto', '5814 191382', 'yutos212@hotmail.com', 347983, 854, '2006-08-30 14:52:42', '2010-03-29 01:30:06', 1, 1);
INSERT INTO `client` VALUES (971, 'Jack Jones', '7815 188832', 'jackjones80@icloud.com', 303209, 831, '2002-07-29 12:15:25', '2006-01-26 04:46:42', 1, 1);
INSERT INTO `client` VALUES (972, 'Kondo Ren', '28-4588-1210', 'rekond@gmail.com', 301175, 1153, '2013-01-27 03:42:23', '2019-07-15 07:00:45', 2, 0);
INSERT INTO `client` VALUES (973, 'Cai Rui', '718-230-6517', 'ruicai@outlook.com', 485748, 1090, '2017-11-16 05:28:06', '2003-01-10 02:44:44', 1, 0);
INSERT INTO `client` VALUES (974, 'Mok Chi Yuen', '212-337-1895', 'chiymok@outlook.com', 909623, 778, '2015-10-22 01:03:57', '2005-08-29 06:25:34', 2, 1);
INSERT INTO `client` VALUES (975, 'Imai Hina', '90-8656-1571', 'hina75@gmail.com', 509974, 476, '2010-05-03 23:28:02', '2022-08-11 15:40:54', 1, 0);
INSERT INTO `client` VALUES (976, 'Hayashi Itsuki', '312-924-5250', 'itshaya@outlook.com', 528156, 0, '2004-08-10 21:38:56', '2008-09-27 03:17:49', 1, 0);
INSERT INTO `client` VALUES (977, 'Meng Tin Wing', '838-037-0630', 'tinwingmeng@outlook.com', 774904, 1180, '2015-07-15 20:31:33', '2004-01-27 02:37:04', 2, 0);
INSERT INTO `client` VALUES (978, 'Alexander Jordan', '330-866-3866', 'jordalexander6@icloud.com', 117512, 0, '2004-10-10 05:56:50', '2009-09-06 01:30:21', 2, 0);
INSERT INTO `client` VALUES (979, 'Mak Kwok Wing', '80-0854-9263', 'kwokwingmak@outlook.com', 690289, 882, '2001-04-01 21:53:28', '2005-04-01 14:19:13', 2, 1);
INSERT INTO `client` VALUES (980, 'Fujita Aoi', '213-836-1077', 'afujita7@mail.com', 658235, 0, '2006-07-18 23:10:10', '2013-06-08 21:37:45', 1, 0);
INSERT INTO `client` VALUES (981, 'Yamamoto Tsubasa', '312-845-5368', 'tsyamamoto911@yahoo.com', 146658, 0, '2022-10-28 01:21:47', '2009-07-13 23:20:30', 1, 0);
INSERT INTO `client` VALUES (982, 'Cheryl Ramos', '80-5907-7217', 'ramosche@gmail.com', 422512, 581, '2016-01-29 21:12:03', '2024-12-11 01:41:40', 1, 1);
INSERT INTO `client` VALUES (983, 'Lei Xiaoming', '(161) 512 8525', 'leixiaoming6@yahoo.com', 610839, 1187, '2022-09-01 02:41:22', '2011-10-22 14:17:11', 2, 0);
INSERT INTO `client` VALUES (984, 'Don Stevens', '(161) 526 8606', 'dos6@outlook.com', 927398, 1148, '2005-08-11 13:20:28', '2022-01-23 21:49:48', 1, 0);
INSERT INTO `client` VALUES (985, 'Virginia Edwards', '330-105-5919', 'virginiaedwards2011@icloud.com', 695162, 422, '2008-06-13 11:53:38', '2022-10-16 05:03:57', 1, 0);
INSERT INTO `client` VALUES (986, 'Fujii Yota', '838-410-4544', 'yotfuj@mail.com', 645152, 639, '2008-08-08 12:52:21', '2022-12-31 15:31:39', 2, 1);
INSERT INTO `client` VALUES (987, 'Yuen Hok Yau', '66-268-6401', 'hyyuen922@gmail.com', 311659, 971, '2012-08-07 13:52:38', '2021-05-04 04:57:52', 1, 1);
INSERT INTO `client` VALUES (988, '廖震南', '769-550-1921', 'zheliao801@icloud.com', 530687, 579, '2016-05-16 07:07:43', '2003-02-12 11:09:40', 2, 1);
INSERT INTO `client` VALUES (989, 'Yuen Ching Wan', '213-930-6375', 'ycw@outlook.com', 64905, 1104, '2009-10-19 04:47:14', '2015-01-21 03:33:33', 1, 0);
INSERT INTO `client` VALUES (990, 'Fung Tin Wing', '70-1713-5665', 'funtw@yahoo.com', 431303, 879, '2024-06-02 06:01:41', '2004-11-16 04:59:20', 1, 1);
INSERT INTO `client` VALUES (991, 'Ku Siu Wai', '769-6671-1017', 'ku48@hotmail.com', 115578, 1111, '2005-11-06 13:22:28', '2011-10-07 02:52:44', 1, 0);
INSERT INTO `client` VALUES (992, '刘致远', '80-5040-5858', 'zli8@outlook.com', 904155, 222, '2007-09-19 12:57:08', '2017-05-24 16:34:00', 0, 0);
INSERT INTO `client` VALUES (993, 'Cheng Zhennan', '312-091-1993', 'chengzhe@outlook.com', 43403, 569, '2008-11-13 04:05:59', '2000-12-26 01:31:54', 2, 0);
INSERT INTO `client` VALUES (994, 'Tsang Sum Wing', '90-4058-6856', 'tsw@icloud.com', 139339, 961, '2011-06-05 22:03:23', '2021-04-26 15:59:24', 1, 0);
INSERT INTO `client` VALUES (995, 'Lam Wai Man', '(1865) 04 5118', 'lam104@gmail.com', 829090, 1175, '2012-03-20 21:07:07', '2015-10-10 09:42:42', 1, 1);
INSERT INTO `client` VALUES (996, 'Hashimoto Yamato', '5465 898253', 'hashimotoy@outlook.com', 144918, 598, '2001-01-20 19:59:12', '2021-04-30 00:01:52', 2, 1);
INSERT INTO `client` VALUES (997, '陆岚', '160-7273-2825', 'lanlu@mail.com', 995093, 503, '2014-09-19 18:14:32', '2024-10-22 00:29:40', 0, 0);
INSERT INTO `client` VALUES (998, 'Yoshida Yota', '760-7228-0254', 'yoshidayota@outlook.com', 628135, 968, '2020-05-01 22:27:03', '2019-06-20 19:10:40', 1, 0);
INSERT INTO `client` VALUES (999, 'Tam Wai San', '5232 804796', 'waisanta901@icloud.com', 135154, 1137, '2009-11-20 03:03:15', '2009-12-28 05:16:27', 1, 1);
INSERT INTO `client` VALUES (1000, '邵安琪', '21-7354-2906', 'ashao@outlook.com', 588584, 725, '2011-05-13 11:54:32', '2011-05-22 03:43:06', 0, 1);
INSERT INTO `client` VALUES (209838082, 'bnahban', '15258130055', '1628512845@qq.com', 0, 5, '2024-12-21 16:47:28', '2024-12-21 16:47:28', 0, 0);
INSERT INTO `client` VALUES (234979330, 'wnvgbuiopaeniosah', '15867404571', '1628512812@qq.com', 0, 591, '2024-12-21 20:28:21', '2024-12-21 20:28:31', 0, 0);
INSERT INTO `client` VALUES (1040310273, '123bgabab', '15867404571', '1628512812@qq.com', 0, 296, '2024-12-21 16:23:17', '2024-12-21 20:28:06', 0, 0);
INSERT INTO `client` VALUES (1577181186, 'qbahbhaegvgg', '15867404571', '1628512812@qq.com', 0, 5, '2024-12-21 16:45:52', '2024-12-21 16:45:52', 0, 0);
INSERT INTO `client` VALUES (1606533122, 'avvgagvgw', '15867404571', '1628512812@qq.com', 0, 3, NULL, NULL, 0, NULL);
INSERT INTO `client` VALUES (1967251458, 'qvebqvqegeva', '15867404571', '1628512812@qq.com', 0, 4, '2024-12-21 16:30:21', '2024-12-21 16:30:21', 0, 0);

-- ----------------------------
-- Table structure for contract
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract`  (
  `id` int(11) NOT NULL,
  `client_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户id，对应客户信息',
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '职工id,对应职工信息\r\n',
  `order_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单id,对应订单信息',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '合同名称',
  `number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '合同编号',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '合同内容',
  `sign_time` datetime NULL DEFAULT NULL COMMENT '合同签订日期',
  `start_time` datetime NULL DEFAULT NULL COMMENT '合同开始执行日期',
  `end_time` datetime NULL DEFAULT NULL COMMENT '合同结束日期',
  `total_amout` decimal(10, 2) NULL DEFAULT NULL COMMENT '合同总金额',
  `last_update` datetime NULL DEFAULT NULL COMMENT '合同最后一次更新的时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '当前版本号,默认为1',
  `status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '合同当前状态，新建为0，审批通过为1，执行中为2，结束为3，用于跟踪合同流程',
  `is_delete` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contract
-- ----------------------------

-- ----------------------------
-- Table structure for contract_approval
-- ----------------------------
DROP TABLE IF EXISTS `contract_approval`;
CREATE TABLE `contract_approval`  (
  `id` int(11) NOT NULL,
  `contract_id` int(11) NULL DEFAULT NULL COMMENT '合同id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '审批人id',
  `start_time` datetime NULL DEFAULT NULL COMMENT '审批开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '审批结束时间',
  `approval_opinion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '审批意见，审批人填写的对合同的看法、修改建议或批准说明等内容',
  `status` int(2) NULL DEFAULT NULL COMMENT '审批结果，0 表示未批准，1 表示批准，2表示不通过，方便后续判断合同审批是否通过',
  `is_delete` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contract_approval
-- ----------------------------

-- ----------------------------
-- Table structure for contract_claim
-- ----------------------------
DROP TABLE IF EXISTS `contract_claim`;
CREATE TABLE `contract_claim`  (
  `id` int(11) NOT NULL,
  `contract_id` int(11) NULL DEFAULT NULL COMMENT '合同id',
  ` claim_time` datetime NULL DEFAULT NULL COMMENT '索赔提出时间',
  `claim_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '索赔内容如索赔原因、金额等详细信息',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '索赔提出者',
  `status` int(2) NULL DEFAULT NULL COMMENT '索赔状态0“待审查”1“协商中”2“已解决”等',
  `resolved_time` datetime NULL DEFAULT NULL COMMENT '索赔解决时间',
  `resolved_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '索赔金额',
  `is_delete` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contract_claim
-- ----------------------------

-- ----------------------------
-- Table structure for contract_log
-- ----------------------------
DROP TABLE IF EXISTS `contract_log`;
CREATE TABLE `contract_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL COMMENT '合同ID',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `is_delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contract_log
-- ----------------------------

-- ----------------------------
-- Table structure for contract_payment
-- ----------------------------
DROP TABLE IF EXISTS `contract_payment`;
CREATE TABLE `contract_payment`  (
  `id` int(11) NOT NULL,
  `contract_id` int(11) NULL DEFAULT NULL,
  `payment_time` datetime NULL DEFAULT NULL COMMENT '付款时间',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '付款金额',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '付款方式',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '付款备注',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '负责员工id',
  `is_delete` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contract_payment
-- ----------------------------

-- ----------------------------
-- Table structure for contract_progress
-- ----------------------------
DROP TABLE IF EXISTS `contract_progress`;
CREATE TABLE `contract_progress`  (
  `id` int(11) NOT NULL,
  `contract_id` int(11) NULL DEFAULT NULL COMMENT '合同id',
  `progress_time` datetime NULL DEFAULT NULL COMMENT '进度记录日期，表明该进度是何时更新的',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '进度类型，例如 “货物交付进度”“服务完成百分比”“收款进度” 等，用于区分不同方面的进展情况',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '进度细节详细描述内容，如交付了多少货物、服务完成到什么程度、本次收款金额等具体信息',
  `version` int(11) NULL DEFAULT NULL COMMENT '对于执行进度的更新，设置版本号字段，每次更新进度时版本号递增，便于数据的版本控制和历史追溯',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '确定执行人id',
  `risk_issues` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '记录执行过程中出现的风险问题',
  `is_delete` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contract_progress
-- ----------------------------

-- ----------------------------
-- Table structure for contract_risk
-- ----------------------------
DROP TABLE IF EXISTS `contract_risk`;
CREATE TABLE `contract_risk`  (
  `id` int(11) NOT NULL,
  `contract_id` int(11) NULL DEFAULT NULL COMMENT '合同id',
  `risk_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '风险描述',
  `risk_level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '风险等级',
  `deal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '应对措施',
  `find_time` datetime NULL DEFAULT NULL COMMENT '发现风险时间',
  `status` int(11) NULL DEFAULT NULL COMMENT '风险当前状态如 “未处理”“处理中”“已解决”等',
  `is_delete` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of contract_risk
-- ----------------------------

-- ----------------------------
-- Table structure for data
-- ----------------------------
DROP TABLE IF EXISTS `data`;
CREATE TABLE `data`  (
  `id` int(11) NOT NULL,
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '合同累计总金额',
  `sum` int(11) NULL DEFAULT NULL COMMENT '合同累计签订数量',
  `defaultsum` int(11) NULL DEFAULT NULL COMMENT '违约合同数量',
  `defaultamount` decimal(10, 2) NULL DEFAULT NULL COMMENT '违约合同累计金额',
  `period` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '统计周期',
  `update_time` datetime NULL DEFAULT NULL COMMENT '数据更新时间',
  `is_delete` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of data
-- ----------------------------

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `id` int(11) NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文件名',
  `uuid_file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'uuid',
  `content_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `is_delete` int(11) NULL DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file
-- ----------------------------
INSERT INTO `file` VALUES (-1337868287, '计算机专业实践能力考核试题内容与要求.pdf', '2024-12-22/daf8ad2df0584f30b0f2051eca4e4ced.pdf', 'application/pdf', '2024-12-22 21:48:44', 0);
INSERT INTO `file` VALUES (-599740414, '计算机专业实践能力考核试题内容与要求.pdf', '2024-12-22/ca77dbd354144cba911fc871b9b9f9e0.pdf', 'application/pdf', '2024-12-22 21:32:58', 0);
INSERT INTO `file` VALUES (-188743678, 'Last Christmas - Taylor Swift.mp3', '2024-12-19/4e80d2f84ee0427d97d17d638deeed91.mp3', 'audio/mpeg', '2024-12-19 21:28:22', 0);
INSERT INTO `file` VALUES (318767106, 'Last Christmas - Taylor Swift.mp3', '2024-12-19/f2227e5ded2d46038c618eb41e5d0d10.mp3', 'audio/mpeg', '2024-12-19 21:29:27', 0);
INSERT INTO `file` VALUES (1321250818, '【javaEE】P1 Maven项目管理与Spring基本配置.doc', '2024-12-22/2aec2fb5cc44462d8fe861641536dc2f.doc', 'application/msword', '2024-12-22 21:28:16', 1);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` int(11) NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '通知内容',
  `type` int(2) NULL DEFAULT NULL COMMENT '通知类型，0\'status_change\', 1\'reminder\',2‘other’',
  `send_time` datetime NULL DEFAULT NULL COMMENT '通知发送时间',
  `contract_id` int(11) NULL DEFAULT NULL COMMENT '合同id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '收到通知单的用户id',
  `is_delete` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for order_approval
-- ----------------------------
DROP TABLE IF EXISTS `order_approval`;
CREATE TABLE `order_approval`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `approver_id` int(11) NOT NULL COMMENT '审批人ID',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '审批状态',
  `comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批意见',
  `approve_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `is_delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单审批表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_approval
-- ----------------------------

-- ----------------------------
-- Table structure for order_file
-- ----------------------------
DROP TABLE IF EXISTS `order_file`;
CREATE TABLE `order_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `file_id` int(11) NOT NULL COMMENT '文件ID',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `is_delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_file
-- ----------------------------
INSERT INTO `order_file` VALUES (2, 4, -599740414, '计算机', '2024-12-22 21:32:58', 0);
INSERT INTO `order_file` VALUES (3, 1, -1337868287, '', '2024-12-22 21:48:44', 0);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `unit_price` int(11) NOT NULL COMMENT '单价(分)',
  `total_price` int(11) NOT NULL COMMENT '总价(分)',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `is_delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_item
-- ----------------------------

-- ----------------------------
-- Table structure for order_log
-- ----------------------------
DROP TABLE IF EXISTS `order_log`;
CREATE TABLE `order_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `is_delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_log
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号',
  `client_id` int(11) NOT NULL COMMENT '客户ID',
  `user_id` int(11) NOT NULL COMMENT '销售员ID',
  `total_amount` int(11) NOT NULL DEFAULT 0 COMMENT '订单总金额(分)',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '202412221702523321789', 209838082, 5, 0, 'DRAFT', '1', '2024-12-22 17:02:52', '2024-12-22 17:02:52', 0);
INSERT INTO `orders` VALUES (2, '202412221704126246407', 1577181186, 5, 0, 'DRAFT', '123', '2024-12-22 17:04:13', '2024-12-22 17:04:13', 0);
INSERT INTO `orders` VALUES (3, '202412221957517027206', 3, 1, 0, 'DRAFT', '121', '2024-12-22 19:57:52', '2024-12-22 19:57:52', 0);
INSERT INTO `orders` VALUES (4, '202412221958373484525', 3, 1, 0, 'DRAFT', '121', '2024-12-22 19:58:37', '2024-12-22 19:58:37', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户角色',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_update` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `is_delete` int(11) NOT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`user_name` ASC) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1205 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (-297680894, 'anymore131', 'Wyt56280711', '1628512812@qq.com', 'wjh', '15867404571', 'admin', '2024-12-17 19:20:43', '2024-12-17 19:22:48', 0);
INSERT INTO `user` VALUES (1, 'admin', 'admin123', 'admin@qq.com', 'admin', '15811111111', 'admin', '2024-11-22 22:00:25', '2024-12-13 23:26:45', 0);
INSERT INTO `user` VALUES (2, 'normal', '666666', 'normal@qq.com', 'normal', '15822222222', 'user', '2024-11-07 23:02:50', '2024-12-17 18:55:18', 0);
INSERT INTO `user` VALUES (3, 'user1', 'user1', 'user1@qq.com', 'normal', '15800000001', 'user', '2024-11-19 19:50:53', '2024-12-21 16:27:51', 1);
INSERT INTO `user` VALUES (4, 'user2', 'user2', 'user2@qq.com', 'normal', '15800000002', 'user', '2024-11-19 19:51:06', '2024-12-21 16:30:46', 1);
INSERT INTO `user` VALUES (5, 'user3', 'user3', 'user3@qq.com', 'normal', '15800000003', 'user', '2024-11-19 19:52:04', '2024-12-13 18:29:41', 0);
INSERT INTO `user` VALUES (6, 'user4', 'user4', 'user4@qq.com', 'normal', '15800000004', 'user', '2024-11-19 19:52:45', '2024-12-13 18:29:41', 0);
INSERT INTO `user` VALUES (203, 'Ronald Roberts', 'hjTxD8mbIY', 'roberts506@gmail.com', 'Ronald Roberts', '5182 909206', 'user', '2024-07-16 15:13:30', '2021-05-08 00:09:01', 1);
INSERT INTO `user` VALUES (204, 'Meng Ting Fung', '2ZitKnG6ET', 'tfmen@outlook.com', 'Meng Ting Fung', '769-015-9878', 'user', '2022-11-22 21:13:23', '2007-12-13 20:23:24', 1);
INSERT INTO `user` VALUES (205, 'Kevin Anderson', 'L6pSboeJEf', 'andekev41@yahoo.com', 'Kevin Anderson', '760-3144-1785', 'user', '2023-12-09 21:19:01', '2017-09-08 19:47:47', 0);
INSERT INTO `user` VALUES (206, 'Cui Xiuying', 'YrlVsmLxjo', 'cuixi@yahoo.com', '崔秀英', '(161) 656 7678', 'user', '2022-05-25 08:10:05', '2020-03-30 22:24:24', 0);
INSERT INTO `user` VALUES (207, 'Man Ho Yin', 'rjAUpu2RJ0', 'man408@icloud.com', 'Man Ho Yin', '312-177-8688', 'user', '2011-05-25 04:33:34', '2014-06-23 19:50:19', 1);
INSERT INTO `user` VALUES (208, 'Lau Yun Fat', '1PC552cRzT', 'lauyunfat5@outlook.com', 'Lau Yun Fat', '139-0051-2279', 'user', '2007-10-21 14:38:05', '2003-03-24 17:08:08', 0);
INSERT INTO `user` VALUES (209, 'Siu Kwok Yin', 'BhQAfMBMqV', 'siukwokyin1953@gmail.com', 'Siu Kwok Yin', '70-9843-8544', 'user', '2010-12-31 21:43:01', '2003-12-13 01:08:10', 0);
INSERT INTO `user` VALUES (210, 'Qian Xiuying', 'ugCQitSbRQ', 'qian2@icloud.com', '钱秀英', '838-198-9457', 'user', '2004-11-29 05:32:32', '2006-03-30 03:04:13', 1);
INSERT INTO `user` VALUES (211, 'Kwok Fat', 'w9dndpMW7J', 'fat3@gmail.com', 'Kwok Fat', '90-5564-5437', 'user', '2020-11-11 15:38:06', '2010-07-21 15:02:22', 1);
INSERT INTO `user` VALUES (212, 'Tin Tsz Ching', 'H9ejL1BIpt', 'tintc13@yahoo.com', 'Tin Tsz Ching', '212-202-4310', 'user', '2015-10-13 11:54:53', '2002-05-07 06:02:36', 0);
INSERT INTO `user` VALUES (213, 'Li Jiehong', 'fOnkiVcwYK', 'jiehong111@icloud.com', 'Li Jiehong', '28-6968-0514', 'user', '2018-05-22 14:20:56', '2017-03-08 19:42:10', 1);
INSERT INTO `user` VALUES (214, 'Su Xiaoming', 'xDIp7Tjaj9', 'suxiao60@yahoo.com', '苏晓明', '5123 893754', 'user', '2005-12-16 17:30:41', '2012-11-21 13:55:09', 0);
INSERT INTO `user` VALUES (215, 'Betty Adams', 'UqOMVQUfbM', 'adabetty@outlook.com', 'Betty Adams', '718-596-3748', 'user', '2015-11-28 21:07:16', '2022-01-17 14:10:08', 1);
INSERT INTO `user` VALUES (216, 'Louise Watson', 'jxwVpE5ByB', 'louiswatson1116@outlook.com', 'Louise Watson', '5973 940427', 'user', '2009-09-13 09:33:29', '2012-05-01 21:37:50', 0);
INSERT INTO `user` VALUES (217, 'Maria Gutierrez', 'tHF9oKk03k', 'gutimaria1031@mail.com', 'Maria Gutierrez', '838-134-1144', 'user', '2023-06-08 09:14:08', '2011-02-05 05:45:51', 1);
INSERT INTO `user` VALUES (218, 'Lu Yunxi', 'W7mrkQUiAq', 'luyunxi@outlook.com', '吕云熙', '90-2031-2266', 'user', '2004-10-21 06:27:00', '2002-03-08 13:07:28', 1);
INSERT INTO `user` VALUES (219, 'Yao Rui', 'lAFVkGbEFu', 'ruiya@outlook.com', 'Yao Rui', '312-014-8503', 'user', '2017-03-15 22:53:08', '2019-11-17 00:08:58', 0);
INSERT INTO `user` VALUES (220, 'Feng Xiuying', 'trvUhcFmPC', 'xiuyfe@icloud.com', 'Feng Xiuying', '70-3309-8513', 'user', '2014-04-08 06:33:20', '2012-03-31 01:23:20', 1);
INSERT INTO `user` VALUES (221, 'Xiao Ziyi', 'vtJ6RLMF32', 'ziyxi1976@icloud.com', '萧子异', '52-452-2645', 'user', '2010-10-17 23:29:56', '2022-02-06 15:05:44', 0);
INSERT INTO `user` VALUES (222, 'Norman Coleman', '8aAeuI3gzP', 'coleman1@gmail.com', 'Norman Coleman', '212-624-2714', 'user', '2009-04-14 02:05:21', '2023-09-16 10:25:32', 0);
INSERT INTO `user` VALUES (223, 'Ruth Ortiz', '1Ym3U7Zauo', 'rutortiz@yahoo.com', 'Ruth Ortiz', '755-2483-8766', 'user', '2020-12-11 04:10:54', '2000-07-16 23:59:06', 0);
INSERT INTO `user` VALUES (224, 'Debbie Mendoza', 'wDDQewnPCR', 'debbie7@gmail.com', 'Debbie Mendoza', '(116) 622 6023', 'user', '2011-04-25 08:21:59', '2000-09-02 04:57:08', 0);
INSERT INTO `user` VALUES (225, 'Glenn Rose', '7cNA9q7TEe', 'glennrose@gmail.com', 'Glenn Rose', '3-9044-6994', 'user', '2003-12-07 19:39:29', '2015-01-25 03:17:30', 1);
INSERT INTO `user` VALUES (226, 'Jiang Xiaoming', 'NOTNankrsl', 'jixiaom116@outlook.com', 'Jiang Xiaoming', '188-4051-2339', 'user', '2000-07-25 05:15:41', '2009-04-07 15:58:50', 1);
INSERT INTO `user` VALUES (227, 'Thomas Ryan', 'roGXJCiCgP', 'ryat1102@outlook.com', 'Thomas Ryan', '(151) 880 6544', 'user', '2007-12-10 16:52:37', '2001-10-09 13:12:20', 0);
INSERT INTO `user` VALUES (228, 'Jonathan Patterson', 'rZS25KrVdv', 'patterson73@icloud.com', 'Jonathan Patterson', '80-0369-2303', 'user', '2023-02-20 04:32:20', '2001-09-19 09:07:44', 1);
INSERT INTO `user` VALUES (229, 'Yan Zhiyuan', 'lFM3LsBR5A', 'yan1001@hotmail.com', 'Yan Zhiyuan', '28-6632-0396', 'user', '2022-06-02 11:59:50', '2020-06-20 16:16:17', 1);
INSERT INTO `user` VALUES (230, 'Cheng Anqi', 'e0KnRPZ7RU', 'anch79@gmail.com', '程安琪', '312-932-4378', 'user', '2010-08-27 23:19:04', '2000-04-02 15:24:34', 1);
INSERT INTO `user` VALUES (231, 'Ying Chung Yin', 'nTNdnTu4BO', 'chungyin1983@gmail.com', 'Ying Chung Yin', '90-5892-6880', 'user', '2001-10-30 03:34:33', '2010-03-01 02:35:30', 0);
INSERT INTO `user` VALUES (232, 'Brenda Wells', 'pGSAtJYFlp', 'brendawells1975@mail.com', 'Brenda Wells', '70-9720-6094', 'user', '2022-03-27 15:00:34', '2017-04-24 16:18:34', 0);
INSERT INTO `user` VALUES (233, 'Ying Kwok Wing', 'tHLEf6dthn', 'yingkwokwing@outlook.com', 'Ying Kwok Wing', '144-0425-6132', 'user', '2023-09-30 10:00:03', '2005-11-26 11:37:26', 0);
INSERT INTO `user` VALUES (234, 'Guo Lu', 'IFQh5Ai3ii', 'guo2@gmail.com', 'Guo Lu', '838-604-6332', 'user', '2023-11-04 14:36:58', '2005-12-25 00:52:08', 1);
INSERT INTO `user` VALUES (235, 'Cho Kwok Wing', 'E3iz5bILgu', 'kwch@icloud.com', 'Cho Kwok Wing', '80-4639-2964', 'user', '2023-01-01 00:11:02', '2016-09-26 07:38:25', 0);
INSERT INTO `user` VALUES (236, 'Wan Wing Sze', '3nL3XCj61d', 'wswan@gmail.com', 'Wan Wing Sze', '66-437-4190', 'user', '2016-06-14 08:58:28', '2005-04-07 13:17:28', 0);
INSERT INTO `user` VALUES (237, 'Wong Wai Man', 'A2E76W7Isx', 'waiman1@hotmail.com', 'Wong Wai Man', '312-077-3990', 'user', '2002-05-14 22:57:35', '2021-07-17 03:22:34', 0);
INSERT INTO `user` VALUES (238, 'Jiang Anqi', 'ExV0QXWzWa', 'jianganqi@icloud.com', 'Jiang Anqi', '80-9037-0455', 'user', '2005-11-30 15:49:37', '2003-06-17 17:53:20', 0);
INSERT INTO `user` VALUES (239, 'Cao Yunxi', 'qMo797ez7w', 'yunxi05@hotmail.com', '曹云熙', '(151) 283 1396', 'user', '2011-12-30 01:44:51', '2014-02-06 22:25:11', 1);
INSERT INTO `user` VALUES (240, 'Sheh Chieh Lun', 'NXzJZXmMQB', 'chsh@outlook.com', 'Sheh Chieh Lun', '312-896-3783', 'user', '2012-01-10 17:42:16', '2023-07-18 13:33:46', 0);
INSERT INTO `user` VALUES (241, 'Xu Jialun', 'W79L5FV4FW', 'jxu99@outlook.com', 'Xu Jialun', '(121) 075 4207', 'user', '2011-07-10 19:54:00', '2000-08-17 17:23:16', 1);
INSERT INTO `user` VALUES (242, 'Zhong Rui', 'Y5DWsKZf2l', 'zrui83@hotmail.com', 'Zhong Rui', '140-1061-0640', 'user', '2024-12-14 12:17:22', '2011-10-01 21:59:23', 0);
INSERT INTO `user` VALUES (243, 'Lu Anqi', 'I5zZ8yEEK1', 'lu5@yahoo.com', 'Lu Anqi', '157-4228-8785', 'user', '2021-06-29 09:03:04', '2021-07-31 22:03:50', 1);
INSERT INTO `user` VALUES (244, 'William Parker', 'NoztVmZpQY', 'williamp@gmail.com', 'William Parker', '312-337-2212', 'user', '2011-05-08 16:18:43', '2015-01-21 11:26:38', 0);
INSERT INTO `user` VALUES (245, 'Han Zhennan', 'u5j1hekBOS', 'zhennan8@gmail.com', '韩震南', '5231 247334', 'user', '2004-03-22 10:31:55', '2011-03-16 12:45:29', 1);
INSERT INTO `user` VALUES (246, 'Mok Kwok Kuen', 'YpKmzmWqEz', 'mok1@outlook.com', 'Mok Kwok Kuen', '184-7713-6216', 'user', '2013-12-07 02:07:18', '2023-03-10 11:40:58', 1);
INSERT INTO `user` VALUES (247, 'Lee Chiu Wai', 'UA1hB5rV9K', 'lchiuwai308@outlook.com', 'Lee Chiu Wai', '312-413-0451', 'user', '2015-12-09 18:29:55', '2004-09-27 09:52:32', 1);
INSERT INTO `user` VALUES (248, 'Lai On Kay', '1eobdU3FFC', 'okla@yahoo.com', 'Lai On Kay', '174-9005-9640', 'user', '2024-07-24 00:04:55', '2007-03-28 10:52:46', 1);
INSERT INTO `user` VALUES (249, 'He Xiaoming', 'lWnvu2M2Zi', 'hexiaoming@outlook.com', '贺晓明', '80-6478-6797', 'user', '2000-07-25 05:20:27', '2001-11-26 17:29:40', 0);
INSERT INTO `user` VALUES (250, 'Long Xiuying', 'dkdamu5Cxi', 'longxi@gmail.com', '龙秀英', '28-7976-5247', 'user', '2004-12-02 21:42:03', '2000-10-18 12:28:43', 0);
INSERT INTO `user` VALUES (251, 'Fan Shihan', 'pcWycWfYiP', 'shihan6@gmail.com', '范詩涵', '(151) 933 0428', 'user', '2021-06-09 00:02:51', '2020-03-02 09:05:15', 1);
INSERT INTO `user` VALUES (252, 'Shing Ho Yin', '0viofrLCDE', 'shinghy@gmail.com', 'Shing Ho Yin', '(1223) 92 8261', 'user', '2005-06-23 22:42:05', '2020-11-19 02:20:01', 0);
INSERT INTO `user` VALUES (253, 'Miguel Reynolds', 'fBi3w6tKpx', 'reynoldsmigue@yahoo.com', 'Miguel Reynolds', '5577 445649', 'user', '2021-02-03 19:15:46', '2024-01-03 07:04:31', 0);
INSERT INTO `user` VALUES (254, 'Ti Kwok Ming', 'Iw2vSX5EMC', 'tikwokming@icloud.com', 'Ti Kwok Ming', '80-6394-5911', 'user', '2011-10-08 21:51:00', '2012-11-10 21:58:59', 0);
INSERT INTO `user` VALUES (255, 'Zhong Anqi', 'JeCXNyFXYx', 'anzh7@icloud.com', '钟安琪', '(121) 614 7774', 'user', '2007-12-22 08:51:43', '2002-06-29 07:23:09', 0);
INSERT INTO `user` VALUES (256, 'Tong Wing Sze', 'oVQRGj7bpE', 'tongwingsze@icloud.com', 'Tong Wing Sze', '70-4967-5235', 'user', '2015-10-30 04:18:54', '2008-02-14 00:31:26', 0);
INSERT INTO `user` VALUES (257, 'Duan Anqi', 'SdajMDWXkk', 'anqid10@gmail.com', 'Duan Anqi', '90-4859-5088', 'user', '2023-06-19 15:57:05', '2016-05-11 07:07:15', 0);
INSERT INTO `user` VALUES (258, 'James Richardson', 'uTIwf7WEDd', 'rij@icloud.com', 'James Richardson', '312-529-9586', 'user', '2003-04-15 19:09:04', '2001-04-28 06:21:44', 1);
INSERT INTO `user` VALUES (259, 'James Ramos', 'mWO030YD8O', 'james5@gmail.com', 'James Ramos', '188-0050-6139', 'user', '2022-02-06 20:44:58', '2009-06-12 07:40:53', 0);
INSERT INTO `user` VALUES (260, 'Cao Lan', 'B4dBdzSi7H', 'cao2@hotmail.com', '曹岚', '718-582-5191', 'user', '2016-08-07 15:46:16', '2013-12-14 16:41:09', 0);
INSERT INTO `user` VALUES (261, 'Fung Ming', 'wTCimecc0a', 'mingf@outlook.com', 'Fung Ming', '769-4889-4547', 'user', '2017-05-26 14:14:37', '2022-05-19 13:17:09', 1);
INSERT INTO `user` VALUES (262, 'Zhao Yuning', 'ApgEktG5uf', 'zhaoy@gmail.com', 'Zhao Yuning', '5895 205364', 'user', '2005-04-26 13:20:58', '2014-09-09 06:20:04', 1);
INSERT INTO `user` VALUES (263, 'Wan Sum Wing', 'J6KPLAVDQ6', 'swwa@yahoo.com', 'Wan Sum Wing', '312-707-7885', 'user', '2024-04-18 01:34:31', '2006-10-25 13:24:19', 0);
INSERT INTO `user` VALUES (264, 'Cheryl Owens', 'd4ZUNnmO8N', 'owec@gmail.com', 'Cheryl Owens', '21-475-0633', 'user', '2004-01-16 09:56:22', '2023-04-15 23:11:32', 1);
INSERT INTO `user` VALUES (265, 'Xiong Yunxi', 'KlpHq4su36', 'xiong1953@mail.com', '熊云熙', '330-661-9334', 'user', '2021-04-07 03:54:14', '2016-11-20 21:34:13', 1);
INSERT INTO `user` VALUES (266, 'Zheng Zhennan', 'x3OTPvIY8Y', 'zhennan617@outlook.com', 'Zheng Zhennan', '3-7588-7304', 'user', '2003-03-04 10:41:29', '2000-11-16 23:38:42', 1);
INSERT INTO `user` VALUES (267, 'Li Yunxi', 'busicODHgL', 'liyunxi703@gmail.com', 'Li Yunxi', '614-871-5512', 'user', '2009-02-11 20:21:08', '2005-07-26 13:01:41', 0);
INSERT INTO `user` VALUES (268, 'Du Xiaoming', 'KnqUpwbFw2', 'dxiaoming@gmail.com', 'Du Xiaoming', '70-4276-4585', 'user', '2014-11-30 00:18:20', '2007-11-10 23:59:15', 1);
INSERT INTO `user` VALUES (269, 'Tian Shihan', 'wiwieCJb1X', 'shihtian1125@gmail.com', '田詩涵', '74-606-4136', 'user', '2016-04-19 04:18:07', '2010-06-24 10:39:30', 1);
INSERT INTO `user` VALUES (270, 'Hui Hui Mei', '6kp7giwftA', 'huhui@gmail.com', 'Hui Hui Mei', '197-1361-3238', 'user', '2001-03-09 15:59:26', '2010-10-11 23:29:33', 0);
INSERT INTO `user` VALUES (271, 'Yeow Tak Wah', '5uIEEgwE3u', 'yeow5@outlook.com', 'Yeow Tak Wah', '5468 742102', 'user', '2018-11-25 22:12:54', '2022-11-02 03:28:31', 0);
INSERT INTO `user` VALUES (272, 'Wang Ziyi', '8RVCH1QCSm', 'ziyiwang4@icloud.com', 'Wang Ziyi', '614-754-4333', 'user', '2017-04-10 19:23:54', '2012-08-04 10:16:36', 0);
INSERT INTO `user` VALUES (273, 'Choi Chi Ming', 'KlhBBXhApi', 'chimingc@hotmail.com', 'Choi Chi Ming', '(151) 511 8009', 'user', '2021-12-31 15:48:49', '2015-06-18 20:14:24', 1);
INSERT INTO `user` VALUES (274, 'Bradley Payne', 'ULfMu5zo2D', 'paynebradley1127@hotmail.com', 'Bradley Payne', '11-913-5238', 'user', '2003-10-13 20:01:32', '2023-12-29 18:35:31', 1);
INSERT INTO `user` VALUES (275, 'Ying Chun Yu', 'pTVtkbB5Gw', 'chunyuying@gmail.com', 'Ying Chun Yu', '718-052-9483', 'user', '2014-12-24 20:42:15', '2010-11-15 03:25:57', 0);
INSERT INTO `user` VALUES (276, 'Jean Flores', 'ExI6ktI23p', 'jeanflo@yahoo.com', 'Jean Flores', '718-294-6918', 'user', '2018-06-16 10:44:49', '2024-11-29 06:43:35', 1);
INSERT INTO `user` VALUES (277, 'Mui Hui Mei', 'Nfb9re7Gil', 'mui8@outlook.com', 'Mui Hui Mei', '5424 951467', 'user', '2020-05-14 03:24:13', '2023-04-03 11:41:23', 0);
INSERT INTO `user` VALUES (278, 'Lucille Thomas', 'kS3Lsmyrd6', 'thomasluci810@gmail.com', 'Lucille Thomas', '52-155-3187', 'user', '2016-06-14 06:39:21', '2020-10-21 06:21:49', 0);
INSERT INTO `user` VALUES (279, 'Koon Wing Kuen', 'M0zZLUnlht', 'wikoon@icloud.com', 'Koon Wing Kuen', '11-397-3078', 'user', '2010-01-31 09:43:45', '2000-01-28 01:09:06', 0);
INSERT INTO `user` VALUES (280, 'Yuen Tsz Ching', 'NPzETdeWa5', 'tszching5@icloud.com', 'Yuen Tsz Ching', '90-6104-0935', 'user', '2016-03-13 01:31:24', '2003-06-22 08:55:55', 1);
INSERT INTO `user` VALUES (281, 'Meng Ziyi', 'gK6F4C2si0', 'ziyi5@outlook.com', 'Meng Ziyi', '74-430-9522', 'user', '2009-06-23 01:10:28', '2002-05-20 05:59:16', 0);
INSERT INTO `user` VALUES (282, 'Pan Lu', 'z0x7fY7qIg', 'lup@gmail.com', '潘璐', '769-9267-9675', 'user', '2019-02-28 09:20:41', '2005-09-01 06:13:15', 0);
INSERT INTO `user` VALUES (283, 'Joanne Ellis', 'C9csx6DpcF', 'ellisjoanne@yahoo.com', 'Joanne Ellis', '3-1152-9151', 'user', '2002-05-08 22:32:16', '2019-12-24 19:17:23', 0);
INSERT INTO `user` VALUES (284, 'Tang Yuning', 'VhcDqWigJB', 'yta@outlook.com', 'Tang Yuning', '178-9783-9061', 'user', '2016-11-25 22:21:19', '2008-03-23 15:01:34', 0);
INSERT INTO `user` VALUES (285, 'Tang Jiehong', 'Nx2AGbrbuM', 'tanjieh10@outlook.com', 'Tang Jiehong', '28-263-3398', 'user', '2005-05-14 17:57:20', '2007-08-28 20:54:44', 0);
INSERT INTO `user` VALUES (286, 'Debra Meyer', 'wmbzbSo10g', 'meydebra5@hotmail.com', 'Debra Meyer', '614-243-0343', 'user', '2017-05-05 06:35:55', '2013-05-23 10:29:09', 0);
INSERT INTO `user` VALUES (287, 'Ding Anqi', 'Ch6vIpNh9o', 'ding61@gmail.com', '丁安琪', '66-833-1774', 'user', '2006-05-27 19:28:52', '2015-11-22 01:01:27', 0);
INSERT INTO `user` VALUES (288, 'Tong Kwok Kuen', 'w6cdsApSQA', 'kkto@outlook.com', 'Tong Kwok Kuen', '718-793-6610', 'user', '2015-01-06 07:52:53', '2020-02-01 21:31:21', 1);
INSERT INTO `user` VALUES (289, 'Jiang Zhennan', 'FvsUpnZQgt', 'zhennanji4@yahoo.com', '蒋震南', '7906 591524', 'user', '2007-04-09 13:24:37', '2012-11-26 00:31:35', 0);
INSERT INTO `user` VALUES (290, 'Han Tak Wah', 'WOn63m9UWr', 'twhan@outlook.com', 'Han Tak Wah', '90-2840-2097', 'user', '2021-02-22 22:44:46', '2017-09-27 09:04:17', 1);
INSERT INTO `user` VALUES (291, 'He Zitao', 'vf5HBx9xha', 'zitaohe@hotmail.com', '何子韬', '11-121-2454', 'user', '2005-12-06 13:37:24', '2020-03-29 19:27:05', 0);
INSERT INTO `user` VALUES (292, 'Fan Kar Yan', 'si5RTlJZoM', 'faky918@gmail.com', 'Fan Kar Yan', '614-101-1791', 'user', '2009-04-20 01:12:21', '2005-04-02 16:11:00', 0);
INSERT INTO `user` VALUES (293, 'Elaine Burns', 'BiMWojx73q', 'elaib@hotmail.com', 'Elaine Burns', '5612 601015', 'user', '2024-06-25 04:27:18', '2015-01-26 13:04:12', 0);
INSERT INTO `user` VALUES (294, 'Shen Anqi', 'XDBFOJWz1i', 'shenan627@outlook.com', 'Shen Anqi', '52-851-3596', 'user', '2021-10-26 11:33:23', '2015-12-08 17:18:53', 0);
INSERT INTO `user` VALUES (295, 'Zhao Shihan', 'EpcXP5zkZr', 'shihanz@mail.com', '赵詩涵', '179-2889-0670', 'user', '2002-12-22 08:02:24', '2011-08-20 02:42:45', 0);
INSERT INTO `user` VALUES (296, 'Zou Jialun', '666666', 'zoujialu@outlook.com', '邹嘉伦', '80-8527-2787', 'user', '2000-05-13 19:37:35', '2024-12-21 15:08:08', 0);
INSERT INTO `user` VALUES (297, 'Ren Zhennan', '853kOASX70', 'zhennanren@yahoo.com', '任震南', '212-168-4027', 'user', '2015-09-12 00:11:44', '2000-04-23 04:58:28', 1);
INSERT INTO `user` VALUES (298, 'Mo Sai Wing', 'xyc2hwuH7q', 'saiwingmo3@outlook.com', 'Mo Sai Wing', '90-8398-3997', 'user', '2014-03-19 21:39:52', '2009-03-17 14:06:05', 0);
INSERT INTO `user` VALUES (299, 'Emma Cox', '3PaIyuq8S1', 'emmacox@icloud.com', 'Emma Cox', '74-130-1147', 'user', '2016-05-16 21:06:30', '2010-12-24 03:41:19', 0);
INSERT INTO `user` VALUES (300, 'Tan Yuning', '4tuZeNAe83', 'tanyunin@icloud.com', 'Tan Yuning', '5615 810696', 'user', '2006-01-31 07:06:17', '2006-09-10 03:19:47', 1);
INSERT INTO `user` VALUES (301, 'Zhou Zhiyuan', '6LcMvkbyQ7', 'zhiyzh@outlook.com', 'Zhou Zhiyuan', '330-940-2132', 'user', '2015-09-12 11:22:04', '2020-08-05 11:36:38', 0);
INSERT INTO `user` VALUES (302, 'Sylvia Reynolds', 'lHoqlaOviT', 'sylvia712@gmail.com', 'Sylvia Reynolds', '212-511-3603', 'user', '2022-09-05 04:28:37', '2009-06-21 03:18:37', 1);
INSERT INTO `user` VALUES (303, 'Tsui Wing Fat', 'FX9CAWrBG7', 'twf@outlook.com', 'Tsui Wing Fat', '199-9042-4067', 'user', '2008-02-16 03:01:03', '2001-04-14 16:10:13', 1);
INSERT INTO `user` VALUES (304, 'Dorothy Guzman', 'S3CGZbnYmH', 'guzmand@mail.com', 'Dorothy Guzman', '171-2362-3593', 'user', '2011-10-15 12:19:13', '2004-04-09 13:42:12', 0);
INSERT INTO `user` VALUES (305, 'Zeng Rui', 'X6Io1awKn9', 'zeru@hotmail.com', '曾睿', '718-512-0040', 'user', '2023-10-12 21:58:04', '2003-08-07 22:56:14', 1);
INSERT INTO `user` VALUES (306, 'Xiao Xiuying', 'vZREsYzrK1', 'xiao2016@icloud.com', 'Xiao Xiuying', '760-6918-8029', 'user', '2009-11-14 07:16:37', '2002-12-09 15:52:24', 0);
INSERT INTO `user` VALUES (307, 'Vincent Graham', 'FY4oSgjhjK', 'vincentgraham@gmail.com', 'Vincent Graham', '7250 670605', 'user', '2019-10-07 23:21:29', '2004-09-15 21:12:46', 0);
INSERT INTO `user` VALUES (308, 'Siu Wai San', 'lnl6ospSjD', 'siuwaisan@yahoo.com', 'Siu Wai San', '140-1060-6610', 'user', '2012-03-17 12:26:54', '2007-03-13 12:18:10', 1);
INSERT INTO `user` VALUES (309, 'Fang Anqi', 'OzLeaGN797', 'fanqi2@icloud.com', '方安琪', '80-1059-3938', 'user', '2022-05-07 07:55:00', '2010-09-13 21:45:12', 1);
INSERT INTO `user` VALUES (310, 'Shen Zitao', 'NQ8N9zJkLa', 'zshe@gmail.com', '沈子韬', '7744 959179', 'user', '2003-08-31 15:05:45', '2023-09-30 14:49:06', 0);
INSERT INTO `user` VALUES (311, 'Rita White', '0gTe3VxKi6', 'white1@gmail.com', 'Rita White', '7687 784286', 'user', '2009-09-30 14:49:45', '2000-06-07 13:40:39', 0);
INSERT INTO `user` VALUES (312, 'Yan Zitao', 'j3nrdjvgLi', 'yan1202@gmail.com', '严子韬', '74-195-6321', 'user', '2023-06-21 04:23:25', '2008-03-28 09:50:58', 1);
INSERT INTO `user` VALUES (313, 'Brenda Patel', '4DyXJePKMw', 'patelb@outlook.com', 'Brenda Patel', '755-1674-2119', 'user', '2016-10-30 01:23:58', '2011-06-23 23:53:01', 1);
INSERT INTO `user` VALUES (314, 'Kong Anqi', 'tzNjKGdZG6', 'kong4@gmail.com', '孔安琪', '760-470-6553', 'user', '2022-07-20 20:38:45', '2016-05-25 08:29:09', 1);
INSERT INTO `user` VALUES (315, 'Kwong Wing Fat', 'PTqircTHaM', 'kwongwingfat@icloud.com', 'Kwong Wing Fat', '66-020-0752', 'user', '2020-03-10 15:09:44', '2022-07-14 08:30:10', 1);
INSERT INTO `user` VALUES (316, 'Shi Jialun', '8T86vuGBPQ', 'jialuns@icloud.com', '史嘉伦', '140-8630-4324', 'user', '2019-07-26 12:00:24', '2022-10-28 15:38:44', 0);
INSERT INTO `user` VALUES (317, 'Lam Tsz Hin', 'RE8uzSwkKe', 'lamth@gmail.com', 'Lam Tsz Hin', '838-629-5202', 'user', '2020-04-08 02:01:23', '2020-04-28 13:43:29', 1);
INSERT INTO `user` VALUES (318, 'Dai Tak Wah', '5ySUjvI2pz', 'takwah00@outlook.com', 'Dai Tak Wah', '7530 289879', 'user', '2021-07-09 02:17:42', '2002-02-02 10:22:39', 0);
INSERT INTO `user` VALUES (319, 'Mary Moore', 'fnh4p2zuNE', 'momary613@outlook.com', 'Mary Moore', '66-186-6567', 'user', '2019-02-06 15:26:21', '2000-01-21 11:28:37', 1);
INSERT INTO `user` VALUES (320, 'Julie Gray', 'F8AdAUIVhi', 'julg@outlook.com', 'Julie Gray', '213-044-6292', 'user', '2017-07-25 00:28:23', '2008-12-25 14:46:08', 1);
INSERT INTO `user` VALUES (321, 'Denise Robertson', 'KRZYyznS1h', 'robertsondenise@icloud.com', 'Denise Robertson', '74-548-1793', 'user', '2007-07-06 12:50:15', '2005-12-28 03:22:01', 1);
INSERT INTO `user` VALUES (322, 'To Yun Fat', 'v6qEw5Wdqs', 'yunfat20@gmail.com', 'To Yun Fat', '176-9517-6817', 'user', '2013-12-30 15:57:57', '2005-12-04 15:32:25', 1);
INSERT INTO `user` VALUES (323, 'Man Sze Kwan', 'joSVF9XLnG', 'szeman6@outlook.com', 'Man Sze Kwan', '11-175-3951', 'user', '2018-03-09 04:11:25', '2004-07-23 08:51:38', 0);
INSERT INTO `user` VALUES (324, 'Emma Simpson', 'bu4nxlV1gE', 'simemm@outlook.com', 'Emma Simpson', '166-6147-1649', 'user', '2017-02-03 09:59:59', '2015-12-30 23:24:25', 1);
INSERT INTO `user` VALUES (325, 'Zou Zitao', 'n4V4MSnXvU', 'zouzitao@icloud.com', '邹子韬', '185-7650-7058', 'user', '2016-09-24 08:28:09', '2007-06-21 06:04:14', 1);
INSERT INTO `user` VALUES (326, 'Han Chi Yuen', 'tnRqsu2sZI', 'chiyuenhan@outlook.com', 'Han Chi Yuen', '755-5126-9094', 'user', '2012-09-13 16:27:41', '2001-06-05 06:19:37', 0);
INSERT INTO `user` VALUES (327, 'Thomas Barnes', 'wQfqRyDjQu', 'thomasba9@outlook.com', 'Thomas Barnes', '330-007-2607', 'user', '2008-05-24 04:51:38', '2014-10-31 12:36:12', 0);
INSERT INTO `user` VALUES (328, 'Jeff Gray', 'tDocgQkpmu', 'jeffgray@icloud.com', 'Jeff Gray', '7779 946116', 'user', '2003-12-27 22:04:48', '2009-06-19 21:43:01', 0);
INSERT INTO `user` VALUES (329, 'Thelma Mendez', 'WBxlHVNaOz', 'mendez2@mail.com', 'Thelma Mendez', '312-792-5981', 'user', '2021-02-24 22:52:52', '2012-04-22 09:13:16', 1);
INSERT INTO `user` VALUES (330, 'Zhu Xiaoming', 'WXLqCgzADF', 'xiaomingzhu1948@gmail.com', 'Zhu Xiaoming', '181-3997-8395', 'user', '2009-05-27 01:21:35', '2001-10-04 14:55:00', 1);
INSERT INTO `user` VALUES (331, 'Chin Wing Suen', 'ytnpdRmYgx', 'wschin1995@yahoo.com', 'Chin Wing Suen', '80-5326-7813', 'user', '2012-11-27 17:59:32', '2017-03-05 07:54:21', 1);
INSERT INTO `user` VALUES (332, 'Hazel Torres', 'e7ZcVzwX4h', 'thazel@yahoo.com', 'Hazel Torres', '7790 671395', 'user', '2019-11-21 18:02:00', '2006-01-18 23:45:04', 1);
INSERT INTO `user` VALUES (333, 'Nicholas Moreno', '4hJZUeFGkz', 'morenoni@icloud.com', 'Nicholas Moreno', '28-008-6130', 'user', '2024-02-01 23:37:28', '2013-09-26 06:37:50', 1);
INSERT INTO `user` VALUES (334, 'Yuen Wai Yee', 'uwcjekl7fq', 'yuewy@gmail.com', 'Yuen Wai Yee', '330-369-6729', 'user', '2011-04-07 06:26:13', '2006-04-24 10:56:27', 1);
INSERT INTO `user` VALUES (335, 'Yu Lu', '9qLcYyDC04', 'luy@outlook.com', 'Yu Lu', '74-448-2638', 'user', '2009-09-17 10:04:32', '2011-04-22 05:36:14', 0);
INSERT INTO `user` VALUES (336, 'Lei Zitao', 'qj7Ymoxjhr', 'leizitao2@outlook.com', '雷子韬', '3-9334-7917', 'user', '2012-04-21 08:41:58', '2013-03-24 09:12:27', 1);
INSERT INTO `user` VALUES (337, 'Jacqueline Hughes', 'hWMJUcWreN', 'hughesj1212@gmail.com', 'Jacqueline Hughes', '80-3422-1525', 'user', '2018-11-14 20:03:13', '2002-03-28 19:24:31', 1);
INSERT INTO `user` VALUES (338, 'Tang Chi Yuen', 'FsZUn5bDzw', 'chiyuen826@gmail.com', 'Tang Chi Yuen', '312-685-3693', 'user', '2017-11-26 06:26:59', '2010-08-04 16:37:38', 1);
INSERT INTO `user` VALUES (339, 'Martin Dixon', 'gk04Oir8kQ', 'dmartin2@icloud.com', 'Martin Dixon', '7392 390173', 'user', '2019-12-31 22:09:26', '2018-09-12 17:04:37', 1);
INSERT INTO `user` VALUES (340, 'Judith Ward', 'P13Ovu1ROg', 'judward413@gmail.com', 'Judith Ward', '769-6982-2136', 'user', '2024-10-09 16:08:20', '2024-10-09 03:11:10', 1);
INSERT INTO `user` VALUES (341, 'Fu Shihan', 'szqDYB192R', 'sfu@icloud.com', '傅詩涵', '838-967-9089', 'user', '2009-11-03 02:24:26', '2002-05-02 07:36:41', 1);
INSERT INTO `user` VALUES (342, 'Doris Ramos', 'Mq5kQdhIbT', 'dorisra2@yahoo.com', 'Doris Ramos', '3-9130-8208', 'user', '2020-08-21 04:58:34', '2011-10-27 14:51:58', 1);
INSERT INTO `user` VALUES (343, 'Fred Gardner', 'yag5eHvngB', 'fregardner812@icloud.com', 'Fred Gardner', '312-143-5103', 'user', '2015-06-09 10:17:39', '2011-06-14 09:14:16', 1);
INSERT INTO `user` VALUES (344, 'Linda Vargas', 'k4J0yxvvMc', 'vargas3@outlook.com', 'Linda Vargas', '(20) 7870 7711', 'user', '2023-05-12 01:34:12', '2015-03-28 23:41:10', 0);
INSERT INTO `user` VALUES (345, 'Feng Lu', 'n4YfEkKZQM', 'lu912@outlook.com', 'Feng Lu', '28-506-4994', 'user', '2022-01-23 20:22:55', '2017-05-05 20:37:30', 1);
INSERT INTO `user` VALUES (346, 'Rodney Jenkins', '0LJKQITWY8', 'rodnjenkins@hotmail.com', 'Rodney Jenkins', '193-6843-2105', 'user', '2015-02-20 20:22:22', '2022-11-16 23:25:49', 1);
INSERT INTO `user` VALUES (347, 'Pan Ziyi', 'ghKYp2IXhM', 'ziyipan6@hotmail.com', 'Pan Ziyi', '198-9763-3694', 'user', '2013-02-28 20:14:17', '2005-05-06 12:04:50', 0);
INSERT INTO `user` VALUES (348, 'Koo Chung Yin', 'pYvchRBWjV', 'cyk301@gmail.com', 'Koo Chung Yin', '(20) 9073 7625', 'user', '2021-11-24 15:28:11', '2022-12-17 19:53:46', 0);
INSERT INTO `user` VALUES (349, 'Kao Ka Ming', '11Tm2RKtHe', 'kakami10@icloud.com', 'Kao Ka Ming', '213-645-8971', 'user', '2021-06-11 12:13:32', '2015-11-21 03:17:20', 1);
INSERT INTO `user` VALUES (350, 'Doris Powell', 'EdcTM78CRP', 'dorpowell@outlook.com', 'Doris Powell', '74-281-6317', 'user', '2011-09-30 04:01:23', '2019-02-17 01:47:30', 1);
INSERT INTO `user` VALUES (351, 'Luo Jiehong', 'DWwxWe2pHe', 'jluo9@yahoo.com', 'Luo Jiehong', '(161) 651 9870', 'user', '2010-07-08 13:44:14', '2004-10-07 17:16:55', 1);
INSERT INTO `user` VALUES (352, 'Wu Jialun', 'jf5EbbYIpj', 'wuji509@icloud.com', 'Wu Jialun', '838-110-0076', 'user', '2007-01-13 03:55:09', '2019-11-01 22:56:34', 1);
INSERT INTO `user` VALUES (353, 'Ralph Gonzalez', 'BkbicbBkoj', 'gonzalezra@gmail.com', 'Ralph Gonzalez', '20-287-5336', 'user', '2023-10-13 21:27:54', '2011-05-24 01:18:41', 0);
INSERT INTO `user` VALUES (354, 'Jeff Rogers', 'lCJKwwyB3q', 'rogers1104@gmail.com', 'Jeff Rogers', '21-6893-6921', 'user', '2010-10-17 16:03:48', '2003-10-11 14:23:25', 1);
INSERT INTO `user` VALUES (355, 'Hao Xiuying', 'tamWJIWmuo', 'xiuyinghao64@gmail.com', 'Hao Xiuying', '168-9215-1105', 'user', '2007-04-22 10:00:36', '2006-01-13 14:10:07', 1);
INSERT INTO `user` VALUES (356, 'Roger Edwards', 'S8IE77QRrW', 'edwroger@hotmail.com', 'Roger Edwards', '90-1651-4612', 'user', '2023-07-13 01:53:31', '2008-10-04 14:12:15', 1);
INSERT INTO `user` VALUES (357, 'Tao On Kay', 'uEzbpTZw3Q', 'onkaytao@icloud.com', 'Tao On Kay', '70-1188-7823', 'user', '2011-06-07 18:37:09', '2016-12-12 23:41:37', 1);
INSERT INTO `user` VALUES (358, 'Wu Rui', 'fdnHXyOiJJ', 'rui6@yahoo.com', '武睿', '(116) 324 8141', 'user', '2000-05-27 05:26:19', '2000-05-21 05:01:36', 1);
INSERT INTO `user` VALUES (359, 'Ku On Na', 'cSg6XWcjL7', 'onnaku1030@mail.com', 'Ku On Na', '66-443-5435', 'user', '2004-01-18 08:37:17', '2013-02-28 04:05:16', 0);
INSERT INTO `user` VALUES (360, 'Fu Zitao', 'uhbse9w0iL', 'zfu7@outlook.com', '傅子韬', '5935 978172', 'user', '2017-09-05 23:08:40', '2022-01-12 07:17:05', 0);
INSERT INTO `user` VALUES (361, 'Ruby Harrison', '9HQGBZafyT', 'harrisonr126@gmail.com', 'Ruby Harrison', '11-145-3803', 'user', '2024-07-06 18:23:23', '2019-07-04 13:54:00', 0);
INSERT INTO `user` VALUES (362, 'Elaine Ellis', 'n4dIUPfV9C', 'elellis308@outlook.com', 'Elaine Ellis', '213-480-2970', 'user', '2017-08-26 20:35:58', '2022-09-02 14:24:03', 1);
INSERT INTO `user` VALUES (363, 'Tang Zhiyuan', 'Bku8thy40r', 'tangzhiyuan02@icloud.com', 'Tang Zhiyuan', '838-862-5051', 'user', '2004-05-27 05:04:12', '2020-04-10 05:48:41', 1);
INSERT INTO `user` VALUES (364, 'Lai Lik Sun', 'XrAIb9u0cD', 'liksunl@hotmail.com', 'Lai Lik Sun', '173-5982-4429', 'user', '2010-01-27 07:36:35', '2017-06-09 16:10:05', 1);
INSERT INTO `user` VALUES (365, 'Tsui Chi Ming', '7YxvYrfV0A', 'cmt@mail.com', 'Tsui Chi Ming', '(151) 472 0846', 'user', '2010-12-15 07:49:45', '2002-11-11 20:08:59', 0);
INSERT INTO `user` VALUES (366, 'So Sze Kwan', '316HHjUOZO', 'szekwanso@icloud.com', 'So Sze Kwan', '52-261-0939', 'user', '2014-10-16 15:06:58', '2001-08-01 02:56:15', 1);
INSERT INTO `user` VALUES (367, 'Irene Hawkins', 'fO4M2OQwjO', 'hawkinsire@gmail.com', 'Irene Hawkins', '5943 562862', 'user', '2019-06-13 15:35:04', '2019-05-29 12:03:48', 0);
INSERT INTO `user` VALUES (368, 'Wu Anqi', 'xDevyIMEpS', 'anqiwu8@gmail.com', '吴安琪', '66-676-5193', 'user', '2023-04-05 08:34:09', '2003-02-20 08:28:23', 0);
INSERT INTO `user` VALUES (369, 'Patrick Kim', 'pLwb54hifN', 'patrik5@icloud.com', 'Patrick Kim', '11-787-0548', 'user', '2023-07-05 21:56:54', '2002-06-29 21:22:05', 1);
INSERT INTO `user` VALUES (370, 'Shing Tin Lok', 'xUtFb8uP9i', 'shintl2000@outlook.com', 'Shing Tin Lok', '70-9085-1628', 'user', '2021-03-05 09:25:03', '2009-07-21 08:55:17', 1);
INSERT INTO `user` VALUES (371, 'Koon Wai Man', 'mvWK8VbWKu', 'koon48@outlook.com', 'Koon Wai Man', '158-5280-2721', 'user', '2002-02-10 05:22:21', '2008-06-12 04:49:58', 0);
INSERT INTO `user` VALUES (372, 'Lee Allen', 'hPe0pbcR7l', 'lee62@mail.com', 'Lee Allen', '838-169-8101', 'user', '2012-04-20 13:41:11', '2012-04-22 09:50:00', 1);
INSERT INTO `user` VALUES (373, 'Martha Myers', 'tYz9AlGJHk', 'marthamyer@icloud.com', 'Martha Myers', '151-3729-7821', 'user', '2014-02-06 10:38:38', '2007-06-09 07:35:29', 1);
INSERT INTO `user` VALUES (374, 'Anita Carter', 'NQFuPx6nAp', 'ac1@yahoo.com', 'Anita Carter', '769-1955-5856', 'user', '2008-12-12 20:41:11', '2016-08-22 04:10:20', 1);
INSERT INTO `user` VALUES (375, 'Wayne Torres', 'qmbze5s5c6', 'waynetorres4@outlook.com', 'Wayne Torres', '5553 139378', 'user', '2009-03-17 13:38:25', '2013-05-27 02:29:31', 1);
INSERT INTO `user` VALUES (376, 'Hung Ming', 'TNUVUjJCt5', 'minghung@outlook.com', 'Hung Ming', '20-8285-0525', 'user', '2023-10-14 05:10:16', '2001-11-15 05:34:01', 0);
INSERT INTO `user` VALUES (377, 'Yip Hiu Tung', 'Vd5ZCoZya4', 'yip78@gmail.com', 'Yip Hiu Tung', '90-3318-8994', 'user', '2015-09-25 03:57:03', '2001-01-29 11:13:04', 0);
INSERT INTO `user` VALUES (378, 'Tin Sze Kwan', 'E64PXqEjrG', 'szekwant@gmail.com', 'Tin Sze Kwan', '838-193-9009', 'user', '2014-11-13 07:34:40', '2011-11-29 15:48:58', 1);
INSERT INTO `user` VALUES (379, 'Lu Jialun', 'RAO1HOyMTq', 'luj720@gmail.com', '卢嘉伦', '174-1726-7525', 'user', '2001-06-05 15:17:20', '2012-01-13 10:49:37', 1);
INSERT INTO `user` VALUES (380, 'Ho Chieh Lun', 'x3BrPvDY1P', 'chieho728@icloud.com', 'Ho Chieh Lun', '162-7706-5654', 'user', '2023-03-23 01:59:06', '2012-03-14 23:16:31', 0);
INSERT INTO `user` VALUES (381, 'Koo On Na', 'zQPE8IttSo', 'kooon6@gmail.com', 'Koo On Na', '(151) 401 4452', 'user', '2005-01-10 15:58:50', '2010-05-22 04:07:41', 1);
INSERT INTO `user` VALUES (382, 'Mo Ming', 'hwbWMJI5lu', 'mo2@gmail.com', 'Mo Ming', '(121) 988 7967', 'user', '2011-01-09 03:32:44', '2016-11-23 23:28:36', 0);
INSERT INTO `user` VALUES (383, 'Yin Shihan', 'BvF1iyLENs', 'syi@gmail.com', '尹詩涵', '179-2098-5304', 'user', '2008-04-29 16:04:14', '2011-11-03 07:12:29', 1);
INSERT INTO `user` VALUES (384, 'Xu Xiuying', '48jw0dmOpg', 'xuxiu@mail.com', 'Xu Xiuying', '11-648-9137', 'user', '2023-08-29 15:41:03', '2022-12-25 02:25:24', 1);
INSERT INTO `user` VALUES (385, 'Kao Ming Sze', 'KsMmC1JZZS', 'mska74@outlook.com', 'Kao Ming Sze', '80-0445-9659', 'user', '2022-03-15 04:39:58', '2004-09-22 18:53:58', 0);
INSERT INTO `user` VALUES (386, 'Herbert Dunn', 'OS6V9RzCnn', 'herbed47@gmail.com', 'Herbert Dunn', '(151) 067 4733', 'user', '2008-09-08 02:36:37', '2011-01-13 01:16:23', 0);
INSERT INTO `user` VALUES (387, 'Rose Mendoza', 'VEPLfkksaz', 'rosemendo@icloud.com', 'Rose Mendoza', '213-385-7250', 'user', '2014-01-18 17:49:02', '2015-02-20 05:47:44', 0);
INSERT INTO `user` VALUES (388, 'Gu Yuning', 'wp6zp404Cp', 'guyuning5@hotmail.com', 'Gu Yuning', '614-493-4594', 'user', '2003-03-11 14:08:54', '2010-06-28 23:35:46', 0);
INSERT INTO `user` VALUES (389, 'Ng Fu Shing', '3uIi1xQgaC', 'fung@gmail.com', 'Ng Fu Shing', '755-4083-9921', 'user', '2012-05-16 12:08:05', '2021-10-20 08:12:28', 1);
INSERT INTO `user` VALUES (390, 'Chad Lopez', 'yLZ3UaQeI5', 'lopez1982@hotmail.com', 'Chad Lopez', '7846 348412', 'user', '2004-04-29 14:25:31', '2003-03-24 01:15:11', 0);
INSERT INTO `user` VALUES (391, 'Meng Xiuying', '4qdaXpBn82', 'xiuyingmeng@yahoo.com', 'Meng Xiuying', '80-2307-4078', 'user', '2021-09-05 11:58:57', '2017-05-07 17:20:25', 0);
INSERT INTO `user` VALUES (392, 'Kelly Olson', 'iQmSC0ynVi', 'kelly5@gmail.com', 'Kelly Olson', '52-446-4772', 'user', '2008-04-21 09:09:23', '2021-11-08 20:20:31', 0);
INSERT INTO `user` VALUES (393, 'Joseph Wells', 'IVXbIwb4xg', 'josepw6@hotmail.com', 'Joseph Wells', '143-5778-5964', 'user', '2022-03-05 19:55:49', '2013-12-10 00:10:17', 0);
INSERT INTO `user` VALUES (394, 'Lau On Na', 'vjeHr5Vrwg', 'lauon2@hotmail.com', 'Lau On Na', '330-864-9680', 'user', '2021-03-01 11:40:33', '2019-12-30 21:58:39', 0);
INSERT INTO `user` VALUES (395, 'Kao Ching Wan', '6SbmMaVFT3', 'kacw@outlook.com', 'Kao Ching Wan', '212-038-8204', 'user', '2019-01-07 04:34:51', '2003-07-29 21:17:33', 1);
INSERT INTO `user` VALUES (396, 'Mo Chi Yuen', 'jTWoSS6Sci', 'cym10@gmail.com', 'Mo Chi Yuen', '213-619-8695', 'user', '2019-04-24 10:39:14', '2002-11-08 22:30:42', 1);
INSERT INTO `user` VALUES (397, 'Yan Zhennan', 'Ezgw347A29', 'zy909@hotmail.com', '严震南', '70-1016-5240', 'user', '2014-10-25 19:23:08', '2016-10-24 13:07:26', 0);
INSERT INTO `user` VALUES (398, 'So Wai Han', 'y4ouXAZjuA', 'swaihan@outlook.com', 'So Wai Han', '213-775-7150', 'user', '2022-08-09 12:04:13', '2014-04-16 19:26:05', 1);
INSERT INTO `user` VALUES (399, 'Angela Jimenez', 'zz3s5QOaGC', 'jimenezangela@icloud.com', 'Angela Jimenez', '70-9199-2735', 'user', '2020-09-16 22:15:54', '2001-12-06 18:55:56', 1);
INSERT INTO `user` VALUES (400, 'Zhou Rui', '914qqj6Emh', 'rui5@gmail.com', 'Zhou Rui', '(20) 9361 7741', 'user', '2022-09-02 16:46:30', '2024-12-21 16:40:41', 1);
INSERT INTO `user` VALUES (401, 'Ernest Parker', '666666', 'ernestpa@outlook.com', 'Ernest Parker', '70-1891-1616', 'user', '2009-05-17 02:12:19', '2024-12-21 15:09:10', 1);
INSERT INTO `user` VALUES (402, 'Kwan Cho Yee', 'TiBoJFBWZ9', 'kwan504@gmail.com', 'Kwan Cho Yee', '838-191-2034', 'user', '2022-03-19 09:06:49', '2003-01-26 15:42:31', 0);
INSERT INTO `user` VALUES (403, 'Peggy Shaw', 'Ho3VoGwU45', 'peggyshaw@icloud.com', 'Peggy Shaw', '5215 293380', 'user', '2004-05-13 19:42:11', '2019-01-25 21:55:32', 0);
INSERT INTO `user` VALUES (404, 'Yip Wing Fat', 'O6xi2QDMhV', 'wfyip@hotmail.com', 'Yip Wing Fat', '90-1141-5453', 'user', '2003-08-27 19:04:23', '2021-07-14 01:50:32', 0);
INSERT INTO `user` VALUES (405, 'Jiang Zitao', 'tIjbwPQOBC', 'jzitao@mail.com', '江子韬', '11-536-2074', 'user', '2020-07-12 07:47:01', '2009-02-27 04:24:16', 1);
INSERT INTO `user` VALUES (406, 'Wang Zhiyuan', 'Z0EVJ5rDnS', 'zhwang3@icloud.com', '汪致远', '760-620-0943', 'user', '2013-11-02 03:45:17', '2021-07-26 15:16:00', 1);
INSERT INTO `user` VALUES (407, 'Ye Anqi', 'flV2HBK2hU', 'ye63@gmail.com', '叶安琪', '718-596-9188', 'user', '2023-06-26 20:25:24', '2000-03-22 16:56:37', 1);
INSERT INTO `user` VALUES (408, 'Tse Tsz Ching', '8vmJxDVxzm', 'tctse220@hotmail.com', 'Tse Tsz Ching', '330-404-8310', 'user', '2008-01-08 05:16:45', '2012-07-18 16:03:04', 1);
INSERT INTO `user` VALUES (409, 'Koo Wing Sze', 'Sqej0kxaUe', 'koowingsze519@hotmail.com', 'Koo Wing Sze', '20-793-0941', 'user', '2001-08-25 11:32:33', '2002-10-13 00:52:18', 1);
INSERT INTO `user` VALUES (410, 'Tao Wai Yee', 'PDN7dJwjnt', 'waiyeetao1984@icloud.com', 'Tao Wai Yee', '192-2927-4696', 'user', '2000-08-01 22:23:27', '2005-06-18 19:04:46', 1);
INSERT INTO `user` VALUES (411, 'Ma Kwok Yin', '30MqW5wYaP', 'kym@outlook.com', 'Ma Kwok Yin', '11-990-3714', 'user', '2014-04-30 16:32:46', '2010-01-12 04:09:04', 0);
INSERT INTO `user` VALUES (412, 'Ying Wing Fat', 'uOkWkQ3LHT', 'wingfat923@icloud.com', 'Ying Wing Fat', '11-913-7316', 'user', '2011-08-24 02:37:37', '2021-07-05 06:04:33', 0);
INSERT INTO `user` VALUES (413, 'Yung Lik Sun', 'Qpkiubeoau', 'yuliksun@outlook.com', 'Yung Lik Sun', '213-014-5811', 'user', '2018-05-24 16:12:23', '2020-04-28 21:21:16', 0);
INSERT INTO `user` VALUES (414, 'Dai Zitao', 'AYuBNfAXjI', 'daizitao@icloud.com', '戴子韬', '769-039-9588', 'user', '2000-04-19 04:49:28', '2013-10-02 09:45:21', 1);
INSERT INTO `user` VALUES (415, 'Yuen Chieh Lun', 'HnhU4DyvB3', 'yuencl1026@icloud.com', 'Yuen Chieh Lun', '7269 421502', 'user', '2000-12-29 04:02:09', '2000-07-21 05:13:49', 1);
INSERT INTO `user` VALUES (416, 'Christine Foster', 'TuOg2U80RM', 'christine815@gmail.com', 'Christine Foster', '7122 287650', 'user', '2018-10-20 06:36:11', '2016-03-20 18:29:31', 1);
INSERT INTO `user` VALUES (417, 'David Boyd', 'JOphLAIZiG', 'boyddav@mail.com', 'David Boyd', '52-214-8329', 'user', '2015-05-10 10:54:54', '2020-11-05 13:41:17', 0);
INSERT INTO `user` VALUES (418, 'Janice Parker', 'AO1LP5ptNs', 'parkejani@icloud.com', 'Janice Parker', '3-4865-4836', 'user', '2006-09-25 18:53:38', '2018-10-15 08:51:15', 0);
INSERT INTO `user` VALUES (419, 'Fu Lan', 'RiSNWgm8hT', 'lafu43@mail.com', '傅岚', '(20) 0231 7559', 'user', '2011-02-06 12:17:54', '2024-05-16 01:20:53', 0);
INSERT INTO `user` VALUES (420, 'Yung Kwok Wing', 'FiA6GlrxrK', 'ykw@gmail.com', 'Yung Kwok Wing', '130-0244-4879', 'user', '2014-04-20 21:32:50', '2007-09-12 09:24:07', 1);
INSERT INTO `user` VALUES (421, 'Hung Chi Ming', 'gebT9vCNCC', 'cmhung@gmail.com', 'Hung Chi Ming', '(151) 522 0917', 'user', '2015-06-10 11:23:44', '2015-05-20 10:30:51', 0);
INSERT INTO `user` VALUES (422, 'Bonnie Ward', '9FpID4u0cq', 'bonniew06@hotmail.com', 'Bonnie Ward', '52-827-3935', 'user', '2012-05-06 09:50:59', '2017-06-15 17:38:44', 0);
INSERT INTO `user` VALUES (423, 'Kevin Webb', 'NCkGW5ZoVk', 'kevin9@outlook.com', 'Kevin Webb', '5638 319466', 'user', '2007-03-13 13:40:22', '2003-02-12 00:02:08', 0);
INSERT INTO `user` VALUES (424, 'Zhu Rui', '436yNl8JIH', 'ruizhu8@icloud.com', '朱睿', '7321 785618', 'user', '2020-07-20 10:54:40', '2001-04-26 05:39:31', 0);
INSERT INTO `user` VALUES (425, 'Liao Hok Yau', 'sxrgk2mL2J', 'lihok1978@hotmail.com', 'Liao Hok Yau', '838-952-0737', 'user', '2019-06-25 23:49:29', '2020-01-03 09:46:11', 1);
INSERT INTO `user` VALUES (426, 'Kenneth Barnes', 'ol9pKCpHvU', 'kenneth4@gmail.com', 'Kenneth Barnes', '21-8124-4198', 'user', '2009-11-02 03:32:45', '2012-03-03 09:37:43', 1);
INSERT INTO `user` VALUES (427, 'Tang Zitao', 'MGteUGVlvD', 'zittan5@outlook.com', 'Tang Zitao', '760-2717-7674', 'user', '2019-09-03 12:08:05', '2000-09-03 19:01:30', 0);
INSERT INTO `user` VALUES (428, 'Marie Henry', 'VzcRMtIc4l', 'henry40@icloud.com', 'Marie Henry', '330-142-9041', 'user', '2013-04-20 08:55:43', '2021-12-03 15:43:20', 0);
INSERT INTO `user` VALUES (429, 'Dai Yuning', 'ekmX0EA3wT', 'dyun417@outlook.com', 'Dai Yuning', '80-8422-9232', 'user', '2014-09-24 22:28:27', '2019-07-24 11:59:42', 0);
INSERT INTO `user` VALUES (430, 'Chan Fat', 'JeBJIkJ7I1', 'fach9@outlook.com', 'Chan Fat', '312-316-9763', 'user', '2017-01-22 01:56:31', '2008-10-19 06:17:26', 0);
INSERT INTO `user` VALUES (431, 'Mui Tin Wing', 'UHSsm3yUNR', 'muitw9@mail.com', 'Mui Tin Wing', '7349 735555', 'user', '2006-01-30 06:03:24', '2003-09-26 09:44:46', 0);
INSERT INTO `user` VALUES (432, 'Koon Ting Fung', 'zFXAf7BQP8', 'tfkoon@gmail.com', 'Koon Ting Fung', '718-323-6858', 'user', '2001-04-04 03:36:02', '2011-12-16 08:20:25', 1);
INSERT INTO `user` VALUES (433, 'Leung Cho Yee', 's7aO5wKZrB', 'leung3@yahoo.com', 'Leung Cho Yee', '312-214-6653', 'user', '2009-10-31 18:19:44', '2011-10-14 04:51:13', 0);
INSERT INTO `user` VALUES (434, 'Andrea Stewart', 'zgM4cZuK6P', 'ands@yahoo.com', 'Andrea Stewart', '20-490-0924', 'user', '2024-07-06 06:12:39', '2008-04-19 08:22:56', 1);
INSERT INTO `user` VALUES (435, 'Tsang Lai Yan', 'BSdYabVvUX', 'tsanlaiyan@icloud.com', 'Tsang Lai Yan', '70-4453-0103', 'user', '2000-10-02 17:56:41', '2011-01-05 01:45:34', 0);
INSERT INTO `user` VALUES (436, 'Charlotte Ross', 'v5XQzBZzHU', 'charlotteross@gmail.com', 'Charlotte Ross', '838-622-0540', 'user', '2024-11-22 23:31:20', '2007-09-30 02:53:36', 1);
INSERT INTO `user` VALUES (437, 'Hung Tin Lok', 'LUSDvdZcaF', 'tinlokhung@yahoo.com', 'Hung Tin Lok', '838-223-3286', 'user', '2023-12-24 17:40:39', '2016-06-17 14:59:40', 1);
INSERT INTO `user` VALUES (438, 'Duan Xiaoming', 'UAb7dc1EHF', 'xduan@mail.com', '段晓明', '10-6045-6800', 'user', '2005-04-16 13:58:33', '2004-08-18 10:29:28', 0);
INSERT INTO `user` VALUES (439, 'Yue Ho Yin', 'JXeEE2MeAO', 'yue509@outlook.com', 'Yue Ho Yin', '66-495-3445', 'user', '2000-10-15 03:33:41', '2005-01-18 07:41:43', 1);
INSERT INTO `user` VALUES (440, 'Denise Gordon', 'cHyPnjWQjj', 'gordode@gmail.com', 'Denise Gordon', '11-751-1970', 'user', '2008-08-12 12:47:42', '2016-04-12 00:40:30', 1);
INSERT INTO `user` VALUES (441, 'Tracy Torres', 'dwbBhFJ74A', 'trtorres@gmail.com', 'Tracy Torres', '212-893-3240', 'user', '2014-05-30 22:28:25', '2018-09-01 10:37:04', 0);
INSERT INTO `user` VALUES (442, 'Ernest Russell', '9WxgehnFT0', 'russellernest1@yahoo.com', 'Ernest Russell', '179-8948-5707', 'user', '2007-11-20 10:00:24', '2014-06-08 08:03:31', 0);
INSERT INTO `user` VALUES (443, 'Melvin Morgan', 'GIfGBWjVjK', 'mmorgan@mail.com', 'Melvin Morgan', '(116) 672 1638', 'user', '2007-10-01 17:36:28', '2021-08-29 04:59:57', 1);
INSERT INTO `user` VALUES (444, 'Yuan Shihan', '9rTPjGttQX', 'shihanyua@mail.com', '袁詩涵', '212-904-5458', 'user', '2009-06-19 10:19:38', '2007-04-14 07:43:10', 1);
INSERT INTO `user` VALUES (445, 'Grace Vargas', 'yk17bNFkTm', 'gracevar812@yahoo.com', 'Grace Vargas', '760-656-2363', 'user', '2021-01-13 06:13:54', '2004-11-24 23:09:41', 1);
INSERT INTO `user` VALUES (446, 'Siu Lai Yan', 'R605RFiGOn', 'silaiyan2@gmail.com', 'Siu Lai Yan', '185-2939-1306', 'user', '2013-01-26 00:41:03', '2003-11-09 19:23:27', 0);
INSERT INTO `user` VALUES (447, 'Tong Wai Man', 'eRB4iawtbH', 'waimanto@gmail.com', 'Tong Wai Man', '74-936-1737', 'user', '2023-06-22 19:31:12', '2021-08-22 18:48:56', 0);
INSERT INTO `user` VALUES (448, 'Dai Tin Lok', 'OFFDfdjCyv', 'daitinlok@icloud.com', 'Dai Tin Lok', '7878 534002', 'user', '2006-04-14 12:38:38', '2023-11-20 13:17:25', 0);
INSERT INTO `user` VALUES (449, 'Ryan Fernandez', '9Zh8Df99x8', 'ryan89@gmail.com', 'Ryan Fernandez', '151-0906-7296', 'user', '2015-12-17 05:41:38', '2023-12-25 06:41:51', 0);
INSERT INTO `user` VALUES (450, 'Lee Diaz', 'cCbE3lKfkm', 'leediaz803@icloud.com', 'Lee Diaz', '138-0346-1711', 'user', '2016-02-14 07:30:24', '2007-09-17 23:33:52', 1);
INSERT INTO `user` VALUES (451, 'Xie Jialun', 'YbSTmhQKgO', 'xjialun@outlook.com', '谢嘉伦', '159-4069-2453', 'user', '2024-08-08 17:44:23', '2023-02-07 04:31:40', 1);
INSERT INTO `user` VALUES (452, 'Mark Carter', 'UJopcPFdla', 'marcarter1951@gmail.com', 'Mark Carter', '614-056-8824', 'user', '2022-08-09 17:37:24', '2017-07-21 06:55:56', 1);
INSERT INTO `user` VALUES (453, 'Ren Lu', 'zRF56bWFlo', 'lur2@mail.com', 'Ren Lu', '213-303-2190', 'user', '2018-05-22 15:14:06', '2005-06-19 04:03:24', 1);
INSERT INTO `user` VALUES (454, 'He Lan', 'mWlyPo2ZG5', 'helan@outlook.com', 'He Lan', '90-4704-7481', 'user', '2000-11-02 05:02:46', '2005-11-14 14:12:49', 0);
INSERT INTO `user` VALUES (455, 'Yeow Suk Yee', 'qPcl1iLR4F', 'yeowsukyee51@icloud.com', 'Yeow Suk Yee', '80-5016-4900', 'user', '2007-05-16 20:22:47', '2003-02-26 10:54:36', 1);
INSERT INTO `user` VALUES (456, 'Mak Suk Yee', 'OjTGbMPnKF', 'sukyeemak522@hotmail.com', 'Mak Suk Yee', '145-2916-8033', 'user', '2023-07-06 15:18:41', '2016-09-07 07:24:48', 0);
INSERT INTO `user` VALUES (457, 'Cho Ling Ling', '7vGk0qCuAC', 'choll304@yahoo.com', 'Cho Ling Ling', '312-766-5809', 'user', '2009-03-11 20:02:31', '2018-06-28 17:13:40', 1);
INSERT INTO `user` VALUES (458, 'Amber Gray', 'gh4y6Q5yhI', 'agra41@hotmail.com', 'Amber Gray', '20-5222-3966', 'user', '2001-03-10 22:39:02', '2002-04-03 01:45:52', 1);
INSERT INTO `user` VALUES (459, 'Lo Ting Fung', 'nVQMGlzCik', 'tflo@icloud.com', 'Lo Ting Fung', '7882 462502', 'user', '2007-01-13 20:25:14', '2010-10-22 20:54:49', 0);
INSERT INTO `user` VALUES (460, 'Kathleen Snyder', 'pIOxUBXLt4', 'kathleensnyder@icloud.com', 'Kathleen Snyder', '66-783-9472', 'user', '2007-06-20 07:02:07', '2017-09-23 17:04:26', 0);
INSERT INTO `user` VALUES (461, 'David Martinez', 'BVhCOahQOS', 'damart@gmail.com', 'David Martinez', '188-7682-5746', 'user', '2016-02-25 18:16:04', '2019-01-24 10:54:01', 1);
INSERT INTO `user` VALUES (462, 'Alfred Schmidt', '2mvKnG5WPl', 'schmidtalfred629@hotmail.com', 'Alfred Schmidt', '177-8406-9571', 'user', '2020-09-19 09:12:00', '2004-10-27 21:24:41', 1);
INSERT INTO `user` VALUES (463, 'Rhonda Jones', 'd1uXoV5iIY', 'jonerh915@outlook.com', 'Rhonda Jones', '760-937-7206', 'user', '2014-11-21 12:38:28', '2006-06-11 05:02:55', 0);
INSERT INTO `user` VALUES (464, 'Frederick Ryan', 'CJMfZEjrTl', 'ryan1976@gmail.com', 'Frederick Ryan', '182-3088-7241', 'user', '2020-02-19 21:34:28', '2013-10-09 09:03:10', 1);
INSERT INTO `user` VALUES (465, 'Lo Wai Yee', 'kJeWu2TaU5', 'wylo@gmail.com', 'Lo Wai Yee', '5703 701029', 'user', '2020-06-02 06:17:04', '2019-04-25 12:15:07', 1);
INSERT INTO `user` VALUES (466, 'Lu Lu', 'cdWXOVQ9Ah', 'lulu@icloud.com', '陆璐', '188-9238-5413', 'user', '2022-04-01 23:16:02', '2001-11-22 19:34:35', 1);
INSERT INTO `user` VALUES (467, 'Siu Wai Man', 'qMVkZNooCq', 'wmsiu1955@gmail.com', 'Siu Wai Man', '718-381-2378', 'user', '2005-06-19 18:55:44', '2014-10-06 12:44:53', 1);
INSERT INTO `user` VALUES (468, 'Zeng Ziyi', '8zDwQOyFS5', 'ziyizeng1965@hotmail.com', '曾子异', '614-618-7788', 'user', '2013-09-17 16:07:30', '2018-10-28 22:40:54', 1);
INSERT INTO `user` VALUES (469, 'Tong Ling Ling', 'K62d7ThTK7', 'linglingtong@icloud.com', 'Tong Ling Ling', '718-485-3470', 'user', '2014-11-20 11:00:46', '2008-09-02 00:38:58', 0);
INSERT INTO `user` VALUES (470, 'Cheng Yuning', 'vfj5aXUdpj', 'cyuning66@gmail.com', '程宇宁', '20-3538-6220', 'user', '2016-01-26 12:17:20', '2024-05-18 22:00:41', 1);
INSERT INTO `user` VALUES (471, 'Fu Yunxi', 'flN8vab2lt', 'fuyu@icloud.com', '傅云熙', '614-534-6009', 'user', '2009-12-04 14:30:32', '2010-04-12 17:35:03', 0);
INSERT INTO `user` VALUES (472, 'Luo Yuning', 'JxwQu1h1wm', 'lyuning6@hotmail.com', 'Luo Yuning', '769-200-1646', 'user', '2005-02-28 05:15:38', '2008-01-13 19:56:16', 1);
INSERT INTO `user` VALUES (473, 'Kwong Fu Shing', 'beceFaJ9PS', 'kwfushing9@gmail.com', 'Kwong Fu Shing', '66-417-3051', 'user', '2015-06-26 08:27:16', '2021-04-01 03:33:36', 1);
INSERT INTO `user` VALUES (474, 'Monica Edwards', 'ziCSYCD7dk', 'medwards3@outlook.com', 'Monica Edwards', '70-6271-7340', 'user', '2016-09-18 16:32:23', '2000-11-28 23:08:55', 0);
INSERT INTO `user` VALUES (475, 'Xue Lu', 'DscBM3yNQS', 'xue3@gmail.com', '薛璐', '760-5123-6274', 'user', '2007-04-12 21:44:13', '2007-07-14 06:42:44', 1);
INSERT INTO `user` VALUES (476, 'Alan Ryan', 'f2BBKjOkQz', 'aryan5@gmail.com', 'Alan Ryan', '80-4472-9575', 'user', '2021-12-15 11:17:28', '2004-07-14 12:48:39', 0);
INSERT INTO `user` VALUES (477, 'Han Ka Ling', 'b0j9xScSMD', 'hakaling@gmail.com', 'Han Ka Ling', '(1865) 74 1611', 'user', '2003-07-01 01:32:59', '2008-10-25 20:14:55', 0);
INSERT INTO `user` VALUES (478, 'Lam Yun Fat', 'Op4usBiU6H', 'yunfatlam@icloud.com', 'Lam Yun Fat', '614-550-2391', 'user', '2006-05-02 08:42:58', '2013-05-19 13:29:43', 1);
INSERT INTO `user` VALUES (479, 'Andrea Gray', '1VEzbcYeps', 'agray@icloud.com', 'Andrea Gray', '66-302-7259', 'user', '2004-06-21 05:26:23', '2003-07-03 13:21:35', 0);
INSERT INTO `user` VALUES (480, 'Koo Kwok Ming', 'BDvkN6lQzT', 'kwokmingkoo89@yahoo.com', 'Koo Kwok Ming', '614-343-5617', 'user', '2019-03-11 04:10:25', '2020-01-06 19:43:58', 0);
INSERT INTO `user` VALUES (481, 'Xia Rui', 'MHH1CXGWTl', 'xiar10@mail.com', 'Xia Rui', '5062 074767', 'user', '2019-08-16 07:31:15', '2010-11-21 12:20:31', 0);
INSERT INTO `user` VALUES (482, 'Hu Zitao', '42PFAwNZzE', 'zitaohu@outlook.com', 'Hu Zitao', '(1865) 08 4768', 'user', '2017-03-30 20:50:54', '2014-04-21 14:32:39', 1);
INSERT INTO `user` VALUES (483, 'Phyllis Mitchell', 'XAfYfOi3HM', 'mp72@gmail.com', 'Phyllis Mitchell', '178-4274-6766', 'user', '2004-10-23 06:17:05', '2019-01-20 14:23:48', 0);
INSERT INTO `user` VALUES (484, 'Li Lu', 'cqH968Tjpb', 'lu2010@mail.com', 'Li Lu', '769-293-9607', 'user', '2008-10-10 15:36:35', '2014-09-28 05:25:28', 1);
INSERT INTO `user` VALUES (485, 'Debra Patterson', '0HECh2yI0k', 'debra1218@outlook.com', 'Debra Patterson', '66-477-8186', 'user', '2001-03-05 14:04:24', '2024-04-20 20:43:40', 0);
INSERT INTO `user` VALUES (486, 'Stephen Ross', '6cTAOLUdmL', 'rosstep@outlook.com', 'Stephen Ross', '80-4308-2929', 'user', '2004-04-18 00:10:34', '2005-09-22 17:57:30', 1);
INSERT INTO `user` VALUES (487, 'Fong Ming', 'Nmf56De8AP', 'mingfon218@icloud.com', 'Fong Ming', '(151) 041 6179', 'user', '2023-07-21 09:04:36', '2002-01-24 19:56:59', 0);
INSERT INTO `user` VALUES (488, 'Yuen Tak Wah', 'KnGL438hBk', 'takwahyue@mail.com', 'Yuen Tak Wah', '80-5452-8132', 'user', '2019-09-06 23:21:55', '2012-03-24 14:59:56', 0);
INSERT INTO `user` VALUES (489, 'Chen Zhiyuan', 'zCqXUu98Vw', 'chzhiyuan820@yahoo.com', '陈致远', '191-5530-0529', 'user', '2017-07-05 19:29:23', '2016-10-13 22:58:29', 0);
INSERT INTO `user` VALUES (490, 'Pang Ka Ling', 'pW4kDO2w1y', 'kaling9@outlook.com', 'Pang Ka Ling', '52-897-0392', 'user', '2021-04-30 10:28:42', '2018-04-22 22:59:51', 0);
INSERT INTO `user` VALUES (491, 'Zou Rui', 'vEB4lzM6EH', 'zour408@gmail.com', 'Zou Rui', '197-7634-2134', 'user', '2003-11-05 08:17:02', '2013-12-10 23:07:56', 0);
INSERT INTO `user` VALUES (492, 'Tao Kwok Yin', 'EH4uhgEizE', 'kwokyin5@gmail.com', 'Tao Kwok Yin', '(151) 859 2253', 'user', '2003-05-19 21:05:04', '2005-09-22 00:15:50', 0);
INSERT INTO `user` VALUES (493, 'Chang Wing Suen', 'msSsXNj73X', 'wingcha@outlook.com', 'Chang Wing Suen', '(121) 751 1632', 'user', '2004-12-09 18:41:24', '2006-06-09 05:09:28', 0);
INSERT INTO `user` VALUES (494, 'Liao Zhennan', 'GMGWDMlLUX', 'zhenliao4@outlook.com', 'Liao Zhennan', '5146 717088', 'user', '2017-12-20 12:46:09', '2015-08-12 05:03:57', 1);
INSERT INTO `user` VALUES (495, 'Paula Miller', '5B1eBAZtUc', 'pamille@gmail.com', 'Paula Miller', '(161) 777 3694', 'user', '2003-03-15 13:39:12', '2018-07-22 19:02:11', 1);
INSERT INTO `user` VALUES (496, 'Duan Jiehong', 'fG03acxxev', 'jiehong01@hotmail.com', '段杰宏', '718-604-0936', 'user', '2003-11-25 10:59:31', '2014-11-16 17:44:33', 1);
INSERT INTO `user` VALUES (497, 'Theodore Baker', 'lsamNZjAoQ', 'theodore708@gmail.com', 'Theodore Baker', '136-4860-5093', 'user', '2021-12-15 13:09:09', '2009-10-24 21:29:52', 0);
INSERT INTO `user` VALUES (498, 'Pamela Jordan', 'NEbrEKTslU', 'pamelajor@mail.com', 'Pamela Jordan', '718-696-9452', 'user', '2008-04-22 07:27:48', '2004-03-05 15:33:12', 1);
INSERT INTO `user` VALUES (499, 'Ti Ka Man', 'FvAQJ6nixn', 'kmti1011@yahoo.com', 'Ti Ka Man', '138-9848-9834', 'user', '2020-03-06 00:13:50', '2008-06-10 00:11:26', 0);
INSERT INTO `user` VALUES (500, 'Cheng Tin Lok', 'wXH7G2Q3WW', 'cheng1991@mail.com', 'Cheng Tin Lok', '66-207-2225', 'user', '2011-12-09 03:56:32', '2006-12-18 13:20:09', 1);
INSERT INTO `user` VALUES (501, 'Wong Tak Wah', 'xA1ZqpK1me', 'wontw45@outlook.com', 'Wong Tak Wah', '(1865) 10 8871', 'user', '2021-07-28 09:57:38', '2020-12-03 07:54:27', 1);
INSERT INTO `user` VALUES (502, 'Feng Zhiyuan', 'zx7oypQPRe', 'zhiyuanfe@gmail.com', '冯致远', '755-437-2093', 'user', '2012-01-05 23:11:37', '2001-06-05 16:35:33', 0);
INSERT INTO `user` VALUES (503, 'Shi Zitao', '9ekG4NSA46', 'shzitao74@outlook.com', 'Shi Zitao', '66-067-1184', 'user', '2013-05-03 20:45:16', '2014-10-23 22:21:58', 0);
INSERT INTO `user` VALUES (504, 'Deng Zhiyuan', 'ox2lJFb3LG', 'zhiyuan830@mail.com', 'Deng Zhiyuan', '70-9904-9517', 'user', '2014-12-20 06:51:56', '2002-11-05 14:33:52', 0);
INSERT INTO `user` VALUES (505, 'Ruby Snyder', '0eYXchR07Q', 'rsnyder@outlook.com', 'Ruby Snyder', '(161) 182 7953', 'user', '2009-02-27 16:46:44', '2020-03-19 05:22:44', 0);
INSERT INTO `user` VALUES (506, 'Lam Tsz Ching', 'oxEO6yt7PA', 'lamtszching@gmail.com', 'Lam Tsz Ching', '74-080-5839', 'user', '2010-01-20 12:07:28', '2001-07-25 20:03:26', 1);
INSERT INTO `user` VALUES (507, 'Kathleen Sullivan', 'AbvOZ3iPpM', 'kathleens@outlook.com', 'Kathleen Sullivan', '7071 645461', 'user', '2015-08-17 20:36:58', '2002-10-04 09:53:03', 0);
INSERT INTO `user` VALUES (508, 'Yue Sze Kwan', 'woqZe4fSqa', 'szeyue1213@outlook.com', 'Yue Sze Kwan', '90-3383-7412', 'user', '2023-03-29 06:29:43', '2024-04-28 04:56:44', 1);
INSERT INTO `user` VALUES (509, 'Yung Chung Yin', 'IrrGsjNHAR', 'chungyiny@mail.com', 'Yung Chung Yin', '7288 631838', 'user', '2014-05-26 19:29:46', '2019-10-26 18:37:11', 0);
INSERT INTO `user` VALUES (510, 'Wang Anqi', '3Xjyrep4xd', 'wanganqi@yahoo.com', '汪安琪', '(121) 397 5140', 'user', '2012-11-15 21:21:12', '2015-02-06 20:46:52', 0);
INSERT INTO `user` VALUES (511, 'Zhu Ziyi', 'kSksgJMU9C', 'zhuziyi@outlook.com', 'Zhu Ziyi', '7874 999901', 'user', '2013-09-14 08:15:05', '2003-04-25 05:55:36', 0);
INSERT INTO `user` VALUES (512, 'Lee Wai Man', '6OMWW8XX7B', 'lwm@mail.com', 'Lee Wai Man', '90-0486-7629', 'user', '2019-12-28 04:58:43', '2003-11-02 13:52:02', 1);
INSERT INTO `user` VALUES (513, 'Xu Lu', 'tt8qVznbqy', 'luxu@yahoo.com', '徐璐', '52-167-9211', 'user', '2002-05-03 22:01:42', '2021-02-05 01:38:25', 0);
INSERT INTO `user` VALUES (514, 'Allen Adams', 'SgsStsSsCS', 'adams5@outlook.com', 'Allen Adams', '80-3838-4731', 'user', '2002-03-01 13:50:54', '2005-11-27 14:26:04', 1);
INSERT INTO `user` VALUES (515, 'Carlos Adams', 'Py9IiyZElU', 'cadams2@gmail.com', 'Carlos Adams', '760-041-8575', 'user', '2008-03-09 12:09:08', '2002-11-09 07:33:48', 1);
INSERT INTO `user` VALUES (516, 'Cao Zhiyuan', 'FqmpST2RPf', 'caozhiyuan@icloud.com', 'Cao Zhiyuan', '(121) 755 6548', 'user', '2015-03-23 17:27:56', '2016-08-16 04:21:30', 0);
INSERT INTO `user` VALUES (517, 'Liao Ka Ling', 'AEkG1N4eEd', 'kalingliao@outlook.com', 'Liao Ka Ling', '90-7759-3814', 'user', '2024-01-08 06:41:23', '2009-04-21 01:42:12', 1);
INSERT INTO `user` VALUES (518, 'Angela Evans', 'b2r8oc4gaB', 'angelaevans@yahoo.com', 'Angela Evans', '(121) 393 4814', 'user', '2022-11-04 10:17:26', '2017-10-26 03:53:44', 0);
INSERT INTO `user` VALUES (519, 'Frances Simmons', 'LnNtzbFlEV', 'francessimm@yahoo.com', 'Frances Simmons', '(121) 723 9810', 'user', '2003-02-22 10:48:28', '2009-01-26 10:40:49', 1);
INSERT INTO `user` VALUES (520, 'Xiong Zhiyuan', 'RSFVN3FEcZ', 'zhiyuan1@yahoo.com', 'Xiong Zhiyuan', '755-837-4649', 'user', '2012-11-14 11:18:13', '2014-04-08 08:03:55', 0);
INSERT INTO `user` VALUES (521, 'Jeff Aguilar', 'V3W8VrMtdO', 'jeffagu@outlook.com', 'Jeff Aguilar', '80-5927-9833', 'user', '2007-05-04 15:13:16', '2014-11-10 07:07:02', 0);
INSERT INTO `user` VALUES (522, 'Tian Zhiyuan', 'VrefJTzZHq', 'tzh@gmail.com', 'Tian Zhiyuan', '152-8100-5694', 'user', '2024-04-01 09:32:41', '2001-11-11 20:54:28', 1);
INSERT INTO `user` VALUES (523, 'Yin Yunxi', 'FtyhG1X7G7', 'yunxi9@gmail.com', '尹云熙', '(161) 219 1269', 'user', '2021-07-15 11:43:59', '2021-04-03 08:06:03', 1);
INSERT INTO `user` VALUES (524, 'Yuen Chi Yuen', 'b22ohqXTMY', 'cyyuen@gmail.com', 'Yuen Chi Yuen', '7299 388245', 'user', '2018-04-29 01:06:29', '2005-07-24 16:33:41', 1);
INSERT INTO `user` VALUES (525, 'Lei Xiaoming', '1MaDoBkZGZ', 'xiaomingle723@outlook.com', 'Lei Xiaoming', '(1865) 33 5798', 'user', '2012-01-13 09:37:33', '2000-10-13 05:55:42', 0);
INSERT INTO `user` VALUES (526, 'Tang Lan', 'AXuEkH16Zk', 'tangla@gmail.com', 'Tang Lan', '(1865) 94 5114', 'user', '2015-04-16 00:32:52', '2003-05-20 04:06:18', 1);
INSERT INTO `user` VALUES (527, 'Danielle Ryan', 'LWG9ogEtX6', 'danielle19@gmail.com', 'Danielle Ryan', '11-466-2676', 'user', '2003-08-27 13:47:49', '2001-04-05 12:36:08', 0);
INSERT INTO `user` VALUES (528, 'Peng Anqi', 'S790RxojAA', 'peanqi@gmail.com', 'Peng Anqi', '164-7588-5285', 'user', '2004-12-29 18:45:16', '2008-08-07 02:38:52', 0);
INSERT INTO `user` VALUES (529, 'Xie Zitao', 'sBzgnKgCFK', 'xzita@outlook.com', 'Xie Zitao', '(121) 169 6650', 'user', '2014-03-22 01:31:21', '2010-09-15 14:44:11', 0);
INSERT INTO `user` VALUES (530, 'Alexander Sanchez', 'qYVc2FNahs', 'alexandersanchez00@yahoo.com', 'Alexander Sanchez', '74-309-7093', 'user', '2000-09-24 07:28:47', '2011-12-08 03:20:35', 0);
INSERT INTO `user` VALUES (531, 'Xie Rui', 'aXZTbC4Zfz', 'ruixie@hotmail.com', '谢睿', '90-3029-5981', 'user', '2019-08-07 18:52:38', '2009-12-13 12:48:46', 0);
INSERT INTO `user` VALUES (532, 'Yao Yuning', 'NBXyRqxfIW', 'yayuning@yahoo.com', '姚宇宁', '11-444-3340', 'user', '2003-01-18 21:49:10', '2015-03-24 01:50:30', 0);
INSERT INTO `user` VALUES (533, 'Che Chiu Wai', 'mkWiRAdKVL', 'checw1@outlook.com', 'Che Chiu Wai', '10-533-5521', 'user', '2022-10-13 18:15:21', '2004-10-22 18:51:11', 0);
INSERT INTO `user` VALUES (534, 'James Lee', 'mRZu6hqRhh', 'lejames@mail.com', 'James Lee', '80-4545-2966', 'user', '2019-12-15 06:03:16', '2022-03-20 17:38:57', 1);
INSERT INTO `user` VALUES (535, 'Stephen Aguilar', '666666', 'stephena1@icloud.com', 'Stephen Aguilar', '(1223) 94 4532', 'user', '2000-04-10 19:45:20', '2024-12-21 16:39:48', 1);
INSERT INTO `user` VALUES (536, 'Cheryl Garcia', 'cyPFtYfOiT', 'garciacheryl@outlook.com', 'Cheryl Garcia', '11-876-1404', 'user', '2006-10-25 04:12:09', '2014-04-24 22:58:21', 0);
INSERT INTO `user` VALUES (537, 'Yan Jialun', 'rd8KNzR0gI', 'jialuyan@mail.com', '阎嘉伦', '7953 614050', 'user', '2001-05-24 16:45:57', '2006-12-27 12:04:35', 0);
INSERT INTO `user` VALUES (538, 'Loui Wing Sze', '5lFfRFDCUh', 'wsl@mail.com', 'Loui Wing Sze', '70-9239-5531', 'user', '2017-12-24 05:41:33', '2010-12-11 04:51:30', 0);
INSERT INTO `user` VALUES (539, 'Rita Tran', 'uH4zFa4eat', 'tran92@outlook.com', 'Rita Tran', '70-0075-4075', 'user', '2008-03-26 17:46:52', '2011-06-19 19:20:25', 1);
INSERT INTO `user` VALUES (540, 'Ku Siu Wai', 'aY2w7YZYKY', 'siuwaiku203@icloud.com', 'Ku Siu Wai', '(20) 2993 9513', 'user', '2020-03-18 21:40:39', '2002-03-08 12:20:00', 0);
INSERT INTO `user` VALUES (541, 'Yan Lu', 'Pa3LlRFoMr', 'luya222@gmail.com', '阎璐', '718-818-5630', 'user', '2014-03-07 19:25:42', '2009-04-01 05:03:42', 1);
INSERT INTO `user` VALUES (542, 'Glenn Martin', 'RJgZaXZbun', 'magle9@icloud.com', 'Glenn Martin', '74-193-0130', 'user', '2014-04-17 00:28:47', '2008-09-27 17:18:30', 0);
INSERT INTO `user` VALUES (543, 'Xiao Anqi', 'cPfXdarvmH', 'anqix@gmail.com', 'Xiao Anqi', '(1865) 05 2379', 'user', '2018-08-02 19:07:06', '2004-02-12 18:00:09', 0);
INSERT INTO `user` VALUES (544, 'Chic Sai Wing', 'HnB3XAKuKp', 'saichic@hotmail.com', 'Chic Sai Wing', '7476 930391', 'user', '2008-03-03 04:01:27', '2003-01-20 17:42:05', 1);
INSERT INTO `user` VALUES (545, 'Janice Hughes', 'uiUU6GlNUm', 'hughejanice619@icloud.com', 'Janice Hughes', '(121) 306 9990', 'user', '2010-09-20 13:05:45', '2008-10-22 20:13:53', 1);
INSERT INTO `user` VALUES (546, 'Tam Yun Fat', '1yL0WixQie', 'tamyunf@gmail.com', 'Tam Yun Fat', '20-9515-8930', 'user', '2023-03-18 22:05:20', '2020-05-07 03:00:54', 1);
INSERT INTO `user` VALUES (547, 'Diana Griffin', 'y6CmMU9Fyz', 'griffin3@yahoo.com', 'Diana Griffin', '156-5174-5656', 'user', '2020-12-19 20:03:27', '2007-07-15 00:19:11', 1);
INSERT INTO `user` VALUES (548, 'Tan Xiaoming', 'dNjJcTNprb', 'tanxi@gmail.com', 'Tan Xiaoming', '90-0389-5346', 'user', '2012-07-27 19:05:11', '2010-06-10 01:59:34', 0);
INSERT INTO `user` VALUES (549, 'Choi Kwok Kuen', 'wP3iyTUkmr', 'kwokkuenc@mail.com', 'Choi Kwok Kuen', '70-2962-2241', 'user', '2008-08-24 02:10:21', '2014-02-13 20:38:37', 1);
INSERT INTO `user` VALUES (550, 'Shi Rui', 'HlwkMzETt2', 'srui53@gmail.com', '史睿', '150-1837-6581', 'user', '2024-02-07 04:15:59', '2020-12-20 13:31:48', 1);
INSERT INTO `user` VALUES (551, 'Scott Kim', 'zIZ4eZA2rI', 'kimscott@gmail.com', 'Scott Kim', '614-691-9309', 'user', '2016-05-09 02:34:43', '2018-03-09 19:30:55', 0);
INSERT INTO `user` VALUES (552, 'Bonnie Wallace', '2WzjnVehBi', 'walbonnie@outlook.com', 'Bonnie Wallace', '(116) 245 8201', 'user', '2001-11-26 20:55:33', '2016-07-21 14:35:15', 0);
INSERT INTO `user` VALUES (553, 'Shi Ziyi', 'hBcBW9GXbJ', 'ziys@gmail.com', 'Shi Ziyi', '(1865) 95 1892', 'user', '2022-11-13 11:41:28', '2007-10-23 04:16:52', 1);
INSERT INTO `user` VALUES (554, 'Choi Hok Yau', 'QnOpj5cGkl', 'hokyau12@gmail.com', 'Choi Hok Yau', '139-7600-1989', 'user', '2016-04-10 02:57:02', '2001-06-14 04:19:50', 1);
INSERT INTO `user` VALUES (555, 'Yip Tsz Ching', 'mEx5bfZYgG', 'tszching1116@icloud.com', 'Yip Tsz Ching', '838-190-0747', 'user', '2018-07-02 19:01:54', '2007-07-28 14:33:35', 0);
INSERT INTO `user` VALUES (556, 'Yip Ling Ling', 'VzUXkbynB9', 'linglingyi05@gmail.com', 'Yip Ling Ling', '838-808-0504', 'user', '2013-05-10 20:46:03', '2000-06-28 02:22:49', 1);
INSERT INTO `user` VALUES (557, 'Luis Williams', 'aSb87q8V53', 'williamsluis1@icloud.com', 'Luis Williams', '90-3298-2258', 'user', '2006-11-22 01:12:00', '2000-07-22 21:32:32', 0);
INSERT INTO `user` VALUES (558, 'Fong Kwok Kuen', 'poaAXq31to', 'kkfong7@outlook.com', 'Fong Kwok Kuen', '213-470-1973', 'user', '2005-06-21 03:59:03', '2007-06-12 20:41:22', 1);
INSERT INTO `user` VALUES (559, 'Shi Yunxi', 'uvHtGNIRPU', 'yunxishi@outlook.com', 'Shi Yunxi', '169-5439-1722', 'user', '2023-04-23 06:55:39', '2019-03-29 04:41:19', 0);
INSERT INTO `user` VALUES (560, 'Yu Zitao', 'wEo5Y1503v', 'yuzit@icloud.com', '余子韬', '213-349-6134', 'user', '2015-09-19 08:50:33', '2000-08-14 22:08:30', 0);
INSERT INTO `user` VALUES (561, 'Gu Rui', 'vd0mpjmiGE', 'grui@icloud.com', '顾睿', '10-5644-1069', 'user', '2012-08-21 06:10:26', '2009-02-07 19:30:05', 1);
INSERT INTO `user` VALUES (562, 'Chow Ting Fung', 'E8oxbdDhkS', 'chotf9@icloud.com', 'Chow Ting Fung', '70-1610-1500', 'user', '2012-02-28 06:38:19', '2018-07-20 15:18:06', 0);
INSERT INTO `user` VALUES (563, 'Tang Kwok Ming', '9SJ3NGNftE', 'tankm1@yahoo.com', 'Tang Kwok Ming', '213-868-1900', 'user', '2011-02-24 13:54:10', '2009-10-12 17:44:12', 0);
INSERT INTO `user` VALUES (564, 'Mak Sze Kwan', 'AN5ntJdGlk', 'szekwanmak@gmail.com', 'Mak Sze Kwan', '28-086-6637', 'user', '2000-10-07 09:17:06', '2007-07-26 20:46:09', 1);
INSERT INTO `user` VALUES (565, 'Kwok Lik Sun', '8YdJwRLSLo', 'liksunkwo@hotmail.com', 'Kwok Lik Sun', '11-000-3083', 'user', '2000-12-11 07:52:27', '2017-12-06 21:01:10', 1);
INSERT INTO `user` VALUES (566, 'Fang Zhennan', 'rcXhXRt1wu', 'zhennanfan@gmail.com', 'Fang Zhennan', '140-0664-4214', 'user', '2004-11-09 13:49:25', '2015-02-07 08:58:24', 0);
INSERT INTO `user` VALUES (567, 'Loui Chung Yin', 'SyZo8WAv8M', 'louicy7@yahoo.com', 'Loui Chung Yin', '838-932-0900', 'user', '2021-08-12 10:28:17', '2002-12-24 16:40:54', 0);
INSERT INTO `user` VALUES (568, 'Cheng Sum Wing', 'aiiFLsZjvM', 'swcheng@mail.com', 'Cheng Sum Wing', '330-081-2975', 'user', '2017-09-24 00:14:57', '2014-04-26 18:26:09', 1);
INSERT INTO `user` VALUES (569, 'Wong Lik Sun', '5ccmiSKGmX', 'lsw@gmail.com', 'Wong Lik Sun', '172-1414-3255', 'user', '2015-12-19 00:40:59', '2005-03-08 11:45:11', 0);
INSERT INTO `user` VALUES (570, 'Bernard Barnes', 'u26fvQRaxV', 'bernardbarn@outlook.com', 'Bernard Barnes', '11-011-3341', 'user', '2016-03-16 05:58:21', '2009-03-06 11:16:00', 0);
INSERT INTO `user` VALUES (571, 'Ng On Na', 'FP13BRvVhb', 'onng6@mail.com', 'Ng On Na', '838-429-9507', 'user', '2022-04-08 16:02:35', '2003-08-14 03:44:28', 0);
INSERT INTO `user` VALUES (572, 'Chang On Na', 'awTXByRZEv', 'onna9@gmail.com', 'Chang On Na', '769-876-7931', 'user', '2001-01-14 18:21:36', '2015-05-02 08:46:23', 0);
INSERT INTO `user` VALUES (573, 'Vincent Evans', 'ubEw5TN6DA', 'evince71@hotmail.com', 'Vincent Evans', '90-5797-1901', 'user', '2018-08-02 02:03:58', '2021-06-30 11:16:00', 0);
INSERT INTO `user` VALUES (574, 'Theodore Romero', 'My55nLcKV1', 'theodorero@gmail.com', 'Theodore Romero', '70-8485-3080', 'user', '2021-07-19 04:24:37', '2010-07-31 04:59:39', 0);
INSERT INTO `user` VALUES (575, 'Johnny Murphy', 'iE2dAIdPvU', 'johnnmurphy@gmail.com', 'Johnny Murphy', '176-9949-8870', 'user', '2004-07-04 05:00:31', '2009-01-01 15:40:26', 1);
INSERT INTO `user` VALUES (576, 'Koon Sum Wing', 'p33tezShPE', 'koon1021@mail.com', 'Koon Sum Wing', '5829 340461', 'user', '2003-01-30 01:37:44', '2024-08-17 18:36:31', 0);
INSERT INTO `user` VALUES (577, 'Chiang Ka Keung', '7w29eQhZHC', 'chiangkakeung@mail.com', 'Chiang Ka Keung', '3-5821-5452', 'user', '2022-01-25 00:40:49', '2019-03-16 17:46:37', 0);
INSERT INTO `user` VALUES (578, 'Denise White', '4tjc5ojLFl', 'dwh208@yahoo.com', 'Denise White', '80-0756-4238', 'user', '2016-08-20 14:47:50', '2010-09-06 04:48:57', 0);
INSERT INTO `user` VALUES (579, 'Gladys Diaz', '3S59v00T9i', 'diazgla825@outlook.com', 'Gladys Diaz', '(121) 480 7478', 'user', '2019-05-15 00:18:40', '2018-11-18 08:01:47', 0);
INSERT INTO `user` VALUES (580, 'Xie Xiuying', 'kdV9VxRfbg', 'xiux@gmail.com', 'Xie Xiuying', '90-8823-2336', 'user', '2016-01-13 17:56:18', '2003-01-03 18:14:54', 0);
INSERT INTO `user` VALUES (581, 'Mak Kar Yan', 'FHjVn8GaoE', 'mkar@yahoo.com', 'Mak Kar Yan', '80-9331-7352', 'user', '2003-05-08 04:42:50', '2009-04-21 14:49:20', 0);
INSERT INTO `user` VALUES (582, 'Lok On Na', 'gQyhF8bRwQ', 'lokonna1@outlook.com', 'Lok On Na', '66-845-3750', 'user', '2004-08-19 12:34:39', '2022-09-18 04:46:29', 0);
INSERT INTO `user` VALUES (583, 'Elaine Thomas', 'v5Lt7qkEDM', 'thomela@hotmail.com', 'Elaine Thomas', '90-3618-6893', 'user', '2008-06-16 06:25:43', '2005-01-25 20:04:20', 1);
INSERT INTO `user` VALUES (584, 'Jeff Flores', 'HUVQiW3r0H', 'jeff6@gmail.com', 'Jeff Flores', '197-8502-9992', 'user', '2017-09-16 18:51:00', '2010-11-29 03:28:30', 1);
INSERT INTO `user` VALUES (585, 'Tong Lai Yan', 'i0IU452oE6', 'tonly@gmail.com', 'Tong Lai Yan', '141-1596-9466', 'user', '2009-12-29 17:20:13', '2001-10-30 22:08:46', 0);
INSERT INTO `user` VALUES (586, 'Lu Jiehong', 'ejJnXXr2FC', 'lujiehong2@hotmail.com', 'Lu Jiehong', '312-279-0198', 'user', '2009-08-14 00:27:48', '2024-04-13 00:31:45', 0);
INSERT INTO `user` VALUES (587, 'Ng Ka Fai', 'KYVZ6mVRC9', 'kang@gmail.com', 'Ng Ka Fai', '148-2387-7362', 'user', '2010-05-17 19:08:18', '2019-04-22 04:13:06', 1);
INSERT INTO `user` VALUES (588, 'Ralph Brooks', 'DPZhRUoOF8', 'ralpbro@icloud.com', 'Ralph Brooks', '66-250-3009', 'user', '2005-05-04 22:29:37', '2023-06-23 19:34:12', 1);
INSERT INTO `user` VALUES (589, 'Wayne Burns', 'LnHaRDGA5y', 'wayneburns57@yahoo.com', 'Wayne Burns', '718-928-8838', 'user', '2016-10-02 23:11:58', '2024-08-30 03:10:21', 0);
INSERT INTO `user` VALUES (590, 'Xu Zhiyuan', 'PoeaHCh01A', 'xuz925@gmail.com', '徐致远', '5596 257268', 'user', '2018-11-29 15:33:48', '2004-01-15 08:33:49', 1);
INSERT INTO `user` VALUES (591, 'Yeung Sum Wing', '2f8396zUet', 'yeungsw@gmail.com', 'Yeung Sum Wing', '3-2824-9455', 'user', '2000-05-14 16:48:36', '2024-11-30 18:52:03', 0);
INSERT INTO `user` VALUES (592, 'Allen Turner', 'FQsv2ysj0E', 'tallen@outlook.com', 'Allen Turner', '7112 476762', 'user', '2013-09-24 03:31:16', '2002-04-12 11:51:51', 1);
INSERT INTO `user` VALUES (593, 'Albert Tucker', 'X5lrQBn3y0', 'talbert317@outlook.com', 'Albert Tucker', '7431 736891', 'user', '2009-08-31 18:17:54', '2003-11-09 20:58:39', 0);
INSERT INTO `user` VALUES (594, 'Anita Moreno', 'zskO8XHzWv', 'anitamoreno@gmail.com', 'Anita Moreno', '213-285-8998', 'user', '2013-11-06 08:54:45', '2019-07-26 03:08:08', 0);
INSERT INTO `user` VALUES (595, 'Kathleen Rivera', '9Q0T4iGaZh', 'kathleenrivera@mail.com', 'Kathleen Rivera', '66-765-1047', 'user', '2023-09-16 14:41:32', '2016-11-18 21:53:30', 0);
INSERT INTO `user` VALUES (596, 'Chic Yu Ling', 'F4CmGKnTCv', 'cyuling@yahoo.com', 'Chic Yu Ling', '52-997-4306', 'user', '2005-11-24 08:21:34', '2021-06-24 06:35:06', 1);
INSERT INTO `user` VALUES (597, 'Dai Lai Yan', 'FynwyOytuh', 'dailaiyan1969@yahoo.com', 'Dai Lai Yan', '212-173-4250', 'user', '2008-07-20 11:19:19', '2010-07-13 22:55:54', 0);
INSERT INTO `user` VALUES (598, 'Eleanor Morris', '9lsTpAIrty', 'morriseleanor@hotmail.com', 'Eleanor Morris', '614-365-9266', 'user', '2017-04-29 12:37:34', '2003-04-05 15:08:11', 0);
INSERT INTO `user` VALUES (599, 'Doris Wright', 'cGGytaKd9O', 'doris2@outlook.com', 'Doris Wright', '70-1527-6903', 'user', '2020-02-01 03:54:32', '2012-05-25 01:27:26', 1);
INSERT INTO `user` VALUES (600, 'Zhu Shihan', 'X0g6fIIDwr', 'zhushihan9@gmail.com', 'Zhu Shihan', '133-7502-7209', 'user', '2000-07-13 15:23:31', '2012-03-23 06:20:16', 0);
INSERT INTO `user` VALUES (601, 'Brandon Rogers', 'EOcUiYHidD', 'brandroger@gmail.com', 'Brandon Rogers', '212-309-5169', 'user', '2020-10-01 11:20:50', '2003-12-01 01:21:59', 1);
INSERT INTO `user` VALUES (602, 'Shi Jiehong', '5x5khsgzaH', 'shijiehong8@gmail.com', '石杰宏', '52-189-0707', 'user', '2011-05-31 14:02:56', '2010-12-30 01:05:04', 1);
INSERT INTO `user` VALUES (603, 'Kam Chi Yuen', '4pjLMJzZgn', 'kamchiyuen210@gmail.com', 'Kam Chi Yuen', '193-2570-7296', 'user', '2003-06-22 01:51:02', '2000-01-08 23:41:25', 1);
INSERT INTO `user` VALUES (604, 'Daniel Jones', 'srD3ryICJ8', 'danj5@outlook.com', 'Daniel Jones', '80-3701-1451', 'user', '2006-11-06 07:36:51', '2022-07-26 23:35:47', 0);
INSERT INTO `user` VALUES (605, 'Wei Yuning', '6bClUQ6tLf', 'yuningw7@hotmail.com', '魏宇宁', '769-757-1750', 'user', '2020-09-06 01:58:46', '2017-10-20 08:43:04', 1);
INSERT INTO `user` VALUES (606, 'Glenn Tucker', 'WzQbPbhq9B', 'glenn10@gmail.com', 'Glenn Tucker', '70-1114-8353', 'user', '2021-02-19 01:41:09', '2013-05-18 05:40:42', 1);
INSERT INTO `user` VALUES (607, 'Lawrence West', 'T8Fx43Ym4d', 'lawrence208@outlook.com', 'Lawrence West', '70-5390-2475', 'user', '2016-11-22 12:28:20', '2013-12-26 00:23:02', 0);
INSERT INTO `user` VALUES (608, 'Mo Anqi', '04fEaz2Dlg', 'ma1023@hotmail.com', 'Mo Anqi', '10-1882-4021', 'user', '2023-10-12 05:47:11', '2003-04-02 10:43:30', 0);
INSERT INTO `user` VALUES (609, 'Lee Sze Yu', '9hGo2PZ9iv', 'syle7@icloud.com', 'Lee Sze Yu', '(20) 4244 8033', 'user', '2001-11-07 09:22:36', '2007-09-22 07:19:53', 0);
INSERT INTO `user` VALUES (610, 'James Bailey', '74ca70RKlE', 'bajames@gmail.com', 'James Bailey', '838-845-1867', 'user', '2006-04-22 04:49:09', '2007-11-18 08:33:53', 0);
INSERT INTO `user` VALUES (611, 'Hsuan Ming', 'ODgg9Gmce2', 'hsuaming@outlook.com', 'Hsuan Ming', '80-9354-8954', 'user', '2002-03-13 08:16:16', '2000-05-24 08:34:57', 0);
INSERT INTO `user` VALUES (612, 'Francis Williams', 'leioxWMTX1', 'franciswilliams@hotmail.com', 'Francis Williams', '838-054-7848', 'user', '2015-01-05 10:33:57', '2006-05-17 19:33:02', 1);
INSERT INTO `user` VALUES (613, 'Marilyn Bell', 'Nr0Rj5Cn6b', 'bell908@hotmail.com', 'Marilyn Bell', '(1223) 63 1659', 'user', '2021-05-02 07:28:19', '2011-05-11 07:12:23', 0);
INSERT INTO `user` VALUES (614, 'Ying Chiu Wai', '0VRNMW9lZf', 'yingcw@gmail.com', 'Ying Chiu Wai', '5605 970250', 'user', '2016-02-17 13:43:58', '2016-05-08 18:49:02', 0);
INSERT INTO `user` VALUES (615, 'Fang Jialun', 'UGPwYCYN1n', 'fangjialu@icloud.com', '方嘉伦', '74-085-1961', 'user', '2003-03-07 05:45:25', '2018-08-09 12:24:18', 0);
INSERT INTO `user` VALUES (616, 'Yu Yuning', '9ZWh4kuV7O', 'yuningy@yahoo.com', '于宇宁', '66-595-6328', 'user', '2004-03-22 10:01:53', '2018-07-25 14:49:48', 1);
INSERT INTO `user` VALUES (617, 'Xie Xiaoming', 'c5enH4QW3r', 'xiexiaom@outlook.com', '谢晓明', '5323 144048', 'user', '2006-07-07 10:44:58', '2005-10-27 03:16:37', 1);
INSERT INTO `user` VALUES (618, 'He Jiehong', 'yhQw6XnUiy', 'jiehonghe121@gmail.com', '何杰宏', '213-315-9721', 'user', '2015-12-15 15:00:26', '2012-06-16 17:07:47', 0);
INSERT INTO `user` VALUES (619, 'Clara Bennett', 'Xm8LLPbtEI', 'clara75@yahoo.com', 'Clara Bennett', '838-005-7820', 'user', '2002-08-20 07:18:28', '2015-12-23 19:20:57', 0);
INSERT INTO `user` VALUES (620, 'Jiang Jialun', '8ySUD4wrR8', 'jjiang@outlook.com', 'Jiang Jialun', '(151) 095 8304', 'user', '2017-10-05 16:09:48', '2016-02-03 22:47:07', 0);
INSERT INTO `user` VALUES (621, 'Monica Wright', '8WorISbWD8', 'mwr@gmail.com', 'Monica Wright', '90-7391-4910', 'user', '2009-07-29 15:29:40', '2020-05-12 05:17:30', 1);
INSERT INTO `user` VALUES (622, 'Nicole Ramos', 'G998w6cQmu', 'nramos4@mail.com', 'Nicole Ramos', '197-1512-7618', 'user', '2004-04-28 03:07:59', '2013-06-12 20:08:09', 1);
INSERT INTO `user` VALUES (623, 'Wu Hok Yau', 'liHzfPtCN6', 'wuhokyau@icloud.com', 'Wu Hok Yau', '52-389-1337', 'user', '2022-07-19 09:45:11', '2007-12-20 21:25:24', 1);
INSERT INTO `user` VALUES (624, 'Su Shihan', 'GIFISw6ADz', 'su46@gmail.com', '苏詩涵', '312-759-3372', 'user', '2021-11-06 16:52:24', '2022-06-15 06:31:09', 1);
INSERT INTO `user` VALUES (625, 'Michelle Meyer', 'OTuxn7oIYM', 'mmeye814@outlook.com', 'Michelle Meyer', '7602 829295', 'user', '2010-04-04 05:06:21', '2002-08-03 14:49:49', 0);
INSERT INTO `user` VALUES (626, 'Curtis Fisher', 'mGfYdLJobe', 'curtisf@outlook.com', 'Curtis Fisher', '90-0972-4002', 'user', '2015-01-10 21:05:04', '2019-07-12 06:31:36', 1);
INSERT INTO `user` VALUES (627, 'Alan Mason', 'wUn2AhtLKW', 'alanmason@gmail.com', 'Alan Mason', '165-2613-6279', 'user', '2011-08-23 04:05:57', '2006-05-15 07:15:10', 1);
INSERT INTO `user` VALUES (628, 'Kong Tak Wah', 'zjziq9bg4Z', 'takwah40@gmail.com', 'Kong Tak Wah', '52-246-5340', 'user', '2024-09-10 09:15:32', '2013-03-11 22:47:54', 0);
INSERT INTO `user` VALUES (629, 'Tong Tin Lok', 'XSOBaSMmHp', 'tongtl4@outlook.com', 'Tong Tin Lok', '70-0440-8762', 'user', '2018-03-17 13:09:18', '2007-03-09 15:22:31', 0);
INSERT INTO `user` VALUES (630, 'Man Tak Wah', 'qHchdGGJgB', 'man229@gmail.com', 'Man Tak Wah', '11-945-2179', 'user', '2020-10-30 21:46:30', '2018-12-01 12:02:40', 1);
INSERT INTO `user` VALUES (631, 'Gong Anqi', 'lTK1yqbKo5', 'gong5@gmail.com', 'Gong Anqi', '66-876-3571', 'user', '2018-01-26 09:02:11', '2023-07-30 21:07:22', 1);
INSERT INTO `user` VALUES (632, 'Christina Rose', 'F0Z7jqXAeT', 'rose1018@mail.com', 'Christina Rose', '21-4775-0594', 'user', '2007-11-26 07:02:15', '2015-06-11 15:23:46', 1);
INSERT INTO `user` VALUES (633, 'Shi Shihan', 'PxK7vfJf1g', 'shihan5@icloud.com', 'Shi Shihan', '614-821-5436', 'user', '2003-09-11 18:14:19', '2017-07-20 11:48:08', 1);
INSERT INTO `user` VALUES (634, 'Samuel Ramirez', 'RHegJMgwRq', 'samuelramirez2@icloud.com', 'Samuel Ramirez', '28-217-0397', 'user', '2012-05-10 15:24:51', '2022-09-01 03:10:16', 0);
INSERT INTO `user` VALUES (635, 'Nicole Soto', 'ty58QMBG4k', 'nicoles@gmail.com', 'Nicole Soto', '90-1107-9166', 'user', '2013-04-21 08:49:12', '2018-04-08 11:48:54', 1);
INSERT INTO `user` VALUES (636, 'Mao Jialun', 'qOvvbevSek', 'maojialun@gmail.com', '毛嘉伦', '213-015-9357', 'user', '2009-07-13 04:25:59', '2005-02-12 23:20:52', 1);
INSERT INTO `user` VALUES (637, 'Long Jiehong', 'yjfbfImz3d', 'longjiehong126@outlook.com', '龙杰宏', '838-322-6600', 'user', '2006-05-17 14:29:19', '2024-06-27 17:56:09', 0);
INSERT INTO `user` VALUES (638, 'Au Ching Wan', 'B0oCcivLUY', 'cwa@outlook.com', 'Au Ching Wan', '90-8671-1949', 'user', '2001-08-05 17:19:29', '2000-03-13 16:47:52', 1);
INSERT INTO `user` VALUES (639, 'Maria Freeman', 'RfqgZcvA0U', 'marf55@gmail.com', 'Maria Freeman', '(121) 988 3806', 'user', '2007-08-16 12:55:01', '2013-04-26 14:21:25', 1);
INSERT INTO `user` VALUES (640, 'Rita Wallace', 'HCWGVDAtUm', 'wallace09@icloud.com', 'Rita Wallace', '7922 069456', 'user', '2011-07-06 06:19:45', '2010-09-04 15:31:21', 0);
INSERT INTO `user` VALUES (641, 'Shing Chieh Lun', 'za0XZexdk8', 'clshing@gmail.com', 'Shing Chieh Lun', '70-6265-3802', 'user', '2015-01-29 20:50:47', '2010-08-24 04:11:26', 1);
INSERT INTO `user` VALUES (642, 'Lee Hiu Tung', 'YYQ909ez4L', 'hiutlee@yahoo.com', 'Lee Hiu Tung', '330-445-0674', 'user', '2008-07-03 20:20:49', '2003-03-11 05:35:57', 1);
INSERT INTO `user` VALUES (643, 'Craig Webb', 'SGKgi9WQPd', 'webbc@gmail.com', 'Craig Webb', '165-4426-5266', 'user', '2011-10-31 23:09:44', '2000-11-17 16:01:55', 1);
INSERT INTO `user` VALUES (644, 'Ma Xiaoming', 'R7BWhsknYV', 'xiam122@yahoo.com', '马晓明', '133-6547-6662', 'user', '2019-05-08 01:01:50', '2008-04-24 21:09:14', 0);
INSERT INTO `user` VALUES (645, 'Tian Rui', 'fq9OEC4CgP', 'tian2009@outlook.com', '田睿', '(151) 041 2166', 'user', '2016-01-21 17:08:18', '2005-09-04 15:30:13', 0);
INSERT INTO `user` VALUES (646, 'Yu Xiuying', 'vVYGDNOuWv', 'yuxiuying2@gmail.com', '余秀英', '213-358-6546', 'user', '2020-10-21 08:58:56', '2014-04-28 05:02:39', 0);
INSERT INTO `user` VALUES (647, 'Ng Tak Wah', 'ilIeOSklgj', 'takwah1940@gmail.com', 'Ng Tak Wah', '(20) 9342 0706', 'user', '2004-05-05 10:18:57', '2021-10-21 06:09:09', 0);
INSERT INTO `user` VALUES (648, 'Shannon Gordon', 'bjuLAORVwI', 'shanngordon@icloud.com', 'Shannon Gordon', '7567 238388', 'user', '2019-04-22 23:57:09', '2006-10-14 12:30:19', 1);
INSERT INTO `user` VALUES (649, 'Bernard Stone', 'Vdsj9yvGmu', 'bernardstone@gmail.com', 'Bernard Stone', '718-635-3473', 'user', '2021-12-20 16:10:46', '2015-07-20 09:57:08', 0);
INSERT INTO `user` VALUES (650, 'Joe Warren', 'druXNGgT0r', 'warrenjoe4@icloud.com', 'Joe Warren', '5947 041093', 'user', '2001-07-24 07:29:30', '2007-11-21 09:16:53', 1);
INSERT INTO `user` VALUES (651, 'Hao Zitao', '1tZvHqNvhO', 'hzitao@icloud.com', 'Hao Zitao', '52-493-2183', 'user', '2018-07-06 17:59:39', '2012-02-12 03:23:14', 1);
INSERT INTO `user` VALUES (652, 'Patrick Davis', 'oP2Ffalt8d', 'pd1109@outlook.com', 'Patrick Davis', '66-657-7610', 'user', '2024-06-12 13:51:34', '2007-07-10 10:02:54', 1);
INSERT INTO `user` VALUES (653, 'Anita Hill', 'LMoPSpfGKM', 'hill821@icloud.com', 'Anita Hill', '70-6881-0636', 'user', '2019-01-17 23:52:37', '2006-03-12 01:48:29', 0);
INSERT INTO `user` VALUES (654, 'Hui Wai Man', 'djylc64OP3', 'hui4@outlook.com', 'Hui Wai Man', '760-6585-9161', 'user', '2016-06-14 16:59:41', '2019-09-27 22:52:07', 1);
INSERT INTO `user` VALUES (655, 'Lok Siu Wai', 'hKMCxnPhou', 'loksiuwai@hotmail.com', 'Lok Siu Wai', '11-973-8316', 'user', '2004-08-30 20:06:47', '2015-08-06 22:05:01', 0);
INSERT INTO `user` VALUES (656, 'Shao Shihan', 'V156URie2e', 'shisha@gmail.com', 'Shao Shihan', '52-342-4130', 'user', '2021-11-15 15:51:05', '2014-10-06 12:53:49', 1);
INSERT INTO `user` VALUES (657, 'Lok Kwok Ming', 'nr5KEpgkGo', 'lokkwokming406@icloud.com', 'Lok Kwok Ming', '(151) 434 6029', 'user', '2002-03-23 02:51:13', '2007-07-03 02:59:13', 0);
INSERT INTO `user` VALUES (658, 'Marilyn James', 'DFnfKsEQEA', 'mariljames@icloud.com', 'Marilyn James', '80-5482-6304', 'user', '2008-09-02 09:37:12', '2019-06-21 20:01:35', 0);
INSERT INTO `user` VALUES (659, 'David Morgan', 'DQv3D4LYVu', 'modavid@gmail.com', 'David Morgan', '156-3394-6775', 'user', '2007-04-15 17:26:41', '2010-03-29 02:16:27', 1);
INSERT INTO `user` VALUES (660, 'Xue Rui', 'qAB9HRIX88', 'rui1961@yahoo.com', '薛睿', '718-869-6898', 'user', '2012-06-23 21:00:43', '2009-07-10 11:50:07', 1);
INSERT INTO `user` VALUES (661, 'Susan Mason', 'nVzLL4LFOy', 'masosusan1984@yahoo.com', 'Susan Mason', '(20) 8694 1607', 'user', '2004-09-07 13:39:51', '2022-09-30 18:43:21', 1);
INSERT INTO `user` VALUES (662, 'Qian Zhiyuan', 'vT036979xv', 'zhiyuan3@outlook.com', '钱致远', '142-3118-1617', 'user', '2000-05-27 11:15:14', '2004-09-24 17:17:19', 1);
INSERT INTO `user` VALUES (663, 'Choi Wai Yee', 'n5izZ1Odv9', 'waiychoi@icloud.com', 'Choi Wai Yee', '213-394-3261', 'user', '2019-10-27 01:01:13', '2010-07-28 05:30:05', 0);
INSERT INTO `user` VALUES (664, 'Dennis Hicks', 'Q8BIm8T4h0', 'hicks47@gmail.com', 'Dennis Hicks', '70-8568-5758', 'user', '2003-01-18 02:26:18', '2000-08-17 04:20:26', 0);
INSERT INTO `user` VALUES (665, 'Liao Jiehong', 'Sf4O5EX10a', 'jiehongliao@outlook.com', 'Liao Jiehong', '312-850-5717', 'user', '2018-08-24 07:04:13', '2016-09-08 00:13:59', 0);
INSERT INTO `user` VALUES (666, 'Xie Zhiyuan', 'Owm8as80ty', 'zhiyuanx4@icloud.com', '谢致远', '7520 971085', 'user', '2003-05-29 16:46:47', '2023-05-07 21:50:31', 1);
INSERT INTO `user` VALUES (667, 'Ryan Mills', '20b4baVrT5', 'ryanmills@gmail.com', 'Ryan Mills', '70-6541-1649', 'user', '2002-02-04 16:45:35', '2003-09-07 08:26:11', 1);
INSERT INTO `user` VALUES (668, 'Lillian Perry', 's6920WARBf', 'perli@gmail.com', 'Lillian Perry', '760-7341-1466', 'user', '2011-04-27 10:41:20', '2004-05-27 16:05:45', 0);
INSERT INTO `user` VALUES (669, 'Gong Yuning', 'aegFXPpEeA', 'yungong@gmail.com', '龚宇宁', '170-8593-2407', 'user', '2001-01-20 14:27:05', '2000-08-03 20:37:17', 1);
INSERT INTO `user` VALUES (670, 'Xiong Ziyi', 'tGWnPodFFs', 'ziyixi@yahoo.com', '熊子异', '760-369-7829', 'user', '2023-10-13 00:21:43', '2012-11-01 02:22:41', 1);
INSERT INTO `user` VALUES (671, 'Deborah Gomez', 'MJLjRgCGJP', 'debgomez@gmail.com', 'Deborah Gomez', '(1865) 16 1823', 'user', '2005-11-03 21:59:50', '2023-04-04 22:38:14', 0);
INSERT INTO `user` VALUES (672, 'Xiao Jialun', 'Jld4Zi7gNw', 'xiao73@hotmail.com', '萧嘉伦', '5942 735296', 'user', '2012-01-23 18:14:48', '2017-04-06 14:04:15', 1);
INSERT INTO `user` VALUES (673, 'Kam Wai Yee', 'tLE2NI1hVn', 'waik@gmail.com', 'Kam Wai Yee', '7251 235235', 'user', '2009-10-30 13:59:28', '2000-10-19 04:19:45', 1);
INSERT INTO `user` VALUES (674, 'Christopher Medina', 'bAgcYOUygI', 'medchristopher@icloud.com', 'Christopher Medina', '212-082-8517', 'user', '2011-11-12 15:31:50', '2011-09-28 21:26:38', 1);
INSERT INTO `user` VALUES (675, 'Wan Sze Yu', 'BWg6Y0vEL4', 'szeyuwan@icloud.com', 'Wan Sze Yu', '80-9850-0169', 'user', '2008-06-22 15:45:41', '2011-07-02 17:59:41', 1);
INSERT INTO `user` VALUES (676, 'Tammy Murphy', '8OIBrtgGJb', 'tammymurp@icloud.com', 'Tammy Murphy', '52-026-9259', 'user', '2023-03-21 12:40:41', '2006-03-16 09:07:16', 1);
INSERT INTO `user` VALUES (677, 'Ren Yuning', 'Cl7DEKfJnZ', 'ren6@gmail.com', 'Ren Yuning', '196-8085-0395', 'user', '2011-07-22 02:53:05', '2016-01-06 17:55:32', 1);
INSERT INTO `user` VALUES (678, 'Yu Yunxi', '9zZETh2S9I', 'yyu@outlook.com', '余云熙', '80-8516-7620', 'user', '2019-06-19 08:17:22', '2004-11-04 06:14:59', 1);
INSERT INTO `user` VALUES (679, 'Virginia Mills', 'tBpygCs44E', 'millsvir@icloud.com', 'Virginia Mills', '5161 627943', 'user', '2014-10-05 00:03:31', '2013-05-15 16:19:14', 1);
INSERT INTO `user` VALUES (680, 'Wu Suk Yee', 'mqOMkkCf8h', 'sukyee62@yahoo.com', 'Wu Suk Yee', '212-753-1161', 'user', '2014-04-16 07:26:59', '2001-02-11 14:23:12', 1);
INSERT INTO `user` VALUES (681, 'Grace Spencer', 'fq6L8HtEoi', 'grace1987@icloud.com', 'Grace Spencer', '(116) 938 6567', 'user', '2013-03-10 19:55:46', '2017-05-08 20:42:03', 1);
INSERT INTO `user` VALUES (682, 'Ng Wai Yee', 'z0gn7V1O3a', 'waiyee9@icloud.com', 'Ng Wai Yee', '189-3368-1343', 'user', '2001-03-26 23:53:50', '2000-06-29 00:28:16', 1);
INSERT INTO `user` VALUES (683, 'Sit Ming', '6FepNLRI4l', 'sitming@outlook.com', 'Sit Ming', '614-888-1315', 'user', '2021-05-09 17:59:47', '2013-05-13 19:02:27', 0);
INSERT INTO `user` VALUES (684, 'Shao Zhiyuan', 'w7euTFukgC', 'zhiyuans209@gmail.com', '邵致远', '769-1021-1120', 'user', '2006-05-23 09:43:45', '2014-02-02 06:38:15', 1);
INSERT INTO `user` VALUES (685, 'Chin Wing Sze', 'MAAisN42vu', 'wingsze3@icloud.com', 'Chin Wing Sze', '52-668-2525', 'user', '2008-08-11 23:44:25', '2023-01-11 10:16:38', 1);
INSERT INTO `user` VALUES (686, 'Phillip Washington', 'xGatPA4vrP', 'washington8@gmail.com', 'Phillip Washington', '718-352-7609', 'user', '2010-09-13 17:07:00', '2021-06-11 04:11:51', 0);
INSERT INTO `user` VALUES (687, 'Dawn Mitchell', 'HtoLdTSxtM', 'dawnmitchell@yahoo.com', 'Dawn Mitchell', '213-389-9604', 'user', '2021-08-10 14:17:36', '2009-12-04 20:43:12', 0);
INSERT INTO `user` VALUES (688, 'So Wai Man', 'ULyg3bSwNZ', 'wmso106@outlook.com', 'So Wai Man', '5986 742916', 'user', '2001-07-27 22:45:19', '2001-10-29 21:27:33', 1);
INSERT INTO `user` VALUES (689, 'Miu Ka Fai', 'oOqskJnkYi', 'miu122@gmail.com', 'Miu Ka Fai', '7696 340866', 'user', '2010-08-23 02:51:03', '2005-12-04 19:09:33', 1);
INSERT INTO `user` VALUES (690, 'Eleanor Harrison', 'zMRIR90Aei', 'eleanorharri@icloud.com', 'Eleanor Harrison', '138-6653-4020', 'user', '2017-07-23 04:54:55', '2015-08-10 04:57:53', 0);
INSERT INTO `user` VALUES (691, 'Yuen Chung Yin', 'ZyIVt85IlK', 'yuen1229@outlook.com', 'Yuen Chung Yin', '213-078-9349', 'user', '2023-03-28 09:26:00', '2006-07-02 17:02:25', 1);
INSERT INTO `user` VALUES (692, 'Joel Bailey', '8n7jJ0SzeS', 'joebail218@hotmail.com', 'Joel Bailey', '5714 221661', 'user', '2004-03-30 01:13:39', '2014-05-27 12:41:49', 0);
INSERT INTO `user` VALUES (693, 'Kenneth Thomas', 'fkPoN2EdQN', 'kent10@icloud.com', 'Kenneth Thomas', '718-626-8071', 'user', '2016-02-09 21:48:52', '2003-09-04 00:39:48', 0);
INSERT INTO `user` VALUES (694, 'Kenneth Olson', 'bQDxWc6AhI', 'kennetholson10@hotmail.com', 'Kenneth Olson', '178-0723-1273', 'user', '2012-04-21 11:23:44', '2019-12-07 04:45:56', 1);
INSERT INTO `user` VALUES (695, 'April Russell', 'IrfcQOwy3B', 'rusapril2@gmail.com', 'April Russell', '614-036-6239', 'user', '2005-01-05 09:04:27', '2023-11-09 17:21:12', 1);
INSERT INTO `user` VALUES (696, 'Shen Xiaoming', 'umV1w9Paux', 'xs122@gmail.com', '沈晓明', '181-5649-1892', 'user', '2011-08-02 16:29:48', '2024-10-01 01:20:47', 0);
INSERT INTO `user` VALUES (697, 'Ann Kelley', 'Kv6crxAkX0', 'ankelley@gmail.com', 'Ann Kelley', '3-8785-9616', 'user', '2002-02-18 15:05:41', '2007-05-18 01:50:19', 1);
INSERT INTO `user` VALUES (698, 'Jia Xiaoming', 'EXONleCegM', 'xji1985@gmail.com', '贾晓明', '70-8577-4500', 'user', '2008-09-11 06:42:33', '2016-03-25 15:39:27', 1);
INSERT INTO `user` VALUES (699, 'Yeow Siu Wai', 'jlRzSDdtFS', 'siuwai828@icloud.com', 'Yeow Siu Wai', '90-3638-6863', 'user', '2012-10-10 08:34:14', '2000-01-30 14:43:15', 0);
INSERT INTO `user` VALUES (700, 'Todd Martinez', 'wmga4oRyIR', 'martinez3@yahoo.com', 'Todd Martinez', '130-1729-0628', 'user', '2020-07-18 16:33:43', '2012-06-12 13:09:09', 1);
INSERT INTO `user` VALUES (701, 'Tang Shihan', '6EHuyq3RxL', 'tangshihan1220@outlook.com', 'Tang Shihan', '137-3593-1981', 'user', '2012-03-19 17:35:30', '2013-07-15 19:19:08', 0);
INSERT INTO `user` VALUES (702, 'Nicole Baker', 'q0y7V91H0u', 'bnicole3@hotmail.com', 'Nicole Baker', '760-8946-5364', 'user', '2001-07-26 14:12:08', '2018-12-08 18:18:36', 1);
INSERT INTO `user` VALUES (703, 'Tao Anqi', '1b6bA3Xi4O', 'anqtao5@gmail.com', 'Tao Anqi', '838-042-6163', 'user', '2022-03-27 04:34:24', '2013-01-20 22:33:27', 0);
INSERT INTO `user` VALUES (704, 'Mao Ziyi', 'oVfcxPGyOo', 'ziymao@outlook.com', 'Mao Ziyi', '90-6560-7808', 'user', '2001-11-10 07:21:03', '2004-03-06 11:34:48', 1);
INSERT INTO `user` VALUES (705, 'Ng Tin Wing', 'mgeYoBcK5x', 'tinwingng10@icloud.com', 'Ng Tin Wing', '312-294-6656', 'user', '2014-01-27 21:55:07', '2024-04-25 23:38:32', 0);
INSERT INTO `user` VALUES (706, 'Monica Hamilton', 'TxWC6dIz4c', 'hamiltonmonica@icloud.com', 'Monica Hamilton', '130-4436-9841', 'user', '2024-05-23 16:37:24', '2024-05-16 20:38:23', 0);
INSERT INTO `user` VALUES (707, 'Yung Ming', 'MhrbT1oAAn', 'yungm@hotmail.com', 'Yung Ming', '70-0631-2801', 'user', '2021-02-05 01:57:41', '2007-12-12 14:24:42', 1);
INSERT INTO `user` VALUES (708, 'Dong Ziyi', 'DL92EeQiFo', 'ziyidong@gmail.com', 'Dong Ziyi', '130-8083-6797', 'user', '2008-11-30 12:25:37', '2001-12-23 02:43:21', 1);
INSERT INTO `user` VALUES (709, 'Jeffery Castillo', '4adVmg1aPR', 'jcastillo@gmail.com', 'Jeffery Castillo', '90-3059-9780', 'user', '2000-04-10 11:41:19', '2007-12-06 04:58:49', 1);
INSERT INTO `user` VALUES (710, 'Ding Xiuying', 'o7Dc3tWSH6', 'xiuying1102@gmail.com', 'Ding Xiuying', '148-4975-6719', 'user', '2013-12-14 09:22:56', '2013-08-02 16:59:02', 1);
INSERT INTO `user` VALUES (711, 'Angela Munoz', '7Ge5ZjX4t5', 'munoange2007@mail.com', 'Angela Munoz', '70-3055-2075', 'user', '2008-02-15 08:35:47', '2018-04-04 17:03:23', 0);
INSERT INTO `user` VALUES (712, 'Fong Wai San', 'ENGSvjjtl7', 'fwa@outlook.com', 'Fong Wai San', '3-2962-7987', 'user', '2017-09-23 16:16:41', '2006-12-15 07:56:15', 1);
INSERT INTO `user` VALUES (713, 'Peggy Sullivan', 'BdBDJc1b1V', 'peggysul87@outlook.com', 'Peggy Sullivan', '70-2222-9953', 'user', '2018-06-02 17:26:51', '2007-07-01 20:53:13', 0);
INSERT INTO `user` VALUES (714, 'Liang Xiaoming', 'o11Ni49Q3B', 'liangxiaoming@outlook.com', 'Liang Xiaoming', '(151) 769 8543', 'user', '2020-03-20 08:26:28', '2006-09-17 06:48:50', 1);
INSERT INTO `user` VALUES (715, 'Huang Xiuying', 'wuYAwlRbIf', 'xhuan@outlook.com', '黄秀英', '7454 553468', 'user', '2012-09-27 09:57:22', '2019-03-07 04:24:52', 0);
INSERT INTO `user` VALUES (716, 'Kong Shihan', 'JV9ahLV348', 'shihan723@gmail.com', 'Kong Shihan', '160-1585-1600', 'user', '2012-08-25 23:47:24', '2008-02-29 11:23:06', 0);
INSERT INTO `user` VALUES (717, 'Ying Cho Yee', 'PPDkEK2Vof', 'ycy@yahoo.com', 'Ying Cho Yee', '174-6486-8916', 'user', '2011-12-12 16:15:51', '2007-10-15 03:57:03', 1);
INSERT INTO `user` VALUES (718, 'Cynthia Hunter', 'XJ4Xao1s0E', 'huc@gmail.com', 'Cynthia Hunter', '66-364-5349', 'user', '2006-09-10 18:33:03', '2007-06-23 09:42:23', 1);
INSERT INTO `user` VALUES (719, 'Yang Zitao', 'jsCRAo1rNs', 'yzitao@gmail.com', 'Yang Zitao', '330-045-0066', 'user', '2018-09-15 19:30:58', '2004-08-10 19:16:14', 1);
INSERT INTO `user` VALUES (720, 'Tian Lu', 'IzNmY2ta89', 'tianl@yahoo.com', '田璐', '212-778-7003', 'user', '2019-05-10 15:39:22', '2016-01-08 18:39:21', 1);
INSERT INTO `user` VALUES (721, 'Cheung Ka Ming', 'H9sPPSzjxN', 'kamingch@gmail.com', 'Cheung Ka Ming', '769-1047-2473', 'user', '2022-03-12 22:14:16', '2015-05-12 10:59:10', 0);
INSERT INTO `user` VALUES (722, 'Huang Shihan', 'VYmZfsRmeb', 'hushi@gmail.com', 'Huang Shihan', '718-132-3204', 'user', '2023-06-05 14:07:22', '2021-02-13 13:55:02', 0);
INSERT INTO `user` VALUES (723, 'Steve Harris', 'Fuo4ucEgeB', 'steveh4@icloud.com', 'Steve Harris', '838-402-3162', 'user', '2007-07-22 01:34:05', '2003-11-15 19:45:25', 1);
INSERT INTO `user` VALUES (724, 'Ethel Johnson', 'q1fAt9rlzJ', 'johnse1983@outlook.com', 'Ethel Johnson', '140-2707-7662', 'user', '2018-07-10 22:57:28', '2020-03-02 10:45:38', 0);
INSERT INTO `user` VALUES (725, 'Elaine Clark', '12NTGIIUJu', 'elaclark@icloud.com', 'Elaine Clark', '80-7321-8518', 'user', '2022-08-13 11:07:52', '2009-08-04 23:12:44', 1);
INSERT INTO `user` VALUES (726, 'Yin Zitao', 'DLdZ8EOL2c', 'zitaoyin307@icloud.com', '尹子韬', '(1865) 12 2226', 'user', '2006-10-04 18:59:24', '2016-01-01 19:10:53', 0);
INSERT INTO `user` VALUES (727, 'Dai Anqi', 'KBZHs1HoWe', 'anqida1102@outlook.com', 'Dai Anqi', '156-7219-7022', 'user', '2007-04-10 19:52:39', '2009-04-21 17:08:25', 1);
INSERT INTO `user` VALUES (728, 'Hao Rui', 'oVVMpYACwg', 'hrui10@gmail.com', '郝睿', '838-495-7185', 'user', '2008-10-29 03:39:19', '2009-10-01 18:06:40', 1);
INSERT INTO `user` VALUES (729, 'Frank Silva', 'SphLkO3ekv', 'silvafrank@outlook.com', 'Frank Silva', '330-785-3805', 'user', '2002-11-24 16:54:10', '2001-08-14 17:41:37', 1);
INSERT INTO `user` VALUES (730, 'Lei Zhiyuan', 'iaAzaLab6M', 'zhiyuan313@yahoo.com', '雷致远', '133-3292-3157', 'user', '2008-12-19 14:31:13', '2014-03-28 03:05:44', 0);
INSERT INTO `user` VALUES (731, 'Qin Lu', '2i33E2JkYP', 'lqin@hotmail.com', 'Qin Lu', '760-9593-5147', 'user', '2022-02-22 22:18:55', '2010-04-15 10:02:30', 0);
INSERT INTO `user` VALUES (732, 'Han Yunxi', 'G51JP1N98E', 'yhan18@outlook.com', '韩云熙', '7095 359338', 'user', '2011-07-11 22:21:59', '2002-05-02 20:51:01', 1);
INSERT INTO `user` VALUES (733, 'Loui Ka Keung', 'Bw4oyZzehy', 'kakeungl1127@mail.com', 'Loui Ka Keung', '(161) 955 9167', 'user', '2008-11-01 12:05:33', '2022-10-10 06:57:25', 1);
INSERT INTO `user` VALUES (734, 'Antonio Hall', '2yaY7RfmAd', 'ahall10@mail.com', 'Antonio Hall', '5228 568432', 'user', '2004-08-19 08:16:57', '2024-03-19 10:48:12', 1);
INSERT INTO `user` VALUES (735, 'Arthur Bennett', 'JxcZglcnRQ', 'bennetta@outlook.com', 'Arthur Bennett', '5617 283956', 'user', '2018-09-16 00:48:39', '2002-02-03 13:45:17', 1);
INSERT INTO `user` VALUES (736, 'Hui Ka Keung', 'MEAUHJNSdW', 'kakeung601@yahoo.com', 'Hui Ka Keung', '5273 658732', 'user', '2012-07-16 07:00:04', '2001-06-29 09:37:54', 0);
INSERT INTO `user` VALUES (737, 'Tang Jialun', 'F0eSWQhg1p', 'tanjialun@icloud.com', 'Tang Jialun', '838-926-2662', 'user', '2018-07-21 08:51:55', '2024-04-18 00:36:18', 0);
INSERT INTO `user` VALUES (738, 'Xu Yuning', 'xlwntWXQ3s', 'xuy@gmail.com', 'Xu Yuning', '11-517-1539', 'user', '2002-08-04 17:54:11', '2004-06-18 16:30:10', 1);
INSERT INTO `user` VALUES (739, 'Song Lan', 'CcQ0s6kUjX', 'slan2@outlook.com', 'Song Lan', '90-4281-3120', 'user', '2000-07-25 04:06:06', '2023-08-22 03:45:19', 1);
INSERT INTO `user` VALUES (740, 'April Carter', 'aHBTgsnfvy', 'cartapr@mail.com', 'April Carter', '66-335-0479', 'user', '2001-12-10 00:31:37', '2015-07-23 04:09:15', 1);
INSERT INTO `user` VALUES (741, 'So Ming', 'luZj1WGkUY', 'som@icloud.com', 'So Ming', '20-4622-8126', 'user', '2003-10-05 06:48:53', '2013-12-02 15:13:05', 0);
INSERT INTO `user` VALUES (742, 'Earl Gonzalez', 'zL9PCJZKVT', 'gonzalez3@outlook.com', 'Earl Gonzalez', '3-2929-0860', 'user', '2020-12-04 18:55:49', '2014-01-08 13:52:04', 0);
INSERT INTO `user` VALUES (743, 'Maria Hawkins', 'tQN3EYrotN', 'hawkimar528@hotmail.com', 'Maria Hawkins', '175-5882-5787', 'user', '2014-01-13 04:32:38', '2015-09-10 14:06:05', 1);
INSERT INTO `user` VALUES (744, 'Ti Lai Yan', 't6zTYcONsZ', 'lyti@gmail.com', 'Ti Lai Yan', '330-380-0379', 'user', '2017-06-08 23:36:02', '2004-12-27 23:35:04', 1);
INSERT INTO `user` VALUES (745, 'Jose Stewart', 'Z2jYeHOwB9', 'stewartjos427@icloud.com', 'Jose Stewart', '312-486-0149', 'user', '2004-12-25 07:38:05', '2017-07-10 19:39:16', 1);
INSERT INTO `user` VALUES (746, 'Eva Adams', 'NRk6ByBmap', 'adamse@icloud.com', 'Eva Adams', '7683 725070', 'user', '2007-08-28 01:04:15', '2013-10-02 03:52:43', 0);
INSERT INTO `user` VALUES (747, 'Tan Ziyi', 'n3Oydc1id3', 'ziyi1991@gmail.com', '谭子异', '(1223) 82 1366', 'user', '2004-05-28 13:09:35', '2007-04-10 13:01:26', 1);
INSERT INTO `user` VALUES (748, 'David Rivera', 'F2EcRbGuIp', 'rd112@gmail.com', 'David Rivera', '7762 933052', 'user', '2007-11-22 02:08:53', '2007-03-11 16:33:08', 0);
INSERT INTO `user` VALUES (749, 'Kong Jiehong', 'v3C5Si2V7Q', 'jiehong425@outlook.com', 'Kong Jiehong', '5330 837864', 'user', '2021-05-11 22:27:25', '2013-08-29 05:05:53', 0);
INSERT INTO `user` VALUES (750, 'Yeow Wai Yee', 'VTUu6oi8pL', 'yeow90@outlook.com', 'Yeow Wai Yee', '312-433-0384', 'user', '2024-10-14 03:02:53', '2014-05-22 08:03:28', 0);
INSERT INTO `user` VALUES (751, 'Su Zhennan', 'M6cVWxuTA0', 'zhennansu1@hotmail.com', 'Su Zhennan', '213-013-6871', 'user', '2012-06-07 21:07:58', '2012-12-30 13:25:55', 0);
INSERT INTO `user` VALUES (752, 'Deng Jiehong', 'L07IIxnIc0', 'deng80@mail.com', 'Deng Jiehong', '28-8864-2104', 'user', '2013-11-04 04:57:30', '2020-08-20 10:59:21', 0);
INSERT INTO `user` VALUES (753, 'Hao Zhiyuan', 'o8aDSMeXwr', 'zh9@gmail.com', '郝致远', '718-515-5370', 'user', '2009-03-18 10:45:43', '2016-01-13 16:42:57', 0);
INSERT INTO `user` VALUES (754, 'Manuel Butler', '15IZ0oDtcq', 'bmanuel9@mail.com', 'Manuel Butler', '80-7759-3347', 'user', '2003-10-01 03:18:58', '2021-07-05 15:06:07', 1);
INSERT INTO `user` VALUES (755, 'Helen Taylor', '1Cuc8JgGu4', 'taylohelen1@gmail.com', 'Helen Taylor', '80-5572-3351', 'user', '2002-07-28 18:50:02', '2010-06-23 06:02:45', 0);
INSERT INTO `user` VALUES (756, 'Du Anqi', 'vVZWEGnpKb', 'anqidu@hotmail.com', 'Du Anqi', '718-152-0625', 'user', '2004-04-03 18:31:38', '2016-08-30 13:42:03', 0);
INSERT INTO `user` VALUES (757, 'Yu Zhennan', '5Z2Sddh0eN', 'yuzhennan@mail.com', '于震南', '90-8361-8672', 'user', '2005-09-06 01:15:47', '2013-03-05 08:54:43', 0);
INSERT INTO `user` VALUES (758, 'Diane Clark', 'xAfEnrnWuy', 'cdiane1948@gmail.com', 'Diane Clark', '52-679-5467', 'user', '2011-03-21 03:31:30', '2006-10-21 23:50:46', 1);
INSERT INTO `user` VALUES (759, 'Ma Xiuying', 'jTW7ipsxuJ', 'maxiuyi@outlook.com', 'Ma Xiuying', '760-1626-8627', 'user', '2018-01-09 01:32:37', '2018-09-29 01:50:43', 1);
INSERT INTO `user` VALUES (760, 'Joel Nguyen', 'R3hqhIOSgC', 'joelnguyen@gmail.com', 'Joel Nguyen', '90-1958-3443', 'user', '2009-10-17 23:18:02', '2009-01-19 09:37:57', 1);
INSERT INTO `user` VALUES (761, 'April Kennedy', 'RnxFr87bWh', 'aprilke8@outlook.com', 'April Kennedy', '(121) 546 5039', 'user', '2002-01-30 05:37:59', '2024-06-11 01:00:33', 0);
INSERT INTO `user` VALUES (762, 'So Lik Sun', 'Halhu6HIAn', 'sliksun601@icloud.com', 'So Lik Sun', '183-5712-9332', 'user', '2010-05-09 17:56:38', '2020-12-24 07:49:03', 1);
INSERT INTO `user` VALUES (763, 'Fong Siu Wai', 'bkxtIXyICG', 'siuwai5@mail.com', 'Fong Siu Wai', '312-480-8418', 'user', '2019-08-04 15:29:04', '2020-06-22 11:27:37', 1);
INSERT INTO `user` VALUES (764, 'Dai Xiuying', 'jroEtSMhdl', 'dai65@gmail.com', 'Dai Xiuying', '838-262-7077', 'user', '2001-06-02 01:30:13', '2020-12-31 06:19:24', 0);
INSERT INTO `user` VALUES (765, 'Ren Zitao', 'IRGuDu4Fil', 'renzitao@mail.com', '任子韬', '70-1554-8420', 'user', '2021-05-03 20:01:07', '2020-06-28 18:34:12', 0);
INSERT INTO `user` VALUES (766, 'Hsuan Chi Ming', 'G331bP6lM0', 'chiming2@icloud.com', 'Hsuan Chi Ming', '769-090-0960', 'user', '2021-07-01 15:48:43', '2023-05-27 15:55:31', 1);
INSERT INTO `user` VALUES (767, 'Lu Xiaoming', 'dUofAFHGZ5', 'xiaomlu2@icloud.com', '吕晓明', '5313 284512', 'user', '2003-06-23 15:17:29', '2019-10-25 15:34:08', 0);
INSERT INTO `user` VALUES (768, 'Lai Wing Kuen', 'Dg1h68aeJ2', 'lai10@mail.com', 'Lai Wing Kuen', '66-520-5350', 'user', '2017-08-08 01:45:38', '2005-02-20 20:23:37', 0);
INSERT INTO `user` VALUES (769, 'Mok On Kay', 'vJiSmtOFZx', 'mokok@gmail.com', 'Mok On Kay', '330-696-7831', 'user', '2006-12-24 00:45:24', '2024-12-12 02:09:03', 1);
INSERT INTO `user` VALUES (770, 'Wu Jiehong', 'fny1rEQEKF', 'wuji@icloud.com', 'Wu Jiehong', '70-4116-1678', 'user', '2000-03-04 05:19:20', '2024-12-21 15:07:03', 1);
INSERT INTO `user` VALUES (771, 'Hung Tsz Hin', 'Jbe5t1mqYE', 'hungtszhin@mail.com', 'Hung Tsz Hin', '312-427-5271', 'user', '2002-07-27 01:33:07', '2014-07-07 11:56:03', 1);
INSERT INTO `user` VALUES (772, 'Robin Russell', '50NNdXIzRt', 'russellr@gmail.com', 'Robin Russell', '52-310-4017', 'user', '2010-07-08 20:25:48', '2020-03-02 22:29:40', 0);
INSERT INTO `user` VALUES (773, 'Yin Ho Yin', 'y53H0mv132', 'hoyiyi1955@outlook.com', 'Yin Ho Yin', '(20) 4515 3822', 'user', '2017-04-04 17:48:16', '2011-03-08 18:42:01', 1);
INSERT INTO `user` VALUES (774, 'Cui Zhiyuan', 'yVW1tJHmYg', 'zhiyuanc83@outlook.com', 'Cui Zhiyuan', '70-4460-7909', 'user', '2008-09-28 05:16:53', '2000-08-23 12:12:26', 0);
INSERT INTO `user` VALUES (775, 'Xiong Xiaoming', 'NCz12WCF0I', 'xionxiaoming1031@hotmail.com', '熊晓明', '186-2799-0494', 'user', '2017-03-31 23:08:37', '2020-10-16 22:00:30', 1);
INSERT INTO `user` VALUES (776, 'Mak Chieh Lun', 'MDa7bpJBHr', 'clmak@gmail.com', 'Mak Chieh Lun', '312-022-3455', 'user', '2005-10-31 01:43:53', '2003-12-26 17:01:51', 0);
INSERT INTO `user` VALUES (777, 'Kathryn Mitchell', 'Qk3g4oifjh', 'mitk@gmail.com', 'Kathryn Mitchell', '133-8375-4863', 'user', '2010-02-19 17:49:06', '2022-08-21 12:25:08', 0);
INSERT INTO `user` VALUES (778, 'Stephanie Hughes', 'gHFzJyaMbp', 'sh9@icloud.com', 'Stephanie Hughes', '3-7321-5587', 'user', '2006-08-19 17:34:30', '2009-01-27 05:18:04', 1);
INSERT INTO `user` VALUES (779, 'Zeng Lan', 'S0cparserc', 'zengl@outlook.com', 'Zeng Lan', '213-084-5354', 'user', '2003-06-07 21:24:45', '2016-10-05 14:54:37', 0);
INSERT INTO `user` VALUES (780, 'Tina Smith', 'zGI5kIuSq2', 'tinasmith3@gmail.com', 'Tina Smith', '131-0985-2686', 'user', '2000-10-30 20:23:18', '2019-08-24 11:39:05', 1);
INSERT INTO `user` VALUES (781, 'Ti Wai San', 'rOys6QJya0', 'twaisan@outlook.com', 'Ti Wai San', '20-0123-1661', 'user', '2010-11-01 12:38:09', '2016-05-27 01:56:26', 1);
INSERT INTO `user` VALUES (782, 'Wang Rui', 'aVhdk6cq5a', 'rwang@icloud.com', '汪睿', '7185 550265', 'user', '2019-07-14 10:08:27', '2013-07-26 18:51:25', 0);
INSERT INTO `user` VALUES (783, 'Daniel Edwards', 'LFMqEEqnET', 'danieledwards@gmail.com', 'Daniel Edwards', '718-331-6652', 'user', '2012-11-26 08:58:17', '2021-09-24 20:58:24', 1);
INSERT INTO `user` VALUES (784, 'Heung Chi Yuen', 'hQ2MdnhxRm', 'chiyuenheung4@gmail.com', 'Heung Chi Yuen', '7377 866523', 'user', '2000-05-09 11:36:10', '2003-08-31 22:09:42', 1);
INSERT INTO `user` VALUES (785, 'Bobby Hall', 'diJNzNSrBU', 'hallbob47@mail.com', 'Bobby Hall', '(1223) 79 5512', 'user', '2010-12-17 21:53:53', '2017-10-08 10:22:02', 1);
INSERT INTO `user` VALUES (786, 'Lam Ka Fai', '8mXpCwsYDN', 'lamkafai@outlook.com', 'Lam Ka Fai', '3-2418-2932', 'user', '2024-06-22 06:23:53', '2023-10-06 09:59:22', 1);
INSERT INTO `user` VALUES (787, 'Shawn Stone', 'RRQactiK9H', 'sshawn@gmail.com', 'Shawn Stone', '(1865) 88 0458', 'user', '2014-05-11 04:13:54', '2010-07-30 05:06:46', 1);
INSERT INTO `user` VALUES (788, 'Yan Xiuying', 'fitMKNH106', 'xiuyyan8@gmail.com', 'Yan Xiuying', '(1865) 53 8712', 'user', '2003-01-22 09:55:36', '2015-02-14 23:18:43', 0);
INSERT INTO `user` VALUES (789, 'Peggy Allen', 'djN5ZgIAmQ', 'pa220@gmail.com', 'Peggy Allen', '159-4824-4441', 'user', '2024-02-24 17:11:54', '2019-12-05 00:13:55', 1);
INSERT INTO `user` VALUES (790, 'Yue Tin Lok', 'pa0g081PAl', 'tinlokyue@mail.com', 'Yue Tin Lok', '145-4930-9498', 'user', '2012-12-12 03:24:51', '2023-11-19 05:54:49', 1);
INSERT INTO `user` VALUES (791, 'Choi Yun Fat', 'nlHl6ASwXG', 'choi69@hotmail.com', 'Choi Yun Fat', '312-030-4511', 'user', '2003-12-18 02:58:02', '2000-07-24 00:30:31', 1);
INSERT INTO `user` VALUES (792, 'Nicole Parker', 'qkbdDMAv0j', 'panicole@gmail.com', 'Nicole Parker', '151-7238-0540', 'user', '2021-05-21 17:14:24', '2000-05-17 19:16:12', 0);
INSERT INTO `user` VALUES (793, 'Sean Kim', 'k3NRfEyino', 'sean12@icloud.com', 'Sean Kim', '7493 394617', 'user', '2022-10-15 22:26:46', '2004-12-15 06:51:25', 1);
INSERT INTO `user` VALUES (794, 'Wong Kwok Ming', '5T3R6zEJfk', 'wkm7@hotmail.com', 'Wong Kwok Ming', '131-0474-0443', 'user', '2008-09-06 15:31:26', '2020-06-11 20:29:52', 0);
INSERT INTO `user` VALUES (795, 'Tong Ming Sze', '61AxdwwQ2v', 'tomin@icloud.com', 'Tong Ming Sze', '80-2859-3498', 'user', '2017-11-25 09:02:44', '2018-04-06 13:04:09', 1);
INSERT INTO `user` VALUES (796, 'Jiang Zhiyuan', 'qeGTT0bkYy', 'jiangzhi@gmail.com', 'Jiang Zhiyuan', '(1223) 94 6720', 'user', '2006-06-17 15:27:40', '2012-01-06 03:31:29', 0);
INSERT INTO `user` VALUES (797, 'Cui Shihan', 'BoAxoZXkdq', 'cuishihan4@icloud.com', '崔詩涵', '80-8228-6281', 'user', '2018-11-29 04:11:15', '2011-03-29 15:26:56', 1);
INSERT INTO `user` VALUES (798, 'Lin Xiaoming', 'WqUdeDck0z', 'xiaominglin903@gmail.com', 'Lin Xiaoming', '769-832-9414', 'user', '2004-08-14 00:23:49', '2013-09-17 08:32:19', 1);
INSERT INTO `user` VALUES (799, 'Janet Soto', 'K4ZV0KYicN', 'janets@gmail.com', 'Janet Soto', '70-9273-4850', 'user', '2005-07-23 06:10:00', '2011-01-15 04:01:22', 0);
INSERT INTO `user` VALUES (800, 'Liao Kwok Kuen', 'StINiJm4PJ', 'kwokkuenliao@hotmail.com', 'Liao Kwok Kuen', '838-505-1092', 'user', '2003-07-24 06:39:41', '2021-04-28 01:23:17', 0);
INSERT INTO `user` VALUES (801, 'Hao Zhennan', 'KUuJFymRcC', 'haozhe@outlook.com', 'Hao Zhennan', '212-114-6362', 'user', '2017-09-07 04:49:24', '2013-07-26 05:04:10', 1);
INSERT INTO `user` VALUES (802, 'Tiffany Meyer', 'A4W41FPYxR', 'tiffm65@icloud.com', 'Tiffany Meyer', '70-6024-1628', 'user', '2008-06-05 04:35:33', '2001-08-20 13:39:37', 0);
INSERT INTO `user` VALUES (803, 'Yeung Tak Wah', 'cZSreV1rD3', 'takwahyeung@icloud.com', 'Yeung Tak Wah', '10-7640-4772', 'user', '2006-11-12 14:13:46', '2018-02-11 02:42:59', 1);
INSERT INTO `user` VALUES (804, 'Joe Nguyen', 'EebLPsO7pb', 'ngj@yahoo.com', 'Joe Nguyen', '838-793-5360', 'user', '2011-11-18 16:45:20', '2002-03-05 05:17:03', 1);
INSERT INTO `user` VALUES (805, 'Pamela Torres', 'pMYNsN8E1P', 'tpamela@icloud.com', 'Pamela Torres', '212-527-1356', 'user', '2013-09-22 14:50:32', '2021-11-18 18:37:30', 0);
INSERT INTO `user` VALUES (806, 'Larry Ward', 'nOnn6nOz1b', 'wardlarry@icloud.com', 'Larry Ward', '718-659-2812', 'user', '2001-02-11 12:34:59', '2003-01-30 19:20:17', 1);
INSERT INTO `user` VALUES (807, 'Yuen Ming Sze', 'V4nBrE62Jk', 'mingsze07@yahoo.com', 'Yuen Ming Sze', '193-9600-2181', 'user', '2000-09-22 17:59:55', '2021-11-23 01:33:18', 1);
INSERT INTO `user` VALUES (808, 'Cheng Ka Fai', '8tsXtzKSfN', 'chkafai@gmail.com', 'Cheng Ka Fai', '614-082-5144', 'user', '2022-04-04 06:21:28', '2019-07-31 05:45:07', 1);
INSERT INTO `user` VALUES (809, 'Ku Ting Fung', 'nqQ4zhhgil', 'tfku@yahoo.com', 'Ku Ting Fung', '(116) 374 6760', 'user', '2019-09-18 06:07:59', '2023-03-02 20:00:06', 0);
INSERT INTO `user` VALUES (810, 'Carmen Bennett', 'LWuy1AWpFg', 'carmen7@mail.com', 'Carmen Bennett', '212-167-2990', 'user', '2000-11-18 12:37:34', '2024-06-11 18:35:45', 1);
INSERT INTO `user` VALUES (811, 'Theresa Ortiz', 'rmYvV7UkNK', 'therortiz88@icloud.com', 'Theresa Ortiz', '137-3355-8997', 'user', '2010-01-17 18:14:21', '2022-02-03 18:39:42', 0);
INSERT INTO `user` VALUES (812, 'Ku Lik Sun', 'LaGjKAEm5i', 'ku2017@yahoo.com', 'Ku Lik Sun', '330-359-7345', 'user', '2013-03-14 11:13:52', '2024-09-18 01:02:24', 0);
INSERT INTO `user` VALUES (813, 'Lok On Kay', 'seUMCCiLwS', 'look@outlook.com', 'Lok On Kay', '183-9851-4919', 'user', '2004-06-03 08:37:01', '2012-09-30 20:20:16', 1);
INSERT INTO `user` VALUES (814, 'Wong Wing Fat', 'yMQ8dfE9Se', 'wfw@yahoo.com', 'Wong Wing Fat', '(151) 685 1386', 'user', '2009-09-09 23:02:58', '2005-06-09 18:46:23', 1);
INSERT INTO `user` VALUES (815, 'Pak Kwok Ming', 'iWwo7q7wvk', 'pkm@icloud.com', 'Pak Kwok Ming', '28-502-5823', 'user', '2008-10-24 18:23:16', '2007-12-28 18:37:27', 1);
INSERT INTO `user` VALUES (816, 'Bernard Olson', 'UPh3Tyz9P3', 'bernard1012@gmail.com', 'Bernard Olson', '755-4951-2146', 'user', '2015-10-29 05:11:13', '2006-07-16 19:01:44', 1);
INSERT INTO `user` VALUES (817, 'Yam Ho Yin', 'cqTYJNSw6P', 'hoyin6@outlook.com', 'Yam Ho Yin', '80-4522-8307', 'user', '2021-03-13 06:00:05', '2014-11-12 10:38:28', 0);
INSERT INTO `user` VALUES (818, 'Valerie Reyes', 'H7KO1itJ1A', 'valre8@yahoo.com', 'Valerie Reyes', '7096 626206', 'user', '2023-03-28 21:08:11', '2006-09-25 01:13:17', 1);
INSERT INTO `user` VALUES (819, 'Carmen James', 'WAjkPSho0M', 'carmen15@mail.com', 'Carmen James', '(116) 158 7807', 'user', '2022-04-29 08:16:09', '2003-08-18 14:55:37', 0);
INSERT INTO `user` VALUES (820, 'Mo Ziyi', '2dvkdrRFlu', 'ziyimo9@icloud.com', 'Mo Ziyi', '7512 428846', 'user', '2016-02-25 15:15:02', '2000-06-20 03:51:41', 0);
INSERT INTO `user` VALUES (821, 'Au Ka Ling', 'Vg2xvwP4pR', 'kalingau507@gmail.com', 'Au Ka Ling', '(116) 643 0112', 'user', '2003-06-13 03:22:14', '2009-11-12 14:08:02', 1);
INSERT INTO `user` VALUES (822, 'Mo Kwok Wing', 'iYPVply7gl', 'mokw64@icloud.com', 'Mo Kwok Wing', '718-822-6384', 'user', '2002-11-29 23:04:17', '2009-04-12 12:50:33', 0);
INSERT INTO `user` VALUES (823, 'Tsang Wing Fat', 'Zg6B0uqc9o', 'tsawingfat2@icloud.com', 'Tsang Wing Fat', '312-082-4175', 'user', '2003-05-02 23:31:47', '2017-12-13 03:25:25', 1);
INSERT INTO `user` VALUES (824, 'Shirley Graham', 'k1xTwm2puA', 'shirley6@icloud.com', 'Shirley Graham', '7995 483098', 'user', '2007-03-18 06:32:44', '2020-09-06 02:19:54', 0);
INSERT INTO `user` VALUES (825, 'Marilyn Lewis', '861aPLE43X', 'marilynlew@yahoo.com', 'Marilyn Lewis', '52-010-1613', 'user', '2009-01-02 22:47:00', '2024-05-10 13:29:34', 1);
INSERT INTO `user` VALUES (826, 'Chin Wing Fat', '5OIh9ya3Q0', 'wingfat10@gmail.com', 'Chin Wing Fat', '158-8166-7187', 'user', '2020-04-06 23:11:33', '2024-08-12 13:11:31', 1);
INSERT INTO `user` VALUES (827, 'Meng Shihan', 'ReewQXvnso', 'ms920@outlook.com', 'Meng Shihan', '(161) 004 7865', 'user', '2000-06-09 11:11:15', '2009-05-09 02:08:59', 0);
INSERT INTO `user` VALUES (828, 'Lin Jiehong', 'nsCc7ypcP6', 'lijie@mail.com', '林杰宏', '175-6377-8596', 'user', '2014-04-01 10:14:17', '2020-10-10 20:59:38', 1);
INSERT INTO `user` VALUES (829, 'Mo Yunxi', 'u6rrc1UCXg', 'yunxmo7@mail.com', '莫云熙', '21-807-8656', 'user', '2024-10-31 15:48:54', '2015-10-10 15:46:35', 1);
INSERT INTO `user` VALUES (830, 'Jeff Woods', 'yxUftnLgHS', 'woodsjeff@outlook.com', 'Jeff Woods', '330-724-1418', 'user', '2019-05-04 06:45:12', '2017-06-02 07:25:26', 1);
INSERT INTO `user` VALUES (831, 'Jin Anqi', 'RMeIDx0kkN', 'jinanqi09@yahoo.com', 'Jin Anqi', '5356 529776', 'user', '2023-10-18 07:47:19', '2009-07-29 13:07:37', 1);
INSERT INTO `user` VALUES (832, 'Yau Ting Fung', '3wFLhG0fmK', 'tiy@yahoo.com', 'Yau Ting Fung', '74-030-6303', 'user', '2001-05-09 23:56:24', '2000-05-09 10:59:28', 0);
INSERT INTO `user` VALUES (833, 'Yam Hiu Tung', 'DCQ1SirO37', 'htyam@gmail.com', 'Yam Hiu Tung', '21-196-1386', 'user', '2019-03-02 22:32:59', '2013-12-30 01:31:54', 1);
INSERT INTO `user` VALUES (834, 'Yip Sze Yu', 'TK40zyQ7Wi', 'szeyuyip@hotmail.com', 'Yip Sze Yu', '90-6998-9785', 'user', '2013-05-09 17:55:49', '2022-12-08 05:50:59', 1);
INSERT INTO `user` VALUES (835, 'Kong Jialun', 'rB79i81p9c', 'jk5@outlook.com', 'Kong Jialun', '176-4441-0416', 'user', '2017-12-29 10:00:35', '2001-07-25 01:20:49', 1);
INSERT INTO `user` VALUES (836, 'Herbert Wallace', 'oLVe5WtJOg', 'herbertwa@yahoo.com', 'Herbert Wallace', '90-9680-4242', 'user', '2005-07-10 02:17:42', '2012-12-09 12:17:08', 0);
INSERT INTO `user` VALUES (837, 'Tang Chi Ming', 'whPFHy0TSn', 'tangchiming@outlook.com', 'Tang Chi Ming', '(121) 402 4631', 'user', '2014-10-28 07:22:55', '2002-01-21 18:07:27', 0);
INSERT INTO `user` VALUES (838, 'Eva Morales', 'DHCoV2ysKN', 'morales68@outlook.com', 'Eva Morales', '90-6317-6645', 'user', '2006-02-25 11:05:38', '2013-07-15 15:49:40', 1);
INSERT INTO `user` VALUES (839, 'Joyce Turner', '7wJfdah17s', 'joyceturner96@gmail.com', 'Joyce Turner', '164-2079-9205', 'user', '2007-07-30 06:54:22', '2017-06-07 01:25:57', 0);
INSERT INTO `user` VALUES (840, 'Thelma Hayes', '0Jb1QMFZZ0', 'hayes1976@hotmail.com', 'Thelma Hayes', '7286 122223', 'user', '2012-03-11 04:58:07', '2020-02-23 14:32:25', 0);
INSERT INTO `user` VALUES (841, 'Alfred Fisher', 'X8KBlryEH8', 'alfred203@icloud.com', 'Alfred Fisher', '20-689-1386', 'user', '2018-11-18 18:01:49', '2005-12-26 20:25:13', 1);
INSERT INTO `user` VALUES (842, 'Pak Kar Yan', 'iqVTZ4lfHs', 'karyanpa2017@icloud.com', 'Pak Kar Yan', '180-6469-5660', 'user', '2021-10-29 07:14:16', '2006-05-20 04:37:00', 1);
INSERT INTO `user` VALUES (843, 'Zhong Lu', 'nMNeyyJMvq', 'zhonglu57@mail.com', '钟璐', '213-625-4353', 'user', '2022-06-27 17:53:13', '2008-06-01 11:46:00', 1);
INSERT INTO `user` VALUES (844, 'Thelma Gutierrez', 'ZkfOVIhfFY', 'thelgu57@gmail.com', 'Thelma Gutierrez', '162-2862-8530', 'user', '2007-04-09 08:24:16', '2007-08-26 01:52:33', 1);
INSERT INTO `user` VALUES (845, 'Xie Jiehong', 'u8kvZibhQG', 'xiej319@mail.com', '谢杰宏', '170-9938-4207', 'user', '2003-11-18 10:21:10', '2003-02-24 16:47:56', 0);
INSERT INTO `user` VALUES (846, 'Donna Diaz', '3WywXJqeJm', 'donnad2@outlook.com', 'Donna Diaz', '7397 045055', 'user', '2011-12-13 01:25:33', '2009-05-28 01:45:52', 0);
INSERT INTO `user` VALUES (847, 'Marvin Spencer', 'fTZiSzu5mU', 'spencermarvi55@outlook.com', 'Marvin Spencer', '21-372-4032', 'user', '2011-07-18 07:28:05', '2020-08-30 22:16:15', 1);
INSERT INTO `user` VALUES (848, 'Zhao Lan', 'vfHEy80Vh0', 'lanzha1119@gmail.com', '赵岚', '(116) 823 0431', 'user', '2003-08-26 09:30:18', '2015-03-31 20:50:16', 0);
INSERT INTO `user` VALUES (849, 'Feng Yuning', '1q4TW1EB8Y', 'yunifeng101@gmail.com', '冯宇宁', '(1223) 09 4787', 'user', '2001-07-15 05:24:23', '2023-06-30 17:13:47', 1);
INSERT INTO `user` VALUES (850, 'Pang Kwok Kuen', 'LnC3AvuUBi', 'kkpa@mail.com', 'Pang Kwok Kuen', '614-839-0877', 'user', '2022-10-22 08:21:02', '2020-10-09 10:54:46', 0);
INSERT INTO `user` VALUES (851, 'Cui Zitao', 'exLTFKogtq', 'cuizi@outlook.com', 'Cui Zitao', '7549 723399', 'user', '2016-06-18 23:26:05', '2002-08-06 23:29:01', 1);
INSERT INTO `user` VALUES (852, 'John Nelson', 'vCrwmoea8Y', 'njohn82@icloud.com', 'John Nelson', '(121) 303 2344', 'user', '2018-04-28 06:24:38', '2022-06-18 14:30:56', 1);
INSERT INTO `user` VALUES (853, 'Xu Lan', 'Bge5SCxQQc', 'xu315@hotmail.com', 'Xu Lan', '(121) 843 8044', 'user', '2010-01-12 02:44:13', '2007-12-31 05:56:32', 1);
INSERT INTO `user` VALUES (854, 'Gu Anqi', 'fACvcBpKZO', 'anqi66@gmail.com', '顾安琪', '161-3662-0106', 'user', '2000-09-12 02:33:49', '2000-06-04 19:45:59', 1);
INSERT INTO `user` VALUES (855, 'Kimberly Peterson', 'xyCNDZw8Ay', 'pkimb@outlook.com', 'Kimberly Peterson', '(20) 3518 7654', 'user', '2008-09-23 04:02:10', '2009-07-20 22:35:17', 1);
INSERT INTO `user` VALUES (856, 'Zhou Jialun', 'tNaJOx2WgO', 'zjia@outlook.com', '周嘉伦', '5324 624832', 'user', '2002-12-15 04:04:38', '2007-05-03 03:23:45', 0);
INSERT INTO `user` VALUES (857, 'Deborah Hunt', 'fp9qwSFziw', 'huntdeborah@gmail.com', 'Deborah Hunt', '7189 379781', 'user', '2024-02-28 19:05:35', '2009-05-15 12:33:57', 1);
INSERT INTO `user` VALUES (858, 'Laura Lewis', 'aTlGQnvoWN', 'laura110@mail.com', 'Laura Lewis', '90-4356-8132', 'user', '2007-05-03 09:41:35', '2007-12-11 08:44:20', 1);
INSERT INTO `user` VALUES (859, 'David King', 'M1K7OXQsuw', 'david57@mail.com', 'David King', '52-285-5112', 'user', '2005-10-17 21:17:12', '2005-06-25 00:04:43', 0);
INSERT INTO `user` VALUES (860, 'Robert Cox', 'EqHMY35sO5', 'cro@icloud.com', 'Robert Cox', '21-504-6777', 'user', '2020-01-21 11:57:37', '2001-01-22 00:56:46', 1);
INSERT INTO `user` VALUES (861, 'Tong Ching Wan', 'rkZnCqIzoZ', 'tocw@mail.com', 'Tong Ching Wan', '66-227-8353', 'user', '2015-08-18 17:56:02', '2006-03-14 09:05:20', 0);
INSERT INTO `user` VALUES (862, 'Shao Xiaoming', 'Of395PJHDf', 'shaoxiaoming@gmail.com', '邵晓明', '614-560-4870', 'user', '2019-12-01 19:02:31', '2011-01-30 18:32:26', 0);
INSERT INTO `user` VALUES (863, 'Frederick Walker', '6av5cL523S', 'frederick9@icloud.com', 'Frederick Walker', '(1865) 50 6341', 'user', '2022-04-05 22:47:37', '2001-11-20 08:00:49', 0);
INSERT INTO `user` VALUES (864, 'Lam Hiu Tung', 'fXyFtld7Lv', 'lamht@gmail.com', 'Lam Hiu Tung', '838-340-5281', 'user', '2017-09-29 14:42:39', '2001-10-02 11:58:29', 1);
INSERT INTO `user` VALUES (865, 'Ye Yuning', 'KXwXbUkkKp', 'yeyuning@mail.com', '叶宇宁', '90-9043-1196', 'user', '2009-01-05 22:35:39', '2018-08-29 06:32:57', 1);
INSERT INTO `user` VALUES (866, 'Wu Lan', 'nyVGH7GpoW', 'wulan@icloud.com', '武岚', '5811 960438', 'user', '2004-02-16 13:57:16', '2002-07-01 12:46:24', 0);
INSERT INTO `user` VALUES (867, 'Kwan Wing Fat', 'C0XM8AEpL5', 'wingfat930@gmail.com', 'Kwan Wing Fat', '(116) 470 7383', 'user', '2016-03-30 06:18:07', '2008-01-16 18:03:42', 1);
INSERT INTO `user` VALUES (868, 'Tian Yuning', 'iyh0iGWVrQ', 'ytian@gmail.com', 'Tian Yuning', '7348 965473', 'user', '2013-05-22 23:01:22', '2011-12-01 12:37:34', 1);
INSERT INTO `user` VALUES (869, 'Cheung Chi Ming', 'Ps7E7EC08p', 'cheungcm@gmail.com', 'Cheung Chi Ming', '(116) 459 2479', 'user', '2002-11-25 08:01:34', '2020-07-05 01:34:39', 0);
INSERT INTO `user` VALUES (870, 'Cai Jiehong', 'Ig7guiisqb', 'jcai@yahoo.com', '蔡杰宏', '21-3468-0527', 'user', '2012-10-28 05:06:34', '2015-08-06 16:04:02', 1);
INSERT INTO `user` VALUES (871, 'Wong Kwok Wing', 'mto3ricneN', 'wkwokwing@outlook.com', 'Wong Kwok Wing', '7690 458109', 'user', '2009-09-28 04:08:48', '2013-08-28 18:55:31', 0);
INSERT INTO `user` VALUES (872, 'Joyce Jackson', 'iLy7LIeu9s', 'jacksonj1@hotmail.com', 'Joyce Jackson', '7490 195808', 'user', '2020-11-08 09:06:40', '2019-01-15 20:54:42', 0);
INSERT INTO `user` VALUES (873, 'Dai Chiu Wai', 'Uiey84HIkS', 'dacw131@hotmail.com', 'Dai Chiu Wai', '(161) 937 9826', 'user', '2005-01-17 01:44:39', '2023-01-10 11:18:00', 0);
INSERT INTO `user` VALUES (874, 'Xie Shihan', 'upEjJZRj9J', 'shihanxi319@outlook.com', '谢詩涵', '212-359-1342', 'user', '2007-03-08 20:44:32', '2008-08-17 22:58:56', 0);
INSERT INTO `user` VALUES (875, 'Yung Wai Yee', 'tO4eBojmXL', 'yungwaiyee329@gmail.com', 'Yung Wai Yee', '(161) 906 0598', 'user', '2009-09-22 15:40:56', '2008-06-15 21:41:57', 1);
INSERT INTO `user` VALUES (876, 'Brandon Kim', 'vEiKNDe18N', 'kimb1954@outlook.com', 'Brandon Kim', '(121) 894 9102', 'user', '2015-01-04 18:12:18', '2009-02-03 20:56:55', 1);
INSERT INTO `user` VALUES (877, 'Cheung Chung Yin', 'uN57ZVm7lT', 'chungyin6@icloud.com', 'Cheung Chung Yin', '142-8421-2598', 'user', '2012-03-25 07:19:30', '2004-02-09 09:50:32', 1);
INSERT INTO `user` VALUES (878, 'Xiang Yuning', 'szCIsgmhhi', 'yuning503@gmail.com', '向宇宁', '(161) 737 6125', 'user', '2017-04-09 07:37:05', '2023-03-29 16:30:06', 1);
INSERT INTO `user` VALUES (879, 'Yuen Hiu Tung', '81YG8oviZG', 'yuen3@hotmail.com', 'Yuen Hiu Tung', '90-8689-9325', 'user', '2005-12-15 22:54:36', '2016-05-15 18:16:14', 1);
INSERT INTO `user` VALUES (880, 'Chen Yuning', '9nECZQmruu', 'cheny5@outlook.com', 'Chen Yuning', '70-2728-5196', 'user', '2010-03-21 02:15:52', '2003-01-19 06:11:40', 1);
INSERT INTO `user` VALUES (881, 'Jeffrey Ross', 'ow3lgT6d8X', 'jeffrey1111@hotmail.com', 'Jeffrey Ross', '90-8010-8757', 'user', '2023-07-04 17:59:39', '2009-07-21 06:10:07', 0);
INSERT INTO `user` VALUES (882, 'Ethel Baker', 'PMoNhRGtpj', 'ethelbak@yahoo.com', 'Ethel Baker', '90-2499-1555', 'user', '2018-10-25 03:43:12', '2024-11-03 16:27:14', 0);
INSERT INTO `user` VALUES (883, 'Yan Jiehong', 'g4BaZzRmSF', 'yjieho910@mail.com', 'Yan Jiehong', '213-002-1704', 'user', '2014-09-09 22:51:23', '2008-12-03 22:26:03', 0);
INSERT INTO `user` VALUES (884, 'Yip Fu Shing', 'SHadQaxQGW', 'fushingyip9@yahoo.com', 'Yip Fu Shing', '7705 039024', 'user', '2022-08-29 19:31:11', '2000-08-07 06:14:32', 0);
INSERT INTO `user` VALUES (885, 'Ho Hiu Tung', 'ae9dujv04Y', 'hhiutung11@icloud.com', 'Ho Hiu Tung', '312-318-2992', 'user', '2010-07-21 11:25:28', '2023-07-23 13:35:24', 0);
INSERT INTO `user` VALUES (886, 'Au Yu Ling', '7NgeGmHlX7', 'yulingau@outlook.com', 'Au Yu Ling', '5770 226974', 'user', '2016-09-13 11:57:25', '2018-03-17 05:49:50', 0);
INSERT INTO `user` VALUES (887, 'Todd Lee', '3H54O7GONE', 'leetodd78@outlook.com', 'Todd Lee', '3-3830-8211', 'user', '2011-09-19 16:11:40', '2007-09-08 19:31:42', 1);
INSERT INTO `user` VALUES (888, 'Heung Ching Wan', 'NsJ22zXN98', 'chingwanhe@gmail.com', 'Heung Ching Wan', '10-5140-5659', 'user', '2015-11-07 09:19:17', '2024-03-16 08:26:07', 1);
INSERT INTO `user` VALUES (889, 'Manuel Kelley', 'POKh4zu9g6', 'kemanuel@mail.com', 'Manuel Kelley', '755-338-8186', 'user', '2014-08-18 09:21:36', '2001-08-06 17:44:42', 1);
INSERT INTO `user` VALUES (890, 'Alice Brown', 's60jEQCQTH', 'browalice10@outlook.com', 'Alice Brown', '330-419-9361', 'user', '2020-07-20 11:05:51', '2024-06-19 03:07:12', 0);
INSERT INTO `user` VALUES (891, 'Francis Palmer', 'oxVmXQce5s', 'palmerfra2@mail.com', 'Francis Palmer', '718-058-7335', 'user', '2017-01-13 14:50:17', '2011-10-30 12:21:59', 1);
INSERT INTO `user` VALUES (892, 'Dai Kar Yan', 'ssWln21NWT', 'kydai93@icloud.com', 'Dai Kar Yan', '66-976-0317', 'user', '2016-10-26 00:12:35', '2005-07-25 19:39:30', 1);
INSERT INTO `user` VALUES (893, 'Cheng Hiu Tung', 'R6H2cfRvQX', 'chenght10@gmail.com', 'Cheng Hiu Tung', '185-3442-0994', 'user', '2003-10-19 20:20:43', '2011-05-11 17:28:52', 0);
INSERT INTO `user` VALUES (894, 'Cheng Yunxi', 'omxH8ZTbPd', 'yunxic@outlook.com', '程云熙', '7318 597896', 'user', '2011-06-17 05:39:31', '2020-11-13 12:52:08', 0);
INSERT INTO `user` VALUES (895, 'Rita Stone', 'tGSzgWk2p8', 'rstone2@gmail.com', 'Rita Stone', '312-885-7705', 'user', '2015-11-19 02:24:39', '2001-07-07 05:03:40', 1);
INSERT INTO `user` VALUES (896, 'Carmen Morris', 'Q0FSzGPlWC', 'mcar1123@icloud.com', 'Carmen Morris', '(1223) 62 0195', 'user', '2021-11-02 16:07:56', '2017-05-09 14:59:53', 1);
INSERT INTO `user` VALUES (897, 'Jiang Lan', 'Lz6Vamvndi', 'ljia4@outlook.com', '江岚', '74-257-0995', 'user', '2006-01-14 22:39:12', '2000-04-24 14:45:53', 0);
INSERT INTO `user` VALUES (898, 'Joseph Phillips', '83HFNg07Jc', 'phillipsjos@mail.com', 'Joseph Phillips', '7226 040639', 'user', '2014-04-02 23:57:20', '2024-10-31 08:24:29', 0);
INSERT INTO `user` VALUES (899, 'Thelma Mcdonald', 'ny7ACGfYb0', 'tmcdonald@mail.com', 'Thelma Mcdonald', '312-016-0912', 'user', '2020-03-04 21:25:34', '2011-06-27 05:40:46', 1);
INSERT INTO `user` VALUES (900, 'Robin Roberts', 'jbE4brMFCF', 'robertsrobin1947@gmail.com', 'Robin Roberts', '213-730-4801', 'user', '2003-05-26 16:48:07', '2019-02-21 19:47:41', 1);
INSERT INTO `user` VALUES (901, 'Zhang Zhennan', 'mB9E5UYvxG', 'zzhe10@yahoo.com', 'Zhang Zhennan', '614-215-4244', 'user', '2008-08-24 15:33:56', '2002-10-02 15:43:05', 1);
INSERT INTO `user` VALUES (902, 'Feng Anqi', 'hrG4t4XGpx', 'anqf96@outlook.com', '冯安琪', '90-6479-0189', 'user', '2016-09-03 10:33:18', '2013-03-28 06:22:42', 0);
INSERT INTO `user` VALUES (903, 'Cheung Kwok Kuen', 'mUVw82rxzs', 'cheung1122@gmail.com', 'Cheung Kwok Kuen', '11-602-1506', 'user', '2020-11-29 03:01:38', '2008-06-04 05:08:43', 1);
INSERT INTO `user` VALUES (904, 'Edwin Black', '8PYrvRqmaT', 'edwin4@mail.com', 'Edwin Black', '7387 978246', 'user', '2014-07-12 04:01:53', '2000-11-15 16:36:16', 0);
INSERT INTO `user` VALUES (905, 'Lo Yu Ling', '4FYvO6agVy', 'yll@gmail.com', 'Lo Yu Ling', '28-995-3297', 'user', '2004-02-10 09:48:09', '2000-10-05 12:15:51', 1);
INSERT INTO `user` VALUES (906, 'Hsuan Hui Mei', 'jOlsYeCaNV', 'hhm9@yahoo.com', 'Hsuan Hui Mei', '(1865) 68 0548', 'user', '2019-11-19 09:26:06', '2006-08-26 14:54:16', 1);
INSERT INTO `user` VALUES (907, 'Chiang Siu Wai', 'HDqW7pZU6P', 'siuwai8@hotmail.com', 'Chiang Siu Wai', '28-507-9882', 'user', '2006-01-14 08:44:49', '2000-11-18 00:16:20', 0);
INSERT INTO `user` VALUES (908, 'Barbara Perry', 'cR4hvzhS0b', 'perry58@outlook.com', 'Barbara Perry', '90-1658-1943', 'user', '2015-05-23 00:38:56', '2011-03-02 18:24:39', 1);
INSERT INTO `user` VALUES (909, 'Helen Hamilton', '3ZSh3e4pQk', 'hhelen@hotmail.com', 'Helen Hamilton', '80-5943-7438', 'user', '2007-07-26 21:18:46', '2024-07-11 13:09:44', 1);
INSERT INTO `user` VALUES (910, 'Eric Collins', '3RizmP3Urh', 'cole09@icloud.com', 'Eric Collins', '90-9883-4040', 'user', '2023-06-18 03:37:15', '2020-10-16 06:20:55', 0);
INSERT INTO `user` VALUES (911, 'Jia Yunxi', 'BbFCXApj0Z', 'jyun8@hotmail.com', '贾云熙', '838-226-1782', 'user', '2011-03-08 01:55:19', '2023-08-02 08:05:56', 1);
INSERT INTO `user` VALUES (912, 'Lee James', 'Fp1cVdWpDq', 'jal8@gmail.com', 'Lee James', '74-901-4917', 'user', '2023-12-29 03:39:50', '2011-03-29 03:54:00', 1);
INSERT INTO `user` VALUES (913, 'Joseph Olson', '17GfogHVTS', 'josepolson1031@gmail.com', 'Joseph Olson', '10-5046-8925', 'user', '2011-02-28 06:55:01', '2019-02-20 14:49:36', 1);
INSERT INTO `user` VALUES (914, 'Wayne Chen', 'X2qktW1QnW', 'chenwayne14@hotmail.com', 'Wayne Chen', '21-5470-6348', 'user', '2020-11-28 12:19:49', '2002-03-08 19:56:14', 0);
INSERT INTO `user` VALUES (915, 'Yu Anqi', 'uM5217qZtV', 'yua@gmail.com', '余安琪', '80-1764-6472', 'user', '2003-01-19 08:21:47', '2010-09-08 02:26:05', 0);
INSERT INTO `user` VALUES (916, 'Charlotte Rose', 'l81wksamUF', 'rosecharlotte@icloud.com', 'Charlotte Rose', '760-1322-6544', 'user', '2014-08-04 20:08:24', '2001-09-06 22:13:38', 0);
INSERT INTO `user` VALUES (917, 'Tong Sum Wing', '4YEy7YQU94', 'sumwing10@gmail.com', 'Tong Sum Wing', '(161) 022 4400', 'user', '2018-01-10 09:01:43', '2006-12-02 00:40:25', 1);
INSERT INTO `user` VALUES (918, 'Ti Chun Yu', 'mLYf71LEhP', 'tichunyu@mail.com', 'Ti Chun Yu', '80-2180-1891', 'user', '2022-02-23 22:57:42', '2022-07-02 04:20:19', 1);
INSERT INTO `user` VALUES (919, 'Martin James', 'flZYGT2mNl', 'jm929@yahoo.com', 'Martin James', '718-481-0678', 'user', '2024-04-23 08:50:12', '2013-08-14 06:31:46', 0);
INSERT INTO `user` VALUES (920, 'Christina Mills', 'EwJ157zjvt', 'millchristina18@gmail.com', 'Christina Mills', '838-952-0430', 'user', '2013-05-21 17:18:35', '2012-12-21 04:12:56', 1);
INSERT INTO `user` VALUES (921, 'Yung Ka Ming', 'nltyuN5kyq', 'kamiyung1@mail.com', 'Yung Ka Ming', '80-1261-3402', 'user', '2018-01-22 02:40:24', '2023-11-10 23:14:29', 0);
INSERT INTO `user` VALUES (922, 'Yeung Wai San', 'GAz4RNEg88', 'yewaisan5@outlook.com', 'Yeung Wai San', '838-708-7315', 'user', '2008-10-17 06:48:13', '2017-10-02 11:01:19', 0);
INSERT INTO `user` VALUES (923, 'Chow Wing Sze', '4c6JANVFWT', 'wingszech@gmail.com', 'Chow Wing Sze', '90-5243-2870', 'user', '2016-05-12 09:14:18', '2014-10-01 02:25:29', 1);
INSERT INTO `user` VALUES (924, 'Sun Zhiyuan', '4hmbYfTM10', 'zhisun@yahoo.com', 'Sun Zhiyuan', '5628 424654', 'user', '2022-01-31 12:10:30', '2019-10-26 17:28:25', 0);
INSERT INTO `user` VALUES (925, 'Joanne Stevens', 'rIhKA3F3jS', 'js8@gmail.com', 'Joanne Stevens', '70-8896-7613', 'user', '2019-06-05 12:25:54', '2017-12-29 16:32:38', 0);
INSERT INTO `user` VALUES (926, 'Nicholas Holmes', 'fR1gG3PIng', 'nicholmes@icloud.com', 'Nicholas Holmes', '330-901-6752', 'user', '2009-11-25 13:23:27', '2015-09-01 07:09:31', 1);
INSERT INTO `user` VALUES (927, 'Bryan Ross', 'GQsq6lkzU5', 'bryanros@gmail.com', 'Bryan Ross', '(1865) 33 7102', 'user', '2014-09-09 22:30:11', '2002-01-19 05:00:17', 1);
INSERT INTO `user` VALUES (928, 'Fu Xiaoming', 'MNJfYn6N7r', 'xiaofu1116@outlook.com', 'Fu Xiaoming', '5854 187626', 'user', '2002-02-19 10:24:08', '2007-10-25 12:18:34', 1);
INSERT INTO `user` VALUES (929, 'Mario Cole', 'mQgAskupXS', 'colem3@hotmail.com', 'Mario Cole', '21-9992-1787', 'user', '2022-02-27 02:49:10', '2007-06-09 22:30:16', 0);
INSERT INTO `user` VALUES (930, 'Wang Xiuying', 'NKhjWuh9xe', 'xiuying9@gmail.com', 'Wang Xiuying', '5191 547585', 'user', '2014-09-25 23:16:14', '2016-05-07 00:58:18', 1);
INSERT INTO `user` VALUES (931, 'Man On Na', 'Tpr1FzycK8', 'onma1985@gmail.com', 'Man On Na', '11-917-4406', 'user', '2018-04-12 00:32:15', '2012-09-20 03:57:22', 1);
INSERT INTO `user` VALUES (932, 'Martha Castro', 's4hJC0CbFn', 'castro7@hotmail.com', 'Martha Castro', '5725 739159', 'user', '2013-01-09 14:27:12', '2002-01-03 08:28:54', 1);
INSERT INTO `user` VALUES (933, 'Siu Sze Kwan', 'yKhEtFzi9c', 'szekwans@outlook.com', 'Siu Sze Kwan', '20-4822-1794', 'user', '2020-11-30 06:30:21', '2018-09-16 10:56:51', 1);
INSERT INTO `user` VALUES (934, 'Elaine Hill', 'P1Q363kWfU', 'elainehill@gmail.com', 'Elaine Hill', '163-7303-3075', 'user', '2005-01-09 03:59:36', '2002-03-25 17:27:27', 0);
INSERT INTO `user` VALUES (935, 'Qiu Lu', '1YAt5aPQlH', 'qlu6@outlook.com', 'Qiu Lu', '169-0204-0798', 'user', '2006-12-29 00:19:45', '2016-03-28 08:35:56', 0);
INSERT INTO `user` VALUES (936, 'Sheh Wai San', 'IUzwEK4tHf', 'waisansheh730@outlook.com', 'Sheh Wai San', '760-1089-0450', 'user', '2019-05-29 02:13:50', '2020-02-13 07:41:47', 1);
INSERT INTO `user` VALUES (937, 'Peng Lu', 'E54w3CYCCq', 'lupe@outlook.com', '彭璐', '7495 310728', 'user', '2023-06-25 05:52:39', '2020-02-16 09:25:49', 0);
INSERT INTO `user` VALUES (938, 'Kao Fat', 'pPSCT6QUXh', 'fatkao@outlook.com', 'Kao Fat', '(1223) 16 0570', 'user', '2000-07-21 20:04:50', '2019-07-24 10:50:40', 0);
INSERT INTO `user` VALUES (939, 'Kao Wing Sze', 'l84BIRJEP2', 'wingsze90@outlook.com', 'Kao Wing Sze', '(1223) 47 9416', 'user', '2007-02-22 01:35:46', '2004-11-02 08:34:35', 1);
INSERT INTO `user` VALUES (940, 'Xie Lan', 'nSRmin26aG', 'lanxie@yahoo.com', 'Xie Lan', '7910 870398', 'user', '2018-05-22 21:55:22', '2008-04-07 05:15:07', 1);
INSERT INTO `user` VALUES (941, 'Cheryl Allen', 'zCFtFymDUc', 'alleche@hotmail.com', 'Cheryl Allen', '330-390-9400', 'user', '2010-10-30 06:24:39', '2017-12-03 15:55:28', 1);
INSERT INTO `user` VALUES (942, 'Joseph Miller', '7EVrsWt6n7', 'joseph43@gmail.com', 'Joseph Miller', '28-881-4279', 'user', '2021-12-09 16:21:51', '2011-05-26 11:49:17', 1);
INSERT INTO `user` VALUES (943, 'Jack Ramos', '9L37dT5nfU', 'ramosjac@gmail.com', 'Jack Ramos', '312-775-5799', 'user', '2022-03-26 00:26:24', '2001-08-31 23:42:52', 1);
INSERT INTO `user` VALUES (944, 'Shi Xiuying', 'DEyRNsNN6b', 'shixiuying@outlook.com', 'Shi Xiuying', '312-184-7385', 'user', '2006-11-04 17:32:44', '2023-03-31 13:46:49', 0);
INSERT INTO `user` VALUES (945, 'Joyce Martinez', 'qk2GStgnfm', 'joyma@icloud.com', 'Joyce Martinez', '212-141-5738', 'user', '2017-12-13 06:20:35', '2015-02-06 10:06:41', 1);
INSERT INTO `user` VALUES (946, 'Joan Wood', '3ubXwN6h83', 'jowood@gmail.com', 'Joan Wood', '330-443-0891', 'user', '2012-03-10 13:54:10', '2021-02-13 13:37:47', 0);
INSERT INTO `user` VALUES (947, 'Laura Wells', 'WXOnu4vYVC', 'wellsla@mail.com', 'Laura Wells', '70-3632-5051', 'user', '2018-04-06 09:42:21', '2002-01-08 18:53:03', 1);
INSERT INTO `user` VALUES (948, 'Lee Sai Wing', 'dS0D73CfwZ', 'lee57@gmail.com', 'Lee Sai Wing', '7211 983004', 'user', '2022-12-06 17:21:14', '2015-12-02 00:24:23', 1);
INSERT INTO `user` VALUES (949, 'Li Lan', '46IMW3SOVn', 'lanli@hotmail.com', 'Li Lan', '7679 748914', 'user', '2009-05-21 23:56:25', '2023-12-19 07:24:43', 0);
INSERT INTO `user` VALUES (950, 'Meng Xiaoming', 'YIUA4TpcpY', 'mengx@hotmail.com', 'Meng Xiaoming', '66-565-2106', 'user', '2010-10-19 18:45:52', '2014-02-26 09:14:07', 0);
INSERT INTO `user` VALUES (951, 'Zeng Zitao', 'NvpmFNhWZx', 'zengzita@yahoo.com', '曾子韬', '718-062-3868', 'user', '2014-09-28 16:19:27', '2001-05-05 06:58:18', 0);
INSERT INTO `user` VALUES (952, 'Fung Fu Shing', 'Ug62iiC1WD', 'fushing829@mail.com', 'Fung Fu Shing', '213-236-9299', 'user', '2003-08-15 08:09:07', '2007-01-12 03:37:17', 0);
INSERT INTO `user` VALUES (953, 'Marie Peterson', '6zcm5bYzMb', 'mapeterson10@icloud.com', 'Marie Peterson', '212-124-4905', 'user', '2024-12-05 21:05:47', '2004-11-29 01:47:55', 0);
INSERT INTO `user` VALUES (954, 'Danny Adams', 'NinkxsTuQC', 'dannyadams@icloud.com', 'Danny Adams', '11-950-9080', 'user', '2010-09-14 07:45:44', '2015-05-22 07:46:57', 1);
INSERT INTO `user` VALUES (955, 'Ren Lan', 'kYJJNK6Hzi', 'lanren@icloud.com', '任岚', '718-697-2852', 'user', '2011-12-14 15:07:11', '2016-09-28 04:33:54', 1);
INSERT INTO `user` VALUES (956, 'Fan Chieh Lun', 'RqXl5hQmmQ', 'chiehlunfan@gmail.com', 'Fan Chieh Lun', '312-242-0235', 'user', '2001-03-21 12:42:15', '2022-10-02 10:15:52', 1);
INSERT INTO `user` VALUES (957, 'Sara Nichols', 'sBsIUMO1rx', 'saranichols@mail.com', 'Sara Nichols', '7747 762867', 'user', '2023-06-28 01:11:20', '2017-04-18 04:45:27', 0);
INSERT INTO `user` VALUES (958, 'Xiong Jiehong', 'rhO1qsvi3d', 'xiongji10@icloud.com', '熊杰宏', '70-2265-8417', 'user', '2002-02-08 09:13:02', '2003-12-21 12:59:41', 1);
INSERT INTO `user` VALUES (959, 'Cui Yuning', 'RjEaseim72', 'cui04@yahoo.com', '崔宇宁', '769-404-8619', 'user', '2016-12-17 05:04:42', '2003-03-03 12:15:01', 1);
INSERT INTO `user` VALUES (960, 'Wu Ziyi', 'TolZDo5lEh', 'wuzi@icloud.com', 'Wu Ziyi', '312-944-6131', 'user', '2020-04-06 05:07:20', '2005-09-03 03:33:49', 0);
INSERT INTO `user` VALUES (961, 'Zhao Lu', '8xcGT905Vx', 'lu10@mail.com', 'Zhao Lu', '80-7703-1093', 'user', '2022-09-24 23:21:01', '2009-12-17 19:27:37', 0);
INSERT INTO `user` VALUES (962, 'Sheh Ting Fung', 'E8FjQpALLV', 'tfsheh@yahoo.com', 'Sheh Ting Fung', '7881 553649', 'user', '2016-07-12 08:24:29', '2008-12-07 09:08:45', 0);
INSERT INTO `user` VALUES (963, 'Guo Jialun', 'BMBXpofKPG', 'guojial@hotmail.com', '郭嘉伦', '(116) 139 3508', 'user', '2011-11-23 19:20:00', '2023-11-29 05:34:13', 0);
INSERT INTO `user` VALUES (964, 'Jeffrey Simmons', 'HYQavrxlDQ', 'simmonsj@outlook.com', 'Jeffrey Simmons', '70-9515-7553', 'user', '2013-09-30 09:47:14', '2015-03-05 13:59:06', 1);
INSERT INTO `user` VALUES (965, 'Yip Tin Lok', 'e3pJS3YyRY', 'tinloky@outlook.com', 'Yip Tin Lok', '330-421-2684', 'user', '2010-02-21 22:14:03', '2006-10-03 00:08:03', 1);
INSERT INTO `user` VALUES (966, 'Cho Lai Yan', 'wcoPLkvcKJ', 'laiyancho@hotmail.com', 'Cho Lai Yan', '143-8974-5438', 'user', '2016-03-17 23:37:05', '2021-08-28 02:30:22', 1);
INSERT INTO `user` VALUES (967, 'Lisa Rivera', 'zeRtUO0bVZ', 'lisrivera2011@gmail.com', 'Lisa Rivera', '(161) 878 1819', 'user', '2012-04-06 17:20:39', '2012-05-05 09:38:50', 1);
INSERT INTO `user` VALUES (968, 'Chang Wing Kuen', '56CPNdrtbg', 'cwingkuen10@hotmail.com', 'Chang Wing Kuen', '212-211-4312', 'user', '2005-12-26 02:39:44', '2024-05-07 05:47:48', 0);
INSERT INTO `user` VALUES (969, 'Choi Hiu Tung', 'ADyKYEJwtA', 'hiutungchoi1982@gmail.com', 'Choi Hiu Tung', '7472 070034', 'user', '2004-07-29 10:56:32', '2009-02-27 03:00:14', 0);
INSERT INTO `user` VALUES (970, 'Betty Stone', 'DiTpPvMHXY', 'bes@icloud.com', 'Betty Stone', '212-461-8197', 'user', '2023-05-31 13:09:44', '2013-03-10 20:07:41', 1);
INSERT INTO `user` VALUES (971, 'Mario Salazar', 'IR7SQw9ZSS', 'msa@hotmail.com', 'Mario Salazar', '(1865) 83 2452', 'user', '2013-06-24 03:53:23', '2018-02-05 15:45:35', 0);
INSERT INTO `user` VALUES (972, 'Harold Harris', 'Huq5E0WSNe', 'harold42@yahoo.com', 'Harold Harris', '(20) 8193 0596', 'user', '2007-07-18 00:20:26', '2013-12-22 13:09:41', 1);
INSERT INTO `user` VALUES (973, 'Chu Ka Keung', 'RxhPrb2qXu', 'kkchu2002@gmail.com', 'Chu Ka Keung', '21-386-5629', 'user', '2013-10-18 12:07:46', '2015-07-21 06:25:54', 0);
INSERT INTO `user` VALUES (974, 'Fan Anqi', 'JobGiKyWIw', 'anfan524@icloud.com', 'Fan Anqi', '28-619-4491', 'user', '2009-06-04 03:05:45', '2019-07-20 16:56:18', 0);
INSERT INTO `user` VALUES (975, 'Chiang Chung Yin', 'lggpYtTUiS', 'cchungyin@gmail.com', 'Chiang Chung Yin', '718-524-0395', 'user', '2006-06-29 15:46:50', '2003-04-22 10:27:23', 0);
INSERT INTO `user` VALUES (976, 'Eric Walker', 'TDR95SSF8g', 'ericwalker95@outlook.com', 'Eric Walker', '158-2786-2881', 'user', '2000-12-22 06:01:37', '2007-05-13 17:16:33', 0);
INSERT INTO `user` VALUES (977, 'Gao Jialun', 'fiTztPnPK3', 'jgao@gmail.com', 'Gao Jialun', '(121) 529 5110', 'user', '2008-09-14 12:26:50', '2020-02-29 20:01:53', 1);
INSERT INTO `user` VALUES (978, 'Francisco Rice', 'Yd0IqBqDBl', 'rifrancisco@outlook.com', 'Francisco Rice', '7307 389944', 'user', '2006-03-06 22:14:45', '2018-02-07 20:15:44', 1);
INSERT INTO `user` VALUES (979, 'Lai Kwok Yin', 'JrlbcU5ssC', 'kwokyin122@outlook.com', 'Lai Kwok Yin', '80-3562-0088', 'user', '2016-07-08 07:23:30', '2004-10-27 06:43:46', 0);
INSERT INTO `user` VALUES (980, 'Liu Ziyi', 'A9ESG51qW9', 'zliu69@yahoo.com', 'Liu Ziyi', '614-598-4521', 'user', '2009-08-12 08:45:42', '2019-08-24 09:18:07', 1);
INSERT INTO `user` VALUES (981, 'Marie Woods', 'Rbcs7XlqMS', 'marie826@hotmail.com', 'Marie Woods', '(116) 682 6420', 'user', '2012-08-24 17:29:58', '2022-01-15 22:01:20', 1);
INSERT INTO `user` VALUES (982, 'Tammy Scott', 'Zb6NFPNbFk', 'tammy409@yahoo.com', 'Tammy Scott', '28-8746-6554', 'user', '2008-09-17 02:50:33', '2007-05-15 07:32:25', 1);
INSERT INTO `user` VALUES (983, 'Dai Lik Sun', 'cHv9pLlioW', 'dai6@icloud.com', 'Dai Lik Sun', '330-118-4271', 'user', '2008-12-17 12:43:14', '2020-01-30 10:14:58', 0);
INSERT INTO `user` VALUES (984, 'Paula Ford', 'k0TR3R7uWM', 'paford00@gmail.com', 'Paula Ford', '74-463-6838', 'user', '2011-02-12 17:01:20', '2005-04-16 23:45:29', 0);
INSERT INTO `user` VALUES (985, 'Xia Yunxi', '2xhiZnFUdF', 'xia307@outlook.com', 'Xia Yunxi', '74-027-6652', 'user', '2012-06-30 17:15:38', '2006-10-15 03:42:10', 0);
INSERT INTO `user` VALUES (986, 'Liang Jialun', 'XsZUeuRQsl', 'jilian@gmail.com', '梁嘉伦', '144-7988-2759', 'user', '2005-02-05 12:43:31', '2003-07-26 17:25:07', 1);
INSERT INTO `user` VALUES (987, 'Heather Evans', 'I375JiDK6X', 'evanshe7@gmail.com', 'Heather Evans', '7533 693071', 'user', '2023-11-15 03:37:08', '2007-10-07 16:46:30', 1);
INSERT INTO `user` VALUES (988, 'Alfred Kelley', 'AnRr7V3qlM', 'kelleyalfred@gmail.com', 'Alfred Kelley', '(1865) 46 1718', 'user', '2024-07-25 16:19:47', '2018-05-02 09:25:26', 0);
INSERT INTO `user` VALUES (989, 'Patricia Woods', 'YjfVbkcODl', 'patrwoods@gmail.com', 'Patricia Woods', '(116) 308 5804', 'user', '2016-06-10 13:31:50', '2022-03-27 08:28:33', 0);
INSERT INTO `user` VALUES (990, 'Travis Kelley', 'heJquGAHte', 'travkell@hotmail.com', 'Travis Kelley', '138-5928-1809', 'user', '2014-03-24 04:29:53', '2022-08-15 23:03:29', 1);
INSERT INTO `user` VALUES (991, 'Yao Xiaoming', 'OOScZ7Elng', 'yaoxiao93@gmail.com', '姚晓明', '(121) 072 0770', 'user', '2019-10-19 13:19:08', '2011-09-12 22:35:14', 1);
INSERT INTO `user` VALUES (992, 'Jennifer Rice', '2hd902pMVg', 'jennrice@icloud.com', 'Jennifer Rice', '52-002-9322', 'user', '2004-03-12 02:32:05', '2010-02-20 20:47:37', 1);
INSERT INTO `user` VALUES (993, 'Fong Yu Ling', 'NXT5l7aEjZ', 'fyl@gmail.com', 'Fong Yu Ling', '7443 545746', 'user', '2015-08-09 08:46:45', '2024-09-16 02:26:13', 0);
INSERT INTO `user` VALUES (994, 'Xie Yuning', 'rJ3EuFzsAE', 'xiy@gmail.com', 'Xie Yuning', '330-182-6364', 'user', '2019-07-31 02:59:18', '2001-10-16 20:22:19', 1);
INSERT INTO `user` VALUES (995, 'Hui Wai Lam', '6h0Zcr4mxm', 'hui52@outlook.com', 'Hui Wai Lam', '213-066-9985', 'user', '2016-03-04 06:39:09', '2017-09-14 13:01:27', 1);
INSERT INTO `user` VALUES (996, 'Pak Chun Yu', 'KjMJEBm2P0', 'pakchunyu7@gmail.com', 'Pak Chun Yu', '5865 351715', 'user', '2004-05-14 11:58:54', '2014-09-09 06:28:40', 1);
INSERT INTO `user` VALUES (997, 'Yuen Wing Fat', 'JycwYiddCm', 'yuenwf@icloud.com', 'Yuen Wing Fat', '5567 892424', 'user', '2003-09-30 05:44:19', '2024-03-13 19:48:22', 1);
INSERT INTO `user` VALUES (998, 'Diane Gibson', 'egFna49QNs', 'gibsondiane@gmail.com', 'Diane Gibson', '614-931-3195', 'user', '2004-11-27 02:40:12', '2009-10-22 03:38:54', 1);
INSERT INTO `user` VALUES (999, 'Chang Zhiyuan', '1hEeOBLVNq', 'changzhiy08@outlook.com', 'Chang Zhiyuan', '718-344-3034', 'user', '2007-03-11 01:33:00', '2022-07-29 22:05:35', 1);
INSERT INTO `user` VALUES (1000, 'Jonathan Harrison', 'e9LpxNDEA3', 'jh01@gmail.com', 'Jonathan Harrison', '66-919-5214', 'user', '2024-09-08 08:57:30', '2008-10-01 05:48:02', 1);
INSERT INTO `user` VALUES (1001, 'Cheung Sum Wing', 'ZJN8FNau39', 'swcheung@outlook.com', 'Cheung Sum Wing', '7085 537695', 'user', '2001-05-06 11:31:38', '2009-05-23 21:10:45', 0);
INSERT INTO `user` VALUES (1002, 'Danielle Moore', 'xm6EPI4aQE', 'damoor@hotmail.com', 'Danielle Moore', '5706 180246', 'user', '2019-03-30 07:31:26', '2011-12-06 15:47:01', 1);
INSERT INTO `user` VALUES (1003, 'Emma Rose', 'MEUUmeT5W0', 'emmarose@hotmail.com', 'Emma Rose', '52-293-2831', 'user', '2009-05-01 18:06:36', '2023-12-12 08:15:47', 0);
INSERT INTO `user` VALUES (1004, 'Cheng Wing Kuen', 'JEsXzWIDUZ', 'wkcheng@yahoo.com', 'Cheng Wing Kuen', '213-891-2668', 'user', '2018-08-17 06:08:39', '2009-11-08 22:59:28', 1);
INSERT INTO `user` VALUES (1005, 'Xia Zhennan', 'nNODVrx30F', 'xia89@outlook.com', 'Xia Zhennan', '70-5034-6610', 'user', '2023-05-11 13:15:18', '2016-01-23 21:51:04', 1);
INSERT INTO `user` VALUES (1006, 'Qiu Zitao', '3r47MRewC2', 'qiuz@yahoo.com', 'Qiu Zitao', '151-7078-8924', 'user', '2021-08-24 21:57:32', '2004-07-26 08:21:50', 0);
INSERT INTO `user` VALUES (1007, 'He Zhennan', 'ezTzzCRjWS', 'zhennanhe@outlook.com', '何震南', '168-7814-4017', 'user', '2022-02-17 00:51:43', '2023-02-04 20:14:33', 1);
INSERT INTO `user` VALUES (1008, 'Justin Mills', 'FDhmftDgaq', 'justim@icloud.com', 'Justin Mills', '213-995-2440', 'user', '2005-01-28 10:18:45', '2001-12-04 01:41:18', 0);
INSERT INTO `user` VALUES (1009, 'Pamela Sullivan', 'CITo3iYoPM', 'psullivan@hotmail.com', 'Pamela Sullivan', '3-5886-8865', 'user', '2020-10-27 21:11:14', '2000-12-17 06:37:27', 0);
INSERT INTO `user` VALUES (1010, 'Yu Xiaoming', 'Q37PVD0tY9', 'xiyu10@outlook.com', '于晓明', '212-272-7681', 'user', '2012-03-21 05:58:27', '2002-12-01 15:17:23', 1);
INSERT INTO `user` VALUES (1011, 'Lok Ka Fai', 'yBOUC9CC3m', 'kfl@yahoo.com', 'Lok Ka Fai', '(161) 054 6411', 'user', '2013-12-17 02:39:26', '2003-12-02 20:12:39', 0);
INSERT INTO `user` VALUES (1012, 'Steven Cruz', '55z9YWdrTs', 'stevencr@yahoo.com', 'Steven Cruz', '755-411-1422', 'user', '2020-07-28 17:58:27', '2000-03-01 16:12:44', 0);
INSERT INTO `user` VALUES (1013, 'Dong Rui', 'BTjdec5oke', 'dongr6@gmail.com', '董睿', '66-111-6421', 'user', '2004-11-18 11:27:41', '2007-04-27 18:14:50', 1);
INSERT INTO `user` VALUES (1014, 'Shao Yunxi', 'MHYOXc5JvX', 'yshao102@gmail.com', '邵云熙', '312-520-6690', 'user', '2021-03-27 21:04:04', '2008-06-20 21:59:45', 0);
INSERT INTO `user` VALUES (1015, 'Jin Rui', 'isUjDfpkha', 'rjin51@mail.com', '金睿', '70-4837-1691', 'user', '2000-10-21 21:17:52', '2005-09-18 14:39:39', 1);
INSERT INTO `user` VALUES (1016, 'Deborah Crawford', 'zpdReoBkIj', 'deborahcrawford@outlook.com', 'Deborah Crawford', '74-070-9208', 'user', '2007-06-05 10:12:21', '2003-11-25 13:05:02', 0);
INSERT INTO `user` VALUES (1017, 'Chu Tak Wah', 'LsZCGKva7t', 'takwah1977@icloud.com', 'Chu Tak Wah', '70-0160-3427', 'user', '2005-11-24 12:47:42', '2009-02-05 13:29:05', 1);
INSERT INTO `user` VALUES (1018, 'Emily Patterson', 'nGqXlCR1b2', 'empatterson@gmail.com', 'Emily Patterson', '74-948-8033', 'user', '2020-09-18 15:26:58', '2002-12-23 12:40:00', 0);
INSERT INTO `user` VALUES (1019, 'Tse Ching Wan', 'g1yj41dWQM', 'tsecw6@mail.com', 'Tse Ching Wan', '80-0995-7050', 'user', '2012-12-08 00:02:56', '2005-09-18 12:56:53', 0);
INSERT INTO `user` VALUES (1020, 'Gerald Kim', 'eC4bG1ovuv', 'kgerald@icloud.com', 'Gerald Kim', '70-6023-4240', 'user', '2006-02-12 03:02:10', '2019-05-03 14:31:17', 1);
INSERT INTO `user` VALUES (1021, 'Deborah Russell', 'GqVkkEk6dj', 'deborahrus1009@icloud.com', 'Deborah Russell', '175-2572-6500', 'user', '2009-11-19 13:33:11', '2003-10-11 16:39:08', 1);
INSERT INTO `user` VALUES (1022, 'Wei Jiehong', '1oTrrE9jzG', 'wejiehong823@icloud.com', '魏杰宏', '11-947-5576', 'user', '2023-11-03 01:37:28', '2005-10-10 02:00:02', 0);
INSERT INTO `user` VALUES (1023, 'Christopher Stevens', 'jfrBWTPV1q', 'stevenschristopher@outlook.com', 'Christopher Stevens', '183-4919-3240', 'user', '2024-07-16 17:04:55', '2015-10-21 21:03:21', 1);
INSERT INTO `user` VALUES (1024, 'Lui Wing Fat', 'LZxBopEjng', 'lui57@icloud.com', 'Lui Wing Fat', '170-0784-2343', 'user', '2022-10-24 09:39:13', '2015-10-20 01:40:43', 0);
INSERT INTO `user` VALUES (1025, 'Cui Anqi', 'tMcYp7kqY4', 'anqicui@outlook.com', '崔安琪', '7283 445444', 'user', '2007-06-13 21:36:15', '2011-07-05 15:56:47', 1);
INSERT INTO `user` VALUES (1026, 'Ellen Marshall', 'uBuLFscwJR', 'marshallellen@mail.com', 'Ellen Marshall', '74-316-1841', 'user', '2008-02-07 14:23:49', '2021-09-11 19:08:23', 0);
INSERT INTO `user` VALUES (1027, 'Fong Wai Man', 'mCAXU7OViz', 'wmfo@icloud.com', 'Fong Wai Man', '66-974-7207', 'user', '2018-09-27 03:08:32', '2007-03-17 17:11:46', 0);
INSERT INTO `user` VALUES (1028, 'Sharon Smith', 'l0BEsZB1Mx', 'sharsmit@hotmail.com', 'Sharon Smith', '90-1279-8044', 'user', '2015-08-15 09:54:18', '2000-06-25 21:12:35', 0);
INSERT INTO `user` VALUES (1029, 'Eddie Mendez', 'sfwzglGFIb', 'mendeeddie2@gmail.com', 'Eddie Mendez', '80-4025-3757', 'user', '2001-11-07 12:44:14', '2001-09-20 18:39:18', 1);
INSERT INTO `user` VALUES (1030, 'Miguel Porter', '0JOqA1NTs2', 'miguelport@gmail.com', 'Miguel Porter', '3-9644-1135', 'user', '2015-12-08 05:06:45', '2000-01-11 01:59:20', 1);
INSERT INTO `user` VALUES (1031, 'Lee Lik Sun', 'ge8eAu4D8x', 'liksunlee@mail.com', 'Lee Lik Sun', '140-0739-0290', 'user', '2013-08-18 16:28:27', '2006-02-23 05:31:42', 1);
INSERT INTO `user` VALUES (1032, 'Todd Vargas', 'nd5MVqRYt8', 'vargastodd@gmail.com', 'Todd Vargas', '20-8996-2733', 'user', '2017-05-08 12:54:54', '2008-05-09 22:41:18', 1);
INSERT INTO `user` VALUES (1033, 'Meng Lik Sun', 'pzyKFTFAR4', 'mengls@gmail.com', 'Meng Lik Sun', '7827 325719', 'user', '2019-01-07 13:55:34', '2014-10-09 21:14:55', 1);
INSERT INTO `user` VALUES (1034, 'Raymond Ruiz', 'eEDiQH01qP', 'ruiz56@gmail.com', 'Raymond Ruiz', '838-932-1829', 'user', '2019-03-13 15:17:13', '2012-08-26 04:00:37', 1);
INSERT INTO `user` VALUES (1035, 'Yip Lik Sun', 'prOd8ATpfj', 'yiplik@gmail.com', 'Yip Lik Sun', '838-332-3691', 'user', '2007-02-03 17:12:50', '2023-12-01 01:15:28', 0);
INSERT INTO `user` VALUES (1036, 'Crystal Mcdonald', 'TwMIVeldYb', 'mcdonaldc@mail.com', 'Crystal Mcdonald', '312-853-4708', 'user', '2014-03-27 20:37:26', '2009-09-26 10:17:14', 1);
INSERT INTO `user` VALUES (1037, 'Lui Wai San', 'lTj8Rro33Y', 'lwaisan@icloud.com', 'Lui Wai San', '80-8867-3122', 'user', '2022-10-05 18:58:27', '2018-08-14 05:52:52', 0);
INSERT INTO `user` VALUES (1038, 'Yao Zhiyuan', 'G98Py4Wx5u', 'zhiyuanya88@outlook.com', 'Yao Zhiyuan', '7691 593465', 'user', '2011-09-05 04:09:31', '2020-12-08 13:18:23', 1);
INSERT INTO `user` VALUES (1039, 'Au Chiu Wai', 'ZXs3JB6sLs', 'au10@outlook.com', 'Au Chiu Wai', '7456 973295', 'user', '2001-10-24 22:45:16', '2018-02-10 18:39:54', 1);
INSERT INTO `user` VALUES (1040, 'Wang Yunxi', 'tbO8cwWZnJ', 'yuwang1@mail.com', '王云熙', '80-8810-3289', 'user', '2016-07-25 19:54:57', '2016-03-21 04:16:33', 1);
INSERT INTO `user` VALUES (1041, 'Wong Hiu Tung', '7ES1sovoXl', 'wong505@icloud.com', 'Wong Hiu Tung', '74-573-6030', 'user', '2023-02-01 18:45:37', '2013-03-04 06:43:25', 1);
INSERT INTO `user` VALUES (1042, 'So Tak Wah', 'JQ2Sf1jzWy', 'sotw929@outlook.com', 'So Tak Wah', '175-6292-0870', 'user', '2016-08-31 15:20:18', '2007-11-06 08:23:55', 1);
INSERT INTO `user` VALUES (1043, 'Danielle Foster', 'A2KKJ2Ow3H', 'danielle05@outlook.com', 'Danielle Foster', '74-941-1277', 'user', '2003-06-24 21:47:30', '2007-12-11 21:03:25', 1);
INSERT INTO `user` VALUES (1044, 'Lei Lan', 'qmYAcV71So', 'lanlei1@yahoo.com', 'Lei Lan', '157-0073-6350', 'user', '2002-06-23 06:39:40', '2024-11-16 01:33:29', 1);
INSERT INTO `user` VALUES (1045, 'Nancy Tucker', '2Cux2ee4FE', 'nancytucker1982@gmail.com', 'Nancy Tucker', '(151) 963 3627', 'user', '2017-04-26 03:39:37', '2018-05-17 08:56:06', 1);
INSERT INTO `user` VALUES (1046, 'Shirley Kim', 'RrNSnMM190', 'shirleyki@hotmail.com', 'Shirley Kim', '52-244-6444', 'user', '2018-03-28 09:08:43', '2018-02-13 00:36:20', 1);
INSERT INTO `user` VALUES (1047, 'Brian Hunt', 'RocSDbiLS7', 'brianh2010@icloud.com', 'Brian Hunt', '718-292-8321', 'user', '2007-09-07 04:55:11', '2013-11-11 22:09:59', 1);
INSERT INTO `user` VALUES (1048, 'Hung Yu Ling', 'qXiDPlUKO7', 'yulingh1@gmail.com', 'Hung Yu Ling', '838-834-4109', 'user', '2021-10-26 10:18:56', '2007-01-24 23:07:27', 1);
INSERT INTO `user` VALUES (1049, 'Yung Tak Wah', 'xok7NtjVUj', 'yuta@gmail.com', 'Yung Tak Wah', '312-575-4669', 'user', '2013-01-16 07:58:01', '2008-12-10 19:05:05', 0);
INSERT INTO `user` VALUES (1050, 'Anthony Foster', 'nMjLzCxp7P', 'foantho@icloud.com', 'Anthony Foster', '70-5137-2338', 'user', '2020-05-09 07:07:43', '2024-06-05 02:27:31', 0);
INSERT INTO `user` VALUES (1051, 'Willie Harris', 'hS4n1nCYKC', 'harriswillie64@yahoo.com', 'Willie Harris', '5727 077811', 'user', '2019-02-06 03:23:51', '2014-06-11 13:58:02', 1);
INSERT INTO `user` VALUES (1052, 'Zhong Xiaoming', 'OWmDu4MH7w', 'zhx82@mail.com', 'Zhong Xiaoming', '52-388-2875', 'user', '2004-06-02 09:16:59', '2024-12-10 19:53:42', 0);
INSERT INTO `user` VALUES (1053, 'Xiao Yunxi', 'D0r1bfYJV0', 'yunxiao@gmail.com', 'Xiao Yunxi', '90-5152-9357', 'user', '2004-08-28 06:07:47', '2004-08-21 22:19:39', 1);
INSERT INTO `user` VALUES (1054, 'Maria Weaver', 'jxqvFrjzbq', 'mariweaver05@yahoo.com', 'Maria Weaver', '28-4785-4588', 'user', '2019-09-03 13:49:12', '2021-08-14 23:49:19', 1);
INSERT INTO `user` VALUES (1055, 'Stephen Morgan', 't0TqM0xP9G', 'stephmorga@icloud.com', 'Stephen Morgan', '80-3437-7800', 'user', '2015-03-12 15:48:41', '2005-06-26 11:29:05', 0);
INSERT INTO `user` VALUES (1056, 'Mui Wai Lam', 'PcYSK1O0e7', 'wailammu1214@outlook.com', 'Mui Wai Lam', '5706 357323', 'user', '2002-08-17 04:13:55', '2008-02-17 23:11:15', 0);
INSERT INTO `user` VALUES (1057, 'Lai Ling Ling', 'fVPZIiqACU', 'lailin@outlook.com', 'Lai Ling Ling', '614-130-7965', 'user', '2015-07-29 14:24:44', '2022-01-27 18:50:52', 1);
INSERT INTO `user` VALUES (1058, 'Karen Romero', 'C1CUcfuRSl', 'romek@hotmail.com', 'Karen Romero', '(121) 717 6301', 'user', '2015-10-24 02:04:14', '2000-01-01 13:06:59', 0);
INSERT INTO `user` VALUES (1059, 'Zhang Yuning', 'MbzqRIT25E', 'yuning3@icloud.com', 'Zhang Yuning', '20-455-1334', 'user', '2015-09-17 12:55:10', '2002-07-16 19:17:32', 0);
INSERT INTO `user` VALUES (1060, 'Todd Coleman', 'G596QWO5e6', 'toddcol52@gmail.com', 'Todd Coleman', '159-1661-4774', 'user', '2005-03-27 13:36:02', '2016-10-04 17:55:35', 0);
INSERT INTO `user` VALUES (1061, 'Tang Xiaoming', 'iFSFWQDbNX', 'xiaomtan08@mail.com', '唐晓明', '838-532-5825', 'user', '2002-07-06 00:49:51', '2023-12-28 18:38:50', 1);
INSERT INTO `user` VALUES (1062, 'Wong Chung Yin', 'jMlkIDTGEH', 'wongchungyin@yahoo.com', 'Wong Chung Yin', '166-1887-5675', 'user', '2024-03-18 10:44:48', '2000-06-14 06:40:13', 0);
INSERT INTO `user` VALUES (1063, 'Diana Patel', 'Eq3rRoDqCi', 'dianpatel94@icloud.com', 'Diana Patel', '90-4187-7880', 'user', '2006-02-12 05:35:18', '2013-07-10 08:01:38', 0);
INSERT INTO `user` VALUES (1064, 'Shawn Jackson', 'YZxr7RoQHD', 'sjackson@gmail.com', 'Shawn Jackson', '5754 146962', 'user', '2008-10-05 20:24:49', '2001-03-02 21:29:53', 1);
INSERT INTO `user` VALUES (1065, 'Koon Hok Yau', 'AB2bG6K0MI', 'khokyau@icloud.com', 'Koon Hok Yau', '212-717-2380', 'user', '2014-03-24 11:05:59', '2020-11-14 03:10:50', 1);
INSERT INTO `user` VALUES (1066, 'Wang Jialun', 'G0ieI0YZ9V', 'wj1955@hotmail.com', '王嘉伦', '5023 646349', 'user', '2015-11-12 17:06:57', '2010-01-30 07:48:16', 1);
INSERT INTO `user` VALUES (1067, 'Shao Anqi', 'M5ETtDFjtD', 'shaoanqi@gmail.com', 'Shao Anqi', '194-5393-0534', 'user', '2011-09-18 17:41:35', '2011-03-25 04:31:37', 0);
INSERT INTO `user` VALUES (1068, 'Wu On Kay', 't2KGGQjSh9', 'wok@hotmail.com', 'Wu On Kay', '80-0940-9003', 'user', '2013-04-05 11:08:02', '2008-07-20 22:13:21', 1);
INSERT INTO `user` VALUES (1069, 'Norman Griffin', 'NkuX02P0r9', 'ngriff1106@yahoo.com', 'Norman Griffin', '718-194-7467', 'user', '2002-06-16 05:15:24', '2002-05-06 16:16:00', 0);
INSERT INTO `user` VALUES (1070, 'Wong Sze Kwan', 'yJJHRZGXUZ', 'woszekwan206@icloud.com', 'Wong Sze Kwan', '(151) 819 9798', 'user', '2005-03-02 08:30:55', '2004-02-16 11:41:23', 1);
INSERT INTO `user` VALUES (1071, 'Leslie Munoz', 'h28B2mewAS', 'munoz10@icloud.com', 'Leslie Munoz', '20-2111-6785', 'user', '2010-09-02 09:09:19', '2017-04-28 08:30:51', 1);
INSERT INTO `user` VALUES (1072, 'Ku Wai Man', '9km7yJkDWu', 'wmku46@gmail.com', 'Ku Wai Man', '196-2512-0467', 'user', '2007-06-07 02:30:47', '2017-04-23 22:50:11', 1);
INSERT INTO `user` VALUES (1073, 'Rita Brooks', 'BrMCywGsfV', 'br1988@outlook.com', 'Rita Brooks', '7595 607176', 'user', '2000-10-19 09:52:52', '2005-07-29 17:03:31', 0);
INSERT INTO `user` VALUES (1074, 'Kathryn Alexander', 'bPjSUo3wGD', 'kata@hotmail.com', 'Kathryn Alexander', '3-3407-5053', 'user', '2022-10-07 18:27:03', '2011-11-02 01:33:29', 0);
INSERT INTO `user` VALUES (1075, 'Tan Zitao', 'KNzD1z14KH', 'zita@icloud.com', '谭子韬', '330-779-1333', 'user', '2019-05-18 10:37:17', '2016-07-02 05:45:01', 0);
INSERT INTO `user` VALUES (1076, 'Kwok Wing Fat', '4uFDlORQ0j', 'kwf55@yahoo.com', 'Kwok Wing Fat', '718-035-6149', 'user', '2017-09-15 20:09:48', '2020-03-30 23:00:51', 0);
INSERT INTO `user` VALUES (1077, 'Anthony Henry', 'F3sI6uTCHO', 'anthonyhenry@mail.com', 'Anthony Henry', '3-5253-6543', 'user', '2005-03-14 04:55:44', '2005-04-25 16:49:20', 1);
INSERT INTO `user` VALUES (1078, 'Jiang Ziyi', 'fpQ5Rq4689', 'jziyi@gmail.com', 'Jiang Ziyi', '7624 439722', 'user', '2009-01-12 00:13:14', '2017-09-30 14:16:05', 0);
INSERT INTO `user` VALUES (1079, 'Alan Jenkins', 'umoBQ36p78', 'jealan@yahoo.com', 'Alan Jenkins', '80-6472-0848', 'user', '2000-11-20 04:56:22', '2006-08-28 16:03:10', 1);
INSERT INTO `user` VALUES (1080, 'Pan Shihan', 'IZFzu4YlIx', 'pan1@icloud.com', '潘詩涵', '70-8961-8521', 'user', '2023-11-04 04:39:05', '2015-11-24 00:03:52', 0);
INSERT INTO `user` VALUES (1081, 'Wu Yun Fat', 'xrrqCMS73K', 'wu6@outlook.com', 'Wu Yun Fat', '80-4158-6542', 'user', '2024-08-14 00:51:40', '2001-09-01 12:48:35', 1);
INSERT INTO `user` VALUES (1082, 'Tong Tak Wah', 'URa1rgKyYY', 'tong4@gmail.com', 'Tong Tak Wah', '90-7213-4915', 'user', '2003-05-01 07:48:01', '2015-05-01 06:31:34', 1);
INSERT INTO `user` VALUES (1083, 'Song Lu', 'uBuPG1OLH7', 'solu203@hotmail.com', '宋璐', '614-342-5827', 'user', '2009-10-13 06:06:53', '2006-10-08 14:36:26', 0);
INSERT INTO `user` VALUES (1084, 'Rose Hall', 'KygeK5AAZO', 'roh@icloud.com', 'Rose Hall', '(121) 826 8788', 'user', '2016-12-31 17:17:41', '2023-04-06 12:41:02', 0);
INSERT INTO `user` VALUES (1085, 'Shen Ziyi', '6JkiPPQarS', 'shziyi703@yahoo.com', 'Shen Ziyi', '21-8291-0874', 'user', '2012-08-13 19:34:50', '2018-01-22 21:08:12', 0);
INSERT INTO `user` VALUES (1086, 'Kam Sze Kwan', 'O0NJh6VHre', 'skk@mail.com', 'Kam Sze Kwan', '718-398-3174', 'user', '2019-12-22 11:01:57', '2006-06-09 08:34:18', 0);
INSERT INTO `user` VALUES (1087, 'Bryan Phillips', 'tDiXcxJV31', 'bphill@gmail.com', 'Bryan Phillips', '212-235-8394', 'user', '2005-09-05 21:07:33', '2016-02-08 05:03:51', 1);
INSERT INTO `user` VALUES (1088, 'Teresa Hicks', 'vML1dhwTl7', 'teresahicks01@mail.com', 'Teresa Hicks', '7363 873424', 'user', '2023-08-03 09:14:33', '2008-08-16 22:24:36', 1);
INSERT INTO `user` VALUES (1089, 'Liao Xiuying', 'sTq6ExG9Br', 'xiuyingl@gmail.com', '廖秀英', '5990 994730', 'user', '2019-02-26 05:23:01', '2006-05-19 12:51:55', 0);
INSERT INTO `user` VALUES (1090, 'Fan Rui', 'zDghRn7Hva', 'fanrui55@icloud.com', '范睿', '769-5345-5866', 'user', '2003-06-11 15:43:15', '2004-04-30 13:03:12', 0);
INSERT INTO `user` VALUES (1091, 'Edwin Clark', '8KkgVh7q06', 'edclark421@icloud.com', 'Edwin Clark', '80-5858-0375', 'user', '2006-07-13 18:40:38', '2019-04-13 14:38:34', 1);
INSERT INTO `user` VALUES (1092, 'Cai Shihan', '11MAXxdBI6', 'cshih2@mail.com', '蔡詩涵', '161-2130-9708', 'user', '2014-02-13 20:12:51', '2007-02-27 14:07:39', 1);
INSERT INTO `user` VALUES (1093, 'Feng Rui', 'bLbhHFfsrv', 'frui@gmail.com', 'Feng Rui', '28-5364-8337', 'user', '2019-08-23 01:57:39', '2004-01-06 09:38:07', 1);
INSERT INTO `user` VALUES (1094, 'Judith Mills', 'VisNMNd5Je', 'jmi64@icloud.com', 'Judith Mills', '139-6831-8552', 'user', '2016-04-13 12:21:25', '2020-02-25 13:52:12', 0);
INSERT INTO `user` VALUES (1095, 'Timothy Kelley', 'BEG4C43kvl', 'timothy502@hotmail.com', 'Timothy Kelley', '144-1401-3336', 'user', '2019-07-02 13:09:20', '2004-03-21 00:14:18', 1);
INSERT INTO `user` VALUES (1096, 'Wu Tsz Hin', 'ptKkXiaf00', 'wu77@hotmail.com', 'Wu Tsz Hin', '(161) 640 5758', 'user', '2001-05-13 16:48:54', '2008-01-11 13:14:48', 0);
INSERT INTO `user` VALUES (1097, 'Dennis Bryant', 'U8FltUMHWT', 'bryantdennis@outlook.com', 'Dennis Bryant', '755-943-2722', 'user', '2002-08-26 07:29:31', '2024-02-25 20:07:15', 1);
INSERT INTO `user` VALUES (1098, 'Travis Gutierrez', 'S3LSXcAfua', 'travisgutierrez1016@hotmail.com', 'Travis Gutierrez', '20-8562-9080', 'user', '2019-05-21 04:16:58', '2002-08-18 00:46:26', 1);
INSERT INTO `user` VALUES (1099, 'Mark Thomas', 'TyhwBRiXYM', 'markt77@gmail.com', 'Mark Thomas', '162-2454-1995', 'user', '2011-03-14 00:39:13', '2007-05-14 05:40:20', 0);
INSERT INTO `user` VALUES (1100, 'Ryan Rice', 'Kdf7xMVCWi', 'ricery@icloud.com', 'Ryan Rice', '312-398-7540', 'user', '2009-04-20 01:08:54', '2013-07-18 08:40:39', 1);
INSERT INTO `user` VALUES (1101, 'Eugene Taylor', 'pDNQn0t6l4', 'eugene1995@hotmail.com', 'Eugene Taylor', '718-258-3847', 'user', '2000-04-09 13:35:21', '2018-08-19 23:53:11', 1);
INSERT INTO `user` VALUES (1102, 'Edna Gardner', 'EeP2mfBsh0', 'ednagardner207@outlook.com', 'Edna Gardner', '(121) 223 9453', 'user', '2005-12-28 23:24:47', '2019-12-14 09:42:27', 0);
INSERT INTO `user` VALUES (1103, 'Frances Clark', 'jHipFPfFiy', 'clarkfrances@gmail.com', 'Frances Clark', '330-263-2396', 'user', '2012-07-22 06:38:54', '2017-04-21 08:22:53', 1);
INSERT INTO `user` VALUES (1104, 'Jennifer Campbell', '3Jk5nfcLwd', 'cjenn@gmail.com', 'Jennifer Campbell', '330-414-5428', 'user', '2018-09-08 05:27:42', '2021-03-24 08:21:14', 1);
INSERT INTO `user` VALUES (1105, 'Tam Suk Yee', 'ek3TKGZ00O', 'tam3@outlook.com', 'Tam Suk Yee', '330-562-9431', 'user', '2002-03-22 00:13:28', '2008-12-27 02:34:38', 0);
INSERT INTO `user` VALUES (1106, 'Lai Sau Man', 'cDVFHNUXZP', 'lai10@outlook.com', 'Lai Sau Man', '132-1689-7583', 'user', '2007-06-24 06:47:04', '2006-09-08 18:09:38', 1);
INSERT INTO `user` VALUES (1107, 'Hsuan Tak Wah', '0baAdg22sE', 'twhsuan@icloud.com', 'Hsuan Tak Wah', '153-2243-0709', 'user', '2017-10-05 06:59:50', '2005-09-26 16:14:02', 0);
INSERT INTO `user` VALUES (1108, 'David Hall', 'HiBPjEPET7', 'davidha@icloud.com', 'David Hall', '(121) 155 7656', 'user', '2015-05-26 09:22:57', '2002-07-20 16:14:09', 1);
INSERT INTO `user` VALUES (1109, 'Ye Jiehong', '3ZrZ20Opyh', 'jiehoye@icloud.com', 'Ye Jiehong', '7327 645683', 'user', '2010-09-14 03:33:27', '2006-08-13 04:01:57', 0);
INSERT INTO `user` VALUES (1110, 'Du Zitao', 'R504TNVPGv', 'duzi@icloud.com', '杜子韬', '614-107-0414', 'user', '2003-02-19 14:38:57', '2005-05-10 13:47:58', 1);
INSERT INTO `user` VALUES (1111, 'Jane Bell', 'bAIvIPsx5M', 'belljane@yahoo.com', 'Jane Bell', '7263 593717', 'user', '2008-05-12 09:16:20', '2020-12-19 01:18:15', 0);
INSERT INTO `user` VALUES (1112, 'Fu Lai Yan', '3o9dbjhIf6', 'fuly1105@yahoo.com', 'Fu Lai Yan', '212-626-5750', 'user', '2008-06-15 06:29:35', '2013-04-06 17:23:29', 1);
INSERT INTO `user` VALUES (1113, 'John Reyes', 'hiVy6NTPDc', 'reyes1@gmail.com', 'John Reyes', '5353 256988', 'user', '2010-01-23 01:01:53', '2000-04-10 06:52:12', 1);
INSERT INTO `user` VALUES (1114, 'Miu Chung Yin', 'ijzDqblEdv', 'chunmiu@gmail.com', 'Miu Chung Yin', '838-961-7939', 'user', '2008-09-19 20:31:17', '2017-06-10 01:36:30', 1);
INSERT INTO `user` VALUES (1115, 'Lu Zitao', 'uL5RvDJmtQ', 'zitlu3@hotmail.com', '陆子韬', '614-938-0973', 'user', '2017-11-21 16:18:49', '2000-05-15 17:59:34', 1);
INSERT INTO `user` VALUES (1116, 'Lok Kwok Kuen', 'YQjp2zmPFC', 'kwoklok71@gmail.com', 'Lok Kwok Kuen', '66-833-8281', 'user', '2013-08-23 05:16:26', '2002-10-18 02:45:51', 1);
INSERT INTO `user` VALUES (1117, 'Ren Xiuying', 'EzIm4FkSOo', 'renx51@icloud.com', 'Ren Xiuying', '212-805-2133', 'user', '2004-08-26 08:04:41', '2005-07-01 22:18:04', 1);
INSERT INTO `user` VALUES (1118, 'Wu Shihan', '6jM8YL9BAJ', 'shiwu@gmail.com', 'Wu Shihan', '28-3285-7029', 'user', '2020-04-02 06:45:53', '2010-04-20 03:29:17', 1);
INSERT INTO `user` VALUES (1119, 'Kenneth Bryant', 'Sw8Q9LvDHB', 'kbryant@mail.com', 'Kenneth Bryant', '21-684-1958', 'user', '2005-03-16 02:22:31', '2022-07-04 15:30:36', 1);
INSERT INTO `user` VALUES (1120, 'Mao Zhennan', 'YvoLaytk50', 'mazhennan3@icloud.com', '毛震南', '3-0650-2823', 'user', '2013-06-30 13:54:28', '2010-12-28 02:26:07', 0);
INSERT INTO `user` VALUES (1121, 'Carolyn Rose', 'NKn6uhRKjm', 'carolynrose@gmail.com', 'Carolyn Rose', '838-995-2805', 'user', '2021-09-04 19:50:32', '2005-10-14 09:12:18', 0);
INSERT INTO `user` VALUES (1122, 'Patrick Martin', 'wJaOa7DZzi', 'patrick43@outlook.com', 'Patrick Martin', '70-9689-4131', 'user', '2015-02-11 07:25:48', '2004-08-02 21:12:22', 0);
INSERT INTO `user` VALUES (1123, 'Yao Zhennan', '2rYy4xlpVq', 'yzhe1999@icloud.com', '姚震南', '7078 726952', 'user', '2005-05-20 23:34:24', '2002-09-10 10:28:25', 1);
INSERT INTO `user` VALUES (1124, 'Lok Sai Wing', 'OIi1ikKE5E', 'swlok09@yahoo.com', 'Lok Sai Wing', '718-335-6496', 'user', '2011-02-02 23:33:37', '2022-07-27 01:33:58', 0);
INSERT INTO `user` VALUES (1125, 'Ku Kwok Yin', 'vQLqBseuWO', 'kky@icloud.com', 'Ku Kwok Yin', '70-8927-7058', 'user', '2022-02-07 16:51:10', '2007-06-26 15:06:25', 1);
INSERT INTO `user` VALUES (1126, 'Man Hok Yau', 'Knpwg9Iqkn', 'manhy@outlook.com', 'Man Hok Yau', '330-464-7773', 'user', '2011-03-27 18:51:33', '2016-10-18 10:15:49', 0);
INSERT INTO `user` VALUES (1127, 'Lam Fat', 'IEKRq6Skmn', 'falam10@mail.com', 'Lam Fat', '5646 857211', 'user', '2021-07-27 07:08:41', '2006-07-17 18:33:22', 0);
INSERT INTO `user` VALUES (1128, 'Qiu Lan', 'KbVFv0ipAI', 'qiu2@outlook.com', '邱岚', '(121) 229 6340', 'user', '2009-11-15 16:48:44', '2006-05-06 01:26:00', 0);
INSERT INTO `user` VALUES (1129, 'Hsuan Wing Sze', 'b6PAGyhHYx', 'hsws1992@yahoo.com', 'Hsuan Wing Sze', '312-067-7111', 'user', '2015-05-18 13:02:10', '2023-12-16 14:46:02', 0);
INSERT INTO `user` VALUES (1130, 'Huang Jialun', 'l2FmX5wRf9', 'huaj72@gmail.com', '黄嘉伦', '213-985-9972', 'user', '2019-04-09 02:02:54', '2011-05-03 06:58:39', 0);
INSERT INTO `user` VALUES (1131, 'Kwok Yu Ling', 'spvue6lZVo', 'yulingkwok219@outlook.com', 'Kwok Yu Ling', '718-114-1445', 'user', '2024-02-20 22:57:15', '2006-01-11 09:43:06', 1);
INSERT INTO `user` VALUES (1132, 'Lui Kwok Yin', 'Ra7QyBiCgL', 'luikwokyin@outlook.com', 'Lui Kwok Yin', '212-433-5723', 'user', '2009-06-01 11:07:01', '2022-12-15 19:13:47', 0);
INSERT INTO `user` VALUES (1133, 'So Kar Yan', 'BtZ37KOUG5', 'so43@gmail.com', 'So Kar Yan', '90-0419-0297', 'user', '2022-07-27 13:02:57', '2016-11-07 20:39:05', 1);
INSERT INTO `user` VALUES (1134, 'Lok Ka Ling', 'PEI6d6xcBs', 'lokaling@outlook.com', 'Lok Ka Ling', '52-118-9739', 'user', '2005-04-02 06:36:58', '2012-11-06 07:45:17', 0);
INSERT INTO `user` VALUES (1135, 'Jia Zhiyuan', 'COiGYMQa1N', 'jiazhiyuan@yahoo.com', '贾致远', '10-2575-1360', 'user', '2004-04-28 06:32:39', '2019-02-22 21:31:30', 1);
INSERT INTO `user` VALUES (1136, 'Carol Thompson', '2xN4HZm5AE', 'thompsoncarol@outlook.com', 'Carol Thompson', '614-478-4806', 'user', '2010-12-31 19:14:24', '2004-06-21 04:16:03', 1);
INSERT INTO `user` VALUES (1137, 'Carrie Cruz', 'lBpqQtO8HT', 'ccr@mail.com', 'Carrie Cruz', '70-1789-5345', 'user', '2010-12-22 17:01:00', '2024-04-22 22:17:12', 0);
INSERT INTO `user` VALUES (1138, 'Janet Collins', 'TVmqk5DkRJ', 'janetc@yahoo.com', 'Janet Collins', '213-321-9919', 'user', '2002-06-02 04:52:07', '2011-12-15 15:49:09', 0);
INSERT INTO `user` VALUES (1139, 'Lo Chung Yin', 'zKl1cjFZkS', 'chulo@mail.com', 'Lo Chung Yin', '70-4509-1699', 'user', '2008-11-19 07:52:32', '2021-01-14 22:28:00', 1);
INSERT INTO `user` VALUES (1140, 'Phillip Jordan', 'SFukqTYaEP', 'jordanphillip@icloud.com', 'Phillip Jordan', '760-498-4855', 'user', '2015-01-06 22:52:06', '2014-11-12 06:09:41', 0);
INSERT INTO `user` VALUES (1141, 'Eugene Reyes', 'j97ogS1Wyr', 'reug6@outlook.com', 'Eugene Reyes', '7285 112735', 'user', '2001-03-15 02:15:53', '2017-05-28 04:03:56', 1);
INSERT INTO `user` VALUES (1142, 'Tang Rui', 'sa1Ye394e0', 'ruitang@icloud.com', 'Tang Rui', '(1223) 31 9015', 'user', '2013-04-12 13:09:54', '2002-11-18 05:27:21', 1);
INSERT INTO `user` VALUES (1143, 'Kao Ling Ling', '0041kmvz7v', 'lingling4@gmail.com', 'Kao Ling Ling', '614-207-0252', 'user', '2000-03-06 22:53:25', '2014-10-04 11:45:49', 1);
INSERT INTO `user` VALUES (1144, 'Pak Suk Yee', 'lawQ8iJjv3', 'syp@gmail.com', 'Pak Suk Yee', '90-6459-1673', 'user', '2010-04-11 02:24:49', '2024-09-09 01:39:43', 1);
INSERT INTO `user` VALUES (1145, 'Clarence Alexander', 'mk3bZ8kpT1', 'alexander403@icloud.com', 'Clarence Alexander', '175-6625-3106', 'user', '2001-12-11 05:18:37', '2022-07-21 07:16:33', 0);
INSERT INTO `user` VALUES (1146, 'Ronald Mendoza', 'A383h5VBCU', 'rm13@outlook.com', 'Ronald Mendoza', '11-837-3100', 'user', '2008-06-17 20:28:10', '2003-02-13 08:20:17', 0);
INSERT INTO `user` VALUES (1147, 'Eric Wilson', '67UNJY9rxl', 'wile41@outlook.com', 'Eric Wilson', '760-196-4610', 'user', '2003-10-21 03:54:09', '2021-08-05 08:28:52', 1);
INSERT INTO `user` VALUES (1148, 'Wu Lu', 'alEGhpLHxh', 'wulu@icloud.com', 'Wu Lu', '614-782-9391', 'user', '2023-12-24 20:45:15', '2010-12-14 19:20:56', 0);
INSERT INTO `user` VALUES (1149, 'Margaret Hill', 'SktCixkvoM', 'mahi4@gmail.com', 'Margaret Hill', '11-521-3340', 'user', '2022-05-15 01:37:09', '2014-11-09 05:36:16', 1);
INSERT INTO `user` VALUES (1150, 'Gong Xiaoming', 'kHqLJpUH5u', 'xiaoming1025@gmail.com', 'Gong Xiaoming', '11-073-7237', 'user', '2024-08-22 05:11:42', '2005-10-17 13:49:05', 1);
INSERT INTO `user` VALUES (1151, 'Tsang Ho Yin', '9D7nG8GNIz', 'tsang922@mail.com', 'Tsang Ho Yin', '11-547-2723', 'user', '2006-06-21 00:48:06', '2010-11-21 16:09:23', 0);
INSERT INTO `user` VALUES (1152, 'Li Xiuying', 'FQA5tU0Way', 'xiuying01@icloud.com', '黎秀英', '90-5773-8795', 'user', '2013-07-27 08:17:03', '2023-11-17 03:12:04', 1);
INSERT INTO `user` VALUES (1153, 'Linda Soto', 'bOQkrIPNVZ', 'sotolinda@icloud.com', 'Linda Soto', '5021 060567', 'user', '2022-10-11 22:27:25', '2003-09-22 09:39:32', 0);
INSERT INTO `user` VALUES (1154, 'Jin Lan', 'ifCWCIidTl', 'jin5@gmail.com', 'Jin Lan', '312-311-7631', 'user', '2021-01-24 06:11:32', '2015-03-24 16:56:06', 0);
INSERT INTO `user` VALUES (1155, 'Gloria Butler', 'gTUNTmokcN', 'gloria3@gmail.com', 'Gloria Butler', '90-6981-9442', 'user', '2015-04-22 19:28:54', '2016-03-06 04:10:24', 1);
INSERT INTO `user` VALUES (1156, 'Fan Wing Kuen', 'lae3nQMXTB', 'wingfan618@gmail.com', 'Fan Wing Kuen', '80-9342-3141', 'user', '2009-08-01 10:57:42', '2005-05-30 23:46:13', 0);
INSERT INTO `user` VALUES (1157, 'Kwong Wing Sze', 'OS1EZjWSLF', 'wskwong@icloud.com', 'Kwong Wing Sze', '5095 153520', 'user', '2000-11-11 08:39:25', '2017-06-18 04:33:54', 0);
INSERT INTO `user` VALUES (1158, 'Jacob Palmer', 'VNa34A55Yb', 'palmer6@outlook.com', 'Jacob Palmer', '70-1334-5493', 'user', '2024-02-22 22:30:25', '2000-01-19 18:19:37', 1);
INSERT INTO `user` VALUES (1159, 'Yam Wing Sze', '3akMkRgakR', 'wingszey1945@outlook.com', 'Yam Wing Sze', '(1223) 62 4856', 'user', '2005-03-08 12:17:03', '2012-06-27 02:01:08', 1);
INSERT INTO `user` VALUES (1160, 'Ashley Murray', 'oPgnqzUalf', 'ashley10@yahoo.com', 'Ashley Murray', '11-381-4948', 'user', '2007-10-15 04:42:07', '2005-11-08 03:34:26', 1);
INSERT INTO `user` VALUES (1161, 'Kathy Brooks', 'Fg0t6jDa87', 'kathybroo@gmail.com', 'Kathy Brooks', '5464 822770', 'user', '2016-11-01 06:54:54', '2016-07-18 14:07:59', 0);
INSERT INTO `user` VALUES (1162, 'Willie Fisher', 'fEWKwsyBla', 'fiswillie10@mail.com', 'Willie Fisher', '614-992-2508', 'user', '2009-02-27 15:27:04', '2006-01-24 05:52:21', 1);
INSERT INTO `user` VALUES (1163, 'Vincent Walker', '9OFYyQKzXC', 'wavinc4@icloud.com', 'Vincent Walker', '312-241-4651', 'user', '2017-08-25 00:57:43', '2021-01-22 09:31:26', 0);
INSERT INTO `user` VALUES (1164, 'Joanne Ford', 'QYajJuebE6', 'jford@outlook.com', 'Joanne Ford', '760-423-2593', 'user', '2005-07-30 22:49:10', '2022-11-23 03:50:24', 1);
INSERT INTO `user` VALUES (1165, 'Chen Zitao', 'tcbApLWbjA', 'zitaoch@hotmail.com', 'Chen Zitao', '5824 841087', 'user', '2019-07-30 18:37:34', '2021-06-14 01:59:26', 1);
INSERT INTO `user` VALUES (1166, 'Han Fat', 'WoshiCMhWi', 'fhan@yahoo.com', 'Han Fat', '7347 045433', 'user', '2023-09-23 19:26:05', '2005-01-17 05:32:15', 0);
INSERT INTO `user` VALUES (1167, 'Jia Ziyi', 'Du89hmKwv5', 'ziyjia1971@hotmail.com', 'Jia Ziyi', '838-560-4335', 'user', '2006-05-21 16:09:32', '2010-01-31 09:06:08', 0);
INSERT INTO `user` VALUES (1168, 'Hung Ka Ling', 'PkEPoppOnC', 'hukl@hotmail.com', 'Hung Ka Ling', '718-600-9695', 'user', '2002-05-08 11:55:57', '2000-06-06 17:45:30', 1);
INSERT INTO `user` VALUES (1169, 'Xia Xiuying', 'jVHxGEOalV', 'xiuying1202@yahoo.com', '夏秀英', '3-6249-0423', 'user', '2002-07-10 10:00:37', '2016-10-22 13:50:24', 0);
INSERT INTO `user` VALUES (1170, 'Wei Zhennan', 'lRNV9shSMK', 'zhenwei@yahoo.com', 'Wei Zhennan', '5894 261366', 'user', '2022-07-11 02:36:59', '2015-04-01 11:26:15', 1);
INSERT INTO `user` VALUES (1171, 'Sarah Bennett', 'qV44evyQJp', 'bennetts@outlook.com', 'Sarah Bennett', '5982 698049', 'user', '2015-07-17 10:30:11', '2007-09-21 04:23:59', 1);
INSERT INTO `user` VALUES (1172, 'Albert Snyder', 'ZZXErZLTaF', 'snya@hotmail.com', 'Albert Snyder', '7546 183556', 'user', '2004-02-07 05:03:28', '2024-12-21 16:40:29', 1);
INSERT INTO `user` VALUES (1173, 'Peggy Tran', '56vAMeqRk9', 'pegtran8@gmail.com', 'Peggy Tran', '20-619-5577', 'user', '2005-08-18 12:26:27', '2014-02-16 16:12:09', 1);
INSERT INTO `user` VALUES (1174, 'Liu Jialun', '20zqhMxD2r', 'jiliu@gmail.com', 'Liu Jialun', '80-8721-9705', 'user', '2007-07-24 10:11:29', '2021-01-06 10:03:34', 0);
INSERT INTO `user` VALUES (1175, 'Song Zhennan', 'CbIZnUCNpU', 'zsong@gmail.com', 'Song Zhennan', '769-1959-3780', 'user', '2002-03-14 20:42:04', '2021-04-10 15:11:12', 0);
INSERT INTO `user` VALUES (1176, 'Chiang Chieh Lun', 'n4kX39qeot', 'cchiehlun@gmail.com', 'Chiang Chieh Lun', '70-5582-3127', 'user', '2023-01-05 01:50:05', '2002-05-14 11:54:02', 0);
INSERT INTO `user` VALUES (1177, 'Wei Anqi', 'VFKJo5B885', 'awei@gmail.com', 'Wei Anqi', '90-0056-4142', 'user', '2020-10-30 04:39:11', '2016-04-05 14:08:19', 1);
INSERT INTO `user` VALUES (1178, 'Cheung Siu Wai', 'zt8mU7VAw8', 'chesw@gmail.com', 'Cheung Siu Wai', '614-573-0535', 'user', '2001-05-19 01:53:55', '2016-07-10 04:32:55', 1);
INSERT INTO `user` VALUES (1179, 'Jimmy Kim', 'GyAXmOBwN7', 'kij@gmail.com', 'Jimmy Kim', '188-9327-1993', 'user', '2011-07-15 06:45:22', '2000-12-18 06:43:57', 0);
INSERT INTO `user` VALUES (1180, 'Koon Chi Yuen', 'zuQYpKot3x', 'koon1112@icloud.com', 'Koon Chi Yuen', '(116) 909 0486', 'user', '2014-09-01 14:22:19', '2002-02-02 13:50:57', 1);
INSERT INTO `user` VALUES (1181, 'Yang Zhennan', 'woAS54VBnD', 'yanzhe@gmail.com', '杨震南', '21-471-2624', 'user', '2013-04-24 17:20:28', '2000-07-20 22:07:37', 1);
INSERT INTO `user` VALUES (1182, 'Wei Xiaoming', 'GAJpzax4Fj', 'weixiaoming2@outlook.com', '韦晓明', '(20) 4708 0586', 'user', '2002-12-02 11:34:09', '2023-07-13 14:43:52', 0);
INSERT INTO `user` VALUES (1183, 'Fan Zhiyuan', 'Pv2Bmtm4lQ', 'fanzhiyuan326@icloud.com', 'Fan Zhiyuan', '70-7775-9926', 'user', '2007-11-03 19:40:47', '2014-10-23 14:29:51', 1);
INSERT INTO `user` VALUES (1184, 'Wu Ching Wan', 'crkFvldLdX', 'wchingwan410@outlook.com', 'Wu Ching Wan', '7446 299367', 'user', '2015-10-29 18:25:38', '2013-11-25 04:57:06', 0);
INSERT INTO `user` VALUES (1185, 'Rachel Ramos', 'xILKE8HYTU', 'rachel48@gmail.com', 'Rachel Ramos', '755-4262-5073', 'user', '2007-04-14 11:41:57', '2010-08-24 01:10:43', 0);
INSERT INTO `user` VALUES (1186, 'Ashley Guzman', 'pqTTi44NHR', 'ashleyg@yahoo.com', 'Ashley Guzman', '718-271-5442', 'user', '2015-07-20 02:33:02', '2018-06-06 09:10:52', 1);
INSERT INTO `user` VALUES (1187, 'Mark Sullivan', '1cj4fmAPOp', 'mark1988@gmail.com', 'Mark Sullivan', '7968 230519', 'user', '2003-04-10 20:55:30', '2021-06-17 02:03:59', 0);
INSERT INTO `user` VALUES (1188, 'Yip Ka Ling', 'WnbNjUZBqX', 'klyip2@icloud.com', 'Yip Ka Ling', '(161) 272 9736', 'user', '2024-10-11 05:19:17', '2003-11-28 09:20:20', 0);
INSERT INTO `user` VALUES (1189, 'Lu Yuning', 'IOD8dODzj5', 'luyuni@icloud.com', '吕宇宁', '7197 320787', 'user', '2018-08-19 06:45:41', '2006-01-05 21:06:04', 0);
INSERT INTO `user` VALUES (1190, 'Lu Zhennan', 'jxS3w5WW2K', 'zhennan304@icloud.com', '吕震南', '5075 077497', 'user', '2014-05-21 14:31:47', '2023-12-29 06:50:18', 0);
INSERT INTO `user` VALUES (1191, 'Gary West', 'ORrkLvF1P4', 'west10@gmail.com', 'Gary West', '182-8211-7192', 'user', '2012-05-10 10:54:15', '2012-12-07 04:07:34', 1);
INSERT INTO `user` VALUES (1192, 'Shing Chi Ming', 'Y1SXUtwbjP', 'cmshing2@gmail.com', 'Shing Chi Ming', '213-422-0001', 'user', '2003-04-24 08:14:33', '2016-09-29 04:30:05', 0);
INSERT INTO `user` VALUES (1193, 'Ying Kwok Kuen', '2UJaA3WhoO', 'kwokkuenying@gmail.com', 'Ying Kwok Kuen', '90-5332-6983', 'user', '2015-07-13 14:54:55', '2003-08-04 08:19:19', 0);
INSERT INTO `user` VALUES (1194, 'Cheng Kwok Ming', 'UHUNsHK6tV', 'chengkm12@mail.com', 'Cheng Kwok Ming', '80-3828-8081', 'user', '2002-04-30 04:19:59', '2017-04-17 23:14:03', 1);
INSERT INTO `user` VALUES (1195, 'Michelle Foster', 'SSoEOHHoj8', 'michelle1995@hotmail.com', 'Michelle Foster', '213-920-5551', 'user', '2016-04-06 03:36:22', '2014-03-03 06:52:15', 1);
INSERT INTO `user` VALUES (1196, 'Han Wing Kuen', 'WsOYPkuSJR', 'wkha@yahoo.com', 'Han Wing Kuen', '80-4019-7910', 'user', '2024-09-20 19:56:40', '2014-10-19 21:19:31', 1);
INSERT INTO `user` VALUES (1197, 'Janet Perez', '22zjnA1fbW', 'janetperez2@mail.com', 'Janet Perez', '11-401-6331', 'user', '2003-06-06 00:49:26', '2010-06-19 19:49:13', 0);
INSERT INTO `user` VALUES (1198, 'Fan Jialun', 'WaaEoQkDJL', 'fajia@gmail.com', '范嘉伦', '7403 279660', 'user', '2013-08-14 21:33:38', '2022-04-05 23:28:25', 0);
INSERT INTO `user` VALUES (1199, 'Han Xiuying', 'NG8stxxFnW', 'hxiuying324@gmail.com', 'Han Xiuying', '(1865) 83 2842', 'user', '2018-01-16 03:11:11', '2017-09-05 08:28:00', 0);
INSERT INTO `user` VALUES (1200, 'Fu Ching Wan', 'oZ37GfPnER', 'chingwan58@mail.com', 'Fu Ching Wan', '838-329-9659', 'user', '2015-11-16 15:46:42', '2023-07-17 07:30:03', 0);
INSERT INTO `user` VALUES (1201, 'Vincent Hamilton', '4fyuvedyt5', 'vincenthamilton7@yahoo.com', 'Vincent Hamilton', '80-1390-1142', 'user', '2003-06-09 00:26:46', '2008-02-15 15:06:24', 0);
INSERT INTO `user` VALUES (1202, 'Yip Ting Fung', 'LPynK40Lpv', 'yip728@outlook.com', 'Yip Ting Fung', '(121) 980 8554', 'user', '2017-08-22 05:11:57', '2015-05-08 20:08:51', 0);
INSERT INTO `user` VALUES (1204, 'admin888', 'admin888', 'admin888@qq.com', 'admin888', '12345678910', 'admin', '2024-12-01 16:32:05', '2024-12-18 16:32:53', 0);

SET FOREIGN_KEY_CHECKS = 1;
