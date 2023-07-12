-- group 3

select e.empSSN, e.empName, d.depName, sum(w.workHours) as total
from tblEmployee e
join tblDepartment d on e.depNum = d.depNum
join tblWorksOn w  on e.empSSN = w.empSSN
join tblProject p on w.proNum = p.proNum
group by e.empSSN, e.empName, d.depName


select d.depNum, d.depName, sum(w.workHours) as total
from tblDepartment d
join tblProject p on d.depNum = p.depNum
join tblWorksOn w on p.proNum = w.proNum
group by d.depNum, d.depName

select e.empSSN, e.empName, sum(w.workHours) as total
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
group by e.empSSN, e.empName
having sum(w.workHours) = (select min(total) from (select sum(w.workHours) as total
												   from tblWorksOn w
												   group by w.empSSN) as totals);

select e.empSSN, e.empName, sum(w.workHours) as total
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
group by e.empSSN, e.empName
having sum(w.workHours) = (select max(total) from (select sum(w.workHours) as total
												   from tblWorksOn w
												   group by w.empSSN) as totals);

/*
select e.empSSN, e.empName, d.depName
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
join tblDepartment d on e.depNum = d.depNum
join tblProject p on w.proNum = p.proNum
where e.empStartdate = (select min(empStartdate) from tblEmployee where empSSN = e.empSSN)
group by e.empSSN, e.empName, d.depName */

select e.empSSN, e.empName, d.depName
from tblEmployee e
join (select empSSN from tblWorksOn 
	  group by empSSN 
	  having count(proNum) = 1) as w on e.empSSN = w.empSSN
join tblDepartment d on e.depNum = d.depNum

select e.empSSN, e.empName, d.depName
from tblEmployee e
join (select empSSN from tblWorksOn 
	  group by empSSN 
	  having count(proNum) = 2) as w on e.empSSN = w.empSSN
join tblDepartment d on e.depNum = d.depNum

select e.empSSN, e.empName, d.depName
from tblEmployee e
join tblWorksOn w on e.empSSN = w.empSSN
join tblDepartment d on e.depNum = d.depNum
group by e.empSSN, e.empName, d.depName
having count(distinct w.proNum) >= 2

select p.proNum, p.proName, count(w.empSSN) as total
from tblProject p
join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName

select p.proNum, p.proName, sum(w.workHours) as total
from tblProject p
join tblWorksOn w on p.proNum = w.proNum
group by p.proNum, p.proName







