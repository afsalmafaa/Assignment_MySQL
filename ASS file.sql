show databases;
use test;
create table SalesPeople(
Snum int primary key,
Sname varchar(260) unique,
City varchar(260),
Comm decimal(5,2)
);
insert into SalesPeople (Snum, Sname, City, Comm) values
(1001, "Peel", "London", 0.12),
(1002, "Serres", "Sanjose", 0.13),
(1004, "Motika", "London", 0.11),
(1007, "Rifkin", "Barcelona", 0.15),
(1003, "Axelrod", "Newyork", 0.10);

select * from SalesPeople;

create table Customers (
Cnum int primary key,
Cname varchar(200),
City varchar(200) not null,
Snum int,
foreign key (Snum) references SalesPeople(Snum)
);
insert into Customers (Cnum, Cname, City, Snum) values
(2001, "Hoffman", "London", 1001),
(2002, "Giovanni", "Rome", 1003),
(2003, "Liu", "Sanjose", 1002),
(2004, "Grass", "Berlin", 1002),
(2006, "Clemens", "London", 1001),
(2008, "Cisneros", "Sanjose", 1007),
(2007, "Pereira", "Rome", 1004);

select * from Customers;

create table Orders (
Onum int primary key,
Amt decimal (10,2),
Odate date,
Cnum int, foreign key (Cnum) references Customers(Cnum),
Snum int, foreign key (snum) references SalesPeople(Snum)
);
insert into Orders (Onum, Amt, Odate, Cnum, Snum) values
(3001, 18.69, '1990-03-10', 2008, 1007),
(3003, 767.19, '1990-03-10', 2001, 1001),
(3002, 1900.10, '1990-03-10', 2007, 1004),
(3005, 5160.45, '1990-03-10', 2003, 1002),
(3006, 1098.16, '1990-03-10', 2008, 1007),
(3009, 1713.23, '1990-04-10', 2002, 1003),
(3007, 75.75, '1990-04-10', 2004, 1002),
(3008, 4273.00, '1990-05-10', 2006, 1001),
(3010, 1309.95, '1990-06-10', 2004, 1002),
(3011, 9891.88, '1990-06-10', 2006, 1001);

select * from Orders;

select count(*)
from SalesPeople
where upper(Sname) like 'A%';

select S.Snum, S.Sname
from SalesPeople S
where S.Snum in (
	select O.Snum
    from Orders O
    group by O.Snum
    having sum(O.Amt) > 2000
);

select count(*)
from SalesPeople
where City = "Newyork";

select City, count(*)
from SalesPeople
where City in ("London", "Paris")
group by City;

SELECT S.Snum, S.Sname, COUNT(O.Onum) AS NumOrders, MIN(O.Odate) AS FirstOrderDate
FROM SalesPeople S
LEFT JOIN Orders O ON S.Snum = O.Snum
GROUP BY S.Snum, S.Sname;
