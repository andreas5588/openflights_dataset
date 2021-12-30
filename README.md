# Openflights demo dataset
Openflights dataset, datamodel for InterSystems IRIS

You find here a flight datamodel for the Database InterSystems IRIS. This model is inspired by https://community.intersystems.com/post/technology-bonuses-intersystems-iris-datasets-contest-2021

## InterSystems IRIS - LOAD DATA 
To load the CSV files into the database the new LOAD DATA feature of IRIS Version 2021.2.0.617 (preview) is used. Details about the new SQL command canbe found here: https://docs.intersystems.com/iris20212/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_loaddata

## Contained data
Dataset formats: https://openflights.org/data.html#airline

* airlines.dat 
containing information on airlines

* routes.dat 
Route file contains routes between airports on airlines spanning the globe

* planes.dat 
The OpenFlights plane file contains a curated selection of 173 passenger aircraft with IATA and/or ICAO codes, covering the vast majority of flights operated today and commonly used in flight schedules and reservation systems.

Dataset formats: https://ourairports.com/help/data-dictionary.html

* airports.csv 
Each row in this dataset represents the record for a single airport. The primary key for interoperability purposes with other datasets is ident, but the actual internal OurAirports primary key is id. iso_region is a foreign key into the regions.csv download file. 

* airport_freq.csv 
Each row in this dataset represents a single airport radio frequency for voice communication (radio navigation aids appear in navaids.csv). The column airport_ident is a foreign key referencing the ident column in airports.csv for the associated airport. 
* countries.csv 
Each row represents a country or country-like entity (e.g. Hong Kong). The iso_country column in airports.csv, navaids.csv, and regions.csv refer to the code column here. 
* runways.csv 
Each row in this dataset represents a single airport landing surface (runway, helipad, or waterway). The initial fields apply to the entire surface, in both directions. Fields beginning with le_* apply only to the low-numbered end of the runway (e.g. 09), while fields beginning with he_* apply only to the high-numbered end of the runway (e.g. 27). 
* navaids.csv 
Each row in this dataset represents a single radio navigation. When the navaid is associated with an airport, the associated_airport field links to the ident field in airports.csv. 
* regions.csv 
Each row represents a high-level administrative subdivision of a country. The iso_region column in airports.csv links to the code column in this dataset. 

## State of loading

* :heavy_check_mark: airlines.dat (6.162 of 6.162 rows loaded)
* airport_freq.csv (28.074 of 28.969 rows loaded)
* :heavy_check_mark: airports.csv (69.197 of 69.197 rows loaded) 
* :heavy_check_mark: countries.csv (247 of 247 rows loaded)
* :heavy_check_mark: navaids.csv (11.020 of 11.020 rows loaded)
* :heavy_check_mark: planes.dat (246 of 246 rows loaded)
* :heavy_check_mark: regions.csv (3.964 of 3.964 rows loaded)
* routes.dat (66.392 of 67.663 rows loaded)
* runways.csv (42.929 of  rows 42.932 loaded)

## datamodel

FKs are not all set... stay tune

![all tables and row counts](/doc/datamodel.png)

## Installation

Iin order to prevent problems with the data encoding when loading, please make the following setting on the %Java Server: -Dfile.encoding=UTF-8
See the screenshots for details:
![%Java Server Settings](/doc/change_jvm_param_for_javaserver.png)
![%Java Server Param](/doc/change_jvm_param_for_javaserver_file_encoding.png)

## Data sources

* Airports http://ourairports.com/data/
* Routes http://openflights.org/data.html
* Airport total passengers
** http://www.aci.aero/
** http://en.wikipedia.org/wiki/List_of_the_world%27s_busiest_airports_by_passenger_traffic#2014_statistics


## repos
https://github.com/jpatokal/openflights
https://openflights.org/data.html#airline

## Docker
Some docker notes

docker cp <src-path> <container>:<dest-path> ... 
docker cp <container>:<src-path> <local-dest-path>


* docker cp D:\dev\openflights_dataset\data\airlines.dat my-iris:/usr/airlines.dat
* docker cp D:\dev\openflights_dataset\data\airport_freq.csv my-iris:/usr/airport_freq.csv
* docker cp D:\dev\openflights_dataset\data\airports.csv my-iris:/usr/airports.csv
* docker cp D:\dev\openflights_dataset\data\countries.csv my-iris:/usr/countries.csv
* docker cp D:\dev\openflights_dataset\data\navaids.csv my-iris:/usr/navaids.csv
* docker cp D:\dev\openflights_dataset\data\planes.dat my-iris:/usr/planes.dat
* docker cp D:\dev\openflights_dataset\data\regions.csv my-iris:/usr/regions.csv
* docker cp D:\dev\openflights_dataset\data\routes.dat my-iris:/usr/routes.dat
* docker cp D:\dev\openflights_dataset\data\runways.csv my-iris:/usr/runways.csv