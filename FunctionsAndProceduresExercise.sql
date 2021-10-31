USE SoftUni
GO

CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
SELECT FirstName, LastName FROM Employees
WHERE Salary > 35000
GO

CREATE OR ALTER PROC usp_GetEmployeesSalaryAboveNumber (@Salary DECIMAL(18,4)) 
AS
SELECT FirstName, LastName FROM Employees
WHERE Salary > @Salary
GO

EXEC usp_GetEmployeesSalaryAboveNumber 48100 
GO

CREATE OR ALTER PROC usp_GetTownsStartingWith (@Pattern VARCHAR)
AS 
SELECT Name AS [Town] FROM Towns
WHERE Name LIKE @Pattern+'%'
GO

EXEC usp_GetTownsStartingWith b
GO

CREATE PROC usp_GetEmployeesFromTown (@TownName VARCHAR(50))
AS
SELECT e.FirstName, e.LastName FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON t.TownID = a.TownID
WHERE t.Name= @TownName
GO

EXEC usp_GetEmployeesFromTown  'Sofia'
GO

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel (@Salary MONEY)
RETURNS NVARCHAR(10)
AS
BEGIN
  DECLARE @SalaryLevel NVARCHAR(10)
  	IF(@Salary < 30000)
  	BEGIN
  	 SET @SalaryLevel = 'Low'
  	 END
  	ELSE IF(@Salary BETWEEN 30000 AND 50000)
  	BEGIN
  	 SET @SalaryLevel = 'Average'
  	 END
  	ELSE
  	BEGIN
  	 SET @SalaryLevel = 'High'
  	 END
  RETURN @SalaryLevel
END
GO

SELECT Salary, dbo.ufn_GetSalaryLevel(Salary) AS [Salary Level] FROM Employees
GO

CREATE OR ALTER PROC usp_EmployeesBySalaryLevel(@SalaryLeveL NVARCHAR(10))
AS
SELECT FirstName, LastName FROM Employees 
WHERE dbo.ufn_GetSalaryLevel(Salary) = @SalaryLeveL
GO

EXEC usp_EmployeesBySalaryLevel 'High'
GO

CREATE FUNCTION ufn_IsWordComprised(@SetOfLetters VARCHAR (MAX), @Word VARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @CurrentLetter CHAR
	DECLARE @Counter INT = 1
	WHILE(LEN(@Word) >= @Counter)
	BEGIN
		SET @CurrentLetter = SUBSTRING(@Word, @Counter, 1)
		DECLARE @Match INT = CHARINDEX(@CurrentLetter, @SetOfLetters)

		IF (@Match = 0)
		BEGIN
			RETURN 0
		END
		SET @Counter += 1
	END
	RETURN 1
END
GO

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia') AS [Result]
GO

CREATE PROC usp_DeleteEmployeesFromDepartment (@DepartmentId INT)
AS
SELECT EmployeeID FROM Employees
	WHERE DepartmentID = @DepartmentId
GO

CREATE OR ALTER PROC usp_DeleteEmployeesFromDepartment (@DepartmentId INT) 
AS
BEGIN
	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN (
	SELECT EmployeeID FROM Employees
	WHERE DepartmentID = @DepartmentId)

	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL

	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN (
	SELECT EmployeeID FROM Employees
	WHERE DepartmentID = @DepartmentId)

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (
	SELECT EmployeeID FROM Employees
	WHERE DepartmentID = @DepartmentId)

	DELETE FROM Employees
	WHERE DepartmentID = @DepartmentId

	DELETE FROM Departments
	WHERE DepartmentID = @DepartmentId

	SELECT COUNT(*) FROM Employees WHERE DepartmentID = @DepartmentId
END

EXEC dbo.usp_DeleteEmployeesFromDepartment 1
GO

USE Bank
GO

CREATE PROC usp_GetHoldersFullName 
AS
SELECT CONCAT(FirstName+ ' ', LastName) AS [Full Name] FROM ClIENTS
GO

EXEC dbo.usp_GetHoldersFullName 
GO

CREATE PROC usp_GetHoldersWithBalanceHigherThan (@RequiredMoney DECIMAL (18,2))
AS
SELECT c.FirstName, c.LastName FROM CLIENTS AS c
JOIN Accounts AS a ON c.Id = a.ClientId
AND  a.Balance <= @RequiredMoney
GO

EXEC dbo.usp_GetHoldersWithBalanceHigherThan 100.00
GO

CREATE FUNCTION ufn_CalculateFutureValue (@InitialSum DECIMAL(18,2), @YearlyInterestRate FLOAT, @Years INT)
RETURNS DECIMAL (18,2)
AS
BEGIN

DECLARE @FutureValue DECIMAL(18,2)
SET @FutureValue = @InitialSum*POWER((1+@YearlyInterestRate),@Years); 

RETURN @FutureValue
END
GO

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
GO

CREATE OR ALTER PROC usp_CalculateFutureValueForAccount (@AccountId INT, @InterestRate DECIMAL(18,2))
AS
BEGIN
SELECT a.Id AS [Acount Id],c.FirstName AS [First Name], c.LastName AS [Last Name], a.Balance AS [Current Balance],
dbo.ufn_CalculateFutureValue (a.Balance, @InterestRate,5) AS [Balance in 5 years]
FROM Accounts AS a
JOIN CLIENTS AS c ON a.ClientID = c.ID
END
GO

USE Diablo
GO

CREATE OR ALTER FUNCTION ufn_CashInUsersGames(@GameName NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN (SELECT SUM(Cash) AS [SumCash] FROM ( 
	SELECT Cash,ROW_NUMBER() OVER(ORDER BY Cash DESC) AS [RowNum] 
	FROM UserSGames AS ug
	JOIN Games AS g ON g.Id = ug.GameId
	WHERE g.Name = @GameName ) AS [CashList]
	WHERE RowNum % 2 <> 0)
GO

SELECT * FROM dbo.ufn_CashInUsersGames('Lily Stargazer')
GO