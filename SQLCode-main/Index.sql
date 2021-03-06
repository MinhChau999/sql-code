--Tao index trong bang TransactionTest theo NGAY
USE PartTest
CREATE TABLE TransactionTest(
	ID INT IDENTITY,
	NGAY DATETIME,
	SANPHAM_ID INT
) ON PScheme_NGD(NGAY)
GO
CREATE INDEX CI_SANPHAM_ID ON dbo.TransactionTest(SANPHAM_ID)

--Mac dinh INDEX se duoc phan doan theo INDEX cua bang
--Kiem tra xem index duoc phan doan
SELECT i.name AS IndexName, i.type_desc, ps.name PartitionName, ps.data_space_id 
FROM SYS.indexes i
JOIN SYS.partition_schemes ps
	ON ps.data_space_id = i.data_space_id
		WHERE i.name = 'CI_SANPHAM_ID'

	

--code để liệt kê các cột chứa trong index
SELECT ind.name AS Index_Name, col.name AS Column_Name
FROM SYS.indexes ind 
INNER JOIN SYS.index_columns ic 
    ON  ind.OBJECT_ID = ic.OBJECT_ID and ind.index_id = ic.index_id 
INNER JOIN SYS.COLUMNS col 
    ON ic.OBJECT_ID = col.OBJECT_ID and ic.column_id = col.column_id 
WHERE ind.name = 'CI_SANPHAM_ID'	


--Tao unique index 
CREATE UNIQUE INDEX UI_SANPHAM_ID ON TransactionTest(SANPHAM_ID)	
--unique index nay phai la tap con cua index key.
CREATE UNIQUE INDEX UI_SANPHAM_ID ON TransactionTest(SANPHAM_ID) ON [PRIMARY]
--chi dinh index tren primary group

