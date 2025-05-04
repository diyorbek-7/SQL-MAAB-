--task1
drop table if exists employee
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary INT NOT NULL
);


INSERT INTO Employee (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'Sales', 6000),
(4, 'David', 'HR', 5500),
(5, 'Emma', 'IT', 7200);

CREATE TABLE #EmployeeTransfers (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary INT NOT NULL
);


INSERT INTO #EmployeeTransfers (EmployeeID, Name, Department, Salary)
SELECT 
    EmployeeID,
    Name,
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
    END AS Department,
    Salary
FROM Employee;

select * from #EmployeeTransfers

--task2



CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Product VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL
);

INSERT INTO Orders_DB1 (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);


CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Product VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL
);

INSERT INTO Orders_DB2 (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

declare @MissingOrders table (
	OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Product VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL
)
insert into @MissingOrders (OrderID,CustomerName,Product,Quantity) 
select o1.OrderID,
	o1.CustomerName,
	o1.Product,
	o1.Quantity from Orders_DB1 o1 LEFT JOIN Orders_DB2 o2 ON o1.OrderID = o2.OrderID WHERE o2.OrderID IS NULL

select * from @MissingOrders



--
CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog (EmployeeID, EmployeeName, Department, WorkDate, HoursWorked) VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

select * from WorkLog

CREATE VIEW vw_MonthlyWorkSummary AS
SELECT 
    w.EmployeeID,
    w.EmployeeName,
    w.Department,
    SUM(w.HoursWorked) AS TotalHoursWorked,
    SUM(SUM(w.HoursWorked)) OVER (PARTITION BY w.Department) AS TotalHoursDepartment,
    AVG(SUM(w.HoursWorked)) OVER (PARTITION BY w.Department) AS AvgHoursDepartment
FROM WorkLog w
GROUP BY w.EmployeeID, w.EmployeeName, w.Department;

SELECT * FROM vw_MonthlyWorkSummary;

