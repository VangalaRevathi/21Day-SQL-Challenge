-- DAY07 Practice questions
-- Services where patient admission is more than 500

SELECT service, SUM(patients_admitted) AS Total_patients_admitted
FROM services_weekly
GROUP BY service
HAVING SUM(patients_admitted)>500;

-- Services where Avg patient satisfaction is below 70

SELECT service, ROUND(AVG(patient_satisfaction),2)
AS Avg_patient_satisfaction 
FROM services_weekly
GROUP BY service
HAVING ROUND(AVG(patient_satisfaction),2) < 100;

-- List of weeks where total staff presesnce across all services is lessthan 50

SELECT week, service,COUNT(present) as staff_presence
FROM staff_schedule
GROUP BY week,service
HAVING COUNT(present)<50;
SELECT * FROM staff_schedule;

-- DAY07 Challenge

SELECT * FROM services_weekly;
SELECT 
      service,
	  SUM(patients_refused) as Total_patients_refused, 
      ROUND(AVG(patient_satisfaction),2) as Avg_satisfaction
FROM services_weekly
GROUP BY service
HAVING  SUM(patients_refused) > 100 AND AVG(patient_satisfaction) < 80;


