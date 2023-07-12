CREATE PROCEDURE KhachHangId_Proc1
@makh nvarchar(5),
@diachi nvarchar(50)
AS
BEGIN
UPDATE KHACHHANG
SET DiaChi = @diachi
WHERE MaKH = @makh
END;

select * from KHACHHANG

EXEC KhachHangId_Proc1 @makh = 'KH01', @diachi ='Quy Nhon'
