/*
Project: 01_MRO_Predictive_Maintenance
Author: Saurav Korde
Date: 2026-03-23
Goal: Initialize the raw ingestion schema for NASA Turbofan telemetry data.
*/

-- =======================================================
-- 1. Create Raw Telemetry Fact Table
-- =======================================================

-- Step A: Audit (Check if table already exists in the public schema)
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' AND table_name = 'raw_engine_telemetry';

-- Step B: The Fix (Execute table creation logic)
CREATE TABLE IF NOT EXISTS raw_engine_telemetry (
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
    PRIMARY KEY (engine_id, operational_cycle)
);

-- Step C: Verify (Prove the schema was built correctly)
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'raw_engine_telemetry'
ORDER BY ordinal_position;