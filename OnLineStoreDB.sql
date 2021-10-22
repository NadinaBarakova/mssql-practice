CREATE DATABASE OnLineStore
GO
USE OnLineStore

CREATE TABLE Cities
(
	CityID INT NOT NULL,
	Name VARCHAR(50),
	CONSTRAINT PK_Cities PRIMARY KEY(CityID)
)

CREATE TABLE ItemTypes
(
	ItemTypeID INT NOT NULL,
	Name VARCHAR(50),
	CONSTRAINT PK_ItemTypes PRIMARY KEY(ItemTypeID)
)

CREATE TABLE Customers
(
	CustomerID INT NOT NULL,
	Name VARCHAR(50),
	Birthday DATE,
	CityID INT,
	CONSTRAINT PK_Customers PRIMARY KEY (CustomerID),
	CONSTRAINT FK_Customers_CityID FOREIGN KEY (CityID) REFERENCES Cities(CityID)
)

CREATE TABLE Items
(
	ItemID INT NOT NULL,
	Name VARCHAR(50),
	ItemTypeID INT,
	CONSTRAINT FK_Items_ItemTypes FOREIGN KEY(ItemTypeID) REFERENCES ItemTypes(ItemTypeID),
	CONSTRAINT PK_Items PRIMARY KEY(ItemID)
)

CREATE TABLE Orders
(
	OrderID INT NOT NULL,
	CustomerID INT,
	CONSTRAINT PK_Orders PRIMARY KEY (OrderID),
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

CREATE TABLE OrderItems
(
	OrderID INT,
	ItemID INT,
	CONSTRAINT FK_OrderItems_Orders FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT FK_OrderItems_ItemS FOREIGN KEY(ItemID) REFERENCES Items(ItemID),
	PRIMARY KEY (OrderID, ItemID)
)



