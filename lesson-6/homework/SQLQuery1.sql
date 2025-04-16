use lessons 
drop table if exists departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');


drop table if exists Projects
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    EmployeeID INT
);

INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);

drop table if exists Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT foreign key references Departments(DepartmentID),
    Salary INT
);

INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);


select * from Employees
select * from Departments
select * from Projects

--task1
select * from Employees /*inner*/ join Departments on Employees.departmentid =Departments.DepartmentID

--task2
 select * from Employees left join Departments on Employees.departmentid =Departments.DepartmentID

 --task3
 select * from Employees right join Departments on Employees.departmentid =Departments.DepartmentID

 --task4
 select * from Employees  full outer join Departments on Employees.departmentid =Departments.DepartmentID

 --task5
SELECT DepartmentName, SUM(Salary) AS TotalSalary
FROM Departments
LEFT JOIN Employees
ON Departments.DepartmentID = Employees.DepartmentID
GROUP BY DepartmentName;

 --task6
  select * from Employees  cross join Departments

  --task7
SELECT Employees.Name, Departments.DepartmentName, Projects.ProjectName
FROM Employees
LEFT JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID
LEFT JOIN Projects
ON Employees.EmployeeID = Projects.EmployeeID;