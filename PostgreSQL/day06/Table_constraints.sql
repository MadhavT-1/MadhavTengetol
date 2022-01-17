	===========================		NOT NULL	==============================
	
		Field must have a value
		
1.	CREATE TABLE IF NOT EXISTS practices (
	practiceid integer NOT NULL
	);

2.	INSERT INTO practices (practiceid)
	VALUES (null);
	
	DROP TABLE IF EXISTS practices;

3.	CREATE TABLE IF NOT EXISTS practices (
	practiceid integer NOT NULL,
	practice_field varchar(50) NOT NULL
	);

4.	ALTER TABLE products
	ALTER COLUMN unitprice SET NOT NULL;

5.	ALTER TABLE employees
	ALTER COLUMN lastname SET NOT NULL;
		
	===========================		UNIQUE KEY	==============================
	
		Value must not be already be in table
		
6.	DROP TABLE IF EXISTS practices;

7.	CREATE TABLE practices (
	practiceid integer UNIQUE,
	fieldname varchar(50) NOT NULL
	);

8.	INSERT INTO practices (practiceid,fieldname)
	VALUES (1, 'field1');
9.	INSERT INTO practices (practiceid,fieldname)
	VALUES (1, 'field2');


10.	DROP TABLE IF EXISTS pets;

11.	CREATE TABLE pets (
	petid integer UNIQUE,
    name varchar(25) NOT NULL
	)

12.	ALTER TABLE pets
	ADD CONSTRAINT name UNIQUE(name);

13.	ALTER TABLE shippers
	ADD CONSTRAINT shippers_companyname UNIQUE(companyname);
	
	===========================		PRIMARY KEY	==============================
	
		Must have a value and be unique, used to identify record
		
14.	DROP TABLE IF EXISTS practices;

15.	CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	fieldname varchar(50) NOT NULL
	);

16.	INSERT INTO practices (practiceid,fieldname)
	VALUES (1, null);
17.	INSERT INTO practices (practiceid,fieldname)
	VALUES (1, 'field1');
18.	INSERT INTO practices (practiceid,fieldname)
	VALUES (1, 'field2');

19.	DROP TABLE IF EXISTS pets;

20.	CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL
	);

21.	ALTER TABLE practices
	DROP CONSTRAINT practices_pkey;

22.	ALTER TABLE practices
	ADD PRIMARY KEY (practiceid);

23.	ALTER TABLE pets
	DROP CONSTRAINT pets_pkey;

24.	ALTER TABLE pets
	ADD PRIMARY KEY (petid);
		
	===========================		FOREIGN KEY	==============================
	
		All values must exist in another table`
		
25.	DROP TABLE IF EXISTS practices;

26.	CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	practicefield varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
	)


27.	DROP TABLE IF EXISTS pets;

28.	CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
	)

29.	ALTER TABLE practices
	DROP CONSTRAINT practices_employeeid_fkey;

30.	ALTER TABLE practices
	ADD CONSTRAINT practices_employee_fkey
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid);

31.	ALTER TABLE pets
	DROP CONSTRAINT pets_customerid_fkey;

32.	ALTER TABLE pets
	ADD CONSTRAINT pets_customerid_fkey
	FOREIGN KEY (customerid) REFERENCES customers(customerid);
		
	===========================		CHECK 	==============================
	
		Checks that all values meet condition
		
31.	DROP TABLE IF EXISTS practices;

32.	CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	practicefield varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	cost integer CONSTRAINT practices_cost CHECK (cost >= 0 AND cost <= 1000),
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
	);
	
	INSERT INTO practices VALUES(1,'something',1,1500)

33.	DROP TABLE IF EXISTS pets;

34.	CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	weight integer CONSTRAINT pets_weight CHECK (weight > 0 AND weight < 200),
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
	);

35.	ALTER TABLE orders
	ADD CONSTRAINT orders_freight CHECK (freight > 0);

36.	ALTER TABLE products
	ADD CONSTRAINT products_unitprice CHECK (unitprice > 0);
		
	===========================		DEFAULT	==============================
	
		If no value provided, value is set to the default
		
37.	DROP TABLE IF EXISTS practices;

38.	CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	practicefield varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	cost integer DEFAULT 50 CONSTRAINT practices_cost CHECK (cost >= 0 AND cost <= 1000),
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
	);

39.	DROP TABLE IF EXISTS pets;

40.	CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	weight integer DEFAULT 5 CONSTRAINT pets_weight CHECK (weight > 0 AND weight < 200),
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
	);

41.	ALTER TABLE orders
	ALTER COLUMN shipvia SET DEFAULT 1;

42.	ALTER TABLE products
	ALTER COLUMN reorderlevel SET DEFAULT 5;
	
43.	ALTER TABLE products
	ALTER COLUMN reorderlevel SET DEFAULT 5

44.	ALTER TABLE products
	ALTER COLUMN reorderlevel DROP DEFAULT

45.	ALTER TABLE suppliers
	ALTER COLUMN homepage SET DEFAULT 'N/A'

46.	ALTER TABLE suppliers
	ALTER COLUMN homepage DROP DEFAULT
	
47.	ALTER TABLE products
	ADD CHECK ( reorderlevel > 0);

-- All rows must meet the condition
48.	UPDATE products
	SET reorderlevel = 0
	WHERE reorderlevel is null or reorderlevel < 0;

49.	ALTER TABLE products
	ALTER COLUMN discontinued SET NOT NULL;

50.	ALTER TABLE products
	DROP CONSTRAINT products_reorderlevel_check;

51.	ALTER TABLE products
	ALTER COLUMN discontinued DROP NOT NULL;

52.	ALTER TABLE order_details
	ADD CHECK (unitprice > 0);

53.	ALTER TABLE order_details
	ALTER COLUMN discount SET NOT NULL;

54.	ALTER TABLE order_details
	DROP CONSTRAINT order_details_unitprice_check;

55.	ALTER TABLE order_details
	ALTER COLUMN discount DROP NOT NULL;
	
	
		