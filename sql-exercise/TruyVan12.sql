USE HowKteam
GO

-- SELECT INTO
-- Lấy hết giữ liệu của bảng GV vào bảng mới tên là TableA
-- Bảng nảy có các record tương ứng như bảng GV
SELECT * INTO TableA
FROM dbo.GIAOVIEN

-- Tạo ra bảng table mới có cột giữ liệu là HoTen tương ứng như bảng GV
-- Giữ liệu của bảng TableB lấy từ GV ra
SELECT Hoten INTO tableB
FROM dbo.GIAOVIEN

-- Tạo ra bảng table mới có cột giữ liệu là HoTen tương ứng như bảng GV
-- Với điều kiện lương > 2000
-- Giữ liệu của bảng TableC lấy từ GV ra
SELECT Hoten INTO tableC
FROM dbo.GIAOVIEN
WHERE Luong > 2000

-- Tạo ra một bảng mới từ nhiều bảng
SELECT MaGV, HoTen, TenBM INTO GVBackup
FROM dbo.GIAOVIEN
JOIN dbo.BOMON
ON BOMON.MaBM = GIAOVIEN.MaBM

-- Tạo ra bảng giáo viên y chang nhưng không có dữ liệu
SELECT * INTO GVBK
FROM dbo.GIAOVIEN
WHERE 1>2

-- INSERT INTO SELECT -->  Coppy dữ liệu vào bảng đã tồn tại
SELECT * INTO CloneGV
FROM dbo.GIAOVIEN
WHERE 1=0

INSERT INTO CloneGV
SELECT * FROM dbo.GIAOVIEN

SELECT * FROM dbo.CloneGV
