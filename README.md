
[![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Fopenflights_dataset&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Fopenflights_dataset)
 
 

# Openflights demo dataset
This is a demo dataset\datamodel for InterSystems IRIS. This model is build for the IRIS Dataset contest: https://community.intersystems.com/post/technology-bonuses-intersystems-iris-datasets-contest-2021 

The data used by this datamodel are based on datasets from ourairports.com and openflights.org 

To load the CSV files into the database the new LOAD DATA feature of IRIS Version 2022.1.0.199.0 (preview) is used. Details about the new SQL command can be found here: https://irisdocs.intersystems.com/iris20221/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_loaddata

With this example project you have at least two use cases: See and evaluate the using of LOAD DATA or just explore the openflights datamodel
To see this dataset in action with Apache Zeppelin please check this repo: https://github.com/andreas5588/openflights_demo

## Installation

To start working with this datamodel you have two options:

* Pull the ready build container from hub.docker
* Build your own container from source based in this repo

### Pull from hub.docker

```shell
docker run --rm -d -p 1972:1972 -p 52773:52773 andreasschneiderixdbde/openflights-iris
```

Thats it! Now you can work with InterSystems IRIS and the Openflights-Database
* Open the Management Portal: http://localhost:52773/csp/sys/UtilHome.csp
* Connect via JDBC with this URL: jdbc:IRIS://localhost:1972/OPENFLIGHTS
* Browse the datamodel documentation: http://localhost:52773/csp/openflights/index.html


### Build from source in this repo

Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

1. Clone/git pull the repo into any local directory

```shell
git clone https://github.com/andreas5588/openflights_dataset.git
```

2. Open the console in this directory and run:

```shell
docker-compose build
```

By default the Container ports  [![Docker-ports](https://img.shields.io/badge/dynamic/yaml?color=blue&label=docker-compose&prefix=ports%20-%20&query=%24.services.iris.ports&url=https%3A%2F%2Fraw.githubusercontent.com%2Fandreas5588%2Fopenflights_dataset%2Fmaster%2Fdocker-compose.yml)](https://raw.githubusercontent.com/andreas5588/openflights_dataset/master/docker-compose.yml) are mapped to the same local ports. Please check the availability of the ports on your maschine first.


3. Run the iris-openflight container with the datamodel:

```shell
docker-compose up -d
```

## Using and testing the datamodel

Now that the container is running, you should be able to create a connection to the management portal or just create a database connection with your favorite sql query tool.

 The JDBC URL should be looks like: jdbc:IRIS://localhost:1972/OPENFLIGHTS

 You can use User: _SYSTEM with pwd: SYS

 ![JDBC connection](/doc/connection_sql_query_tool.png)


After this you should be able to query the OPENFLIGHTS namespace as you wish. [Here](/src/sql/dev_some_queries.sql) are some example queries: [/src/sql/dev_some_queries.sql](/src/sql/dev_some_queries.sql)  

 ![Query the database](/doc/sqldatalens_show_fk_targets.gif)

The screenshots are from the tool [SQL DATA LENS](https://sqldatalens.com/) that is optimised for unique features of InterSystems IRIS & InterSystems Caché databases.

## Data in this model

The data comes from ourairports.com and openflights.org. 

The openflights.org website makes the data available under the Open Database License. For details please see: https://openflights.org/data.html#license
The ourairports.com website makes the data from there available to the Public Domain. The data comes with no guarantee of accuracy or fitness for use. 

#### Data from: https://openflights.org/data.html
The "dat"-files are simple text files
* airlines.dat file contains information on airlines
* routes.dat file contains routes between airports and airlines
* planes.dat file contains aircrafts with IATA and/or ICAO codes

#### Data from: https://ourairports.com/help/data-dictionary.html https://github.com/davidmegginson/ourairports-data
The "csv"-files are simple text files
* airports.csv - Each row represents the record for a single airport.
* airport_freq.csv - Each row represents a single airport radio frequency for voice communication (radio navigation aids appear in navaids.csv). 
* countries.csv - Each row represents a country or country-like entity (e.g. Hong Kong). 
* runways.csv - Each row represents a single airport landing surface (runway, helipad, or waterway).
* navaids.csv - Each row represents a single radio navigation. 
* regions.csv - Each row represents a high-level administrative subdivision of a country. 

#### State of loading

* :heavy_check_mark: airlines.dat (6.162 of 6.162 rows loaded)
* :heavy_check_mark: airport_freq.csv (28.969 of 28.969 rows loaded)
* :heavy_check_mark: airports.csv (69.197 of 69.197 rows loaded) 
* :heavy_check_mark: countries.csv (247 of 247 rows loaded)
* :heavy_check_mark: navaids.csv (11.020 of 11.020 rows loaded)
* :heavy_check_mark: planes.dat (246 of 246 rows loaded)
* :heavy_check_mark: regions.csv (3.964 of 3.964 rows loaded)
* :heavy_check_mark: routes.dat (67.663 of 67.663 rows loaded)
* :heavy_check_mark: runways.csv (42.932 of  rows 42.932 loaded)

You find the raw data files within docker container in folder: /opt/irisbuild/data for your own tests with the LOAD DATA command. The sql statements that are used to load the data for this project can be found in file [/src/ddl/02_create_db_model.sql](/src/ddl/02_create_db_model.sql)

## Documentation details about the data model

 The Tables are created in Namespace *OPENFLIGHTS* with SCHEMA *dc_data_flights*. The tables were named according to the files from which the data originated.

You found more details about the content of the tables and columns within the database. The IRIS CREATE TABLE *%DESCRIPTION* option was used for the purpose to document the datamodel.
![all tables and row counts](/doc/datamodel_remarks.png)

These are the tables in this model
![all tables and row counts](/doc/datamodel.png)

### Browsable db documentation in folder http://localhost:52773/csp/openflights/index.html

In the folder /doc/dbdoc you will find a complete html based documentation of the data model. The documentation contains details about table and column names as well as data types and relationships. To use the documentation, simply open the file /doc/dbdoc/index.html with a webbroser.

If the container is up and running then the documentation is available via the IRIS webserver: [http://localhost:52773/csp/openflights/index.html](http://localhost:52773/csp/openflights/index.html)


This is a screenshot of the entry page

![db documentation](/doc/database_doc.png)

From each entity you can navigate by relationships to the dependent tables. The relationships are also displayed graphically.

![db documentation](/doc/diagram_doc.png)

The generated documentation contains the explanations stored in the %DESCRIPTION property of tables and columns. With this information it should be easy to explore the data model.

## Some usful details and links

### how are the ddl's are executed
 This is a article-post on community.intersystems.com related to this github repo: https://community.intersystems.com/post/tips-and-tricks-brand-new-load-data-command As described on this post, I had problems creating and populating the tables via DDL script in IRIS. Unfortunately *$SYSTEM.SQL.Schema.ImportDDL* does not support many SQL statements, e.g. USE DATABASE or LOAD DATA.
Fortunately Benjamin De Boe (https://github.com/bdeboe) had a solution in one of his repositories :-)
The IRIS class file /src/cls/Utils.cls and within the Openflights.Utils.RunDDL method based on his https://github.com/bdeboe/isc-adventureworks/blob/main/src/cls/AdventureWorks/Utils.cls file. I've just changed the statement delimiter from ";" to "GO". Thanks Benjamin!

### what is in folder /sql ?

While working with the data and developing this project, some scripts were created. 

* dev_add_fks.sql - based on the documentation the FKs are defined, but not all are currently there cause of data inconsistencies 

* dev_check_sql_diag.sql - with queries in this file the LOAD DATA state can be checked and analyzed
* dev_drop_tables.sql - ... as the name says
* dev_some_queries.sql - just some queries to work with the datamodel

[![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/openflights_dataset)
