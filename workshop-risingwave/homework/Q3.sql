CREATE MATERIALIZED VIEW pickups AS
WITH latest_pickup AS (SELECT max(tpep_pickup_datetime) AS latest_pickup_t FROM trip_data)
SELECT 
	zone,
	count(*) AS pickup_num
FROM 
	latest_pickup, taxi_zone
JOIN trip_data
ON taxi_zone.location_id = trip_data.pulocationid
WHERE trip_data.tpep_pickup_datetime > (latest_pickup_t - INTERVAL '17' HOUR)
GROUP BY zone;

SELECT * FROM pickups ORDER BY pickup_num DESC LIMIT 3;

-- zone                 | pickup_num 
-- ---------------------+------------
-- LaGuardia Airport    |         19
-- JFK Airport          |         17
-- Lincoln Square East  |         17
--(3 rows)