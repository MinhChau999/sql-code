USE HowKteam
GO

-- Trigger sẽ được gọi mỗi khi có thao tác thay đổi thông tin bảng
-- Inserted: chứa những trường đã Insert / Update vào bảng
-- Deleted: Chứa những trường bị xóa khỏi bảng

CREATE TRIGGER UTG_InsertGiaoVien
ON dbo.GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
	--ROLLBACK TRAN
	PRINT 'Trigger'
END
GO

ALTER TRIGGER UTG_InsertGiaoVien
ON dbo.GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
	ROLLBACK TRAN
	PRINT 'Trigger2'
END
GO

DROP TRIGGER UTG_InsertGiaoVien
GO	
--------------------------------------------------
-- Không cho phép xóa thông tin giao viên có tuổi lớn hơn 50

CREATE TRIGGER UTG_AbortOlderThan
ON dbo.GIAOVIEN
FOR	DELETE
AS
BEGIN
	DECLARE @Count INT = 0
	SELECT @Count = COUNT(*) FROM dbo.GIAOVIEN
	WHERE YEAR(GETDATE()) - YEAR(NGSinh) > 50
	IF (@Count > 1)
		BEGIN
			PRINT N'Không được xóa giáo viên trên 50 tuổi'
			ROLLBACK TRAN
		END
END
GO

SELECT * FROM dbo.GIAOVIEN

DELETE dbo.GIAOVIEN WHERE MaGV = '011'

