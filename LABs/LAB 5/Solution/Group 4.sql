create procedure addItemToHD
@maHD nvarchar(10),
@ngay datetime,
@maKH nvarchar(5),
@tongTG int
as
select * from HOADON
where @maHD = MaHD AND @ngay = Ngay AND @maKH = MaKH AND @tongTG = TongTG
insert into HOADON values(@maHD, @ngay, @maKH, @tongTG)

exec addItemToHD 'HD011', '2023-07-12', 'KH01', 20
