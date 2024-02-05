SELECT COUNT(1)
FROM green_trip
WHERE CAST(lpep_dropoff_datetime AS DATE) = '2019-09-18'
AND CAST(lpep_pickup_datetime AS DATE) = '2019-09-18';