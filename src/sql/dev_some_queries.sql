SELECT TOP 100 a.*,f.* FROM dc_data_flights.airports a
INNER JOIN dc_data_flights.airport_freq f ON f.airport_id = a.ID
WHERE a.ident='EDDF'
GO
SELECT id FROM dc_data_flights.airports
GROUP BY id
HAVING COUNT(*) > 1
GO
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
