/* 
   7. Indicate which department has the most jobs. 
      Required information: department code, department name, number of workplaces.

   8. Indicate which department has the least jobs. 
      Required information: department code, department name, number of workplaces.
*/

SELECT *  FROM tblProject

SELECT * FROM tblDepartment

SELECT tblDepartment.depNum, depName, COUNT (tblProject.proNum) AS number 
FROM tblDepartment JOIN tblProject ON tblDepartment.depNum = tblProject.depNum 
GROUP BY tblDepartment.depNum, depName
HAVING COUNT(tblProject.proNum) = (SELECT MAX(job) FROM (SELECT COUNT(tblProject.proNum) AS job FROM tblProject GROUP BY depNum) AS jobs);

SELECT tblDepartment.depNum, depName, COUNT (tblProject.proNum) AS number 
FROM tblDepartment JOIN tblProject ON tblDepartment.depNum = tblProject.depNum 
GROUP BY tblDepartment.depNum, depName
HAVING COUNT(tblProject.proNum) = (SELECT MIN(job) FROM (SELECT COUNT(tblProject.proNum) AS job FROM tblProject GROUP BY depNum) AS jobs);