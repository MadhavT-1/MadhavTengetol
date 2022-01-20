
	==============================	Simple TRANSACTION Control	==========================
	
1	BEGIN TRANSACTION;
	UPDATE products
	SET reorderlevel = reorderlevel - 5;

	SELECT COUNT(*)
	FROM products
	WHERE unitsinstock + unitsonorder < reorderlevel;

	END TRANSACTION;


2	BEGIN TRANSACTION;
	UPDATE orders
	SET requireddate = requireddate + INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-12-01' AND '1997-12-31';

	UPDATE orders
	SET requireddate = requireddate - INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-11-01' AND '1997-11-30';

	END TRANSACTION;
	
	
	
	=================================	ROLLBACK & SAVEPOINT 	===================================
	
3.	START TRANSACTION;

	UPDATE orders
	SET orderdate = orderdate + INTERVAL '1 YEAR';

4	ROLLBACK;


5	START TRANSACTION;

	INSERT INTO employees (employeeid,lastname,firstname,title,birthdate,hiredate)
	VALUES (501,'Sue','Jones','Operations Assistant','1999-05-23','2017-06-13');

6	SAVEPOINT inserted_employee;

7	UPDATE employees
	SET birthdate='2025-07-11';

8	ROLLBACK TO inserted_employee;

9	UPDATE employees
	SET birthdate='1998-05-23'
	WHERE employeeid=501;

10	COMMIT;

11	SELECT *
	FROM employees
	WHERE employeeid=501;
	
	