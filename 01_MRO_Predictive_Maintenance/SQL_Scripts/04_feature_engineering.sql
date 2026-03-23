/*
Project: 01_MRO_Predictive_Maintenance
Author: Saurav Korde
Date: 2026-03-23
Goal: I will engineer moving averages to smooth sensor noise and expose the degradation trend.
*/

-- =======================================================
-- 4. Feature Engineering: 10-Cycle Rolling Averages
-- =======================================================

-- Step A: Audit (Check the raw noise of Sensor 11 for Engine 1)
SELECT operational_cycle, sensor_11 
FROM vw_engine_rul 
WHERE engine_id = 1 
ORDER BY operational_cycle ASC 
LIMIT 15;

-- Step B: The Fix (Create the final BI-ready View with Rolling Averages)
CREATE OR REPLACE VIEW vw_mro_predictive_features AS
SELECT 
    engine_id,
    operational_cycle,
    max_cycle,
    rul,
    sensor_11 AS raw_hpc_pressure,
    AVG(sensor_11) OVER (
        PARTITION BY engine_id 
        ORDER BY operational_cycle 
        ROWS BETWEEN 9 PRECEDING AND CURRENT ROW
    ) AS rolling_avg_hpc_pressure,
    sensor_14 AS raw_core_speed,
    AVG(sensor_14) OVER (
        PARTITION BY engine_id 
        ORDER BY operational_cycle 
        ROWS BETWEEN 9 PRECEDING AND CURRENT ROW
    ) AS rolling_avg_core_speed
FROM vw_engine_rul;

-- Step C: Verify (Observe how the rolling average starts calculating and smoothing)
SELECT 
    operational_cycle, 
    raw_hpc_pressure, 
    ROUND(rolling_avg_hpc_pressure, 2) AS smoothed_hpc_pressure
FROM vw_mro_predictive_features
WHERE engine_id = 1
ORDER BY operational_cycle ASC
LIMIT 15;