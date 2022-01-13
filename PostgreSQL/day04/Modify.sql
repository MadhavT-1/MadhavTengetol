	================ 	INSERT INTO		================
1.	INSERT INTO orders
	(orderid,customerid, employeeid, orderdate, requireddate, shipvia,
	freight, shipname, shipaddress, shipcity, shippostalcode,shipcountry)
	VALUES (11078,'VINET', 4, '2017-09-16','2017-09-30',3,
        42.5, 'Vins et alcools Chevalier',
        '59 rue de l''Abbaye', 'Reims','51100', 'France');

2.	SELECT MAX(orderid)
	FROM orders;

3.	INSERT INTO orders
	(orderid,customerid, employeeid, orderdate, requireddate, shipvia,
	freight, shipname, shipaddress, shipcity, shippostalcode,shipcountry)
	VALUES (11078, 'VINET', 4, '2017-09-16','2017-09-30',3,
        42.5, 'Vins et alcools Chevalier',"59 rue de l'Abbaye" 'Reims','51100', 'France');

4.	SELECT *
	FROM PRODUCTS
	WHERE productname='Queso Cabrales'
	--productid=11;

5.	INSERT INTO order_details
	(orderid, productid, unitprice,quantity,discount)
	VALUES (11078,11,14,20,0);
	
	
	
	=======================		UPDATE		=========================
	
6.	UPDATE orders
	SET requireddate='2017-09-20',freight=50
	WHERE orderid=11078;

7.	UPDATE order_details
	SET quantity=40,discount=.05
	WHERE orderid=11078 AND productid=11;
	
	===================== 	DELETE 	=================================
	
8.	DELETE FROM order_details
	WHERE orderid=11078 AND productid=11;

9.	DELETE FROM orders
	WHERE orderid=11078;	
	
	==================== 	SELECT INTO		===========================
	
10.	SELECT *
	INTO suppliers_northamerica
	FROM suppliers
	WHERE country in ('USA','Canada');
	
	=>	SELECT * FROM suppliers_northamerica

11.	SELECT *
	INTO orders_1997
	FROM orders
	WHERE orderdate BETWEEN '1997-01-01' AND '1997-12-31';
	
	=>SELECT *
	FROM orders_1997
	
	=======================	INSERT INTO SELECT	=====================
	
12.	INSERT INTO suppliers_northamerica
	SELECT *
	FROM suppliers
	WHERE country IN ('Brazil','Argentina')

13.	INSERT INTO orders_1997
	SELECT * FROM orders
	WHERE orderdate BETWEEN '1996-12-01' AND '1996-12-31'
	
	=======================	RETURNING DATA FROM UPDATE/DELETE/INSERT	====================
	
14.	INSERT INTO employees
	(firstname,lastname,address,city,country,postalcode,homephone,title,employeeid,reportsto)
	VALUES
	('Bob','Smith','463-4613 Ipsum Street','New Orleans','USA','73-638','741-0423','Chief Strategy',50,NULL)
	RETURNING employeeid;

15.	INSERT INTO orders (customerid,employeeid,requireddate,shippeddate,orderid)
	VALUES ('VINET',5,'1996-08-01','1996-08-10',500) RETURNING orderid;

16.	UPDATE products
	SET unitprice = unitprice * 1.2
	WHERE productid=1
	RETURNING productid,unitprice AS new_price;


17.	UPDATE order_details
	SET quantity = quantity * 2
	WHERE orderid=10248 AND productid=11
	RETURNING quantity AS new_quantity;

18.	DELETE FROM employees
	WHERE employeeid=50
	RETURNING *;

19.	DELETE FROM orders
	WHERE orderid=500
	RETURNING *;
	
	
	
	