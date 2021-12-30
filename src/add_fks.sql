ALTER TABLE flights.airport_freq
ADD CONSTRAINT fk_airport_freq_airports_airport_id 
FOREIGN KEY (airport_id ) 
REFERENCES flights.airports(id);
GO
ALTER TABLE flights.airport_freq
ADD CONSTRAINT fk_airport_freq_airports_airport_ident 
FOREIGN KEY (airport_ident ) 
REFERENCES flights.airports(ident);
GO
ALTER TABLE flights.runways
ADD CONSTRAINT fk_runways_airports_airport_id 
FOREIGN KEY (airport_id ) 
REFERENCES flights.airports(id);
GO
ALTER TABLE flights.runways
ADD CONSTRAINT fk_runways_airports_airport_ident 
FOREIGN KEY (airport_ident ) 
REFERENCES flights.airports(ident);
