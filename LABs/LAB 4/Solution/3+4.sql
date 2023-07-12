--3. Indicate which project has the least total number of hours worked. 
--	 Required information: project code, project name, total hours worked

SELECT tblProject.proNum, proName, SUM(tblWorksOn.workHours) AS total_hours_worked
FROM tblProject
JOIN tblWorksOn ON tblProject.proNum = tblWorksOn.proNum
GROUP BY tblProject.proNum, proName
HAVING SUM(tblWorksOn.workHours) = (
	SELECT MIN(total)
	FROM (SELECT SUM(workHours) AS total
	FROM tblWorksOn
GROUP BY tblWorksOn.proNum) AS total);

--4. Indicate which project has the most total hours worked. 
--	 Required information: project code, project name, total hours worked
SELECT tblProject.proNum, proName, SUM(tblWorksOn.workHours) AS total_hours_worked
FROM tblProject
JOIN tblWorksOn ON tblProject.proNum = tblWorksOn.proNum
GROUP BY tblProject.proNum, proName
HAVING SUM(tblWorksOn.workHours) = (
	SELECT MAX(total)
	FROM (SELECT SUM(workHours) AS total
	FROM tblWorksOn
GROUP BY tblWorksOn.proNum) AS total);