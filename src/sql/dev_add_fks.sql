ALTER TABLE dc_data_flights.airport_freq
    ADD CONSTRAINT fk_airport_freq_airports_airport_ident 
        FOREIGN KEY (airport_ident) REFERENCES dc_data_flights.airports(ident);
GO
/*
-- duplicates in airports_iata_code
ALTER TABLE dc_data_flights.routes
    ADD CONSTRAINT fk_routes_source_airport_airports_iata_code 
        FOREIGN KEY (source_airport) REFERENCES dc_data_flights.airports(iata_code);       
GO
*/
/*
-- duplicates in airports_iata_code
ALTER TABLE dc_data_flights.routes
    ADD CONSTRAINT fk_routes_dest_airport_airports_iata_code 
        FOREIGN KEY (dest_airport) REFERENCES dc_data_flights.airports(iata_code);
GO
*/
ALTER TABLE dc_data_flights.runways
    ADD CONSTRAINT fk_runways_airports_airport_ident 
        FOREIGN KEY (airport_ident) REFERENCES dc_data_flights.airports(ident);
GO

ALTER TABLE dc_data_flights.airports
    ADD CONSTRAINT fk_airports_iso_country_countries_code 
        FOREIGN KEY (iso_country) REFERENCES dc_data_flights.countries(code);       
GO

ALTER TABLE dc_data_flights.airports
    ADD CONSTRAINT fk_airports_iso_region_region_code 
        FOREIGN KEY (iso_region) REFERENCES dc_data_flights.regions(code);       
GO

ALTER TABLE dc_data_flights.navaids
    ADD CONSTRAINT fk_navaids_iso_country_countries_code 
        FOREIGN KEY (iso_country) REFERENCES dc_data_flights.countries(code);
GO   

ALTER TABLE dc_data_flights.navaids
    ADD CONSTRAINT fk_navaids_associated_airport_airports_ident 
        FOREIGN KEY (associated_airport) REFERENCES dc_data_flights.airports(ident);
GO        

ALTER TABLE dc_data_flights.regions
    ADD CONSTRAINT fk_regions_iso_country_countries_code 
        FOREIGN KEY (iso_country) REFERENCES dc_data_flights.countries(code);
GO