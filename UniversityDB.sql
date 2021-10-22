CREATE DATABASE UniversityDatabase
GO
USE UniversityDatabase

CREATE TABLE Majors
(
	MajorID INT NOT NULL,
	Name VARCHAR(50),
	CONSTRAINT PK_Majors PRIMARY KEY (MajorID)
)

CREATE TABLE Students
(
	StudentID INT NOT NULL,
	StudentNumber INT NOT NULL,
	StudentName VARCHAR(50) NOT NULL,
	MajorID INT,
	CONSTRAINT PK_Students PRIMARY KEY(StudentID),
	CONSTRAINT UQ_Students UNIQUE (StudentNumber),
	CONSTRAINT FK_Students FOREIGN KEY (MajorID) REFERENCES Majors(MajorID)
)

CREATE TABLE Payments
(
	PaymentID INT NOT NULL,
	PaymentDate DATE NOT NULL,
	PaymentAmount DECIMAL(15,2),
	StudentID INT,
	CONSTRAINT PK_Payments PRIMARY KEY(PaymentID),
	CONSTRAINT FK_Payments FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
)

CREATE TABLE Subjects
(
	SubjectID INT NOT NULL,
	SubjecTName VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Subjects PRIMARY KEY(SubjectID)
)

CREATE TABLE Agenda
(
	StudentID INT NOT NULL,
	SubjectID INT NOT NULL,
	CONSTRAINT FK_Agenda_Students FOREIGN KEY(StudentID) REFERENCES Students(StudentID),
	CONSTRAINT FK_Agenda_Subjects FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID),
	CONSTRAINT PK_Agenda PRIMARY KEY(StudentID,SubjectID)
)



