--This question we have to use scalar function

CREATE FUNCTION Chitiethoadon_Func1 (@mavt nvarchar(5))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total DECIMAL(10,2);

    SELECT @total = SUM(sl * giaban)
    FROM CHITIETHOADON
    WHERE MaVT = @mavt;

    IF @total IS NULL
        SET @total = 0;

    RETURN @total;
END;
go;

DECLARE @mavt nvarchar(5) = 'VT01';
DECLARE @result DECIMAL(10, 2);

SET @result = dbo.Chitiethoadon_Func1(@mavt);

SELECT @result AS TotalAmount;

SELECT * from CHITIETHOADON

