Select * from sys.databases WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');

create database testDB;

select * from sys.databases where name not in ('master','tempdb','model','msdb')

drop database testDB;

select * from sys.databases where name not in ('master','tempdb','model','msdb')

CREATE TABLE CUSTOMERS(
   ID   INT              NOT NULL,
   NAME VARCHAR (20)     NOT NULL,
   AGE  INT              NOT NULL,
   ADDRESS  CHAR (25) ,
   SALARY   DECIMAL (18, 2),       
   PRIMARY KEY (ID)
);

select * from sys.tables;

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (3, 'kaushik', 23, 'Kota', 2000.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 );

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY)
VALUES (6, 'Komal', 22, 'MP', 4500.00 );

select * from customers;

INSERT INTO CUSTOMERS 
VALUES (7, 'Muffy', 24, 'Indore', 10000.00 );

select id ,name from customers;

select id , name from customers
where name='komal';

select id,name,age,salary from customers
where salary>2000;

update customers 
set name = 'sachin',address = 'mp'
where id = 2;

update customers 
set name = 'sohan',address = 'rajsthan'
where id = 3;

select * from customers;

delete from customers
where id = 7;

select * from student;

ALTER TABLE student
DROP COLUMN dob;

select * from customers
where salary like '200%';

select * from customers;

select * from customers
where address like '%ba%';

select * from customers
where salary like '_5%'; 

select top 3 * from customers;

select top 3 name , age ,id from customers;

select * from customers order by name desc,salary ; 

select name,sum(salary) from customers
group by name;

select * from customers;

select  distinct salary from customers;

select * from customers
order by (case address
when 'Ahmedabad' then 1
when 'mp' then 2
when 'Mumbai' then 3
when 'Bhopal' then 4
when 'rajsthan' then 5
else 100 end) asc;                


ALTER TABLE customers DROP CONSTRAINT customers_PK;

select * from sys.tables;

create table order_table
(OID int not null unique,
DATE date not null ,
customer_id int not null ,
Amount int not null);



insert into order_table
values (102,'2022-3-4',2,3400);

insert into order_table
values (103 ,'2022-5-4',3,5324);

insert into order_table 
values ( 104,'2022-5-22',4,3420);

insert into order_table 
values (105,'2022-6-2',3,4522);

select * from order_table;
select * from customers;

select id,name,address,amount
from customers,order_table
where customers.id = order_table.customer_id;

select id , name,amount ,date
from customers left join order_table
on customers.id = order_table.customer_id
union
select id,name,amount ,date
from customers right join order_table
on customers.id = order_table.customer_id;

select id,name,amount ,date
from customers left join order_table
on customers.id = order_table.customer_id

except
select id,name,amount ,date
from customers right join order_table
on customers.id = order_table.customer_id;

select id,name,amount ,date
from customers left join order_table
on customers.id = order_table.customer_id

intersect
select id,name,amount ,date
from customers right join order_table
on customers.id = order_table.customer_id;

select id,name,amount ,date
from customers left join order_table
on customers.id = order_table.customer_id

union all
select id,name,amount ,date
from customers right join order_table
on customers.id = order_table.customer_id;

select id,name,address,salary
from customers
where salary is not null;

select * from customers;

select * from customers where salary is null;

select name,address,id as student
from customers as class;

select c.id,c.name,c.address,o.amount
from customers as c ,order_table as o
where c.id = o.customer_id;

create index id on customers;

Alter table customers add sex char(1);

select * from customers;
alter table customers drop sex;
ALTER TABLE CUSTOMERS DROP column SEX;

alter table customers alter column sex char(2);


ALTER TABLE customers
ADD CONSTRAINT MyUniqueConstraint UNIQUE(id,name);

alter table customers
drop constraint Myuniqueconstraint;

alter table customers
drop constraint myprimarykey;

ALTER TABLE customers
DROP CONSTRAINT MyPrimaryKey;

truncate table student;
select * from student;

create view customers_view as
select id,name,address
from customers;

select * from customers_view;

create view customers_seview as
select id,name,address
from customers where address in ('mp','bhopal','mumbai');

select * from customers_seview;

create view customers_thiview as
select id,name
from customers
with check option;

select * from customers_thiview;

update customers_thiview
set name ='rohit'
where id =2;

insert into customers_thiview
values (7,'ram');

drop view customers_thiview;


select * from customers;
select name,age,address
from customers group by age;

SELECT *
FROM CUSTOMERS
GROUP BY age
HAVING COUNT(age) >= 2;

select name ,sum(salary) from customers group by name having salary >= 3000;