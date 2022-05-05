-- JOIN
USE HowKteam
GO

-- Gom 2 bảng lại, theo điều kiện, bên nào không có điều kiện thì để null
SELECT * FROM dbo.GIAOVIEN FULL OUTER JOIN dbo.BOMON
ON BOMON.MaBM = GIAOVIEN.MaBM

-- Cross join là tổ hợp mỗi record của bảng A với all record của bảng B
SELECT * FROM dbo.GIAOVIEN CROSS JOIN dbo.BOMON

-- Left join 
-- Bảng bên phải nhập vào bảng bên trái
-- Record nào bảng phải không có thì để null
-- Record nào bên trái không có thì không điền vào
SELECT * FROM dbo.GIAOVIEN LEFT JOIN dbo.BOMON
ON BOMON.MaBM = GIAOVIEN.MaBM

-- Right join
SELECT * FROM dbo.GIAOVIEN RIGHT JOIN dbo.BOMON
ON BOMON.MaBM = GIAOVIEN.MaBM

-- union
SELECT MaGV FROM dbo.GIAOVIEN
WHERE Luong >=2500
UNION
SELECT MaGV FROM dbo.NGUOITHAN
WHERE Phai = N'Nữ'

