CREATE DATABASE QuanLySinhVien
GO

USE QuanLySinhVien
GO

--1. Tạo bảng Khoa
CREATE TABLE Khoa
(
	MaKhoa CHAR(2),
	TenKhoa NVARCHAR(50),
	SoSinhVien INT,
	PRIMARY KEY (MaKhoa)
)
GO

--2 Tạo bảng sinh viên
CREATE TABLE SinhVien
(
	MaSV CHAR(10),
	TenSV NVARCHAR(50),
	NgaySinh DATE,
	MaKhoa CHAR(2),
	PRIMARY KEY (MaSV),
	FOREIGN KEY (MaKhoa) REFERENCES dbo.Khoa (MaKhoa)
)
GO	

--3. Chèn dữ liệu vào bảng khoa
INSERT INTO	dbo.Khoa
(
    MaKhoa,
    TenKhoa,
    SoSinhVien
)
VALUES
('vh',N'Khoa Văn',200),
('to',N'Khoa Toán',400),
('th',N'Khoa Tin',150);
GO

-- 4. Chèn dữ liệu vào bảng sinh viên
INSERT INTO dbo.SinhVien
(
    MaSV,
    TenSV,
    NgaySinh,
    MaKhoa
)
VALUES
('vh003',N'Trần An Toàn','1998-12-31','vh'),
('vh001',N'Nguyễn Anh','19980112','vh'),
('vh002',N'Trần An','19981231','vh'),
('to001',N'Võ Anh Huy','20000123','to');
GO

--5. Xem danh sách sinh viên (masv, tensv, makhoa) thuộc khoa Văn
SELECT MaSV, TenSV, dbo.SinhVien.MaKhoa FROM dbo.SinhVien
	JOIN dbo.Khoa
	ON Khoa.MaKhoa = SinhVien.MaKhoa
WHERE TenKhoa = N'Khoa Văn'

--6. Giảm 10% số lượng sinh viên khoa Toán
UPDATE dbo.Khoa SET 
SoSinhVien = 90 * (SELECT SoSinhVien FROM dbo.Khoa WHERE dbo.Khoa.TenKhoa = N'Khoa Toán') / 100
WHERE TenKhoa = N'Khoa Toán';

--7. Những sinh viên nào sinh vào tháng 1
SELECT * FROM dbo.SinhVien
WHERE MONTH(NgaySinh) = 1

--8. Xem danh sách sinh viên có trong các khoa bao gồm: mã SV, tên SV, tên Khoa, ngày sinh
--Sắp xếp thứ tự theo tên khoa
SELECT MaSV, TenSV, TenKhoa, NgaySinh FROM dbo.SinhVien
	JOIN dbo.Khoa
	ON Khoa.MaKhoa = SinhVien.MaKhoa
ORDER BY TenKhoa ASC;

--9. Khoa nào chưa có SV đăng ký
SELECT * FROM dbo.Khoa
WHERE MaKhoa NOT IN
(SELECT MaKhoa FROM dbo.SinhVien GROUP BY MaKhoa)

--9. Có bao nhiêu sinh viên sinh năm 1998
SELECT COUNT(*) FROM dbo.SinhVien
WHERE YEAR(NgaySinh) = 1998

--10. Xóa khoa có mã th trong khoa
DELETE FROM	dbo.Khoa
WHERE MaKhoa = 'th'
