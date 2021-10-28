USE SoftUni

SELECT TOP(5) EmployeeID, JobTitle, e.AddressID, a.AddressText FROM Employees AS e 
JOIN Addresses AS a ON e.AddressID=a.AddressID
ORDER BY AddressID

SELECT TOP(50) e.FirstName, e.LastName,t.Name AS [Town], a.AddressText FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID = a.AddressID
JOIN Towns AS t
ON a.TownID = t.TownID
ORDER BY e.FirstName, e.LastName

SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name AS [DepartmentName] FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID

SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.Name AS [DepartmentName] FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID

SELECT TOP(3) e.EmployeeID, e.FirstName  FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID

SELECT e.FirstName, e.LastName, e.HireDate, d.Name AS [DeptName] FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '1999-01-01' AND d.Name IN ('Sales','Finance')
ORDER BY e.HireDate

SELECT TOP(5) e.EmployeeID, e.FirstName, p.Name AS [ProjectName] FROM Employees AS e
JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p
ON ep.ProjectID = p.ProjectID
WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
ORDER BY e.EmployeeID

SELECT e.EmployeeID, e.FirstName,
 CASE
    WHEN DATEPART(YEAR,p.StartDate) > = 2005 THEN NULL
	ELSE p.Name
  END AS [ProjectName]
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p
ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24

SELECT e.EmployeeID, e.FirstName, m.EmployeeID AS [ManagerID], m.FirstName AS [ManagerName] FROM Employees AS e
JOIN Employees AS m
ON e.ManagerID = m.EmployeeID 
WHERE e.ManagerID IN (3,7)
ORDER BY EmployeeID

SELECT TOP(50) e1.EmployeeID, 
	CONCAT(e1.FirstName, ' ', e1.LastName) AS [EmployeeName],
	CONCAT(e2.FirstName, ' ', e2.LastName) AS [ManagerName],
	d.Name AS [DepartmentName]
FROM Employees AS e1
LEFT JOIN Employees AS e2
ON e1.ManagerID = e2.EmployeeID
JOIN Departments AS d
ON e1.DepartmentID = d.DepartmentID
ORDER BY e1.DepartmentID

SELECT MIN([AvErage Salary]) AS [MinAverageSalary]
		FROM (
				SELECT DepartmentID, AVG(Salary) AS [Average Salary] FROM Employees
				GROUP BY DepartmentID
			  ) AS [AverageSalaryQuary]

USE Geography

SELECT c.CountryCode,
	m.MountainRange,
	p.PeakName,
	p.Elevation
	FROM MountainsCountries AS mc
JOIN Countries AS c
ON c.CountryCode = mc.CountryCode
JOIN Mountains AS m
ON mc.MountainId = m.Id
JOIN Peaks AS p
ON p.MountainId = m.Id
WHERE c.CountryCode = 'BG' AND p.Elevation >= 2835
ORDER BY p.Elevation DESC

SELECT CountryCode, COUNT(MountainId) AS [MountainRanges] 
	FROM MountainsCountries
WHERE CountryCode IN ('BG', 'RU','US')
GROUP BY CountryCode

SELECT TOP (5) c.CountryName, r.RiverName FROM CountriesRivers AS cr
JOIN Rivers AS r
ON cr.RiverId = r.Id
RIGHT JOIN Countries AS c
ON c.CountryCode = cr.CountryCode
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName

SELECT ContinentCode, CurrencyCode, CurrencyCount AS [CurrencyUsage]FROM
   (
	SELECT ContinentCode, 
		   CurrencyCode, 
		   [CurrencyCount],
		   DENSE_RANK() OVER(PARTITION BY ContinentCode ORDER BY CurrencyCount DESC) AS [CurrencyRank]
		   FROM (
			SELECT ContinentCode, 
					CurrencyCode, 
					COUNT(*) AS [CurrencyCount]
			FROM Countries
			GROUP BY ContinentCode, CurrencyCode
			) AS [CurrencyCountQuery] 
	WHERE CurrencyCount > 1
	) AS CurrencyRankingQuery
WHERE CurrencyRank = 1
ORDER BY ContinentCode

SELECT TOP(5) CountryName,
	   MAX(p.Elevation) AS [Highest Peak Elevation],
	   MAX(r.Length) AS [Longest River Length]
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr
ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r
ON cr.RiverId = r.Id
LEFT JOIN MountainsCountries AS mc
ON c.CountryCode = mc.CountryCode
LEFT JOIN Mountains AS m
ON mc.MountainId = m.Id
LEFT JOIN Peaks AS p
ON p.MountainId = m.Id
GROUP BY c.CountryName
ORDER BY [Highest Peak Elevation] DESC, [Longest River Length] DESC, CountryName DESC

SELECT TOP (5) Country,
	   CASE
		  WHEN PeakName IS NULL THEN '(no highest peak)' 
		  ELSE PeakName
	   END AS [Highest Peak Name],
	      CASE
		  WHEN Elevation IS NULL THEN 0 
		  ELSE Elevation	
	   END AS [Highest Peak Elevation],
	      CASE
		  WHEN MountainRange IS NULL THEN '(no mountain)' 
		  ELSE MountainRange
	   END AS [Mountain] FROM
	   (
SELECT * , 
		DENSE_RANK() OVER(PARTITION BY [Country] ORDER BY [Elevation]DESC ) AS [PeakRank]
FROM
	(SELECT CountryName AS [Country],
			p.PeakName,
			p.Elevation,
			m.MountainRange
	 FROM Countries AS c
	 LEFT JOIN MountainsCountries AS mc
	 ON c.CountryCode = mc.CountryCode
	 LEFT JOIN Mountains AS m
	 ON mc.MountainId = m.Id
	 LEFT JOIN Peaks AS p
	 ON p.MountainId = m.Id
	) AS [FullInfoQuery] ) [PeakRankingsQuery]
	 ORDER BY Country ASC, [Highest Peak Name] ASC






