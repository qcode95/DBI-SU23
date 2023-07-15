/*


- Scalar function: Hàm có 1 or nhiều đối số và phải trả về 1 giá trị
	create function <name>
	(@đối số -- KDL)
	return KDL 
	as
	begin
		<câu lệnh>
		return <giá trị>
	end
	--> calling: select <name>(Đối số)

- In-line function: Hàm có 1 hay nhiều đối số và phải trả về 1 bảng
	create function <name>
	(
		<Đối số 1>
		<------ 2>
		...
	)
	return table
	as
	return <câu lệnh>
	--> calling: select <cột của bảng mình muốn hiển thị> from <name>(đối số)

- Multi function: Hàm có 1 or nhiều đối số or k có đối số và phải return về 1 bảng. Trong hàm ta thêm cái thuộc tính cho bảng được return
	create function <name>
	(đối số)
	return <@tên bảng> table (tên các cột muốn bảng được return hiển thị)
	as
	begin 
		<câu lệnh>
		return
	end
	--> calling: select <cột của bảng mình muốn hiển thị> from <name>(đối số)


/*


- Procedure: thủ tục
	create procedure <tên procedure>
	(Đối số)
	as
	begin
		<khối lệnh>
	end

- Trigger: công tắc
	create trigger <tên trigger>
	on <tên bảng>
	for/after [insert, delete, update]
	as
	begin
		<khối lệnh>
	end

- View: Tạo 1 bảng nhỏ để quan sát
	create view <tên view>
	as
		<khối lệnh>


*/
Group 1:  Write function name: StudenID_ Func1 with parameter @mavt.
		  Return the sum of sl*giaban corresponding.
*/

create function QE170239_Func1(@mavt nvarchar(5))
returns decimal(10, 2)
as
begin
	declare @total Decimal(10, 2)
	set @total = (select sum(sl*giaban)
				  from CHITIETHOADON
				  where MaVT = @mavt)
	if @total is null
		set @total = 0.0
	return @total
end
go


/*
Group 2:  Write function to return a total of the HoaDon (@MahD is a parameter).
*/

create function QE170239_Func2(@mahd nvarchar(5))
returns decimal(10, 2)
as
begin 
	declare @total Decimal(10, 2)
	set @total = (select sum(TongTG) 
				  from HOADON
				  where MaHD = @mahd)
	if @total is null
		set @total = 0.0
	return @total
end
go


/*
Group 3:  Write procedure name: StudenId _Proc1, parameter @makh, @diachi. 
          This procedure help user update @diachi corresponding @makh.
*/

create procedure QE170239_Proc1
@makh nvarchar(5),
@diachi nvarchar(50)
as
begin
update KHACHHANG
set DiaChi = @diachi
where MaKH = @makh
end
go


/*
Group 4:  Write procedure to add an item into Hoadon.
*/

create procedure QE170239_Proc2
@mahd nvarchar(5),
@ngay datetime,
@makh nvarchar(5),
@tongtg int,
@tongtien int
as
begin 
	if exists (select 1 
			   from HOADON 
			   where MaHD = @mahd)
		begin 
			print 'Hoa don da ton tai'
		end
	else
		begin
			insert into HOADON values (@mahd, @ngay, @makh, @tongtg, @tongtien)
			print 'Them hoa don thanh cong'
		end
end
go


/*
Group 5:  Write trigger name: StudenId_ Trig1 on table Chitiethoadon, when user insert data into
          Chitiethoadon, the trigger will update the Tongtien in HoaDon(student should add Tongtien
		  column into Hoadon, tongtien=sum(sl*giaban).
*/

create trigger QE170239_Trig1
on CHITIETHOADON
after insert
as
begin
	update HOADON
	set TongTG = (select sum(ch.sl * ch.giaban) 
				  from CHITIETHOADON ch
				  join inserted ins on ch.maHD = ins.maHD)
	from HOADON h
	join inserted ins on h.MaHD = ins.MaHD
end
go

enable trigger QE170239_Trig1 on CHITIETHOADON
go


/*
Group 6: Write view name: StudentID_View1 to extract list of customers who bought ‘Gach Ong'.
*/


create view QE170239_View1 
as
	select kh.MaKH, kh.TenKH, kh.DiaChi
	from KHACHHANG kh
	join HOADON h on kh.MaKH = h.MaKH
	join CHITIETHOADON ct on h.MaHD = ct.MaHD
	join VATTU v on ct.MaVT = v.MaVT
	where v.TenVT = N'Gach Ong'
go



