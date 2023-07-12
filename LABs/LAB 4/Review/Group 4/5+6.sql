/*5. Indicate the number of departments working each workplace
*Required information: name of workplace, number of departments*/

Select tblLocation.locName,count(tblDepLocation.depNum) as number
From tblLocation
join tblDepLocation on tblLocation.locNum = tblDepLocation. locNum
Group by tblLocation.locName

/*6. Indicate the number of workplaces
*Required information: department code, department name, number of workplace*/
Select dl.depNum, dp.depName,Count(Distinct dl.locNum) As Number_of_workplaces
From tblDepartment dp
join tblDepLocation dl On dp.depNum= dl. depNum
Group By dl.depNum ,dp.depName
