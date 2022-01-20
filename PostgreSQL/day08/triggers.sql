======================	First Trigger	================
1.	ALTER TABLE employees
	ADD COLUMN last_updated timestamp;

2.	CREATE OR REPLACE FUNCTION employees_timestamp() RETURNS trigger AS $$
	BEGIN

	NEW.last_updated := now();
	RETURN NEW;

	END;
	$$ LANGUAGE plpgsql;

3	DROP TRIGGER IF EXISTS employees_timestamp ON employees;

4	CREATE TRIGGER employees_timestamp BEFORE INSERT OR UPDATE ON employees
	FOR EACH ROW EXECUTE FUNCTION employees_timestamp();

5	SELECT last_updated,*FROM EMPLOYEES
	WHERE employeeid=1;

6	UPDATE employees
	SET address = '27 West Bird Lane'
	WHERE employeeid=1;

7	SELECT last_updated FROM EMPLOYEES
	WHERE employeeid=1;

-- product example
8	ALTER TABLE products
	ADD COLUMN last_updated timestamp;

9	CREATE OR REPLACE FUNCTION products_timestamp() RETURNS trigger AS $$
	BEGIN

	NEW.last_updated := now();
	RETURN NEW;

	END;
10	$$ LANGUAGE plpgsql;

11	DROP TRIGGER IF EXISTS products_timestamp ON products;

12	CREATE TRIGGER products_timestamp BEFORE INSERT OR UPDATE ON products
	FOR EACH ROW EXECUTE FUNCTION products_timestamp();

13	SELECT last_updated,* FROM products
	WHERE productid=2;

14	UPDATE products
	SET unitprice=19.05
	WHERE productid=2;

15	SELECT last_updated,* FROM products
	WHERE productid=2;


==============================	Statement TRIGGERS	==========================

-- show how to grab the create statement using pgAdmin

16	CREATE TABLE order_details_audit (
	operation char(1) NOT NULL,
	userid	text NOT NULL,
	stamp	timestamp NOT NULL,
    orderid smallint NOT NULL,
    productid smallint NOT NULL,
    unitprice real NOT NULL,
    quantity smallint NOT NULL,
    discount real
	)

17	CREATE OR REPLACE FUNCTION audit_order_details() RETURNS trigger AS $$
	BEGIN
	IF (TG_OP == 'DELETE') THEN
		INSERT INTO order_details_audit
		SELECT 'D',user,now(),o.* FROM old_table o;
	ELSIF (TG_OP == 'UPDATE') THEN
		INSERT INTO order_details_audit
		SELECT 'U',user,now(),n.* FROM new_table n;
	ELSIF (TG_OP == 'INSERT') THEN
		INSERT INTO order_details_audit
		SELECT 'U',user,now(),n.* FROM new_table n;
	END IF;
	RETURN NULL;  -- we are using in after trigger so don't need to return update

	END;
	$$ LANGUAGE plpgsql;

18	DROP TRIGGER IF EXISTS audit_order_details_insert ON order_details;

19	CREATE TRIGGER audit_order_details_insert AFTER INSERT ON order_details
	REFERENCING NEW TABLE AS new_table
	FOR EACH STATEMENT EXECUTE FUNCTION audit_order_details();

20	DROP TRIGGER IF EXISTS audit_order_details_update ON order_details;

21	CREATE TRIGGER audit_order_details_update AFTER UPDATE ON order_details
	REFERENCING NEW TABLE AS new_table
	FOR EACH STATEMENT EXECUTE FUNCTION audit_order_details();

22	DROP TRIGGER IF EXISTS audit_order_details_delete ON order_details;

23	CREATE TRIGGER audit_order_details_delete AFTER DELETE ON order_details
	REFERENCING OLD TABLE AS old_table
	FOR EACH STATEMENT EXECUTE FUNCTION audit_order_details();

24	INSERT INTO order_details
	VALUES (10248, 3, 10, 5, 0);

25	SELECT * FROM order_details_audit;

26	update order_details
	SET discount=0.20
	WHERE orderid=10248 AND productid=3;

27	SELECT * FROM order_details_audit;

28	DELETE FROM order_details
	WHERE orderid=10248 AND productid=3;

29	SELECT * FROM order_details_audit;

30	CREATE TABLE orders_audit (
	operation char(1) NOT NULL,
	userid text NOT NULL,
	stamp timestamp NOT NULL,
	orderid smallint NOT NULL,
    customerid bpchar,
    employeeid smallint,
    orderdate date,
    requireddate date,
    shippeddate date,
    shipvia smallint DEFAULT 1,
    freight real,
    shipname character varying(40),
    shipaddress character varying(60),
    shipcity character varying(15),
    shipregion character varying(15),
    shippostalcode character varying(10),
    shipcountry character varying(15)
	)

31	CREATE OR REPLACE FUNCTION audit_orders() RETURNS trigger AS $$
	BEGIN
	IF (TG_OP = 'INSERT') THEN
		INSERT INTO orders_audit
		SELECT 'I',user,now(),n.* FROM new_table n;
	ELSIF (TG_OP = 'UPDATE') THEN
		INSERT INTO orders_audit
		SELECT 'U',user,now(),n.* FROM new_table n;
	ELSIF (TG_OP = 'DELETE') THEN
		INSERT INTO orders_audit
		SELECT 'D',user,now(),O.* FROM old_table o;
	END IF;
	RETURN NULL;
	END;
	$$ LANGUAGE plpgsql;

32	DROP TRIGGER IF EXISTS audit_orders_insert ON orders;

33	CREATE TRIGGER audit_orders_insert AFTER INSERT ON orders
	REFERENCING NEW TABLE AS new_table
	FOR EACH STATEMENT EXECUTE FUNCTION audit_orders();

34	DROP TRIGGER IF EXISTS audit_orders_update ON orders;

35	CREATE TRIGGER audit_orders_update AFTER UPDATE ON orders
	REFERENCING NEW TABLE AS new_table
	FOR EACH STATEMENT EXECUTE FUNCTION audit_orders();

36	DROP TRIGGER IF EXISTS audit_orders_delete ON orders;

37	CREATE TRIGGER audit_orders_delete AFTER DELETE ON orders
	REFERENCING OLD TABLE AS old_table
	FOR EACH STATEMENT EXECUTE FUNCTION audit_orders();
