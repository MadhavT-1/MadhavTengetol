	################## Subqueries 	############################
	
	
	====================	Exitsts 	===================

1.	SELECT companyname,contactname
	FROM customers
	WHERE EXISTS (SELECT customerid FROM orders
              WHERE customerid=customers.customerid AND
               orderdate BETWEEN '1997-04-01' AND '1997-04-30');

2.	SELECT companyname,contactname
	FROM customers
	WHERE NOT EXISTS (SELECT customerid FROM orders
               WHERE customerid=customers.customerid AND
                orderdate BETWEEN '1997-04-01' AND '1997-04-30');

3.	SELECT productname
	FROM products
	WHERE NOT EXISTS (SELECT orders.orderid FROM orders
                  JOIN order_details ON orders.orderid=order_details.orderid
              WHERE order_details.productid=products.productid AND
                  orderdate BETWEEN '1997-04-01' AND '1997-04-30');

4.	SELECT companyname
	FROM suppliers
	WHERE EXISTS (SELECT productid FROM products
             	WHERE products.supplierid=products.supplierid AND
               	unitprice > 200);

5.	SELECT companyname
	FROM suppliers
	WHERE  NOT EXISTS (SELECT products.productid FROM products
                  JOIN order_details ON products.productid=order_details.productid
                  JOIN orders ON order_details.orderid=orders.orderid
             	WHERE suppliers.supplierid=products.supplierid AND
                  orderdate BETWEEN '1996-12-01' AND '1996-12-31' );
				  
				  
	=========================	ANY and ALL 	=======================

6.	SELECT companyname
	FROM customers
	WHERE  customerid = ANY (SELECT customerid FROM orders
                         JOIN order_details ON orders.orderid=order_details.orderid
                         WHERE quantity > 50);

7.	SELECT companyname
	FROM suppliers
	WHERE  supplierid = ANY (SELECT products.supplierid FROM order_details
                        JOIN products ON products.productid=order_details.productid
                        WHERE quantity = 1);

8.	SELECT DISTINCT productname
	FROM products
	JOIN order_details ON products.productid=order_details.productid
	WHERE  order_details.unitprice*quantity > ALL
	(SELECT AVG(order_details.unitprice*quantity)
             FROM order_details
             GROUP BY productid);

 9.	SELECT DISTINCT companyname
	FROM customers
	JOIN orders ON orders.customerid=customers.customerid
	JOIN order_details ON orders.orderid=order_details.orderid
	WHERE  order_details.unitprice*quantity > ALL
 	(SELECT AVG(order_details.unitprice*quantity)
              FROM order_details
             JOIN orders ON orders.orderid=order_details.orderid
             GROUP BY orders.customerid);
	
                               
	====================== 	IN using subquery 	=====================
10.	SELECT companyname
	FROM customers
	WHERE country IN (SELECT DISTINCT country 
	FROM suppliers);

11.	SELECT companyname
	FROM suppliers
	WHERE city IN (SELECT DISTINCT city
	FROM customers);

                  
	
	