USE Quan_Ly_Sinh_Vien
GO

--1/Danh sách các sinh viên khoa “Công nghệ Thông tin” khoá 2002-2006
SELECT SV.*, K.Ten_Khoa, KH.Nam_Bat_Dau, KH.Nam_Ket_Thuc FROM  dbo.Sinh_Vien AS SV
JOIN dbo.Lop AS L
	ON	L.Ma_Lop = SV.Ma_Lop
JOIN dbo.Khoa AS K
	ON K.Ma_Khoa = L.Ma_Khoa
JOIN dbo.Khoa_Hoc AS KH
	ON KH.Ma_Khoa_Hoc = L.Ma_Khoa_Hoc
where K.Ma_Khoa = 'CNTT'
and KH.Nam_bat_Dau = 2002
and KH.Nam_Ket_Thuc = 2006

--2/Cho biết các thông tin (MSSV, họ tên ,năm sinh) 
--của các sinh viên học sớm hơn tuổi quy định 
--(theo tuổi quy định thi sinh viên đủ 18 tuổi khi bắt đầu khóa học)

SELECT dbo.Sinh_Vien.*,dbo.Khoa_Hoc.Nam_Bat_Dau - dbo.Sinh_Vien.Nam_Sinh AS N'Tuổi bắt đầu học' 
FROM dbo.Sinh_Vien
JOIN dbo.Lop ON Lop.Ma_Lop = dbo.Sinh_Vien.Ma_Lop
JOIN dbo.Khoa_Hoc ON Khoa_Hoc.Ma_Khoa_Hoc = Lop.Ma_Khoa_Hoc
WHERE 
dbo.Khoa_Hoc.Nam_Bat_Dau - dbo.Sinh_Vien.Nam_Sinh < 18


--3/Cho biết sinh viên khoa CNTT, khoá 2002-2006 chưa học môn cấu trúc dữ liệu 1
select distinct Sinh_Vien.*  from Sinh_Vien
LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa ON Lop.Ma_Khoa = Khoa.Ma_Khoa
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
LEFT JOIN Mon_Hoc ON Mon_Hoc.Ma_Khoa = Khoa.Ma_Khoa
where Khoa.Ma_Khoa = 'CNTT'
and Khoa_Hoc.Nam_Bat_Dau = 2002
and Khoa_Hoc.Nam_Ket_Thuc = 2006
and Mon_Hoc.Ten_MH NOT LIKE N'Cấu trúc dữ liệu 1'

-- Theo cách truy vấn lồng
select Sinh_Vien.* from Sinh_Vien
LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa ON Lop.Ma_Khoa = Khoa.Ma_Khoa
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
LEFT JOIN Mon_Hoc ON Mon_Hoc.Ma_Khoa = Khoa.Ma_Khoa
where Khoa.Ma_Khoa = 'CNTT'
and Khoa_Hoc.Nam_Bat_Dau = 2002
and Khoa_Hoc.Nam_Ket_Thuc = 2006
and Sinh_Vien.Ma_SV not in
(select Sinh_Vien.Ma_SV  from Sinh_Vien
LEFT JOIN Lop ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
LEFT JOIN Khoa ON Lop.Ma_Khoa = Khoa.Ma_Khoa
LEFT JOIN Khoa_Hoc ON Lop.Ma_Khoa_Hoc = Khoa_Hoc.Ma_Khoa_Hoc
LEFT JOIN Mon_Hoc ON Mon_Hoc.Ma_Khoa = Khoa.Ma_Khoa
where Khoa.Ma_Khoa = 'CNTT'
and Khoa_Hoc.Nam_Bat_Dau = 2002
and Khoa_Hoc.Nam_Ket_Thuc = 2006
and Mon_Hoc.Ten_MH = N'Cấu trúc dữ liệu 1')

/*
BÀI TẬP VỀ NHÀ
4/ Cho biết sinh viên thi không đậu (Diem <5) môn cấu trúc dữ liệu 1 nhưng chưa thi lại. 
5/ Với mỗi lớp thuộc khoa CNTT, cho biết mã lớp, mã khóa học, tên chương trình và số sinh viên thuộc lớp đó 
6/ Cho biết điểm trung bình của sinh viên có mã số 0212003 (điểm trung bình chỉ tính trên lần thi sau cùng của sinh viên) 
*/

--4/ Cho biết sinh viên thi không đậu (Diem <5) môn cấu trúc dữ liệu 1 nhưng chưa thi lại. 
SELECT Ket_Qua.Ma_SV, Ho_Ten, Ma_MH FROM dbo.Ket_Qua
JOIN dbo.Sinh_Vien ON Sinh_Vien.Ma_SV = Ket_Qua.Ma_SV
WHERE Lan_Thi = 1
AND Diem_Thi < 5
AND Ket_Qua.Ma_SV NOT IN (SELECT Ket_Qua.Ma_SV FROM dbo.Ket_Qua
JOIN dbo.Sinh_Vien ON Sinh_Vien.Ma_SV = Ket_Qua.Ma_SV
WHERE Lan_Thi > 1)
GO	

-- 5/ Với mỗi lớp thuộc khoa CNTT, cho biết mã lớp, mã khóa học, tên chương trình và số sinh viên thuộc lớp đó 
SELECT dbo.Lop.Ma_Lop, Khoa_Hoc.Ma_Khoa_Hoc, Ten_CT, Ma_Khoa, COUNT(*) AS N'Số sinh viên' FROM dbo.Lop
JOIN dbo.Khoa_Hoc ON Khoa_Hoc.Ma_Khoa_Hoc = Lop.Ma_Khoa_Hoc
JOIN dbo.Chuong_Trinh_Hoc ON Chuong_Trinh_Hoc.Ma_CT = Lop.Ma_CT
JOIN dbo.Sinh_Vien ON Sinh_Vien.Ma_Lop = Lop.Ma_Lop
GROUP BY dbo.Lop.Ma_Lop, Khoa_Hoc.Ma_Khoa_Hoc, Ten_CT, Ma_Khoa
HAVING dbo.Lop.Ma_Khoa = 'CNTT'
GO


--6/ Cho biết điểm trung bình của sinh viên có mã số 0212003 (điểm trung bình chỉ tính trên lần thi sau cùng của sinh viên) 
SELECT AVG(Diem_Thi) AS N'Điểm trung bình' FROM dbo.Ket_Qua
JOIN (SELECT Ma_MH,MAX(Lan_Thi) AS [last_time] FROM dbo.Ket_Qua
WHERE Ma_SV ='0212003'
GROUP BY Ma_MH) ketqua2 ON	ketqua2.Ma_MH = Ket_Qua.Ma_MH
WHERE Lan_Thi = ketqua2.last_time
AND	Ma_SV = '0212003'