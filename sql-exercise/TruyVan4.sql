-- Inner Join
USE HowKteam
GO	

--1/ Xuất ra thông tin giáo viên (mã GV và tên) và tên người thân tương ứng của giáo viên đó.
SELECT GV.MaGV, GV.HoTen, NT.Ten AS "NGUOI THAN"
FROM dbo.GIAOVIEN AS GV
INNER JOIN dbo.NGUOITHAN AS	NT
ON NT.MaGV = GV.MaGV

--2/ Xuất ra thông tin đề tài (mã DT, tên DT) và tên chủ đề của đề tài đó
SELECT DT.MaDT, DT.TenDT, CD.TenCD
FROM dbo.DETAI AS DT
INNER JOIN dbo.CHUDE AS CD
ON CD.MaCD = DT.MaCD

--3/ Xuất ra thông tin đề tài (mã DT, tên DT) và tên giáo viên chủ nhiệm đề tài đó
SELECT DT.MaDT, DT.TenDT, GV.HoTen AS N'Giáo Viên'
FROM dbo.DETAI AS DT
INNER JOIN dbo.GIAOVIEN AS GV
ON GV.MaGV = DT.GVCNDT

--4/ Xuất ra thông tin giáo viên (mã GV, tên GV) và tên khoa mà giáo viên đó giảng dạy
SELECT GV.MaGV, GV.HoTen, K.TenKhoa
FROM dbo.GIAOVIEN AS GV
INNER JOIN dbo.BOMON AS BM ON BM.MaBM = GV.MaBM
INNER JOIN dbo.KHOA AS K ON K.MaKhoa = BM.MaKhoa

--5/ Xuất ra tên đề tài và tên các giáo viên tham gia đề tài
-- Gợi ý: Bạn có thể dựa trên CSDL của 3 table: DETAI, THAMGIADE, GIAOVIEN
SELECT DT.MaDT,DT.TenDT, GV.HoTen
FROM dbo.THAMGIADT AS TGDT
INNER JOIN dbo.DETAI AS DT ON DT.MaDT = TGDT.MaDT
INNER JOIN dbo.GIAOVIEN AS GV ON GV.MaGV = TGDT.MaGV

-- INNER JOIN KẾT HỢP ĐIỀU KIỆN
--6/ Xuất ra thông tin giáo viên nam, bộ môn và khoa mà giáo viên đó giảng dạy
SELECT GV.MaGV, Gv.HoTen,GV.Phai,BM.TenBM, K.TenKhoa
FROM dbo.GIAOVIEN AS GV
	JOIN dbo.BOMON AS BM ON BM.MaBM = GV.MaBM
	JOIN dbo.KHOA AS K ON K.MaKhoa = BM.MaKhoa
WHERE GV.Phai = 'NAM'

--7/ Xuất ra thông tin đề tài (Mã DT, tên DT) và tên giáo viên chủ nhiệm đề tài có ngày kết thúc trước năm 2009
SELECT DT.MaDT, DT.TenDT, GV.HoTen AS N'GV Chủ Nhiệm', YEAR(DT.NgayKT) AS N'Năm Kết Thúc'
FROM dbo.DETAI AS DT
	JOIN dbo.GIAOVIEN AS GV ON GV.MaGV = DT.GVCNDT
WHERE YEAR(DT.NgayKT) < 2009