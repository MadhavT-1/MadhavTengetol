	==========================	Creating Indexes	=====================================
	
1.	CREATE UNIQUE INDEX idx_employees_employeeid
	ON employees (employeeid);

2.	CREATE UNIQUE INDEX idx_Orders_customerid_orderid
	ON orders(customerid,orderid)
	
	
	==========================	Drop Indexes	========================================
	
3.	DROP INDEX 	idx_employees_employeeid;

4.	DROP INDEX 	idx_Orders_customerid_orderid;


	==========================	Kill RUNAWAY Queries	================================
	
5.	DROP TABLE IF EXISTS performance_test;

	a.	CREATE TABLE performance_test (
		id serial,
		location text
		);

	b.	INSERT INTO performance_test (location)
		SELECT 'Katmandu, Nepal' FROM generate_series(1,500000000);

	//See what is running
6.	SELECT * FROM pg_stat_activity WHERE state = 'active';

	// polite way to stop
7.	SELECT pg_cancel_backend(PID);

	//stop at all costs - can lead to full database restart
8.	SELECT pg_terminate_backend(PID);

	=======================	Using Explain	===========================================
	
9.	DROP TABLE IF EXISTS performance_test;

	CREATE TABLE performance_test (
	id serial,
	location text
	);


10.	INSERT INTO performance_test (location)
	SELECT md5(random()::text) FROM generate_series(1,10000);
	
	-- this takes forever 332
11.	SELECT COUNT(*) FROM performance_test;

	-- this takes 331 msec
12.	SELECT * FROM performance_test
	WHERE id = 2000;

	-- notice that it does a sequential scan
13.	EXPLAIN SELECT COUNT(*) FROM performance_test;

14.	EXPLAIN SELECT * FROM performance_test
	WHERE id = 2000;


15.	CREATE INDEX idx_performance_test_id ON performance_test (id);

-- now will use an index scan
16.	EXPLAIN SELECT * FROM performance_test
	WHERE id = 2000;

-- now count runs in 26 msec
17.	SELECT * FROM performance_test
	WHERE id = 2000;

-- still does sequence scan
18.	EXPLAIN SELECT COUNT(*) FROM performance_test;

-- still takes 319 msec
19.	SELECT COUNT(*) FROM performance_test;


	================================	Use Analyze to UPDATE TABLE	=======================
	
20.	DROP TABLE IF EXISTS performance_test;
	CREATE TABLE performance_test (
	id serial,
	location text
	);
21.	INSERT INTO performance_test (location)
	SELECT md5(random()::text) FROM generate_series(1,10000000);
	

-- it thinks there will be rows=50000
22.	EXPLAIN ANALYZE SELECT * FROM performance_test
	WHERE id = 2000000;

23.	ANALYZE performance_test;

-- it now thinks there will be rows=1
	EXPLAIN ANALYZE SELECT * FROM performance_test
	WHERE id = 2000000;

	
	================================	Query Plan Cost Calculation	========================
	
	#Every table and index is stores as an array of pages of fixed size default 8kb

24.	SET max_parallel_workers_per_gather = 0;
	EXPLAIN SELECT * FROM performance_test
	WHERE location like 'ab%';

-- size of table
25.	SELECT pg_relation_size('performance_test'),
	pg_size_pretty(pg_relation_size('performance_test'));


-- number of relation pages
26.	SELECT relpages
	FROM pg_class
	WHERE relname='performance_test';

--
27.	SELECT relpages, pg_relation_size('performance_test') / 8192
	FROM pg_class
	WHERE relname='performance_test';

-- I/O cost per relationship page read
28.	SHOW seq_page_cost;

-- total I/O cost
29.	SELECT relpages * current_setting('seq_page_cost')::numeric
	FROM pg_class
	WHERE relname='performance_test';

-- number of rows
30.	SELECT reltuples
	FROM pg_class
	WHERE relname='performance_test';

--CPU cost per row processed
31.	SHOW cpu_tuple_cost;

32.	SHOW cpu_operator_cost;

-- Total CPU Costs
33.	SELECT reltuples * current_setting('cpu_tuple_cost')::numeric +
	reltuples * current_setting('cpu_operator_cost')::numeric
	FROM pg_class
	WHERE relname='performance_test';

-- Total Costs for a table scan
34.	SELECT relpages * current_setting('seq_page_cost')::numeric +
	reltuples * current_setting('cpu_tuple_cost')::numeric +
	reltuples * current_setting('cpu_operator_cost')::numeric
	FROM pg_class
	WHERE relname='performance_test';

35.	SHOW parallel_setup_cost;

36.	SHOW parallel_tuple_cost;

37.	SET max_parallel_workers_per_gather = 4;

38.	EXPLAIN (ANALYZE, VERBOSE) SELECT * FROM performance_test
	WHERE location like 'ab%';
	
	=========================	Using INDEXES on more than one field	=========================
	
39.	ALTER TABLE performance_test
	ADD COLUMN name text;
	
40.	UPDATE performance_test
	SET name = md5(location);

-- takes above 900ms after data cached
	EXPLAIN ANALYZE SELECT *
	FROM  performance_test
	WHERE location LIKE 'df%' AND name LIKE 'cf%';

41.	CREATE INDEX idx_peformance_test_location_name
	ON performance_test(location,name);

-- takes 55 ms
42.	EXPLAIN ANALYZE SELECT *
	FROM  performance_test
	WHERE location LIKE 'df%' AND name LIKE 'cf%';

-- this can't use index
43.	EXPLAIN ANALYZE SELECT *
	FROM  performance_test
	WHERE  name LIKE 'cf%';

-- this can
44.	EXPLAIN ANALYZE SELECT *
	FROM  performance_test
	WHERE location LIKE 'df%';
	
	===========================	Expression INDEXES	=======================================
	-- This is for AdventureWorks database

--Make sure we don't have indexes to see the effect
45.	DROP INDEX IF EXISTS production.idx_product_name;
46.	DROP INDEX IF EXISTS production.idx_product_upper_name;

-- you should see a sequential scan
-- Seq Scan on product  (cost=0.00..16.30 rows=10 width=139)
47.	EXPLAIN select *
	from production.product
	WHERE name LIKE 'Flat%';

-- create normal index
48.	CREATE INDEX idx_product_name
	ON production.product (name);

-- this becomes an bitmap index scan
-- "  ->  Bitmap Index Scan on idx_product_name  (cost=0.00..4.32 rows=5 width=0)"
49.	EXPLAIN select *
	from production.product
	WHERE name LIKE 'Flat%';

-- this is back to sequential scan
-- "Seq Scan on product  (cost=0.00..17.56 rows=3 width=139)"
50.	EXPLAIN select *
	from production.product
	WHERE UPPER(NAME) LIKE UPPER('Flat%');

-- create an expression scan
51.	CREATE INDEX idx_product_upper_name
	ON production.product (UPPER(name));

-- now we get a bitmap index scan
-- "  ->  Bitmap Index Scan on idx_product_upper_name  (cost=0.00..4.30 rows=3 width=0)"
52.	EXPLAIN select *
	from production.product
	WHERE UPPER(NAME) LIKE UPPER('Flat%');

--your turn
53.	CREATE INDEX idx_person_fullname
	ON person.person ( (firstname  || ' ' || lastname) );

--show that it uses the index
54.	EXPLAIN SELECT *
	FROM person.person
	WHERE firstname || ' ' || lastname = 'Terri Duffy';

	=============================	Speeding Up Text Matching	================================
55.	CREATE EXTENSION pg_trgm;

56.	CREATE INDEX trgm_idx_performance_test_location
	ON performance_test USING gin (location gin_trgm_ops);

57.	CREATE INDEX idx_performance_test_name
	ON performance_test (name);


-- terrible performance
58.	EXPLAIN ANALYZE SELECT location
	FROM  performance_test
	WHERE name LIKE '%dfe%';

--only situation where pattern matching works
59.	EXPLAIN ANALYZE SELECT location
	FROM  performance_test
	WHERE name LIKE 'dfe%';


-- much better performance
60.	EXPLAIN ANALYZE SELECT location
	FROM  performance_test
	WHERE location LIKE '%dfe%';

61.	EXPLAIN ANALYZE SELECT location
	FROM  performance_test
	WHERE location LIKE 'dfe%';
	
	