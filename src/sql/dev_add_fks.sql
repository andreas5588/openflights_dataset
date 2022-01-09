/*
-- can't add this FK caus if duplicates in airports_iata_code
ALTER TABLE dc_data_flights.routes
    ADD CONSTRAINT fk_routes_source_airport_airports_iata_code 
        FOREIGN KEY (source_airport) REFERENCES dc_data_flights.airports(iata_code);       
GO
*/


/*
-- can't add this FK caus if duplicates in airports_iata_code
ALTER TABLE dc_data_flights.routes
    ADD CONSTRAINT fk_routes_dest_airport_airports_iata_code 
        FOREIGN KEY (dest_airport) REFERENCES dc_data_flights.airports(iata_code);
GO
*/
