/*
1. 
- Please indicate who is managing the department named: Research and Development Department. 
- Required information: code, employee name, department number, department name 
*/

USE FUH_COMPANY
GO 

SELECT *
FROM tblDepartment; 

SELECT *
FROM tblEmployee; 

SELECT empSSN,empName,d.depNum, depName
FROM tblDepartment d JOIN tblEmployee e ON d.mgrSSN = e.empSSN
WHERE depName = N'Phòng Nghiên cứu và phát triển'


/*
2. 
- For the department with the name: Research and Development Department, which projects are managed 
by this department currently?
- Required information: project number, project name, name of management department 
*/

USE FUH_COMPANY
GO

SELECT *
FROM tblDepartment

SELECT *
FROM tblProject

SELECT proNum, proName, depName
FROM tblDepartment d JOIN tblProject p ON d.depNum = p.depNum
WHERE depName = N'Phòng nghiên cứu và phát triển'


﻿/*
3.
- What department is the project named ProjectB currently managed by?
- Required information: project number, project name, name of management
department
*/


USE FUH_COMPANY
GO 

SELECT *
FROM tblProject

SELECT *
FROM tblDepartment

/* 
STEP 1: Perform the natural join between the two tables Project and Department through depNum 
STEP 2: Select properties including proNum, proName, depName with the condition 
							proName = 'ProjectB'
*/

SELECT proNum, proName, depName
FROM  tblProject p join tblDepartment d ON p.depNum = d.depNum
WHERE proName = 'ProjectB';


﻿/*
4.
- Display information of all employees who are supervised by an employee named
Mai Duy An
- Required information: employee number, employee's full name
*/


USE FUH_COMPANY
GO 

SELECT *
FROM tblEmployee

/* 
STEP 1: Select empSSN of Mai Duy An
STEP 2: Select all employee have supervisorSSN is empSSN of Mai Duy An
STEP 3: Select empSSN and empName of all employee selected in STEP 2
*/

SELECT empSSN, empName
FROM tblEmployee
WHERE supervisorSSN = (SELECT empSSN
					   FROM tblEmployee
					   WHERE empName = N'Mai Duy An');


/*
** 5.
** Please show who currently supervises staff named Mai Duy An.
** Required information: employee number, and the full name of the supervisor.
*/

USE FUH_COMPANY
GO

SELECT empSSN AS 'Employee SSN', empName AS 'Employee Name'
FROM tblEmployee
WHERE empSSN = (
	SELECT supervisorSSN
	FROM tblEmployee
	WHERE empName = N'Mai Duy An'
);


/*
** 6.
** Indicates where the project named ProjectA is currently working.
** Required information: code, name of working position.
*/

USE FUH_COMPANY
GO

SELECT locNum AS 'Code', locName AS 'Working position'
FROM tblLocation
WHERE locNum = (
	SELECT locNum
	FROM tblProject
	WHERE proName = N'ProjectA'
);


﻿/*
7. 
- Indicate the working position named: Tp. Ho Chi Minh City is currently the working
place of which projects. 
- Required information: code, project name
*/

USE FUH_COMPANY
GO 

/*
SELECT *
FROM tblProject

SELECT *
FROM tblLocation
*/

SELECT proNum AS 'Code', proName
FROM tblProject
WHERE locNum = (SELECT locNum
				FROM tblLocation
				WHERE locName = N'TP Hồ Chí Minh')


USE FUH_COMPANY
GO 
  
/*Indicate dependents over 18 years old .T
  Information required: name, date of birth of dependent, dependent employee name.
*/
  
/*
SELECT *
FROM tblDependent
GO
SELECT *
FROM tblEmployee
GO
*/

SELECT depName, depBirthdate, empName
FROM tblDependent d join tblEmployee e ON d.empSSN = e.empSSN
WHERE  1990 /*năm tự chọn*/ - year(depBirthdate) > 18
GO