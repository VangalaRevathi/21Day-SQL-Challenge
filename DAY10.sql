-- DAY10 Practice queries

-- CAtegorize by Satisfaction
SELECT patient_id
CASE 
  WHEN satisfaction >=70 THEN 'High'
  WHEN satisfaction >=50 THEN 'Medium'
  ELSE 'Low'
END AS satisfaction_status
FROM patients;

-- Label Staff roles based on role type as Medical, Support

SELECT staff_id,staff_name,role,
CASE 
WHEN role='doctor' THEN 'Medical'
WHEN role='nurse'  THEN 'Support'
WHEN role='nursing_assistant' THEN 'Support'
ELSE 'None'
END AS staff_role_type
FROM staff;

-- Create age_groups for patients

SELECT patient_id,name,age,
CASE 
WHEN age Between 0 AND 18  THEN 'Pediatric'
WHEN age Between 19 AND 40 THEN 'Adult'
WHEN age Between 41 AND 65 THEN 'Old man'
ELSE 'Senior Citizen'
END AS Patient_age_group
FROM patients;

--DAY10 Challenge

Create a service performance report showing service name,
total patients admitted,and a performance category

SELECT * FROM services_weekly;
SELECT service,SUM(patients_admitted) AS Total_patients_admitted,
ROUND(AVG(patient_satisfaction),2) AS Avg_satisfaction,
CASE 
WHEN Avg(patient_satisfaction) >= 85 THEN 'Excellent'
WHEN Avg(patient_satisfaction) >= 75 THEN 'Good'
WHEN AVG(patient_satisfaction) >= 65 THEN 'Fair'
ELSE 'Needs Improvement'
END AS performance_category
FROM services_weekly
GROUP BY service
ORDER BY Avg_satisfaction desc;