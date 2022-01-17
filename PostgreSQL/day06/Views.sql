	=================================== Create Views	==============================
	
		-It acts like a stored query that you give a name
		-Once created you can use SELECT to pull information from like regular table
		
		why use poeple
			-Used to keep from having to type in complex queries.
			-also allows you to change underlying tables without rewriting all the queries that access.
			-Grant permissions so you can limit a person/group to certain fields from base tables.
	
1.	CREATE VIEW customer_order_details AS
	SELECT companyname, Orders.customerid, employeeid, orderdate, requireddate, shippeddate
	Shipvia, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry,
	order_details.*
	FROM customers
	JOIN orders on customers.customerid=orders.customerid
	JOIN order_details on order_details.orderid=orders.orderid;

2.	SELECT *
	FROM customer_order_details
	WHERE customerid='TOMSP';

3.	CREATE VIEW supplier_order_details AS
	SELECT companyname, suppliers.supplierid, Products.productid, productname,
	Order_details.unitprice, quantity, discount, orders.*
	FROM suppliers
	JOIN products ON suppliers.supplierid=products.supplierid
	JOIN order_details ON order_details.productid=products.productid
	JOIN orders ON order_details.orderid=orders.orderid;

4.	SELECT *  FROM supplier_order_details WHERE supplierid=5;

	=============================	Modify Views	========================================
	
5.	CREATE OR REPLACE VIEW customer_order_details AS
	SELECT companyname, Orders.customerid,employeeid,requireddate,shippeddate,
	Shipvia,freight,shipname,shipcity,shipregion,shippostalcode,shipcountry,
	order_details.*,contactname
	FROM customers
	JOIN orders USING(customerid)
	JOIN order_details USING(orderid);

6.	CREATE OR REPLACE VIEW supplier_order_details AS
	SELECT companyname,suppliers.supplierid,
	Products.productid,productname,
	Order_details.unitprice,quantity,discount,
	orders.*,phone
	FROM suppliers
	JOIN products ON suppliers.supplierid=products.supplierid
	JOIN order_details ON order_details.productid=products.productid
	JOIN orders ON order_details.orderid=orders.orderid;

7.	ALTER VIEW customer_order_details RENAME TO customer_order_detailed;

8.	ALTER VIEW supplier_order_details RENAME TO supplier_orders;

	============================	Creating Updatable Views	==============================
	You can update, delete or insert into a view IF-
		-Only one table is referenced in FROM ( could be another updatable view)
		-Can not have GROUP BY,HAVING,LIMIT, DISTINCT,UNION,INTERSECT,EXCEPT in defining query
		-Can not any window functions, set returning function, or any aggregate functions like SUM,COUNT,AVG.MIN,MAX
9.	CREATE VIEW north_america_customers AS
	SELECT *
	FROM customers
	WHERE country in ('USA','Canada','Mexico');

10.	INSERT INTO north_america_customers
	(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
	VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','USA','555-555-5555',null);

11	UPDATE north_america_customers SET fax='555-333-4141' WHERE customerid='CFDCM';

12.	DELETE FROM north_america_customers WHERE customerid='CFDCM';

13.	CREATE VIEW protein_products AS
	SELECT * FROM products
	WHERE categoryid in (4,6,8);

14.	INSERT INTO protein_products
	(productid,productname,supplierid,categoryid,discontinued)
	VALUES (78,'Kobe Beef',12,8,0);

15.	UPDATE protein_products SET unitprice=55 WHERE productid=78;

16.	DELETE FROM protein_products WHERE productid=78;
		
	
	