drop table if exists customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
drop table if exists Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);
drop table if exists Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);
-- Insert into Customers table
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'John Smith'),
(2, 'Jane Doe'),
(3, 'Alice Johnson'),
(4, 'Bob Wilson'),
(5, 'Emma Brown'),
(6, 'Michael Lee'),
(7, 'Sarah Davis'),
(8, 'David Clark');

-- Insert into Products table
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Smartphone', 'Electronics'),
(3, 'Headphones', 'Accessories'),
(4, 'Backpack', 'Bags'),
(5, 'Mouse', 'Accessories'),
(6, 'Keyboard', 'Accessories'),
(7, 'Monitor', 'Electronics'),
(8, 'Tablet', 'Electronics');

-- Insert into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2025-04-01'),
(2, 2, '2025-04-02'),
(3, 3, '2025-04-03'),
(4, 4, '2025-04-04'),
(5, 5, '2025-04-05'),
(6, 6, '2025-04-06'),
(7, 7, '2025-04-07');

-- Insert into OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 2, 999.99),
(2, 1, 3, 1, 49.99),
(3, 2, 2, 1, 699.99),
(4, 3, 4, 3, 29.99),
(5, 4, 5, 2, 19.99),
(6, 5, 6, 1, 59.99),
(7, 6, 7, 1, 199.99),
(8, 7, 8, 2, 399.99);

select * from customers
select * from Orders
select * from OrderDetails
select * from Products

--task1
--select Customers.CustomerID,
--    Customers.CustomerName,
--	Orders.OrderDate,
--	OrderDetails.OrderID
--	from Customers left join Orders on Customers.CustomerID = Orders.CustomerID left join OrderDetails on Orders.OrderID = OrderDetails.OrderID 


--task2
--select Customers.CustomerID,
--    Customers.CustomerName
--	from Customers left join Orders on Customers.CustomerID = Orders.CustomerID
--	WHERE Orders.OrderID IS NULL;


--task3
--select 
--Products.ProductName,
--OrderDetails.Quantity 
--from Products join OrderDetails on Products.ProductID = OrderDetails.ProductID 

--task4
--select Customers.CustomerName,
--OrderDetails.Quantity 
--from Customers join Orders on Customers.CustomerID = Orders.CustomerID join OrderDetails on Orders.OrderID  = OrderDetails.OrderID 
--where OrderDetails.Quantity>1

--task5
--SELECT DISTINCT
--    od1.OrderID,
--    od1.ProductID,
--    p.ProductName,
--    od1.Price
--FROM OrderDetails od1
--JOIN Products p ON od1.ProductID = p.ProductID
--LEFT JOIN OrderDetails od2 ON od1.OrderID = od2.OrderID AND od2.Price > od1.Price;

--task6
--SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
--FROM Customers c
--JOIN Orders o ON c.CustomerID = o.CustomerID
--LEFT JOIN Orders o2
--    ON o.CustomerID = o2.CustomerID
--    AND o.OrderDate < o2.OrderDate
--WHERE o2.OrderID IS NULL;


--task7
--select distinct c.CustomerName from Customers c join Orders o on o.CustomerID  = c.CustomerID join OrderDetails od on od.OrderID = o.Orderid join Products p on od.ProductID = p.ProductID
--LEFT JOIN OrderDetails od2 ON od2.OrderID = o.OrderID
--LEFT JOIN Products p2 ON od2.ProductID = p2.ProductID AND p2.Category <> 'Electronics'


--task8
--SELECT DISTINCT c.CustomerID, c.CustomerName
--FROM Customers c
--JOIN Orders o ON c.CustomerID = o.CustomerID
--JOIN OrderDetails od ON o.OrderID = od.OrderID
--JOIN Products p ON od.ProductID = p.ProductID
--WHERE p.Category = 'Stationery';

--task9
SELECT c.CustomerID, c.CustomerName, SUM(od.Quantity * od.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;


