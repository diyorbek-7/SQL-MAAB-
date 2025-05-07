DECLARE @Year INT = 2025;
DECLARE @Month INT = 5; -- May 2025

WITH DateList AS (
    SELECT DATEADD(DAY, number, DATEFROMPARTS(@Year, @Month, 1)) AS CalendarDate
    FROM master.dbo.spt_values
    WHERE type = 'P'
    AND number BETWEEN 0 AND DATEDIFF(DAY, DATEFROMPARTS(@Year, @Month, 1), EOMONTH(DATEFROMPARTS(@Year, @Month, 1)))
),
Weeks AS (
    SELECT 
        DATEPART(WEEK, CalendarDate) - DATEPART(WEEK, DATEFROMPARTS(@Year, @Month, 1)) + 1 AS WeekNumber,
        DATENAME(WEEKDAY, CalendarDate) AS DayName,
        DATEPART(DAY, CalendarDate) AS DayNumber
    FROM DateList
)
SELECT 
    WeekNumber,
    MAX(CASE WHEN DayName = 'Sunday' THEN DayNumber END) AS Sunday,
    MAX(CASE WHEN DayName = 'Monday' THEN DayNumber END) AS Monday,
    MAX(CASE WHEN DayName = 'Tuesday' THEN DayNumber END) AS Tuesday,
    MAX(CASE WHEN DayName = 'Wednesday' THEN DayNumber END) AS Wednesday,
    MAX(CASE WHEN DayName = 'Thursday' THEN DayNumber END) AS Thursday,
    MAX(CASE WHEN DayName = 'Friday' THEN DayNumber END) AS Friday,
    MAX(CASE WHEN DayName = 'Saturday' THEN DayNumber END) AS Saturday
FROM Weeks
GROUP BY WeekNumber
ORDER BY WeekNumber;