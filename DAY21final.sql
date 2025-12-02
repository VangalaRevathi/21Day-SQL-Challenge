-- DAY 21 Practice Queries

-- Create a CTE to calculate service statistics, then query from it.

WITH service_statistics  AS(
SELECT service,
ROUND(AVG(patient_satisfaction)) AS Avg_patient_satisfaction,
SUM(patients_admitted) AS total_patients_admitted,
SUM(patients_refused) AS total_patients_refused
FROM services_weekly sw
GROUP BY sw.service
)
SELECT * FROM service_statistics ;

-- Use multiple CTEs to break down a complex query into logical steps.

WITH service_stats AS(
SELECT service,
ROUND(AVG(patient_satisfaction)) AS Avg_patient_satisfaction
FROM services_weekly
GROUP BY service),

service_stats1 AS(
SELECT service, 
SUM(patients_admitted) AS total_patients_admitted
FROM services_weekly
GROUP BY service),

service_stats2 AS(
SELECT service,
SUM(patients_refused) AS total_patients_refused
FROM services_weekly
GROUP BY service)

SELECT s.service,
       s.Avg_patient_satisfaction,
       s1.total_patients_admitted,
       s2.total_patients_refused
       FROM service_stats s
	   JOIN service_stats1 s1
	   ON s.service=s1.service
	   JOIN service_stats2 s2
	   ON s.service=s2.service;

-- Build a CTE for staff utilization and join it with patient data.

WITH staff_utilization AS (
    SELECT week, staff_id,staff_name,service
	FROM staff_schedule
	WHERE present=1
)
SELECT su.week,
       su.staff_id,
	   su.staff_name,
	   su.service,
	   p.patient_id,
	   p.name,
	   p.age,
	   p.satisfaction,p.week
	   FROM staff_utilization su
	   JOIN patients p
	   ON p.service=su.service;

-- DAY 21 Challenge

-- Create a comprehensive hospital performance dashboard using CTEs.
-- Calculate: 1) Service-level metrics (total admissions, refusals, 
-- avg satisfaction), 2) Staff metrics per service (total staff, 
-- avg weeks present), 3) Patient demographics per service (avg age,
-- count).Then combine all three CTEs to create a final report showing
-- service name, all calculated metrics, and an overall performance score
-- (weighted average of admission rate and satisfaction). Order by 
-- performance score descending.

WITH service_metrics AS(
SELECT 
service,
SUM(patients_admitted) as total_admissions,
SUM(patients_refused) AS total_refusals,
ROUND(AVG(patient_satisfaction)) AS Avg_patient_satisfaction
FROM services_weekly
GROUP BY service
),

staff_metrics AS(
SELECT service,
COUNT(DISTINCT staff_id) as total_staff,
AVG(CASE WHEN present=1 THEN 1 ELSE 0 END)*100 as Avg_weeks_present_pct
FROM staff_schedule 
GROUP BY service
),

patient_demographics AS(
SELECT service,
AVG(age) AS Avg_age,
COUNT(DISTINCT patient_id) AS total_patients
FROM patients 
GROUP BY service
)
SELECT 
       s.service,
       s.total_admissions,
       s.total_refusals,
       s.Avg_patient_satisfaction,
	   st.total_staff,
	   st.Avg_weeks_present_pct,
	   p.Avg_age,
	   p.total_patients,
-- Weighted performance score (you can adjust weights)
(0.6 * (s.total_admissions / NULLIF((s.total_admissions + s.total_refusals),0)) * 100) +
(0.4 * s.Avg_patient_satisfaction) AS performance_score
FROM service_metrics s
LEFT JOIN staff_metrics st
ON st.service=s.service
LEFT JOIN patient_demographics p
ON s.service=p.service
ORDER BY performance_score desc;



