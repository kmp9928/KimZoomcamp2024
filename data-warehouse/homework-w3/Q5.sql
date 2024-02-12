SELECT DISTINCT(PULocationID)
FROM `green_taxi.green_tripdata`
WHERE TIMESTAMP_MICROS(CAST(lpep_pickup_datetime/1000 AS INT64)) BETWEEN "2022-06-01" AND "2022-06-30";

SELECT DISTINCT(PULocationID)
FROM green_taxi.external_green_tripdata_partitoned_clustered
WHERE lpep_pickup_date BETWEEN "2022-06-01" AND "2022-06-30";