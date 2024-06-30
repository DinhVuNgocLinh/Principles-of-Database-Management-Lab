CREATE DATABASE Ecommerce;

CREATE TABLE Customers (
    CustomerID char (20) PRIMARY KEY,
    FirstName nvarchar(50),
    LastName nvarchar(50),
    BankName nvarchar(200),
    BankAccountName nvarchar(200),
    BankAccountNumber nvarchar(200),
	password nvarchar(10)
);
CREATE TABLE CustomerMails (
    CustomerID char (20),
    Mail varchar(max),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
    ProductID char (20) PRIMARY KEY,
	ProductName nvarchar(50),
	ProductMaterial nvarchar(50),
	ProductType nvarchar(50),
	ProductQuantity int,
	ProductPrice int,
    SellersName nvarchar(200),
);
CREATE TABLE ProductPhotos (
    ProductID char (20),
    Photo varbinary(max),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE SellersMails (
    ProductID char (20),
    Mail varchar(max),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Orders (
    OrderID char (20) PRIMARY KEY,
    CustomerID char (20),
    ProductID char (20),
	ProductName nvarchar(50),
	ProductPrice int,
	Quantity int,
	ExpectedDelivery nvarchar(50),
	FeeDelivery int,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
SELECT Orders.OrderID, Products.ProductName, Products.ProductPrice, SUM(Orders.Quantity * Products.ProductPrice + Orders.FeeDelivery) as TotalPrice
FROM Orders
JOIN Products ON Orders.ProductID = Products.ProductID
GROUP BY Orders.OrderID, Products.ProductName, Products.ProductPrice;

SELECT Orders.OrderID, Products.ProductName, Products.ProductPrice
FROM Orders
JOIN Products ON Orders.ProductID = Products.ProductID;

