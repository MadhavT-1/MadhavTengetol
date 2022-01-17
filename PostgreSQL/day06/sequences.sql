	========================	CREATE SEQUENCE		========================
	
1.	CREATE SEQUENCE test_sequence;

2.	SELECT nextval('test_sequence');


3.	SELECT currval('test_sequence');

4.	SELECT lastval();

-- set value but next value will increment
5.	SELECT setval('test_sequence',14);

6.	SELECT nextval('test_sequence');

-- set value and next value will be what you set
7.	SELECT setval('test_sequence',25,false);

8.	SELECT nextval('test_sequence');

9.	CREATE SEQUENCE IF NOT EXISTS test_sequence2 INCREMENT 5;

10.	CREATE SEQUENCE IF NOT EXISTS test_sequence_3
	INCREMENT 50 MINVALUE 350 MAXVALUE 5000 START WITH 550;

12.	CREATE SEQUENCE IF NOT EXISTS test_sequence_4 INCREMENT 7 START WITH 33;

13.	SELECT MAX(employeeid) FROM employees;

14.	CREATE SEQUENCE IF NOT EXISTS employees_employeeid_seq
	START WITH 10 OWNED BY employees.employeeid;

--This insert will fail
15.	INSERT INTO employees
	(lastname,firstname,title,reportsto)
	VALUES ('Smith','Bob', 'Assistant', 2);

--must alter the default value
16.	ALTER TABLE employees
	ALTER COLUMN employeeid SET DEFAULT nextval('employees_employeeid_seq');

--Now Insert will work
17.	INSERT INTO employees
	(lastname,firstname,title,reportsto)
	VALUES ('Smith','Bob', 'Assistant', 2);

18.	INSERT INTO users (name,age) VALUES (‘Liszt’,10) RETURNING id;

19.	SELECT MAX(orderid) FROM orders;

20.	CREATE SEQUENCE IF NOT EXISTS orders_orderid_seq START WITH 11077;

21.	ALTER TABLE orders
	ALTER COLUMN orderid SET DEFAULT nextval('orders_orderid_seq');

22.	INSERT INTO orders (customerid,employeeid,requireddate,shippeddate)
	VALUES ('VINET',5,'1996-08-01','1996-08-10') RETURNING orderid;
	