
drop table if exists Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);
go
-- Insert sample data into the Employees table
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate)
VALUES 
    (1, 'John Doe', 'Engineering', 75000.50, '2023-01-15'),
    (2, 'Jane Smith', 'Marketing', 65000.75, '2022-06-20'),
    (3, 'Mike Johnson', 'Finance', 80000.00, '2021-09-10'),
    (4, 'Sarah Williams', 'HR', 70000.25, '2023-03-01'),
    (5, 'Tom Brown', 'Engineering', 82000.40, '2020-11-05');


INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate)
VALUES 
    (6, 'Emily Davis', 'Marketing', 68000.90, '2024-02-10'),
    (7, 'David Lee', 'Finance', 85000.30, '2022-12-15'),
    (8, 'Lisa Chen', 'HR', 72000.60, '2023-07-22'),
    (9, 'Mark Taylor', 'Engineering', 78000.15, '2021-04-18'),
    (10, 'Anna White', 'Sales', 69000.80, '2024-01-05'),
    (11, 'James Wilson', 'Engineering', 75000.50, '2023-05-12'),  -- Same salary as John Doe
    (12, 'Rachel Green', 'Marketing', 65000.75, '2022-08-30'),  -- Same salary as Jane Smith
    (13, 'Peter Harris', 'Finance', 80000.00, '2021-11-25'),    -- Same salary as Mike Johnson
    (14, 'Laura Adams', 'Sales', 69000.80, '2024-03-15'),      -- Same salary as Anna White
    (15, 'Chris Evans', 'HR', 70000.25, '2023-09-10');         -- Same salary as Sarah Williams


select * from Employees

--task1
select * ,
	DENSE_RANK() over(order by salary desc)
from Employees

--task2
select *,
case
	when count(*) over(partition by salary) > 1 then 'has same salary'
	else 'unique salary'
end  as salaryStatus
from Employees
order by EmployeeID

--task3
select *,
	DENSE_RANK()over(partition by  department order by salary desc),
	case
	when
		DENSE_RANK()over(partition by  department order by salary desc)	<=2 then 'top 2'
		else 'not top 2'
		end as 'determine top 2'
from Employees
order by Department


--task4
select *,
case when
	DENSE_RANK() over(partition by department order by salary ) = 1 then 'lowest paid'
	else 'not the lowest'
	end as 'determine lowest-paid'
from Employees

--task5
select *,
	sum (salary) over(partition by department order by employeeid) as running_total
from Employees

--task6
select *,
	sum (salary) over(partition by department) as TotalSalaryOfEachDep
from Employees

--task7
select *,
	cast(avg(salary) over(partition by department) as decimal(10,0)) as A
from Employees

--task8
select *,
	abs(salary - avg(salary) over(partition by department))
from Employees


--task9
select *,
	cast(avg(salary) over(partition by department order by department rows between 1 preceding and 1 following) as decimal(10,0)) as A
from Employees

--task10



--task11
select * ,
	avg(salary) over(order by employeeid rows between unbounded preceding and current row )
from Employees

--task12
SELECT 
   *,
    MAX(Salary) OVER (
        ORDER BY EmployeeID
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
    ) AS MaxSalaryInWindow
FROM Employees;

--task13
SELECT 
    EmployeeID, Name, Department, Salary, HireDate,
    (Salary * 100.0 / SUM(Salary) OVER (PARTITION BY Department)) AS PercentContribution
FROM Employees;