CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
drop table if exists orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'Alice', 'Johnson', 'HR', 90000.00, '2020-01-15'),
(2, 'Bob', 'Smith', 'IT', 120000.00, '2019-03-10'),
(3, 'Charlie', 'Lee', 'Sales', 75000.00, '2021-07-01'),
(4, 'Diana', 'Brown', 'IT', 95000.00, '2018-11-23'),
(5, 'Ethan', 'Clark', 'HR', 50000.00, '2022-05-14'),
(6, 'Fiona', 'Davis', 'Finance', 110000.00, '2017-08-05'),
(7, 'George', 'Wilson', 'Sales', 68000.00, '2021-02-19'),
(8, 'Hannah', 'Moore', 'Finance', 60000.00, '2020-09-30'),
(9, 'Ivan', 'Garcia', 'IT', 130000.00, '2016-12-01'),
(10, 'Judy', 'Martinez', 'HR', 47000.00, '2023-01-10');

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status) VALUES
(201, 'Alice Johnson', '2023-02-15', 3200.00, 'Shipped'),     -- Completed
(202, 'Bob Smith',     '2023-03-20', 2100.00, 'Delivered'),   -- Completed
(203, 'Charlie Lee',   '2023-05-10', 1800.00, 'Pending'),     -- Pending
(204, 'Diana Brown',   '2023-07-18', 6000.00, 'Delivered'),   -- Completed (included in result)
(205, 'Ethan Clark',   '2023-08-01', 7200.00, 'Shipped'),     -- Completed (included in result)
(206, 'Fiona Davis',   '2023-09-12', 300.00,  'Cancelled'),   -- Cancelled
(207, 'George Wilson', '2023-10-05', 5300.00, 'Pending'),     -- Pending (included in result)
(208, 'Hannah Moore',  '2023-11-15', 8000.00, 'Cancelled'),   -- Cancelled (included in result)
(209, 'Ivan Garcia',   '2023-12-20', 1500.00, 'Delivered'),   -- Completed
(210, 'Judy Martinez', '2023-04-09', 9000.00, 'Shipped');  

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status) VALUES
(101, 'Michael Scott', '2024-03-15', 250.75, 'Delivered'),
(102, 'Pam Beesly', '2024-03-16', 100.00, 'Shipped'),
(103, 'Jim Halpert', '2024-03-17', 175.50, 'Pending'),
(104, 'Dwight Schrute', '2024-03-18', 300.00, 'Cancelled'),
(105, 'Stanley Hudson', '2024-03-19', 90.25, 'Delivered');


INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(201, 'Laptop', 'Electronics', 899.99, 10),
(202, 'Wireless Mouse', 'Accessories', 25.99, 50),
(203, 'Keyboard', 'Accessories', 45.00, 30),
(204, 'Monitor', 'Electronics', 199.99, 20),
(205, 'Office Chair', 'Furniture', 120.00, 15);

--task1
select department, 
Avg(salary) as AverageSalary,
	case
		when Avg(salary) > 80000 then 'High'
		when Avg(salary) between 50000 and 80000 then 'Medium'
		else 'Low'
	end as 'SalaryCategory'
from(
select top 10 percent * from Employees order by Salary desc) as TopPaid
GROUP BY Department
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;

select * from Orders
--task2
select
	case 
		 WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
	end as orderstatus,COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue from Orders
where Orderdate between '2023-01-01' and'2023-12-31'
group by 
	case
		WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
	end
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;

--task3
SELECT 
    Products.ProductID,
    Products.ProductName,
    Products.Category,
    Products.Price,
    Products.Stock,
    IIF(Products.Stock = 0, 'Out of Stock',
        IIF(Products.Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM Products
JOIN (
    SELECT Category, MAX(Price) AS MaxPrice
    FROM Products
    GROUP BY Category
) AS TopProducts
ON Products.Category = TopProducts.Category AND Products.Price = TopProducts.MaxPrice
ORDER BY Products.Price DESC
OFFSET 5 ROWS;






