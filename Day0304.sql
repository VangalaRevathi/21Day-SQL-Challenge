-- Day03 Practice Queries

SELECT name, age FROM patients
ORDER BY age DESC;

--All services_weekly data sorted by weeknum asc, patient request desc
SELECT week,service,patients_request FROM services_weekly
ORDER BY week asc, patients_request Desc;

-- Display staff members sorted by alphabetical order

SELECT staff_name FROM staff
ORDER BY staff_name;

-- Day03 Challenge

SELECT week, service, patients_refused, patients_request
FROM services_weekly
ORDER BY week, patients_refused desc LIMIT 5;

--Day04 Practice queries

SELECT name FROM patients
LIMIT 5;

--Patients from 11-20

SELECT name, patient_id FROM patients
LIMIT 20 OFFSET 10;

SELECT patient_id,name,arrival_date FROM patients
ORDER BY arrival_date LIMIT 10;

--Day04 Challenge

SELECT patient_id, name, service, satisfaction
FROM patients
ORDER BY satisfaction desc LIMIT 5 OFFSET 2;



