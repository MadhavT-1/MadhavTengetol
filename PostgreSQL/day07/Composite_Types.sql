	=====================	Composite Type Basics	=====================
	
	Basically a list of field names and their data types
	can be used as column in a TABLE
	also used in functions and procedures
	
1.	CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
	);

2.	CREATE TABLE friends (
	first_name varchar(100),
	last_name varchar(100),
	address	address
	);

3.	DROP TYPE address CASCADE;
4.	DROP TABLE friends;


5.	CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
	);

6.	CREATE TYPE full_name AS (
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
	);

7.	CREATE TABLE friends (
	name full_name,
	address	address
	);

8.	DROP TYPE address CASCADE;
9.	DROP TYPE full_name CASCADE;
10.	DROP TABLE friends;
	
	
	====================	Using Composite Types	=========================
	
11.	CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
	);

12.	CREATE TYPE full_name AS (
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
	);

13	CREATE TYPE dates_to_remember AS (
	birthdate date,
	age       integer,
	anniversary date
	);

14.	CREATE TABLE friends (
	name full_name,
	address	address,
	specialdates dates_to_remember
	);

15.	INSERT INTO friends (name, address, specialdates)
	VALUES (ROW('Boyd','M','Gregory'),ROW('7777','','Boise','Idaho','USA','99999'),ROW('1969-02-01',49,'2001-07-15'));

16.	SELECT * FROM friends;
17	SELECT name FROM friends;

18.	SELECT (address).city,(specialdates).birthdate
	FROM friends;

19.	SELECT name FROM friends
	WHERE (name).first_name = 'Boyd';

20.	SELECT (address).state_region,(name).middle_name,(specialdates).age FROM friends
	WHERE (name).last_name = 'Gregory';
	