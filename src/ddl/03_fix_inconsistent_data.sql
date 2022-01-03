--check for duplicates in iata_code
SELECT iata_code,COUNT(*) FROM dc_data_flights.airports 
GROUP BY iata_code
HAVING COUNT(*) > 1
ORDER BY iata_code
--
--UPDATE dc_data_flights.airports SET iata_code=NULL WHERE iata_code=0 