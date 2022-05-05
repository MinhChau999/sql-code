USE HowKteam
GO 

-- xuất ra số lượng giáo viên trong từng bộ môn mà số giáo viên > 2
-- having -> như where của select nhưng giành cho group by
-- having là where của group by

SELECT GIAOVIEN.MaBM, TenBM, COUNT(*) FROM dbo.BOMON
	JOIN dbo.GIAOVIEN
	ON dbo.BOMON.MaBM = dbo.GIAOVIEN.MaBM
GROUP BY GIAOVIEN.MaBM, TenBM
HAVING COUNT(*) > 2

-- Xuất ra mức lương và tổng tuổi của giáo viên nhận mức lương đó
-- và có người thân
-- và tuổi phải lớn hơn tuổi trung bình
SELECT LUONG, SUM(YEAR(GETDATE()) - YEAR(GIAOVIEN.NGSINH)) 
FROM dbo.GIAOVIEN
JOIN dbo.NGUOITHAN
ON NGUOITHAN.MaGV = GIAOVIEN.MaGV
AND GIAOVIEN.MAGV IN (SELECT MaGV FROM dbo.NGUOITHAN)
GROUP BY LUONG, GIAOVIEN.NGSINH
HAVING YEAR(GETDATE()) - YEAR(GIAOVIEN.NGSINH) > 
(
	(SELECT SUM(YEAR(GETDATE()) - YEAR(GIAOVIEN.NGSINH)) FROM dbo.GIAOVIEN)
	/ (SELECT COUNT(*) FROM dbo.GIAOVIEN)
)
