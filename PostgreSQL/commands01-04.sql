-- 1
SELECT * FROM actor;

--2
SELECT * FROM film;

--3
SELECT * FROM staff;

--4
SELECT address,district FROM address;

--5
SELECT title,description FROM film;

--6
SELECT city,country_id FROM city;

--7
SELECT DISTINCT(last_name) FROM customer;

SELECT (last_name) FROM customer;

--8
SELECT DISTINCT(first_name) FROM actor;

--9
SELECT DISTINCT(inventory_id) FROM rental;

--10
SELECT COUNT(*) FROM film;

--11
SELECT COUNT(*) FROM category;

--12
SELECT COUNT(DISTINCT first_name) FROM actor;

--12
SELECT rental_id,return_date-rental_date FROM rental;

-- 1
SELECT * FROM actor;

--2
SELECT * FROM film;

--3
SELECT * FROM staff;

--4
SELECT address,district FROM address;

--5
SELECT title,description FROM film;

--6
SELECT city,country_id FROM city;

--7
SELECT DISTINCT(last_name) FROM customer;

--8
SELECT DISTINCT(first_name) FROM actor;

--9
SELECT DISTINCT(inventory_id) FROM rental;

--10
SELECT COUNT(*) FROM film;

--11
SELECT COUNT(*) FROM category;

--12
SELECT COUNT(DISTINCT first_name) FROM actor;

--12
SELECT rental_id,return_date-rental_date FROM rental;


--1
SELECT * FROM data_src
WHERE journal = 'Food Chemistry';

--2
SELECT * FROM nutr_def
WHERE nutrdesc = 'Retinol';

--3
SELECT * FROM food_des
WHERE manufacname = 'Kellogg, Co.';

--4
SELECT COUNT(*) FROM data_src
WHERE year > 2000;

--5
SELECT COUNT(*) FROM food_des
WHERE fat_factor<4;

--6
SELECT * FROM weight
WHERE gm_wgt = 190;

--7
SELECT COUNT(*)
FROM food_des
WHERE pro_factor > 1.5 AND fat_factor < 5;

--8
SELECT * FROM data_src
WHERE year=1990 AND journal='Cereal Foods World';

--9
SELECT COUNT(*) FROM weight
WHERE gm_wgt > 150 and gm_wgt < 200;

--10
SELECT *
FROM nutr_def
WHERE units = 'kj' or units='kcal';

--11
SELECT * FROM data_src
WHERE year=2000 OR journal='Food Chemistry';

--12
-- lookup the fdgrp_cd for Breakfast Cereals
SELECT fdgrp_cd FROM fd_group
WHERE fddrp_desc = 'Breakfast Cereals';
-- find the count
SELECT COUNT(*) FROM food_des
WHERE NOT fdgrp_cd = '0800';

--13
SELECT * FROM data_src
WHERE (year >= 1990 AND year <=2000) AND
	(journal = 'J. Food Protection' OR Journal='Food Chemistry');

--14
SELECT COUNT(*)
FROM weight
WHERE gm_wgt BETWEEN 50 AND 75;

--15
SELECT * FROM data_src
WHERE year IN (1960,1970,1980,1990,2000);


SELECT *
FROM customers;

SELECT *
FROM employees;

SELECT companyname, city, country
FROM suppliers;

SELECT categoryname, description
FROM categories;

SELECT DISTINCT country
FROM customers;

SELECT DISTINCT city, country
FROM customers;

SELECT DISTINCT region
FROM suppliers;

SELECT COUNT(*)
FROM Products;

SELECT COUNT(*)
FROM orders;

SELECT COUNT(DISTINCT city)
FROM  suppliers;

SELECT COUNT(DISTINCT productid)
FROM  order_details;

SELECT orderid, shippeddate - orderdate
FROM orders;

SELECT orderid, unitprice * quantity
FROM order_details;

SELECT companyname
FROM suppliers
WHERE city='Berlin';

SELECT companyname,contactname
FROM customers
WHERE country='Mexico';

SELECT COUNT(*)
FROM orders
WHERE employeeid=3;

SELECT COUNT(*)
FROM order_details
WHERE quantity>20;

SELECT COUNT(*)
FROM orders
WHERE freight>=250;

SELECT COUNT(*)
FROM orders
where orderdate >= '1998-01-01';

SELECT COUNT(*)
FROM orders
where shippeddate < '1997-06-05';

SELECT COUNT(*)
FROM orders
WHERE freight > 100 AND shipcountry = 'Germany';

SELECT DISTINCT customerid
FROM orders
WHERE shipvia=2 AND shipcountry='Brazil';

SELECT COUNT(*)
FROM customers
WHERE country='USA' OR country='Canada';

SELECT COUNT(*)
FROM customers
WHERE country='Germany' OR country='Spain';

SELECT COUNT(*)
FROM orders
WHERE shipcountry='USA' OR shipcountry='Brazil'
OR shipcountry='Argentina';

SELECT COUNT(*)
FROM customers
WHERE NOT country='France';

SELECT COUNT(*)
FROM suppliers
WHERE NOT country='USA';

SELECT COUNT(*)
FROM orders
WHERE shipcountry='Germany'
AND (freight<50 OR freight>175);

SELECT COUNT(*)
FROM orders
WHERE (shipcountry='Canada' OR shipcountry='Spain')
AND shippeddate > '1997-05-01';

SELECT COUNT(*)
FROM order_details
WHERE unitprice BETWEEN 10 AND 20;

SELECT COUNT(*)
FROM orders
WHERE shippeddate BETWEEN '1996-06-01' AND '1996-09-30';

SELECT COUNT(*)
FROM suppliers
WHERE country IN ('Germany','France','Spain','Italy');

SELECT COUNT(*)
FROM products
WHERE categoryid IN (1, 4, 6, 7);

