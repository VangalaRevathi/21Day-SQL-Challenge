SELECT * FROM patients;

-- Show each patient with their service's 
-- average satisfaction as an additional column.

SELECT 
    p.*,
    (
        SELECT ROUND(AVG(p2.satisfaction), 2)
        FROM patients p2
        WHERE p2.service = p.service
    ) AS avg_service_satisfaction
FROM patients p
ORDER BY avg_service_satisfaction;

-- Create a derived table of service statistics and query from it.

SELECT 
    p.*,
    svc.avg_satisfaction
FROM patients p
JOIN (
        SELECT 
            service,
            ROUND(AVG(satisfaction), 2) AS avg_satisfaction
        FROM patients
        GROUP BY service
     ) AS svc
ON p.service = svc.service
ORDER BY svc.avg_satisfaction;


-- Display staff with their service's total 
-- patient count as a calculated field.


SELECT 
    s.staff_id,
    s.staff_name,
    s.service,
    SUM(sw.patients_admitted) AS patient_count
FROM staff s
LEFT JOIN services_weekly sw
       ON s.service = sw.service
GROUP BY 
    s.staff_id,
    s.staff_name,
    s.service;


-- Day 17 Challenge

-- Create a report showing each service with: service name, 
-- total patients admitted, the difference between their total admissions
-- and the average admissions across all services, and a rank indicator
-- ('Above Average', 'Average', 'Below Average'). Order by total patients
-- admitted descending.

SELECT 
    service,
    total_patients,
    total_patients - overall_avg AS diff,
    CASE 
        WHEN total_patients > overall_avg THEN 'Above Average'
        WHEN total_patients = overall_avg THEN 'Average'
        ELSE 'Below Average'
    END AS indicator
FROM (
        SELECT 
            service,
            SUM(patients_admitted) AS total_patients,
            (
                SELECT AVG(total_patients)
                FROM (
                    SELECT 
                        service,
                        SUM(patients_admitted) AS total_patients
                    FROM services_weekly
                    GROUP BY service
                ) AS t
            ) AS overall_avg
        FROM services_weekly
        GROUP BY service
     ) AS x
ORDER BY total_patients DESC;


