USE HowKteam
GO
-- INDEXS
-- Tạo index trên bảng giáo viên
-- Tăng tốc độ tìm kím <> Chậm tốc độ thêm, xóa, sưa
-- Cho phép các trường trùng nhau
CREATE INDEX IndexName ON dbo.NGUOITHAN(MaGV)

-- Không Cho phép các trường trùng nhau
CREATE UNIQUE INDEX IndexNameUnique ON dbo.GIAOVIEN(MaGV)

----------------------------------------------------------
-- DECLARE

-- Tìm ra giáo viên có lương thấp nhất
SELECT MaGV FROM dbo.GIAOVIEN 
WHERE Luong = 
(SELECT MIN(Luong) FROM	dbo.GIAOVIEN)

-- Lấy ra tuổi giáo viên có lương thấp nhất
SELECT YEAR(GETDATE())-YEAR(dbo.GIAOVIEN.NGSinh) AS N'Tuổi' FROM dbo.GIAOVIEN
WHERE MaGV = (SELECT MaGV FROM dbo.GIAOVIEN WHERE Luong = (SELECT MIN(Luong) FROM	dbo.GIAOVIEN))

--------------------------
-- Tạo ra 1 biến kiểu char lưu mã giáo viên lương thấp nhất
DECLARE @minSalaryMaGV CHAR(4)
SELECT @minSalaryMaGV = MaGV FROM dbo.GIAOVIEN WHERE Luong = (SELECT MIN(Luong) FROM	dbo.GIAOVIEN)
-- Lấy ra tuổi giáo viên có lương thấp nhất
SELECT YEAR(GETDATE())-YEAR(dbo.GIAOVIEN.NGSinh) AS N'Tuổi' FROM dbo.GIAOVIEN
WHERE MaGV = @minSalaryMaGV

---------------------------
-- Khởi tạo với kiểu dữ liệu
-- Biến bắt đầu bằng @
DECLARE @i INT
DECLARE @j INT = 0 --(Defaut cho biến)

-- Set dữ liệu cho biến
SET @i = @i + 1
SET @i += 1
SET @i *= @j

-- Set thông qua câu select
DECLARE @maxLuong INT
SELECT @maxLuong = MAX(Luong) FROM dbo.GIAOVIEN

------------------------------
--1/ Xuất ra số lượng người thân của giáo viên 001
-- Lưu mã giáo viên 001 lại
-- Tìm ra số lượng người thân từ mã giáo viên

DECLARE @MaGV CHAR(10) = '001'
SELECT COUNT(*) FROM dbo.NGUOITHAN WHERE MaGV = @MaGV

-- 2/ Xuất ra tên giáo viên có lương thấp nhất
DECLARE @MinLuong INT
DECLARE @TenGV NVARCHAR(100)

SELECT @MinLuong = MIN(Luong) FROM dbo.GIAOVIEN
SELECT @TenGV = HoTen FROM dbo.GIAOVIEN WHERE Luong = @MinLuong

PRINT @TenGV

----------------------------------------------------
-- IF ELSE
DECLARE @LuongTrungBinh INT
DECLARE @SoLuongGiaoVien INT

SELECT @SoLuongGiaoVien = COUNT(*) FROM	dbo.GIAOVIEN
SELECT @LuongTrungBinh = SUM(Luong)/@SoLuongGiaoVien FROM dbo.GIAOVIEN

DECLARE @MaGiaoVien CHAR(10) = '001'
DECLARE @LuongMaGV INT

SELECT @LuongMaGV = Luong FROM dbo.GIAOVIEN WHERE dbo.GIAOVIEN.MaGV = @MaGiaoVien

IF @LuongMaGV > @LuongTrungBinh
	BEGIN
		PRINT N'Lớn hơn'
	END
ELSE
	PRINT N'Nhỏ hơn'
