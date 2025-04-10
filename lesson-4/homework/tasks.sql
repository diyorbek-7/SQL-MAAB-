--task 1
--CREATE TABLE [dbo].[TestMultipleZero]
--(
--    [A] [int] NULL,
--    [B] [int] NULL,
--    [C] [int] NULL,
--    [D] [int] NULL
--);
--GO

--INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
--VALUES 
--    (0,0,0,1),
--    (0,0,1,0),
--    (0,1,0,0),
--    (1,0,0,0),
--    (0,0,0,0),
--    (1,1,1,0);


--select * from TestMultipleZero
--where A!=0 or B!=0 or C!=0 or D!=0


--task 2
--CREATE TABLE TestMax
--(
--    Year1 INT
--    ,Max1 INT
--    ,Max2 INT
--    ,Max3 INT
--);
--GO
 
--INSERT INTO TestMax 
--VALUES
--    (2001,10,101,87)
--    ,(2002,103,19,88)
--    ,(2003,21,23,89)
--    ,(2004,27,28,91);

--select * from TestMax
--select *,
--	case 
--		when max1>=max2 and max1>=max3 then max1
--		when max2>=max3 and max2>=max1 then max2
--		else max3
--	end as maxvalue
--from TestMax;




--task 3
--drop table if exists mpbirth
--CREATE TABLE mpBirth
--(
--    EmpId INT  IDENTITY(1,1) 
--    ,EmpName VARCHAR(50) 
--    ,BirthDate DATETIME 
--);
 
--INSERT INTO mpBirth(EmpName,BirthDate)
--SELECT 'Pawan' , '12/04/1983'
--UNION ALL
--SELECT 'Zuzu' , '11/28/1986'
--UNION ALL
--SELECT 'Parveen', '05/07/1977'
--UNION ALL
--SELECT 'Mahesh', '01/13/1983'
--UNION ALL
--SELECT'Ramesh', '05/09/1983';

--select * from mpBirth
--where day(BirthDate) >=7 and month(BirthDate) = 5



--task 4
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

SELECT letter
FROM letters
ORDER BY CASE WHEN letter = 'b' THEN 1 ELSE 0 END, letter;









