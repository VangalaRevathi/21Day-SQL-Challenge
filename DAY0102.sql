SELECT * From patients;
SELECT patient_id, name, age FROM patients;
SELECT * FROM services_weekly LIMIT 10;
-- Day01 Challenge
SELECT DISTINCT service as hospital_services
FROM patients;

-- Day02 Practise queries
--List patients who are above 60 year old
SELECT name, age FROM patients 
WHERE age>60;

--Staff members dealing with emergency ward
SELECT staff_name, service 
FROM staff
WHERE service= 'emergency';

--Weeks where patients request for admission is greater than 100
SELECT week as Week_num 
FROM services_weekly
WHERE patients_request >100;

-- Day02 Challenge 
--Patients joined for Surgery service with below 70 as satisfactionscore.
SELECT name, patient_id, age, satisfaction as satisfaction_score
FROM patients
WHERE service='surgery' AND satisfaction < 70;

