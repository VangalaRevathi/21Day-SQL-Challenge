
-- Day05 Practice queries
SELECT * FROM services_weekly;
SELECT COUNT(patient_id) AS total_patients
FROM patients;

SELECT AVG(satisfaction) AS Avg_satisfaction_score
FROM patients;

SELECT MIN(age) AS youngest_patient, MAX(age) AS oldest_patient 
FROM patients;

-- Day05 Challenge

SELECT SUM(patients_admitted) AS patients_admitted,
SUM(patients_refused) AS patients_refused,
ROUND(AVG(patient_satisfaction),2) 
AS Avg_satisfaction_score FROM services_weekly;

--Day 06 Practice Queries

SELECT service, COUNT(name) AS patient_count
FROM patients
GROUP BY service;

SELECT service, ROUND(Avg(age)) as Avg_age_patients
FROM patients
GROUP BY service;

SELECT role, COUNT(staff_id) AS staff_per_role
FROM staff
GROUP BY role;

SELECT * FROM services_weekly;

-- Day06 Challenge

SELECT service, SUM(patients_admitted) AS Total_admitted_patients, 
SUM(patients_refused) AS Total_patients_refused, 
SUM(patients_request) AS Total_patients_request,
ROUND(SUM(patients_admitted),2)/ SUM(patients_request)*100
AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate desc ;
