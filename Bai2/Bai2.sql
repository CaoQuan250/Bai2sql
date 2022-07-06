create database VehicleRent
go 
use VehicleRent
go

create table Provider(
   PID int not null,
   ADDRESS char(50),
   TAXID int,
   PHONE int,
   Brand char(50),
)

select * from Provider

INSERT INTO Provider values (1,'Nhat',598,0999999,'Toyota')
INSERT INTO Provider values (2,'Y',753,0999123,'Alfa Romeo')
INSERT INTO Provider values (3,'My',928,0999456,'Jeep')
INSERT INTO Provider values (4,'VietNam',598,0999789,'Vinfast')
INSERT INTO Provider values (5,'Duc',836,0999246,'BMW')
INSERT INTO Provider values (6,'My',194,0999357,'Ford')

CREATE TABLE Contract(
   CID int not null,
   PLATE char(10),
   CarType char(50),
   SEAT int,
   BRAND CHAR(50)
)

select * from Contract

INSERT INTO Contract values (9,'E59C','Corolla Altis',5,'Toyota') 
INSERT INTO Contract values (21,'G36H','Innova',8,'Toyota') 
INSERT INTO Contract values (15,'N92D','Wigo',4,'Toyota') 

INSERT INTO Contract values (4,'B578G2','Spider Veloce',4,'Alfa Romeo')
INSERT INTO Contract values (48,'F947K1','4C',2,'Alfa Romeo')
INSERT INTO Contract values (8,'N347Y1','Giulia',5,'Alfa Romeo')

INSERT INTO Contract values (34,'H3K99','Wrangler',4,'Jeep') 
INSERT INTO Contract values (67,'M1B58','Wagoneer',8,'Jeep') 
INSERT INTO Contract values (5,'G3J93','Compass',5,'Jeep') 

INSERT INTO Contract values (59,'N89B24','Fadil',4,'Vinfast')
INSERT INTO Contract values (3,'Z98K12','Lux A2.0',5,'Vinfast')
INSERT INTO Contract values (19,'J37X92','Lux SA2.0',7,'Vinfast')

INSERT INTO Contract values (77,'S145ZM','750Li',4,'BMW')
INSERT INTO Contract values (31,'J153KQ','X7',7,'BMW')
INSERT INTO Contract values (61,'M367BZ','3 Series',5,'BMW') 

INSERT INTO Contract values (83,'M59G63','Laser',4,'Ford')
INSERT INTO Contract values (13,'S71H92','Everest',7,'Ford')
INSERT INTO Contract values (43,'S13B83','Ecosport',5,'Ford') 

CREATE TABLE Manage(
   SID int not null,
   SNAME char(50),
   SDETAIL char(50),
)

INSERT INTO Manage values (1 , 'Thue xe 1 ngay' , 'Cho phep thue xe' )
INSERT INTO Manage values (2 , 'Thue xe 1 tuan' , 'Cho phep thue xe' )
INSERT INTO Manage values (3 , 'Thue xe 1 thang' , 'Cho phep thue xe' )
 
select * from Manage

CREATE TABLE FEE(
   FID int not null,
   METHOD char(10),
   AMOUNT decimal,
)

Insert Into FEE values (1 , 'Cash' , '10')
Insert Into FEE values (2 , 'Cash' , '20')
Insert Into FEE values (3 , 'Cash' , '30')
Insert Into FEE values (4 , 'Cash' , '40')
Insert Into FEE values (5 , 'Cash' , '50')
Insert Into FEE values (6 , 'Cash' , '60')
Insert into FEE values (7 , 'Cash' , '70')
Insert into FEE values (8 , 'Cash' , '80')
Insert into FEE values (9 , 'Cash' , '90')
Insert into FEE values (10 , 'Cash' , '100') 

Insert Into FEE values (11 , 'Transfer' , '10')
Insert Into FEE values (12 , 'Transfer' , '20')
Insert Into FEE values (13 , 'Transfer' , '30')
Insert Into FEE values (14 , 'Transfer' , '40')
Insert Into FEE values (15 , 'Transfer' , '50')
Insert Into FEE values (16 , 'Transfer' , '60')
Insert into FEE values (17 , 'Transfer' , '70')
Insert into FEE values (18 , 'Transfer' , '80')
Insert into FEE values (19 , 'Transfer' , '90')
Insert into FEE values (20 , 'Transfer' , '100') 

select * from FEE

create table Register(
   SID int not null,
   FID int not null,
   S_START DATE,
   S_END DATE,
   CID int not null,
)

select * from Register

Insert into Register values(1, 2, '2012/08/27','2012/08/28',5)
Insert into Register values(3, 19, '2019/05/19','2019/06/19',9)
Insert into Register values(2, 7, '2007/09/03','2007/09/10',43)
Insert into Register values(3, 10, '2015/12/21','2016/01/21',21)
Insert into Register values(1, 13, '2021/11/17','2021/11/18',3)
Insert into Register values(1, 12, '1998/03/06','1998/03/07',77)
Insert into Register values(2, 14, '2013/06/12','2013/07/12',61)
Insert into Register values(1, 4, '1981/08/28','1981/08/29',83)
Insert into Register values(2, 6, '2009/11/15','2009/12/15',19)
Insert into Register values(2, 16, '2003/05/05','2003/06/05',21)

Alter table Register ADD CONSTRAINT ID PRIMARY KEY (SID,CID,FID)
Alter table FEE ADD CONSTRAINT FID PRIMARY KEY (FID)
Alter table Manage ADD CONSTRAINT SID PRIMARY KEY (SID)
Alter table Contract ADD CONSTRAINT CID PRIMARY KEY (CID)

ALTER TABLE Register
   ADD CONSTRAINT fk_htk_SID
   FOREIGN KEY (SID)
   REFERENCES manage (SID)

ALTER TABLE Register
   ADD CONSTRAINT fk_htk_FID
   FOREIGN KEY (FID)
   REFERENCES FEE (FID)

ALTER TABLE Register
   ADD CONSTRAINT fk_htk_CID
   FOREIGN KEY (CID)
   REFERENCES Contract (CID)
   
-- Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ
select CarType,BRAND,SEAT from Contract
WHERE SEAT >= 5;
-- Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe
-- thuộc hãng xe “Toyota” với mức phí có đơn giá là 15.000 VNĐ/km hoặc những dòng xe
-- thuộc hãng xe “KIA” với mức phí có đơn giá là 20.000 VNĐ/km   
select PID,ADDRESS,TAXID,PHONE,Provider.Brand from Provider 
JOIN Contract on Provider.Brand = Contract.BRAND
JOIN Register on Register.CID = Contract.CID
join FEE on Register.FID = FEE.FID
where FEE.AMOUNT = 30 AND Provider.Brand = 'Vinfast' or FEE.AMOUNT = 15 and Provider.Brand = 'Toyota'
-- Câu 5: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung
-- cấp và giảm dần theo mã số thuế

select * from Provider 
order by Brand asc,taxid desc

-- Câu 6: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với
-- yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu
-- cung cấp là “20/11/2015”
select Provider.Brand,count(Contract.CID) as "Số lượng" from Provider
join Contract on Provider.Brand = Contract.BRAND
join Register on Contract.CID = Register.CID
where Register.S_START = '2012/08/27' or Register.S_START = '2015/11/20'
group by Provider.Brand 


-- Câu 7: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe
-- chỉ được liệt kê một lần

Select DISTINCT BRAND from Contract 

-- Câu 8: Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia,
-- HangXe, NgayBatDauCC, NgayKetThucCC của tất cả các lần đăng ký cung cấp phương
-- tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương
-- tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra

select PID,provider.Brand,ADDRESS,TAXID,SNAME,AMOUNT,CarType,S_START,S_END from Provider
JOIN Contract ON Provider.Brand = Contract.BRAND
join Register on Contract.CID = Register.CID
join Manage ON Manage.SID = Register.SID
join FEE on Register.FID = FEE.FID

-- Câu 9: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện
-- thuộc dòng xe “Hiace” hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “Cerato”

select PID,ADDRESS,TAXID,PHONE,Provider.Brand,CarType from Provider
join Contract on Provider.Brand = Contract.BRAND
join Register on Contract.CID = Register.CID
where CarType = 'Compass' or CarType = 'Hiace' or CarType = 'Cerato' 

-- Câu 10: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp
-- phương tiện lần nào cả.
select PID,ADDRESS,TAXID,PHONE,Provider.Brand from Provider
join Contract on Provider.Brand = Contract.BRAND
join Register on Contract.CID = Register.CID
where Register.FID is null and Register.CID is null
