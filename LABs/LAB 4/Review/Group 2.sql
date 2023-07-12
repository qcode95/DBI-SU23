--group 2

select d.depName, d.depBirthdate, e.empName
FROM tblDependent d JOIN tblEmployee e ON d.empSSN = e.empSSN
WHERE d.depSex = N'M'

select d.depNum, d.depName, l.locName
from tblDepartment d
join tblDepLocation dl on d.depNum = dl.depNum
join tblLocation l on dl.locNum = l.locNum
where d.depName = N'Phòng nghiên cứu và phát triển' 

select p.proNum, p.proName, d.depName
from tblProject p 
join tblDepartment d on p.depNum = d.depNum
where p.locNum = (select locNum from tblLocation where locName = N'Tp Hồ chí minh')

select e.empName, de.depName, de.depRelationship
from tblEmployee e 
join tblDependent de on e.empSSN = de.empSSN
join tblDepartment d on e.depNum = d.depNum					
where de.depSex = N'F' and d.depName = N'phòng nghiên cứu và phát triển'

select e.empName, de.depName, de.depRelationship
from tblEmployee e
join tblDependent de on e.empSSN = de.empSSN
join tblDepartment d on e.depNum = d.depNum
where d.depName = N'phòng nghiên cứu và phát triển' 
and (year(getdate() - year(de.depBirthdate)) > 18)

select de.depSex, count(*) as counts
from tblDependent de
group by de.depSex
order by counts

select de.depRelationship, count (*) as counts
from tblDependent de
group by de.depRelationship
order by counts

select d.depNum, d.depName, count(de.depRelationship) as counts
from tblDepartment d 
join tblEmployee e on d.depNum = e.depNum
join tblDependent de on e.empSSN = de.empSSN
group by d.depNum, d.depName
having count(de.depRelationship) = (select min(total) 
									from (select count(de.depRelationship) as total 
										  from tblDependent de
										  join tblEmployee e on de.empSSN = e.empSSN
										  join tblDepartment d on e.depNum = d.depNum
										  group by d.depNum) as totals);

select d.depNum, d.depName, count(de.depRelationship) as counts
from tblDepartment d 
join tblEmployee e on d.depNum = e.depNum
join tblDependent de on e.empSSN = de.empSSN
group by d.depNum, d.depName
having count(de.depRelationship) = (select max(total) 
									from (select count(de.depRelationship) as total 
										  from tblDependent de
										  join tblEmployee e on de.empSSN = e.empSSN
										  join tblDepartment d on e.depNum = d.depNum
										  group by d.depNum) as totals);


