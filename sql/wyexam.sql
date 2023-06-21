/*
 Navicat Premium Data Transfer

 Source Server         : LocalDB
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : wyexam

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 21/06/2023 17:51:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `adminId` int(0) NOT NULL AUTO_INCREMENT COMMENT 'ID号',
  `adminName` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '姓名',
  `phoneNum` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '电话号码',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '电子邮箱',
  `pwd` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `cardId` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '身份证号',
  `part` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '角色(0管理员，1教师，2学生)',
  PRIMARY KEY (`adminId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9556 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '管理员信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (9527, '超级管理员', '13658377857', '1253838283@qq.com', '123456', '3132', '0');
INSERT INTO `admin` VALUES (9528, '超级管理员', NULL, NULL, '123456', NULL, '0');
INSERT INTO `admin` VALUES (9529, '超级管理员', NULL, NULL, 'ssl21314123', NULL, '0');
INSERT INTO `admin` VALUES (9555, '超级管理员', NULL, NULL, '123456', NULL, '0');

-- ----------------------------
-- Table structure for application_question
-- ----------------------------
DROP TABLE IF EXISTS `application_question`;
CREATE TABLE `application_question`  (
  `questionId` int(0) NOT NULL AUTO_INCREMENT COMMENT '应用题ID',
  `subject` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '考试科目',
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '题目内容',
  `analysis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '题目解析',
  `chapter` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '章节',
  `mark` int(0) NOT NULL COMMENT '分数',
  `difficulty` int(0) NOT NULL COMMENT '难度',
  `referenceAns` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`questionId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10030 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of application_question
-- ----------------------------
INSERT INTO `application_question` VALUES (10000, '计算机网络', '简述CSMA技术的P—坚持算法规则。', '', '', 10, 2, 'P—坚持算法规则为：\r\n\r\n(1)监听总线，如果总线空闲，则以P的概率发送，而以(1-P)的概率延迟一个时间单位(最大传播时延的2倍)。\r\n\r\n(2)延迟了一个时间单位后，再重复步骤(1)。\r\n\r\n(3)如果总线是忙的，继续监听直至总线空闲并重复步骤(1)。');
INSERT INTO `application_question` VALUES (10001, '计算机网络', '简述Novell NetWare对文件服务器的共享硬盘提供的5级可靠性措施。', '', NULL, 10, 2, '第一级：对硬盘目录和文件分配表(FAT)的保护；\r\n\r\n第二级：对硬盘表面损坏时的数据保护；\r\n\r\n第三级：采用磁盘镜像的方法实现对磁盘驱动器损坏的保护；\r\n\r\n第四级：采用磁盘双工，对磁盘通道或磁盘驱动器损坏起到保护作用。\r\n\r\n第五级：采用事务跟踪系统TTS的附加容错功能。');
INSERT INTO `application_question` VALUES (10002, '计算机网络', '简述使用“拨号网络”连接Internet所需进行的准备工作。', '', NULL, 10, 2, '(1)选择合适的ISP，通过ISP获取Internet帐号；\r\n\r\n(2)准备一个调制解调器和一条能拨通ISP的电话线；\r\n\r\n(3)安装“拨号网络”；\r\n\r\n(4)安装TCP/IP协议并将其绑定到“拨号网络适配器”；\r\n\r\n(5)输入TCP/IP相关信息；\r\n\r\n(6)用“拨号网络”建立与ISP的连接。');
INSERT INTO `application_question` VALUES (10003, '计算机网络', '采用相—幅调制(PAM)技术在带宽为32KHz的无噪声信道上传输数字信号，每个相位处都有两种不同幅度的电平。若要达到192Kbps的数据速率，至少要有多少种不同的相位?', '', NULL, 10, 3, '根据奈奎斯特公式C=2HLog2N\r\n\r\n由题意C=192K,H=32K\r\n\r\n解得Log2N=3,N=8\r\n\r\n');
INSERT INTO `application_question` VALUES (10004, '计算机网络', '速率为9600bps的调制解调器，若采用无校验位、一位停止位的异步传输方式，试计算2分钟内最多能传输多少个汉字(双字节)?', '', NULL, 10, 3, '①2分钟传输的位数为9600bps×120=1152000位\r\n\r\n②由于每个汉字用双字节表示，所以在给定的异步传输方式下每个汉字需传输的位数为\r\n\r\n(8+1+1)×2=20位\r\n\r\n③2分钟内传输的汉字数为1152000位÷20位=57600(个)');
INSERT INTO `application_question` VALUES (10005, '计算机网络', '长2km、数据传输率为10Mbps的基带总线LAN，信号传播速度为200m/μs，试计算：\r\n\r\n(1)1000比特的帧从发送开始到接收结束的最大时间是多少?\r\n\r\n(2)若两相距最远的站点在同一时刻发送数据，则经过多长时间两站发现冲突? ', '', NULL, 10, 4, '(1)1000bit/10Mbps+2000m/200(m/μs)=100μs+10μs=110μs\r\n\r\n(2)2000m/200(m/μs)=10μs');
INSERT INTO `application_question` VALUES (10006, '计算机组成原理', '静态MOS存储元、动态MOS存储元各有什么特点？', '', NULL, 10, 2, '在MOS半导体存储器中，根据存储信息机构的原理不同，又分为静态MOS存储器（SRAM）和动态MOS存储器（DRAM），前者利用双稳态触发器来保存信息，只要不断电，信息不会丢失，后者利用MOS电容存储电荷来保存信息，使用时需不断给电容充电才能使信息保持。');
INSERT INTO `application_question` VALUES (10007, '计算机组成原理', '什么是刷新？为什么要刷新？有哪几种常用的刷新方式？', '', NULL, 10, 2, '对动态存储器要每隔一定时间（通常是2ms）给全部基本存储元的存储电容补充一次电荷，称为RAM的刷新，2ms是刷新间隔时间。由于存放信息的电荷会有泄漏，动态存储器的电荷不能象静态存储器电路那样，由电源经负载管源源不断地补充，时间一长，就会丢失信息，所以必须刷新。常用的刷新方式有两种：集中式刷新、分布式刷新。');
INSERT INTO `application_question` VALUES (10008, '计算机组成原理', 'Cache有哪些特点？', '', NULL, 10, 5, 'Cache具有如下特点：\r\n\r\n(1) 位于CPU与主存之间，是存储器层次结构中级别最高的一级。\r\n\r\n(2) 容量比主存小，目前一般有数KB到数MB。\r\n\r\n(3) 速度一般比主存快5~10倍，通常由存储速度高的双极型三极管或SRAM组成。\r\n\r\n(4) 其容量是主存的部分副本。\r\n\r\n(5) 可用来存放指令，也可用来存放数据。\r\n\r\n(6) 快存的功能全部由硬件实现，并对程序员透明。');
INSERT INTO `application_question` VALUES (10009, '计算机组成原理', '存储器的主要功能是什么？为什么要把存储系统分成若干个不同层次？主要有哪些层次？', '', NULL, 10, 5, '存储器的主要功能是用来保存程序和数据。存储系统是由几个容量、速度和价格各不相同的存储器用硬件、软件以及硬件与软件相结合的方法连接起来的系统。把存储系统分成若干个不同层次的目的是为了解决存储容量、存取速度和价格之间的矛盾。由高速缓冲存储器、主存储器和辅助存储器构成的三级存储系统可以分为两个层次，其中高速缓冲和主存间称为Cache－主存存储层次（Cache存储系统）；主存和辅存间称为主存－辅存存储层次（虚拟存储系统）');
INSERT INTO `application_question` VALUES (10010, '计算机组成原理', ' 微程序控制的基本思想是什么？', '', NULL, 10, 5, '微程序控制技术在现今计算机设计中得到广泛的采用，其实质是用程序设计的思想方法来组织操作控制逻辑。');
INSERT INTO `application_question` VALUES (10011, '计算机组成原理', ' 指令和数据都存放在主存，如何识别从主存储器中取出的是指令还是数据？', '', NULL, 10, 5, '指令和数据都存放在主存，它们都以二进制代码形式出现，区分的方法为：\r\n\r\n（1）取指令或数据时所处的机器周期不同：取指周期取出的是指令；分析、取数或执行周期取出的是数据。\r\n\r\n（2）取指令或数据时地址的来源不同：指令地址来源于程序计算器；数据地址来源于地址形成部件。');
INSERT INTO `application_question` VALUES (10012, '计算机组成原理', '说明总线结构对计算机系统性能的影响。', '', NULL, 10, 5, '主要影响有以下三方面：\r\n\r\n（1）最大存储容量\r\n\r\n单总线系统中，最大内存容量必须小于由计算机字长所决定的可能地址总线。\r\n\r\n双总线系统中，存储容量不会受到外围设备数量的影响\r\n\r\n（2）指令系统\r\n\r\n双总线系统，必须有专门的I/O指令系统\r\n\r\n单总线系统，访问内存和I/O使用相同指令 ');
INSERT INTO `application_question` VALUES (10013, '测试加题', '测试', '测试', '测试', 10, 3, '答案');
INSERT INTO `application_question` VALUES (10014, '测试加题', '测试', '测试', '测试', 10, 1, '答案');
INSERT INTO `application_question` VALUES (10015, '测试加题', '测试题干', '测试', '测试', 10, 1, '答案');
INSERT INTO `application_question` VALUES (10016, '测试加题', '测试题干', '测试', '测试', 10, 2, '答案');
INSERT INTO `application_question` VALUES (10017, '测试加题', '测试题干', '测试', '测试', 10, 3, '答案');
INSERT INTO `application_question` VALUES (10018, '测试加题', '测试题干', '测试', '测试', 10, 4, '答案');
INSERT INTO `application_question` VALUES (10019, '测试加题', '测试题干', '测试', '测试', 10, 5, '答案');
INSERT INTO `application_question` VALUES (10020, '测试加题', '测试题干', '测试', '测试', 10, 1, '答案');
INSERT INTO `application_question` VALUES (10021, '测试加题', '测试题干', '测试', '测试', 10, 2, '答案');
INSERT INTO `application_question` VALUES (10022, '测试加题', '测试题干', '测试', '测试', 10, 3, '答案');
INSERT INTO `application_question` VALUES (10023, '测试加题', '测试题干', '测试', '测试', 10, 4, '答案');
INSERT INTO `application_question` VALUES (10024, '测试加题', '测试题干', '测试', '测试', 10, 5, '答案');
INSERT INTO `application_question` VALUES (10025, '测试加题', '测试题干', '测试', '测试', 10, 1, '答案');
INSERT INTO `application_question` VALUES (10026, '测试加题', '测试题干', '测试', '测试', 10, 2, '答案');
INSERT INTO `application_question` VALUES (10027, '测试加题', '测试题干', '测试', '测试', 10, 3, '答案');
INSERT INTO `application_question` VALUES (10028, '测试加题', '测试题干', '测试', '测试', 10, 4, '答案');
INSERT INTO `application_question` VALUES (10029, '测试加题', '测试题干', '测试', '测试', 10, 5, '答案');

-- ----------------------------
-- Table structure for choose_question
-- ----------------------------
DROP TABLE IF EXISTS `choose_question`;
CREATE TABLE `choose_question`  (
  `questionId` int(0) NOT NULL AUTO_INCREMENT COMMENT '试题编号',
  `subject` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '考试科目',
  `question` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '问题题目',
  `ansA` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '选项A',
  `ansB` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '选项B',
  `ansC` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '选项C',
  `ansD` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '选项D',
  `rightAns` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '正确答案',
  `analysis` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '题目解析',
  `mark` int(0) NULL DEFAULT 2 COMMENT '分数',
  `chapter` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '所属章节',
  `difficulty` int(0) NULL DEFAULT NULL COMMENT '难度等级',
  PRIMARY KEY (`questionId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10091 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '选择题题库表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of choose_question
-- ----------------------------
INSERT INTO `choose_question` VALUES (10000, '计算机网络', 'DNS 服务器和DHCP服务器的作用是（）', '将IP地址翻译为计算机名，为客户机分配IP地址', '将IP地址翻译为计算机名、解析计算机的MAC地址', '将计算机名翻译为IP地址、为客户机分配IP地址', '将计算机名翻译为IP地址、解析计算机的MAC地址', 'C', NULL, 2, '应用层', 2);
INSERT INTO `choose_question` VALUES (10001, '计算机网络', 'HTTP协议通常使用什么协议进行传输（）', 'ARP', 'DHCP', 'UDP', 'TCP', 'D', NULL, 2, '应用层', 2);
INSERT INTO `choose_question` VALUES (10003, '计算机网络', '查看DNS缓存记录的命令（）', 'ipconfig/displaydns', 'nslookup', 'ipconfig/release', 'ipconfig/flushdns', 'A', NULL, 2, '应用层', 3);
INSERT INTO `choose_question` VALUES (10004, '计算机网络', 'DHCP(        )报文的目的IP地址为255.255.255.255', 'DhcpDisover', 'DhcpOffer', 'DhcpAck', 'DhcpNack', 'A', NULL, 2, '应用层', 2);
INSERT INTO `choose_question` VALUES (10005, '计算机网络', '下列地址中，（  ）不是DHCP服务器分配的IP地址', '196.254.109.100', '169.254.12.42', '69.254.48.45', '96.254.54.15', 'B', NULL, 2, '应用层', 2);
INSERT INTO `choose_question` VALUES (10006, '计算机网络', 'DHCP通常可以为客户端自动配置哪些网络参数（）', 'IP，掩码，网关，DNS', 'IP，掩码，域名，SMTP', '网关，掩码，浏览器，FTP', 'IP，网关，DNS，服务器', 'A', NULL, 2, '应用层', 2);
INSERT INTO `choose_question` VALUES (10007, '计算机网络', 'DNS服务器在名称解析过程中正确的查询顺序为（）', '本地缓存记录→区域记录→转发域名服务器→根域名服务器', '区域记录→本地缓存记录→转发域名服务器→根域名服务器', '本地缓存记录→区域记录→根域名服务器→转发域名服务器', '区域记录→本地缓存记录→根域名服务器→转发域名服务器', 'A', NULL, 2, '应用层', 3);
INSERT INTO `choose_question` VALUES (10008, '计算机网络', '在TCP/IP协议中，序号小于（  ）的端口称为熟知端口(well-known port)。', '1024', '64', '256', '128', 'A', NULL, 2, '传输层', 1);
INSERT INTO `choose_question` VALUES (10009, '计算机网络', '在Internet上用TCP/IP播放视频，想用传输层的最快协议，以减少时延，要使用（ ）', 'UDP协议的低开销特性', 'UDP协议的高开销特性', 'TCP协议的低开销特性', 'TCP协议的高开销特性', 'A', NULL, 2, '传输层', 2);
INSERT INTO `choose_question` VALUES (10010, '计算机网络', '在TCP协议中采用（ ）来区分不同的应用进程', '端口号', 'IP地址', '协议类型', 'MAC地址', 'A', NULL, 2, '传输层', 3);
INSERT INTO `choose_question` VALUES (10011, '计算机网络', '可靠的传输协议中的“可靠”指的是（ ）', '使用面向连接的会话', '使用“尽力而为”的传输', '使用滑动窗口来维持可靠性', '使用确认重传机制来确保传输的数据不丢失', 'D', NULL, 2, '传输层', 2);
INSERT INTO `choose_question` VALUES (10012, '计算机网络', '假设拥塞窗口为50KB，接收窗口为80KB，TCP能够发送的最大字节数为（ ）', '50KB', '80KB', '130KB', '30KB', 'A', NULL, 2, '传输层', 4);
INSERT INTO `choose_question` VALUES (10013, '计算机网络', '主机A向主机B发送一个（SYN=1，seq=2000）的TCP报文，期望与主机B建立连接，若主机B接受连接请求，则主机B发送的正确有TCP报文可能是（ ）', '（SYN=0,ACK=0,seq=2001,ack=2001）', '（SYN=1,ACK=1,seq=2000,ack=2000）', '（SYN=1,ACK=1,seq=2001,ack=2001）', '（SYN=0,ACK=1,seq=2000,ack=2000）', 'C', NULL, 2, '传输层', 2);
INSERT INTO `choose_question` VALUES (10014, '计算机网络', '主机A向主机B连续发送了两个TCP报文段，其序号分别为70和100。试问： （1）第一个报文段携带了（）个字节的数据？', ' 70', '30', '100', '170', 'B', NULL, 2, '传输层', 3);
INSERT INTO `choose_question` VALUES (10015, '计算机网络', 'PCM脉码调制的过程（ ）', '采样、量化、编码', '量化、编码、采样', '编码、量化、采样', '采样、编码、量化', 'A', NULL, 2, '物理层', 4);
INSERT INTO `choose_question` VALUES (10016, '计算机网络', '若某采用4相位调制的通信链路的数据传输速率为2400bps，则该链路的波特率为（）', '600Baud', '1200Baud', '4800Baud', '9600Baud', 'B', NULL, 2, '物理层', 1);
INSERT INTO `choose_question` VALUES (10017, '计算机网络', '以下关于数据传输速率的描述中，错误的是( )', '数据传输速率表示每秒钟传输构成数据代码的二进制比特数', '对于二进制数据，数据传输速率为S=1/T (bps)', '常用的数据传输速率单位有: 1Mbps=1.024×106bps', '数据传输速率是描述数据传输系统性能的重要技术指标之一', 'C', NULL, 2, '物理层', 2);
INSERT INTO `choose_question` VALUES (10018, '计算机网络', '以下关于时分多路复用概念的描述中，错误的是.(  ).', '时分多路复用将线路使用的时间分成多个时间片', '时分多路复用分为同步时分多路复用与统计时分多路复用', '时分多路复用使用“帧”与数据链路层“帧”的概念、作用是不同的', '统计时分多路复用将时间片预先分配给各个信道', 'D', NULL, 2, '物理层', 2);
INSERT INTO `choose_question` VALUES (10019, '计算机网络', '1000BASE-T标准支持的传输介质是（）', '双绞线', '同轴电缆', '光纤', '无线电', 'A', NULL, 2, '物理层', 1);
INSERT INTO `choose_question` VALUES (10020, '计算机网络', '一个以太网交换机，读取整个数据帧，对数据帧进行差错校验后再转发出去，这种交换方式称为 （）', '直通交换', '无碎片交换', '无差错交换', '存储转发交换', 'D', NULL, 2, '数据链路层', 2);
INSERT INTO `choose_question` VALUES (10021, '计算机网络', '关于VLAN，下面的描述中正确的是（）', '一个新的交换机没有配置VLAN', '通过配置VLAN减少了冲突域的数量', '一个VLAN不能跨越多个交换机', '各个VLAN属于不同的广播域', 'D', NULL, 2, '数据链路层', 2);
INSERT INTO `choose_question` VALUES (10022, '计算机网络', '以太网协议中使用物理地址作用是什么？', '.用于不同子网中的主机进行通信', '作为第二层设备的唯一标识', '用于区别第二层第三层的协议数据单元', '保存主机可检测未知的远程设备', 'B', NULL, 2, '数据链路层', 2);
INSERT INTO `choose_question` VALUES (10023, '计算机网络', '以太网采用的CSMA/CD协议，当冲突发生时要通过二进制指数后退算法计算后退延时， 关于这个算法，以下论述中错误的是 （）', '冲突次数越多，后退的时间越短', '平均后退次数的多少与负载大小有关', '后退时延的平均值与负载大小有关', '重发次数达到一定极限后放弃发送', 'A', NULL, 2, '数据链路层', 3);
INSERT INTO `choose_question` VALUES (10024, '计算机网络', '以下关于交换机获取与其端口连接设备的MAC地址的叙述中，正确的是（）', '交换机从路由表中提取设备的MAC地址', '交换机检查端口流入分组的源地址', '交换机之间互相交换地址表', '网络管理员手工输入设备的MAC地址', 'B', NULL, 2, '数据链路层', 2);
INSERT INTO `choose_question` VALUES (10025, '计算机网络', '如果G (x）为11010010，以下4个CRC校验比特序列中只有哪个可能是正确的 ？', '1101011001', '101011011', '11011011', '1011001', 'B', NULL, 2, '数据链路层', 1);
INSERT INTO `choose_question` VALUES (10026, '计算机网络', '以下关于Ethernet物理地址的描述中，错误的是', 'Ethernet物理地址又叫做MAC地址', '48位的Ethernet物理地址允许分配的地址数达到247个', '网卡的物理地址写入主机的EPROM中', '每一块网卡的物理地址在全世界是唯一的', 'C', NULL, 2, '数据链路层', 3);
INSERT INTO `choose_question` VALUES (10027, '计算机网络', '下列帧类型中，不属于HDLC帧类型的是（）', '信息帧', '确认帧', '监控帧', '无编号帧', 'B', NULL, 2, '数据链路层', 1);
INSERT INTO `choose_question` VALUES (10028, '计算机网络', '通过交换机连接的一组站点，关于它们的广播域和冲突域说法正确的是（）', '组成一个冲突域，但不是一个广播域', '组成一个广播域，但不是一个冲突域', '组成一个冲突域，也是一个广播域', '既不一个冲突域，也不是一个广播域', 'B', NULL, 2, '数据链路层', 3);
INSERT INTO `choose_question` VALUES (10029, '计算机网络', '数据链路层的数据单位是（）', '帧', '字节', '比特', '分组', 'A', NULL, 2, '数据链路层', 1);
INSERT INTO `choose_question` VALUES (10030, '计算机网络', 'LAN参考模型可分为物理层、（ ）', 'MAC，LLC等三层', 'LLC，MHS等三层', 'MAC，FTAM等三层', 'LLC，VT等三层', 'A', NULL, 2, '数据链路层', 3);
INSERT INTO `choose_question` VALUES (10031, '测试', '测试', 'A', 'B', 'C', 'D', 'B', '解析', 2, '测试', 4);
INSERT INTO `choose_question` VALUES (10032, '计算机网络', 'DNS 服务器和DHCP服务器的作用是（）', 'A', 'B', 'C', 'D', 'B', '哦解析', 2, '网络层', 2);
INSERT INTO `choose_question` VALUES (10033, '计算机网络', '测试', 'a', 'b', 'c', 'd', NULL, '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10037, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10039, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 1);
INSERT INTO `choose_question` VALUES (10040, '测试加题', '测试', '测试', '答案', '测试', '测试', 'B', '测试', 2, '测试', 1);
INSERT INTO `choose_question` VALUES (10041, '测试加题', '测试', '测试', '测试', '答案', '测试', 'C', '测试', 2, '测试', 1);
INSERT INTO `choose_question` VALUES (10042, '测试加题', '测试', '测试', '测试', '测试', '答案', 'D', '测试', 2, '测试', 1);
INSERT INTO `choose_question` VALUES (10043, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10044, '测试加题', '测试', '测试', '答案', '测试', '测试', 'B', '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10045, '测试加题', '测试', '测试', '测试', '答案', '测试', 'C', '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10046, '测试加题', '测试', '测试', '测试', '测试', '答案', 'D', '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10047, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 5);
INSERT INTO `choose_question` VALUES (10048, '测试加题', '测试', '测试', '答案', '测试', '测试', 'B', '测试', 2, '测试', 5);
INSERT INTO `choose_question` VALUES (10049, '测试加题', '测试', '测试', '测试', '答案', '测试', 'C', '测试', 2, '测试', 5);
INSERT INTO `choose_question` VALUES (10050, '测试加题', '测试', '测试', '测试', '测试', '答案', 'D', '测试', 2, '测试', 5);
INSERT INTO `choose_question` VALUES (10051, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 2);
INSERT INTO `choose_question` VALUES (10052, '测试加题', '测试', '测试', '答案', '测试', '测试', 'B', '测试', 2, '测试', 2);
INSERT INTO `choose_question` VALUES (10053, '测试加题', '测试', '测试', '测试', '答案', '测试', 'C', '测试', 2, '测试', 2);
INSERT INTO `choose_question` VALUES (10054, '测试加题', '测试', '测试', '测试', '测试', '答案', 'D', '测试', 2, '测试', 2);
INSERT INTO `choose_question` VALUES (10055, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 4);
INSERT INTO `choose_question` VALUES (10056, '测试加题', '测试', '测试', '答案', '测试', '测试', 'B', '测试', 2, '测试', 4);
INSERT INTO `choose_question` VALUES (10057, '测试加题', '测试', '测试', '测试', '答案', '测试', 'C', '测试', 2, '测试', 4);
INSERT INTO `choose_question` VALUES (10058, '测试加题', '测试', '测试', '测试', '测试', '答案', 'D', '测试', 2, '测试', 4);
INSERT INTO `choose_question` VALUES (10059, '计算机组成原理', '完整的计算机系统应包括______。', '运算器、存储器和控制器', '外部设备和主机', '主机和实用程序', '配套的硬件设备和软件系统', 'D', '', 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10060, '计算机组成原理', '计算机系统中的存储器系统是指____。', 'RAM存储器', 'ROM存储器', '主存储器', '主存储器和外存储器', 'D', '', 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10061, '计算机组成原理', '冯·诺依曼机工作方式的基本特点是______。', ' 多指令流单数据流 ', '按地址访问并顺序执行指令', '堆栈操作', ' 存储器按内部选择地址', 'B', NULL, 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10062, '计算机组成原理', '下列说法中不正确的是___。', ' 任何可以由软件实现的操作也可以由硬件来实现', '固件就功能而言类似于软件，而从形态来说又类似于硬件', '在计算机系统的层次结构中，微程序级属于硬件级，其他四级都是软件级', '面向高级语言的机器是完全可以实现的', 'D', '', 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10063, '计算机组成原理', '在下列数中最小的数为____。', '(101001)2', ' (52)8', '(101001)BCD', '(233)16', 'C', '', 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10064, '计算机组成原理', '在下列数中最大的数为____。', '(10010101)2', ' (227)8', '(143)5', '(96)16', 'B', '', 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10065, '计算机组成原理', '在机器中，______的零的表示形式是唯一的。', ' 原码', '补码', '原码和反码', '反码', 'B', '', 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10066, '计算机组成原理', '针对8位二进制数，下列说法中正确的是______。', '–127的补码为10000000', '–127的反码等于0的移码', '+1的移码等于–127的反码', '0的补码等于–1的反码', 'B', '', 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10067, '计算机组成原理', '一个8位二进制整数采用补码表示，且由3个“1”和5个“0”组成，则最小值为____。', '–127', '-32', '-125', '-3', 'B', '', 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10068, '计算机组成原理', '计算机系统中采用补码运算的目的是为了____。', '与手工运算方式保持一致 ', ' 提高运算速度', '简化计算机的设计', ' 提高运算的精度', 'C', '', 2, '导论', 1);
INSERT INTO `choose_question` VALUES (10069, '冲厕所', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试章', 3);
INSERT INTO `choose_question` VALUES (10070, '冲厕所', '测试', '答案', '测试', '测试', '测试', 'A', '测试测试测试', 2, '擦拭', 1);
INSERT INTO `choose_question` VALUES (10071, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 1);
INSERT INTO `choose_question` VALUES (10072, '测试加题', '测试', '测试', '答案', '测试', '测试', 'B', '测试', 2, '测试', 2);
INSERT INTO `choose_question` VALUES (10073, '测试加题', '测试', '测试', '测试', '答案', '测试', 'C', '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10074, '测试加题', '测试', '测试', '测试', '测试', '答案', 'D', '测试', 2, '测试', 4);
INSERT INTO `choose_question` VALUES (10075, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 5);
INSERT INTO `choose_question` VALUES (10076, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 1);
INSERT INTO `choose_question` VALUES (10077, '测试加题', '测试', '测试', '答案', '测试', '测试', 'B', '测试', 2, '测试', 2);
INSERT INTO `choose_question` VALUES (10078, '测试加题', '测试', '测试', '测试', '答案', '测试', 'C', '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10079, '测试加题', '测试', '测试', '测试', '测试', '答案', 'D', '测试', 2, '测试', 4);
INSERT INTO `choose_question` VALUES (10080, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 5);
INSERT INTO `choose_question` VALUES (10081, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 1);
INSERT INTO `choose_question` VALUES (10082, '测试加题', '测试', '测试', '答案', '测试', '测试', 'B', '测试', 2, '测试', 2);
INSERT INTO `choose_question` VALUES (10083, '测试加题', '测试', '测试', '测试', '答案', '测试', 'C', '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10084, '测试加题', '测试', '测试', '测试', '测试', '答案', 'D', '测试', 2, '测试', 4);
INSERT INTO `choose_question` VALUES (10085, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 5);
INSERT INTO `choose_question` VALUES (10086, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 1);
INSERT INTO `choose_question` VALUES (10087, '测试加题', '测试', '测试', '答案', '测试', '测试', 'B', '测试', 2, '测试', 2);
INSERT INTO `choose_question` VALUES (10088, '测试加题', '测试', '测试', '测试', '答案', '测试', 'C', '测试', 2, '测试', 3);
INSERT INTO `choose_question` VALUES (10089, '测试加题', '测试', '测试', '测试', '测试', '答案', 'D', '测试', 2, '测试', 4);
INSERT INTO `choose_question` VALUES (10090, '测试加题', '测试', '答案', '测试', '测试', '测试', 'A', '测试', 2, '测试', 5);

-- ----------------------------
-- Table structure for correct_paper
-- ----------------------------
DROP TABLE IF EXISTS `correct_paper`;
CREATE TABLE `correct_paper`  (
  `correctId` int(0) NOT NULL AUTO_INCREMENT COMMENT '改卷编号',
  `examineeId` int(0) NULL DEFAULT NULL COMMENT '考生id',
  `examCode` int(0) NULL DEFAULT NULL COMMENT '考试id',
  `subject` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '科目',
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '题目',
  `appAnswer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用题考试答案',
  `referenceAns` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参考答案解析，协助老师改卷',
  `appMark` int(0) NULL DEFAULT NULL COMMENT '老师给分',
  `IsUpdate` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'yes:已更新 no:未更新',
  PRIMARY KEY (`correctId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1028 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of correct_paper
-- ----------------------------
INSERT INTO `correct_paper` VALUES (1018, 201915001, 20230001, '计算机网络', '测试', '我的回答我的回答\n我的回答\n我的回答\n我的回答我的回答\n我的回答我的回答', '答案', 8, 'yes');
INSERT INTO `correct_paper` VALUES (1019, 201915001, 20230001, '计算机网络', '长2km、数据传输率为10Mbps的基带总线LAN，信号传播速度为200m/μs，试计算：\r\n\r\n(1)1000比特的帧从发送开始到接收结束的最大时间是多少?\r\n\r\n(2)若两相距最远的站点在同一时刻发送数据，则经过多长时间两站发现冲突? ', '我的回答\n我的回答\n我的回答\n我的回答', '(1)1000bit/10Mbps+2000m/200(m/μs)=100μs+10μs=110μs\r\n\r\n(2)2000m/200(m/μs)=10μs', 6, 'yes');
INSERT INTO `correct_paper` VALUES (1020, 201915002, 20230001, '计算机网络', '测试', '我的大暗暗我的大暗暗\n我的大暗暗\n我的大暗暗\n我的大暗暗我的大暗暗\n我的大暗暗', '答案', 6, 'yes');
INSERT INTO `correct_paper` VALUES (1021, 201915002, 20230001, '计算机网络', '长2km、数据传输率为10Mbps的基带总线LAN，信号传播速度为200m/μs，试计算：\r\n\r\n(1)1000比特的帧从发送开始到接收结束的最大时间是多少?\r\n\r\n(2)若两相距最远的站点在同一时刻发送数据，则经过多长时间两站发现冲突? ', '我的大暗暗\n我的大暗暗\n我的大暗暗\n我的大暗暗\n我的大暗暗', '(1)1000bit/10Mbps+2000m/200(m/μs)=100μs+10μs=110μs\r\n\r\n(2)2000m/200(m/μs)=10μs', 2, 'yes');
INSERT INTO `correct_paper` VALUES (1022, 201915002, 20230016, '测试加题', '测试题干', '我的答案\n我的答案\n我的答案\n我的答案', '答案', 6, 'yes');
INSERT INTO `correct_paper` VALUES (1023, 201915002, 20230016, '测试加题', '测试题干', '我的答案\n我的答案\n我的答案\n我的答案\n我的答案', '答案', 6, 'yes');
INSERT INTO `correct_paper` VALUES (1024, 201915002, 20230001, '计算机网络', '测试', '我的答案\n我的答案我的答案\n我的答案\n我的答案', '答案', 3, 'yes');
INSERT INTO `correct_paper` VALUES (1025, 201915002, 20230001, '计算机网络', '长2km、数据传输率为10Mbps的基带总线LAN，信号传播速度为200m/μs，试计算：\r\n\r\n(1)1000比特的帧从发送开始到接收结束的最大时间是多少?\r\n\r\n(2)若两相距最远的站点在同一时刻发送数据，则经过多长时间两站发现冲突? ', '我的答案\n我的答案\n我的答案我的答案', '(1)1000bit/10Mbps+2000m/200(m/μs)=100μs+10μs=110μs\r\n\r\n(2)2000m/200(m/μs)=10μs', 6, 'yes');
INSERT INTO `correct_paper` VALUES (1026, 201915001, 20230001, '计算机网络', '测试', '我的回答我的回答\n我的回答\n我的回答', '答案', 7, 'yes');
INSERT INTO `correct_paper` VALUES (1027, 201915001, 20230001, '计算机网络', '长2km、数据传输率为10Mbps的基带总线LAN，信号传播速度为200m/μs，试计算：\r\n\r\n(1)1000比特的帧从发送开始到接收结束的最大时间是多少?\r\n\r\n(2)若两相距最远的站点在同一时刻发送数据，则经过多长时间两站发现冲突? ', '我的回答\n我的回答\n我的回答\n我的回答', '(1)1000bit/10Mbps+2000m/200(m/μs)=100μs+10μs=110μs\r\n\r\n(2)2000m/200(m/μs)=10μs', 4, 'yes');

-- ----------------------------
-- Table structure for examinee
-- ----------------------------
DROP TABLE IF EXISTS `examinee`;
CREATE TABLE `examinee`  (
  `examineeId` int(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `examineeName` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '姓名',
  `grade` varchar(4) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '年级',
  `major` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '专业',
  `clazz` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '班级',
  `academe` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '学院',
  `phoneNum` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '电话号码',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '电子邮件',
  `pwd` varchar(16) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '密码',
  `cardId` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '身份证号',
  `sex` int(0) NULL DEFAULT NULL COMMENT '性别',
  `part` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '2' COMMENT '角色(0管理员，1教师，2学生)',
  PRIMARY KEY (`examineeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 201915009 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '学生信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of examinee
-- ----------------------------
INSERT INTO `examinee` VALUES (201915001, '苏大强', '2019', '软件工程', '2', '信通学院', '15011710071', '670321727@qq.com', '123456', '44512119920202343X', 1, '2');
INSERT INTO `examinee` VALUES (201915002, '韩嘉娟', '2019', '软件工程', '2', '信通学院', '13585439532', 'gblw@163.com', '123456', '445121199902163221', 1, '2');
INSERT INTO `examinee` VALUES (201915003, '林楷狄', '2020', '计算机科学与技术', '2', '信通学院', '13658377857', '13658377857@sina.cn', '123456', '445121200002167788', 1, '2');
INSERT INTO `examinee` VALUES (201915004, '陈金祖', '2021', '衍生品设计', '1', '艺术学院', '15583829425', '15583829425@163.com', '123456', '445121200002169988', 0, '2');
INSERT INTO `examinee` VALUES (201915005, '黄冠冰', '2021', '网络工程', '1', '信通学院', '18734538457', '18734538457@163.com', '123456', '445121200002160102', 0, '2');
INSERT INTO `examinee` VALUES (201915006, '林子羊', '2015', '信息工程', '2', '信通学院', '15523619564', '15523619564@163.com', '123456', '500234199704022353', 1, '2');
INSERT INTO `examinee` VALUES (201915007, '删除他', '2019', '软件工程', '1', '信通学院', '19120557888', '19120557888@163.com', '111222', '44512120000216757X', 0, '2');
INSERT INTO `examinee` VALUES (201915008, '删除她', '2019', '软件工程', '2', '信通学院', '19120657892', '19120557888@163.com', '111222', '44512120000216757X', 1, '2');

-- ----------------------------
-- Table structure for fill_question
-- ----------------------------
DROP TABLE IF EXISTS `fill_question`;
CREATE TABLE `fill_question`  (
  `questionId` int(0) NOT NULL AUTO_INCREMENT COMMENT '试题编号',
  `subject` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '考试科目',
  `question` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '试题内容',
  `rightAns` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '正确答案',
  `analysis` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '题目解析',
  `mark` int(0) NULL DEFAULT 2 COMMENT '分数',
  `difficulty` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '难度等级',
  `chapter` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '所属章节',
  PRIMARY KEY (`questionId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10051 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '填空题题库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fill_question
-- ----------------------------
INSERT INTO `fill_question` VALUES (10000, '计算机网络', '从计算机网络系统组成的角度看，计算机网络可以分为()和()', '通信子网资源子网', NULL, 2, '3', NULL);
INSERT INTO `fill_question` VALUES (10001, '计算机网络', '收发电子邮件，属于ISO/OSI RM中 ()层的功能。', '应用', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10002, '计算机网络', '在TCP/IP层次模型中与OSI参考模型第四层相对应的主要协议有()和(),其中后者提供无连接的不可靠传输服', 'TCP（传输控制协议） UDP（用户数据报协议） ', NULL, 2, '2', NULL);
INSERT INTO `fill_question` VALUES (10003, '计算机网络', '计算机网络中常用的三种有线媒体是 (),()和 ()', '同轴电缆.双绞线 光纤', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10004, '计算机网络', '国内最早的四大网络包括原邮电部的ChinaNet. 原电子部的ChinaGBN. 教育部的()和中科院的CSTnet', 'CERnet (或中国教育科研网)', NULL, 2, '4', NULL);
INSERT INTO `fill_question` VALUES (10005, '计算机网络', '复盖一个国家，地区或几个洲的计算机网络称为()，在同一建筑或复盖几公里内范围的网络称为()，而介于两者之间的是()', ' 广域网       局域网     城域网', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10006, '计算机网络', 'Outlook等常用电子邮件软件接收邮件使用的协议是(),发送邮件时使用的协议是()', 'POP3    SMTP    ', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10007, '计算机网络', '通信系统中，称调制前的电信号为()信号，调制后的信号为调制信号', '基带', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10008, '计算机网络', '按照IPV4标准,IP地址205.3.127.13属于()类地址', 'C', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10009, '计算机网络', '计算机网络采用()技术，而传统电话网络则采用()技术', '分组交换电路交换', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10010, '计算机网络', '计算机内传输的信号是()，而公用电话系统的传输系统只能传输()', '数字信号模拟信号', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10011, '计算机网络', '通信系统中，称调制前的电信号为()，调制后的信号叫()。', '基带信号调制信号', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10012, '计算机网络', 'IP地址分()和()两个部分', '网络号主机号', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10013, '计算机网络', ' IP地址协议作网间网中()层协议，提供无连接的数据报传输机制，IP数据报也分为()和()两个部分', '网络报头数据区', NULL, 2, '2', NULL);
INSERT INTO `fill_question` VALUES (10014, '计算机网络', '()是一个简单的远程终端协议。', 'TELNET', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10015, '计算机网络', '在同一个系统内，相邻层之间交换信息的连接点称之为()，而低层模块向高层提供功能性的支持称之为()。', '接口服务', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10016, '计算机网络', 'Internet广泛使用的电子邮件传送协议是()', 'SMTP', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10017, '计算机网络', '按交换方式来分类，计算机网络可以分为电路交换网，  报文交换网  和()三种', '分组交换网', NULL, 2, '3', NULL);
INSERT INTO `fill_question` VALUES (10018, '计算机网络', 'Intranet分层结构包括网络、(),应用三个层次。', '服务', NULL, 2, '1', NULL);
INSERT INTO `fill_question` VALUES (10019, '计算机网络', 'WWW上的每一个网页都有一个独立的地址，这些地址称为  ()', '统一资源定位器/URL ', NULL, 2, '2', NULL);
INSERT INTO `fill_question` VALUES (10020, '计算机网络', '分组交换网中，附加信息用来在网络中进行路由选择、() 和流量控制', '差错纠正  ', NULL, 2, '4', NULL);
INSERT INTO `fill_question` VALUES (10021, '计算机网络', '根据IEEE802模型的标准将数据链路层划分为LLC子层和 ()子层。', ' MAC ', NULL, 2, '3', NULL);
INSERT INTO `fill_question` VALUES (10022, '计算机网络', '据交换的路由信息的不同，路由算法可以分为两大类：  ()  和链路状态算法', '距离向量算法', NULL, 2, '3', NULL);
INSERT INTO `fill_question` VALUES (10023, '计算机网络', '假定某信道受奈氏准则限制的最高码元速率为2000码元/秒。如果采用振幅调制，把码元的振幅划分为16个不同等级来传送，那么可以获得的数据率为 () b/s。', '80000 ', NULL, 2, '5', NULL);
INSERT INTO `fill_question` VALUES (10024, '计算机网络', '交换型以太网系统中的 ()  ，以其为核心联接站点或者网段，端口之间帧的输入和输出已不再受到CSMA/CD媒体访问控制协议的约束。', '以太网交换器 ', NULL, 2, '5', NULL);
INSERT INTO `fill_question` VALUES (10025, '计算机网络', '局域网络参考模型是以 ()标准为基础的', 'IEEE802', NULL, 2, '5', NULL);
INSERT INTO `fill_question` VALUES (10026, '计算机网络', '路由器的核心是 () 。', ' 路由表', NULL, 2, '3', NULL);
INSERT INTO `fill_question` VALUES (10027, '计算机网络', '若 HDLC 帧数据段中出现比特串“ 01011111110 ”，则比特填充后的输出为()', '10111110110', NULL, 2, '5', NULL);
INSERT INTO `fill_question` VALUES (10028, '计算机网络', '数字调制的三种基本形式：移幅键控法ASK、 ()、移相键控法PSK', '移频键控法FSK', NULL, 2, '5', NULL);
INSERT INTO `fill_question` VALUES (10029, '测试加题', '测试()', '答案', '解析', 2, '2', '测试');
INSERT INTO `fill_question` VALUES (10030, '测试加题', '测试()', '答案', '测试', 2, '2', '测试');
INSERT INTO `fill_question` VALUES (10031, '测试加题', '测试()', '答案', '解析', 2, '1', '测试');
INSERT INTO `fill_question` VALUES (10032, '测试加题', '测试()', '答案', '解析', 2, '1', '测试');
INSERT INTO `fill_question` VALUES (10033, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '1', '测试');
INSERT INTO `fill_question` VALUES (10034, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '1', '测试');
INSERT INTO `fill_question` VALUES (10035, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '2', '测试');
INSERT INTO `fill_question` VALUES (10036, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '2', '测试');
INSERT INTO `fill_question` VALUES (10037, '测试加题', '测试()', '答案', '解析', 2, '3', '测试');
INSERT INTO `fill_question` VALUES (10038, '测试加题', '测试()', '答案', '解析', 2, '3', '测试');
INSERT INTO `fill_question` VALUES (10039, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '3', '测试');
INSERT INTO `fill_question` VALUES (10040, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '3', '测试');
INSERT INTO `fill_question` VALUES (10041, '测试加题', '测试()', '答案', '解析', 2, '4', '测试');
INSERT INTO `fill_question` VALUES (10042, '测试加题', '测试()', '答案', '解析', 2, '4', '测试');
INSERT INTO `fill_question` VALUES (10043, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '4', '测试');
INSERT INTO `fill_question` VALUES (10044, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '4', '测试');
INSERT INTO `fill_question` VALUES (10045, '测试加题', '测试()', '答案', '解析', 2, '5', '测试');
INSERT INTO `fill_question` VALUES (10046, '测试加题', '测试()', '答案', '解析', 2, '5', '测试');
INSERT INTO `fill_question` VALUES (10047, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '5', '测试');
INSERT INTO `fill_question` VALUES (10048, '测试加题', '测试()测试()', '答案 答案', '解析', 2, '5', '测试');
INSERT INTO `fill_question` VALUES (10049, '冲厕所', '测试()', '答案', '测试', 2, '4', '测试章');
INSERT INTO `fill_question` VALUES (10050, '冲厕所', '测试()()', '测试', '测试', 2, '3', '测试');

-- ----------------------------
-- Table structure for judge_question
-- ----------------------------
DROP TABLE IF EXISTS `judge_question`;
CREATE TABLE `judge_question`  (
  `questionId` int(0) NOT NULL AUTO_INCREMENT COMMENT '试题编号',
  `subject` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '考试科目',
  `question` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '试题内容',
  `rightAns` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '正确答案',
  `analysis` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '题目解析',
  `mark` int(0) NULL DEFAULT 2 COMMENT '分数',
  `difficulty` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '难度等级',
  `chapter` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '所属章节',
  PRIMARY KEY (`questionId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10028 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '判断题题库表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of judge_question
-- ----------------------------
INSERT INTO `judge_question` VALUES (10001, '计算机网络', '与有线网相比,无线网的数据传输率一般相对较慢', 'T', NULL, 2, '1', '');
INSERT INTO `judge_question` VALUES (10002, '计算机网络', 'OSI参考模型中,不同节点的同等层具有不同的功能', 'F', NULL, 2, '1', NULL);
INSERT INTO `judge_question` VALUES (10003, '计算机网络', '普通电脑不能作为服务器', 'F', NULL, 2, '1', NULL);
INSERT INTO `judge_question` VALUES (10004, '计算机网络', '没有网线的电脑不能连入互联网', 'F', NULL, 2, '1', NULL);
INSERT INTO `judge_question` VALUES (10005, '计算机网络', '网卡必须安装驱动程序', 'T', NULL, 2, '2', NULL);
INSERT INTO `judge_question` VALUES (10006, '计算机网络', 'UTP为屏蔽双绞线', 'F', NULL, 2, '2', NULL);
INSERT INTO `judge_question` VALUES (10007, '计算机网络', '网络接口卡又称为网卡,它是构成网络的基本部件', 'T', NULL, 2, '2', NULL);
INSERT INTO `judge_question` VALUES (10008, '计算机网络', '无线AP可以成倍地扩展网络覆盖范围', 'T', NULL, 2, '3', NULL);
INSERT INTO `judge_question` VALUES (10009, '计算机网络', 'SMTP是一组用于由源地址到目的地址传送邮件的协议', 'T', NULL, 2, '4', NULL);
INSERT INTO `judge_question` VALUES (10010, '计算机网络', '任务管理器可以关闭所有的进程', 'F', NULL, 2, '3', NULL);
INSERT INTO `judge_question` VALUES (10011, '计算机网络', '利用BT下载时,用户越多,下载速度越快', 'T', NULL, 2, '2', NULL);
INSERT INTO `judge_question` VALUES (10012, '计算机网络', 'INTERNET上向朋友发送电子邮件,必须知道对方的真实姓名和家庭住址', 'F', NULL, 2, '1', NULL);
INSERT INTO `judge_question` VALUES (10013, '测试加题', '测试题目T', 'T', '测试', 2, '3', '测试');
INSERT INTO `judge_question` VALUES (10014, '测试加题', '测试题目T', 'T', '测试', 2, '1', '测试');
INSERT INTO `judge_question` VALUES (10015, '测试加题', '测试题目F', 'F', '测试', 2, '1', '测试');
INSERT INTO `judge_question` VALUES (10016, '测试加题', '测试题目T', 'T', '测试', 2, '2', '测试');
INSERT INTO `judge_question` VALUES (10017, '测试加题', '测试题目F', 'F', '测试', 2, '2', '测试');
INSERT INTO `judge_question` VALUES (10018, '测试加题', '测试题目T', 'T', '测试', 2, '3', '测试');
INSERT INTO `judge_question` VALUES (10019, '测试加题', '测试题目F', 'F', '测试', 2, '3', '测试');
INSERT INTO `judge_question` VALUES (10020, '测试加题', '测试题目T', 'T', '测试', 2, '4', '测试');
INSERT INTO `judge_question` VALUES (10021, '测试加题', '测试题目F', 'F', '测试', 2, '4', '测试');
INSERT INTO `judge_question` VALUES (10022, '测试加题', '测试题目T', 'T', '测试', 2, '5', '测试');
INSERT INTO `judge_question` VALUES (10023, '测试加题', '测试题目F', 'F', '测试', 2, '5', '测试');
INSERT INTO `judge_question` VALUES (10024, '测试加题', '测试题目T', 'T', '测试', 2, '1', '测试');
INSERT INTO `judge_question` VALUES (10025, '测试加题', '测试题目F', 'F', '测试', 2, '1', '测试');
INSERT INTO `judge_question` VALUES (10026, '测试加题', '测试题目T', 'T', '测试', 2, '2', '测试');
INSERT INTO `judge_question` VALUES (10027, '测试加题', '测试题目F', 'F', '测试', 2, '2', '测试');

-- ----------------------------
-- Table structure for manage_exam
-- ----------------------------
DROP TABLE IF EXISTS `manage_exam`;
CREATE TABLE `manage_exam`  (
  `examCode` int(0) NOT NULL AUTO_INCREMENT COMMENT '考试编号',
  `descriptions` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '该次考试介绍',
  `courseName` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '课程名称',
  `paperId` int(0) NULL DEFAULT NULL COMMENT '试卷编号',
  `examDate` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '考试日期',
  `examDeadline` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '考试截止日期',
  `duringTime` int(0) NULL DEFAULT NULL COMMENT '持续时长',
  `clazz` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '班级',
  `grade` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '年级',
  `term` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '学期',
  `major` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '专业',
  `academe` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '学院',
  `totalMark` int(0) NULL DEFAULT NULL COMMENT '总分',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '考试类型',
  `tips` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '考生须知',
  PRIMARY KEY (`examCode`, `examDate`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20230023 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '考试管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manage_exam
-- ----------------------------
INSERT INTO `manage_exam` VALUES (20230001, '2023学年度期末考试', '计算机网络', 1001, '2023-05-18', '2023-05-25', 60, '2', '2019', '1', '软件工程', '信通学院', 100, '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `manage_exam` VALUES (20230002, '2023学年度期末考试', '数据库理论', 1002, '2019-03-07', '2023-05-19', 90, '2', '2018', '2', '网络工程', '信通学院', 100, '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `manage_exam` VALUES (20230003, '2023学年度期末考试', '数据结构', 1003, '2019-02-27', '2023-05-25', 90, '1', '2017', '1', '软件工程', '信通学院', 100, '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `manage_exam` VALUES (20230005, '2023学年度期末考试', '计算机导论', 1004, '2019-03-14', '2023-05-25', 90, '1', '2021', '1', '计算机科学与技术', '信通学院', 100, '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `manage_exam` VALUES (20230006, '2023学年度期末考试', '软件工程', 1005, '2019-03-21', '2023-05-25', 120, '2', '2018', '1', '计算机科学与技术', '信通学院', 100, '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `manage_exam` VALUES (20230007, '2023学年度期末考试', '操作系统', 1006, '2019-03-13', '2023-05-25', 120, '2', '2018', '2', '计算机科学与技术', '信通学院', 100, '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `manage_exam` VALUES (20230008, '2023学年度期末考试', 'C语言', 1007, '2019-03-13', '2023-05-25', 120, '2', '2018', '1', '信息工程', '信通学院', 100, '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `manage_exam` VALUES (20230009, '2023学年度期末考试', '高等数学', 1008, '2019-03-07', '2023-05-01', 90, '2', '2019', '1', '软件工程', '信通学院', 100, '期末考试', '快乐千万条，学习第一条，平时不努力，考试两行泪。');
INSERT INTO `manage_exam` VALUES (20230010, '[测试]该考试已结束,但考过试了', '[测试]该考试已结束,但考过试了', 1014, '2023-05-01', '2023-05-04', 60, '2', '2019', NULL, '软件工程', '信通学院', 100, '期末考试', '无');
INSERT INTO `manage_exam` VALUES (20230014, '2023学年度期末考试', '苏龙波特考', 1010, '2023-04-02', '2023-05-01', 123, '1', '2020', NULL, '软件工程', '信通学院', 123, '闭卷', '无');
INSERT INTO `manage_exam` VALUES (20230016, '答辩用，测试自动组卷', '测试加题', 1011, '2023-04-29', '2023-05-25', 33, '2', '2019', '1', '软件工程', '信通学院', 120, '开卷', '别作弊');
INSERT INTO `manage_exam` VALUES (20230019, '[测试]该考试已结束', '[测试]该考试已结束', 1012, '2023-05-01', '2023-05-04', 60, '2', '2019', NULL, '软件工程', '信通学院', 100, '期末考试', '无');
INSERT INTO `manage_exam` VALUES (20230020, '[测试]用于删除的考试', '[测试]用于删除的考试', 1013, '2023-05-18', '2023-05-24', 60, '2', '2019', NULL, '软件工程', '信通学院', 100, '闭卷', '不要作弊！自主完成考试');
INSERT INTO `manage_exam` VALUES (20230022, '期末考试', '[测试未开始]不可考', 1015, '2023-05-31', '2023-06-01', 120, '2', '2019', NULL, '软件工程', '信通学院', 120, '期末考试', '无');

-- ----------------------------
-- Table structure for manage_paper
-- ----------------------------
DROP TABLE IF EXISTS `manage_paper`;
CREATE TABLE `manage_paper`  (
  `paperId` int(0) NULL DEFAULT NULL COMMENT '试卷编号',
  `questionType` int(0) NULL DEFAULT NULL COMMENT '题目类型(1是选择题 2是填空题 3是判断题 4是应用题)',
  `questionId` int(0) NULL DEFAULT NULL COMMENT '题目编号',
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用于去重',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 418 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '试卷管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manage_paper
-- ----------------------------
INSERT INTO `manage_paper` VALUES (1001, 1, 10013, 1);
INSERT INTO `manage_paper` VALUES (1001, 1, 10005, 2);
INSERT INTO `manage_paper` VALUES (1001, 1, 10001, 3);
INSERT INTO `manage_paper` VALUES (1001, 1, 10004, 4);
INSERT INTO `manage_paper` VALUES (1001, 1, 10000, 5);
INSERT INTO `manage_paper` VALUES (1001, 1, 10016, 6);
INSERT INTO `manage_paper` VALUES (1001, 1, 10032, 7);
INSERT INTO `manage_paper` VALUES (1001, 1, 10025, 8);
INSERT INTO `manage_paper` VALUES (1001, 1, 10030, 9);
INSERT INTO `manage_paper` VALUES (1001, 1, 10017, 10);
INSERT INTO `manage_paper` VALUES (1001, 1, 10027, 11);
INSERT INTO `manage_paper` VALUES (1001, 1, 10023, 12);
INSERT INTO `manage_paper` VALUES (1001, 1, 10009, 13);
INSERT INTO `manage_paper` VALUES (1001, 1, 10011, 14);
INSERT INTO `manage_paper` VALUES (1001, 2, 10017, 15);
INSERT INTO `manage_paper` VALUES (1001, 2, 10012, 16);
INSERT INTO `manage_paper` VALUES (1001, 2, 10004, 17);
INSERT INTO `manage_paper` VALUES (1001, 2, 10005, 18);
INSERT INTO `manage_paper` VALUES (1001, 2, 10003, 19);
INSERT INTO `manage_paper` VALUES (1001, 2, 10008, 20);
INSERT INTO `manage_paper` VALUES (1001, 2, 10020, 21);
INSERT INTO `manage_paper` VALUES (1001, 2, 10013, 22);
INSERT INTO `manage_paper` VALUES (1001, 2, 10006, 23);
INSERT INTO `manage_paper` VALUES (1001, 2, 10015, 24);
INSERT INTO `manage_paper` VALUES (1001, 3, 10002, 25);
INSERT INTO `manage_paper` VALUES (1001, 3, 10009, 26);
INSERT INTO `manage_paper` VALUES (1001, 3, 10003, 27);
INSERT INTO `manage_paper` VALUES (1001, 3, 10005, 28);
INSERT INTO `manage_paper` VALUES (1001, 3, 10004, 29);
INSERT INTO `manage_paper` VALUES (1001, 3, 10012, 30);
INSERT INTO `manage_paper` VALUES (1001, 3, 10011, 31);
INSERT INTO `manage_paper` VALUES (1001, 3, 10006, 32);
INSERT INTO `manage_paper` VALUES (1001, 3, 10008, 33);
INSERT INTO `manage_paper` VALUES (1001, 3, 10001, 34);
INSERT INTO `manage_paper` VALUES (1002, 1, 10000, 35);
INSERT INTO `manage_paper` VALUES (1002, 1, 10013, 36);
INSERT INTO `manage_paper` VALUES (1002, 1, 10014, 37);
INSERT INTO `manage_paper` VALUES (1002, 1, 10009, 38);
INSERT INTO `manage_paper` VALUES (1002, 2, 10017, 39);
INSERT INTO `manage_paper` VALUES (1002, 2, 10013, 40);
INSERT INTO `manage_paper` VALUES (1002, 2, 10012, 41);
INSERT INTO `manage_paper` VALUES (1002, 2, 10011, 42);
INSERT INTO `manage_paper` VALUES (1002, 3, 10009, 43);
INSERT INTO `manage_paper` VALUES (1002, 3, 10005, 44);
INSERT INTO `manage_paper` VALUES (1001, 1, 10014, 45);
INSERT INTO `manage_paper` VALUES (1001, 1, 10022, 49);
INSERT INTO `manage_paper` VALUES (1010, 1, 10027, 56);
INSERT INTO `manage_paper` VALUES (1010, 1, 10001, 57);
INSERT INTO `manage_paper` VALUES (1010, 1, 10025, 58);
INSERT INTO `manage_paper` VALUES (1010, 2, 10010, 59);
INSERT INTO `manage_paper` VALUES (1010, 2, 10023, 60);
INSERT INTO `manage_paper` VALUES (1010, 2, 10028, 61);
INSERT INTO `manage_paper` VALUES (1010, 3, 10010, 62);
INSERT INTO `manage_paper` VALUES (1010, 3, 10003, 63);
INSERT INTO `manage_paper` VALUES (1010, 3, 10001, 64);
INSERT INTO `manage_paper` VALUES (1010, 1, 10024, 65);
INSERT INTO `manage_paper` VALUES (1010, 1, 10006, 66);
INSERT INTO `manage_paper` VALUES (1010, 2, 10002, 68);
INSERT INTO `manage_paper` VALUES (1010, 2, 10020, 69);
INSERT INTO `manage_paper` VALUES (1010, 2, 10014, 70);
INSERT INTO `manage_paper` VALUES (1010, 3, 10008, 71);
INSERT INTO `manage_paper` VALUES (1010, 3, 10007, 73);
INSERT INTO `manage_paper` VALUES (1010, 1, 10016, 74);
INSERT INTO `manage_paper` VALUES (1010, 1, 10026, 75);
INSERT INTO `manage_paper` VALUES (1010, 1, 10029, 76);
INSERT INTO `manage_paper` VALUES (1010, 1, 10018, 77);
INSERT INTO `manage_paper` VALUES (1010, 1, 10023, 78);
INSERT INTO `manage_paper` VALUES (1010, 2, 10013, 79);
INSERT INTO `manage_paper` VALUES (1010, 2, 10027, 81);
INSERT INTO `manage_paper` VALUES (1010, 2, 10016, 82);
INSERT INTO `manage_paper` VALUES (1010, 2, 10017, 83);
INSERT INTO `manage_paper` VALUES (1010, 3, 10011, 85);
INSERT INTO `manage_paper` VALUES (1010, 3, 10004, 86);
INSERT INTO `manage_paper` VALUES (1010, 3, 10012, 88);
INSERT INTO `manage_paper` VALUES (1010, 1, 10030, 89);
INSERT INTO `manage_paper` VALUES (1010, 1, 10009, 90);
INSERT INTO `manage_paper` VALUES (1010, 1, 10008, 91);
INSERT INTO `manage_paper` VALUES (1010, 2, 10015, 92);
INSERT INTO `manage_paper` VALUES (1010, 3, 10009, 95);
INSERT INTO `manage_paper` VALUES (1010, 4, 10001, 98);
INSERT INTO `manage_paper` VALUES (1010, 4, 10002, 99);
INSERT INTO `manage_paper` VALUES (1001, 1, 10008, 108);
INSERT INTO `manage_paper` VALUES (1001, 1, 10024, 112);
INSERT INTO `manage_paper` VALUES (1001, 1, 10006, 113);
INSERT INTO `manage_paper` VALUES (1001, 4, 10013, 116);
INSERT INTO `manage_paper` VALUES (1001, 1, 10020, 117);
INSERT INTO `manage_paper` VALUES (1001, 4, 10005, 118);
INSERT INTO `manage_paper` VALUES (1012, 1, 10042, 267);
INSERT INTO `manage_paper` VALUES (1012, 1, 10039, 268);
INSERT INTO `manage_paper` VALUES (1012, 1, 10040, 269);
INSERT INTO `manage_paper` VALUES (1012, 1, 10041, 270);
INSERT INTO `manage_paper` VALUES (1012, 1, 10076, 271);
INSERT INTO `manage_paper` VALUES (1012, 1, 10051, 272);
INSERT INTO `manage_paper` VALUES (1012, 1, 10072, 273);
INSERT INTO `manage_paper` VALUES (1012, 1, 10052, 274);
INSERT INTO `manage_paper` VALUES (1012, 1, 10054, 275);
INSERT INTO `manage_paper` VALUES (1012, 1, 10082, 276);
INSERT INTO `manage_paper` VALUES (1012, 2, 10034, 277);
INSERT INTO `manage_paper` VALUES (1012, 2, 10033, 278);
INSERT INTO `manage_paper` VALUES (1012, 2, 10036, 279);
INSERT INTO `manage_paper` VALUES (1012, 2, 10029, 280);
INSERT INTO `manage_paper` VALUES (1012, 3, 10025, 281);
INSERT INTO `manage_paper` VALUES (1012, 3, 10014, 282);
INSERT INTO `manage_paper` VALUES (1012, 3, 10026, 283);
INSERT INTO `manage_paper` VALUES (1012, 3, 10016, 284);
INSERT INTO `manage_paper` VALUES (1012, 3, 10027, 285);
INSERT INTO `manage_paper` VALUES (1012, 4, 10026, 286);
INSERT INTO `manage_paper` VALUES (1012, 1, 10043, 287);
INSERT INTO `manage_paper` VALUES (1012, 1, 10088, 288);
INSERT INTO `manage_paper` VALUES (1012, 1, 10083, 289);
INSERT INTO `manage_paper` VALUES (1012, 1, 10046, 290);
INSERT INTO `manage_paper` VALUES (1012, 1, 10037, 291);
INSERT INTO `manage_paper` VALUES (1012, 1, 10055, 292);
INSERT INTO `manage_paper` VALUES (1012, 1, 10056, 293);
INSERT INTO `manage_paper` VALUES (1012, 1, 10058, 294);
INSERT INTO `manage_paper` VALUES (1012, 1, 10057, 295);
INSERT INTO `manage_paper` VALUES (1012, 1, 10079, 296);
INSERT INTO `manage_paper` VALUES (1012, 2, 10039, 297);
INSERT INTO `manage_paper` VALUES (1012, 2, 10037, 298);
INSERT INTO `manage_paper` VALUES (1012, 2, 10041, 299);
INSERT INTO `manage_paper` VALUES (1012, 2, 10043, 300);
INSERT INTO `manage_paper` VALUES (1012, 2, 10042, 301);
INSERT INTO `manage_paper` VALUES (1012, 3, 10013, 302);
INSERT INTO `manage_paper` VALUES (1012, 3, 10019, 303);
INSERT INTO `manage_paper` VALUES (1012, 3, 10021, 304);
INSERT INTO `manage_paper` VALUES (1012, 3, 10020, 305);
INSERT INTO `manage_paper` VALUES (1012, 4, 10023, 306);
INSERT INTO `manage_paper` VALUES (1012, 1, 10047, 307);
INSERT INTO `manage_paper` VALUES (1012, 1, 10048, 308);
INSERT INTO `manage_paper` VALUES (1012, 1, 10085, 309);
INSERT INTO `manage_paper` VALUES (1012, 1, 10080, 310);
INSERT INTO `manage_paper` VALUES (1012, 1, 10050, 311);
INSERT INTO `manage_paper` VALUES (1012, 1, 10090, 312);
INSERT INTO `manage_paper` VALUES (1012, 2, 10046, 313);
INSERT INTO `manage_paper` VALUES (1012, 3, 10022, 314);
INSERT INTO `manage_paper` VALUES (1012, 1, 10045, 315);
INSERT INTO `manage_paper` VALUES (1012, 1, 10044, 316);
INSERT INTO `manage_paper` VALUES (1012, 1, 10089, 317);
INSERT INTO `manage_paper` VALUES (1012, 1, 10084, 318);
INSERT INTO `manage_paper` VALUES (1013, 1, 10076, 319);
INSERT INTO `manage_paper` VALUES (1013, 1, 10040, 320);
INSERT INTO `manage_paper` VALUES (1013, 1, 10039, 321);
INSERT INTO `manage_paper` VALUES (1013, 1, 10041, 322);
INSERT INTO `manage_paper` VALUES (1013, 1, 10051, 323);
INSERT INTO `manage_paper` VALUES (1013, 1, 10052, 324);
INSERT INTO `manage_paper` VALUES (1013, 1, 10072, 325);
INSERT INTO `manage_paper` VALUES (1013, 1, 10053, 326);
INSERT INTO `manage_paper` VALUES (1013, 2, 10032, 327);
INSERT INTO `manage_paper` VALUES (1013, 2, 10031, 328);
INSERT INTO `manage_paper` VALUES (1013, 2, 10036, 329);
INSERT INTO `manage_paper` VALUES (1013, 2, 10029, 330);
INSERT INTO `manage_paper` VALUES (1013, 2, 10030, 331);
INSERT INTO `manage_paper` VALUES (1013, 3, 10015, 332);
INSERT INTO `manage_paper` VALUES (1013, 3, 10024, 333);
INSERT INTO `manage_paper` VALUES (1013, 3, 10027, 334);
INSERT INTO `manage_paper` VALUES (1013, 3, 10016, 335);
INSERT INTO `manage_paper` VALUES (1013, 4, 10021, 336);
INSERT INTO `manage_paper` VALUES (1014, 1, 10039, 337);
INSERT INTO `manage_paper` VALUES (1014, 1, 10071, 338);
INSERT INTO `manage_paper` VALUES (1014, 1, 10054, 339);
INSERT INTO `manage_paper` VALUES (1014, 1, 10052, 340);
INSERT INTO `manage_paper` VALUES (1014, 1, 10072, 341);
INSERT INTO `manage_paper` VALUES (1014, 2, 10032, 342);
INSERT INTO `manage_paper` VALUES (1014, 2, 10033, 343);
INSERT INTO `manage_paper` VALUES (1014, 2, 10030, 344);
INSERT INTO `manage_paper` VALUES (1014, 2, 10029, 345);
INSERT INTO `manage_paper` VALUES (1014, 2, 10036, 346);
INSERT INTO `manage_paper` VALUES (1014, 3, 10014, 347);
INSERT INTO `manage_paper` VALUES (1014, 3, 10015, 348);
INSERT INTO `manage_paper` VALUES (1014, 3, 10026, 349);
INSERT INTO `manage_paper` VALUES (1014, 3, 10016, 350);
INSERT INTO `manage_paper` VALUES (1014, 3, 10017, 351);
INSERT INTO `manage_paper` VALUES (1014, 4, 10021, 352);
INSERT INTO `manage_paper` VALUES (1011, 1, 10071, 373);
INSERT INTO `manage_paper` VALUES (1011, 1, 10076, 374);
INSERT INTO `manage_paper` VALUES (1011, 1, 10040, 375);
INSERT INTO `manage_paper` VALUES (1011, 1, 10041, 376);
INSERT INTO `manage_paper` VALUES (1011, 1, 10086, 377);
INSERT INTO `manage_paper` VALUES (1011, 1, 10051, 378);
INSERT INTO `manage_paper` VALUES (1011, 1, 10072, 379);
INSERT INTO `manage_paper` VALUES (1011, 1, 10053, 380);
INSERT INTO `manage_paper` VALUES (1011, 1, 10052, 381);
INSERT INTO `manage_paper` VALUES (1011, 1, 10077, 382);
INSERT INTO `manage_paper` VALUES (1011, 2, 10032, 383);
INSERT INTO `manage_paper` VALUES (1011, 2, 10031, 384);
INSERT INTO `manage_paper` VALUES (1011, 2, 10029, 385);
INSERT INTO `manage_paper` VALUES (1011, 2, 10030, 386);
INSERT INTO `manage_paper` VALUES (1011, 2, 10035, 387);
INSERT INTO `manage_paper` VALUES (1011, 3, 10025, 388);
INSERT INTO `manage_paper` VALUES (1011, 3, 10015, 389);
INSERT INTO `manage_paper` VALUES (1011, 3, 10016, 390);
INSERT INTO `manage_paper` VALUES (1011, 3, 10017, 391);
INSERT INTO `manage_paper` VALUES (1011, 3, 10027, 392);
INSERT INTO `manage_paper` VALUES (1011, 4, 10016, 393);
INSERT INTO `manage_paper` VALUES (1011, 1, 10043, 394);
INSERT INTO `manage_paper` VALUES (1011, 1, 10073, 395);
INSERT INTO `manage_paper` VALUES (1011, 1, 10083, 396);
INSERT INTO `manage_paper` VALUES (1011, 1, 10045, 397);
INSERT INTO `manage_paper` VALUES (1011, 1, 10037, 398);
INSERT INTO `manage_paper` VALUES (1011, 1, 10089, 399);
INSERT INTO `manage_paper` VALUES (1011, 1, 10084, 400);
INSERT INTO `manage_paper` VALUES (1011, 1, 10055, 401);
INSERT INTO `manage_paper` VALUES (1011, 1, 10074, 402);
INSERT INTO `manage_paper` VALUES (1011, 1, 10058, 403);
INSERT INTO `manage_paper` VALUES (1011, 2, 10037, 404);
INSERT INTO `manage_paper` VALUES (1011, 2, 10040, 405);
INSERT INTO `manage_paper` VALUES (1011, 2, 10044, 406);
INSERT INTO `manage_paper` VALUES (1011, 2, 10043, 407);
INSERT INTO `manage_paper` VALUES (1011, 2, 10042, 408);
INSERT INTO `manage_paper` VALUES (1011, 3, 10019, 409);
INSERT INTO `manage_paper` VALUES (1011, 3, 10013, 410);
INSERT INTO `manage_paper` VALUES (1011, 3, 10021, 411);
INSERT INTO `manage_paper` VALUES (1011, 3, 10020, 412);
INSERT INTO `manage_paper` VALUES (1011, 4, 10018, 413);
INSERT INTO `manage_paper` VALUES (1001, 1, 10029, 414);
INSERT INTO `manage_paper` VALUES (1001, 1, 10019, 415);
INSERT INTO `manage_paper` VALUES (1001, 1, 10021, 416);
INSERT INTO `manage_paper` VALUES (1001, 1, 10018, 417);

-- ----------------------------
-- Table structure for mark
-- ----------------------------
DROP TABLE IF EXISTS `mark`;
CREATE TABLE `mark`  (
  `markId` int(0) NOT NULL AUTO_INCREMENT COMMENT '分数编号',
  `examCode` int(0) NULL DEFAULT NULL COMMENT '考试编号',
  `examineeId` int(0) NULL DEFAULT NULL COMMENT '学号',
  `subject` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '课程名称',
  `ptMark` int(0) NULL DEFAULT NULL COMMENT '平时成绩',
  `objMark` int(0) NULL DEFAULT NULL COMMENT '客观题成绩',
  `subMark` int(0) NULL DEFAULT NULL COMMENT '主观题成绩',
  `mark` int(0) NULL DEFAULT NULL COMMENT '总成绩',
  `answerDate` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '答题日期',
  `markType` int(0) NULL DEFAULT NULL COMMENT '0表示不可重考，1则可以',
  PRIMARY KEY (`markId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '成绩管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mark
-- ----------------------------
INSERT INTO `mark` VALUES (4, 20190001, 201915004, '计算机网络', NULL, 70, NULL, NULL, '2019-04-03', 0);
INSERT INTO `mark` VALUES (14, 20190002, 201915004, '数据库理论', NULL, 78, NULL, NULL, '2019-04-20', 0);
INSERT INTO `mark` VALUES (15, 20190002, 201915004, '数据库理论', NULL, 80, NULL, NULL, '2019-04-20', 0);
INSERT INTO `mark` VALUES (16, 20190002, 201915004, '数据库理论', NULL, 83, 12, NULL, '2019-04-20', 1);
INSERT INTO `mark` VALUES (17, 20190001, 201915001, '计算机网络', NULL, 74, NULL, NULL, '2019-04-13', 0);
INSERT INTO `mark` VALUES (18, 20190001, 201915001, '计算机网络', NULL, 70, NULL, NULL, '2019-04-10', 0);
INSERT INTO `mark` VALUES (19, 20190001, 201915003, '计算机网络', NULL, 86, NULL, NULL, '2019-04-14', 0);
INSERT INTO `mark` VALUES (20, 20190001, 201915005, '计算机网络', NULL, 90, NULL, NULL, '2019-04-11', 0);
INSERT INTO `mark` VALUES (21, 20190001, 201915005, '计算机网络', NULL, 92, NULL, NULL, '2019-04-12', 1);
INSERT INTO `mark` VALUES (22, 20190001, 201915006, '计算机网络', NULL, 80, NULL, NULL, '2019-04-12', 0);
INSERT INTO `mark` VALUES (23, 20190001, 201915003, '计算机网络', NULL, 90, NULL, NULL, '2019-04-13', 0);
INSERT INTO `mark` VALUES (24, 20190001, 201915006, '计算机网络', NULL, 88, NULL, NULL, '2019-04-14', 1);
INSERT INTO `mark` VALUES (27, 20190001, 201915004, '计算机网络', NULL, 80, NULL, NULL, '2019-04-25', 0);
INSERT INTO `mark` VALUES (34, 20190014, 201915004, '苏龙波特考', NULL, 6, NULL, NULL, '2023-03-01', 0);
INSERT INTO `mark` VALUES (35, 20230001, 201915001, '计算机网络', NULL, 67, NULL, NULL, '2023-03-27', 0);
INSERT INTO `mark` VALUES (54, 20230001, 201915001, '计算机网络', NULL, 38, NULL, NULL, '2023-04-19', 0);
INSERT INTO `mark` VALUES (55, 20230001, 201915001, '计算机网络', NULL, 59, NULL, NULL, '2023-04-19', 0);
INSERT INTO `mark` VALUES (56, 20230001, 201915001, '计算机网络', NULL, 38, NULL, NULL, '2023-04-19', 0);
INSERT INTO `mark` VALUES (57, 20230001, 201915001, '计算机网络', NULL, 55, NULL, NULL, '2023-04-20', 0);
INSERT INTO `mark` VALUES (63, 20230016, 201915001, '测试加题', NULL, 72, NULL, NULL, '2023-04-21', 0);
INSERT INTO `mark` VALUES (64, 20230016, 201915001, '测试加题', NULL, 73, NULL, NULL, '2023-04-21', 0);
INSERT INTO `mark` VALUES (67, 20230016, 201915001, '测试加题', NULL, 60, NULL, NULL, '2023-05-10', 0);
INSERT INTO `mark` VALUES (68, 20230010, 201915001, '[测试]该考试已结束,但考过试了', NULL, 61, NULL, NULL, '2023-05-03', 1);
INSERT INTO `mark` VALUES (71, 20230020, 201915001, '[测试]用于删除的考试', NULL, 2, NULL, NULL, '2023-05-19', 1);
INSERT INTO `mark` VALUES (72, 20230001, 201915001, '计算机网络', NULL, 0, NULL, NULL, '2023-05-19', 0);
INSERT INTO `mark` VALUES (77, 20230001, 201915001, '计算机网络', NULL, 0, 11, NULL, '2023-05-20', 1);

-- ----------------------------
-- Table structure for secret_key
-- ----------------------------
DROP TABLE IF EXISTS `secret_key`;
CREATE TABLE `secret_key`  (
  `kid` int(0) NOT NULL AUTO_INCREMENT,
  `kCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '秘钥内容',
  `IsUsed` int(0) NOT NULL COMMENT '是否已经使用过 0：未使用 / 1:已使用',
  PRIMARY KEY (`kid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of secret_key
-- ----------------------------
INSERT INTO `secret_key` VALUES (1, '111', 0);
INSERT INTO `secret_key` VALUES (2, '222333444', 1);
INSERT INTO `secret_key` VALUES (3, '2134123', 0);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `teacherId` int(0) NOT NULL AUTO_INCREMENT,
  `teacherName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `academe` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` int(0) NULL DEFAULT NULL,
  `phoneNum` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pwd` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `part` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`teacherId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (20081001, '柳依依', '信通学院', 1, '15011332255', '123456@163.com', '123456', '讲师', 1);

-- ----------------------------
-- Triggers structure for table manage_paper
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_restrict_type1`;
delimiter ;;
CREATE TRIGGER `trigger_restrict_type1` BEFORE INSERT ON `manage_paper` FOR EACH ROW BEGIN
    DECLARE count INT;
    SELECT COUNT(*) INTO count FROM (
			SELECT 1 FROM manage_paper 
			WHERE paperId = NEW.paperId AND questionType = 1
			GROUP BY paperId
		) AS t;
    IF count >= 30 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exceeded maximum number of rows';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table manage_paper
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_restrict_type4`;
delimiter ;;
CREATE TRIGGER `trigger_restrict_type4` BEFORE INSERT ON `manage_paper` FOR EACH ROW BEGIN
    DECLARE count INT;
    SELECT COUNT(*) INTO count FROM (
			SELECT 1 FROM manage_paper 
			WHERE paperId = NEW.paperId AND questionType = 4
			GROUP BY paperId
		) AS t;
    IF count >= 2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exceeded maximum number of rows';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table manage_paper
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_restrict_type3`;
delimiter ;;
CREATE TRIGGER `trigger_restrict_type3` BEFORE INSERT ON `manage_paper` FOR EACH ROW BEGIN
    DECLARE count INT;
    SELECT COUNT(*) INTO count FROM (
			SELECT 1 FROM manage_paper 
			WHERE paperId = NEW.paperId AND questionType = 3
			GROUP BY paperId
		) AS t;
    IF count >= 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exceeded maximum number of rows';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table manage_paper
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_restrict_type2`;
delimiter ;;
CREATE TRIGGER `trigger_restrict_type2` BEFORE INSERT ON `manage_paper` FOR EACH ROW BEGIN
    DECLARE count INT;
    SELECT COUNT(*) INTO count FROM (
			SELECT 1 FROM manage_paper 
			WHERE paperId = NEW.paperId AND questionType = 2
			GROUP BY paperId
		) AS t;
    IF count >= 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Exceeded maximum number of rows';
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
