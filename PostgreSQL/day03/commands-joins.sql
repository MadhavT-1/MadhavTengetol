############# Inner join of two tables ###################
1.	SELECT companyname,orderdate,shipcountry
	FROM orders
	JOIN customers ON customers.customerid=orders.customerid;

2. 	SELECT firstname,lastname,orderdate
	FROM orders
	JOIN employees ON employees.employeeid=orders.employeeid;

3.	SELECT companyname,unitprice,unitsinstock
	FROM products
	JOIN suppliers ON products.supplierid=suppliers.supplierid;
	
	###########################	Inner joins for multiple table ################
	
4.	SELECT companyname,orderdate,unitprice,quantity
	FROM orders
	JOIN order_details ON orders.orderid=order_details.orderid
	JOIN customers ON customers.customerid=orders.customerid;

5.	SELECT companyname, productname, orderdate, order_details.unitprice, quantity
	FROM orders
	JOIN order_details ON orders.orderid=order_details.orderid
	JOIN customers ON customers.customerid=orders.customerid
	JOIN products ON products.productid=order_details.productid;

6.	SELECT companyname, productname, categoryname,
	orderdate, order_details.unitprice, quantity
	FROM orders
	JOIN order_details ON orders.orderid=order_details.orderid
	JOIN customers ON customers.customerid=orders.customerid
	JOIN products ON products.productid=order_details.productid
	JOIN categories ON categories.categoryid=products.categoryid;

7.	SELECT companyname, productname, categoryname,
	orderdate, order_details.unitprice, quantity
	FROM orders
	JOIN order_details ON orders.orderid=order_details.orderid
	JOIN customers ON customers.customerid=orders.customerid
	JOIN products ON products.productid=order_details.productid
	JOIN categories ON categories.categoryid=products.categoryid
	WHERE 	categoryname='Seafood' AND
	order_details.unitprice*quantity >= 500;
	
	######################	Left Joins #####################
		Pulls back all records in first table and any matching records in second TABLE

8.	SELECT companyname, orderid
	FROM customers
	LEFT JOIN orders ON customers.customerid=orders.customerid;

9.	SELECT companyname, orderid
	FROM customers
	LEFT JOIN orders ON customers.customerid=orders.customerid
	WHERE orderid IS NULL;

10.	SELECT productname, orderid
	FROM products
	LEFT JOIN order_details ON products.productid=order_details.productid;

11.	SELECT productname, orderid
	FROM products
	LEFT JOIN order_details ON products.productid=order_details.productid
	WHERE orderid IS NULL;
	
	########################## Right Joins 	###########################
		pulls back matching records in first TABLE and all records in second TABLE
	
12.	SELECT companyname, orderid
	FROM orders
	RIGHT JOIN customers ON customers.customerid=orders.customerid;

13.	SELECT companyname, orderid
	FROM orders
	RIGHT JOIN customers ON customers.customerid=orders.customerid
	WHERE orderid IS NULL;

14.	SELECT companyname, customercustomerdemo.customerid
	FROM customercustomerdemo
	RIGHT JOIN customers ON customers.customerid=customercustomerdemo.customerid;
	
	
	##############################  Full Joins 	##########################333
		pulls all records in first table and all records in second TABLE
		
15.	SELECT companyname, orderid
	FROM orders
	FULL JOIN customers ON customers.customerid=orders.customerid;

16.	SELECT productname, categoryname
	FROM categories
	FULL JOIN products ON products.categoryid=categories.categoryid;
		
		
	#####################	Self Joins	#############################	
		connect a table back to itself
		
		why =>	1. hierarchy -like employees who report to other employees
				2. looking for similarities or dissimilarities same column - everyone in same city or same birthday
	
17.	SELECT A.companyname AS CustomerName1, B.companyname AS CustomerName2, A.city
	FROM customers A, customers B
	WHERE A.customerid > B.customerid
	AND A.city = B.city
	ORDER BY A.city;

18.	SELECT  A.companyname AS SupplierName1,
	B.companyname AS SupplierName2,  A.country
	FROM suppliers A, suppliers B
	WHERE A.supplierid > B.supplierid
	AND A.country = B.country
	ORDER BY A.country;
	
	################### 	using to reduce typing 	###########################
		on customers.customerod =orders.customerid  =>	USING(customerid)
	
	
19.	SELECT *
	FROM orders
	JOIN order_details USING (orderid);
	
20.	SELECT *
	FROM orders
	JOIN order_details USING (orderid)
	JOIN products USING (productid);
	
	
	###################### 	Even less typing #####################
		 if the fields have same name
		 =>	NATURAL is shorthand for USING with a list of all columns that are the same in both tables
		 
		 join order and order_details using NATURAL
		 
21.	SELECT *
	FROM orders
	NATURAL JOIN order_details;

22.	SELECT *
	FROM customers
	NATURAL JOIN orders
	NATURAL JOIN order_details;


--notice the difference between these two joins
23.	SELECT COUNT(*)
	FROM products
	NATURAL JOIN order_details;  --this is joining on both productid and unitprice

24.	SELECT COUNT(*)
	FROM products
	JOIN order_details USING (productid); -- this is joining on both productid
	
	
	#####################	Joining multiple tables together 	###########################3
--01

-- this is spelling out the ON
SELECT firstname,middlename,lastname,phonenumber,name
FROM person.personphone AS ph
JOIN person.businessentity AS be ON be.businessentityid=ph.businessentityid
JOIN person.person AS pe ON pe.businessentityid=be.businessentityid
JOIN person.phonenumbertype AS pnt ON pnt.phonenumbertypeid=ph.phonenumbertypeid
ORDER BY ph.businessentityid DESC;

--this is with USING
SELECT firstname,middlename,lastname,phonenumber,name
FROM person.personphone AS ph
JOIN person.businessentity USING (businessentityid)
JOIN person.person USING (businessentityid)
JOIN person.phonenumbertype USING (phonenumbertypeid)
ORDER BY ph.businessentityid DESC;


--02
SELECT pm.name,c.name,description
FROM production.productdescription
JOIN production.productmodelproductdescriptionculture USING (productdescriptionid)
JOIN production.culture AS c USING (cultureid)
JOIN production.productmodel AS pm USING (productmodelid)
ORDER BY pm.name ASC;

--03
SELECT p.name,pm.name,c.name,description
FROM production.productdescription
JOIN production.productmodelproductdescriptionculture USING (productdescriptionid)
JOIN production.culture AS c USING (cultureid)
JOIN production.productmodel AS pm USING (productmodelid)
JOIN production.product AS p USING (productmodelid)
ORDER BY pm.name ASC;

--04
SELECT name, rating, comments
FROM production.product
LEFT JOIN production.productreview USING (productid)
ORDER BY rating ASC;

--05
SELECT p.name,orderqty,scrappedqty
FROM production.workorder
RIGHT JOIN production.product AS p USING (productid)
ORDER BY p.productid ASC;
	
		 
	
	
		
	
