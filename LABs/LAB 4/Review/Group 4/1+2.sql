--1. Indicate which project has the least number of members. 
--	 Required information: project code, project name, number of members

SELECT tblProject.proNum, proName, COUNT (DISTINCT tblworkson.empSSN) AS number_of_members
FROM tblProject
JOIN tblWorksOn ON tblProject.proNum = tblWorkson.proNum 
GROUP BY tblProject.proNum, proName
HAVING COUNT (DISTINCT tblWorkson.empSSN) = (
	SELECT MIN(member_count)
	FROM (SELECT COUNT (DISTINCT tblWorksOn.empSSN) AS member_count
			FROM tblWorksOn
	GROUP BY tblWorksOn.proNum) AS counts);

--2. Indicate which project has the largest number of members. 
--	 Required information: project code, project name, number of members

SELECT tblProject.proNum, proName, COUNT (DISTINCT tblworkson.empSSN) AS number_of_members
FROM tblProject
JOIN tblWorksOn ON tblProject.proNum = tblWorkson.proNum 
GROUP BY tblProject.proNum, proName
HAVING COUNT (DISTINCT tblWorkson.empSSN) = (
	SELECT MAX(member_count)
	FROM (SELECT COUNT (DISTINCT tblWorksOn.empSSN) AS member_count
			FROM tblWorksOn
	GROUP BY tblWorksOn.proNum) AS counts);