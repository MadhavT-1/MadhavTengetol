	=========================	CREATE TABLE	====================
1.	CREATE TABLE subscribers (
	firstname varchar(200),
	 lastname varchar(200),
	email varchar(250),
	signup timestamp,
	frequency integer,
	iscustomer boolean
	);
	
	SELECT * FROM subscribers
	
2.	CREATE TABLE returns (
	returnrid serial,
	customerid char(5),
	returndate timestamp,
	productid integer,
	quantity smallint,
	orderid integer
	);

	SELECT * FROM returns
	
	==========================	ALTER TABLE	=================================
	
3.	ALTER TABLE subscribers
	RENAME firstname TO first_name;

4.	ALTER TABLE returns
	RENAME returndate TO return_date;

5.	ALTER TABLE subscribers
	RENAME TO email_subscribers;

6.	ALTER TABLE returns
	RENAME TO bad_orders;

7.	ALTER TABLE email_subscribers
	ADD COLUMN last_visit_date timestamp;

8.	ALTER TABLE bad_orders
	ADD COLUMN reason text;


9.	ALTER TABLE email_subscribers
	DROP COLUMN last_visit_date;

10.	ALTER TABLE bad_orders
	DROP COLUMN reason;
	
11.	ALTER TABLE email_subscribers
	ALTER COLUMN email SET DATA TYPE varchar(225);

12.	ALTER TABLE bad_orders
	ALTER COLUMN quantity SET DATA TYPE int;
	
	================================	DROP TABLE	======================================
	
13.	DROP TABLE email_subscribers;

14.	DROP TABLE bad_orders;
	
	
	
	