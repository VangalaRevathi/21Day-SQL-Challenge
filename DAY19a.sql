-- DAY 19 Practice Queries

-- Rank patients by satisfaction score within each service.

SELECT patient_id,name, satisfaction,service,
RANK() OVER (PARTITION BY service ORDER BY satisfaction desc) 
AS satisfaction_rnk
FROM patients
ORDER BY service,satisfaction desc;

-- Assign row numbers to staff ordered by their name.

SELECT *,ROW_NUMBER() OVER (ORDER BY staff_name asc) AS staff_row_num
FROM staff;

-- Rank services by total patients admitted.

SELECT service,SUM(patients_admitted) AS total_patients,
       RANK() OVER (ORDER BY SUM(patients_admitted) desc)
	   AS service_rank
	   FROM services_weekly
	   GROUP BY service
	   ORDER BY SUM(patients_admitted) desc;


-- DAY19 Challenge

-- For each service, rank the weeks by patient satisfaction score
-- (highest first). Show service, week, patient_satisfaction, 
-- patients_admitted,and the rank. Include only the top 3 weeks per 
-- service.

SELECT 
     service,
	 week,
	 patient_satisfaction,
	 patients_admitted, 
	 rnk
	 FROM(
	 SELECT service,week,patient_satisfaction,patients_admitted,
	 RANK() OVER (PARTITION BY service ORDER BY patient_satisfaction desc)
	 AS rnk
	 FROM services_weekly
	 )AS ranked_data
    WHERE rnk <= 3
    ORDER BY service, rnk, patient_satisfaction DESC;

	 
	 