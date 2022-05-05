USE cuahangthoitrang
GO

-- 6.1.	
select * from hang
order by dongia asc;

-- 6.2.
select mahh, tenhh, donvitinh, dongia, lh.maloai  from hanghoa hh
join loaihang lh on lh.maloai = hh.loai
where tenloai like 'Thời trang%';

-- 6.3.
select maloai, tenloai, count(mahh) as 'Tổng số mặt hàng' from loaihang lh
join hanghoa hh on hh.loai = lh.maloai 
group by maloai, tenloai
order by count(mahh) desc;

-- 6.4.	
select ctpx.sophieu as 'Số phiếu xuất', 
	ngayxuat, tench, hh.mahh, tenhh, tenloai, soluong, dongia, 
	(soluong * dongia) as 'Thành tiền' from chitietphieuxuat ctpx
join hanghoa hh on hh.mahh = ctpx.mahh
join phieuxuat px on px.sophieu = ctpx.sophieu
join loaihang lh on lh.maloai = hh.loai
join cuahang ch on ch.mach = px.mach 
group by ngayxuat, tench, hh.mahh, tenhh, tenloai, soluong, dongia;

-- 6.5.	
select concat(month(ngayxuat),'/',year(ngayxuat)) as 'Tháng/Năm', tench,  sum(soluong * dongia) as 'Tổng thành tiền' from cuahang ch
join phieuxuat px on ch.mach = px.mach 
join chitietphieuxuat ctpx on px.sophieu = ctpx.sophieu
join hanghoa hh on hh.mahh = ctpx.mahh
group by concat(month(ngayxuat),'/',year(ngayxuat)), tench;

-- 6.6.	 
select px.ngayxuat, sum(ctpx.soluong) as 'số lượng xuất kho' from chitietphieuxuat ctpx
join hanghoa hh on hh.mahh = ctpx.mahh
join phieuxuat px on px.sophieu = ctpx.sophieu
where month(ngayxuat) = 10 
group by tenhh
order by sum(ctpx.soluong) desc 
limit 5;

-- 6.7.	
select tench, count(px.mach) as 'số lần nhập hàng', sum(soluong * dongia) as 'Số tiền thanh toán'from chitietphieuxuat ctpx
join hanghoa hh on hh.mahh = ctpx.mahh
join phieuxuat px on px.sophieu = ctpx.sophieu
join loaihang lh on lh.maloai = hh.loai
join cuahang ch on ch.mach = px.mach 
where tench like '%Vân Thanh Fashion - chi nhánh quận 3%'
group by tench;

-- 6.8.	
select ngayxuat, count(px.sophieu) as 'tổng số lần xuất hàng', sum(soluong * dongia) as 'Tổng thành tiền' from chitietphieuxuat ctpx
join hanghoa hh on hh.mahh = ctpx.mahh
join phieuxuat px on px.sophieu = ctpx.sophieu
group by ngayxuat;

-- 6.9.	
set sql_safe_updates = 0;
Update phieuxuat 
set ngayxuat = date(now())
where ngayxuat is null;
select * from phieuxuat;

-- 6.10.	
Update hanghoa 
set dongia = (dongia - dongia*0.1)
where loai = (select maloai from loaihang where tenloai like '%Đồng phục học sinh%');

-- 6.11.	
select * from cuahang 
where mach not in (select mach from phieuxuat );

-- 6.12.	
select hh.mahh, tenhh, sum(soluong) as 'tổng số lượng xuất kho' from chitietphieuxuat ctpx
join hanghoa hh on hh.mahh = ctpx.mahh
group by mahh, tenhh
having sum(soluong) <= all (select sum(soluong) from chitietphieuxuat ctpx 
						join hanghoa hh on hh.mahh = ctpx.mahh
						group by hh.mahh);

select hh.mahh, sum(soluong) as 'tổng số lượng xuất kho' from chitietphieuxuat ctpx 
join hanghoa hh on hh.mahh = ctpx.mahh
group by hh.mahh;

-- 6.13.	
select mahh, tenhh, tenloai from hanghoa hh
join loaihang lh on lh.maloai = hh.loai
where hh.mahh not in (select mahh from chitietphieuxuat );






