/*
9. Which location has the most departments? 
   Required information: name of workplace, number of departments
*/

SELECT * FROM tblDepLocation

SELECT * FROM tblProject

SELECT tbllocation. locName, COUNT (tblDepLocation.depNum) AS number
FROM tblLocation JOIN tblDepLocation ON tblLocation.locNum = tblDepLocation.locNum
GROUP BY tblLocation.locName
having COUNT (tblDepLocation.depNum) = (
	SELECT MAX(num)  
	FROM (SELECT COUNT(tblDepLocation.depNum) AS num 
	FROM tblLocation
	JOIN tblDepLocation ON tblLocation.locNum = tblDepLocation.locNum
	GROUP BY tblLocation.locName) AS nums);