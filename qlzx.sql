/**********
 * ǧ��֮�й�����վ���ݿ�ű�
 *
 * author:zuxia
 * date: 06/21/2009
 **/

/*********����*************/
use  master
go
if exists (select *  from  sysdatabases where name ='web')
drop  database web
go
create database qlzx
go

use qlzx
go

/***********������ҪԼ��*****************/

-- �û���Ϣ����վ��̨������Ա��
create table UserInfo
(
	id int identity primary key,	-- �û����
	userName varchar(20) not null unique,	-- �û�����
	userPwd varchar(20) not null	-- �û�����
)
go

-- ������Ϣ��
create table Bulletin
(
	id int identity primary key, --���
	title varchar(100) not null,-- ����
	content text,	--����
	userId int not null references UserInfo(id), --������
	createTime datetime not null default getdate()	--����ʱ��
)
go

-- �ͻ���Ϣ��
create table CustomerInfo
(
	id int identity primary key,	-- �ͻ����
	email varchar(100) not null unique,	-- �������䣨�ͻ��˻�����
	pwd varchar(20) not null,	-- ����
	registerTime datetime not null --ע��ʱ��
)
go

-- �ͻ���ϸ��Ϣ��
create table CustomerDetailInfo
(
	customerId int primary key references CustomerInfo(id),	--�ͻ����
	[name] varchar(50) not null,	-- �ջ�������
	telphone varchar(20) not null,	-- �̶��绰
	movePhone varchar(20) not null,	-- �ƶ��绰
	address varchar(100) not null	-- �ջ���ַ
)
go

-- ��Ʒ���
create table GoodsType
(
	typeId int identity primary key,	-- �����
	typeName varchar(20) not null unique	-- �������
)
go

-- ��Ʒ��Ϣ��
create table GoodsInfo
(
	goodsId int identity primary key,	-- ��Ʒ���
	typeId int not null references GoodsType(typeId),	-- ��Ʒ���
	goodsName varchar(50) not null,	-- ��Ʒ����
	price decimal(8,2) not null default 0.0,	-- ��Ʒ�۸�
	discount float default 10.0, -- �ۿ�(Ĭ�ϲ�����)
	isNew int not null,	-- �Ƿ���Ʒ(0��Ʒ,1������Ʒ)
	isRecommend int not null,	-- �Ƿ��Ƽ���0�Ƽ���1���Ƽ���
	status int not null, -- ��Ʒ״̬��0�ϼܣ�1�¼ܣ�
	photo varchar(50), -- ��ƷͼƬ
	remark varchar(200) -- ��ע
)
go

-- ������Ϣ��
create table OrderInfo
(
	orderId int identity primary key,	-- �������
	customerId int not null references CustomerInfo(id), -- �ͻ����
	status int not null default 0, -- ����״̬��0δȷ�ϣ�1��ȷ�ϣ�
	orderTime datetime not null --�¶�����ʱ��
)
go


-- ������Ʒ��Ϣ��
create table OrderGoodsInfo
(
	orderId int references OrderInfo(orderId), -- �������
	goodsId int not null references GoodsInfo(goodsId),	-- ��Ʒ���
	quantity int not null,	--��Ʒ����
	primary key (orderId,goodsId) --��������Լ��
)
go




/****************�����������***********************/

-- �������Ա�û�����
insert into UserInfo values ('admin','123456')
insert into UserInfo values ('zhangsan','123456')
insert into UserInfo values ('lisi','123456')
go

-- ������Ʒ����
insert into GoodsType values ('ҰӪ����')
insert into GoodsType values ('˯������')
insert into GoodsType values ('��������')
insert into GoodsType values ('�˶��ֱ�')
insert into GoodsType values ('ҰӪ��Ʒ')
insert into GoodsType values ('��ɽ��������')
insert into GoodsType values ('�����װ')
go

-- ����������µ���Ʒ

-- ����
insert into GoodsInfo values (1,'ND-1182 ˫��˫���ʣ��¿����ˣ�',498.0,default,1,1,0,'zhangpeng1.jpg','˫��˫���ʣ��¿����ˣ���')
insert into GoodsInfo values (1,'ND-1133 ����˫������(��������Ϳ��)',256.0,9.5,0,1,0,'zhangpeng2.jpg','����˫������(��������Ϳ��)��')
insert into GoodsInfo values (1,'ND-1132 ��������(��������)',296.0,6.7,1,0,0,'zhangpeng3.jpg','����˫������(��������Ϳ��)��')
insert into GoodsInfo values (1,'ND-1136 ����˫����',438.0,default,0,1,0,'zhangpeng4.jpg','����˫����(��������Ϳ��)��')
insert into GoodsInfo values (1,'ND-1121 ˫��˫������(��������Ϳ��)',186.0,default,1,1,0,'zhangpeng5.jpg','˫��˫����(��������Ϳ��)��')
insert into GoodsInfo values (1,'ND-1009 ����ɴ������',680.0,default,1,0,0,'zhangpeng6.jpg','����ɴ������')
insert into GoodsInfo values (1,'MOBI GARDEN���ߵѾ���2AIR 2��˫����������',642.0,default,1,0,0,'zhangpeng7.jpg','˫���Զ�2������')
insert into GoodsInfo values (1,'����˫����������',846.0,default,1,1,0,'zhangpeng8.jpg','˫���Զ�2������')
insert into GoodsInfo values (1,'��ɽ3��˫����������',957.0,default,1,1,0,'zhangpeng9.jpg','˫���Զ�2������')
insert into GoodsInfo values (1,'ɽ��3��˫����������',654.0,6.8,0,0,0,'zhangpeng10.jpg','˫���Զ�2������')

-- ˯������
insert into GoodsInfo values (2,'ND-1327 ����˫�������',198.0,8.5,1,1,0,'dianzi1.jpg','ҰӪϵ��')
insert into GoodsInfo values (2,'ND-1255L �ŷ�˯��(200g�п���)',146.0,9.5,0,1,0,'shuidai1.jpg','ҰӪϵ��')
insert into GoodsInfo values (2,'ND-1202 ��������˯��350��',296.0,6.7,1,0,0,'shuidai2.jpg','ҰӪϵ��')
insert into GoodsInfo values (2,'���Ʊ̶�˹500 ����˯��',438.0,default,0,1,0,'shuidai5.jpg','ҰӪϵ��')
insert into GoodsInfo values (2,'CHAMONIX334SOFT˯��',186.0,default,1,1,0,'shuidai7.jpg','ҰӪϵ��')
insert into GoodsInfo values (2,'CHAMONIX265��С˯��',267.0,default,1,0,0,'shuidai8.jpg','ҰӪϵ��')
insert into GoodsInfo values (2,'highrockS106107 ө���',467.0,6.5,1,0,0,'shuidai6.jpg','ҰӪϵ��')
insert into GoodsInfo values (2,'highrockS4543 ө���',456.0,8.8,1,1,0,'shuidai9.jpg','ҰӪϵ��')
go

-- ��������
insert into GoodsInfo values (3,'Featherf4005 ľ���۵���',198.0,8.5,1,1,0,'zuoyi2.jpg','ҰӪϵ��')
insert into GoodsInfo values (3,'Featherf4007 ��ɫԲ���������',146.0,9.5,0,0,0,'zuoyi1.jpg','ҰӪϵ��')
go

-- �˶��ֱ�
insert into GoodsInfo values (4,'MAINNAV950DM �߾���GPS ���',298.0,8.5,1,1,0,'biao1.jpg','ҰӪϵ��')
insert into GoodsInfo values (4,'MAINNAV950D GPS�����˶���',286.0,default,0,0,0,'biao2.jpg','ҰӪϵ��')
insert into GoodsInfo values (4,'SUUNTO D6 Ǳˮϵ���𽺱�',358.0,8.5,1,1,0,'biao3.jpg','ҰӪϵ��')
insert into GoodsInfo values (4,'SUUNTOt3c Black Polished��ɫ�׹� ���ʱ�',434.0,9.5,0,1,0,'biao10.jpg','ҰӪϵ��')
insert into GoodsInfo values (4,'SUUNTO t3c Black without Belt�� ���ʱ�ɫ,�����ʴ�',499.0,8.5,1,1,0,'biao7.jpg','ҰӪϵ��')
insert into GoodsInfo values (4,'����֮��A77���ʱ�',564.0,9.5,0,1,0,'biao4.jpg','ҰӪϵ��')
insert into GoodsInfo values (4,'����֮�Ǹ߾��ȱ�',532.0,default,1,0,0,'biao7.jpg','ʱ��ϵ��')
insert into GoodsInfo values (4,'����֮�Ǹ߾��ȱ�',342.0,default,0,1,0,'biao9.jpg','ʱ��ϵ��')
go

-- ҰӪ��Ʒ
insert into GoodsInfo values (5,'ND-8629 ����������XL',198.0,8.5,1,1,0,'bao1.jpg','(60L-80L)')
insert into GoodsInfo values (5,'ND-8627 ����������M ',186.0,default,0,1,0,'bao2.jpg','(25L- 40L)')
insert into GoodsInfo values (5,'ND-8626 ����������S',99.0,default,1,1,0,'bao3.jpg','(25L����)')
insert into GoodsInfo values (5,'ND-2129 С�ſ��',121.0,9.5,0,1,0,'kuabao1.jpg','ҰӪϵ��')
insert into GoodsInfo values (5,'ND-2125 ����',43.0,default,1,0,0,'yaobao1.jpg','ҰӪϵ��')
insert into GoodsInfo values (5,'ND-3211 ����',34.0,9.5,0,1,0,'yaobao2.jpg','ҰӪϵ��')
insert into GoodsInfo values (5,'ND-3210 ���Ȱ�',59.0,9.5,0,1,0,'jijiubao1.jpg','ҰӪϵ��')
insert into GoodsInfo values (5,'ND-2315 ����',55.0,9.5,0,0,0,'maojing.jpg','ҰӪϵ��')
insert into GoodsInfo values (5,'Featherf201 ����ɡ',532.0,default,1,1,0,'zheyangsan.jpg','����ɡ')
insert into GoodsInfo values (5,'ND-3565 3+5LEDͷ��',89.0,default,0,1,0,'toudeng3.jpg','ͷ��')
insert into GoodsInfo values (5,'ND-3566 2+1Xͷ��',68.0,default,0,1,0,'toudeng2.jpg','ͷ��')
insert into GoodsInfo values (5,'ND-3565 3+5LEDͷ��',92.0,6.5,0,1,0,'toudeng3.jpg','ͷ��')
insert into GoodsInfo values (5,'ND-3613 1X�ֵ�(U40)',55.0,default,1,0,0,'shoudian1.jpg','�ֵ�')
insert into GoodsInfo values (5,'ND-3612 3LED�ֵ�(N35)',58.0,default,0,1,0,'shoudian2.jpg','�ֵ�')
insert into GoodsInfo values (5,'D-3611 1X�ֵ�(N30)',34.0,7.8,0,1,0,'shoudian3.jpg','�ֵ�')
go

-- ��ɽ����
insert into GoodsInfo values (6,'Edelrid1781 000 073 �½���',158.0,8.5,1,1,0,'xiajiangqi.jpg',' MINI 8 FIGURE OF 8')
insert into GoodsInfo values (6,'Edelrid1772 138 006 �½���',186.0,default,0,1,0,'xiajiangqi2.jpg',' PETIT 8 FIGURE OF 8')
insert into GoodsInfo values (6,'Edelrid1813 153 ���� HMS GUITAR LOCK',68.0,default,1,1,0,'zhusuo1.jpg','��ɽϵ��')
insert into GoodsInfo values (6,'Edelrid1813 213 ���� HMS GUITAR LOCK',84.0,9.5,0,1,0,'zhusuo2.jpg','��ɽϵ��')
insert into GoodsInfo values (6,'Edelrid1813 234 ���� HMS GUITAR LOCK',99.0,3.5,1,1,0,'zhusuo3.jpg','��ɽϵ��')
go

-- �����װ
insert into GoodsInfo values (7,'snowwolfŮ����߳����',298.0,8.5,1,1,0,'yi1.jpg',' MINI 8 FIGURE OF 8')
insert into GoodsInfo values (7,'snowwolf�п���߳����',286.0,default,0,1,0,'yi2.jpg',' PETIT 8 FIGURE OF 8')
insert into GoodsInfo values (7,'snowwolfŮ��Ѭ�²ݳ����',358.0,default,1,1,0,'yi3.jpg','ҰӪϵ��')
insert into GoodsInfo values (7,'GARMONT ZEPHYR434 ͽ��Ь',265.0,9.5,0,1,0,'xie2.jpg','ҰӪϵ��')
insert into GoodsInfo values (7,'GARMONT ZEPHYR546 ͽ��Ь',258.0,8.5,1,1,0,'xie3.jpg','ҰӪϵ��')
insert into GoodsInfo values (7,'GARMONT Syncro GTX��ɽЬ',199.0,default,1,1,0,'xie4.jpg','ҰӪϵ��')
go

-- ����ͻ���Ϣ
insert into CustomerInfo values ('a@sina.com','123456','2009-06-06 12:30:45')
insert into CustomerInfo values ('b@sina.com','123456','2009-06-07 12:30:15')
insert into CustomerInfo values ('c@sina.com','123456','2009-06-08 12:30:25')
insert into CustomerInfo values ('d@sina.com','123456','2009-06-09 12:30:35')
go

insert into CustomerDetailInfo values (1,'����','32456754','13534563234','������ɳƺ�����������ѧԺA��')
insert into CustomerDetailInfo values (2,'��˹','32456754','13534563234','������ɳƺ�����������ѧԺB��')
insert into CustomerDetailInfo values (3,'����','32456754','13534563234','������ɳƺ�����������ѧԺC��')
go

-- �¶���
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

-- ����������Ϣ
insert into Bulletin values ('��������-�������1','��������-��������1',1,getdate())
insert into Bulletin values ('��������-�������2','��������-��������2',1,getdate())
insert into Bulletin values ('��������-�������3','��������-��������3',1,getdate())
insert into Bulletin values ('��������-�������4','��������-��������4',1,getdate())
insert into Bulletin values ('��������-�������5','��������-��������5',1,getdate())
insert into Bulletin values ('��������-�������6','��������-��������6',1,getdate())
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