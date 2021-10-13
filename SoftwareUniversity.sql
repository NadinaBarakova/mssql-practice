CREATE DATABASE SoftwareUniversity
USE SoftwareUniversity
CREATE TABLE Towns(
Id INT IDENTITY(1,1) NOT NULL,
Name NVARCHAR(50) NOT NULL
)
ALTER TABLE Towns
ADD CONSTRAINT PK_IdTowns PRIMARY KEY(Id)

CREATE TABLE Addresses(
Id INT IDENTITY(1,1) NOT NULL,
AdressText NVARCHAR(100) NOT NULL,
TownId INT NOT NULL 
)

ALTER TABLE Addresses
ADD CONSTRAINT PK_IdAddress PRIMARY KEY(Id)
ALTER TABLE Addresses
ADD CONSTRAINT FK_TownId FOREIGN KEY(TownId) REFERENCES Towns(Id)

CREATE TABLE Departments(
Id INT IDENTITY (1,1) NOT NULL,
Name NVARCHAR(50) NOT NULL
)
ALTER TABLE Departments
ADD CONSTRAINT PK_Id PRIMARY KEY(Id)

CREATE TABLE Employees(
Id INT IDENTITY(1,1) NOT NULL,
FirstName NVARCHAR(50) NOT NULL,
MiddleName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
JobTitle NVARCHAR(50) NOT NULL,
DepartmentId INT NOT NULL,
HireDate DATE DEFAULT GETDATE(),
Salary DECIMAL (15,2) NOT NULL,
AddressId INT 
)

ALTER TABLE Employees
ADD CONSTRAINT PK_IdEmployees PRIMARY KEY (Id)
ALTER TABLE Employees
ADD CONSTRAINT FK_IdDepartment FOREIGN KEY(DepartmentId) REFERENCES Departments(Id)
ALTER TABLE Employees
ADD CONSTRAINT FK_IdAddress FOREIGN KEY(AddressId) REFERENCES Addresses(Id)

BACKUP DATABASE SoftwareUniversity TO DISK= 'C:\Users\Dell\Documents\SQL Server Management Studio\software-university.bak'

INSERT INTO Towns VALUES ('Sofia'),('Plovdiv'),('Varna'),( 'Burgas')
INSERT INTO Departments VALUES ('Engineering'),( 'Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance')
INSERT INTO Employees  (FirstName, MiddleName, LastName, JobTitle,DepartmentId, HireDate, Salary,AddressId)
VALUES 
('Ivan', 'Ivanov', 'Ivanov','.NET Developer',4 ,'2013-02-01',	3500.00, NULL),
('Petar', 'Petrov', 'Petrov','Senior Engineer',1, '2004-03-02', 4000.00, NULL),
('Georgi', 'Teziev', 'Ivanov','CEO',2 ,'2007-12-09', 3000.00, NULL),
('Peter', 'Ivanov', 'Ivanov','Intern',3 ,'2016-08-28', 599.88, NULL)

SELECT Name FROM Towns
ORDER BY Name

SELECT Name FROM Departments
ORDER BY Name DESC

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

UPDATE Employees
SET Salary *= 1.1