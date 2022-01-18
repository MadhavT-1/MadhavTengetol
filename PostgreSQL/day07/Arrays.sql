===================	Declaring Arrays	======================
1.	DROP TABLE IF EXISTS friends;


2.	CREATE TABLE friends (
    name full_name,
    address address,
    specialdates dates_to_remember,
    children varchar(50) ARRAY
	);

3.	DROP TABLE IF EXISTS salary_employees;

4.	CREATE TABlE salary_employees (
    name text,
    pay_by_quarter integer[4],
	schedule text[][]
)

=============================	Inputting Array VALUES	==================

5.	INSERT INTO friends (name, address, specialdates, children)
	VALUES (ROW('Boyd','M','Gregory'),
		ROW('7777','','Boise','Idaho','USA','99999'),
		ROW('1969-02-01',49,'2001-07-15'),
	   '{"Austin","Ana Grace"}');

6.	INSERT INTO friends (name, address, specialdates, children)
	VALUES (ROW('Scott','X','Levy'),
 		ROW('357 Page Road','','Austin','TX','USA','88888'),
 		ROW('1972-03-01',46,'2002-01-30'),
 		   ARRAY['Ben','Jill']);

7.	INSERT INTO salary_employees (name,pay_by_quarter,schedule)
	VALUES ('Bill',
		 		'{20000, 20000, 20000, 20000}',
				'{{"meeting", "training"},{"lunch", "sales call"}}')

8.	INSERT INTO salary_employees (name,pay_by_quarter,schedule)
	VALUES ('Bill',
		 ARRAY[20000, 20000, 20000, 20000],
		 ARRAY[['meeting', 'training'],['lunch', 'sales call']])

	===========================	Accessing Arrays	=========================
	
9.	SELECT children[2]
	FROM friends;

10.	SELECT pay_by_quarter[2:3]
	FROM salary_employees;

11.	SELECT array_dims(schedule)
	FROM salary_employees;

12.	SELECT array_length(schedule,1),array_length(schedule,2)
	FROM salary_employees;
	
	==============================	Modifing ARRAY	============================
	
13.	UPDATE friends
	SET children=ARRAY['Maddie','Timmy','Cheryl']
	WHERE (name).first_name = 'Boyd';

14.	SELECT children
	FROM friends
	WHERE (name).first_name = 'Boyd'
	LIMIT 1;

15.	UPDATE friends
	SET children[2]='Ricky'
	WHERE (name).first_name = 'Boyd';

16.	SELECT children
	FROM friends
	WHERE (name).first_name = 'Boyd'
	LIMIT 1;

17.	UPDATE friends
	SET children[2:3]=ARRAY['Suzy','Billy']
	WHERE (name).first_name = 'Boyd';

18.	SELECT children
	FROM friends
	WHERE (name).first_name = 'Boyd'
	LIMIT 1;

19.	UPDATE salary_employees
	SET pay_by_quarter=ARRAY[22000,25000,27000,22000]
	WHERE name='Bill';

20.	SELECT pay_by_quarter
	FROM salary_employees
	WHERE name='Bill';

21.	UPDATE salary_employees
	SET pay_by_quarter[4]=26000
	WHERE name='Bill';

22.	SELECT pay_by_quarter
	FROM salary_employees
	WHERE name='Bill';

23.	UPDATE salary_employees
	SET pay_by_quarter[2:3]=ARRAY[24000,25000]
	WHERE name='Bill';

24.	SELECT pay_by_quarter
	FROM salary_employees
	WHERE name='Bill';
	
	=======================	Searching ARRAY	====================================
	
25.	SELECT *
	FROM friends
	WHERE children[0] = 'Billy' OR children[1] = 'Billy'
	OR children[2]='Billy' OR children[3]='Billy';

26.	SELECT *
	FROM friends
	WHERE 'Austin' = ANY (children)

27.	SELECT *
	FROM salary_employees
	WHERE 'sales call' = ANY (schedule);
	
	==========================	Array Operators	=========================
	
	-- equal
28.	SELECT ARRAY[1, 2, 3, 4] = ARRAY[1, 2, 3, 4];

-- not equal, the elements are not in same order
29.	SELECT ARRAY[1, 2, 4, 3] = ARRAY[1, 2, 3, 4];

-- true
30.	SELECT ARRAY[1, 2, 4, 3] > ARRAY[1, 2, 3, 4];

-- false
31.	SELECT ARRAY[1, 2, 3, 4] > ARRAY[1, 2, 3, 4];

-- false 3 smaller than 4, doesn't look at 5 greater than 4
32.	SELECT ARRAY[1, 2, 3, 5] > ARRAY[1, 2, 4, 4];

-- true
33.	SELECT ARRAY[1, 2, 3, 5] @> ARRAY[2, 5];

-- false
34.	SELECT ARRAY[1, 2, 3, 5] @> ARRAY[2, 5, 7];

-- true
35.	SELECT ARRAY[1, 2] <@ ARRAY[2, 5, 7, 1];

-- true
36.	SELECT ARRAY[1, 2, 13, 17] && ARRAY[2, 5, 7, 1];

--false
37.	SELECT ARRAY[ 13, 17] && ARRAY[2, 5, 7, 1];

38.	SELECT *
	FROM friends
	WHERE children && ARRAY['Billy'::varchar(50)];

39.	SELECT *
	FROM salary_employees
	WHERE schedule && ARRAY['sales call'];
	