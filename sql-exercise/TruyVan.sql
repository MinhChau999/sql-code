USE HowKteam
GO

-- Cấu trúc truy vấn
-- Lấy hết các dữ liệu trong bảng bộ môn ra
SELECT * FROM dbo.BOMON

-- Lấy mã đề tài + tên đề tài trong bảng đề tài
SELECT MaDT, TenDT FROM dbo.DETAI

-- Đổi tên cột hiển thị
SELECT MaBM AS 'HowKteam', TenBM AS N'Giáo dục' FROM dbo.BOMON

-- Xuất ra mã giáo viên + tên + tên bộ môn giáo viên đó dạy
SELECT GV.MaGV, GV.HoTen, BM.TenBM FROM dbo.BOMON AS BM, dbo.GIAOVIEN AS GV

-- BÀI TẬP 1:
-- 1. Truy xuất thông tin bảng tham gia đề tài
SELECT * FROM dbo.THAMGIADT
-- 2. Lấy ra mã khoa và tên khoa tương ứng
SELECT MaKhoa, TenKhoa FROM dbo.KHOA
-- 3. Lấy ra mã GV, tên GV và tên người thân tương ứng
SELECT GV.MaGV, GV.HoTen, NT.Ten FROM dbo.GIAOVIEN AS GV, dbo.NGUOITHAN AS NT
WHERE GV.MaGV = NT.MaGV
-- 4. Lấy ra mã GV, tên GV và tên khoa của giáo viên làm việc
SELECT gv.MaGV, gv.HoTen, k.TenKhoa FROM dbo.GIAOVIEN AS gv, dbo.BOMON AS bm, dbo.KHOA AS k
WHERE gv.MaBM = bm.MaBM AND	bm.MaKhoa = k.MaKhoa

