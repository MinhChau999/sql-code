CREATE DATABASE QuanLyThuVien
GO

USE QuanLyThuVien
GO

-- Tạo bảng Sách
CREATE TABLE Sach
(
	MaSach CHAR(5),
	TieuDe NVARCHAR(50),
	MaTG CHAR(5),
	Gia INT,
	PRIMARY KEY (MaSach)
)
GO

-- Tạo bảng tác giả
CREATE TABLE TacGia
(
	MaTG CHAR(5) PRIMARY KEY,
	TenTG NVARCHAR(50)
)
GO 

-- Tạo khóa ngoại MaTG cho bảng Sach
ALTER TABLE dbo.Sach ADD FOREIGN KEY (MaTG) REFERENCES dbo.TacGia(MaTG)
GO

-- Tạo bảng NhaXuatBan
CREATE TABLE NhaXuatBan
(
	MaNXB CHAR(5),
	TenNXb NVARCHAR(50),
	PRIMARY KEY (MaNXB)
)
GO

-- Tạo bảng XuatBan
CREATE TABLE XuatBan
(
	MaSach CHAR(5),
	MaNXB CHAR(5),
	SoLuong INT,
	FOREIGN KEY (MaSach) REFERENCES dbo.Sach(MaSach),
	FOREIGN KEY (MaNXB) REFERENCES dbo.NhaXuatBan(MaNXB)
)
GO