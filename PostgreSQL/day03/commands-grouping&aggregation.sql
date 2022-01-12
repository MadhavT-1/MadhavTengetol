#################### 	Group By 	###########################

1.	SELECT COUNT(*), country
	FROM customers
	GROUP BY country
	ORDER BY COUNT(*) DESC;

2.	SELECT COUNT(*),categoryname
	FROM categories
	JOIN products ON categories.categoryid=products.categoryid
	GROUP BY categoryname
	ORDER BY COUNT(*) DESC;
	
	----------------Or----------------
	SELECT COUNT(*),categoryname
	FROM categories
	JOIN products USING(categoryid)
	GROUP BY categoryname
	ORDER BY COUNT(*) DESC;

3.	SELECT productname,ROUND(AVG(quantity))
	FROM products
	JOIN order_details ON order_details.productid=products.productid
	GROUP BY productname
	ORDER BY AVG(quantity) DESC;

4.	SELECT COUNT(*),country
	FROM suppliers
	GROUP BY country
	ORDER BY COUNT(*) DESC;

5.	SELECT productname, SUM(quantity * order_details.unitprice) AS AmountBought
	FROM products
	JOIN order_details ON order_details.productid=products.productid
	JOIN orders ON orders.orderid=order_details.orderid
	WHERE orderdate BETWEEN '1997-01-01' AND '1997-12-31'
	GROUP BY productname
	ORDER BY AmountBought DESC;

#################### 	Having to filter Group 	########################

6.	SELECT productname, SUM(quantity * order_details.unitprice) AS AmountBought
	FROM products
	JOIN order_details USING (productid)
	GROUP BY productname
	HAVING SUM(quantity * order_details.unitprice) <2000
	ORDER BY AmountBought ASC;

7.	SELECT companyname, SUM(quantity * order_details.unitprice) AS AmountBought
	FROM customers
	NATURAL JOIN orders
	NATURAL JOIN order_details
	GROUP BY companyname
	HAVING SUM(quantity * order_details.unitprice) >5000
	ORDER BY AmountBought DESC;

8.	SELECT companyname, SUM(quantity * order_details.unitprice) AS AmountBought
	FROM customers
	NATURAL JOIN orders
	NATURAL JOIN order_details
	WHERE orderdate BETWEEN '1997-01-01' AND '1997-6-30'
	GROUP BY companyname
	HAVING SUM(quantity * order_details.unitprice) >5000
	ORDER BY AmountBought DESC;

#################### 	Grouping Sets 	###########################

	You could run multiple queries, each one grouping over different set of columns
	Could even UNION them together


9.	SELECT categoryname,productname,SUM(od.unitprice*quantity)
	FROM categories
	NATURAL JOIN products
	NATURAL JOIN order_details AS od
	GROUP BY GROUPING SETS  ((categoryname),(categoryname,productname))
	ORDER BY categoryname, productname;

10.	SELECT c.companyname AS buyer,s.companyname AS supplier,SUM(od.unitprice*quantity)
	FROM customers AS c
	NATURAL JOIN orders
	NATURAL JOIN order_details AS od
	JOIN products USING (productid)
	JOIN suppliers  AS s USING (supplierid)
	GROUP BY GROUPING SETS ((buyer),(buyer,supplier))
	ORDER BY buyer,supplier;

11	SELECT companyname,categoryname,SUM(od.unitprice*quantity)
	FROM customers AS c
	NATURAL JOIN orders
	NATURAL JOIN order_details AS od
	JOIN products USING (productid)
	JOIN categories  AS s USING (categoryid)
	GROUP BY GROUPING SETS ((companyname),(companyname,categoryname))
	ORDER BY companyname,categoryname NULLS FIRST;

#################### 	Roll Up 	###########################

12.	SELECT c.companyname,categoryname,productname,SUM(od.unitprice*quantity)
	FROM customers AS c
	NATURAL JOIN orders
	NATURAL JOIN order_details AS od
	JOIN products USING (productid)
	JOIN categories  USING (categoryid)
	GROUP BY ROLLUP(companyname, categoryname, productname);
	ORDER BY companyname,categoryname,productname

13.	SELECT s.companyname AS supplier, c.companyname AS buyer,productname, SUM(od.unitprice*quantity)
	FROM suppliers AS s
	JOIN products USING (supplierid)
	JOIN order_details AS od USING (productid)
	JOIN orders USING (orderid)
	JOIN customers AS c USING (customerid)
	GROUP BY ROLLUP(supplier, buyer, productname)
	ORDER BY supplier,buyer,productname;


#################### 	Cube roll up on steroid	###########################

14.	SELECT c.companyname,categoryname,productname,SUM(od.unitprice*quantity)
	FROM customers AS c
	NATURAL JOIN orders
	NATURAL JOIN order_details AS od
	JOIN products USING (productid)
	JOIN categories  USING (categoryid)
	GROUP BY CUBE (companyname, categoryname, productname);

15.	SELECT s.companyname AS supplier, c.companyname AS buyer,productname, SUM(od.unitprice*quantity)
	FROM suppliers AS s
	JOIN products USING (supplierid)
	JOIN order_details AS od USING (productid)
	JOIN orders USING (orderid)
	JOIN customers AS c USING (customerid)
	GROUP BY CUBE(supplier, buyer, productname);

