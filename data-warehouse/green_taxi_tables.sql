CREATE SCHEMA `coherent-ranger-412815.green_taxi`;

CREATE OR REPLACE EXTERNAL TABLE `coherent-ranger-412815.green_taxi.external_green_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-kim/green_taxi_data_w3/*.parquet']
);

CREATE OR REPLACE TABLE coherent-ranger-412815.green_taxi.green_tripdata AS
SELECT * FROM coherent-ranger-412815.green_taxi.external_green_tripdata;