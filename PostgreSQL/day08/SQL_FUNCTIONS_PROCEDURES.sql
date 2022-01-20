	======================	SQL Functions and Procedures	========================
	
	Types of Functions =>	1.	Query Language
							2.	Procedural Language	(PL/pgSQL or PL/Tcl)
							3.	Internal Functions	(writeen in C & statically linked to server)
							4.	C-Language Functions
	
	
1.	CREATE  OR REPLACE FUNCTION fix_homepage() RETURNS void AS $$
	UPDATE suppliers
	SET homepage='N/A'
	WHERE homepage IS NULL;
	$$ LANGUAGE SQL;

2.	SELECT fix_homepage();

3.	CREATE OR REPLACE FUNCTION set_employee_default_photo() RETURNS void AS $$
	UPDATE employees
	SET photopath='http://accweb/emmployees/default.bmp'
	WHERE photopath IS NULL;
	$$ LANGUAGE SQL;

4.	SELECT set_employee_default_photo();
	
	===============================	Function that return single VALUE	===================
	
5.	CREATE OR REPLACE FUNCTION max_price() RETURNS real AS $$
	SELECT MAX(unitprice)
	FROM products;
	$$ LANGUAGE SQL;

6.	SELECT max_price();

7.	CREATE OR REPLACE FUNCTION biggest_order() RETURNS double precision AS $$

8.	SELECT MAX(amount)
	FROM
	(SELECT SUM(unitprice*quantity) as amount,orderid
	FROM order_details
	GROUP BY orderid) as totals;
	$$ LANGUAGE SQL;

9.	SELECT biggest_order();

==========================	Function with Parameters	==================================

	ways to REFERENCES parameters
		1.	By name 	: param1,param2
		2.	By Position : $1, $2

10.	CREATE OR REPLACE FUNCTION customer_largest_order(cid bpchar) RETURNS double precision AS $$
	SELECT MAX(order_total) FROM
	(SELECT SUM(quantity*unitprice) as order_total,orderid
	FROM order_details
	NATURAL JOIN orders
	WHERE customerid=cid
	GROUP BY orderid) as order_total;
	$$ LANGUAGE SQL;

12.	SELECT customer_largest_order('ANATR');

13.	CREATE OR REPLACE FUNCTION most_ordered_product(customerid bpchar) RETURNS varchar(40) AS $$
	SELECT productname
	FROM products
	WHERE productid IN
	(SELECT productid FROM
	(SELECT SUM(quantity) as total_ordered, productid
	FROM order_details
	NATURAL JOIN orders
	WHERE customerid= $1
	GROUP BY productid
	ORDER BY total_ordered DESC
	LIMIT 1) as ordered_products);
	$$ LANGUAGE SQL;

14	SELECT most_ordered_product('CACTU');

============================	Functions that have Composite Parameters	========================


15	CREATE OR REPLACE FUNCTION new_price(products, increase_percent numeric)
	RETURNS double precision AS $$
	SELECT $1.unitprice * increase_percent/100
	$$ LANGUAGE SQL

16	SELECT productname,unitprice,new_price(products.*,110)
	FROM products;

17	CREATE OR REPLACE FUNCTION full_name(employees) RETURNS varchar(62) AS $$
	SELECT $1.title || ' ' || $1.firstname || ' ' || $1.lastname
	$$ LANGUAGE SQL;

18	SELECT full_name(employees.*),city,country
	FROM employees;

	==========================	Functions that returns a composite 	=============================
	
	used to return a single row of a table
		1.	order of the field must be same as the table
		2.	each type must match the corresponding composite column
	
19	CREATE OR REPLACE FUNCTION newest_hire() RETURNS employees AS $$
	SELECT *
	FROM employees
	ORDER BY hiredate DESC
	LIMIT 1;
	$$ LANGUAGE SQL;

20	SELECT newest_hire();

21	SELECT (newest_hire()).lastname;

22	SELECT lastname(newest_hire());

23	CREATE OR REPLACE FUNCTION highest_inventory() RETURNS products AS $$

	SELECT * FROM products
	ORDER BY (unitprice*unitsinstock) DESC
	LIMIT 1;

	$$ LANGUAGE SQL;

24	SELECT (highest_inventory()).productname;
25	SELECT productname(highest_inventory());


============================	Functions with output parameters	=========================

26	CREATE OR REPLACE FUNCTION sum_n_product (x int, y int, OUT sum int, OUT product int) AS $$
	SELECT x + y, x * y
	$$ LANGUAGE SQL;

27	SELECT sum_n_product(5, 20);
28	SELECT (sum_n_product(5, 20)).*;

29	CREATE OR REPLACE FUNCTION square_n_cube(IN x int, OUT square int, OUT cube int) AS $$
	SELECT x * x, x*x*x;
	$$ LANGUAGE SQL;

30	SELECT (square_n_cube(55)).*;


	======================	Functions with default value	=======================
	
31	CREATE OR REPLACE FUNCTION new_price(products, increase_percent numeric DEFAULT 105)
	RETURNS double precision AS $$
	SELECT $1.unitprice * increase_percent/100
	$$ LANGUAGE SQL;

32	SELECT productname,unitprice,new_price(products)
	FROM products;

33	CREATE OR REPLACE FUNCTION square_n_cube(IN x int DEFAULT 10, OUT square int, OUT cube int) AS $$
	SELECT x * x, x*x*x;
	$$ LANGUAGE SQL;

34	SELECT (square_n_cube()).*;


	==========================	Using functioms as table source	========================
	
35	SELECT firstname,lastname,hiredate
	FROM newest_hire();

36	SELECT productname,companyname
	FROM highest_inventory() AS hi
	JOIN suppliers ON hi.supplierid=suppliers.supplierid;
	
	==========================	Functions that returns more than one ROW	==================
	
37	CREATE OR REPLACE FUNCTION sold_more_than(total_sales real)
	RETURNS SETOF products AS $$
	SELECT * FROM products
	WHERE productid IN (
	 SELECT productid FROM
 	 (SELECT SUM(quantity*unitprice),productid
	 FROM order_details
	 GROUP BY productid
	 HAVING SUM(quantity*unitprice) > total_sales) as qualified_products
	)
	$$ LANGUAGE SQL;

38	SELECT productname, productid, supplierid
	FROM sold_more_than(25000);

39	CREATE OR REPLACE FUNCTION suppliers_to_reorder_from()
	RETURNS SETOF suppliers AS $$
	SELECT * FROM suppliers
	WHERE supplierid IN (
	 SELECT supplierid FROM products
	  WHERE unitsinstock + unitsonorder < reorderlevel
	)
	$$ LANGUAGE SQL;

40	SELECT * FROM suppliers_to_reorder_from()

41	create function next_birthday() 
	returns table(birthday date, firstname varchar(10),lastname varchar(10) ,hiredate date)as $$
	
	select (birthdate + interval '1 YEAR' * (EXTRACT (year from age(birthdate))+1))::date,
	firstname,lastname,hiredate
	from employees

	$$ language sql;

42	select * from next_birthday();


======================	procedures -functions that returns nothing	=======================

43	CREATE OR REPLACE PROCEDURE add_em(x int, y int) AS $$

	SELECT x + y

	$$ LANGUAGE SQL;

44	CALL add_em(5,3);


45	CREATE OR REPLACE PROCEDURE change_supplier_prices(supplierid smallint, amount real) AS $$

	UPDATE products
	SET unitprice = unitprice + amount
	WHERE supplierid = $1

	$$ LANGUAGE;

46 CALL change_supplier_prices(20::smallint, 0.50);


	
	
	

	