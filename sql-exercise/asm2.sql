create database cuahangthoitrang
GO

USE cuahangthoitrang
GO	

create table LoaiHang(
	maloai char(4) primary key,
    tenloai nvarchar(50) not null
);
GO

create table MatHang(
	maloai char(4),
	mamh char (4) primary key,
    tenhh nvarchar (50) not null,
    donvitinh nchar(5) not null,
    dongia int not null,
    foreign key (maloai) references loaiHang(maloai)
);
GO	
create table CuaHang(
	mach char(4) primary key,
    tench nvarchar(50) not null,
    diachi nvarchar(60) not null,
    sodt char(13) not null,
    email char (30) unique null,
    tenndd nvarchar(30) not null
);
GO	
create table PhieuXuat(
	sophieu char(5) primary key,
    ngaylp date not null,
    ngayxh date null,
    mach char(4),
    tennlp varchar(50) not null,
    foreign key (mach) references cuaHang(mach)
);
GO	
create table CTPhieuXuat(
	sophieu char(5),
	foreign key (sophieu) references phieuXuat(sophieu),
    mamh char(4),
    foreign key (mamh) references matHang(mamh),
    soluong int not null,
    ghichu nvarchar(30) null
);
GO	

INSERT INTO dbo.loaiHang
(
    maloai,
    tenloai
)
VALUES ('DPHF','Đồng phục học sinh'),
	('PKTT',N'Phụ kiện thời trang'),
    ('TTNA',N'Thời trang nam công sở'),
    ('TTNU',N'Thời trang Nữ công sở'),
    ('TTTE',N'Thời trang Trẻ em'),
    ('TTTN',N'Thời trang trung niên');
GO

insert into cuahang(mach, tench, diachi, sodt, email, tenndd)
values  ('CH01',N'Vân Thanh Fashion - Chi nhánh Quận 5','123 Nguyễn Trãi, Quận 5, Tp.HCM','0909099099',' thanhtt@gmail.com',N'Trần Tuấn Thành'),
		('CH02',N'Vân Thanh Fashion - TTTM AERON TÂN PHU','30 Bờ Bao Tân Thẳng, Quận Tân Phú, Tp HCM','0909099099','areontp@gmail.com',N'Nguyễn Thành Công'),
        ('CH03',N'Vân Thanh Fashion - Chi nhánh Quận 3','123 Nguyễn Trãi, Quận 5, Tp.HCM','0862887733','huongnk@gmail.com',N'Nguyễn Kim Hương'),
        ('CH04',N'Vân Thanh Fashion - Chi nhánh Vũng Tàu','123 Nguyễn Trãi, Quận 5, Tp.HCM','0909099099','thanhdt@gmail.com',N'Đỗ Thị Thanh'),
        ('CH05',N'Vân Thanh Fashion - Chi nhánh Hà Nội','123 Nguyễn Trãi, Quận 5, Tp.HCM','0909099099','',N'Trần Quốc Hậu');
GO

insert into mathang(mamh, tenhh, donvitinh, dongia, maloai)
values ('AK01',N'Áo khoác KaKi nữ Hàn Quốc',N'Cái',285000,'TTNU'),
		('AK02',N'Áo khoác nữ dáng dài',N'Cái',675000,'TTNU'),
        ('AO01',N'Áo thun bé trai ngắn tay',N'Cái',85000,'TTTE'),
		('AO02',N'Áo khoác lửng trẻ em cao cấp',N'Cái',320000,'TTTE'),
        ('BO01',N'Bộ thun trẻ em',N'Bộ',280000,'TTTE'),
	    ('DA01',N'Đầm caro công sở',N'Cái',252000,'TTNU'),
        ('DP01',N'Đồng phục học sinh',N'Bộ',180000,'DPHS'),
        ('DP02',N'Đầm phục học sinh THCS',N'Bộ',220000,'DPHS'),
        ('SM01',N'Áo sơ mi nam',N'Cái',315000,'TTNA'),
        ('SM02',N'Sơ mi ngắn tay cổ trụ',N'Cái',285000,'TTNA');
GO
SELECT * FROM dbo.MatHang

insert into dbo.PhieuXuat
(
    sophieu,
    ngaylp,
    ngayxh,
    mach,
    tennlp
)
VALUES
	('PX011','2021-07-06','2021-07-12','CH01','ao'),
	('PX012','2021-07-12','2021-07-20','CH02','quan'),
	('PX013','2021-08-04','2021-08-20','CH05','quan'),
	('PX021','2021-08-09','2021-08-20','CH01','ao khoac'),
	('PX022','2021-08-22','2021-09-20','CH01','ao'),
	('PX023','2021-09-06','2021-09-20','CH02','ao somi'),
	('PX024','2021-09-13','2021-09-20','CH05','ao'),
	('PX025','2021-09-16','2021-09-25','CH01','quan'),
	('PX031','2021-10-15','','CH01','ao'),
	('PX032','2021-01-15','','CH02','quan'),
	('PX033','2021-12-15','','CH01','quan');
GO

insert into dbo.CTPhieuXuat
(
    sophieu,
    mamh,
    soluong,
    ghichu
)
values ('PX021','AO02','20',N''),
		('PX021','DA01','20',N'Đủ size'),
        ('PX025','AK01','10',N'Nhiêu màu'),
        ('PX025','DP01','100',N'Áo + váy'),
        ('PX025','SM01','30',N''),
        ('PX031','BO01','30',N''),
        ('PX032','DP01','200',N'Áo + váy'),
        ('PX032','DP02','200',N''),
        ('PX033','AK01','12',N'Màu xanh, hồng, tím'),
        ('PX033','AO01','20',N'Size 16-20'),
        ('PX033','AO02','10',N''),
        ('PX033','BO01','50',N'');
GO