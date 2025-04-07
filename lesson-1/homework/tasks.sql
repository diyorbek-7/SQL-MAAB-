--task1
--use lessons
--create table students (id int,name varchar(50),age int)
--select * from students
--alter table students
--alter column id int not null


--task2
--create table product(product_id int unique,product_name varchar(50),price decimal)
--alter table product
--drop constraint UQ__product__47027DF46885CC8E
--alter table product
--ADD CONSTRAINT UQ__product__47027DF46885CC8E UNIQUE (product_id, product_name);

----task3
--create table orders(order_id int primary key,customer_name varchar(50),order_date varchar(50))
--alter table orders
--drop constraint PK__orders__465962294C2E1F7C
--alter table orders
--add constraint PK__orders__465962294C2E1F7C primary key(order_id)


--tast4
--create table category(category_id int primary key,category_name varchar(50))
--create table item(item_id int,item_name varchar(50),category_id int,constraint fk_constraint foreign key (category_id) references category(category_id))
--alter table item
--drop constraint fk_constraint 
--alter table item
--add constraint fk foreign key(category_id) references category(category_id);



--task5
--create table account(account_id int primary key,balance decimal constraint c1 check (balance>=0),account_type varchar(50) constraint c2 check(account_type = 'Saving' or account_type = 'Checking'))
--alter table account
--drop constraint c1
--alter table account
--drop constraint c2
--alter table account
--add constraint c3 check (balance>=0)
--alter table account
--add constraint c4 check(account_type = 'Saving' or account_type = 'Checking')



--task6
--create table customer (customer_id int primary key,name varchar(50),city varchar(50) constraint cc default'Unknown')
--alter table customer
--drop constraint cc
--alter table customer
--add constraint cs default 'Unknown' for city


--task7
--create table invoke(invoice_id int identity,amount decimal)
--insert into invoke(amount) values(40),(50),(60),(70),(80)
--select * from invoke



--task8
create table book(book_id int primary key,title varchar(50),author varchar(50),published_year int)
create table member(member_id int primary key,name varchar(50),email varchar(50),phone_number varchar(50))
create table loan(load_id int primary key	,book_id int foreign key references book(book_id),member_id int foreign key references member(member_id),loan_date date,return_date date)
insert into book values (1, '1984', 'george orwell', 1949);
insert into book values (2, 'to kill a mockingbird', 'harper lee', 1960);

insert into member values (1, 'alice smith', 'alice@example.com', '1234567890');
insert into member values (2, 'bob johnson', 'bob@example.com', '0987654321');

insert into loan values (1, 1, 1, '2025-04-01', null);
insert into loan values (2, 2, 2, '2025-04-02', '2025-04-05');





































