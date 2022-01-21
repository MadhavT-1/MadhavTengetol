======================	Basic Import/Export with copy	===================
1	psql --port=5432 --host=localhost --dbname=northwind --username=postgres

COPY customers TO 'D:\customers.txt';



COPY customers TO 'D:\customers.csv'
WITH (HEADER, QUOTE '"');

COPY customers TO 'D:\customers.csv'
WITH (FORMAT CSV, HEADER, QUOTE '"',
FORCE_QUOTE (companyname, contactname,contacttitle, address, city, region, country));


COPY (SELECT * FROM orders WHERE orderdate BETWEEN '1996-01-01' AND '1996-12-31')
TO 'D:\orders1996.csv' WITH (FORMAT CSV, HEADER);

COPY (SELECT * FROM order_details WHERE productid=11)
TO 'D:\queso_order_details.csv' WITH (FORMAT CSV, HEADER);


=======================	Dump and Restore	=================

pg_dump --port=5432 --username=postgres --host=localhost   > northwind.sql

createdb  --port=5432 --host=localhost  --username=postgres northwind_bak

psql --port=5432 --host=localhost  --username=postgres northwind_bak <  northwind.sql



pg_dump --port=5432 --username=postgres --host=localhost  > usda.sql

createdb  --port=5432 --host=localhost  --username=postgres usda_bak 

psql --port=5432 --host=localhost  --username=postgres usda_bak <  usda_bak.sql


========================	Custom Format Dump	====================
pg_dump -Fc --port=5432 --host=localhost --username=postgres northwind > northwind.fc



pg_restore -j 4  --port=5432 --host=localhost --username=postgres -d northwind_bak northwind.fc

pg_restore -j 4  --port=5432 --host=localhost --username=postgres -d -d northwind_bak -t usstates northwind.fc


pg_dump -Fc  --port=5432 --host=localhost --username=postgre usda > usda.fc

pg_restore -j 4   --port=5432 --host=localhost --username=postgres -d usda -t weight  usda.fc
