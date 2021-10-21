USE Geography

SELECT * FROM Peaks
ORDER BY PeakName ASC

SELECT *FROM Countries
SELECT*FROM Continents

SELECT TOP(30)*FROM Countries
WHERE ContinentCode='EU'
ORDER BY Population DESC

SELECT CountryName, CountryCode, CurrencyCode,
	CASE
		WHEN CurrencyCode = 'EUR' THEN 'Euro'
		ELSE 'Not Euro'
	END AS [Currency]
FROM Countries
ORDER BY CountryName




