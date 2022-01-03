ALTER TABLE dc_data_flights.airport_freq
    ADD CONSTRAINT fk_airport_freq_airports_airport_ident 
        FOREIGN KEY (airport_ident ) REFERENCES dc_data_flights.airports(ident);
GO
ALTER TABLE dc_data_flights.runways
    ADD CONSTRAINT fk_runways_airports_airport_ident 
        FOREIGN KEY (airport_ident ) REFERENCES dc_data_flights.airports(ident);
GO