-- DAY09 Practice Questions

SELECT * FROM patients;

-- Arrival year
SELECT 
  patient_id,
  EXTRACT(YEAR FROM arrival_date) AS arrival_year
FROM patients;

-- Length of the stay
SELECT patient_id, arrival_date, departure_date,
(departure_date-arrival_date) AS Length_of_the_stay
FROM patients;

-- Extract month from arrival date

SELECT 
  patient_id,
  TO_CHAR(arrival_date, 'Month') AS month_name
FROM patients
WHERE month_name='Febraury';

--DAY09 Challenge

SELECT COUNT(patient_id) AS patient_count,
ROUND(AVG(departure_date-arrival_date),2) AS Avg_stay,service
FROM patients
GROUP BY service
HAVING AVG(departure_date-arrival_date) >7
ORDER BY AVG(departure_date-arrival_date) desc;


