CREATE DATABASE Minions

CREATE TABLE Minions(
Id INT PRIMARY KEY NOT NULL,
Name NVARCHAR(50) NOT NULL,
Age INT CHECK (Age>0)
)

CREATE TABLE Towns(
Id INT PRIMARY KEY NOT NULL,
Name NVARCHAR(50) NOT NULL
)

ALTER TABLE Minions
ADD TownsId INT NOT NULL
FOREIGN KEY(TownsId) REFERENCES Towns

SELECT *FROM Minions

INSERT INTO Towns (Id, Name) VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions (Id, Name, Age, TownsId) VALUES
(1,'Kevin',22,1),
(2,'Bob',15,3),
(3,'Steward',3,2)

SELECT *FROM Minions

DROP TABLE Minions

DROP TABLE Towns


