-- DAY 16 Practice Queries

-- Find patients who are in services with above-average staff count.



SELECT *
FROM patients
WHERE service IN (
      SELECT service
      FROM (
          SELECT service, COUNT(staff_name) AS staff_count
          FROM staff
          GROUP BY service
      ) AS t
      WHERE staff_count >
            (SELECT AVG(staff_count)
             FROM (
                 SELECT service, COUNT(staff_name) AS staff_count
                 FROM staff
                 GROUP BY service
             ) AS x)
);


-- List staff who work in services that had any week with 
-- patient satisfaction below 70.

SELECT DISTINCT
    s.staff_id,
    s.staff_name,
    s.service,
    sw.week,
    sw.patient_satisfaction
FROM staff s
JOIN services_weekly sw
  ON s.service = sw.service
WHERE sw.patient_satisfaction < 70
ORDER BY s.service, sw.week;


-- Show patients from services where total admitted patients exceed 1000.

SELECT * FROM patients
WHERE service IN( SELECT service
                    FROM services_weekly
                    GROUP BY service
                    HAVING SUM(patients_admitted) > 1000);

-- Day 16 Challenge 

-- Find all patients who were admitted to services that had at least one
-- week where patients were refused AND the average patient satisfaction 
-- for that service was below the overall hospital average satisfaction. 
-- Show patient_id,name, service, and their personal satisfaction score.

Output: from patients table
Filter,condition: 
1.atleast one week where patients refused and
2.avg satisfaction for that service is below overall hospital 
satisfaction

SELECT p.patient_id, p.name, p.service, p.satisfaction 
FROM patients p
WHERE p.service IN(
SELECT service
FROM services_weekly sw
GROUP BY service
HAVING 
    MAX(CASE WHEN patients_refused>0 THEN 1 END)=1
	AND
	AVG(sw.patient_satisfaction) < (
    SELECT AVG(patient_satisfaction)
	FROM services_weekly
	)
);


	

