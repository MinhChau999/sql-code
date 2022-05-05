USE HowKteam
GO

CREATE FUNCTION UF_SelectAllGiaoVien()
RETURNS TABLE
AS RETURN SELECT * FROM dbo.GIAOVIEN
GO

SELECT * FROM dbo.UF_SelectAllGiaoVien()
GO

CREATE FUNCTION	UF_SelectLuongGiaoVien(@MaGV CHAR(10))
RETURNS INT
AS 
BEGIN
	DECLARE @Luong INT
	SELECT @Luong = Luong FROM dbo.GIAOVIEN WHERE MaGV = @MaGV	
	RETURN @Luong
END
GO

SELECT dbo.UF_SelectLuongGiaoVien(MaGV) AS N'Lương' FROM dbo.GIAOVIEN
GO

DROP FUNCTION dbo.UF_SelectLuongGiaoVien
GO
DROP PROC dbo.USP_SelectALlGiaoVien
GO

---------------------------------------------
-- Tạo function tính một số truyền vào là số chẵn hay số lẽ
CREATE FUNCTION UF_IsOdd(@Num INT)
RETURNS NVARCHAR(20)
AS
BEGIN
	IF (@Num % 2 = 1)
		RETURN N'Số lẽ'
	ELSE
		RETURN N'Số chẵn'

	RETURN N'Không xác định'
END
GO

DROP FUNCTION dbo.UF_IsOdd
GO


-- Tạo function tính tuổi
CREATE FUNCTION UF_AgeOfYear(@year DATE)
RETURNS INT
AS
BEGIN
	RETURN YEAR(GETDATE()) - YEAR(@year)
END
GO

SELECT dbo.UF_AgeOfYear(NGSinh) AS N'Tuổi', dbo.UF_IsOdd(dbo.UF_AgeOfYear(NGSinh)) AS N'Chẵn hay lẽ' FROM	dbo.GIAOVIEN
GO
