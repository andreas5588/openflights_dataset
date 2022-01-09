--check for missing airports from dc_data_flights.routes.dest_airport
SELECT DISTINCT dc_data_flights.routes.dest_airport FROM dc_data_flights.routes
LEFT JOIN dc_data_flights.airports ON dc_data_flights.airports.iata_code=dc_data_flights.routes.dest_airport
WHERE dc_data_flights.airports.iata_code IS NULL
ORDER BY dest_airport
GO
--check for missing airports from dc_data_flights.routes.source_airport
SELECT DISTINCT dc_data_flights.routes.source_airport FROM dc_data_flights.routes
LEFT JOIN dc_data_flights.airports ON dc_data_flights.airports.iata_code=dc_data_flights.routes.source_airport
WHERE dc_data_flights.airports.iata_code IS NULL
ORDER BY dest_airport
GO
--check for duplicates in iata_code
SELECT iata_code,COUNT(*) FROM dc_data_flights.airports 
GROUP BY iata_code
HAVING COUNT(*) > 1
ORDER BY iata_code
GO
-- see the airport freqs for airport 'EDDF'
SELECT TOP 100 a.*,f.* FROM dc_data_flights.airports a
INNER JOIN dc_data_flights.airport_freq f ON f.airport_id = a.ID
WHERE a.ident='EDDF'
GO

SELECT id FROM dc_data_flights.airports
GROUP BY id
HAVING COUNT(*) > 1
GO

--
SELECT TOP 100 
       id,
       filename,
       ident,
       name,
       TYPE,
       frequency_khz,
       latitude_deg,
       longitude_deg,
       location,
       elevation_ft,
       iso_country,
       dme_frequency_khz,
       dme_channel,
       dme_latitude_deg,
       dme_longitude_deg,
       dme_elevation_ft,
       slaved_variation_deg,
       magnetic_variation_deg,
       usagetype,
       POWER,
       associated_airport
FROM dc_data_flights.navaids 
WHERE associated_airport='EDDF'
GO
--UPDATE dc_data_flights.airports SET iata_code=NULL WHERE iata_code=0 
--GO
--UPDATE dc_data_flights.airports SET iso_country=NULL WHERE iso_country=0 
GO
-- this just run's forever
/*
UPDATE dc_data_flights.airports upd SET upd.iata_code=NULL 
WHERE upd.ID IN 
(
	SELECT MAX(id) FROM dc_data_flights.airports 
	GROUP BY iata_code
	HAVING COUNT(*) > 1
)
*/
GO
SELECT * FROM dc_data_flights.airports WHERE iata_code LIKE '%CPF%'
GO
SELECT * FROM dc_data_flights.airports WHERE name LIKE '%Berlin-Schönefeld Airport%'
GO
SELECT * FROM dc_data_flights.routes WHERE dest_airport LIKE '%HAH%'