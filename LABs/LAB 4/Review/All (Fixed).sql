/* 
- Scalar function: Hàm có 1 or nhiều đối số và phải trả về 1 giá trị
	create function <name>(@đối số -- KDL)
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
	create function <name>(đối số)
	return <@tên bảng> table (tên các cột muốn bảng được return hiển thị)
	as
	begin 
		<câu lệnh>
		return
	end
	--> calling: select <cột của bảng mình muốn hiển thị> from <name>(đối số)
*/


﻿-- GROUP 1 --

select e.empSSN 'Code', 
	   e.empName [Employee Name],
	   d.depNum [Department Number],
	   d.depName [Department Name]
from tblEmployee e
join tblDepartment d on e.empSSN = d.mgrSSN
where d.depName = N'Phòng nghiên cứu và phát triển'

select p.proNum [Project Number], 
	   p.proName [Project Name], 
	   d.depName [Department Name]
from tblProject p
join tblDepartment d on p.depNum = d.depNum
where d.depName = N'Phòng nghiên cứu và phát triển'

select p.proNum [Project Number],
	   p.proName [Project Name],
	   d.depName [Department Name]
from tblProject p
join tblDepartment d on p.depNum = d.depNum
where p.proName = N'ProjectB'

select e.empSSN [Employee Number],
	   e.empName [Employee Name]
from tblEmployee e
where e.supervisorSSN = (select empSSN
				         from tblEmployee
						 where empName = N'Mai Duy An')

select e.empSSN [Employee Number],
	   e.empName [Employee Name]
from tblEmployee e
where e.empSSN = (select supervisorSSN
				         from tblEmployee
						 where empName = N'Mai Duy An')
						 
select p.proNum 'Code',
	   l.locName [Working Position]
from tblProject p
join tblLocation l on p.locNum = l.locNum
where p.proName = N'ProjectA'

select p.proNum 'Code',
	   p.proName [Working Position]
from tblProject p
join tblLocation l on p.locNum = l.locNum
where l.locName = N'Tp Hồ Chí Minh'

select de.depName 'Name',
	   de.depBirthdate [Date of Birth],
	   e.empName [Employee Name]
from tblDependent de
join tblEmployee e on de.empSSN = e.empSSN
where 1980 - year(depBirthdate) > 18


-- GROUP 2 --

select de.depName [Dependent's Name],
	   de.depBirthdate [Date of Birth],
	   e.empName [Employee Name]
from tblDependent de
join tblEmployee e on de.empSSN = e.empSSN
where de.depSex = N'M'

select d.depNum [Department Code],
	   d.depName [Department Name],
	   l.locName [Workplace Name]
from tblDepartment d
join tblDepLocation dl on d.depNum = dl.depNum
join tblLocation l on dl.locNum = l.locNum
where d.depName = N'Phòng nghiên cứu và phát triển'

select p.proNum [Project Code],
	   p.proName [Project Name],
	   d.depName [Department Name]
from tblProject p
join tblDepartment d on p.depNum = d.depNum
join tblLocation l on p.locNum = l.locNum
where l.locName = N'Tp Hồ Chí Minh'

select e.empName [Employee's Name],
	   de.depName [Dependent's Name],
	   de.depRelationship [Relationship]
from tblDependent de
join tblEmployee e on de.empSSN = e.empSSN
join tblDepartment d on e.depNum = d.depNum
where d.depName = N'Phòng nghiên cứu và phát triển' and de.depSex = N'F'

select e.empName [Employee's Name],
	   de.depName [Dependent's Name],
	   de.depRelationship [Relationship]
from tblDependent de
join tblEmployee e on de.empSSN = e.empSSN
join tblDepartment d on e.depNum = d.depNum
where (2023 - year(depBirthdate) > 18) 
and d.depName = N'Phòng nghiên cứu và phát triển'

select de.depSex [Gender],
	   count(de.depName) [Number of Dependents]
from tblDependent de
group by de.depSex
order by [Number of Dependents]

select de.depRelationship [Relationship],
	   count(de.depName) [Number of Dependents]
from tblDependent de
group by de.depRelationship
order by [Number of Dependents]

select d.depNum [Department Code],
       d.depName [Department Name],
	   count(de.depName) [Number of Dependents]
from tblDepartment d
join tblEmployee e on d.depNum = e.depNum
join tblDependent de on e.empSSN = de.empSSN
group by d.depNum, d.depName
having count(de.depName) = (select min(total) from (select count(de.depName) as total
										            from tblDependent de
													join tblEmployee e on de.empSSN = e.empSSN
													join tblDepartment d on e.depNum = d.depNum
													group by d.depNum) as totals)

select d.depNum [Department Code],
       d.depName [Department Name],
	   count(de.depName) [Number of Dependents]
from tblDepartment d
join tblEmployee e on d.depNum = e.depNum
join tblDependent de on e.empSSN = de.empSSN
group by d.depNum, d.depName
having count(de.depName) = (select max(total) from (select count(de.depName) as total
										            from tblDependent de
													join tblEmployee e on de.empSSN = e.empSSN
													join tblDepartment d on e.depNum = d.depNum
													group by d.depNum) as totals)


-- GROUP 3 --

select e.empSSN [Employee Code],
       e.empName [Employee Name],
	   d.depName [Department Name],
	   sum(w.workHours) [Total work hour]
from tblEmployee e
join tblDepartment d on e.depNum = d.depNum
join tblWorksOn w on e.empSSN = w.empSSN
group by e.empSSN, e.empName, d.depName

select d.depNum [Department Code],
       d.depName [Department Name],
	   sum(w.workHours) [Total hours]
from tblDepartment d
join tblProject p on d.depNum = p.depNum
join tblWorksOn w on p.proNum = w.proNum
group by d.depNum, d.depName

select e.empSSN [Employee Code],
       e.empName [Employee Name],
	   sum(w.workHours) [Total hours]
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
group by e.empSSN, e.empName
having sum(w.workHours) = (select min(total) from (select sum(w.workHours) as total
												   from tblWorksOn w
												   group by w.empSSN) as totals)

select e.empSSN [Employee Code],
       e.empName [Employee Name],
	   sum(w.workHours) [Total hours]
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
group by e.empSSN, e.empName
having sum(w.workHours) = (select max(total) from (select sum(w.workHours) as total
												   from tblWorksOn w
												   group by w.empSSN) as totals)

select e.empSSN [Employee Code],
	   e.empName [Employee Name],
	   d.depName [Department Name]
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
join tblProject p on w.proNum = p.proNum
join tblDepartment d on e.depNum = d.depNum
group by e.empSSN, e.empName, d.depName
having count(e.empSSN) = 1

select e.empSSN [Employee Code],
	   e.empName [Employee Name],
	   d.depName [Department Name]
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
join tblProject p on w.proNum = p.proNum
join tblDepartment d on e.depNum = d.depNum
group by e.empSSN, e.empName, d.depName
having count(e.empSSN) = 2

select e.empSSN [Employee Code],
	   e.empName [Employee Name],
	   d.depName [Department Name]
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
join tblProject p on w.proNum = p.proNum
join tblDepartment d on e.depNum = d.depNum
group by e.empSSN, e.empName, d.depName
having count(p.proNum) >= 2

select p.proNum [Project Code],
	   p.proName [Project Name],
	   count(w.empSSN) [Number of Members]
from tblProject p
join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName

select p.proNum [Project Code],
	   p.proName [Project Name],
	   sum(w.workHours) [Total hours]
from tblProject p
join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName


-- GROUP 4 --

select p.proNum [Project Code],
	   p.proName [Project Name],
	   count(w.empSSN) [Number of Members]
from tblProject p
join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName
having count(w.empSSN) = (select min(total) from (select count(w.empSSN) as total
												  from tblWorksOn w
												  group by w.proNum) as totals)

select p.proNum [Project Code],
	   p.proName [Project Name],
	   count(w.empSSN) [Number of Members]
from tblProject p
join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName
having count(w.empSSN) = (select max(total) from (select count(w.empSSN) as total
												  from tblWorksOn w
												  group by w.proNum) as totals)

select p.proNum [Project Code],
	   p.proName [Project Name],
	   sum(w.workHours) [Total hours]
from tblProject p 
join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName
having sum(w.workHours) = (select min(total) from (select sum(w.workHours) as total
												   from tblWorksOn w
												   group by w.proNum) as totals)

select p.proNum [Project Code],
	   p.proName [Project Name],
	   sum(w.workHours) [Total hours]
from tblProject p 
join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName
having sum(w.workHours) = (select max(total) from (select sum(w.workHours) as total
												   from tblWorksOn w
												   group by w.proNum) as totals)

select l.locName [Name of Workplace],
	   count(d.depNum) [Number of Departments]
from tblLocation l
join tblDepLocation dl on l.locNum = dl.locNum
join tblDepartment d on dl.depNum = d.depNum
group by l.locName

select d.depNum [Department Code],
       d.depName [Department Name],
	   count(l.locNum) [Number of Workplaces]
from tblDepartment d
join tblDepLocation dl on d.depNum = dl.depNum
join tblLocation l on dl.locNum = l.locNum
group by d.depNum, d.depName

select d.depNum [Department Code],
	   d.depName [Department Name],
	   count(p.proNum) [Number of Jobs]
from tblDepartment d
join tblProject p on d.depNum = p.depNum
group by d.depNum, d.depName
having count(p.proNum) = (select max(total) from (select count(p.proNum) as total
												  from tblProject p
												  group by p.depNum) as totals)

select d.depNum [Department Code],
	   d.depName [Department Name],
	   count(p.proNum) [Number of Jobs]
from tblDepartment d
join tblProject p on d.depNum = p.depNum
group by d.depNum, d.depName
having count(p.proNum) = (select min(total) from (select count(p.proNum) as total
												  from tblProject p
												  group by p.depNum) as totals)

select l.locName [Name of Workplace],
	   count(d.depNum) [Number of Departments]
from tblLocation l
join tblDepLocation dl on l.locNum = dl.locNum
join tblDepartment d on dl.depNum = d.depNum
group by l.locName
having count(d.depNum) = (select max(total) from (select count(d.depNum) as total
												  from tblDepartment d
												  join tblDepLocation dl on d.depNum = dl.depNum
												  join tblLocation l on dl.locNum = l.locNum
												  group by locName) as totals)


-- GROUP 5 --

select l.locName [Name of Workplace],
	   count(d.depNum) [Number of Departments]
from tblLocation l
join tblDepLocation dl on l.locNum = dl.locNum
join tblDepartment d on dl.depNum = d.depNum
group by l.locName
having count(d.depNum) = (select min(total) from (select count(d.depNum) as total
												  from tblDepartment d
												  join tblDepLocation dl on d.depNum = dl.depNum
												  join tblLocation l on dl.locNum = l.locNum
												  group by locName) as totals)

select e.empSSN [Employee Number],
	   e.empName [Employee Name],
	   count(*) [Number of Dependents]
from tblEmployee e
join tblDependent de on e.empSSN = de.empSSN
group by e.empSSN, e.empName
having count(*) = (select max(total) from (select count(*) as total
													from tblDependent de
													group by de.empSSN) as totals)

select e.empSSN [Employee Number],
	   e.empName [Employee Name],
	   count(*) [Number of Dependents]
from tblEmployee e
join tblDependent de on e.empSSN = de.empSSN
group by e.empSSN, e.empName
having count(*) = (select min(total) from (select count(*) as total
													from tblDependent de
													group by de.empSSN) as totals)

select e.empSSN [Employee Number],
	   e.empName [Employee Name],
	   d.depName [Department Name]
from tblEmployee e
join tblDepartment d on e.depNum = d.depNum
where e.empSSN not in (select empSSN 
					   from tblDependent)

select d.depNum [Department Number],
	   d.depName [Department Name]
from tblDepartment d
join tblEmployee e on d.depNum = e.depNum
where e.empSSN not in (select empSSN 
					   from tblDependent)
group by d.depNum, d.depName

select e.empSSN [Employee Number],
	   e.empName [Employee Name],
	   d.depName [Department Name]
from tblEmployee e
join tblDepartment d on e.depNum = d.depNum
where e.empSSN not in (select empSSN			
					   from tblWorksOn)

select d.depNum [Department Number],
	   d.depName [Department Name]
from tblDepartment d
join tblEmployee e on d.depNum = e.depNum
where e.empSSN not in (select empSSN	
					   from tblWorksOn)
group by d.depNum, d.depName

select d.depNum [Department Number],
	   d.depName [Department Name]
from tblDepartment d
join tblEmployee e on d.depNum = e.depNum
where e.empSSN not in (select empSSN	
					   from tblWorksOn w
					   join tblProject p on w.proNum = p.proNum
					   where p.proName = N'ProjectA')			    
group by d.depNum, d.depName


-- GROUP 6 --

select d.depNum [Department Number],
		d.depName [Department Name],
		count(p.proNum) [Number of Projects]
from tblDepartment d
join tblProject p on d.depNum = p.depNum
group by d.depNum, d.depName

select d.depNum [Department Number],
		d.depName [Department Name],
		count(p.proNum) [Number of Projects]
from tblDepartment d 
join tblProject p on d.depNum = p.depNum
group by d.depNum, d.depName
having count(p.proNum) = (select min(total) from (select count(p.proNum) as total
													from tblProject p
													group by p.depNum) as totals)

select d.depNum [Department Number],
		d.depName [Department Name],
		count(p.proNum) [Number of Projects]
from tblDepartment d 
join tblProject p on d.depNum = p.depNum
group by d.depNum, d.depName
having count(p.proNum) = (select max(total) from (select count(p.proNum) as total
													from tblProject p
													group by p.depNum) as totals)

select d.depNum [Department Number],
		d.depName [Department Name],
		count(distinct e.empSSN) [Number of Employees],
		p.proName [Project Name]
from tblDepartment d
join tblEmployee e on d.depNum = e.depNum
join tblWorksOn w on e.empSSN = w.empSSN
join tblProject p on d.depNum = p.depNum
group by d.depNum, d.depName, p.proName
having count(distinct e.empSSN) > 5

select e.empSSN [Code],
		e.empName [Employee Name]
from tblEmployee e
join tblDepartment d on e.depNum = d.depNum
where d.depName = N'Phòng nghiên cứu và phát triển'
and e.empSSN not in (select empSSN from tblDependent)

select e.empSSN [Code],
		e.empName [Employee Name],
		sum(w.workHours) [Total working hours]
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
left join tblDependent de on e.empSSN = de.empSSN
where e.empSSN not in (select empSSN from tblDependent)

select e.empSSN [Code],
		e.empName [Employee Name],
		sum(w.workHours) [Total working hours]
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
join tblDependent de on e.empSSN = de.empSSN
group by e.empSSN, e.empName
having count(distinct de.empSSN) > 3;

select e.empSSN [Code],
		e.empName [Employee Name],
		sum(w.workHours) [Total working hours]
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
where e.supervisorSSN = (select empSSN
						from tblEmployee
					    where empName = N'Mai Duy An')
group by e.empSSN, e.empName
