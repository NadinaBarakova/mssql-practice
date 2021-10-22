CREATE DATABASE Demo

GO
USE Demo


CREATE TABLE Passports
(
PassportID INT PRIMARY KEY IDENTITY(101,1),
PassportNumber CHAR(8) UNIQUE NOT NULL
)

CREATE TABLE Persons
(
PersonId INT PRIMARY KEY IDENTITY,
FirstName VARCHAR(50) NOT NULL,
Salary DECIMAL(15,2),
PassportID INT NOT NULL 
FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)
)

INSERT INTO Passports VALUES
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2')

INSERT INTO Persons VALUES
('Roberto',43300.00,102),
('Tom',56100.00,103),
('Yana',602000.00,101)

SELECT*FROM Passports
SELECT*FROM Persons

CREATE TABLE Manufacturers
(
ManufacturerID INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
EstablishedOn DATE NOT NULL
)

CREATE TABLE Models
(
ModelID INT PRIMARY KEY IDENTITY(101,1),
Name VARCHAR(50) NOT NULL,
ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers VALUES
('BMW','07/03/1916'),
('Tesla','01/01/2003'),
('Lada','01/05/1966')

INSERT INTO Models VALUES
('X1',1),
('i6',1),
('Model S',2),
('Model X',2),
('Model 3',2),
('Nova',3)

SELECT *FROM Manufacturers
SELECT *FROM Models

CREATE TABLE Students
(
StudentID INT NOT NULL PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
)

CREATE TABLE Exams
(
ExamID INT NOT NULL PRIMARY KEY IDENTITY(101,1),
Name VARCHAR(50) NOT NULL,
)

CREATE TABLE StudentsExams
(
StudentID INT NOT NULL FOREIGN KEY REFERENCES Students(StudentID),
ExamID INT NOT NULL FOREIGN KEY REFERENCES ExamS(ExamID),
PRIMARY KEY(StudentID,ExamID)
)

INSERT INTO Students VALUES
('Mila'),
('Toni'),
('Ron')

INSERT INTO Exams VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

INSERT INTO StudentsExams VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)

SELECT*FROM Students
SELECT *FROM Exams
SELECT*FROM StudentsExams

CREATE TABLE Teachers
(
TeacherID INT IDENTITY(101,1) PRIMARY KEY,
Name VARCHAR(50) NOT NULL, 
ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)
SET IDENTITY_INSERT Teachers ON
INSERT INTO Teachers (TeacherID,Name,ManagerID) VALUES
(101,'John',NULL),
(102,'Maya',106),
(103,'Silvia',106),
(104,'Ted',105),
(105,'Mark',101),
(106,'Greta',101)
SET IDENTITY_INSERT Teachers OFF

SELECT *FROM Teachers
