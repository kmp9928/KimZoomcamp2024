SELECT "Borough", SUM(total_amount)
FROM green_trip
LEFT JOIN zones
ON green_trip."PULocationID" = zones."LocationID"
WHERE CAST(lpep_pickup_datetime AS DATE)= '2019-09-18'
AND "Borough" != 'Unknown'
GROUP BY "Borough"
ORDER BY 2 DESC;