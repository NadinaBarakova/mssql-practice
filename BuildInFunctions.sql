USE SoftUni
SELECT FirstName,LastName FROM Employees
WHERE FirstName LIKE 'SA%'

SELECT FirstName,LastName FROM Employees
WHERE LastName LIKE '%EI%'

SELECT FirstName, HireDate FROM Employees
WHERE DepartmentID IN(3,10) AND 
	  DATEPART(YEAR,HireDate) BETWEEN 1995 AND 2005

SELECT FirstName,LastName, JobTitle FROM Employees
WHERE JobTitle LIKE '[^engineer]%'

SELECT Name FROM Towns
WHERE LEN(Name)=5 OR LEN(Name)=6
ORDER BY Name

SELECT TownID, Name FROM Towns
WHERE Name LIKE '[MKBE]%'
ORDER BY Name ASC

SELECT TownID, Name FROM Towns
WHERE Name LIKE '[^RBD]%'
ORDER BY Name ASC

CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
WHERE YEAR(HireDate)>2000 

SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName)=5

SELECT * FROM(SELECT EmployeeID, FirstName, LastName, Salary,
			DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
		FROM Employees
		WHERE Salary BETWEEN 10000 AND 50000) 
AS [Rank Table]
WHERE Rank = 2
ORDER BY Salary DESC

USE Geography

SELECT CountryName AS [Country Name], IsoCode AS [ISO Code]FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode

SELECT P.PeakName, r.RiverName, LOWER(
			CONCAT(p.PeakName, SUBSTRING(r.RiverName,2,LEN(r.RiverName)-1)))
			AS[Mix] FROM Peaks AS p, Rivers AS r
WHERE RIGHT(p.PeakName,1) = LEFT(r.RiverName,1)
ORDER BY Mix

USE Diablo

SELECT TOP (50)Name, FORMAT(Start,'yyyy-MM-dd') AS [Start] FROM Games AS g
WHERE DATEPART(YEAR,Start) IN (2011,2012)
ORDER BY g.Start, Name

SELECT UserName, SUBSTRING([Email],CHARINDEX('@',[Email])+1,LEN([Email])+1) AS [Email Provider] FROM Users
ORDER BY Email DESC, UserName

SELECT Username, IpAddress AS [IP Address] FROM Users
WHERE IpAddress LIKE '___.1_%._%.___'
ORDER BY Username

SELECT Name AS [Game],
	CASE
	    WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS [Part of the Day],
	CASE
		WHEN Duration <=3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		ELSE 'Extra Long'
	END AS [Duration]
FROM Games
ORDER BY Name, Duration, [Part of the Day]

USE Orders;

SELECT ProductName,OrderDate,
DATEADD(dd,3,OrderDate) AS [Pay Due], 
DATEADD(MM,1,OrderDate) AS [Deliver Due] 
FROM Orders
 



