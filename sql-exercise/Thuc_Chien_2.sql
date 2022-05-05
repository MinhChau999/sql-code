USE Quan_Ly_Sinh_Vien
GO

-- nhập liệu cho bảng Khóa Học
Insert into Khoa(Ma_Khoa, Ten_Khoa, Nam_Thanh_Lap)
VALUES
( 'CNTT', N'Công nghệ thông tin',1995),
('VL', N'Vật Lý' , 1970);
GO

-- nhập liệu cho bảng Khóa Học
Insert INTO Khoa_Hoc
VALUES
('K2002', 2002 ,2006),
('K2003', 2003, 2007),
('K2004', 2004, 2008);
GO

-- Nhập liệu cho bảng Chương trình học
Insert into Chuong_Trinh_Hoc values('CQ', N'Chính Quy')
GO

-- nhập liệu cho bảng Lớp
Insert into Lop
VALUES
('TH2002/01', 'CNTT','K2002', 'CQ', 1),
('TH2002/02', 'CNTT','K2002', 'CQ', 2),
('TH2003/01', 'VL','K2003', 'CQ', 1);
GO

-- Nhập liệu cho sinh viên
INSERT INTO	dbo.Sinh_Vien
VALUES
('0212001', N'Nguyễn Vĩnh An', 1984, N'Kinh', 'TH2002/01'),
('0212002', N'Nguyễn Thanh Bình', 1985, N'Kinh', 'TH2002/01'),
('0212003', N'Nguyễn Thanh Cường', 1984, N'Kinh', 'TH2002/02'),
('0212004', N'Nguyễn Quốc Duy', 1983, N'Kinh', 'TH2002/02'),
('0311001', N'Phan Tuấn Anh', 1985, N'Kinh', 'TH2003/01'),
('0311002', N'Huỳnh Thanh Sang', 1984, N'Kinh', 'TH2003/01');
GO

-- Nhập liệu cho bảng Môn học
INSERT INTO dbo.Mon_Hoc (Ma_MH, Ma_Khoa, Ten_MH)
VALUES
('THT01', 'CNTT', N'Toán cao cấp A1'),
('VLT01', 'VL', N'Toán cao cấp A1'),
('THT02', 'CNTT', N'Toán rời rạc'),
('THCS01', 'CNTT', N'Cấu trúc dữ liệu 1'),
('THCS02', 'CNTT', N'Hệ điều hành');
GO

-- Nhập dữ liệu cho bảng kết quả
INSERT INTO dbo.Ket_Qua
VALUES
('0212001', 'THT01', 1,4),
('0212001', 'THT01', 2,7),
('0212002', 'THT01', 1,8),
('0212003', 'THT01', 1,6),
('0212004', 'THT01', 1,9),
('0212001', 'THT02', 1,8),
('0212002', 'THT02', 1,5.5),
('0212003', 'THT02', 1,4),
('0212003', 'THT02', 2,6),
('0212001', 'THCS01', 1,6.5),
('0212002', 'THCS01', 1,4),
('0212003', 'THCS01', 1,7);
GO

-- Nhập liệu cho bảng Giảng Khoa
Insert into Giang_Khoa 
VALUES
('CQ', 'CNTT', 'THT01',2003, 1, 60, 30, 5),
('CQ', 'CNTT', 'THT02',2003, 2, 45, 30, 4),
('CQ', 'CNTT', 'THCS01',2004, 1, 45, 30, 4);
GO
