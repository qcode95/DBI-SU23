CREATE FUNCTION GetHoaDonTotal(@MaHD nvarchar(10))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10,2);

    SELECT @TotalAmount = SUM(TongTG)
    FROM HOADON
    WHERE MaHD = @MaHD;

    IF @TotalAmount IS NULL
        SET @TotalAmount = 0;

    RETURN @TotalAmount;
END;
GO;

DECLARE @maHD nvarchar(10) = 'HD011';
DECLARE @result DECIMAL(10, 2);

SET @result = dbo.GetHoaDonTotal(@maHD);

SELECT @result AS Total;