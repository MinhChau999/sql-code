/*
Dự án 4:
Xét lược đồ quan hệ sau:
Suppliers(sid:integer, sname: string, address:string)
Parts(pid:integer, pname: string, color:string)
Catalog(sid: integer, pid:integer, cost:real)

Các khóa là được gạch chân và miền trị của các thuộc tính được ghi liền sau mỗi tên thuộc tính.
Quan hệ Catalog nhằm ghi lại giá của các mặt hàng do các nhà cung cấp khác nhau.

Viết các câu truy vần sau bởi SQL
1. Tìm tên nhà cung cấp đã cung cấp ít nhất một mặt hàng màu đỏ
2. Tìm mã sid của các nhà cung cấp đã cung cấp một mặt hàng màu đỏ hay xanh
3. Tìm mã của các nhà cung cấp đã cung cấp một mặt hàng màu đỏ hoặc ở địa chỉ 221 Packer street
4. Tìm mã sid của các nhà cung cấp đã cung cấp các mặt hàng màu xanh lẫn mặt hàng màu đỏ
5. Tìm mã sid của các nhà cung cấp đã cung cấp đầy đủ các mặt hàng
6. Tìm mã sid của các nhà cung cấp đã cung cấp mọi mặt hàng màu đỏ.
7. Tìm mã sid của các nhà cung cấp đã cung cấp mọi mặt hàng màu đỏ lẫn mọi mặt hàng màu xanh
8. Tìm mã sid của các nhà cung cấp đã cung cấp mọi mặt hàng màu đỏ hoặc mọi mặt hàng màu xanh
9. Đưa ra các cặp mã số sid của các nhà cung cấp mà người trước cung cấp nhiều hàng hơn so với người sau ở trong cùng 1 cặp
10. Tìm mã số pid của các mặt hàng được cung cấp bởi ít nhất 2 nhà cung cấp khác nhau.
11. Tìm mã số pid của các mặt hàng có giá đắt nhất được cung cấp bởi nhà cung cấp có tên là Yosemite Sham
*/

--I/ Tạo database & table
CREATE DATABASE DU_AN_4
GO
USE DU_AN_4
GO

CREATE TABLE Suppliers
(
	Id INT PRIMARY KEY,
	sName VARCHAR(20),
	sAddress VARCHAR(50)
)
GO
CREATE TABLE Parts
(
	Id INT PRIMARY KEY,
	pName VARCHAR(20),
	color VARCHAR(20)
)
GO

CREATE TABLE Catalogs
(
	sId INT NOT NULL,
	pId INT NOT NULL,
	cost REAL,

	PRIMARY KEY (sId,pId),
	FOREIGN KEY (sId) REFERENCES dbo.Suppliers(Id),
	FOREIGN KEY (pId) REFERENCES dbo.Parts(Id)
)
GO

INSERT INTO dbo.Suppliers
(
    Id,
    sName,
    sAddress
)
VALUES
(1,'Smith','London'),
(2,'Jones','Paris'),
(3,'Blake','Paris'),
(4,'Clark','London'),
(5,'Adams','Athens');
GO

INSERT INTO dbo.Parts
(
    Id,
    pName,
    color
)
VALUES
(1,'Nut','Red'),
(2,'Bolt','Green'),
(3,'Screw','Blue'),
(4,'Screw','Red'),
(5,'Cam','Blue'),
(6,'Cog','Red');
GO

INSERT INTO dbo.Catalogs
(
    sId,
    pId,
    cost
)
VALUES
(4,3,200),
(2,4,100),
(2,6,200),
(5,5,300),
(1,1,300),
(1,2,200),
(1,3,400),
(1,4,200),
(1,5,100),
(1,6,100),
(2,1,300),
(2,2,400),
(3,2,200),
(4,2,200),
(4,4,300),
(4,5,400);
GO

--1. Tìm tên nhà cung cấp đã cung cấp ít nhất một mặt hàng màu đỏ
SELECT DISTINCT Suppliers.Id, sName FROM dbo.Suppliers
JOIN dbo.Catalogs ON dbo.Suppliers.Id = dbo.Catalogs.sId
JOIN dbo.Parts ON dbo.Parts.Id = dbo.Catalogs.pId
WHERE color = 'Red'
GO

--2. Tìm mã sid của các nhà cung cấp đã cung cấp một mặt hàng màu đỏ hay xanh
SELECT DISTINCT Suppliers.Id, sName FROM dbo.Suppliers
JOIN dbo.Catalogs ON dbo.Suppliers.Id = dbo.Catalogs.sId
JOIN dbo.Parts ON dbo.Parts.Id = dbo.Catalogs.pId
WHERE color = 'Red' OR color = 'Blue'
GO

--3. Tìm mã của các nhà cung cấp đã cung cấp một mặt hàng màu đỏ hoặc ở địa chỉ London
SELECT DISTINCT Suppliers.Id, sName FROM dbo.Suppliers
JOIN dbo.Catalogs ON dbo.Suppliers.Id = dbo.Catalogs.sId
JOIN dbo.Parts ON dbo.Parts.Id = dbo.Catalogs.pId
WHERE color = 'Red' OR dbo.Suppliers.sAddress='London'
GO

-- 4. Tìm mã sid của các nhà cung cấp đã cung cấp các mặt hàng màu xanh lẫn mặt hàng màu đỏ
SELECT DISTINCT Suppliers.Id, sName FROM dbo.Suppliers
JOIN dbo.Catalogs ON dbo.Suppliers.Id = dbo.Catalogs.sId
JOIN dbo.Parts ON dbo.Parts.Id = dbo.Catalogs.pId
WHERE color = 'Red' and color = 'Blue'
GO

--5. Tìm mã sid của các nhà cung cấp đã cung cấp đầy đủ các mặt hàng
-- Tạo function check đã cung cấp đầy đủ các mặt hàng
CREATE FUNCTION F4_Is_Supply_Full_Parts ( @sId INT)
RETURNS BIT
AS
BEGIN
	IF (NOT EXISTS (SELECT Id FROM dbo.Parts EXCEPT
	SELECT DISTINCT pId FROM dbo.Catalogs
	WHERE sId = @sId))
		RETURN 1
	RETURN 0
END
GO
-- mã sid của các nhà cung cấp đã cung cấp đầy đủ các mặt hàng
SELECT * FROM dbo.Suppliers
WHERE dbo.F4_Is_Supply_Full_Parts(Id) = 1
GO

--6. Tìm mã sid của các nhà cung cấp đã cung cấp mọi mặt hàng màu đỏ.
-- Tạo function check đã cung cấp mọi các mặt hàng Red color
CREATE FUNCTION F4_Is_Supply_Full_Parts_Red ( @sId INT)
RETURNS BIT
AS
BEGIN
	IF (NOT EXISTS (SELECT Id FROM dbo.Parts WHERE color = 'Red'
			EXCEPT
			SELECT DISTINCT pId FROM dbo.Catalogs
			JOIN dbo.Parts ON dbo.Parts.Id = dbo.Catalogs.pId
			WHERE sId = @sId AND dbo.Parts.color = 'Red'))
		RETURN 1
	RETURN 0
END
GO
SELECT * FROM dbo.Suppliers
WHERE dbo.F4_Is_Supply_Full_Parts_Red(Id) = 1
GO


--7. Tìm mã sid của các nhà cung cấp đã cung cấp mọi mặt hàng màu đỏ lẫn mọi mặt hàng màu xanh
CREATE FUNCTION F4_Is_Supply_Full_Parts_Blue ( @sId INT)
RETURNS BIT
AS
BEGIN
	IF (NOT EXISTS (SELECT Id FROM dbo.Parts WHERE color = 'Blue'
			EXCEPT
			SELECT DISTINCT pId FROM dbo.Catalogs
			JOIN dbo.Parts ON dbo.Parts.Id = dbo.Catalogs.pId
			WHERE sId = @sId AND dbo.Parts.color = 'Blue'))
		RETURN 1
	RETURN 0
END
GO
SELECT * FROM dbo.Suppliers
WHERE dbo.F4_Is_Supply_Full_Parts_Red(Id) = 1
AND dbo.F4_Is_Supply_Full_Parts_Blue(Id) = 1
GO


--8. Tìm mã sid của các nhà cung cấp đã cung cấp mọi mặt hàng màu đỏ hoặc mọi mặt hàng màu xanh

SELECT * FROM dbo.Suppliers
WHERE dbo.F4_Is_Supply_Full_Parts_Red(Id) = 1
OR dbo.F4_Is_Supply_Full_Parts_Blue(Id) = 1
GO

--9. Đưa ra các cặp mã số sid của các nhà cung cấp mà người trước cung cấp nhiều hàng 
--   hơn so với người sau ở trong cùng 1 cặp
--10. Tìm mã số pid của các mặt hàng được cung cấp bởi ít nhất 2 nhà cung cấp khác nhau.
--11. Tìm mã số pid của các mặt hàng có giá đắt nhất được cung cấp bởi nhà cung cấp có tên là Yosemite Sham

