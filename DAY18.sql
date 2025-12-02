-- DAY 18 Practice Queries

-- Combine patient names and staff names into a single list.

SELECT p.name AS name
FROM patients p
UNION ALL
SELECT s.staff_name 
FROM staff s;


-- Create a union of high satisfaction patients (>90)
-- and low satisfaction patients (<50).

SELECT patient_id,name,satisfaction,
'High_satisfaction_patients' AS category
FROM patients
WHERE satisfaction>90
UNION ALL
SELECT patient_id,name,satisfaction,
'Low_satisfaction_patients' AS category
FROM patients
WHERE satisfaction<50;

SELECT COUNT(*) FROM patients WHERE satisfaction > 90;
SELECT COUNT(*) FROM patients WHERE satisfaction < 50;

--List all unique names from both patients and staff tables.

SELECT DISTINCT p.name,'Patient_name' AS category
FROM patients p
UNION ALL
SELECT DISTINCT s.staff_name, 'staff_name' AS category
FROM staff s;

-- Create a comprehensive personnel and patient list showing:
-- identifier (patient_id or staff_id), full name, type 
-- ('Patient' or 'Staff'), and associated service. Include only those in 
-- 'surgery' or 'emergency' services. Order by type, then service, then 
-- name.

SELECT 
    patient_id AS identifier,
    name AS full_name,
    'Patient' AS type,
    service
FROM patients
WHERE service IN ('surgery', 'emergency')

UNION ALL

SELECT 
    staff_id AS identifier,
    staff_name AS full_name,
    'Staff' AS type,
    service
FROM staff
WHERE service IN ('surgery', 'emergency')
ORDER BY type, service, full_name;



