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


