CREATE TRIGGER TongTien_Trig1
ON CHITIETHOADON
AFTER INSERT
AS
BEGIN
    UPDATE HoaDon
    SET TongTG = (SELECT SUM(ch.SL * ch.GiaBan)
                    FROM CHITIETHOADON ch
                    JOIN inserted ins ON ch.MaHD = ins.MaHD)
    FROM HoaDon
    JOIN inserted ins ON HoaDon.MaHD = ins.MaHD;
END;
GO;

ENABLE TRIGGER TongTien_Trig1 ON CHITIETHOADON
GO;

INSERT INTO CHITIETHOADON VALUES ('HD010', 'VT02', 10, null, 55000)
go

insert into HOADON values('HD011', '2023-07-12', 'KH01', 0)

select * from HOADON
select * from CHITIETHOADON
