-- DAY 15 Practice Queries

-- Join patients, staff, and
-- staff_schedule to show patient service and staff availability.

SELECT * FROM patients;
SELECT * FROM staff;
SELECT * FROM staff_schedule;


SELECT p.*,
       s.staff_id,
	   s.staff_name,
	   s.role,
	   s.service,
	   COUNT(ss.week) AS weeks_available
	   FROM patients p
	   LEFT JOIN staff s
	   ON p.service=s.service
	   LEFT JOIN staff_schedule ss
	   ON s.staff_id=ss.staff_id
	   GROUP BY 
       p.patient_id,
       p.name,
       p.service,
       s.staff_id,
       s.staff_name,
       s.role
	   ORDER BY p.patient_id,s.staff_id;

-- Combine services_weekly with staff and 
-- staff_schedule for comprehensive service analysis.

SELECT * FROM services_weekly;
SELECT * FROM staff;
SELECT * FROM staff_schedule;

SELECT sw.*,
       s.staff_id,
	   s.staff_name,
	   s.role,
	   ss.week AS available_week
	   FROM services_weekly sw
	   LEFT JOIN staff s
	   ON sw.service=s.service
	   LEFT JOIN staff_schedule ss
	   ON ss.staff_id=s.staff_id
	   ORDER BY sw.service, s.staff_id, ss.week;

-- Create a multi-table report showing 
-- patient admissions with staff information.

SELECT sw.*,
       s.staff_id,
	   s.staff_name,
	   s.role,
	   ss.week AS available_week
	   FROM services_weekly sw
	   LEFT JOIN staff s
	   ON sw.service=s.service
	   LEFT JOIN staff_schedule ss
	   ON ss.staff_id=s.staff_id
	   ORDER BY sw.service, s.staff_id, ss.week;

-- Create a multi-table report showing 
-- patient admissions with staff information.

SELECT p.*,
       s.staff_id,
	   s.staff_name,
	   s.role,
	   ss.week AS available_week
	   FROM patients p
	   LEFT JOIN staff s
	   ON p.service=s.service
	   LEFT JOIN staff_schedule ss
	   ON ss.staff_id=s.staff_id
	   ORDER BY p.service, s.staff_id, ss.week;

-- DAY15 Challenge

 /*Create a comprehensive service analysis report for week 20 showing:
 service name, total patients admitted that week, total patients refused,
 average patient satisfaction, count of staff assigned to service, and
 count of staff present that week.*/

SELECT 
    sw.service,
    SUM(sw.patients_admitted) AS total_patients_admitted,
    SUM(sw.patients_refused) AS total_patients_refused,
    ROUND(AVG(sw.patient_satisfaction), 2) AS avg_satisfaction,
    COUNT(DISTINCT s.staff_id) AS staff_assigned,
    COUNT(DISTINCT ss.staff_id) AS staff_present_week
FROM services_weekly sw
LEFT JOIN staff s
    ON sw.service = s.service
LEFT JOIN staff_schedule ss
    ON s.staff_id = ss.staff_id 
   AND ss.week = 20
WHERE sw.week = 20
GROUP BY sw.service
ORDER BY total_patients_admitted DESC;

