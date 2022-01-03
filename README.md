# Openflights demo dataset
This a demo dataset, datamodel for InterSystems IRIS. This model was build for the IRIS Dataset contest: https://community.intersystems.com/post/technology-bonuses-intersystems-iris-datasets-contest-2021 The data used by this datamodel are based on datasets from ourairports.com and openflights.org 
To load the CSV files into the database the new LOAD DATA feature of IRIS Version 2021.2.0.617 (preview) is used. Details about the new SQL command can be found here: https://docs.intersystems.com/iris20212/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_loaddata

With this example project you have at least two use cases: 
    See and evaluate the using of LOAD DATA 
    or 
    just explore the openflights datamodel with SQL

## Data in this model

### data from: https://openflights.org/data.html#airline
The "dat"-files are simple text files
* airlines.dat Contais information on airlines
* routes.dat Route file contains routes between airports on airlines spanning the globe
* planes.dat The OpenFlights plane file contains a curated selection of 173 passenger aircraft with IATA and/or ICAO codes, covering the vast majority of flights operated today and commonly used in flight schedules and reservation systems.

### data from: https://ourairports.com/help/data-dictionary.html

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
* :heavy_check_mark: airport_freq.csv (28.969 of 28.969 rows loaded)
* :heavy_check_mark: airports.csv (69.197 of 69.197 rows loaded) 
* :heavy_check_mark: countries.csv (247 of 247 rows loaded)
* :heavy_check_mark: navaids.csv (11.020 of 11.020 rows loaded)
* :heavy_check_mark: planes.dat (246 of 246 rows loaded)
* :heavy_check_mark: regions.csv (3.964 of 3.964 rows loaded)
* :heavy_check_mark: routes.dat (667.663 of 67.663 rows loaded)
* :heavy_check_mark: runways.csv (42.932 of  rows 42.932 loaded)

You find the files above in the container in folder: /opt/irisbuild/data/

## Visual representation of the data model

FKs are not all set... stay tune

![all tables and row counts](/doc/datamodel.png)

# Prerequisites

Make sure you have git and Docker desktop installed.

## Installation

To start working with this datamodel do the following:

1. Clone/git pull the repo into any local directory

```shell
git clone https://github.com/andreas5588/openflights_dataset.git
```

2. Open the console in this directory and run:

```shell
docker-compose build
```

By default the Container ports 1972; 52773; 53773 are mapped to the same local ports. Please check the availability of the ports on your maschine first.

3. Run the iris-openflight container with the datamodel:

```shell
docker-compose up -d
```

In order to prevent problems with the data encoding when loading, please make the following setting on the %Java Server: -Dfile.encoding=UTF-8
See the screenshots for details:
![%Java Server Settings](/doc/change_jvm_param_for_javaserver.png)
![%Java Server Param](/doc/change_jvm_param_for_javaserver_file_encoding.png)

## Data sources

* Airports http://ourairports.com/data/
* Routes http://openflights.org/data.html
* Airport total passengers
** http://www.aci.aero/
** http://en.wikipedia.org/wiki/List_of_the_world%27s_busiest_airports_by_passenger_traffic#2014_statistics


## some git repos that work already with the openflights data
https://github.com/jpatokal/openflights