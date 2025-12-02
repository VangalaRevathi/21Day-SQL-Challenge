-- Calculate running total of patients admitted by week for each service.

SELECT patients_admitted,service,week,
SUM(patients_admitted) OVER(PARTITION BY service ORDER BY patients_admitted)
AS cumulative_admissions
FROM services_weekly
ORDER BY service, patients_admitted;

-- Find the moving average of patient satisfaction over 4-week periods.

SELECT 
    service,
    week,
    patient_satisfaction,
    ROUND(
        AVG(patient_satisfaction) OVER (
            PARTITION BY service 
            ORDER BY week
            ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_4weeks
FROM services_weekly
ORDER BY service, week;

-- Show cumulative patient refusals by week across all services.

SELECT 
    week,
    SUM(patients_refused) AS weekly_refusals,
    SUM(SUM(patients_refused)) OVER (
        ORDER BY week
    ) AS cumulative_refusals
FROM services_weekly
GROUP BY week
ORDER BY week;

-- DAY 20 Challenge

--Create a trend analysis showing for each service and week: week number,
-- patients_admitted, running total of patients admitted (cumulative), 
-- 3-week moving average of patient satisfaction (current week and 2
-- prior weeks), and the difference between current week admissions and
-- the service average. Filter for weeks 10-20 only.

SELECT 
    service,
    week,
    patients_admitted,
    
    -- cumulative admitted
    SUM(patients_admitted) OVER (
        PARTITION BY service 
        ORDER BY week
    ) AS cumulative_patients_admit,

    -- 3-week moving average
    AVG(patient_satisfaction) OVER (
        PARTITION BY service 
        ORDER BY week
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg,

    -- difference between current week admissions and service avg
    patients_admitted 
      - AVG(patients_admitted) OVER (PARTITION BY service) AS diff
FROM services_weekly
WHERE week BETWEEN 10 AND 20
ORDER BY service, week;


