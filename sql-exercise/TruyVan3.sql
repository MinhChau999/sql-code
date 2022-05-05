-- TRUY VẤN 3: TÌM KIẾM GẦN ĐÚNG
USE HowKteam
GO	

--1/ Xuất ra thông tin giáo viên mma2ten6 bắt đầu bằng chữ l
SELECT * FROM dbo.GIAOVIEN
WHERE HoTen LIKE 'l%'

--2/ Xuất ra thông tin kết thúc bằng chữ n
SELECT * FROM dbo.GIAOVIEN
WHERE HoTen LIKE '%n'

--3/ Xuất ra thông tin giáo viên mà tên có tồn tại chữ ng ở vị trí bất kỳ
SELECT * FROM dbo.GIAOVIEN
WHERE HoTen LIKE '%ng%'

--4/ Xuất ra thông tin mà giáo viên có tồn tại chữ 'ế'
SELECT * FROM dbo.GIAOVIEN
WHERE HoTen LIKE N'%ế%'

--5/ Xuất ra thông tin giáo viên có tồn tại chữ 'iế' và có độ dài 4 ký tự
SELECT * FROM dbo.GIAOVIEN
WHERE HoTen LIKE N'_%iế%_'

--6/ Xuất ra thông tin của giáo viên mà tên bắt đầu bằng chữ Tr và kết thúc bằng chữ ng
SELECT * FROM dbo.GIAOVIEN
WHERE HoTen LIKE 'Tr%ng'