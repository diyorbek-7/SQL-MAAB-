--task1
drop table if exists Employees
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
go
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

--select * from Employees

with cte as (
select EmployeeID,ManagerID,JobTitle,0 as depth
from Employees
where ManagerID is null
union all
select e.EmployeeID,e.ManagerID,e.JobTitle,c.depth +1
from Employees e
INNER JOIN cte c  ON e.ManagerID = c.EmployeeID
)
SELECT 
    EmployeeID,
    ManagerID,
    JobTitle,
    Depth
FROM cte
ORDER BY EmployeeID;

--task2

with cte as (
select 1 as Num , 1 as Factorial
union all
select num +1,Factorial*(num +1)
from cte c
where num <10
)
select Num,Factorial from cte;

--task3
;with cte as (
select 1 as n , 1 as Fibonacci_Number , 0 as prev
union all
select n+1,fibonacci_number + prev , fibonacci_number
from cte
where fibonacci_number + prev <101
)
select n,Fibonacci_Number from cte





