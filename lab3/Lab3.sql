--Task1:
SELECT * FROM CustomerDetails.Customers
UPDATE CustomerDetails.Customers 
SET CustomerLastName = 'Brodie' 
WHERE CustomerId = 1 
SELECT * FROM CustomerDetails.Customers 
WHERE CustomerId = 1 
DECLARE @ValueToUpdate VARCHAR(30) 
SET @ValueToUpdate = 'McGlynn' 
UPDATE CustomerDetails.Customers 
SET CustomerLastName = @ValueToUpdate, 
ClearedBalance = ClearedBalance + UnclearedBalance , 
UnclearedBalance = 0 
WHERE CustomerLastName = 'Brodie' 
SELECT CustomerFirstName, CustomerLastName, 
ClearedBalance, UnclearedBalance 
FROM CustomerDetails.Customers 
WHERE CustomerId = 1
DECLARE @WrongDataType VARCHAR(20) 
SET @WrongDataType = '4311.22' 
UPDATE CustomerDetails.Customers 
SET ClearedBalance = @WrongDataType 
WHERE CustomerId = 1
SELECT CustomerFirstName, CustomerLastName, 
ClearedBalance, UnclearedBalance 
FROM CustomerDetails.Customers 
WHERE CustomerId = 1
--DECLARE @WrongDataType VARCHAR(20)
--SET @WrongDataType = '2.0'
--UPDATE CustomerDetails.Customers
--SET AddressId = @WrongDataType
--WHERE CustomerId = 1--Task2:SELECT 'Before',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareId = 2
BEGIN TRAN ShareUpd
UPDATE ShareDetails.Shares
SET CurrentPrice = CurrentPrice * 1.1
WHERE ShareId = 2
COMMIT TRAN
SELECT 'After',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareId = 2

SELECT 'Before',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
 WHERE ShareId = 2
BEGIN TRAN ShareUpd
UPDATE ShareDetails.Shares
SET CurrentPrice = CurrentPrice * 1.1
WHERE ShareId = 2
SELECT 'Within the transaction',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
ROLLBACK TRAN
SELECT 'After',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareId = 2BEGIN TRAN ShareUpd
SELECT '1st TranCount',@@TRANCOUNT
BEGIN TRAN ShareUpd2
SELECT '2nd TranCount',@@TRANCOUNT
COMMIT TRAN ShareUpd2
SELECT '3rd TranCount',@@TRANCOUNT
COMMIT TRAN -- It is at this point that data modifications will be committed
SELECT 'Last TranCount',@@TRANCOUNT--Task3:SELECT CustomerFirstName + ' ' + CustomerLastName AS [Name],
ClearedBalance,UnclearedBalance
INTO CustTemp
FROM CustomerDetails.Customers

BEGIN TRAN
DELETE CustTemp

BEGIN TRAN
SELECT * FROM CustTemp
DELETE CustTemp
SELECT * FROM CustTemp
ROLLBACK TRAN
SELECT * FROM CustTemp

BEGIN TRAN
SELECT * FROM CustTemp
DELETE TOP (2) CustTemp
SELECT * FROM CustTemp
ROLLBACK TRAN
SELECT * FROM CustTemp

--Task4:
TRUNCATE TABLE CustomerDetails.Customers
