# Openflights demo dataset
This is a demo dataset\datamodel for InterSystems IRIS. This model is build for the IRIS Dataset contest: https://community.intersystems.com/post/technology-bonuses-intersystems-iris-datasets-contest-2021 

The data used by this datamodel are based on datasets from ourairports.com and openflights.org 

To load the CSV files into the database the new LOAD DATA feature of IRIS Version 2021.2.0.617 (preview) is used. Details about the new SQL command can be found here: https://docs.intersystems.com/iris20212/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_loaddata

With this example project you have at least two use cases:

See and evaluate the using of LOAD DATA 
or just explore the openflights datamodel

## Data in this model

The data comes from ourairports.com and openflights.org. 

The openflights.org website makes the data available under the Open Database License. For details please see: https://openflights.org/data.html#license
The ourairports.com website makes the data from there available to the Public Domain. The data comes with no guarantee of accuracy or fitness for use. 

### Data from: https://openflights.org/data.html
The "dat"-files are simple text files
* airlines.dat file contains information on airlines
* routes.dat file contains routes between airports and airlines
* planes.dat file contains aircrafts with IATA and/or ICAO codes

### Data from: https://ourairports.com/help/data-dictionary.html https://github.com/davidmegginson/ourairports-data
The "csv"-files are simple text files
* airports.csv - Each row represents the record for a single airport.
* airport_freq.csv - Each row represents a single airport radio frequency for voice communication (radio navigation aids appear in navaids.csv). 
* countries.csv - Each row represents a country or country-like entity (e.g. Hong Kong). 
* runways.csv - Each row represents a single airport landing surface (runway, helipad, or waterway).
* navaids.csv - Each row represents a single radio navigation. 
* regions.csv - Each row represents a high-level administrative subdivision of a country. 

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

You find the files within docker the container in folder: /opt/irisbuild/data/

## Visual representation of the data model

 The Tables are created in SCHEMA dc_data_flights. The tables were named according to the files from which the data originated.

You found more details about the content of the tables and columns within the database. The IRIS CREATE TABLE *%DESCRIPTION* option was used for the purpose to document the datamodel.
![all tables and row counts](/doc/datamodel_remarks.png)


FKs are not all set... cause of data inconsistencies, indices are still missing
... stay tune

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

## Some usful links

This is a article-post on community.intersystems.com related to this github repo: https://community.intersystems.com/post/tips-and-tricks-brand-new-load-data-command

As described on this post, I had problems creating and populating the tables via DDL script in IRIS. Unfortunately *$SYSTEM.SQL.Schema.ImportDDL* does not support many SQL statements, e.g. USE DATABASE or LOAD DATA.
Fortunately Benjamin De Boe (https://github.com/bdeboe) had a solution in one of his repositories :-)
The IRIS class file /src/cls/Utils.cls and within the Openflights.Utils.RunDDL method based on his https://github.com/bdeboe/isc-adventureworks/blob/main/src/cls/AdventureWorks/Utils.cls file. I've just changed the statement delimiter from ";" to "GO". Thanks Benjamin!