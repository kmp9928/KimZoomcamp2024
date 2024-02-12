CREATE OR REPLACE TABLE coherent-ranger-412815.green_taxi.external_green_tripdata_partitoned_clustered
PARTITION BY DATE(lpep_pickup_date)
CLUSTER BY PUlocationID AS
SELECT *, TIMESTAMP_MICROS(CAST(lpep_pickup_datetime/1000 AS INT64)) AS lpep_pickup_date FROM coherent-ranger-412815.green_taxi.external_green_tripdata;