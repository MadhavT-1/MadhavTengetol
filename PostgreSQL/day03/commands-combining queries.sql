	###################	UNION ############################
		Combine result of 2 or more queries
			1.	Must have same number of columns, column type must line up
			2.	Removes duplicates
		
1.	SELECT companyname
	FROM customers
	UNION
	SELECT companyname
	FROM suppliers;

2.	SELECT city
	FROM customers
	UNION ALL
	SELECT city
	FROM suppliers;

3.	SELECT country
	FROM customers
	UNION
	SELECT country
	FROM suppliers
	ORDER BY country ASC;

4.	SELECT country
	FROM customers
	UNION ALL
	SELECT country
	FROM suppliers
	ORDER BY country ASC;
	
	######################### INTERSECT	############################
		Find items that are both queries
	
5.	SELECT country FROM customers
	INTERSECT
	SELECT country FROM suppliers;
	
6.	SELECT COUNT(*) FROM
	(SELECT country FROM customers
	INTERSECT ALL
	SELECT country FROM suppliers) AS same_country;

7.	SELECT city
	FROM customers
	INTERSECT
	SELECT city
	FROM suppliers
	ORDER BY country ASC;

8.	SELECT COUNT(*) FROM
	(SELECT city FROM customers
	INTERSECT
	SELECT city FROM suppliers ) AS same_city;
	
	##########################	Except	##############################
	Find items that are the first query but not the SECOND
	
		

9.	SELECT country FROM customers
	EXCEPT
	SELECT country FROM suppliers;

10.	SELECT COUNT(*) FROM
	(SELECT country FROM customers
	EXCEPT ALL
	SELECT country FROM suppliers) AS same_country;

11.	SELECT city FROM suppliers
	EXCEPT
	SELECT city FROM customers;

12.	SELECT city
	FROM customers
	INTERSECT
	SELECT city
	FROM suppliers
	ORDER BY city DESC;

13.	SELECT COUNT(*) FROM
	(SELECT city FROM customers
	INTERSECT
	SELECT city FROM suppliers ) AS same_city;
	
	
	