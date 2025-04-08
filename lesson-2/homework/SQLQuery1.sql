--task1
--drop table if exists test_identity
--create table test_identity(id int identity (1,1))
--insert into test_identity default values
--select * from test_identity


--task2
--create table data_types_demo(id int primary key identity,name varchar(50),date_time date)
--insert into data_types_demo values ('a','2025-04-07')
--select * from data_types_demo


--task3
--DROP TABLE IF EXISTS photos
--create table photos(id int primary key,photo varbinary(MAX))
--insert into photos
--select 1,BulkColumn from openrowset(bulk 'C:\Users\shoki\Downloads\download.jpg',single_blob) as BWM

--select * from photos
/*PYTHON CODE:
import pyodbc
from bs4.diagnose import rword

con_str = "DRIVER={SQL SERVER};SERVER=Diyorbek;DATABASE=master;Trusted_Connection = yes;"
con = pyodbc.connect(con_str)
cursor = con.cursor()
cursor.execute(
    """
    select * from photos
    """
)

row = cursor.fetchone()
print(row)
id,data = row
with open(f'BWM.png','wb') as f:
    f.write(data)
*/

--task4
--create table student(id int primary key,name varchar(50),classes int,tuition_per_class int,total_tuition as (classes * tuition_per_class));
--insert into student values(1,'A',5,200),(2,'B',4,300)
--select * from student


--task5
--select * from openrowset(bulk
--'C:\Users\shoki\OneDrive\Desktop\sample1.csv',single_clob) as data;
--create table worker(id int,name varchar(50));
--bulk insert worker from 'C:\Users\shoki\OneDrive\Desktop\sample1.csv' with (firstrow=2,fieldterminator = ',',rowterminator = '\n')

--select * from worker

