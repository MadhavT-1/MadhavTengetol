======================== instance level security	==========================

CREATE ROLE accounting NOCREATEDB NOLOGIN NOSUPERUSER;
CREATE ROLE hr NOCREATEDB NOLOGIN NOSUPERUSER;

//can't login with either
psql -U accounting
psql -U hr


CREATE ROLE suzy NOCREATEDB LOGIN NOSUPERUSER PASSWORD 'pass123';
CREATE USER bobby NOCREATEDB LOGIN NOSUPERUSER PASSWORD 'pass123';

//can login in
psql -U suzy
psql -U bobby

REVOKE ALL ON DATABASE northwind FROM public;

GRANT  accounting TO suzy;
GRANT  hr TO bobby;

CREATE ROLE sales NOCREATEDB NOLOGIN NOSUPERUSER;
CREATE ROLE jill NOCREATEDB LOGIN NOSUPERUSER PASSWORD 'pass123';
GRANT  sales TO jill;


======================= DATABASE level security	==========================
GRANT CONNECT ON DATABASE northwind TO accounting;
GRANT CONNECT ON DATABASE northwind TO hr;

//now we can connect to northwind
 psql -U suzy

 //still can't create schema
CREATE SCHEMA suzy;

//allow accounting to create schemas
GRANT CREATE ON DATABASE northwind TO accounting;

//now suzy can create schema
CREATE SCHEMA suzy;

GRANT CONNECT ON DATABASE northwind TO sales;
GRANT CREATE ON DATABASE northwind TO sales;


==================== SCHEMA level security	===================
//suzy can create a table even though no explicit permissions
 psql -U bobby
create table can_i (id int);


//in pgAdmin issue this command
REVOKE ALL ON SCHEMA public FROM public;
DROP TABLE can_i;


//on psql for bobby try again
create table can_i (id int);


//in pgAdmin window
GRANT CREATE ON SCHEMA public TO accounting;
GRANT USAGE ON SCHEMA public TO accounting;
GRANT USAGE ON SCHEMA public TO hr;


GRANT USAGE ON SCHEMA public TO sales;

====================	TABLE level security	=====================
GRANT SELECT ON ALL TABLES IN SCHEMA public TO accounting;

GRANT INSERT ON TABLE employees TO hr;
GRANT SELECT ON TABLE employees TO hr;
GRANT UPDATE ON TABLE employees TO hr;


GRANT SELECT ON TABLE customers TO sales;

GRANT SELECT ON TABLE orders TO sales;
GRANT SELECT ON TABLE order_details TO sales;

GRANT INSERT ON TABLE orders TO sales;
GRANT INSERT ON TABLE order_details TO sales;

===================	Column level security	=============================

// First we try to restrict
GRANT SELECT (employeeid, lastname, firstname, title, titleofcourtesy, hiredate, country, extension, photo, photopath)
ON employees
TO accounting;

//login in as suzy and try
SELECT * FROM employees;

//She sees everthing, must revoke select on all tables
REVOKE SELECT ON ALL TABLES
IN SCHEMA public
FROM accounting;

// then apply permissions
GRANT SELECT (employeeid, lastname, firstname, title, titleofcourtesy, hiredate, country, extension, photo, photopath)
ON employees
TO accounting;


//login in as suzy and try
SELECT * FROM employees;

//must use column names
SELECT firstname,lastname,hiredate FROM employees;

//your turn
GRANT UPDATE (contactname, contacttitle, phone)
ON customers
TO sales;

=====================	Row level security	====================================

GRANT SELECT
ON TABLE orders
TO accounting;

//login as suzy and test - she can see all rows
SELECT COUNT(*) FROM orders;

ALTER TABLE orders
ENABLE ROW LEVEL SECURITY;

//as suzy - you see zero records
SELECT COUNT(*) FROM orders;

//in pgAdmin create a policy
CREATE POLICY accounting_orders ON orders
FOR SELECT
TO accounting
USING (orderdate >= '1998-01-01');

//now try with suzy
SELECT MIN(orderdate) FROM orders;

// adding policy for older data
CREATE POLICY accounting_orders_older ON orders
FOR SELECT
TO accounting
USING (orderdate <= '1996-12-31');

//now try with suzy
SELECT MIN(orderdate) FROM orders;
//still can not see data from 1997
SELECT * FROM orders where orderdate BETWEEN '1997-01-01' AND '1997-12-31';

//drop policy
DROP POLICY accounting_orders_older ON orders;
//create a restrictive policy
CREATE POLICY accounting_orders_customers ON orders
AS RESTRICTIVE
FOR SELECT TO accounting
USING (customerid LIKE 'A%');

//now try with suzy
SELECT * FROM orders;

// your turn
CREATE POLICY sales_orders ON orders
FOR UPDATE
TO sales
USING (shippeddate IS NULL);

