
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `admin`
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES 
('1', '1号管理员', 'ncsf123456', '2018-05-08 14:59:52', '0'), 
('2', 'admin', 'admin', '2018-06-09 12:27:13', '1');
COMMIT;

-- ----------------------------
--  Table structure for `appoint`
-- ----------------------------
DROP TABLE IF EXISTS `appoint`;
CREATE TABLE `appoint` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `appointTime` time DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `appoint`
-- ----------------------------
BEGIN;
INSERT INTO `appoint` VALUES ('6', '张三', '13921831839', '4', '15:01:00', '陆鹏');
COMMIT;

-- ----------------------------
--  Table structure for `foods`
-- ----------------------------
DROP TABLE IF EXISTS `foods`;
CREATE TABLE `foods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(10) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `num` int(11) DEFAULT '0',
  `enName` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `tem` varchar(1000) DEFAULT NULL,
  `size` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `foods`
-- ----------------------------
BEGIN;
INSERT INTO `foods` VALUES 
('1', '1', '白露粉莓', '18', '1', '0', 'DEW BERRY POWDER', '1', null, null, null), 
('2', '1', '荔多多', '20', '2', '0', 'A LOT OF LITCHI', '1', null, null, null), 
('3', '1', '泰萌', '22', '3', '0', 'THAILAND ADORABLE', '1', null, null, null), 
('4', '2', '多莓奶冰', '16', '1', '0', 'MIXED CRANBERRY SMOOTHIE', '1', null, null, null), 
('5', '2', '泰冰冰', '17', '2', '0', 'THAILAND SMOOTHIES', '1', null, null, null), 
('6', '2', '泰妃', '20', '3', '0', 'TOFFEE', '1', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `menu`
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES 
('1', '泰潮系列'), 
('2', '泰高冷系列');
COMMIT;

-- ----------------------------
--  Table structure for `mycut`
-- ----------------------------
DROP TABLE IF EXISTS `mycut`;
CREATE TABLE `mycut` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(40) DEFAULT NULL,
  `reduction` int(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `getTime` datetime DEFAULT NULL,
  `useTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `mycut`
-- ----------------------------
BEGIN;
INSERT INTO `mycut` VALUES 
('48', 'oOK6t4kx4dm0784rgnI0L5suJEzQ', '1', '0', '2018-06-13 23:40:40', null);
COMMIT;

-- ----------------------------
--  Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openId` varchar(255) DEFAULT NULL,
  `sumMoney` int(11) DEFAULT NULL,
  `cupNumber` int(11) DEFAULT NULL,
  `cartList` varchar(2000) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `orderId` varchar(255) DEFAULT NULL,
  `cathNumber` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `appointTime` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `disTime` datetime DEFAULT NULL,
  `cutMonney` int(11) DEFAULT NULL,
  `packages` varchar(1000) DEFAULT NULL,
  `cutText` varchar(200) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `order`
-- ----------------------------
BEGIN;
INSERT INTO `order` VALUES 
('99', 'oOK6t4kx4dm0784rgnI0L5suJEzQ', '18', '1', '[{\"cType\":0,\"cIndex\":0,\"name\":\"白露粉莓\",\"price\":18,\"enName\":\"DEW BERRY POWDER\",\"detail\":\"常规,+正常糖+常规\",\"number\":1,\"sum\":18,\"img\":\"1-1\"}]', '2018-06-12 23:42:06', '20180612234159524', 'C001', '1', '', '2', null, '0', 'wx122341597396623a63a3e36e0533527612', null, null);
COMMIT;

-- ----------------------------
--  Table structure for `reduction`
-- ----------------------------
DROP TABLE IF EXISTS `reduction`;
CREATE TABLE `reduction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `typeDes` varchar(255) DEFAULT NULL,
  `rule` int(11) DEFAULT NULL,
  `cut` int(11) DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `reduction`
-- ----------------------------
BEGIN;
INSERT INTO `reduction` VALUES 
('1', '1', '全场满减券', '20', '3', '2018-05-21 00:00:00', '2018-06-21 00:00:00', '0', 'http://cdn.handsomebird.xin/1526893482285'), 
('2', '2', '象丸可可单品券', '24', '3', '2018-05-21 00:00:00', '2018-06-18 00:00:00', '0', 'http://cdn.handsomebird.xin/1526893482285'), 
('14', '1', '满30减5块', '30', '5', '2018-06-14 00:00:00', '2018-07-11 00:00:00', '0', ''), 
('15', '2', '密码', '21', '2', '2018-06-14 00:00:00', '2018-07-08 00:00:00', '0', ''), 
('16', '2', '科技', '22', '5', '2018-06-14 00:00:00', '2018-07-01 00:00:00', '1', 'undefined'), 
('17', '2', '测试', '23', '2', '2018-06-14 00:00:00', '2018-06-14 00:00:00', '0', ''), 
('18', '2', '测试', '20', '3', '2018-06-21 00:00:00', '2018-06-22 00:00:00', '0', '');
COMMIT;

-- ----------------------------
--  Table structure for `shoptime`
-- ----------------------------
DROP TABLE IF EXISTS `shoptime`;
CREATE TABLE `shoptime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `open` int(11) DEFAULT NULL,
  `close` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `shoptime`
-- ----------------------------
BEGIN;
INSERT INTO `shoptime` VALUES ('1', '9', '22');
COMMIT;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickName` varchar(255) DEFAULT NULL,
  `avatarUrl` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `root` int(11) DEFAULT NULL,
  `resum` int(11) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `gender` int(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `openId` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_loginTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES 
('15', '陆鹏', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epoUibXXf3ic3EcyVMg1KxI8A3Gia3pRyWr3PN5uVhak3IaqKXgH9vIN8tgXkrvlha4DCunCSpJcRibvg/132', null, '0', '0', '770', 'Shanghai', '1', '未知', 'oOK6t4kx4dm0784rgnI0L5suJEzQ', '2018-05-05 20:58:59', '2018-06-21 15:33:33', '18818219934');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
