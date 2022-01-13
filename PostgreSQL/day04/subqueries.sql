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
                               
	