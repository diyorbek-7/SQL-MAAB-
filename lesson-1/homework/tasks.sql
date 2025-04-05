--task1
--use lessons
--create table students (id int,name varchar(50),age int)
--select * from students
--alter table students
--alter column id int not null


--task2
create table product(product_id int unique,product_name varchar(50),price decimal)
alter table product
drop constraint UQ__product__47027DF46885CC8E
alter table product
ADD CONSTRAINT UQ__product__47027DF46885CC8E UNIQUE (product_id, product_name);




