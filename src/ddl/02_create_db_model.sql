USE DATABASE openflights
GO
CREATE TABLE flights.airlines 
(
	%DESCRIPTION 'Contains information obout airlines. Data Source: https://openflights.org/data.html',
	id      INT NOT NULL %DESCRIPTION 'OpenFlights identifier for this airline',
	name     VARCHAR(255) %DESCRIPTION 'Name of the airline',
	alias    VARCHAR(255) %DESCRIPTION 'Alias of the airline. For example, All Nippon Airways is commonly known as ANA',
	iata     VARCHAR(2)   %DESCRIPTION '2-letter IATA code, if available', 
	icao     VARCHAR(3)   %DESCRIPTION '3-letter ICAO code, if available',
	callsign VARCHAR(255) %DESCRIPTION 'Airline callsign',
	country  VARCHAR(255) %DESCRIPTION 'Country or territory where airport is located. See Countries to cross-reference to ISO 3166-1 codes',
	active   CHAR(1) default 'N' %DESCRIPTION 'Y if the airline is or has until recently been operational, N if it is defunct. This field is not reliable: in particular, major airlines that stopped flying long ago, but have not had their IATA code reassigned (eg. Ansett/AN), will incorrectly show as Y',   
	CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/opt/irisbuild/data/airlines.dat' 
COLUMNS 
(
	id      INT,
	name     VARCHAR(255),
	alias    VARCHAR(255),
	iata     VARCHAR(2),
	icao     VARCHAR(3),
	callsign VARCHAR(255),
	country  VARCHAR(255),
	active   CHAR(1)
)
INTO flights.airlines
(
	id,
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
	id,
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
CREATE TABLE flights.airport_freq 
(
  %DESCRIPTION 'Each row in this table represents a single airport radio frequency for voice communication (radio navigation aids appear in table navaids). The column airport_ident is a foreign key referencing the ident column in table airports for the associated airport. Data Source: https://ourairports.com/help/data-dictionary.html',
  id int NOT NULL  					%DESCRIPTION 'Internal OurAirports integer identifier for the frequency. This will stay persistent, even if the radio frequency or description changes',
  airport_id int NOT NULL 			%DESCRIPTION 'Internal integer foreign key matching the id column for the associated airport in airports (airport_ident is a better alternative.)',
  airport_ident varchar(8) NOT NULL %DESCRIPTION 'Externally-visible string foreign key matching the ident column for the associated airport in airports',
  type varchar(25) NOT NULL 		%DESCRIPTION 'A code for the frequency type. This isnt (currently) a controlled vocabulary, but probably will be soon. Some common values are "TWR" (tower), "ATF" or "CTAF" (common traffic frequency), "GND" (ground control), "RMP" (ramp control), "ATIS" (automated weather), "RCO" (remote radio outlet), "ARR" (arrivals), "DEP" (departures), "UNICOM" (monitored ground station), and "RDO" (a flight-service station).',
  description varchar(255) NOT NULL	%DESCRIPTION 'A description of the frequency, typically the way a pilot would open a call on it',
  frequency_mhz DOUBLE  NOT NULL 	%DESCRIPTION 'Radio voice frequency in megahertz. Note that the same frequency may appear multiple times for an airport, serving different functions.',
  CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/opt/irisbuild/data/airport_freq.csv' 
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
CREATE TABLE flights.airports 
(
	%DESCRIPTION 'airports spanning the globe. Data Source: https://ourairports.com/help/data-dictionary.html',
	id 					INT NOT NULL 				%DESCRIPTION 'Internal OurAirports integer identifier for the airport. This will stay persistent, even if the airport code changes',
	ident 				VARCHAR(8) NOT NULL UNIQUE  %DESCRIPTION 'The text identifier used in the OurAirports URL. This will be the ICAO code if available. Otherwise, it will be a local airport code (if no conflict), or if nothing else is available, an internally-generated code starting with the ISO2 country code, followed by a dash and a four-digit number',
	type 				VARCHAR(25) NOT NULL		%DESCRIPTION 'The type of the airport. Allowed values are closed_airport, heliport, large_airport, medium_airport, seaplane_base, and small_airport. See the map legend for a definition of each type',
	name 				VARCHAR(255)        		%DESCRIPTION 'The official airport name, including Airport, Airstrip, etc',
	latitude_deg 		DOUBLE              		%DESCRIPTION 'The airport latitude in decimal degrees (positive for north)',
	longitude_deg 		DOUBLE              		%DESCRIPTION 'The airport longitude in decimal degrees (positive for east)',
	elevation_ft 		INT                 		%DESCRIPTION 'The airport elevation MSL in feet (not metres)',
	continent 			VARCHAR(2)          		%DESCRIPTION 'The code for the continent where the airport is (primarily) located. Allowed values are AF (Africa), AN (Antarctica), AS (Asia), EU (Europe), NA (North America), OC (Oceania), or SA (South America)',
	iso_country 		VARCHAR(2)          		%DESCRIPTION 'The two-character ISO 3166:1-alpha2 code for the country where the airport is (primarily) located. A handful of unofficial, non-ISO codes are also in use, such as "XK" for Kosovo',
	iso_region 			VARCHAR(255)        		%DESCRIPTION 'An alphanumeric code for the high-level administrative subdivision of a country where the airport is primarily located (e.g. province, governorate), prefixed by the ISO2 country code and a hyphen. OurAirports uses ISO 3166:2 codes whenever possible, preferring higher administrative levels, but also includes some custom codes. See the documentation for regions.csv.',
	municipality 		VARCHAR(255)        		%DESCRIPTION 'The primary municipality that the airport serves (when available). Note that this is not necessarily the municipality where the airport is physically located.',
	scheduled_service 	BIT                 		%DESCRIPTION '"yes" if the airport currently has scheduled airline service; "no" otherwise',
	gps_code       		VARCHAR(4)          		%DESCRIPTION 'The code that an aviation GPS database (such as Jeppesens or Garmins) would normally use for the airport. This will always be the ICAO code if one exists. Note that, unlike the ident column, this is not guaranteed to be globally unique',
	iata_code      		VARCHAR(3)          		%DESCRIPTION 'The three-letter IATA code for the airport (if it has one)',
	local_code     		VARCHAR(255)        		%DESCRIPTION 'The local country code for the airport, if different from the gps_code and iata_code fields (used mainly for US airports)',
	home_link      		VARCHAR(255)        		%DESCRIPTION 'URL of the airports official home page on the web, if one exists',
	wikipedia_link 		VARCHAR(1024)       		%DESCRIPTION 'URL of the airports page on Wikipedia, if one exists',
	keywords       		VARCHAR(1024)       		%DESCRIPTION 'Extra keywords/phrases to assist with search, comma-separated. May include former names for the airport, alternate codes, names in other languages, nearby tourist destinations, etc. ',
	CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/opt/irisbuild/data/airports.csv' 
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
CREATE TABLE flights.countries 
(
	%DESCRIPTION 'Each row represents a country or country-like entity (e.g. Hong Kong). The iso_country column in airports, navaids, and regions refer to the code column here. Data Source: https://ourairports.com/help/data-dictionary.html',
	id 				INT NOT NULL 			%DESCRIPTION 'Internal OurAirports integer identifier for the country. This will stay persistent, even if the country name or code changes.',
	code 			CHAR(2) NOT NULL 		%DESCRIPTION 'The two-character ISO 3166:1-alpha2 code for the country. A handful of unofficial, non-ISO codes are also in use, such as "XK" for Kosovo. The iso_country field in airports.csv points into this column.',
	name 			VARCHAR(255) NOT NULL 	%DESCRIPTION 'The common English-language name for the country. Other variations of the name may appear in the keywords field to assist with search.',
	continent 		CHAR(2)  NOT NULL 		%DESCRIPTION 'The code for the continent where the country is (primarily) located. See the continent code in airports for allowed values. ',
	wikipedia_link 	VARCHAR(1024)			%DESCRIPTION 'Link to the Wikipedia article about the country.',
	keywords 		VARCHAR(1024) 			%DESCRIPTION 'A comma-separated list of search keywords/phrases related to the country.',
	CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/opt/irisbuild/data/countries.csv' 
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
CREATE TABLE flights.navaids 
(
	  %DESCRIPTION 'Each row table represents a single radio navigation. When the navaid is associated with an airport, the associated_airport field links to the ident field in airports. Data Source: https://ourairports.com/help/data-dictionary.html',
	  id            			INT NOT NULL 	%DESCRIPTION 'Internal OurAirports integer identifier for the navaid. This will stay persistent, even if the navaid identifier or frequency changes',
	  filename      			VARCHAR(255) 	%DESCRIPTION 'This is a unique string identifier constructed from the navaid name and country, and used in the OurAirports URL',
	  ident         			VARCHAR(255) 	%DESCRIPTION 'The 1-3 character identifer that the navaid transmits',
	  name          			VARCHAR(255) 	%DESCRIPTION 'The name of the navaid, excluding its type.',
	  type          			VARCHAR(8) 		%DESCRIPTION 'The type of the navaid. Options are "DME", "NDB", "NDB-DME", "TACAN", "VOR", "VOR-DME", or "VORTAC". See the map legend for more information about each type',
	  frequency_khz 			INT 			%DESCRIPTION 'The frequency of the navaid in kilohertz. If the Navaid operates on the VHF band (VOR, VOR-DME) or operates on the UHF band with a paired VHF frequency (DME, TACAN, VORTAC), the you need to divide this number by 1,000 to get the frequency in megahertz (115.3 MHz in this example). For an NDB or NDB-DME, you can use this frequency directly. ',
	  latitude_deg  			DOUBLE 			%DESCRIPTION 'The latitude of the navaid in decimal degrees (negative for south). ',
	  longitude_deg 			DOUBLE 			%DESCRIPTION 'The longitude of the navaid in decimal degrees (negative for west). ',
	  location      			DOUBLE 			%DESCRIPTION '',
	  elevation_ft  			INT 			%DESCRIPTION 'The navaids elevation MSL in feet (not metres). ',
	  iso_country   			VARCHAR(2) 		%DESCRIPTION 'The two-character ISO 3166:1-alpha2 code for the country that operates the navaid. A handful of unofficial, non-ISO codes are also in use, such as "XK" for Kosovo',
	  dme_frequency_khz 		DOUBLE 			%DESCRIPTION 'The paired VHF frequency for the DME (or TACAN) in kilohertz. Divide by 1,000 to get the paired VHF frequency in megahertz (e.g. 115.3 MHz).',
	  dme_channel   			VARCHAR(255) 	%DESCRIPTION 'The DME channel (an alternative way of tuning distance-measuring equipment)',
	  dme_latitude_deg 			DOUBLE 			%DESCRIPTION 'The latitude of the associated DME in decimal degrees (negative for south). If missing, assume that the value is the same as latitude_deg. ',
	  dme_longitude_deg 		DOUBLE 			%DESCRIPTION 'The longitude of the associated DME in decimal degrees (negative for west). If missing, assume that the value is the same as longitude_deg',
	  dme_elevation_ft 			INT 			%DESCRIPTION 'The associated DME transmitters elevation MSL in feet. If missing, assume that its the same value as elevation_ft.',
	  slaved_variation_deg 		DOUBLE 			%DESCRIPTION 'The magnetic variation adjustment built into a VORs, VOR-DMEs, or TACANs radials. Positive means east (added to the true direction), and negative means west (subtracted from the true direction). This will not usually be the same as magnetic-variation because the magnetic pole is constantly in motion.',
	  magnetic_variation_deg 	DOUBLE 			%DESCRIPTION 'The actual magnetic variation at the navaids location. Positive means east (added to the true direction), and negative means west (subtracted from the true direction).',
	  usagetype     			VARCHAR(8)		%DESCRIPTION 'The primary function of the navaid in the airspace system. Options include "HI" (high-altitude airways, at or above flight level 180), "LO" (low-altitude airways), "BOTH" (high- and low-altitude airways), "TERM" (terminal-area navigation only), and "RNAV" (non-GPS area navigation)',
	  power         			VARCHAR(8)		%DESCRIPTION 'The power-output level of the navaid. Options include "HIGH", "MEDIUM", "LOW", and "UNKNOWN".',
	  associated_airport 		VARCHAR(8)		%DESCRIPTION 'The OurAirports text identifier (usually the ICAO code) for an airport associated with the navaid. Links to the ident column in airports',
	  CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/opt/irisbuild/data/navaids.csv' 
INTO flights.navaids
(
	id,
	filename,
	ident,
	name,
	type,
	frequency_khz,
	latitude_deg,
	longitude_deg,
	elevation_ft,
	iso_country,
	dme_frequency_khz,
	dme_channel,
	dme_latitude_deg,
	dme_longitude_deg,
	dme_elevation_ft,
	slaved_variation_deg,
	magnetic_variation_deg,
	usageType,
	power,
	associated_airport
) 
VALUES 
(
	id,
	filename,
	ident,
	name,
	type,
	frequency_khz,
	latitude_deg,
	longitude_deg,
	elevation_ft,
	iso_country,
	dme_frequency_khz,
	dme_channel,
	dme_latitude_deg,
	dme_longitude_deg,
	dme_elevation_ft,
	slaved_variation_deg,
	magnetic_variation_deg,
	usageType,
	power,
	associated_airport
)
USING {"from": {"file": {"header":"1","columnseparator":","} }}
GO
CREATE TABLE flights.planes 
(
	%DESCRIPTION 'contains a curated selection of passenger aircraft with IATA and/or ICAO codes, covering the vast majority of flights operated today and commonly used in flight schedules and reservation systems. Data Source: https://openflights.org/data.html',
	name varchar(255) NOT NULL 	%DESCRIPTION 'Full name of the aircraft',
	iata varchar(3) 			%DESCRIPTION 'Unique three-letter IATA identifier for the aircraft',
	icao varchar(4) 			%DESCRIPTION 'Unique four-letter ICAO identifier for the aircraft',
	CONSTRAINT name_pk PRIMARY KEY (name)
)
GO
LOAD DATA FROM FILE '/opt/irisbuild/data/planes.dat' 
COLUMNS 
(
	name VARCHAR(255),
	iata VARCHAR(3),
	icao VARCHAR(4)
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
CREATE TABLE flights.regions 
(
  %DESCRIPTION 'Each row represents a high-level administrative subdivision of a country. The iso_region column in airports to the code column in this table. Data Source: https://ourairports.com/help/data-dictionary.html',
  id 				INT NOT NULL 				%DESCRIPTION 'Internal OurAirports integer identifier for the region. This will stay persistent, even if the region code changes.',
  code 				VARCHAR(8) NOT NULL UNIQUE 	%DESCRIPTION 'local_code prefixed with the country code to make a globally-unique identifier. ',
  local_code 		VARCHAR(4) NOT NULL 		%DESCRIPTION 'The local code for the administrative subdivision. Whenever possible, these are official ISO 3166:2, at the highest level available, but in some cases OurAirports has to use unofficial codes. There is also a pseudo code "U-A" for each country, which means that the airport has not yet been assigned to a region (or perhaps cant be, as in the case of a deep-sea oil platform).',
  name 				VARCHAR(255) NOT NULL 		%DESCRIPTION 'The common English-language name for the administrative subdivision. In some cases, the name in local languages will appear in the keywords field assist search.',
  continent 		CHAR(2) NOT NULL 			%DESCRIPTION 'A code for the continent to which the region belongs. See the continent field in airports for a list of codes.',
  iso_country 		CHAR(2) NOT NULL 			%DESCRIPTION 'The two-character ISO 3166:1-alpha2 code for the country containing the administrative subdivision. A handful of unofficial, non-ISO codes are also in use, such as "XK" for Kosovo.',
  wikipedia_link 	VARCHAR(1024) 				%DESCRIPTION 'A link to the Wikipedia article describing the subdivision',
  keywords 			VARCHAR(1024) 				%DESCRIPTION 'A comma-separated list of keywords to assist with search. May include former names for the region, and/or the region name in other languages.',
  CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/opt/irisbuild/data/regions.csv' 
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
CREATE TABLE flights.routes 
(
	%DESCRIPTION 'Contains routes between airports and airlines spanning the globe. Data Source: https://openflights.org/data.html',
	airline           CHAR(2) NOT NULL 	%DESCRIPTION '2-letter (IATA) or 3-letter (ICAO) code of the airline',
	airline_id        INT NOT NULL 		%DESCRIPTION 'Unique OpenFlights identifier for airline (see Table Airlines)',
	source_airport    CHAR(3) NOT NULL	%DESCRIPTION '3-letter (IATA) or 4-letter (ICAO) code of the source airport',
	source_airport_id INT NOT NULL 		%DESCRIPTION 'Unique OpenFlights identifier for source airport (see Table Airports)',
	dest_airport      CHAR(3) NOT NULL	%DESCRIPTION '3-letter (IATA) or 4-letter (ICAO) code of the destination airport',
	dest_airport_id   INT NOT NULL		%DESCRIPTION 'Unique OpenFlights identifier for destination airport (see Table Airports)',
	codeshare         VARCHAR(1) 		%DESCRIPTION 'Y if this flight is a codeshare (that is, not operated by Airline, but another carrier), empty otherwise.',
	stops             INT NOT NULL 		%DESCRIPTION 'Number of stops on this flight (0 for direct)',
	equipment         VARCHAR(255) 		%DESCRIPTION '3-letter codes for plane type(s) generally used on this flight, separated by spaces'
)
GO
LOAD DATA FROM FILE '/opt/irisbuild/data/routes.dat' 
COLUMNS 
(
  airline           CHAR(2),
  airline_id        INT,
  source_airport    CHAR(3),
  source_airport_id INT,
  dest_airport      CHAR(3),
  dest_airport_id   INT,
  codeshare         VARCHAR(1),
  stops             INT,
  equipment         VARCHAR(255)
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
GO
CREATE TABLE flights.runways 
(
	%DESCRIPTION 'Each row in this dataset represents a single airport landing surface (runway, helipad, or waterway). The initial fields apply to the entire surface, in both directions. Fields beginning with le_* apply only to the low-numbered end of the runway (e.g. 09), while fields beginning with he_* apply only to the high-numbered end of the runway (e.g. 27). Data Source: https://ourairports.com/help/data-dictionary.html',
	id            				INT NOT NULL 		%DESCRIPTION 'Internal OurAirports integer identifier for the runway. This will stay persistent, even if the runway numbering changes',
	airport_id    				INT NOT NULL 		%DESCRIPTION 'Internal integer foreign key matching the id column for the associated airport in airports.csv. (airport_ident is a better alternative.)',
	airport_ident 				VARCHAR(8) NOT NULL %DESCRIPTION 'Externally-visible string foreign key matching the ident column for the associated airport in airports',
	length_ft     				INT 				%DESCRIPTION 'Length of the full runway surface (including displaced thresholds, overrun areas, etc) in feet.',
	width_ft      				INT 				%DESCRIPTION 'Width of the runway surface in feet.',
	surface       				VARCHAR(255)  		%DESCRIPTION 'Code for the runway surface type. This is not yet a controlled vocabulary, but probably will be soon. Some common values include "ASP" (asphalt), "TURF" (turf), "CON" (concrete), "GRS" (grass), "GRE" (gravel), "WATER" (water), and "UNK" (unknown).',
	lighted       				BIT 				%DESCRIPTION '1 if the surface is lighted at night, 0 otherwise. (Note that this is inconsistent with airports.csv, which uses "yes" and "no" instead of 1 and 0.) ',
	closed        				BIT 				%DESCRIPTION '1 if the runway surface is currently closed, 0 otherwise',
	le_ident      				VARCHAR(6) 			%DESCRIPTION 'Identifier for the low-numbered end of the runway.',
	le_latitude_deg 			DOUBLE 				%DESCRIPTION 'Latitude of the centre of the low-numbered end of the runway, in decimal degrees (positive is north), if available. ',
	le_longitude_deg 			DOUBLE 				%DESCRIPTION 'Longitude of the centre of the low-numbered end of the runway, in decimal degrees (positive is east), if available. ',
	le_location   				DOUBLE 				%DESCRIPTION '',
	le_elevation_ft 			INT 				%DESCRIPTION 'Elevation above MSL of the low-numbered end of the runway in feet.',
	le_heading_degt 			DOUBLE 				%DESCRIPTION 'Heading of the low-numbered end of the runway in degrees true (not magnetic).',
	le_displaced_threshold_ft 	INT 				%DESCRIPTION 'Length of the displaced threshold (if any) for the low-numbered end of the runway, in feet.',
	he_ident      				VARCHAR(6) 			%DESCRIPTION 'Identifier for the high-numbered end of the runway.',
	he_latitude_deg 			DOUBLE 				%DESCRIPTION 'Latitude of the centre of the high-numbered end of the runway, in decimal degrees (positive is north), if available.',
	he_longitude_deg 			DOUBLE 				%DESCRIPTION 'Longitude of the centre of the high-numbered end of the runway, in decimal degrees (positive is east), if available',
	he_location   				DOUBLE 				%DESCRIPTION '',
	he_elevation_ft 			INT 				%DESCRIPTION 'Longitude of the centre of the high-numbered end of the runway, in decimal degrees (positive is east), if available',
	he_heading_degt 			DOUBLE 				%DESCRIPTION 'Heading of the high-numbered end of the runway in degrees true (not magnetic)',
	he_displaced_threshold_ft 	INT 				%DESCRIPTION 'Length of the displaced threshold (if any) for the high-numbered end of the runway, in feet',
	CONSTRAINT id_pk PRIMARY KEY (id)
)
GO
LOAD DATA FROM FILE '/opt/irisbuild/data/runways.csv' 
INTO flights.runways
(
	id,
	airport_id,
	airport_ident,
	length_ft,
	width_ft,
	surface,
	lighted,
	closed,
	le_ident,
	le_latitude_deg,
	le_longitude_deg,
	le_elevation_ft,
	le_heading_degT,
	le_displaced_threshold_ft,
	he_ident,
	he_latitude_deg,
	he_longitude_deg,
	he_elevation_ft,
	he_heading_degT,
	he_displaced_threshold_ft
) 
VALUES 
(
	id,
	airport_ref,
	airport_ident,
	length_ft,
	width_ft,
	surface,
	lighted,
	closed,
	le_ident,
	le_latitude_deg,
	le_longitude_deg,
	le_elevation_ft,
	le_heading_degT,
	le_displaced_threshold_ft,
	he_ident,
	he_latitude_deg,
	he_longitude_deg,
	he_elevation_ft,
	he_heading_degT,
	he_displaced_threshold_ft
)
USING {"from": {"file": {"header":"1","columnseparator":","} }}
GO