/*
Project: 01_MRO_Predictive_Maintenance
Author: Saurav Korde
Date: 2026-03-23
Goal: I will use a Staging Table to bypass trailing space delimiter errors 
      and bulk ingest the NASA CMAPSS telemetry data.
*/

-- =======================================================
-- 2. Bulk Data Ingestion via Staging Bypass
-- =======================================================

-- Step A: Audit (Ensure my final table is empty and ready)
TRUNCATE TABLE raw_engine_telemetry;

-- Step B: The Fix (Create staging, COPY, INSERT, and Drop)

-- B1. Create the temporary staging table with 2 dummy columns to catch trailing spaces
CREATE TEMP TABLE staging_telemetry (
    engine_id INT,
    operational_cycle INT,
    op_setting_1 NUMERIC,
    op_setting_2 NUMERIC,
    op_setting_3 NUMERIC,
    sensor_1 NUMERIC,
    sensor_2 NUMERIC,
    sensor_3 NUMERIC,
    sensor_4 NUMERIC,
    sensor_5 NUMERIC,
    sensor_6 NUMERIC,
    sensor_7 NUMERIC,
    sensor_8 NUMERIC,
    sensor_9 NUMERIC,
    sensor_10 NUMERIC,
    sensor_11 NUMERIC,
    sensor_12 NUMERIC,
    sensor_13 NUMERIC,
    sensor_14 NUMERIC,
    sensor_15 NUMERIC,
    sensor_16 NUMERIC,
    sensor_17 NUMERIC,
    sensor_18 NUMERIC,
    sensor_19 NUMERIC,
    sensor_20 NUMERIC,
    sensor_21 NUMERIC,
    dummy_1 TEXT, -- Catches the first trailing space
    dummy_2 TEXT  -- Catches the second trailing space
);

-- B2. Bulk COPY into the staging table (REPLACE WITH YOUR EXACT FILE PATH)
COPY staging_telemetry 
FROM '/Users/sauravsunilkorde/Desktop/Data Analyst/Projects/Aerospace-Data-Empire/01_MRO_Predictive_Maintenance/Raw_Data/train_FD001.txt' 
WITH (FORMAT csv, DELIMITER ' ');

-- B3. Insert strictly the 26 clean columns into my final target table
INSERT INTO raw_engine_telemetry (
    engine_id, operational_cycle, op_setting_1, op_setting_2, op_setting_3, 
    sensor_1, sensor_2, sensor_3, sensor_4, sensor_5, sensor_6, sensor_7, 
    sensor_8, sensor_9, sensor_10, sensor_11, sensor_12, sensor_13, sensor_14, 
    sensor_15, sensor_16, sensor_17, sensor_18, sensor_19, sensor_20, sensor_21
)
SELECT 
    engine_id, operational_cycle, op_setting_1, op_setting_2, op_setting_3, 
    sensor_1, sensor_2, sensor_3, sensor_4, sensor_5, sensor_6, sensor_7, 
    sensor_8, sensor_9, sensor_10, sensor_11, sensor_12, sensor_13, sensor_14, 
    sensor_15, sensor_16, sensor_17, sensor_18, sensor_19, sensor_20, sensor_21
FROM staging_telemetry;

-- B4. Drop the staging table to clear memory
DROP TABLE staging_telemetry;

-- Step C: Verify (Prove the clean data was ingested)
SELECT COUNT(*) AS final_row_count FROM raw_engine_telemetry;

SELECT * FROM raw_engine_telemetry LIMIT 5;