psql --port=5432 --host=localhost --dbname=northwind --username=postgres

//psql -p 5432 -h localhost -d northwind -U postgres

SELECT * FROM orders;


-- to exit the program
\q


//############################///
export PGHOST=localhost
export PGPORT=5432
export PGUSER=postgres
export PGPASSWORD=root
export PGDATABASE=northwind

--this is the .pgpass format
localhost:5432:northwind:postgres:root

--this is the .pg_service.conf format
[myservice]
host=localhost
port=5432
dbname=northwind
user=postgres
password=root

#####################################

\\ to list databases

\l

\\to connect to a database

\c AdventureWorks 

############List all schemes of the currently connected database	
\dn
##################List available tables
\dt sales.*

