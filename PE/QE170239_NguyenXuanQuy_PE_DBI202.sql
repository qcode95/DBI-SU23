/*
1. Add data for the tables
*/

insert into class values(N'SE15C01', N'IT', N'CSE15', N'FE')
insert into class values(N'AI15B01', N'IT', N'CAI15', N'FE')
insert into class values(N'MK17A01', N'MK', N'CMK17', N'FE')
insert into class values(N'BIZ17B01', N'BIZ', N'CBIZ17', N'FE')

insert into student values(N'SE150023', N'Nguyễn Quốc Khang', '2001-10-15', N'khangnq@fpt.edu.vn', N'SE15C01')
insert into student values(N'SE150040', N'Lê Quang Minh Đà', '2000-01-01', N'dalqm@fpt.edu.vn', N'SE15C01')
insert into student values(N'AI152541', N'Lê Võ Bảo Duy', '2002-05-20', N'duylvb@fpt.edu.vn', N'AI15B01')
insert into student values(N'AI152007', N'Võ Hoàng Nguyên', '2001-01-31', N'nguyenvh@fpt.edu.vn', N'AI15B01')
insert into student values(N'MK175489', N'Trương Việt Hoàng', '2001-02-23', N'hoangtv@fpt.edu.vn', N'MK17A01')
insert into student values(N'MK175694', N'Phan Thị Minh Phương', '2000-05-05', N'phuongptm@fpt.edu.vn', N'MK17A01')
insert into student values(N'BIZ179420', N'Thân Đức Quang Vinh', '2000-07-26', N'vinhtdq@fpt.edu.vn', N'BIZ17B01')
insert into student values(N'BIZ175642', N'Lương Gia Khánh', '2001-06-27', N'khanhlg@fpt.edu.vn', N'BIZ17B01')

insert into subjects values(N'DBI202', N'IT', N'Database Systems_Các hệ cơ sở dữ liệu')
insert into subjects values(N'PRF192', N'IT', N'Programming Fundamentals_Cơ sở lập trình')
insert into subjects values(N'ECO111', N'MK', N'Microeconomics_Kinh tế vi mô')
insert into subjects values(N'MKT101', N'MK', N'Marketing Principles_Nguyên lý Marketing')
insert into subjects values(N'OBE102c', N'BIZ', N'Organizational Behavior_Hành vi tổ chức')
insert into subjects values(N'CHN111', N'BIZ', N'Elementary Chinese 1_Hán ngữ sơ cấp 1 ')

insert into result values(N'SE150023', N'DBI202', 1, 9)
insert into result values(N'SE150040', N'DBI202', 1, 6.5)
insert into result values(N'AI152541', N'DBI202', 1, 8)
insert into result values(N'AI152007', N'DBI202', 1, 7)
insert into result values(N'MK175489', N'ECO111', 1, 8)
insert into result values(N'MK175694', N'MKT101', 1, 9)
insert into result values(N'BIZ179420', N'OBE102c', 2, 9)
insert into result values(N'BIZ175642', N'CHN111', 1, 8)
insert into result values(N'SE150023', N'PRF192', 2, 7.5)
insert into result values(N'BIZ179420', N'CHN111', 1, 8)


/*
2. Queries
*/

-- a. Display a list of students from the department: Công nghệ thông tin -- 
select *
from student s
join class c on s.class_Id = c.class_Id
join department d on c.dep_Id = d.dep_Id
where d.dep_Name = N'Công nghệ thông tin'


-- b. Display class score information: MK17A01 --
select r.stu_id [Student ID], stu.stu_name [Student Name], s.sub_name [Subject Name], r.mark [Mark]
from result r
   join Subjects s on r.sub_id = s.sub_id
   join Student stu on r.stu_id = stu.stu_id
   join Class c on stu.class_id = c.class_id
where c.class_id = 'MK17A01';


-- c. Indicates course information starting in 2021. --
select co.course_Id [Course ID], c.class_Id [Class ID], d.dep_Name [Department Name]
from class c
join department d on c.dep_Id = d.dep_Id
join course co on c.course_Id = co.course_Id
where co.start_Year = 2021


-- d. Find the students with the highest mark and take the exam on the 1st (on_time = 1). Display information: student ID, student name, date of birth. --
select s.stu_id [Student ID], s.stu_name [Student Name], s.stu_birthday [Date Of birth]
from result r
  join Student s on r.stu_id = s.stu_id
where r.on_time = 1 and r.mark = (select max(mark) 
						          from result
								  where on_time = 1);


-- e.  Please indicate the number of students in each department, and sort them in descending order by number of students --
select dep.dep_name [Department Name], count(*) [Number of Students]
from Department dep
   join Class cls on dep.dep_id = cls.dep_id
   join Student stu on cls.class_id = stu.class_id
group by dep.dep_name
order by [Number of Students] desc;
go;


-- f. Using stored procedure to print a list of students in a class. Must have: class code and find all students by class code. --
create procedure GetStudentsByClassCode
@classid varchar(10)
as
begin
	if not exists(select 1 from class where class_Id = @classid)
		begin 
			print 'Class ID not found'
		end
	else
		begin
			select s.stu_id [Student ID], s.stu_name [Student Name], s.stu_birthday [Date of birth]
			from Student s
			join Class c ON s.class_id = c.class_id
			WHERE c.class_Id = @classid;
		end
end
go;

exec GetStudentsByClassCode 'BIZ17B01' -- In ra danh sách 2 học sinh của lớp BIZ17B01
exec GetStudentsByClassCode 'HHH' -- In ra Class ID not found
