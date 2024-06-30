

IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'ApressFinancial')
DROP DATABASE [ApressFinancial]
GO
CREATE DATABASE ApressFinancial 
GO


USE [ApressFinancial]
GO
CREATE SCHEMA [TransactionDetails] AUTHORIZATION dbo
GO
CREATE SCHEMA [ShareDetails] AUTHORIZATION dbo
GO
CREATE SCHEMA [CustomerDetails] AUTHORIZATION dbo

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CustomerDetails].[Customers](
	[CustomerId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerTitleId] [int] NOT NULL,
	[CustomerFirstName] [nvarchar](50) NOT NULL,
	[CustomerOtherInitials] [nvarchar](50) NULL,
	[CustomerLastName] [nvarchar](50) NOT NULL,
	[AddressId] [bigint] NOT NULL,
	[AccountNumber] [nvarchar](15) NOT NULL,
	[AccountTypeId] [int] NOT NULL,
	[ClearedBalance] [money] NOT NULL,
	[UnclearedBalance] [money] NOT NULL,
	[DateAddedd] [datetime] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY NONCLUSTERED 
(
	[CustomerId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CustomerDetails].[CustomerProducts](
	[CustomerFinancialProductId] [bigint] NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[FinancialProductId] [bigint] NOT NULL,
	[AmountToCollect] [money] NOT NULL,
	[Frequency] [smallint] NOT NULL,
	[LastCollected] [datetime] NOT NULL,
	[LastCollection] [datetime] NOT NULL,
	[Renewable] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerProducts] PRIMARY KEY CLUSTERED 
(
	[CustomerFinancialProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CustomerDetails].[CustomerProducts]  WITH CHECK ADD  CONSTRAINT [FK_Customers_CustomerProducts] FOREIGN KEY(CustomerId)
REFERENCES [CustomerDetails].[Customers](CustomerId)
GO

CREATE TABLE TransactionDetails.Transactions
(TransactionId bigint IDENTITY(1,1) NOT NULL,
CustomerId bigint NOT NULL,
TransactionType int NOT NULL,
DateEntered datetime NOT NULL,
Amount numeric(18, 5) NOT NULL,
ReferenceDetails nvarchar(50) NULL,
Notes nvarchar(max) NULL,
RelatedShareId bigint NULL,
RelatedProductId bigint NOT NULL)


USE ApressFinancial
GO

IF OBJECT_ID('TransactionDetails.TransactionTypes',
'U') IS NOT NULL
DROP TABLE TransactionDetails.TransactionTypes
GO
CREATE TABLE TransactionDetails.TransactionTypes(
TransactionTypeId int IDENTITY(1,1) NOT NULL,
TransactionDescription nvarchar(30) NOT NULL,
CreditType bit NOT NULL
)
GO
ALTER TABLE TransactionDetails.TransactionTypes
ADD AffectCashBalance bit NULL
GO
ALTER TABLE TransactionDetails.TransactionTypes
ALTER COLUMN AffectCashBalance bit NOT NULL
GO
USE ApressFinancial
GO
CREATE TABLE CustomerDetails.CustomerProducts(
CustomerFinancialProductId bigint NOT NULL,
CustomerId bigint NOT NULL,
FinancialProductId bigint NOT NULL,
AmountToCollect money NOT NULL,
Frequency smallint NOT NULL,
LastCollected datetime NOT NULL,
LastCollection datetime NOT NULL,
Renewable bit NOT NULL
)
ON [PRIMARY]
GO
CREATE TABLE CustomerDetails.FinancialProducts(
ProductId bigint NOT NULL,
ProductName nvarchar(50) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE ShareDetails.SharePrices(
SharePriceId bigint IDENTITY(1,1) NOT NULL,
ShareId bigint NOT NULL,
Price numeric(18, 5) NOT NULL,
PriceDate datetime NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE ShareDetails.Shares(
ShareId bigint IDENTITY(1,1) NOT NULL,
ShareDesc nvarchar(50) NOT NULL,
ShareTickerId nvarchar(50) NULL,
CurrentPrice numeric(18, 5) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE CustomerDetails.Customers
ADD CONSTRAINT
PK_Customers PRIMARY KEY NONCLUSTERED
(
CustomerId
)
WITH(STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO
USE [ApressFinancial]
GO

SET QUOTED_IDENTIFIER OFF
GO
INSERT INTO [ApressFinancial].[ShareDetails].[Shares]
([ShareDesc] 
,[CurrentPrice])
 VALUES
("ACME'S HOMEBAKE COOKIES INC",
2.34125)
GO


USE ApressFinancial
GO
ALTER TABLE CustomerDetails.CustomerProducts
ADD CONSTRAINT PK_CustomerProducts
PRIMARY KEY CLUSTERED
(CustomerFinancialProductId) ON [PRIMARY]
GO
ALTER TABLE CustomerDetails.CustomerProducts
WITH NOCHECK
ADD CONSTRAINT CK_CustProds_AmtCheck
CHECK ((AmountToCollect > 0))
GO
ALTER TABLE CustomerDetails.CustomerProducts WITH NOCHECK
ADD CONSTRAINT DF_CustProd_Renewable
DEFAULT (0)
FOR Renewable

USE [ApressFinancial]
GO

INSERT INTO CustomerDetails.CustomerProducts
(CustomerFinancialProductId,CustomerId,FinancialProductId
,AmountToCollect,Frequency,
LastCollected,LastCollection,Renewable)
VALUES (1,1,1,-100,0,'24 Aug 2005','24 Aug 2005',0)

INSERT INTO CustomerDetails.CustomerProducts
(CustomerFinancialProductId,CustomerId,FinancialProductId
,AmountToCollect,Frequency,
LastCollected,LastCollection)
VALUES (1,1,1,100,0,'24 Aug 2005','23 Aug 2005')
GO

USE [ApressFinancial]
GO

INSERT INTO CustomerDetails.Customers
(CustomerTitleId,CustomerFirstName,CustomerOtherInitials,
CustomerLastName,AddressId,AccountNumber,AccountTypeId,
ClearedBalance,UnclearedBalance)
VALUES 
(3,'Bernie','I','McGee',314,65368765,1,6653.11,0.00),
(2,'Julie','A','Dewson',2134,81625422,1,53.32,-12.21),
(1,'Kirsty',NULL,'Hull',4312,96565334,1,1266.00,10.32)

GO
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