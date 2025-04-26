CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);
INSERT INTO Shipments (N, Num) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), -- 8 days with Num = 1
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), -- 5 days with Num = 2
(14, 4), (15, 4), (16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), (23, 4), (24, 4), (25, 4), -- 12 days with Num = 4
(26, 5), (27, 5), (28, 5), (29, 5), (30, 5), (31, 5), -- 6 days with Num = 5
(32, 6), 
(33, 7);


WITH cte AS (
    SELECT TOP 40 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS days
    FROM sys.objects a CROSS JOIN sys.objects b
),
AdjustedTable AS (
    SELECT ISNULL(S.Num, 0) AS Numbers
    FROM cte C
    LEFT JOIN Shipments S ON C.days = S.N
),
Ranked AS (
    SELECT Numbers,
           ROW_NUMBER() OVER (ORDER BY Numbers) AS rnk,
           COUNT(*) OVER () AS Total_rows
    FROM AdjustedTable
)
SELECT AVG(1.0 * Numbers) AS MEDIAN
FROM Ranked
WHERE rnk IN (
    FLOOR((Total_rows + 1) / 2),
    CEILING((Total_rows + 1) / 2)
);

