CREATE MATERIALIZED VIEW num_trips AS
SELECT 
	pickup_zone,
  dropoff_zone,
	count(*) AS num_trip,
	avg(trip_t) AS avg_trip_t
FROM 
	trip_time
GROUP BY 1, 2;

WITH max_avg AS (SELECT max(avg_trip_t) AS max FROM num_trips) 
SELECT num_trip, pickup_zone, dropoff_zone 
FROM num_trips, max_avg 
WHERE avg_trip_t = max;

-- num_trip |  pickup_zone   | dropoff_zone 
-- ----------+----------------+--------------
--        1 | Yorkville East | Steinway
--(1 row)