USE [ApressFinancial]
GO

INSERT INTO ShareDetails.Shares
(ShareDesc, ShareTickerId,CurrentPrice)
VALUES ('FAT-BELLY.COM','FBC',45.20)
INSERT INTO ShareDetails.Shares
(ShareDesc, ShareTickerId,CurrentPrice)
VALUES ('NetRadio Inc','NRI',29.79)
INSERT INTO ShareDetails.Shares
(ShareDesc, ShareTickerId,CurrentPrice)
VALUES ('Texas Oil Industries','TOI',0.455)
INSERT INTO ShareDetails.Shares
(ShareDesc, ShareTickerId,CurrentPrice)
VALUES ('Texas Oil Industries','TOI',0.455)

GO

SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareDesc = 'FAT-BELLY.COM'
SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareDesc = 'FAT-BELLY.COm'

SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareDesc > 'FAT-BELLY.COM'
AND ShareDesc < 'TEXAS OIL INDUSTRIES'

SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareDesc <> 'FAT-BELLY.COM'
SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE NOT ShareDesc = 'FAT-BELLY.COM'

SELECT ShareTickerId,CurrentPrice
INTO New_Table_Test
FROM ShareDetails.Shares

SELECT * FROM ShareDetails.Shares
SELECT * FROM ShareDetails.SharePrices
SELECT * FROM CustomerDetails.Customers
SELECT * FROM CustomerDetails.FinancialProducts
SELECT * FROM CustomerDetails.CustomerProducts
SELECT * FROM TransactionDetails.Transactions
SELECT * FROM TransactionDetails.TransactionTypes