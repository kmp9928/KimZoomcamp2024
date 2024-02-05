SELECT zdo."Zone", MAX(tip_amount)
FROM green_trip
LEFT JOIN zones AS zpu
ON green_trip."PULocationID" = zpu."LocationID"
LEFT JOIN zones AS zdo
ON green_trip."DOLocationID" = zdo."LocationID"
WHERE CAST(lpep_pickup_datetime AS DATE) BETWEEN '2019-09-01' AND '2019-09-30'
AND zpu."Zone" = 'Astoria'
GROUP BY zdo."Zone"
ORDER BY 2 DESC;