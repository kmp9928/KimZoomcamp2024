SELECT
	lpep_pickup_datetime,
	MAX(trip_distance)
FROM green_trip
WHERE CAST(lpep_dropoff_datetime AS DATE) = CAST(lpep_pickup_datetime AS DATE)
GROUP BY lpep_pickup_datetime
ORDER BY 2 DESC;