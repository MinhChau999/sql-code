USE HowKteam
GO


-- Xuất ra Danh sách tên bộ môn và số lượng giáo viên của bộ môn đó
SELECT BM.MaBM, BM.TenBM, COUNT(*) AS N'Số giáo viên'
FROM dbo.BOMON AS BM
	JOIN dbo.GIAOVIEN AS GV
	ON GV.MaBM = BM.MaBM
GROUP BY BM.TenBM, BM.MaBM

-- Cột hiển thị phải là thuộc tính nằm trong khối group by hoặc là Agreegate function

-- Xuất ra danh sách tên khoa và số lượng giáo viên của bộ môn đó
SELECT K.MaKhoa, K.TenKhoa, COUNT(*) AS 'Số giáo viên'
FROM dbo.KHOA AS K
	JOIN dbo.BOMON AS BM
	ON BM.MaKhoa = K.MaKhoa
	JOIN dbo.GIAOVIEN AS GV
	ON GV.MaBM = BM.MaBM
GROUP BY k.MaKhoa, K.TenKhoa

-- Lấy ra danh sách giáo viên có lương > lương trung bình của Giáo viên
SELECT HoTen, Luong FROM dbo.GIAOVIEN
WHERE Luong > 
(SELECT SUM(Luong) FROM dbo.GIAOVIEN)/
(SELECT COUNT(*) FROM dbo.GIAOVIEN)

-- Xuất ra tên giáo viên và số lượng đề tài giáo viên đó đã làm
SELECT HoTen, COUNT(*) FROM dbo.GIAOVIEN
	JOIN dbo.THAMGIADT
	ON THAMGIADT.MaGV = GIAOVIEN.MaGV
GROUP BY GIAOVIEN.MaGV, dbo.GIAOVIEN.HoTen

/*
BÀI TẬP:
1. Xuất ra tên giáo viên và số lượng người thân của GV đó
2. Xuât ra tên giáo viên và số lượng đề tài đã hoàn thành mà giáo viên đó tham gia
3. Xuất ra tên khoa có tổng số lương của giáo viên trong khoa là lớn nhất
*/

/*
Agreeate Function

AVG()	Returns the average value
COUNT()	Returns the number of rows
FIRST()	Returns the first value
LAST()	Returns the last value
MAX()	Returns the largest value
MIN()	Returns the smallest value
ROUND()	Rounds a numeric field to the number of decimals specified
SUM()	Returns the sum
*/


/*
string function

CHARINDEX	Searches an expression in a string expression and returns its starting position if found
CONCAT()	 
LEFT()	 
LEN() / LENGTH()	Returns the length of the value in a text field
LOWER() / LCASE()	Converts character data to lower case
LTRIM()	 
SUBSTRING() / MID()	Extract characters from a text field
PATINDEX()	 
REPLACE()	 
RIGHT()	 
RTRIM()	 
UPPER() / UCASE()	Converts character data to upper case
*/