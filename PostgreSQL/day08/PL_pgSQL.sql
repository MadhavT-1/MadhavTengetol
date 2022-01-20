
	============================	Build First PgSql function	=======================
	
1	DROP ROUTINE IF EXISTS  max_price();

2	CREATE FUNCTION max_price() RETURNS real AS $$
	BEGIN
	RETURN MAX(unitprice)
	FROM products;
	END;
	$$ LANGUAGE plpgsql;

3	SELECT max_price();

4	DROP ROUTINE IF EXISTS biggest_order;

5	CREATE FUNCTION biggest_order() RETURNS double precision AS $$
	BEGIN
	RETURN MAX(amount)
	FROM
	(SELECT SUM(unitprice*quantity) as amount,orderid
	FROM order_details
	GROUP BY orderid) as totals;
	END;
	$$ LANGUAGE plpgsql;

6	SELECT biggest_order();
	
	===============================	handling function with output variables	=============
	
7	CREATE OR REPLACE FUNCTION sum_n_product (x int, y int, OUT sum int, OUT product int) AS $$
	BEGIN
	sum := x + y;
	product := x * y;
	RETURN;
	END;
	$$ LANGUAGE plpgsql;

8	SELECT sum_n_product(5, 20);
9	SELECT (sum_n_product(5, 20)).*;

10	CREATE OR REPLACE FUNCTION square_n_cube
	(IN x int, OUT square int, OUT cube int) AS $$
	BEGIN
	square := x*x;
	cube := x*x*x;
	RETURN;

	END;
	$$ LANGUAGE plpgsql;

11	SELECT (square_n_cube(55)).*;
	
	==============================	Declaring Variables	=========================
	
12	CREATE OR REPLACE FUNCTION middle_priced()
	RETURNS SETOF products AS $$

	DECLARE
		average_price real;
		bottom_price real;
		top_price real;
	BEGIN
		SELECT AVG(unitprice) INTO average_price
		FROM products;

		bottom_price := average_price * .75;
		top_price := average_price * 1.25;

		RETURN QUERY SELECT * FROM products
		WHERE unitprice between bottom_price AND top_price;
	END;
	$$ LANGUAGE plpgsql;


13	SELECT * FROM middle_priced();

14	CREATE OR REPLACE FUNCTION normal_orders() RETURNS SETOF orders AS $$

	DECLARE
		average_order_amount real;
		bottom_order_amount real;
		top_order_amount real;
	BEGIN
		SELECT AVG(amount_ordered) INTO average_order_amount FROM
		( SELECT SUM(unitprice*quantity) AS amount_ordered,orderid
		  FROM order_details
		  GROUP BY orderid) as order_totals;

		 bottom_order_amount := average_order_amount * 0.75;
		 top_order_amount := average_order_amount * 1.30;

		 RETURN QUERY SELECT * FROM orders WHERE
		 orderid IN (
			 SELECT orderid FROM
			(SELECT SUM(unitprice*quantity),orderid
		  	FROM order_details
		  	GROUP BY orderid
			HAVING SUM(unitprice*quantity) BETWEEN bottom_order_amount AND top_order_amount) AS order_amount
		 );
	END;
	$$ LANGUAGE plpgsql;

15	SELECT * FROM normal_orders();
	
	====================================	Returning query results	=====================
	
16	create or replace function sold_more_than(total_sales real)
	returns setof products as $$
	
	begin
		return query select * from products
		where productid IN(
			select productid from(
		select sum(quantity*unitprice),productid
		from order_details
		group by productid
		having sum(quantity*unitprice) > total_sales) as qualified_products
		
	);
	end;
	$$ language plpgsql;

17	select (sold_more_than(25000)).*;	


1	CREATE OR REPLACE FUNCTION sold_more_than(total_sales real)
	RETURNS SETOF products AS $$
	BEGIN

	RETURN QUERY SELECT * FROM products
	WHERE productid IN (
	 SELECT productid FROM
 	 (SELECT SUM(quantity*unitprice),productid
	 FROM order_details
	 GROUP BY productid
	 HAVING SUM(quantity*unitprice) > total_sales) as qualified_products
 	);

	IF NOT FOUND THEN
  	RAISE EXCEPTION 'Nn products had sales higher than %.', $1;
	END IF;

	RETURN;
	END;
	$$ LANGUAGE plpgsql;

2	SELECT productname, productid, supplierid
	FROM sold_more_than(25000);

3	CREATE OR REPLACE FUNCTION after_christmas_sale() RETURNS SETOF products AS $$
	DECLARE
	product record;
	BEGIN
	FOR product IN
		SELECT * FROM products
	LOOP
		IF product.categoryid IN (1,4,8) THEN
			product.unitprice = product.unitprice * .80;
		ELSIF product.categoryid IN (2,3,7) THEN
			product.unitprice = product.unitprice * .75;
		ELSE
			product.unitprice = product.unitprice * 1.10;
		END IF;
		RETURN NEXT product;
	END LOOP;

	RETURN;

	END;
	$$ LANGUAGE plpgsql;

4	SELECT * FROM after_christmas_sale();



	==============================	looping through query results	============================
	
-- get the data for this from the CTE - Common Table Expressions section
-- under Creating Hierarchical Data to Use for Recursive WITH Queries

18	CREATE FUNCTION reports_to(IN eid smallint, OUT employeeid smallint, OUT reportsto smallint) RETURNS SETOF record AS $$

	WITH RECURSIVE reports_to(employeeid,reportsto) AS (
		SELECT employeeid,reportsto FROM employees
		WHERE employeeid = eid
		UNION ALL
		SELECT manager.employeeid,manager.reportsto
		FROM employees AS manager
		JOIN reports_to ON reports_to.reportsto = manager.employeeid
	)
	SELECT * FROM reports_to;

	$$ LANGUAGE SQL;


19	CREATE OR REPLACE FUNCTION report_to_array(eid smallint) RETURNS smallint[] AS $$

	DECLARE
	report_array smallint[];
	manager record;
	BEGIN
	FOR manager IN SELECT reportsto FROM reports_to(eid) LOOP
    report_array :=  array_append(report_array, manager.reportsto);
	END LOOP;

	RETURN report_array;

	END;
	$$ LANGUAGE plpgsql;


20	SELECT report_to_array(218::smallint);

21	SELECT firstname,lastname,employeeid,report_to_array(employeeid)
	FROM employees;


22	CREATE OR REPLACE FUNCTION average_of_square() RETURNS double precision AS $$
	DECLARE
	square_total double precision := 0;
	total_count int := 0;
	product record;
	BEGIN
	FOR product IN SELECT * FROM products LOOP
		total_count := total_count + 1;
		square_total := square_total + (product.unitprice*product.unitprice);
	END LOOP;
	RETURN square_total / total_count;
	END;
	$$ LANGUAGE plpgsql;

23	SELECT average_of_square();
	
	======================	using If-then statements	=========================
	
24	CREATE OR REPLACE FUNCTION product_price_category(price real) RETURNS text AS $$
	BEGIN

	IF price > 50.0 THEN
		RETURN 'Luxury';
	ELSIF price > 25.0 THEN
		RETURN 'Consumer';
	ELSE
		RETURN 'Bargain';
	END IF;
	END;
	$$ LANGUAGE plpgsql;


25	SELECT  product_price_category(unitprice),*
	FROM products;



26	CREATE OR REPLACE FUNCTION time_of_year(date_to_check timestamp) RETURNS text AS $$

	DECLARE
	month_of_year int := EXTRACT(MONTH FROM date_to_check);
	BEGIN

	IF month_of_year >=3 AND month_of_year <=5 THEN
		RETURN 'Spring';
	ELSIF month_of_year >= 6 AND month_of_year <=8 THEN
		RETURN 'Summer';
	ELSIF month_of_year >= 9 AND month_of_year <=11 THEN
		RETURN 'Fall';
	ELSE
		RETURN 'Winter';
	END IF;
	END;
	$$ LANGUAGE plpgsql;

27	SELECT  time_of_year(orderdate),*
	FROM orders;
	
	
	=======================	loop and while LOOP	========================
	
28	CREATE OR REPLACE FUNCTION factorial(x float) RETURNS float AS $$
	DECLARE
	current_x float := x;
	running_multiplication float := 1;
	BEGIN
	LOOP
		running_multiplication := running_multiplication * current_x;

		current_x := current_x - 1;
		EXIT WHEN current_x <= 0;
	END LOOP;

	RETURN running_multiplication;

	END;
	$$ LANGUAGE plpgsql;

29	SELECT factorial(13::float);

30	CREATE OR REPLACE FUNCTION factorial(x float) RETURNS float AS $$
	DECLARE
	current_x float := x;
	running_multiplication float := 1;
	BEGIN
	WHILE current_x > 0 LOOP
		running_multiplication := running_multiplication * current_x;

		current_x := current_x - 1;
	END LOOP;

	RETURN running_multiplication;

	END;
	$$ LANGUAGE plpgsql;
	
	======================	Looping over ARRAY	========================
	
31	CREATE OR REPLACE FUNCTION select_url(path_to_search_for text, additional text[], default_path text)
	RETURNS text AS $$
	DECLARE
	additional_element text;
	additional_url text;
	BEGIN
	FOREACH additional_element IN ARRAY additional LOOP
		IF left(additional_element, length(path_to_search_for)) = path_to_search_for THEN
			additional_url := right(additional_element, length(additional_element) -
												length(path_to_search_for) - 1);
			RETURN trim(additional_url);
		END IF;
	END LOOP;

	RETURN default_path;
	END
	$$ LANGUAGE plpgsql;


32	SELECT select_url('sm', ARRAY['sm: /url2', 'md: url3'], '/url1');
33	SELECT select_url('md', ARRAY['sm: /url2', 'md: url3'], '/url1');
34	SELECT select_url('md', ARRAY['sm: /url2'], '/url1');

35	CREATE OR REPLACE FUNCTION first_multiple(x int[], y int) RETURNS int AS $$
	DECLARE
	test_number int;
	BEGIN
	FOREACH test_number IN ARRAY x LOOP
		IF test_number % y = 0 THEN
			RETURN test_number;
		END IF;
	END LOOP;
	RETURN NULL;
	END;
	$$ LANGUAGE plpgsql;

36	SELECT first_multiple(ARRAY[13, 12, 64, 10], 32);
	