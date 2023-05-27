/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : products_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-12-04 18:22:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_comment`
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `commentId` int(11) NOT NULL auto_increment COMMENT '评论id',
  `productObj` int(11) NOT NULL COMMENT '被评商品',
  `content` varchar(1000) NOT NULL COMMENT '评论内容',
  `userObj` varchar(30) NOT NULL COMMENT '评论用户',
  `commentTime` varchar(20) default NULL COMMENT '评论时间',
  PRIMARY KEY  (`commentId`),
  KEY `productObj` (`productObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_comment_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_comment_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES ('1', '1', '非常棒棒哒', 'user2', '');
INSERT INTO `t_comment` VALUES ('2', '1', '好评', 'user2', '');
INSERT INTO `t_comment` VALUES ('3', '3', '给卖家好评', 'user2', '');
INSERT INTO `t_comment` VALUES ('4', '3', '我也想要', 'user2', '');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL auto_increment COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) default NULL COMMENT '留言时间',
  `replyContent` varchar(1000) default NULL COMMENT '管理回复',
  `replyTime` varchar(20) default NULL COMMENT '回复时间',
  PRIMARY KEY  (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', '111', '222', 'user1', '2018-11-30 15:50:03', '333', '2018-11-30 15:50:06');
INSERT INTO `t_leaveword` VALUES ('2', 'aa', 'bb', 'user1', '2018-11-30 15:50:11', '很好', '2018-11-30 15:50:14');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', 'aaaa', '<p>bbbb</p>', '2018-11-30 15:50:55');

-- ----------------------------
-- Table structure for `t_orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_orderinfo`;
CREATE TABLE `t_orderinfo` (
  `orderNo` varchar(30) NOT NULL COMMENT 'orderNo',
  `userObj` varchar(30) NOT NULL COMMENT '下单用户',
  `totalMoney` float NOT NULL COMMENT '订单总金额',
  `payWay` varchar(20) NOT NULL COMMENT '支付方式',
  `orderStateObj` varchar(20) NOT NULL COMMENT '订单状态',
  `orderTime` varchar(20) default NULL COMMENT '下单时间',
  `receiveName` varchar(20) NOT NULL COMMENT '收货人',
  `telephone` varchar(20) NOT NULL COMMENT '收货人电话',
  `address` varchar(80) NOT NULL COMMENT '收货人地址',
  `orderMemo` varchar(500) default NULL COMMENT '订单备注',
  PRIMARY KEY  (`orderNo`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_orderinfo_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderinfo
-- ----------------------------
INSERT INTO `t_orderinfo` VALUES ('14433334433', 'user2', '60', '支付宝', '已付款', '2018-12-19 15:13:14', '马云林', '13958398343', '四川成都万年场13号', 'test');
INSERT INTO `t_orderinfo` VALUES ('user120180122225749', 'user2', '92.5', '支付宝', '已发货', '2018-11-22 22:57:49', '王', '13598308394', '四川成都红星路13号', '尽快发货哦！');
INSERT INTO `t_orderinfo` VALUES ('user120180123234311', 'user2', '99.5', '支付宝', '已付款', '2018-11-23 23:43:11', '王忠强', '13598308394', '四川成都红星路13号', 'test333');
INSERT INTO `t_orderinfo` VALUES ('user120180301125118', 'user2', '138.5', '支付宝', '已发货', '2018-11-01 12:51:18', '王丽丽', '13598308394', '四川成都红星路13号', '快点发货吧');
INSERT INTO `t_orderinfo` VALUES ('user120181130161307', 'user2', '55.5', '支付宝', '已付款', '2018-11-30 16:13:07', '王丽丽', '13598308394', '四川成都红星路13号', '');
INSERT INTO `t_orderinfo` VALUES ('user120181204133239', 'user1', '100', '支付宝', '已付款', '2018-12-04 13:32:39', '小红', '13598308394', '广东深圳', '');

-- ----------------------------
-- Table structure for `t_orderitem`
-- ----------------------------
DROP TABLE IF EXISTS `t_orderitem`;
CREATE TABLE `t_orderitem` (
  `itemId` int(11) NOT NULL auto_increment COMMENT '条目id',
  `orderObj` varchar(30) NOT NULL COMMENT '所属订单',
  `productObj` int(11) NOT NULL COMMENT '订单商品',
  `price` float NOT NULL COMMENT '商品单价',
  `orderNumer` int(11) NOT NULL COMMENT '购买数量',
  PRIMARY KEY  (`itemId`),
  KEY `orderObj` (`orderObj`),
  KEY `productObj` (`productObj`),
  CONSTRAINT `t_orderitem_ibfk_1` FOREIGN KEY (`orderObj`) REFERENCES `t_orderinfo` (`orderNo`),
  CONSTRAINT `t_orderitem_ibfk_2` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderitem
-- ----------------------------
INSERT INTO `t_orderitem` VALUES ('1', '14433334433', '1', '28.5', '2');
INSERT INTO `t_orderitem` VALUES ('2', 'user120180122225749', '1', '28.5', '2');
INSERT INTO `t_orderitem` VALUES ('3', 'user120180122225749', '2', '35.5', '1');
INSERT INTO `t_orderitem` VALUES ('4', 'user120180123234311', '2', '35.5', '2');
INSERT INTO `t_orderitem` VALUES ('5', 'user120180123234311', '1', '28.5', '1');
INSERT INTO `t_orderitem` VALUES ('6', 'user120180301125118', '1', '28.5', '2');
INSERT INTO `t_orderitem` VALUES ('7', 'user120180301125118', '2', '35.5', '1');
INSERT INTO `t_orderitem` VALUES ('8', 'user120180301125118', '3', '23', '2');
INSERT INTO `t_orderitem` VALUES ('9', 'user120181130161307', '6', '20', '1');
INSERT INTO `t_orderitem` VALUES ('10', 'user120181130161307', '2', '35.5', '1');
INSERT INTO `t_orderitem` VALUES ('11', 'user120181204133239', '7', '100', '1');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `productId` int(11) NOT NULL auto_increment COMMENT '商品id',
  `productClassObj` int(11) NOT NULL COMMENT '商品类别',
  `productName` varchar(50) NOT NULL COMMENT '商品名称',
  `mainPhoto` varchar(60) NOT NULL COMMENT '商品图片',
  `productNum` int(11) NOT NULL COMMENT '商品库存',
  `price` float NOT NULL COMMENT '商品价格',
  `recommandFlag` varchar(20) NOT NULL COMMENT '是否推荐',
  `recipeFlag` varchar(20) NOT NULL COMMENT '是否处方药',
  `productDesc` varchar(5000) NOT NULL COMMENT '商品描述',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`productId`),
  KEY `productClassObj` (`productClassObj`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`productClassObj`) REFERENCES `t_productclass` (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '1', '贝思客雪域牛乳生日蛋糕新鲜奶油芝士儿童零食上海北京同城配送', 'upload/520de01d-3ece-4e8d-bfc9-3380926c3800.png', '100', '28.5', '是', '否', '<p>品牌名称：<span class=\"J_EbrandLogo\" style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51);\">贝思客</span></p><p class=\"attr-list-hd tm-clear\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 5px 20px; line-height: 22px; color: rgb(153, 153, 153); font-family: tahoma, arial, 微软雅黑, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; font-weight: 700; float: left;\">产品参数：</span></p><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>生产许可证编号：QS3114 2401 0721</p></li><li><p>厂名：上海煜峰食品有限公司</p></li><li><p>厂址：上海市嘉定区丰茂路658号7幢B区一层、二层、三层</p></li><li><p>厂家联系方式：62197618</p></li><li><p>储藏方法：冷藏</p></li><li><p>保质期：2 天</p></li><li><p>包装方式:&nbsp;包装</p></li><li><p>同城服务:&nbsp;同城24小时卖家送货上门</p></li><li><p>品牌:&nbsp;贝思客</p></li><li><p>系列:&nbsp;经典系列35</p></li><li><p>是否为有机食品:&nbsp;否</p></li><li><p>生鲜储存温度:&nbsp;0-8℃</p></li><li><p>蛋糕种类:&nbsp;芝士蛋糕</p></li><li><p>蛋糕尺寸:&nbsp;1磅&nbsp;2磅&nbsp;3磅</p></li><li><p>蛋糕价格:&nbsp;101-200元</p></li><li><p>产地:&nbsp;中国大陆</p></li><li><p>省份:&nbsp;上海</p></li></ul><p><br/></p>', '2018-11-30 15:47:57');
INSERT INTO `t_product` VALUES ('2', '2', '浅茶家原味重芝士条乳酪起司西式糕点心蛋糕纯手工休闲健康零食', 'upload/657b97a3-7647-4331-802e-5b70a4fe3e3d.png', '100', '35.5', '是', '否', '<p>品牌名称：<span class=\"J_EbrandLogo\" style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51);\">浅茶家</span></p><p class=\"attr-list-hd tm-clear\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 5px 20px; line-height: 22px; color: rgb(153, 153, 153); font-family: tahoma, arial, 微软雅黑, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; font-weight: 700; float: left;\">产品参数：</span></p><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>生产许可证编号：SC12437010500152</p></li><li><p>产品标准号：GB-20977</p></li><li><p>厂名：济南添然烘焙食品有限公司</p></li><li><p>厂址：济南市天桥区药山街道东宇大街799号</p></li><li><p>厂家联系方式：0531-81251818</p></li><li><p>配料表：乳酪 稀奶油 黄油 鸡蛋 小麦粉 白砂糖</p></li><li><p>储藏方法：冷藏或冷冻</p></li><li><p>保质期：10 天</p></li><li><p>食品添加剂：无</p></li><li><p>是否为有机食品:&nbsp;否</p></li><li><p>包装方式:&nbsp;包装</p></li><li><p>糕点种类:&nbsp;西式糕点</p></li><li><p>净含量:&nbsp;250g</p></li><li><p>品牌:&nbsp;浅茶家</p></li><li><p>系列:&nbsp;芝士条类</p></li><li><p>是否含糖:&nbsp;含糖</p></li><li><p>产地:&nbsp;中国大陆</p></li><li><p>省份:&nbsp;山东省</p></li></ul><p><br/></p>', '2018-11-30 15:48:15');
INSERT INTO `t_product` VALUES ('3', '1', '元祖全国上海北京广州杭州南京成都重庆甜蜜生日蛋糕同城配送速递', 'upload/d1df10a6-5357-4490-afb1-373a1ca8a940.png', '100', '23', '是', '否', '<ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>品牌名称：<span class=\"J_EbrandLogo\" style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51);\">GANSO/元祖</span></p></li><li><p class=\"attr-list-hd tm-clear\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 5px 20px; line-height: 22px; color: rgb(153, 153, 153); font-family: tahoma, arial, 微软雅黑, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; font-weight: 700; float: left;\">产品参数：</span></p></li><li><p>生产许可证编号：SC12431011800369</p></li><li><p>产品标准号：SB/T 10329</p></li><li><p>厂名：上海元祖梦果子股份有限公司</p></li><li><p>厂址：上海青浦赵巷镇嘉松中路6088号</p></li><li><p>厂家联系方式：021-59755678</p></li><li><p>储藏方法：冷藏3~7度1天</p></li><li><p>保质期：1 天</p></li><li><p>包装方式:&nbsp;包装</p></li><li><p>同城服务:&nbsp;同城24小时卖家送货上门</p></li><li><p>品牌:&nbsp;GANSO/元祖</p></li><li><p>系列:&nbsp;鲜奶</p></li><li><p>蛋糕种类:&nbsp;鲜奶水果蛋糕</p></li><li><p>蛋糕尺寸:&nbsp;10英寸&nbsp;6英寸&nbsp;8英寸</p></li><li><p>层数:&nbsp;单层(两层夹心)</p></li><li><p>配送地区:&nbsp;全国</p></li><li><p>蛋糕价格:&nbsp;101-200元</p></li><li><p>产地:&nbsp;中国大陆</p></li><li><p>省份:&nbsp;上海</p></li></ul><p><br/></p>', '2018-11-30 15:48:09');
INSERT INTO `t_product` VALUES ('4', '3', '壹点壹客儿童生日蛋糕生日同城奶油草莓蛋糕慕斯翻糖蛋糕深圳成都', 'upload/c5a7ace1-f838-4304-a16f-6a6562140317.png', '100', '25', '是', '否', '<p>品牌名称：<span class=\"J_EbrandLogo\" style=\"margin: 0px; padding: 0px; color: rgb(51, 51, 51);\">1Date 1Cake/壹点壹客</span></p><p class=\"attr-list-hd tm-clear\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 5px 20px; line-height: 22px; color: rgb(153, 153, 153); font-family: tahoma, arial, 微软雅黑, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; font-weight: 700; float: left;\">产品参数：</span></p><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>生产许可证编号：SC12444030500120</p></li><li><p>厂名：深圳壹点壹客食品有限公司</p></li><li><p>厂址：深圳市南山区西丽镇官龙村第一工业区G栋二楼</p></li><li><p>厂家联系方式：4006517217</p></li><li><p>配料表：小麦粉、新鲜草莓、稀奶油、草莓果茸、黄油、牛奶、草莓利口酒</p></li><li><p>储藏方法：0-4度保藏12小时，3小时食用为佳</p></li><li><p>保质期：1 天</p></li><li><p>食品添加剂：无</p></li><li><p>包装方式:&nbsp;包装</p></li><li><p>品牌:&nbsp;1Date 1Cake/壹点壹客</p></li><li><p>系列:&nbsp;蛋糕</p></li><li><p>是否为有机食品:&nbsp;否</p></li><li><p>蛋糕尺寸:&nbsp;1磅&nbsp;2磅&nbsp;3磅&nbsp;其它</p></li><li><p>层数:&nbsp;单层，双层，三层</p></li><li><p>配送地区:&nbsp;广东省</p></li><li><p>蛋糕价格:&nbsp;101-200元</p></li><li><p>产地:&nbsp;中国大陆</p></li><li><p>省份:&nbsp;广东省</p></li></ul><p><br/></p>', '2018-11-30 15:48:23');
INSERT INTO `t_product` VALUES ('5', '4', 'BossBlend x系列冰淇淋粉商用雪糕粉自制家用甜筒软冰激凌原料1kg', 'upload/f2805199-f755-49f3-a650-cdc5aeda545c.png', '100', '55', '是', '否', '<p class=\"attr-list-hd tm-clear\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 5px 20px; line-height: 22px; color: rgb(153, 153, 153); font-family: tahoma, arial, 微软雅黑, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px; font-weight: 700; float: left;\">产品参数：</span></p><ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>生产许可证编号：SC10633042101885</p></li><li><p>产品标准号： GB/T29602</p></li><li><p>厂名：膳滋饮（嘉善）食品有限公司</p></li><li><p>厂址：浙江省嘉兴市嘉善县惠民街道之江路69号2号厂房二楼东侧</p></li><li><p>厂家联系方式：021-61993313</p></li><li><p>配料表：详见包装</p></li><li><p>储藏方法：请置于阴凉干燥处</p></li><li><p>保质期：365 天</p></li><li><p>食品添加剂：详见包装</p></li><li><p>净含量:&nbsp;1000g</p></li><li><p>包装方式:&nbsp;包装</p></li><li><p>包装规格:&nbsp;500g(含)-1000g(含)</p></li><li><p>原料成分:&nbsp;烘焙原料</p></li><li><p>品牌:&nbsp;Boss Blend</p></li><li><p>系列:&nbsp;冰淇淋粉</p></li><li><p>规格:&nbsp;1000g</p></li><li><p>商品条形码:&nbsp;6955604102169</p></li><li><p>是否为有机食品:&nbsp;否</p></li><li><p>颜色分类:&nbsp;牛奶味&nbsp;草莓味&nbsp;香草味&nbsp;芒果味&nbsp;香芋味&nbsp;巧克力&nbsp;抹茶味&nbsp;哈密瓜&nbsp;咖啡味&nbsp;玫瑰味&nbsp;X系列牛奶味&nbsp;X系列草莓味&nbsp;X系列香草味&nbsp;X系列芒果味&nbsp;X系列巧克力味&nbsp;X系列咖啡味&nbsp;X系列香蕉味&nbsp;X系列椰子味</p></li><li><p>产地:&nbsp;中国大陆</p></li><li><p>省份:&nbsp;浙江省</p></li><li><p>套餐份量:&nbsp;2人份</p></li><li><p>套餐周期:&nbsp;2周</p></li><li><p>配送频次:&nbsp;1周1次</p></li></ul><p><br/></p>', '2018-11-30 15:48:31');
INSERT INTO `t_product` VALUES ('6', '4', '可可百利薄脆片法国进口烘焙原料500g薄片慕斯蛋糕材料饼干碎片', 'upload/0d075ab9-07d7-4a05-ac24-0fcdd70cd8f8.png', '100', '100', '是', '是', '<ul class=\"attributes-list list-paddingleft-2\" style=\"list-style-type: none;\"><li><p>厂名:&nbsp;法国可可百利</p></li><li><p>厂址:&nbsp;法国</p></li><li><p>厂家联系方式:&nbsp;1</p></li><li><p>配料表:&nbsp;见包装</p></li><li><p>保质期:&nbsp;400</p></li><li><p>食品添加剂:&nbsp;1</p></li><li><p>净含量:&nbsp;500G</p></li><li><p>包装方式:&nbsp;包装</p></li><li><p>品牌:&nbsp;可可百利</p></li><li><p>系列:&nbsp;薄脆片</p></li><li><p>规格:&nbsp;500G</p></li><li><p>颜色分类:&nbsp;250G装 500G装 2.5千克整盒</p></li><li><p>产地:&nbsp;法国</p></li></ul><p><br/></p>', '2018-11-30 15:48:39');
INSERT INTO `t_product` VALUES ('7', '5', '小红diy蛋糕', 'upload/da4a8ead-c8b9-4190-a409-696f4acce8fe.jpg', '1', '100', '是', '是', '<p>该蛋糕是你预订的哦，我已经做好了<br/></p>', '2018-12-04 13:31:44');

-- ----------------------------
-- Table structure for `t_productclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_productclass`;
CREATE TABLE `t_productclass` (
  `classId` int(11) NOT NULL auto_increment COMMENT '类别id',
  `className` varchar(40) NOT NULL COMMENT '类别名称',
  `classDesc` varchar(500) NOT NULL COMMENT '类别描述',
  PRIMARY KEY  (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productclass
-- ----------------------------
INSERT INTO `t_productclass` VALUES ('1', '奶油蛋糕', '奶油蛋糕');
INSERT INTO `t_productclass` VALUES ('2', '芝士蛋糕', '芝士蛋糕');
INSERT INTO `t_productclass` VALUES ('3', '翻糖蛋糕', '翻糖蛋糕');
INSERT INTO `t_productclass` VALUES ('4', '蛋糕材料区', '蛋糕材料区');
INSERT INTO `t_productclass` VALUES ('5', '小红diy蛋糕', '小红diy蛋糕');

-- ----------------------------
-- Table structure for `t_recharge`
-- ----------------------------
DROP TABLE IF EXISTS `t_recharge`;
CREATE TABLE `t_recharge` (
  `rechargeId` int(11) NOT NULL auto_increment COMMENT '充值id',
  `userObj` varchar(30) NOT NULL COMMENT '充值用户',
  `rechargeMoney` float NOT NULL COMMENT '充值金额',
  `rechargeMemo` varchar(500) default NULL COMMENT '充值备注',
  `rechargeTime` varchar(20) default NULL COMMENT '充值时间',
  PRIMARY KEY  (`rechargeId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_recharge_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_recharge
-- ----------------------------
INSERT INTO `t_recharge` VALUES ('1', 'user1', '100', 'test', '2018-11-30 15:50:21');
INSERT INTO `t_recharge` VALUES ('2', 'user1', '50', 'test22', '2018-11-30 15:50:26');
INSERT INTO `t_recharge` VALUES ('3', 'user1', '50', '333', '2018-11-30 15:50:31');
INSERT INTO `t_recharge` VALUES ('4', 'user1', '500', '来给你充值', '2018-11-30 15:50:37');

-- ----------------------------
-- Table structure for `t_recipel`
-- ----------------------------
DROP TABLE IF EXISTS `t_recipel`;
CREATE TABLE `t_recipel` (
  `recipelId` int(11) NOT NULL auto_increment COMMENT '定制id',
  `recipelPhoto` varchar(60) NOT NULL COMMENT '定制diy照片',
  `userObj` varchar(30) NOT NULL COMMENT '上传用户',
  `recipelMemo` varchar(500) default NULL COMMENT 'diy定制备注',
  `handState` varchar(20) NOT NULL COMMENT '处理状态',
  `addTime` varchar(20) default NULL COMMENT '上传时间',
  PRIMARY KEY  (`recipelId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_recipel_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_recipel
-- ----------------------------
INSERT INTO `t_recipel` VALUES ('4', 'upload/e3701621-5b8a-41ef-9935-9948ba1a3ff8.png', 'user2', '要奶油口味的，然后为花形状的蛋糕，麻烦给我弄下，3天时间要。谢谢店家', '已处理', '2018-11-30 15:48:50');

-- ----------------------------
-- Table structure for `t_shopcart`
-- ----------------------------
DROP TABLE IF EXISTS `t_shopcart`;
CREATE TABLE `t_shopcart` (
  `cartId` int(11) NOT NULL auto_increment COMMENT '购物车id',
  `productObj` int(11) NOT NULL COMMENT '商品',
  `userObj` varchar(30) NOT NULL COMMENT '用户',
  `price` float NOT NULL COMMENT '单价',
  `buyNum` int(11) NOT NULL COMMENT '购买数量',
  PRIMARY KEY  (`cartId`),
  KEY `productObj` (`productObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_shopcart_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_shopcart_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shopcart
-- ----------------------------

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `userMoney` float NOT NULL COMMENT '账户余额',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '小红', '男', '2018-11-30', 'upload/2e132d04-f747-4297-ad59-42f35c7b7d80.jpg', '13598308394', 'dashen@163.com', '广东深圳', '226', '2018-11-30 15:47:36');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '王丽丽', '女', '2018-11-30', 'upload/38353750-0fff-41e9-9dd8-1807c675155f.jpg', '15129893233', 'wanglili@163.com', '福建福州', '0', '2018-11-30 15:47:42');
