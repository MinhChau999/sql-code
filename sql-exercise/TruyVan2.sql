USE HowKteam
GO

-- Lấy ra giáo viên là nữ lương > 200
SELECT * FROM dbo.GIAOVIEN
WHERE Luong > 2000 AND Phai = N'Nữ'

-- Lấy ra giáo viên nhỏ hơn 45 tuổi
SELECT * FROM dbo.GIAOVIEN
WHERE YEAR(GETDATE()) - YEAR(NGSinh) > 45

-- Lấy ra họ tên, năm sinh và tuổi của giao viên
SELECT HoTen, NGSinh, YEAR(GETDATE()) - YEAR(NGSinh)  FROM dbo.GIAOVIEN
WHERE YEAR(GETDATE()) - YEAR(NGSinh) > 45

-- Lấy ra giáo viên là trưởng bộ môn
SELECT GV.* FROM dbo.GIAOVIEN AS GV, dbo.BOMON AS BM
WHERE GV.MaGV = BM.TruongBM

-- Dếm số lượng giáo viên
-- COUNT(*) -> Đếm số lượng của tất cả record
-- COUNT(tên trường) -> Đếm số lượng của tên trường
SELECT COUNT(*) AS N'Số lượng giáo viên' FROM dbo.GIAOVIEN

-- Đếm số lượng người thân của giáo viên có mã GV là 007
SELECT COUNT(*) AS N'Số người thân' 
FROM dbo.GIAOVIEN AS GV, dbo.NGUOITHAN AS NT
WHERE GV.MaGV = '007' AND gv.MaGV = NT.MaGV

-- Lấy ra tên giáo viên và tên đề tài người đó tham gia khi mà người đó tham gia nhiều hơn 1 lần
-- Truy vấn lồng

-- BÀI TẬP:
-- 1. Xuất ra thông tin Giáo viên và Giáo viên quản lý chủ nhiệm của người đó
SELECT GV1.HoTen AS GVQL, GV2.HoTen FROM dbo.GIAOVIEN AS GV1, dbo.GIAOVIEN AS GV2
WHERE GV1.GVQLCM = GV2.MaGV
-- 2. Xuất ra số lượng giáo viên của CNTT
SELECT COUNT(*) FROM dbo.GIAOVIEN AS GV, dbo.BOMON AS BM, dbo.KHOA AS K
WHERE GV.MaBM = BM.MaBM
AND	BM.MaKhoa = K.MaKhoa
AND	k.MaKhoa = 'CNTT'
-- 3. Xuất ra thông tin giáo viên và đề tài người đó tham gia khi kết quả là đạt
SELECT GV.* FROM dbo.GIAOVIEN AS GV, dbo.THAMGIADT AS TGDT
WHERE GV.MaGV = TGDT.MaGV
AND	TGDT.KetQua = N'Đạt'
