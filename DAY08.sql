
-- DAY08 Practice questions

SELECT UPPER(name) as Patient_name_BOLD FROM patients;

SELECT LENGTH(staff_name) AS staff_name_length FROM staff;
SELECT * FROM staff;

SELECT CONCAT(staff_id,' - ',staff_name)
FROM staff;

--DAY08 Challenge

SELECT patient_id, UPPER(name) AS Full_name, 
LOWER(service) AS service,
age, LENGTH(name) AS name_length,
CASE 
WHEN age>='65'
    then 'Senior'
WHEN age>='18'
    then 'Adult'
ELSE
    'Minor'
	END AS age_category
FROM patients
WHERE LENGTH(name)>10;

SELECT * FROM patients;


