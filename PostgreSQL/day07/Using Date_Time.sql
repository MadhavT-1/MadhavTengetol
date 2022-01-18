	=========================	Date, Time and TimeStamp	==================
	
	Timestamp => both date and time
	date	  => date only
	time	  => Time only
	
1.	SHOW DateStyle;

2.	SET DateStyle = 'ISO,DMY';

3.	SET DateStyle = 'ISO,MDY'


4.	CREATE TABLE test_time (
	startdate DATE,
	startstamp TIMESTAMP,
	starttime TIME
	);

5.	Insert INTO test_time (startdate, startstamp,starttime)
	VALUES ('epoch'::abstime,'infinity'::abstime,'allballs');


6.	SELECT * FROM test_time;

7.	Insert INTO test_time (startdate, startstamp)
	VALUES ('NOW'::abstime,'today'::abstime);

8.	SELECT * FROM test_time;

	===============================	Time Zones	===========================
	
9.	SELECT * FROM pg_timezone_names;

10.	SELECT * FROM  pg_timezone_abbrevs;

11.	ALTER TABLE test_time
	ADD COLUMN endstamp TIMESTAMP WITH TIME ZONE;

12.	ALTER TABLE test_time
	ADD COLUMN endtime TIME WITH TIME ZONE;


13.	INSERT INTO test_time
	(endstamp,endtime)
	VALUES ('01/20/2018 10:30:00 US/Pacific', '10:30:00+5');
	INSERT INTO test_time (endstamp,endtime)
	VALUES ('06/20/2018 10:30:00 US/Pacific', '10:30:00+5');

//Notice the difference in offset due to daylight savings time
14.	SELECT * FROM test_time;


15.	SHOW TIME ZONE;
//notice the offset of time
16.	SELECT * FROM test_time;

17.	SET TIME ZONE 'US/Pacific'

//notice offset changed
18.	SELECT * FROM test_time;
	
	========================	Interval Data TYPE	=====================
	
19.	ALTER TABLE test_time
	ADD COLUMN span interval;

20.	DELETE  FROM test_time;

--Postgres Format
21.	INSERT INTO test_time (span)
	VALUES ('5 DECADES 3 YEARS, 6 MONTHS 3 DAYS');
22.	INSERT INTO test_time (span)
	VALUES ('5 DECADES 3 YEARS, 6 MONTHS 3 DAYS ago');

23.	SELECT * FROM test_time;

--SQL Standard
24.	INSERT INTO test_time (span)
	VALUES ('4 32:12:10');

25.	INSERT INTO test_time (span)
	VALUES ('1-2');

--ISO 8061 Format
26.	INSERT INTO test_time (span)
	VALUES (‘P5Y3MT7H3M’)

27.	INSERT INTO test_time (span)
	VALUES ('P25-2-30T17:33:10');

28.	SHOW intervalstyle;
29.	SELECT * FROM test_time;

30.	SET intervalstyle='postgres_verbose';
31.	SELECT * FROM test_time;

32.	SET intervalstyle='sql_standard';
33.	SELECT * FROM test_time;

34.	SET intervalstyle='iso_8601';
35.	SELECT * FROM test_time;

36.	SET intervalstyle='postgres';

	====================	Data Arithmetics	=========================
	
37.	SELECT DATE '2018-09-28' + INTERVAL '5 days 1 hour';

38.	SELECT TIME '5:30:10' + INTERVAL '70 minutes 80 seconds';

39.	SELECT TIMESTAMP '1917-06-20 12:30:10.222' +
	INTERVAL '30 years 6 months 7 days 3 hours 17 minutes 3 seconds';

40.	SELECT INTERVAL '5 hours 30 minutes 2 seconds' +
      INTERVAL '5 days 3 hours 13 minutes';

41.	SELECT DATE '2017-04-05' +  INTEGER '7';

-- subtracting intervals from date,time, timestamp
42.	SELECT DATE '2018-10-20' - INTERVAL '2 months 5 days';

43	SELECT TIME '23:39:17' - INTERVAL '12 hours 7 minutes 3 seconds'

44.	SELECT TIMESTAMP '2016-12-30' - INTERVAL '27 years 3 months 17 days 3 hours 37 minutes';

-- subtracting integer from date
45.	SELECT DATE '2016-12-30' - INTEGER '300';

--subtracting 2 dates
46.	SELECT DATE '2016-12-30' - DATE '2009-04-7';

-- subtracting 2 times and 2 timestamps
47.	SELECT TIME '17:54:01' - TIME '03:23:45';

48.	SELECT TIMESTAMP '2001-02-15 12:00:00' - TIMESTAMP '1655-08-30 21:33:05';

--Multiply and divide intervals
49.	SELECT 5 * INTERVAL '7 hours 5 minutes';

50.	SELECT INTERVAL '30 days 20 minutes' / 2;

51.	SELECT age(TIMESTAMP '2025-10-03', TIMESTAMP '1999-10-03');
52.	SELECT age (TIMESTAMP '1969-04-20');
	
	==========================	Pulling out date and TIME	===================
	
53.	SELECT EXTRACT(YEAR FROM age(birthdate)),firstname, lastname
	FROM employees;

54.	SELECT date_part('day', shippeddate)
	FROM orders;

55.	SELECT EXTRACT(DECADE FROM age(birthdate)),firstname, lastname
	FROM employees;

56.	SELECT date_part('DECADE',age(birthdate)),firstname, lastname
	FROM employees;
	
	
	==================	Converting One Datatype into another	=====================
	
57.	SELECT hiredate::TIMESTAMP
	FROM employees;

58.	SELECT CAST(hiredate AS TIMESTAMP)
	FROM employees;

59.	SELECT (ceil(unitprice*quantity))::TEXT || ' dollars spent'
	FROM order_details;

60.	SELECT CAST('2015-10-03' AS DATE),  375::TEXT;
	