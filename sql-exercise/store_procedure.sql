USE HowKteam
GO	

/*
-- STORE PROCEDURE
- Là chương trình hay thủ tục
- Ta có thể dùng Transact-SQL EXCUTE (EXCE) để thực thi các Stored procedure
- STORE PROCEDURE Khác với các hàm xử lý là giá trị trả về của chúng
- Không chứa trong tên và chúng không được sử dụng trực tiếp trong biểu thức
*/

/*
- Động: Có thể chỉnh sửa khối lệnh, tái sử dụng nhiều lần
- Nhanh hơn: Tự phân tích cú pháp cho tối ưu. Và tạo bản sao để lần sau không thực thi lại từ đầu
- Bảo mật: Giới hạn quyền cho user nào sử dụng, user nào không
- Giảm bandwidth: Với các gói transaction lớn. Vài ngàn dòng lệnh một lúcluc1i2 dùng store sẽ đảm bảo
*/

/*
CREATE PROC <Tên store>
[Parametar nếu có]
AS
BEGIN
	<Code xử lý>
END

Nếu chỉ là câu truy vấn thì có thể không cần sử dụng BEGIN END
*/

CREATE PROC USP_test
@MaGV NVARCHAR(10), @Luong INT
AS
BEGIN
	SELECT * FROM dbo.GIAOVIEN WHERE MaGV = @MaGV AND Luong = @Luong
END
GO	

EXEC dbo.USP_test @MaGV = N'002', -- nvarchar(10)
                  @Luong = 2500   -- int
GO

CREATE PROC USP_SelectALlGiaoVien
AS SELECT * FROM dbo.GIAOVIEN
GO	
EXEC dbo.USP_SelectALlGiaoVien