
/*
Hãy viết các Stored Procedure sau:

1/ In danh sách các sinh viên của 1 lớp học
2/ Nhập vào 2 sinh viên, 1 môn học, tìm xem sinh viên nào có điểm thi môn học đó lần đầu tiên là cao hơn.
3/ Nhập vào 1 môn học và 1 mã sv, kiểm tra xem sinh viên có đậu môn này trong lần thi đầu tiên không, nếu đậu thì xuất ra là “Đậu”, không thì xuất ra “Không đậu”
4/ Nhập vào 1 khoa, in danh sách các sinh viên (mã sinh viên, họ tên, ngày sinh) thuộc khoa này.
5/ Nhập vào 1 sinh viên và 1 môn học, in điểm thi của sinh viên này của các lần thi môn học đó.
Ví dụ:  Lần 1 : 10 Lần 2: 8

6/ Nhập vào 1 sinh viên, in ra các môn học mà sinh viên này phải học.
7/ Nhập vào 1 môn học, in danh sách các sinh viên đậu môn này trong lần thi đầu tiên. 
8/ In điểm các môn học của sinh viên có mã số là maSinhVien được nhập vào.
Chú ý: điểm của môn học là điểm thi của lần thi sau cùng
*/

--1/ In danh sách các sinh viên của 1 lớp học
CREATE PROC KP_List_SV_From_Lop
	@malop VARCHAR(10)
AS
BEGIN
	SELECT * FROM dbo.Sinh_Vien
	WHERE Ma_Lop = @malop
END
GO
EXEC dbo.KP_List_SV_From_Lop @malop = 'TH2002/01' -- varchar(10)
GO

--2/ Nhập vào 2 sinh viên, 1 môn học, tìm xem sinh viên nào có điểm thi môn học đó lần đầu tiên là cao hơn.
CREATE PROC KP_SV_More_Score
	@masv1 VARCHAR(10),
	@masv2 VARCHAR(10),
	@mamh VARCHAR(10)
AS
BEGIN
	DECLARE @diem1 FLOAT
	DECLARE @diem2 FLOAT
	SELECT @diem1 = Diem_Thi FROM dbo.Ket_Qua
	WHERE Ma_SV = @masv1 AND Ma_MH = @mamh AND Lan_Thi = '1'
	SELECT @diem2 = Diem_Thi FROM dbo.Ket_Qua
	WHERE Ma_SV = @masv2 AND Ma_MH = @mamh AND Lan_Thi = '1'
	IF (@diem1 > @diem2)
		PRINT @masv1
	ELSE IF (@diem1 < @diem2)
		PRINT @masv2
	ELSE
		PRINT N'Bằng nhau'
END
GO

SELECT * FROM dbo.Ket_Qua
EXEC dbo.KP_SV_More_Score @masv1 = '0212003', -- varchar(10)
                          @masv2 = '0212004', -- varchar(10)
                          @mamh = 'THT01'   -- varchar(10)
GO

--3/ Nhập vào 1 môn học và 1 mã sv, kiểm tra xem sinh viên có đậu môn này trong lần thi đầu tiên không, 
-- nếu đậu thì xuất ra là “Đậu”, không thì xuất ra “Không đậu”

CREATE PROC KP_Pass_Or_Not
	@mamh VARCHAR(10),
	@masv VARCHAR(10)
--DECLARE @mamh VARCHAR(10)
--DECLARE @masv VARCHAR(10)
--SET @mamh = 'THT01'
--SET @masv = '0212001'
--SELECT Diem_Thi FROM dbo.Ket_Qua WHERE Ma_MH = @mamh AND Ma_SV = @masv AND Lan_Thi = '1'
AS
BEGIN
	IF ((SELECT Diem_Thi FROM dbo.Ket_Qua WHERE Ma_MH = @mamh AND Ma_SV = @masv AND Lan_Thi = '1') < 5)
		PRINT N'Không đậu'
	ELSE
		PRINT N'Đậu'
END

EXEC dbo.KP_Pass_Or_Not @mamh = 'THT01', -- varchar(10)
                        @masv = '0212001'  -- varchar(10)
GO

-- 4/ Nhập vào 1 khoa, in danh sách các sinh viên (mã sinh viên, họ tên, ngày sinh) thuộc khoa này.
CREATE PROC FP_List_SV_Of_Khoa
@makhoa VARCHAR(10)
AS
BEGIN
	SELECT Ma_SV, Ho_Ten, Nam_Sinh FROM dbo.Sinh_Vien
	JOIN dbo.Lop ON Lop.Ma_Lop = Sinh_Vien.Ma_Lop
	JOIN dbo.Khoa ON Khoa.Ma_Khoa = Lop.Ma_Khoa
	WHERE Khoa.Ma_Khoa = @makhoa
END

EXEC dbo.FP_List_SV_Of_Khoa @makhoa = 'CNTT' -- varchar(10)
GO

/*
5/ Nhập vào 1 sinh viên và 1 môn học, in điểm thi của sinh viên này của các lần thi môn học đó.
Ví dụ:  Lần 1 : 10 Lần 2: 8
*/
CREATE PROC KP_Result_One_MH_Of_SV
@masv VARCHAR(10),
@mamh VARCHAR(10)
AS
BEGIN
	SELECT Lan_Thi FROM dbo.Ket_Qua
	WHERE Ma_SV = @masv
	AND Ma_MH = @mamh
END
GO

EXEC dbo.KP_Result_One_MH_Of_SV @masv = '0212001', -- varchar(10)
                                @mamh = 'THT01'  -- varchar(10)
GO

-- 6/ Nhập vào 1 sinh viên, in ra các môn học mà sinh viên này phải học.

CREATE PROC KP_List_MH
@masv VARCHAR(10)
AS
BEGIN
	SELECT Ma_MH, Ten_MH FROM dbo.Mon_Hoc
	JOIN dbo.Lop ON Lop.Ma_Khoa = Mon_Hoc.Ma_Khoa
	JOIN dbo.Sinh_Vien ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
	WHERE Ma_SV = @masv
END
go

EXEC dbo.KP_List_MH @masv = '0212004' -- varchar(10)
GO

-- 7/ Nhập vào 1 môn học, in danh sách các sinh viên đậu môn này trong lần thi đầu tiên. 
CREATE PROC KP_List_SV_Pass_Once_Time
@mamh VARCHAR(10)
AS
BEGIN
SELECT * FROM dbo.Sinh_Vien
JOIN dbo.Ket_Qua ON Ket_Qua.Ma_SV = Sinh_Vien.Ma_SV
WHERE Ma_MH = @mamh
AND Lan_Thi = 1
AND Diem_Thi >= 5
END
GO
EXEC dbo.KP_List_SV_Pass_Once_Time @mamh = 'THT01' -- varchar(10)
GO
/*
8/ In điểm các môn học của sinh viên có mã số là maSinhVien được nhập vào.
Chú ý: điểm của môn học là điểm thi của lần thi sau cùng
*/
CREATE PROC KP_List_Result_Of_SV
@masv VARCHAR(10)
AS
BEGIN
	SELECT Mon_Hoc.Ma_MH, Ten_MH, dbo.KF_Last_Score_SV_With_MH(@masv,Mon_Hoc.Ma_MH) AS N'Điểm thi' FROM dbo.Mon_Hoc
	JOIN dbo.Ket_Qua ON Ket_Qua.Ma_MH=dbo.Mon_Hoc.Ma_MH
	WHERE dbo.Ket_Qua.Ma_SV = @masv
	GROUP BY dbo.Mon_Hoc.Ma_MH, Ten_MH
END
GO

EXEC dbo.KP_List_Result_Of_SV @masv = '0212001' -- varchar(10)
GO

/*Thêm 1 quan hệ
XepLoai:
maSV	diemTrungBinh	ketQua	hocLuc

--9/ Quy định : ketQua của sinh viên là ”Đạt‘ nếu diemTrungBinh (chỉ tính các môn đã có điểm) của sinh viên đó lớn hơn hoặc bằng 5 và không quá 2 môn dưới 4 điểm, ngược lại thì kết quả là không đạtĐưa dữ liệu vào bảng xếp loại. Sử dụng function 3 đã viết ở bài 4
Đối với những sinh viên có ketQua là ”Đạt‘ thì hocLuc được xếp loại như sau:
 diemTrungBinh >= 8 thì hocLuc là ”Giỏi”
7 < = diemTrungBinh < 8 thì hocLuc là ”Khá” Còn lại là ”Trung bình”  

--10/ Với các sinh viên có tham gia đầy đủ các môn học của khoa, chương trình mà sinh viên đang theo học, hãy in ra điểm trung bình cho các sinh viên này.
Chú ý: Điểm trung bình được tính dựa trên điểm thi lần sau cùng. Sử dụng function 3 đã viết ở bài 4 
*/

CREATE TABLE Xep_Loai
(
	Ma_SV VARCHAR(10) PRIMARY KEY,
	Diem_TB FLOAT,
	Ket_Qua NVARCHAR(10),
	Xep_Loai NVARCHAR(20),
	FOREIGN KEY (Ma_SV) REFERENCES dbo.Sinh_Vien(Ma_SV)
)
GO
