USE Bank1

CREATE TABLE Logs(
LogId INT PRIMARY KEY IDENTITY,
AccountId INT FOREIGN KEY REFERENCES Accounts(Id),
OldSum DECIMAL(15,2),
NewSum DECIMAL(15,2)
)	

CREATE OR ALTER TRIGGER tr_InsertAccountsInfo ON Accounts FOR UPDATE
AS
DECLARE @newSum	DECIMAL(15,2)= (SELECT Balance FROM inserted)
DECLARE @oldSum	DECIMAL(15,2) = (SELECT Balance FROM deleted)
DECLARE @accountId INT = (SELECT Id FROM inserted)

INSERT INTO Logs (AccountId, NewSum, OldSum) VALUES
(@accountId, @newSum, @oldSum)

UPDATE Accounts
SET Balance +=10 WHERE Id=1

SELECT *FROM Accounts WHERE Id =1
SELECT *FROM Logs

CREATE TABLE NotificationEmails(
Id INT PRIMARY KEY IDENTITY,
Recipient INT FOREIGN KEY REFERENCES Accounts(Id),
[Subject] VARCHAR(50),
Body VARCHAR(MAX)
)

CREATE OR ALTER TRIGGER tr_LogEmail ON Logs FOR INSERT
AS
DECLARE @accountId INT = (SELECT TOP(1)AccountId FROM inserted)
DECLARE @oldSum DECIMAL(15,2) =(SELECT TOP(1)OldSum FROM inserted)
DECLARE @newSum DECIMAL(15,2) =(SELECT TOP(1)NewSum FROM inserted)

INSERT INTO NotificationEmails (Recipient, [Subject], Body)
VALUES
(@accountId, 'Balance change for account: '+CAST(@accountId AS VARCHAR(20)),
'On ' + CONVERT(VARCHAR(30),GETDATE(),103) + ' your balance was changed from ' +CAST(@oldSum AS VARCHAR(20) )+
' to '+ CAST(@newSum AS VARCHAR(20))+'.')
GO

 
UPDATE Accounts
SET BALANCE +=100
WHERE Id = 1
GO
SELECT * FROM NotificationEmails
SELECT * FROM Logs