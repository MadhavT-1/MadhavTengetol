1 .	SELECT DISTINCT country FROM suppliers ORDER BY country ASC
	
2 . SELECT DISTINCT(country)
	FROM customers;

3 . SELECT DISTINCT(country)
	FROM suppliers
	ORDER BY country ASC;

4.	SELECT DISTINCT(country)
	FROM suppliers
	ORDER BY country DESC;

5.	SELECT DISTINCT country,city
	FROM suppliers
	ORDER BY country ASC,city ASC;

6.	SELECT productname,unitprice
	FROM products
	ORDER BY unitprice DESC, productname ASC;

7.	SELECT MIN(orderdate)
	FROM orders
	WHERE shipcountry='Italy';

8.	SELECT MAX(shippeddate)
	FROM orders
	WHERE shipcountry='Canada';

9.	SELECT MAX(shippeddate-orderdate)
	FROM orders
	WHERE shipcountry='France';
	
10.	SELECT AVG(freight)
	FROM orders
	WHERE shipcountry='Brazil';

11.	SELECT SUM(quantity)
	FROM order_details
	WHERE productid=14;

12.	SELECT AVG(quantity)
	FROM order_details
	WHERE productid=35;
	
	
	
	##################################################
		% stands for zero, one or more characters
			1. where suppliername LIKE 'a%'    => 	all supplier names that starts with a
			2. WHERE suppliername LIKE '%e'    => 	all supplier names that end with e
			3. WHERE suppliername LIKE '%bob%' => 	all supplier names with bod in name somewhere
			4. WHERE suppliername LIKE 'A%i'   => 	all supplier names that start with A and ends with i
		_ stands for any single character
			5. WHERE suppliername LIKE '_a%'   =>	has a as second letter
			6. WHERE suppliername LIKE 'E_%_%' => 	starts with W and has at least 2 other letters
	##################################################
	
13. SELECT companyname,contactname
	FROM customers
	WHERE contactname LIKE 'D%';

14.	SELECT companyname
	FROM suppliers
	WHERE companyname LIKE '_or%';

15.	SELECT companyname
	FROM customers
	WHERE companyname LIKE '%er';
	
	
	###########################################################
	Renaming column with alias
		syntax:	
				SELECT <column1> AS alias_name FROM <table_name>
	################################################				

16.	SELECT unitprice*quantity AS TotalSpent
	FROM order_details;

-- this won't work
17.	SELECT unitprice*quantity AS TotalSpent
	FROM order_details
	WHERE TotalSpent > 10;

-- this one will
18.	SELECT unitprice*quantity AS TotalSpent
	FROM order_details
	ORDER BY TotalSpent DESC;

19.	SELECT unitprice*unitsinstock AS TotalInventory
	FROM products
	ORDER BY TotalInventory DESC;
	
###############################  LIMIT	##########################	

20.	SELECT productid,unitprice*quantity AS TotalCost
	FROM order_details
	ORDER BY TotalCost DESC
	LIMIT 3;

21. SELECT productname,unitprice*unitsinstock AS TotalInventory
	FROM products
	ORDER BY TotalInventory ASC
	LIMIT 2;
	
	################### 	Null values 	###############
22. SELECT count(*)
	FROM customers
	WHERE region IS NULL;

23.	SELECT count(*)
	FROM suppliers
	WHERE region IS NOT NULL;

24. SELECT count(*)
	FROM orders
	WHERE shipregion IS NULL;
	
##########################	Intermediate select statement 	#####################
--1
SELECT name,weight,productnumber
FROM production.product
ORDER BY weight ASC;

--2
SELECT *
FROM purchasing.productvendor
WHERE productid=407
ORDER BY averageleadtime ASC;

--3
SELECT *
FROM sales.salesorderdetail
WHERE productid=799
ORDER BY orderqty DESC;

--4
SELECT MAX(discountpct)
FROM sales.specialoffer;

--5
SELECT MIN(sickleavehours)
FROM humanresources.employee;

--6
SELECT MAX(rejectedqty)
FROM purchasing.purchaseorderdetail;

--7
SELECT AVG(rate)
FROM humanresources.employeepayhistory;

--8
SELECT AVG(standardcost)
FROM production.productcosthistory
WHERE productid=738;

--9
SELECT SUM(scrappedqty)
FROM production.workorder
WHERE productid = 529;

--10
SELECT name
FROM purchasing.vendor
WHERE name LIKE 'G%';

--11
SELECT name
FROM purchasing.vendor
WHERE name LIKE '%Bike%';

--12
SELECT firstname
FROM person.person
WHERE firstname LIKE '_t%';

--13
SELECT *
FROM person.emailaddress
LIMIT 20;

--14
SELECT *
FROM production.productcategory
LIMIT 2;

--15
SELECT COUNT(*)
FROM production.product
WHERE weight IS NULL;

--16
SELECT COUNT(*)
FROM person.person
WHERE additionalcontactinfo IS NOT NULL;
	

	
	

