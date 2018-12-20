/**********
 * 千里之行购物网站数据库脚本
 *
 * author:zuxia
 * date: 06/21/2009
 **/

/*********建库*************/
use  master
go
if exists (select *  from  sysdatabases where name ='web')
drop  database web
go
create database qlzx
go

use qlzx
go

/***********建表及主要约束*****************/

-- 用户信息表（网站后台管理人员）
create table UserInfo
(
	id int identity primary key,	-- 用户编号
	userName varchar(20) not null unique,	-- 用户名称
	userPwd varchar(20) not null	-- 用户密码
)
go

-- 公告信息表
create table Bulletin
(
	id int identity primary key, --编号
	title varchar(100) not null,-- 标题
	content text,	--内容
	userId int not null references UserInfo(id), --发布者
	createTime datetime not null default getdate()	--发布时间
)
go

-- 客户信息表
create table CustomerInfo
(
	id int identity primary key,	-- 客户编号
	email varchar(100) not null unique,	-- 电子邮箱（客户账户名）
	pwd varchar(20) not null,	-- 密码
	registerTime datetime not null --注册时间
)
go

-- 客户详细信息表
create table CustomerDetailInfo
(
	customerId int primary key references CustomerInfo(id),	--客户编号
	[name] varchar(50) not null,	-- 收货人姓名
	telphone varchar(20) not null,	-- 固定电话
	movePhone varchar(20) not null,	-- 移动电话
	address varchar(100) not null	-- 收货地址
)
go

-- 商品类别
create table GoodsType
(
	typeId int identity primary key,	-- 类别编号
	typeName varchar(20) not null unique	-- 类别名称
)
go

-- 商品信息表
create table GoodsInfo
(
	goodsId int identity primary key,	-- 商品编号
	typeId int not null references GoodsType(typeId),	-- 商品类别
	goodsName varchar(50) not null,	-- 商品名称
	price decimal(8,2) not null default 0.0,	-- 商品价格
	discount float default 10.0, -- 折扣(默认不打折)
	isNew int not null,	-- 是否新品(0新品,1不是新品)
	isRecommend int not null,	-- 是否推荐（0推荐，1不推荐）
	status int not null, -- 商品状态（0上架，1下架）
	photo varchar(50), -- 商品图片
	remark varchar(200) -- 备注
)
go

-- 订单信息表
create table OrderInfo
(
	orderId int identity primary key,	-- 订单编号
	customerId int not null references CustomerInfo(id), -- 客户编号
	status int not null default 0, -- 订单状态（0未确认，1已确认）
	orderTime datetime not null --下订单的时间
)
go


-- 订单商品信息表
create table OrderGoodsInfo
(
	orderId int references OrderInfo(orderId), -- 订单编号
	goodsId int not null references GoodsInfo(goodsId),	-- 商品编号
	quantity int not null,	--商品数量
	primary key (orderId,goodsId) --联合主键约束
)
go




/****************插入测试数据***********************/

-- 插入管理员用户数据
insert into UserInfo values ('admin','123456')
insert into UserInfo values ('zhangsan','123456')
insert into UserInfo values ('lisi','123456')
go

-- 插入商品类型
insert into GoodsType values ('野营帐篷')
insert into GoodsType values ('睡袋垫子')
insert into GoodsType values ('户外桌椅')
insert into GoodsType values ('运动手表')
insert into GoodsType values ('野营用品')
insert into GoodsType values ('登山攀岩器材')
insert into GoodsType values ('户外服装')
go

-- 插入各类型下的商品

-- 帐篷
insert into GoodsInfo values (1,'ND-1182 双人双层帐（新款铝杆）',498.0,default,1,1,0,'zhangpeng1.jpg','双人双层帐（新款铝杆）。')
insert into GoodsInfo values (1,'ND-1133 三人双门帐篷(防紫外线涂银)',256.0,9.5,0,1,0,'zhangpeng2.jpg','三人双门帐篷(防紫外线涂银)。')
insert into GoodsInfo values (1,'ND-1132 三人帐篷(带遮阳蓬)',296.0,6.7,1,0,0,'zhangpeng3.jpg','三人双门帐篷(防紫外线涂银)。')
insert into GoodsInfo values (1,'ND-1136 四人双层帐',438.0,default,0,1,0,'zhangpeng4.jpg','四人双层帐(防紫外线涂银)。')
insert into GoodsInfo values (1,'ND-1121 双人双门帐篷(防紫外线涂银)',186.0,default,1,1,0,'zhangpeng5.jpg','双人双层帐(防紫外线涂银)。')
insert into GoodsInfo values (1,'ND-1009 六角纱网帐篷',680.0,default,1,0,0,'zhangpeng6.jpg','六角纱网帐篷')
insert into GoodsInfo values (1,'MOBI GARDEN牧高笛精灵2AIR 2人双层铝竿帐篷',642.0,default,1,0,0,'zhangpeng7.jpg','双层自动2秒帐篷。')
insert into GoodsInfo values (1,'多人双层铝杆帐篷',846.0,default,1,1,0,'zhangpeng8.jpg','双层自动2秒帐篷。')
insert into GoodsInfo values (1,'冷山3人双层铝杆帐篷',957.0,default,1,1,0,'zhangpeng9.jpg','双层自动2秒帐篷。')
insert into GoodsInfo values (1,'山籁3人双层铝杆帐篷',654.0,6.8,0,0,0,'zhangpeng10.jpg','双层自动2秒帐篷。')

-- 睡袋垫子
insert into GoodsInfo values (2,'ND-1327 蛋巢双层防潮垫',198.0,8.5,1,1,0,'dianzi1.jpg','野营系列')
insert into GoodsInfo values (2,'ND-1255L 信封睡袋(200g中空棉)',146.0,9.5,0,1,0,'shuidai1.jpg','野营系列')
insert into GoodsInfo values (2,'ND-1202 羽绒妈咪睡袋350克',296.0,6.7,1,0,0,'shuidai2.jpg','野营系列')
insert into GoodsInfo values (2,'爱菲碧尔斯500 羽绒睡袋',438.0,default,0,1,0,'shuidai5.jpg','野营系列')
insert into GoodsInfo values (2,'CHAMONIX334SOFT睡袋',186.0,default,1,1,0,'shuidai7.jpg','野营系列')
insert into GoodsInfo values (2,'CHAMONIX265超小睡袋',267.0,default,1,0,0,'shuidai8.jpg','野营系列')
insert into GoodsInfo values (2,'highrockS106107 萤火虫',467.0,6.5,1,0,0,'shuidai6.jpg','野营系列')
insert into GoodsInfo values (2,'highrockS4543 萤火虫',456.0,8.8,1,1,0,'shuidai9.jpg','野营系列')
go

-- 户外桌椅
insert into GoodsInfo values (3,'Featherf4005 木制折叠桌',198.0,8.5,1,1,0,'zuoyi2.jpg','野营系列')
insert into GoodsInfo values (3,'Featherf4007 蓝色圆角组合桌椅',146.0,9.5,0,0,0,'zuoyi1.jpg','野营系列')
go

-- 运动手表
insert into GoodsInfo values (4,'MAINNAV950DM 高精度GPS 码表',298.0,8.5,1,1,0,'biao1.jpg','野营系列')
insert into GoodsInfo values (4,'MAINNAV950D GPS户外运动表',286.0,default,0,0,0,'biao2.jpg','野营系列')
insert into GoodsInfo values (4,'SUUNTO D6 潜水系列橡胶表',358.0,8.5,1,1,0,'biao3.jpg','野营系列')
insert into GoodsInfo values (4,'SUUNTOt3c Black Polished黑色抛光 心率表',434.0,9.5,0,1,0,'biao10.jpg','野营系列')
insert into GoodsInfo values (4,'SUUNTO t3c Black without Belt黑 心率表色,无心率带',499.0,8.5,1,1,0,'biao7.jpg','野营系列')
insert into GoodsInfo values (4,'驱动之星A77心率表',564.0,9.5,0,1,0,'biao4.jpg','野营系列')
insert into GoodsInfo values (4,'风尚之星高精度表',532.0,default,1,0,0,'biao7.jpg','时尚系列')
insert into GoodsInfo values (4,'激尚之星高精度表',342.0,default,0,1,0,'biao9.jpg','时尚系列')
go

-- 野营用品
insert into GoodsInfo values (5,'ND-8629 背包防雨罩XL',198.0,8.5,1,1,0,'bao1.jpg','(60L-80L)')
insert into GoodsInfo values (5,'ND-8627 背包防雨罩M ',186.0,default,0,1,0,'bao2.jpg','(25L- 40L)')
insert into GoodsInfo values (5,'ND-8626 背包防雨罩S',99.0,default,1,1,0,'bao3.jpg','(25L以下)')
insert into GoodsInfo values (5,'ND-2129 小号挎包',121.0,9.5,0,1,0,'kuabao1.jpg','野营系列')
insert into GoodsInfo values (5,'ND-2125 腰包',43.0,default,1,0,0,'yaobao1.jpg','野营系列')
insert into GoodsInfo values (5,'ND-3211 腰包',34.0,9.5,0,1,0,'yaobao2.jpg','野营系列')
insert into GoodsInfo values (5,'ND-3210 急救包',59.0,9.5,0,1,0,'jijiubao1.jpg','野营系列')
insert into GoodsInfo values (5,'ND-2315 护脖',55.0,9.5,0,0,0,'maojing.jpg','野营系列')
insert into GoodsInfo values (5,'Featherf201 遮阳伞',532.0,default,1,1,0,'zheyangsan.jpg','遮阳伞')
insert into GoodsInfo values (5,'ND-3565 3+5LED头灯',89.0,default,0,1,0,'toudeng3.jpg','头灯')
insert into GoodsInfo values (5,'ND-3566 2+1X头灯',68.0,default,0,1,0,'toudeng2.jpg','头灯')
insert into GoodsInfo values (5,'ND-3565 3+5LED头灯',92.0,6.5,0,1,0,'toudeng3.jpg','头灯')
insert into GoodsInfo values (5,'ND-3613 1X手电(U40)',55.0,default,1,0,0,'shoudian1.jpg','手电')
insert into GoodsInfo values (5,'ND-3612 3LED手电(N35)',58.0,default,0,1,0,'shoudian2.jpg','手电')
insert into GoodsInfo values (5,'D-3611 1X手电(N30)',34.0,7.8,0,1,0,'shoudian3.jpg','手电')
go

-- 登山器材
insert into GoodsInfo values (6,'Edelrid1781 000 073 下降器',158.0,8.5,1,1,0,'xiajiangqi.jpg',' MINI 8 FIGURE OF 8')
insert into GoodsInfo values (6,'Edelrid1772 138 006 下降器',186.0,default,0,1,0,'xiajiangqi2.jpg',' PETIT 8 FIGURE OF 8')
insert into GoodsInfo values (6,'Edelrid1813 153 主锁 HMS GUITAR LOCK',68.0,default,1,1,0,'zhusuo1.jpg','登山系列')
insert into GoodsInfo values (6,'Edelrid1813 213 主锁 HMS GUITAR LOCK',84.0,9.5,0,1,0,'zhusuo2.jpg','登山系列')
insert into GoodsInfo values (6,'Edelrid1813 234 主锁 HMS GUITAR LOCK',99.0,3.5,1,1,0,'zhusuo3.jpg','登山系列')
go

-- 户外服装
insert into GoodsInfo values (7,'snowwolf女款步行者冲锋衣',298.0,8.5,1,1,0,'yi1.jpg',' MINI 8 FIGURE OF 8')
insert into GoodsInfo values (7,'snowwolf男款步行者冲锋衣',286.0,default,0,1,0,'yi2.jpg',' PETIT 8 FIGURE OF 8')
insert into GoodsInfo values (7,'snowwolf女款熏衣草冲锋衣',358.0,default,1,1,0,'yi3.jpg','野营系列')
insert into GoodsInfo values (7,'GARMONT ZEPHYR434 徒步鞋',265.0,9.5,0,1,0,'xie2.jpg','野营系列')
insert into GoodsInfo values (7,'GARMONT ZEPHYR546 徒步鞋',258.0,8.5,1,1,0,'xie3.jpg','野营系列')
insert into GoodsInfo values (7,'GARMONT Syncro GTX登山鞋',199.0,default,1,1,0,'xie4.jpg','野营系列')
go

-- 插入客户信息
insert into CustomerInfo values ('a@sina.com','123456','2009-06-06 12:30:45')
insert into CustomerInfo values ('b@sina.com','123456','2009-06-07 12:30:15')
insert into CustomerInfo values ('c@sina.com','123456','2009-06-08 12:30:25')
insert into CustomerInfo values ('d@sina.com','123456','2009-06-09 12:30:35')
go

insert into CustomerDetailInfo values (1,'张三','32456754','13534563234','重庆市沙坪坝区足下软件学院A区')
insert into CustomerDetailInfo values (2,'李斯','32456754','13534563234','重庆市沙坪坝区足下软件学院B区')
insert into CustomerDetailInfo values (3,'王五','32456754','13534563234','重庆市沙坪坝区足下软件学院C区')
go

-- 下订单
insert into OrderInfo values (1,0,getdate())
declare @orderId int
select @orderId=@@identity
insert into OrderGoodsInfo values (@orderId,53,1)
insert into OrderGoodsInfo values (@orderId,47,10)
insert into OrderGoodsInfo values (@orderId,48,1)
insert into OrderGoodsInfo values (@orderId,46,16)
insert into OrderGoodsInfo values (@orderId,44,10)
go

insert into OrderInfo values (2,0,getdate())
declare @orderId int
select @orderId=@@identity
insert into OrderGoodsInfo values (@orderId,15,1)
insert into OrderGoodsInfo values (@orderId,51,1)
insert into OrderGoodsInfo values (@orderId,19,1)
insert into OrderGoodsInfo values (@orderId,8,2)
insert into OrderGoodsInfo values (@orderId,43,1)
insert into OrderGoodsInfo values (@orderId,50,1)
insert into OrderGoodsInfo values (@orderId,16,1)
insert into OrderGoodsInfo values (@orderId,18,1)
insert into OrderGoodsInfo values (@orderId,54,3)
insert into OrderGoodsInfo values (@orderId,41,1)
insert into OrderGoodsInfo values (@orderId,53,4)
insert into OrderGoodsInfo values (@orderId,20,1)
insert into OrderGoodsInfo values (@orderId,52,1)
insert into OrderGoodsInfo values (@orderId,14,1)
insert into OrderGoodsInfo values (@orderId,25,1)
go

insert into OrderInfo values (3,0,getdate())
declare @orderId int
select @orderId=@@identity
insert into OrderGoodsInfo values (@orderId,9,1)
insert into OrderGoodsInfo values (@orderId,40,2)
insert into OrderGoodsInfo values (@orderId,26,1)
insert into OrderGoodsInfo values (@orderId,42,1)
go

-- 发布公告信息
insert into Bulletin values ('测试数据-公告标题1','测试数据-公告内容1',1,getdate())
insert into Bulletin values ('测试数据-公告标题2','测试数据-公告内容2',1,getdate())
insert into Bulletin values ('测试数据-公告标题3','测试数据-公告内容3',1,getdate())
insert into Bulletin values ('测试数据-公告标题4','测试数据-公告内容4',1,getdate())
insert into Bulletin values ('测试数据-公告标题5','测试数据-公告内容5',1,getdate())
insert into Bulletin values ('测试数据-公告标题6','测试数据-公告内容6',1,getdate())
go
update GoodsInfo set status = 0,isRecommend = 0,isNew = 0 where goodsId in (select goodsId from OrderGoodsInfo);
go
--select *  from  CustomerInfo c  join Bulletin b on c.id=b.userId where b.userId = 2 and c.id=1
select *  from  CustomerInfo c join CustomerDetailInfo b on c.id = b.customerId where b.customerId = 1
select top 1  * from  CustomerInfo c join CustomerDetailInfo b on c.id=b.customerId where  c.id not in (select top (1*(1-1)) id from CustomerInfo c join CustomerDetailInfo b on c.id = b.customerId)
select top 1  * from  CustomerInfo c join CustomerDetailInfo b on c.id=b.customerId where (c.email like '%%' or b.name like '%%') and c.id not in (select top (1*(1-1)) id from CustomerInfo c join CustomerDetailInfo b on c.id = b.customerId where c.email  like '%a%')
select COUNT (1) from CustomerInfo c join CustomerDetailInfo b on c.id=b.customerId where (c.email like '%%' or b.name like '%%')
delete  from CustomerInfo where id = 1
delete from CustomerDetailInfo where customerId = 1