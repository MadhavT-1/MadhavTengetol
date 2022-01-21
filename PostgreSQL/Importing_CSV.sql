=========================	Importing CSV Files	==========================

1	CREATE DATABASE airport;

2	CREATE TABLE airports (
	id int NOT NULL,
	ident varchar(10),
	type text,
	name text,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	continent text,
	iso_country varchar(10),
	iso_region varchar(10),
	municipality text,
	scheduled_service text,
	gps_code varchar(10),
	iata_code varchar(20),
	local_code varchar(20),
	home_link text,
	wikipedia_link text,
	keywords text
	);

-- this won't work in pgAdmin
3	COPY airports (	id,ident,type,name,latitude_deg,longitude_deg,elevation_ft,
						continent,iso_country,iso_region,municipality,scheduled_service,
						gps_code,iata_code,local_code,home_link,wikipedia_link,keywords)
	FROM 'D:\trainignov21\week6(Database)\airport\airports.csv' DELIMITER ',' CSV HEADER;

-- must use pgsql
4	psql --port=5432 --host=localhost --dbname=airport --username=postgres


5	copy airports (	id,ident,type,name,latitude_deg,longitude_deg,elevation_ft,continent,
	iso_country,iso_region,municipality,scheduled_service,gps_code,iata_code,
	local_code,home_link,wikipedia_link,keywords)
	FROM 'D:\trainignov21\week6(Database)\airport\airports.csv' DELIMITER ',' CSV HEADER;



6	CREATE TABLE airport_frequencies (
	id int,
	airport_ref int,
	airport_ident varchar(10),
	type varchar(20),
	description text,
	frequency_mhz float
	)

7	copy airport_frequencies (	id,airport_ref,airport_ident,type,description,frequency_mhz)
	FROM 'D:\trainignov21\week6(Database)\airport\airport-frequencies.csv' DELIMITER ',' CSV HEADER;
	
8	CREATE TABLE navaids (
	id int,
	filename text,
	ident varchar(10),
	name text,
	type varchar(10),
	frequency_khz float,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	iso_country varchar(10),
	dme_frequency_khz float,
	dme_channel varchar(10),
	dme_latitude_deg float,
	dme_longitude_deg float,
	dme_elevation_ft int,
	slaved_variation_deg float,
	magnetic_variation_deg float,
	usageType char(10),
	power char(10),
	associated_airport varchar(10)
)

9	copy navaids (
	id,filename, ident, name, type, frequency_khz, latitude_deg,
	longitude_deg, elevation_ft, iso_country, dme_frequency_khz, dme_channel,
	dme_latitude_deg, dme_longitude_deg, dme_elevation_ft,
	slaved_variation_deg,magnetic_variation_deg, usageType, power, associated_airport)
	FROM 'D:\trainignov21\week6(Database)\airport\navaids.csv' DELIMITER ',' CSV HEADER;


10	CREATE TABLE regions (
	id int,
	code varchar(10),
	local_code varchar(10),
	name text,
	continent char(2),
	iso_country varchar(10),
	wikipedia_link text,
	keywords text
	)

11	copy regions (	
	id,code, local_code, name, continent, iso_country, wikipedia_link, keywords)
	FROM 'D:\trainignov21\week6(Database)\airport\regions.csv' DELIMITER ',' CSV HEADER;


12	CREATE TABLE countries (
	id int,
	code varchar(10),
	name text,
	continent char(2),
	wikipedia_link text,
	keywords text
	)	

13	copy countries ( id,code, name, continent, wikipedia_link, keywords) 
	FROM 'D:\trainignov21\week6(Database)\airport\countries.csv' DELIMITER ',' CSV HEADER;


14	CREATE TABLE runways (
	id int,
	airport_ref int,
	airport_ident varchar(10),
	length_ft int,
	width_ft int,
	surface text,
	lighted boolean,
	closed boolean,
	le_ident varchar(10),
	le_latitude_deg float,
	le_longitude_deg float,
	le_elevation_ft int,
	le_heading_degT float,
	le_displaced_threshold_ft int,
	he_ident varchar(10),
	he_latitude_deg float,
	he_longitude_deg float,
	he_elevation_ft int,
	he_heading_degT float,
	he_displaced_threshold_ft int
	)

15	copy runways ( id,airport_ref, airport_ident, length_ft, width_ft,
			  surface, lighted, closed ,le_ident, le_latitude_deg, le_longitude_deg, 
			  le_elevation_ft, le_heading_degT, le_displaced_threshold_ft, he_ident,
			  he_latitude_deg, he_longitude_deg, he_elevation_ft, he_heading_degT, he_displaced_threshold_ft)
			  FROM 'D:\trainignov21\week6(Database)\airport\runways.csv' DELIMITER ',' CSV HEADER;
