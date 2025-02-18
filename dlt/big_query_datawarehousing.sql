-- Query public available table
SELECT station_id, name FROM
    bigquery-public-data.new_york_citibike.citibike_stations
LIMIT 100;


-- Check yello trip data
SELECT * FROM taxi-rides-ny.nytaxi.external_yellow_tripdata limit 10;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE `ny_taxi.rides_dataset.yellow_tripdata_non_partitioned` AS
SELECT * FROM inlaid-course-437111-h2.rides_dataset.rides;


-- Create a partitioned table from external table
CREATE OR REPLACE TABLE `ny_taxi.rides_dataset.yellow_tripdata_partitioned`
PARTITION BY
  DATE(tpep_pickup_datetime) AS
SELECT * FROM `ny_taxi.rides_dataset.yellow_tripdata_non_partitioned`

-- Impact of partition
-- Scanning 310MB of data
SELECT DISTINCT(vendor_id)
FROM inlaid-course-437111-h2.rides_dataset.yellow_tripdata_non_partitioned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2024-06-01' AND '2024-06-30';

-- Scanning ~54 MB of DATA
SELECT DISTINCT(vendor_id)
FROM inlaid-course-437111-h2.rides_dataset.yellow_tripdata_partitioned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2024-06-01' AND '2024-06-30';

-- Let's look into the partitions
SELECT table_name, partition_id, total_rows
FROM `rides_dataset.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'yellow_tripdata_partitioned'
ORDER BY total_rows DESC;

-- fareamount 0
SELECT COUNT(*) FROM `ny_taxi.rides_dataset.yellow_tripdata_partitioned` WHERE fare_amount = 0;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE `ny_taxi.rides_dataset.yellow_tripdata_partitioned_clustered`
PARTITION BY DATE(tpep_pickup_datetime)
CLUSTER BY vendor_id AS
SELECT * FROM `ny_taxi.rides_dataset.yellow_tripdata_partitioned`;

-- Query scans 1.1 GB
SELECT count(*) as trips
FROM `ny_taxi.rides_dataset.yellow_tripdata_partitioned`;
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND vendor_id=1;

-- Query scans 864.5 MB
SELECT count(*) as trips
FROM `ny_taxi.rides_dataset.yellow_tripdata_partitioned_clustered`
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND vendor_id=1;
