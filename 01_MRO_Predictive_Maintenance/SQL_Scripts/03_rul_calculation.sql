/*
Project: 01_MRO_Predictive_Maintenance
Author: Saurav Korde
Date: 2026-03-23
Goal: I will create a SQL View to calculate Remaining Useful Life (RUL) using Window Functions.
*/

-- =======================================================
-- 3. Calculate Remaining Useful Life (RUL)
-- =======================================================

-- Step A: Audit (Identify the moment of failure for Engine 1)
SELECT engine_id, MAX(operational_cycle) as failure_cycle 
FROM raw_engine_telemetry 
WHERE engine_id = 1 
GROUP BY engine_id;

-- Step B: The Fix (Create a View with the RUL mathematical logic)
CREATE OR REPLACE VIEW vw_engine_rul AS
SELECT 
    engine_id,
    operational_cycle,
    MAX(operational_cycle) OVER (PARTITION BY engine_id) AS max_cycle,
    (MAX(operational_cycle) OVER (PARTITION BY engine_id) - operational_cycle) AS rul,
    op_setting_1, op_setting_2, op_setting_3,
    sensor_1, sensor_2, sensor_3, sensor_4, sensor_5, sensor_6, sensor_7, 
    sensor_8, sensor_9, sensor_10, sensor_11, sensor_12, sensor_13, sensor_14, 
    sensor_15, sensor_16, sensor_17, sensor_18, sensor_19, sensor_20, sensor_21
FROM raw_engine_telemetry;

-- Step C: Verify (Check the RUL countdown for the final days of Engine 1)
SELECT engine_id, operational_cycle, max_cycle, rul 
FROM vw_engine_rul 
WHERE engine_id = 1 
ORDER BY operational_cycle DESC 
LIMIT 5;