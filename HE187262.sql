create database NCTmart 
go 
use NCTmart  
go 
create table Categories 
( 
   cid [int] primary key, 
   cname nvarchar(30) , 
) 
go
insert into Categories values(1,'series') 
insert into Categories values(2,'accessories')
insert into Categories values(3,'figuries')
insert into Categories values(4,'mega')
insert into Categories values(5,'collaborations')
insert into Categories values(6,'blind box')
go
create table SubCategories 
( 
   subcid [int] primary key, 
   subcname nvarchar(30) ,
   [cid] [int] references Categories(cid),
) 
go
/*series*/
insert into SubCategories values(1,'molly',1) 
insert into SubCategories values(2,'dimoo',1) 
insert into SubCategories values(3,'hirono',1) 
insert into SubCategories values(4,'skullpanda',1) 
insert into SubCategories values(5,'crybaby',1) 
insert into SubCategories values(6,'pucky',1) 
insert into SubCategories values(7,'sweet bean',1) 
insert into SubCategories values(8,'hacipupu',1)
insert into SubCategories values(9,'disney',1) 
insert into SubCategories values(10,'harry potter',1) 
insert into SubCategories values(11,'the monsters',1) 
insert into SubCategories values(12,'azura',1) 
/*mega*/
insert into SubCategories values(13,'mega 100%',4) 
insert into SubCategories values(14,'mega 400%',4) 
insert into SubCategories values(15,'mega 1000%',4)
/*figure*/
insert into SubCategories values(16,'figure',3)
insert into SubCategories values(17,'action figure',3)
/*collab*/
insert into SubCategories values(18,'detective conan',5)
insert into SubCategories values(19,'Sponge bob',5)
insert into SubCategories values(20,'warner bros',5)
insert into SubCategories values(21,'universal studios',5)
insert into SubCategories values(22,'league of legends',5)
/*accessories*/
insert into SubCategories values(23,'earphone case',2)
insert into SubCategories values(24,'earphone bag',2)
insert into SubCategories values(25,'phone case',2)
insert into SubCategories values(26,'bag',2)
insert into SubCategories values(27,'plush toy',2)
insert into SubCategories values(28,'blind box',6)
insert into SubCategories values(29,'phone accessory',2)
go

create table Products 
( 
   pid [int] primary key, 
   pname nvarchar(max) ,
   price [int],
   [describe] [nvarchar](max) NULL, 
   [image1] [nvarchar](max) NULL, 
   [image2] [nvarchar](max) NULL, 
   [image3] [nvarchar](max) NULL, 
   [image4] [nvarchar](max) NULL, 
   [image5] [nvarchar](max) NULL, 
   [imagesize] [nvarchar](max) NULL,
   [imageinfor] [nvarchar](max) NULL,
   [quantity] [int] NULL,
   datesell date NULL
) 
go
insert into Products values(1,'MEGA SPACE MOLLY 100% Series 3',300000,'Brand: NCT MART
Size: Height about 7-8cm
Material: PVC/ABS/PC
A whole set contains 9 blind boxes
(There is no repeated figurine if you buy a whole set)
*A certain chance to win a secret edition',
'images/molly/11.jpg',
'images/molly/12.jpg',
'images/molly/13.jpg',
'images/molly/14.jpg',
'images/molly/15.jpg',
'images/molly/16.png',
'images/molly/17.png',
100,'2024-10-2')

insert into Products values(2,'LABUBU Trick-or-Treater Figure',700000,'Brand: NCT MART
Size: Height about 8.9cm
Material: PVC/ABS',
'images/monsters/21.jpg',
'images/monsters/22.jpg',
'images/monsters/23.jpg',
'images/monsters/24.jpg',
'images/monsters/25.jpg',
'images/monsters/26.png',
'images/monsters/27.png',
100,'2024-10-2')

insert into Products values(3,'DIMOO Dream Travel Series Action Figure',1520000,'Brand: NCT MART
Size: Height about 12.5*17.5*8.5cm
Material: PVC/ABS/Nylon/Terylene/Cotton/Spandex/Hardware/Chinlon
A whole set contains 2 blind boxes
(There is no repeated figurine if you buy a whole set)',
'images/dimoo/31.jpg',
'images/dimoo/32.jpg',
'images/dimoo/33.jpg',
'images/dimoo/34.jpg',
'images/dimoo/35.jpg',
'images/dimoo/36.png',
'images/dimoo/37.png',
100,'2024-10-2')

insert into Products values(4,'DIMOO Weaving Wonders Series Figures',280000,'Brand: NCT MART
Size: Height about 7-11cm
Material: PVC/ABS
A whole set contains 12 blind boxes
(There is no repeated figurine if you buy a whole set)
*A certain chance to win a secret edition',
'images/dimoo/41.jpg',
'images/dimoo/42.jpg',
'images/dimoo/43.jpg',
'images/dimoo/44.jpg',
'images/dimoo/45.jpg',
'images/dimoo/46.png',
'images/dimoo/47.png',
100,'2024-10-2')

insert into Products values(5,'Skip and Loafer-Fluffy Series Plush Toy',150000,'Brand: NCT MART
PRODUCT SIZE:Height about 10cm
MAIN MATERIAL:100% Polyester',
'images/plushtoys/51.jpg',
'images/plushtoys/52.jpg',
'images/plushtoys/53.jpg',
'images/plushtoys/54.jpg',
'images/plushtoys/55.png',
'images/plushtoys/56.png',
'images/plushtoys/57.png',
100,'2024-10-2')

insert into Products values(6,'MEGA SPACE MOLLY 1000% JOKER',21200000,'Brand: NCT MART
Size: Height about 700mm
Material: ABS/PVC/PC',
'images/molly/61.jpg',
'images/molly/62.jpg',
'images/molly/63.jpg',
'images/molly/64.jpg',
'images/molly/65.png',
'images/molly/66.png',
'images/molly/67.png',
100,'2024-10-2')

insert into Products values(7,'MEGA LABUBU 1000% Sketch',21200000,'Brand: NCT MART
Size: Height about 800mm
Material: ABS',
'images/monsters/71.jpg',
'images/monsters72.jpg',
'images/monsters/73.jpg',
'images/monsters/74.jpg',
'images/monsters/75.jpg',
'images/monsters/76.png',
'images/monsters/77.png',
100,'2024-10-2')

insert into Products values(8,'LABUBU × PRONOUNCE - WINGS OF FORTUNE Vinyl Plush Hanging Card',700000,'Brand: NCT MART
Size: 
11×8×17.5cm(excluding hanging loop)、
11×8×22cm(including hanging loop)
Shells:66%Polyester, 25%PVC,9%ABS
Stuffing:95%Polyester, 5%Iron Wire',
'images/monsters/81.jpg',
'images/monsters/82.jpg',
'images/monsters/83.jpg',
'images/monsters/84.jpg',
'images/monsters/85.png',
'images/monsters/86.png',
'images/monsters/87.png',
100,'2024-10-2')
go
CREATE TABLE SubCategoryProduct
(
    subcid INT,
    pid INT,
    PRIMARY KEY (subcid, pid),
    FOREIGN KEY (subcid) REFERENCES SubCategories(subcid),
    FOREIGN KEY (pid) REFERENCES Products(pid)
);
go
SELECT TOP (1000) [subcid]
      ,[subcname]
      ,[cid]
  FROM [NCTmart].[dbo].[SubCategories]
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (1, 1);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (13, 1);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 1);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (11, 2);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 2);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (2, 3);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (17, 3);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 3);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (2, 4);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 4);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 4);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (27, 5);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (1, 6);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (15, 6);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (11, 7);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (15, 7);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (11, 8);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (27, 8);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (11, 9);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 9);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (2, 10);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 11);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 11);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 11);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (1, 12);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (13, 12);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 12);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (1, 13);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (13, 13);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 13);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (1, 14);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (13, 14);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (14, 14);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (8, 15);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (25, 15);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (29, 15);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (8, 16);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (17, 16);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (6, 17);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 17);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (1, 18);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 18);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 18);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (12, 19);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 19);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (12, 19);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 19);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 19);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (12, 20);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 20);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 20);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (11, 21);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 21);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (5, 22);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (25, 22);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (29, 22);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (5, 23);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (26, 23);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (5, 24);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (25, 24);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (29, 24);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 24);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 25);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 25);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 25);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 26);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 26);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 26);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 27);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 27);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 28);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 28);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 29);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (17, 29);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 30);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (17, 30);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 31);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (14, 31);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 32);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (14, 32);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (4, 33);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 33);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (3, 34);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 34);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 34);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (7, 35);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (16, 35);
INSERT INTO SubCategoryProduct (subcid, pid) VALUES (28, 35);
go
CREATE TABLE Accounts
(
    id INT PRIMARY KEY IDENTITY(1,1),          
    phone NVARCHAR(255) UNIQUE NOT NULL,                 
    email NVARCHAR(255) UNIQUE,                 
    name NVARCHAR(MAX),
    address NVARCHAR(MAX),
    password NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CS_AS NOT NULL,            
    sex INT CHECK ([sex] IN (0, 1, 2)),
    dob DATE,
    [role] INT CHECK ([role] IN (1, 2, 3))         
);
go
INSERT INTO Accounts (phone, email, name, address, password, sex, dob, [role])
VALUES
    ('0817171804', 'gnurtnc@gmail.com', N'Nguyễn Chí Trung', N'Tổ 10, thị trấn nông trường Việt Lâm, Vị Xuyên, Hà Giang', 'A123456a', 1, '2004-03-27', 1),
    ('0387901914', 'khoicuto@gmail.com', N'Hoàng Trọng Khởi', N'Thôn 2 Thạch Hòa, Thạch Thất, Hà Nội', 'trungTrinoi', 1, '2004-03-02', 1),
	('0362678790', 'giangcr7@gmail.com', N'Vừ Trường Giang', N'Thôn 4 , Đồng Văn, Hà Giang', 'Giangdeptrai', 1, '2004-03-29', 1),
    ('456123789', 'user3@example.com', N'Lê Văn C', N'Đà Nẵng', 'password3', 1, '1992-09-09', 3);
go
CREATE TABLE Orders (
    oid INT PRIMARY KEY IDENTITY(1,1),
    aid INT,
    order_date DATE,
	did INT,
    total_amount DECIMAL(11, 2),
    payment_method VARCHAR(50) CHECK (payment_method IN ('bank transfer', 'cash payment')),
    payment_status VARCHAR(20) CHECK (payment_status IN ('unpaid', 'paid')),
    shipping_address NVARCHAR(255),
    order_status VARCHAR(20) CHECK (order_status IN ('processing', 'shipping', 'delivered', 'canceled')),
    FOREIGN KEY (aid) REFERENCES Accounts(id),  
	FOREIGN KEY (did) REFERENCES DiscountCodes(did)
);
INSERT INTO Orders (aid, order_date, total_amount, payment_method, payment_status, shipping_address, order_status)
VALUES 
(4, '2024-10-22', 700000.00, 'cash payment', 'paid', '123 ABC Street', 'delivered'),
(4, '2024-10-20', 1400000.00, 'cash payment', 'paid', '456 XYZ Avenue', 'delivered'),
(4, '2024-10-18', 300000.00, 'cash payment', 'paid', '789 DEF Road', 'delivered');
go
INSERT INTO Orders (aid, order_date, total_amount, payment_method, payment_status, shipping_address, order_status)
VALUES 
(4, '2023-10-22', 700000.00, 'cash payment', 'paid', '123 ABC Street', 'delivered'),
(4, '2023-10-20', 1400000.00, 'cash payment', 'paid', '456 XYZ Avenue', 'delivered'),
(4, '2023-10-18', 300000.00, 'cash payment', 'paid', '789 DEF Road', 'delivered');
go
CREATE TABLE DiscountCodes (
    did INT PRIMARY KEY IDENTITY(1,1),
    code VARCHAR(50) NOT NULL UNIQUE,  
    type VARCHAR(20) CHECK (type IN ('percentage', 'fixed')), 
    value DECIMAL(11, 2) NOT NULL,
    start_date DATE, 
    is_active BIT DEFAULT 1
);
go
INSERT INTO DiscountCodes (code, type, value, start_date)
VALUES 
('NEWMEMBER', 'percentage', 20.00, '2024-10-10'),
('HAPPYNEWYEAR', 'fixed', 100000.00, '2024-10-10'),
('WOMENDAY', 'percentage', 30.00, '2024-10-10'),
('HAPPYBIRTHDAY', 'fixed', 100000.00, '2024-10-10');
GO
CREATE TABLE OrderDetail (
    odid INT PRIMARY KEY IDENTITY(1,1),
    oid INT,
    pid INT,
    quantity INT,
    price DECIMAL(11, 2),
	FOREIGN KEY (oid) REFERENCES Orders(oid),  
	FOREIGN KEY (pid) REFERENCES Products(pid)
);
INSERT INTO OrderDetail (oid, pid, quantity, price)
VALUES 
(1, 2, 1, 700000.00),   
(2, 8, 1, 700000.00),   
(2, 2, 1, 700000.00),   
(3, 12, 1, 300000.00);   
go
CREATE TABLE AccountDiscountCodes (
    adid INT PRIMARY KEY IDENTITY(1,1),
    aid INT,
    did INT,
    FOREIGN KEY (aid) REFERENCES Accounts(id),
    FOREIGN KEY (did) REFERENCES DiscountCodes(did),
);
