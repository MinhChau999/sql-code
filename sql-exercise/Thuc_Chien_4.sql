/*
Hãy viết các function sau :
1/ Với 1 mã sinh viên và 1 mã khoa, kiểm tra xem sinh viên có thuộc khoa này không (trả về đúng hoặc sai)
2/ Tính điểm thi sau cùng của một sinh viên trong một môn học cụ thể
3/ Tính điểm trung bình của một sinh viên (chú ý : điểm trung bình được tính dựa trên lần thi sau cùng), sử dụng function 2 đã viết
*/
/*
CREATE FUNCTION [schema_name.]function_name
( [ @parameter [ AS ] [type_schema_name.] datatype
[ = default ] [ READONLY ]
, @parameter [ AS ] [type_schema_name.] datatype
[ = default ] [ READONLY ] ]
)

RETURNS return_datatype

[ WITH { ENCRYPTION
| SCHEMABINDING
| RETURNS NULL ON NULL INPUT
| CALLED ON NULL INPUT
| EXECUTE AS Clause ]

[ AS ]

BEGIN

[declaration_section]

executable_section

RETURN return_value

END;
*/

USE Quan_Ly_Sinh_Vien
GO

--1/ Với 1 mã sinh viên và 1 mã khoa, kiểm tra xem sinh viên có thuộc khoa này không (trả về đúng hoặc sai)

CREATE FUNCTION	KF_Is_SV_In_Khoa (@masv VARCHAR(10), @makhoa VARCHAR(10))
RETURNS BIT
AS
BEGIN
	IF (EXISTS (
		SELECT * FROM dbo.Sinh_Vien
		JOIN dbo.Lop ON Lop.Ma_Lop = Sinh_Vien.Ma_Lop
		JOIN dbo.Khoa ON Khoa.Ma_Khoa = Lop.Ma_Khoa
		WHERE Ma_SV = @masv
		AND Khoa.Ma_Khoa = @makhoa
	))
	RETURN 1
	ELSE 
	RETURN 0
RETURN 0
END
GO

SELECT dbo.Sinh_Vien.Ma_SV, dbo.Sinh_Vien.Ho_Ten, dbo.KF_Is_SV_In_Khoa(Ma_SV,'CNTT') AS 'Khoa CNTT'
FROM dbo.Sinh_Vien
GO

--2/ Tính điểm thi sau cùng của một sinh viên trong một môn học cụ thể
CREATE FUNCTION KF_Last_Score_SV_With_MH(@ma_sv VARCHAR(10), @ma_mh VARCHAR(10))
RETURNS FLOAT
AS
BEGIN
	DECLARE @diem FLOAT
	SELECT @diem = Diem_Thi FROM dbo.Ket_Qua AS KQ
	WHERE KQ.Ma_SV =@ma_sv
	AND KQ.Ma_MH = @ma_mh
	AND	KQ.Lan_Thi = (SELECT MAX(Lan_Thi) AS 'Last' FROM dbo.Ket_Qua
		WHERE Ma_SV =@ma_sv
		AND Ma_MH = @ma_mh
		GROUP BY Ma_MH, Ma_SV
		)
	RETURN @diem
END
GO

SELECT Ma_SV, Ma_MH, dbo.KF_Score_SV_Per_MH(Ma_SV, Ma_MH) AS 'Last_score' FROM dbo.Ket_Qua
GROUP BY Ma_MH, Ma_SV
GO

--3/ Tính điểm trung bình của một sinh viên (chú ý : điểm trung bình được tính dựa trên lần thi sau cùng), sử dụng function 2 đã viết
CREATE FUNCTION KF_AVG_Score_Of_Student(@masv VARCHAR(10))
RETURNS FLOAT
AS
BEGIN
	DECLARE @diem FLOAT
    SELECT @diem = AVG(ketqua2.Last_score) FROM 
	(SELECT Ma_SV, Ma_MH, dbo.KF_Score_SV_Per_MH(@masv, Ma_MH) AS 'Last_score' FROM dbo.Ket_Qua
	GROUP BY Ma_MH, Ma_SV) AS ketqua2
	WHERE Ma_SV = @masv
	GROUP BY ketqua2.Ma_SV
	RETURN @diem
END
GO

SELECT * FROM dbo.Sinh_Vien
WHERE
Ma_SV NOT IN (SELECT Ma_SV FROM	dbo.Ket_Qua)
GO

SELECT *, dbo.KF_AVG_Score_Of_Student(Ma_SV) AS 'Điểm trung bình' FROM dbo.Sinh_Vien
GO


/*
Bài tập về nhà
4/ Nhập vào 1 sinh viên và 1 môn học, trả về các điểm thi của sinh viên này trong các lần thi của môn học đó.
5/ Nhập vào 1 sinh viên, trả về danh sách các môn học mà sinh viên này phải học. 
*/

-- 4/ Nhập vào 1 sinh viên và 1 môn học, trả về các điểm thi của sinh viên này trong các lần thi của môn học đó.

CREATE FUNCTION KF_Score_Sv_With_MH(@masv VARCHAR(10), @mamh VARCHAR(10))
RETURNS TABLE
RETURN
	SELECT Lan_Thi, Diem_Thi FROM dbo.Ket_Qua
	WHERE Ma_SV = @masv
	AND Ma_MH = @mamh
GO

SELECT * FROM dbo.KF_Score_Sv_With_MH('0212002','THT01')
GO


-- 5/ Nhập vào 1 sinh viên, trả về danh sách các môn học mà sinh viên này phải học. 
CREATE FUNCTION KF_List_MH(@masv VARCHAR(10))
RETURNS TABLE
RETURN
	SELECT dbo.Mon_Hoc.* FROM dbo.Mon_Hoc
	JOIN dbo.Khoa ON Khoa.Ma_Khoa = Mon_Hoc.Ma_Khoa
	JOIN dbo.Lop ON Lop.Ma_Khoa = Khoa.Ma_Khoa
	JOIN dbo.Sinh_Vien ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
	WHERE dbo.Sinh_Vien.Ma_SV = @masv
GO


SELECT * FROM dbo.Sinh_Vien
SELECT * FROM dbo.Mon_Hoc