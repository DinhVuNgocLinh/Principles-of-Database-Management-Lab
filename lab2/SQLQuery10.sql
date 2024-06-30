USE [ApressFinancial]
GO

SELECT * FROM CustomerDetails.Customers

SELECT CustomerFirstName,CustomerLastName,ClearedBalance
FROM CustomerDetails.Customers

SELECT CustomerFirstName As 'First Name',
CustomerLastName AS 'Surname',
ClearedBalance Balance
FROM CustomerDetails.Customers

GO


