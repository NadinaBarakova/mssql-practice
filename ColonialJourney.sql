CREATE DATABASE ColonialJourney 

USE ColonialJourney 

CREATE TABLE Planets(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(30) NOT NULL
)

CREATE TABLE Spaceports(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	PlanetId INT FOREIGN KEY REFERENCES Planets(Id) NOT NULL
)

CREATE TABLE Spaceships(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	ManufactUrer VARCHAR(30) NOT NULL,
	LightSpeedRate INT DEFAULT 0
)

CREATE TABLE Colonists(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	Ucn VARCHAR(10) UNIQUE NOT NULL,
	BirthDate DATETIME2 NOT NULL
)

CREATE TABLE Journeys(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	JourneyStart DATETIME2 NOT NULL,
	JourneyEnd DATETIME2 NOT NULL,
	Purpose VARCHAR(11),
	CHECK(Purpose = 'Medical' OR Purpose = 'Technical' OR Purpose = 'Educational' OR Purpose = 'Military'),
	DestinationSpaceportId INT FOREIGN KEY REFERENCES SpacePorts(Id) NOT NULL,
	SpaceshipId INT FOREIGN KEY REFERENCES Spaceships(Id) NOT NULL
)

CREATE TABLE TravelCards(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	CardNumber VARCHAR(10) UNIQUE NOT NULL,
	JobDuringJourney VARCHAR(8),
	CHECK(JobDuringJourney = 'Pilot' OR JobDuringJourney = 'Engineer' OR JobDuringJourney = 'Cook'
	OR JobDuringJourney = 'Trooper' OR JobDuringJourney = 'Cleaner'),
	ColonistId INT FOREIGN KEY REFERENCES Colonists(Id) NOT NULL,
	JourneyId INT FOREIGN KEY REFERENCES JourneYs(Id) NOT NULL
)

INSERT INTO Planets
VALUES
('Mars'),
('Earth'),
('Jupiter'),
('Saturn')

INSERT INTO Spaceships([Name],ManufactUrer, LightSpeedRate)
VALUES
('Golf','VW','3'),
('WakaWaka','Wakanda','4'),
('Falcon9','SpaceX','1'),
('Bed','Vidolov','6')

UPDATE Spaceships
SET LightSpeedRate = 1
WHERE Id BETWEEN 8 AND 12 

SELECT * FROM Spaceships

SELECT* FROM Journeys

SELECT * FROM TravelCards

DELETE FROM TravelCards
WHERE JourneyId BETWEEN 1 AND 3

DELETE FROM Journeys 
WHERE Id BETWEEN 1 AND 3

SELECT Id, FORMAT(JourneyStart,'dd-MM-yyyy') AS [JourneyStart], 
FORMAT(JourneyEnd,'dd-MM-yyyy') AS [JourneyEnd] FROM Journeys
WHERE Purpose = 'Military' 
ORDER BY JourneyStart

SELECT c.Id AS [id], CONCAT(c.FirstName + ' ',LastName) AS [full_name] FROM Colonists AS c
JOIN TravelCards AS tc ON c.Id = tc.ColonistId
WHERE tc.JobDuringJourney = 'Pilot'
ORDER BY c.Id

SELECT COUNT(c.Id) AS [count] FROM Colonists AS c
JOIN TravelCards AS tc ON c.Id = tc.ColonistId
JOIN Journeys AS j ON tc.JourneyId = j.Id
WHERE j.Purpose = 'Technical'

SELECT s.[Name], s.ManufactUrer FROM Spaceships AS s
JOIN Journeys AS j ON s.Id = j.SpaceshipId
JOIN TravelCards AS tc ON j.Id = tc.JourneyId
JOIN Colonists AS c ON tc.ColonistId = c.Id
WHERE DATEDIFF(YEAR,c.BirthDate,'2019-01-01') < 30
ORDER BY s.[Name]

SELECT p.[Name]AS [PlanetName], COUNT(j.Id) AS [JourneyCount] FROM Planets AS p
JOIN Spaceports AS s ON p.Id = s.PlanetId
JOIN Journeys AS j ON s.Id = j.DestinationSpaceportId
GROUP BY p.[Name]
ORDER BY COUNT(j.Id) DESC, p.[Name] ASC

SELECT* FROM(
SELECT tc.JobDuringJourney, CONCAT(c.FirstName+' ',c.LastName) AS [FullName],
RANK() OVER (PARTITION BY tc.JobDuringJourney ORDER BY c.BirthDate) AS [JobRank]
FROM TravelCards AS tc
JOIN Colonists AS c ON tc.ColonistId = c.Id) AS t
WHERE [JobRank] = 2

GO
CREATE FUNCTION udf_GetColonistsCount(@PlanetName VARCHAR (30))
RETURNS INT
AS
BEGIN
	RETURN 
	(SELECT COUNT(c.Id) AS [Count] FROM Colonists AS c
	JOIN TravelCards AS tc ON c.Id = tc.ColonistId
	JOIN Journeys AS j ON tc.JourneyId = j.Id
	JOIN Spaceports AS s ON j.DestinationSpaceportId = s.Id
	JOIN Planets AS p ON s.PlanetId = p.Id
	WHERE p.Name = @PlanetName)
END
GO
SELECT dbo.udf_GetColonistsCount('Otroyphus')









