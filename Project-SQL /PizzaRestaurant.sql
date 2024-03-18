-- Simple Pizza Restaurant
-- 1. Create 3 Tables of Customers, Menus, and Orders with key relationships
-- "Orders" is a bridge table to support many-to-many relationshiop between Customers and Menus

CREATE TABLE Customers (
  cust_id int,
  first_name text,
  last_name text,
  mobile text
);

CREATE TABLE Menus (
  menu_id int,
  menu_name text,
  menu_category text,
  menu_price int
);

CREATE TABLE Orders (
  order_id int,
  order_date DATE,
  cust_id int,
  menu_id int,
  quantity int
);

-- 2. Insert Test data into 3 tables

INSERT INTO Customers VALUES
  (1, 'Ali', 'Beck', '0812345678'),
  (2, 'Verge', 'Vanden', '0982345678'),
  (3, 'Luis', 'Camacho', '0898765432'),
  (4, 'Mo', 'Salaz', '0876543210'),
  (5, 'Lucie', 'Wick', '0996543210');

INSERT INTO Menus VALUES
  (1, 'Hawaiian', 'Pizza', 199),
  (2, 'Seafood Cocktail', 'Pizza', 299),
  (3, 'Super Deluxe', 'Pizza', 399),
  (4, 'Spicy Super Seafood', 'Pizza', 399),
  (5, 'Shrimp Cocktail', 'Pizza', 299),
  (6, 'Roasted spinach', 'Pizza', 199),
  (7, 'Spaghetti Cabonara', 'Pasta', 299),
  (8, 'Bolognese', 'Pasta', 199),
  (9, 'Caesar Salad', 'Salad', 149),
  (10, 'Coca Cola', 'Drink', 99),  
  (11, 'Water', 'Drink', 39),
  (12, 'Black Coffee', 'Drink', 59);

INSERT INTO Orders VALUES
  (1, '2023-08-01', 1, 1, 1),
  (2, '2023-08-01', 2, 2, 2),
  (3, '2023-08-01', 3, 3, 1),
  (4, '2023-08-01', 4, 4, 2),
  (5, '2023-08-01', 5, 5, 1),
  (6, '2023-08-02', 1, 6, 2),
  (7, '2023-08-02', 2, 7, 1),
  (8, '2023-08-02', 3, 8, 2),
  (9, '2023-08-02', 4, 9, 1),
  (10, '2023-08-02', 5, 10, 2),
  (11, '2023-08-03', 1, 11, 1),
  (12, '2023-08-03', 2, 12, 2),
  (13, '2023-08-03', 3, 12, 1),
  (14, '2023-08-03', 4, 11, 2),
  (15, '2023-08-03', 5, 10, 1),
  (16, '2023-08-04', 1, 9, 2),
  (17, '2023-08-04', 2, 8, 1),
  (18, '2023-08-04', 3, 7, 2),
  (19, '2023-08-04', 4, 6, 1),
  (20, '2023-08-04', 5, 5, 2),
  (21, '2023-08-05', 1, 4, 1),
  (22, '2023-08-05', 2, 3, 2),
  (23, '2023-08-05', 3, 2, 1),
  (24, '2023-08-05', 4, 1, 2),
  (25, '2023-08-05', 5, 1, 1),
  (26, '2023-08-06', 1, 3, 2),
  (27, '2023-08-06', 2, 5, 1),
  (28, '2023-08-06', 3, 7, 2),
  (29, '2023-08-06', 4, 9, 1),
  (30, '2023-08-06', 5, 11, 2),
  (31, '2023-08-07', 1, 2, 1),
  (32, '2023-08-07', 2, 4, 2),
  (33, '2023-08-07', 3, 6, 1),
  (34, '2023-08-07', 4, 8, 2),
  (35, '2023-08-07', 5, 10, 1),
  (36, '2023-08-08', 1, 12, 2),
  (37, '2023-08-08', 2, 1, 1),
  (38, '2023-08-08', 3, 2, 2),
  (39, '2023-08-08', 4, 3, 1),
  (40, '2023-08-08', 5, 4, 2),
  (41, '2023-08-09', 1, 5, 1),
  (42, '2023-08-09', 2, 6, 2),
  (43, '2023-08-09', 3, 7, 1),
  (44, '2023-08-09', 4, 8, 2),
  (45, '2023-08-09', 5, 9, 1),
  (46, '2023-08-10', 1, 10, 2),
  (47, '2023-08-10', 2, 11, 1),
  (48, '2023-08-10', 3, 12, 2),
  (49, '2023-08-10', 4, 5, 1),
  (50, '2023-08-10', 5, 3, 2);

.mode box

-- 3. Perform SQL queries to analyze data 
  
-- 3.1 SQL with JOIN
-- See all histories with details of CustOrder 
select
  tor.order_date,
  tcus.first_name,
  tme.menu_name,
  tme.menu_price,
  tor.quantity,
  tme.menu_price*tor.quantity as Spending
from Customers as tcus 
join Orders as tor on tcus.cust_id = tor.cust_id
join Menus as tme on tme.menu_id = tor.menu_id;

-- 3.2 SQL with AGGREGATE function
-- 3.2.1 Finding top spender
CREATE VIEW Cust_Stats AS
select
  tcus.first_name as CustomerName,
  tcus.mobile as ContactNumber,
  sum(tme.menu_price*tor.quantity) as Top_Spender
from Customers as tcus 
join Orders as tor on tcus.cust_id = tor.cust_id
join Menus as tme on tme.menu_id = tor.menu_id
group by tcus.first_name
order by Top_Spender desc;

select * from Cust_Stats;

--3.2.2 Finding top menu to generate income
CREATE VIEW Menu_Stats AS
select
  tme.menu_name as Menu,
  tme.menu_category as Category,
  sum(tme.menu_price*tor.quantity) as Income
from Customers as tcus 
join Orders as tor on tcus.cust_id = tor.cust_id
join Menus as tme on tme.menu_id = tor.menu_id
group by tme.menu_name
order by Income desc;

select * from Menu_Stats;

--3.2.3 Total Shop Income
select
sum(tme.menu_price*tor.quantity) as Shop_Income
from Customers as tcus 
join Orders as tor on tcus.cust_id = tor.cust_id
join Menus as tme on tme.menu_id = tor.menu_id;

--3.3 SQL with SUBQUERIES/WITH
--Find customers who buy Super Deluxe Pizza for consideration of personalized promotion
with Superdeluxe as (
  select * from menus 
  where menu_name = 'Super Deluxe'
)
select 
  tcus.first_name,
  tcus.mobile,
  sum(sd.menu_price*tor.quantity) as Spent_Super_Deluxe
from Customers as tcus 
join Orders as tor on tcus.cust_id = tor.cust_id
join Superdeluxe as sd on sd.menu_id = tor.menu_id
group by tcus.first_name
order by Spent_Super_Deluxe desc;
