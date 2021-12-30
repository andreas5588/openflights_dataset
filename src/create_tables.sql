
--https://docs.intersystems.com/iris20212/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_loaddata

CREATE DATABASE openflights
GO
USE DATABASE openflights
GO
/*
Airline ID 	Unique OpenFlights identifier for this airline.
Name 		Name of the airline.
Alias 		Alias of the airline. For example, All Nippon Airways is commonly known as "ANA".
IATA 		2-letter IATA code, if available.
ICAO 		3-letter ICAO code, if available.
Callsign 		Airline callsign.
Country 		Country or territory where airport is located. See Countries to cross-reference to ISO 3166-1 codes.
Active 		"Y" if the airline is or has until recently been operational, "N" if it is defunct. This field is not reliable: in particular, major airlines that stopped flying long ago, but have not had their IATA code reassigned (eg. Ansett/AN), will incorrectly show as "Y".
*/
DROP TABLE flights.airlines 
GO
CREATE TABLE flights.airlines 
(
  uid      int NOT NULL,
  name     varchar(255),
  alias    varchar(255),
  iata     varchar(2) default NULL,
  icao     varchar(3) default NULL,
  callsign varchar(255),
  country  varchar(255),
  active   char(1) default 'N',   
  CONSTRAINT uid_pk PRIMARY KEY (uid)
)
LOAD DATA FROM FILE '/usr/airlines.dat' 
COLUMNS 
(
  uid      int,
  name     varchar(255),
  alias    varchar(255),
  iata     varchar(2),
  icao     varchar(3),
  callsign varchar(255),
  country  varchar(255),
  active   char(1)
)
INTO flights.airlines
(
  uid,
  name,
  alias,
  iata,
  icao,
  callsign,
  country,
  active
) 
VALUES 
(
  uid,
  name,
  alias,
  iata,
  icao,
  callsign,
  country,
  active
)
USING {"from": {"file": {"header":"0","columnseparator":","} }}
GO
DROP TABLE flights.airports 
GO
CREATE TABLE flights.airports 
(
  id int NOT NULL,
  ident varchar(8) NOT NULL UNIQUE ,
  type varchar(25) NOT NULL,
  name varchar(255),
  latitude_deg DOUBLE,
  longitude_deg DOUBLE,
  elevation_ft int,
  continent varchar(2),
  iso_country varchar(2),
  iso_region varchar(255),
  municipality varchar(255),
  scheduled_service bit,
  gps_code varchar(4),
  iata_code varchar(3),
  local_code varchar(255),
  home_link varchar(255),
  wikipedia_link varchar(1024),
  keywords varchar(1024),
  CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/usr/airports.csv' 
INTO flights.airports
(
  id,
  ident,
  type,
  name,
  latitude_deg,
  longitude_deg,
  elevation_ft,
  continent,
  iso_country,
  iso_region,
  municipality,
  scheduled_service,
  gps_code,
  iata_code,
  local_code,
  home_link,
  wikipedia_link,
  keywords
) 
VALUES 
(
  id,
  ident,
  type,
  name,
  latitude_deg,
  longitude_deg,
  elevation_ft,
  continent,
  iso_country,
  iso_region,
  municipality,
  scheduled_service,
  gps_code,
  iata_code,
  local_code,
  home_link,
  wikipedia_link,
  keywords
)
USING {"from": {"file": {"header":"1","columnseparator":","} }}
GO

DROP TABLE flights.countries 
GO
CREATE TABLE flights.countries 
(
  id int NOT NULL,
  code char(2) NOT NULL,
  name varchar(255) NOT NULL,
  continent char(2)  NOT NULL,
  wikipedia_link varchar(1024),
  keywords varchar(1024),
  CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/usr/countries.csv' 
INTO flights.countries
(
  id,
  code,
  name,
  continent,
  wikipedia_link,
  keywords
) 
VALUES 
(
  id,
  code,
  name,
  continent,
  wikipedia_link,
  keywords
)
USING {"from": {"file": {"header":"1","columnseparator":","} }}
GO
DROP TABLE flights.airport_freq 
GO
CREATE TABLE flights.airport_freq 
(
  id int NOT NULL,
  airport_id int NOT NULL,
  airport_ident varchar(8) NOT NULL,
  type varchar(25) NOT NULL,
  description varchar(255) NOT NULL,
  frequency_mhz DOUBLE  NOT NULL,
  CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/usr/airport_freq.csv' 
INTO flights.airport_freq
(
  id,
  airport_id,
  airport_ident,
  type,
  description,
  frequency_mhz
) 
VALUES 
(
  id,
  airport_ref,
  airport_ident,
  type,
  description,
  frequency_mhz
)
USING {"from": {"file": {"header":"1","columnseparator":","} }}
GO
DROP TABLE flights.regions 
GO
CREATE TABLE flights.regions 
(
  id int NOT NULL,
  code varchar(8) NOT NULL,
  local_code varchar(4) NOT NULL,
  name varchar(255) NOT NULL,
  continent char(2) NOT NULL,
  iso_country char(2) NOT NULL,
  wikipedia_link varchar(1024),
  keywords varchar(1024),
  CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/usr/regions.csv' 
INTO flights.regions
(
  id,
  code,
  local_code,
  name,
  continent,
  iso_country,
  wikipedia_link,
  keywords
) 
VALUES 
(
  id,
  code,
  local_code,
  name,
  continent,
  iso_country,
  wikipedia_link,
  keywords
)
USING {"from": {"file": {"header":"1","columnseparator":","} }}
GO

DROP TABLE flights.runways
GO
CREATE TABLE flights.runways 
(
	id            INT NOT NULL,
	airport_id    INT NOT NULL,
	airport_ident VARCHAR(8) NOT NULL,
	length_ft     INT,
	width_ft      INT,
	surface       TEXT,
	lighted       BIT,
	closed        BIT,
	le_ident      VARCHAR(6),
	le_latitude_deg DOUBLE,
	le_longitude_deg DOUBLE,
	le_location   DOUBLE,
	le_elevation_ft INT,
	le_heading_degt DOUBLE,
	le_displaced_threshold_ft INT,
	he_ident      VARCHAR(6),
	he_latitude_deg DOUBLE,
	he_longitude_deg DOUBLE,
	he_location   DOUBLE,
	he_elevation_ft INT,
	he_heading_degt DOUBLE,
	he_displaced_threshold_ft INT,
	CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/usr/runways.csv' 
INTO flights.runways
	(
	id
	,airport_id
	,airport_ident
	,length_ft
	,width_ft
	,surface
	,lighted
	,closed
	,le_ident
	,le_latitude_deg
	,le_longitude_deg
	,le_elevation_ft
	,le_heading_degT
	,le_displaced_threshold_ft
	,he_ident
	,he_latitude_deg
	,he_longitude_deg
	,he_elevation_ft
	,he_heading_degT
	,he_displaced_threshold_ft
) 
VALUES 
(
	id
	,airport_ref
	,airport_ident
	,length_ft
	,width_ft
	,surface
	,lighted
	,closed
	,le_ident
	,le_latitude_deg
	,le_longitude_deg
	,le_elevation_ft
	,le_heading_degT
	,le_displaced_threshold_ft
	,he_ident
	,he_latitude_deg
	,he_longitude_deg
	,he_elevation_ft
	,he_heading_degT
	,he_displaced_threshold_ft
)
USING {"from": {"file": {"header":"1","columnseparator":","} }}
GO
DROP TABLE flights.navaids
GO
CREATE TABLE flights.navaids 
(
	  id            INT NOT NULL,
	  filename      varchar(255),
	  ident         varchar(255),
	  name          varchar(255),
	  TYPE          varchar(8),
	  frequency_khz INT,
	  latitude_deg  DOUBLE,
	  longitude_deg DOUBLE,
	  location      DOUBLE,
	  elevation_ft  INT,
	  iso_country   varchar(255),
	  dme_frequency_khz DOUBLE,
	  dme_channel   varchar(255),
	  dme_latitude_deg DOUBLE,
	  dme_longitude_deg DOUBLE,
	  dme_elevation_ft INT,
	  slaved_variation_deg DOUBLE,
	  magnetic_variation_deg DOUBLE,
	  usagetype     varchar(8),
	  POWER         varchar(8),
	  associated_airport VARCHAR(8),
	  CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/usr/navaids.csv' 
INTO flights.navaids
(
	 id
	,filename
	,ident
	,name
	,type
	,frequency_khz
	,latitude_deg
	,longitude_deg
	,elevation_ft
	,iso_country
	,dme_frequency_khz
	,dme_channel
	,dme_latitude_deg
	,dme_longitude_deg
	,dme_elevation_ft
	,slaved_variation_deg
	,magnetic_variation_deg
	,usageType
	,power
	,associated_airport
) 
VALUES 
(
	id
	,filename
	,ident
	,name
	,type
	,frequency_khz
	,latitude_deg
	,longitude_deg
	,elevation_ft
	,iso_country
	,dme_frequency_khz
	,dme_channel
	,dme_latitude_deg
	,dme_longitude_deg
	,dme_elevation_ft
	,slaved_variation_deg
	,magnetic_variation_deg
	,usageType
	,power
	,associated_airport
)
USING {"from": {"file": {"header":"1","columnseparator":","} }}
GO
/*
Name 		Full name of the aircraft.
IATA code 	Unique three-letter IATA identifier for the aircraft.
ICAO code 	Unique four-letter ICAO identifier for the aircraft.
*/
DROP TABLE flights.planes
GO
CREATE TABLE flights.planes 
(
  name varchar(255) NOT NULL,
  iata varchar(3)  NULL,
  icao varchar(4)  NULL,
  CONSTRAINT name_pk PRIMARY KEY (name)
)
GO
LOAD DATA FROM FILE '/usr/planes.dat' 
COLUMNS 
(
  name     varchar(255),
  iata     varchar(3),
  icao     varchar(4)
)
INTO flights.planes
(
  name,
  iata,
  icao
) 
VALUES 
(
  name,
  iata,
  icao
)
USING {"from": {"file": {"header":"0","columnseparator":","} }}
GO

/*
Airline 					2-letter (IATA) or 3-letter (ICAO) code of the airline.
Airline ID 				Unique OpenFlights identifier for airline (see Airline).
Source airport 			3-letter (IATA) or 4-letter (ICAO) code of the source airport.
Source airport ID 			Unique OpenFlights identifier for source airport (see Airport)
Destination airport 		3-letter (IATA) or 4-letter (ICAO) code of the destination airport.
Destination airport ID 	Unique OpenFlights identifier for destination airport (see Airport)
Codeshare 				"Y" if this flight is a codeshare (that is, not operated by Airline, but another carrier), empty otherwise.
Stops 					Number of stops on this flight ("0" for direct)
Equipment 				3-letter codes for plane type(s) generally used on this flight, separated by spaces
*/
DROP TABLE flights.routes
GO
CREATE TABLE flights.routes 
(
  airline           char(2) NOT NULL,
  airline_id        int NOT NULL,
  source_airport    char(3) NOT NULL,
  source_airport_id INT NOT NULL,
  dest_airport      char(3) NOT NULL,
  dest_airport_id   INT NOT NULL,
  codeshare         varchar(1) null,
  stops             int not null,
  equipment        varchar(255) null
)
GO
LOAD DATA FROM FILE '/usr/routes.dat' 
COLUMNS 
(
  airline           char(2),
  airline_id        int,
  source_airport    char(3),
  source_airport_id INT,
  dest_airport      char(3),
  dest_airport_id   INT,
  codeshare         varchar(1),
  stops             int,
  equipment        varchar(255)
)
INTO flights.routes
(
  airline,
  airline_id,
  source_airport,
  source_airport_id,
  dest_airport,
  dest_airport_id,
  codeshare,
  stops,
  equipment
) 
VALUES 
(
  airline,
  airline_id,
  source_airport,
  source_airport_id,
  dest_airport,
  dest_airport_id,
  codeshare,
  stops,
  equipment
)
USING {"from": {"file": {"header":"0","columnseparator":","} }}