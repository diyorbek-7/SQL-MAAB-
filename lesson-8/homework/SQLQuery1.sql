--task1
--CREATE TABLE StepStatus (
--    StepNumber INT PRIMARY KEY,
--    Status VARCHAR(10) NOT NULL
--);

--INSERT INTO StepStatus (StepNumber, Status) VALUES
--(1, 'Passed'),
--(2, 'Passed'),
--(3, 'Passed'),
--(4, 'Passed'),
--(5, 'Failed'),
--(6, 'Failed'),
--(7, 'Failed'),
--(8, 'Failed'),
--(9, 'Failed'),
--(10, 'Passed'),
--(11, 'Passed'),
--(12, 'Passed');


--SELECT
--    MIN(StepNumber) AS MinStepNumber,
--    MAX(StepNumber) AS MaxStepNumber,
--    Status,
--    COUNT(*) AS ConsecutiveCount
--FROM (
--    SELECT *,
--        ROW_NUMBER() OVER (ORDER BY StepNumber) -
--        ROW_NUMBER() OVER (PARTITION BY Status ORDER BY StepNumber) AS grp
--    FROM StepStatus
--) AS Numbered
--GROUP BY Status, grp
--ORDER BY MinStepNumber;




--task2
CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](28) NULL,
    [HIRE_DATE] [date] NOT NULL
);

-- Insert employees with hire dates in years that should have hires
INSERT INTO [dbo].[EMPLOYEES_N] (EMPLOYEE_ID, FIRST_NAME, HIRE_DATE) VALUES
(1, 'John', '1975-01-15'),
(2, 'Jane', '1976-03-22'),
(3, 'Alice', '1977-07-10'),
(4, 'Bob', '1979-11-05'),
(5, 'Charlie', '1980-02-14'),
(6, 'David', '1982-06-30'),
(7, 'Eve', '1983-09-12'),
(8, 'Frank', '1984-04-25'),
(9, 'Grace', '1985-08-19'),
(10, 'Hank', '1987-12-01'),
(11, 'Ivy', '1988-05-17'),
(12, 'Jack', '1989-10-09'),
(13, 'Kelly', '1990-03-03'),
(14, 'Liam', '1997-07-20');


SELECT
    CASE
        WHEN IntervalYear < 2 OR HireYear < 1975 THEN NULL
        WHEN IntervalYear >= 2 AND NextYear IS NOT NULL THEN CONCAT(CAST(HireYear + 1 AS NVARCHAR), ' - ', CAST(NextYear - 1 AS NVARCHAR))
        WHEN NextYear IS NULL THEN CONCAT(CAST(HireYear + 1 AS NVARCHAR), ' - ', '2025')
    END AS Years
FROM (
    SELECT
        CAST(YEAR(HIRE_DATE) AS INT) AS HireYear,
        LEAD(CAST(YEAR(HIRE_DATE) AS INT)) OVER (ORDER BY HIRE_DATE) AS NextYear,
        LEAD(CAST(YEAR(HIRE_DATE) AS INT)) OVER (ORDER BY HIRE_DATE) - CAST(YEAR(HIRE_DATE) AS INT) AS IntervalYear
    FROM EMPLOYEES_N
) AS T
WHERE (
    CASE
        WHEN IntervalYear < 2 OR HireYear < 1975 THEN NULL
        WHEN IntervalYear >= 2 AND NextYear IS NOT NULL THEN CONCAT(CAST(HireYear + 1 AS NVARCHAR), ' - ', CAST(NextYear - 1 AS NVARCHAR))
        WHEN NextYear IS NULL THEN CONCAT(CAST(HireYear + 1 AS NVARCHAR), ' - ', '2025')
    END
) IS NOT NULL
ORDER BY HireYear;