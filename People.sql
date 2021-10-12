CREATE TABLE People(
Id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
Name NVARCHAR(200) NOT NULL,
Picture VARBINARY (2000),
Height DECIMAL(15,2),
Weight DECIMAL (15,2),
Gender VARCHAR NOT NULL,
Birthday DATETIME NOT NULL,
Biography NVARCHAR(MAX)
)

ALTER TABLE People
ADD CONSTRAINT ch_Gender
CHECK((Gender='f')OR(Gender='m'))

SELECT *FROM People

INSERT INTO People(Name,Height,Weight,Gender,Birthday,Biography) VALUES
('Georgi Georgiev',180,90,'m',2000-02-12,'Something written here.....'),
('Gergana Georgieva',170,60,'f',2000-05-22,'Something written here.....'),
('Dimitar Dimitrov',185,90,'m',2000-06-18,'Something written here.....'),
('Petya Dimitrova',175,65,'f',2000-09-21,'Something written here.....'),
('Georgi Zhivkov',190,90,'m',2000-08-14,'Something written here.....')

ALTER TABLE People
ALTER COLUMN Birthday DATE NOT NULL

SELECT *FROM People

