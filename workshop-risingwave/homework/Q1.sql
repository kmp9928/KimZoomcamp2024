CREATE MATERIALIZED VIEW trip_time AS
SELECT 
	taxi_zone_pu.zone as pickup_zone,
  taxi_zone_do.zone as dropoff_zone,
	EXTRACT(EPOCH FROM (tpep_dropoff_datetime - tpep_pickup_datetime)) AS trip_t
FROM 
	trip_data
JOIN taxi_zone as taxi_zone_pu
ON trip_data.pulocationid = taxi_zone_pu.location_id
JOIN taxi_zone as taxi_zone_do
ON trip_data.dolocationid = taxi_zone_do.location_id;

CREATE MATERIALIZED VIEW av_min_max_trip_time AS
SELECT 
	pickup_zone,
  dropoff_zone,
	avg(trip_t) AS avg_trip_t,
	min(trip_t) AS min_trip_t,
	max(trip_t) AS max_trip_t
FROM 
	trip_time
GROUP BY 1, 2;

WITH max_avg AS (SELECT max(avg_trip_t) AS max FROM av_min_max_trip_time) 
SELECT pickup_zone, dropoff_zone 
FROM av_min_max_trip_time, max_avg 
WHERE avg_trip_t = max;

-- pickup_zone     | dropoff_zone 
-- ----------------+--------------
-- Yorkville East  | Steinway
--(1 row)