-- DAY14 Practice Queries

-- Show all staff members and their schedule information
-- (including those with no schedule entries).

SELECT * FROM staff;
SELECT * FROM staff_schedule;

SELECT s.*,
       ss.week,
	   ss.present
	   FROM staff s
	   LEFT JOIN staff_schedule ss
	   ON s.staff_id=ss.staff_id;

-- List all services from services_weekly and their
-- corresponding staff (show services even if no staff assigned).

SELECT * FROM services_weekly;
SELECT * FROM staff;

SELECT sw.service,
       s.staff_id,
	   s.staff_name,
	   s.role
	   FROM services_weekly sw
	   LEFT JOIN staff s
	   ON sw.service=s.service;

-- Display all patients and their
-- service's weekly statistics (if available).

SELECT * FROM patients;
SELECT * FROM services_weekly;

SELECT
       p.patient_id,
	   p.name,
	   p.service,
	   sw.*
	   FROM patients p
RIGHT JOIN services_weekly sw
ON p.service=sw.service;


-- Day14 Challenge
--  Create a staff utilisation report showing all staff members 
--  (staff_id, staff_name, role, service) and the count of weeks they were present (from staff_schedule).
--  Include staff members even if they have no schedule records. 
--  Order by weeks present descending.

SELECT * FROM staff_schedule;
SELECT * FROM staff;

SELECT s.*,
       COUNT(DISTINCT CASE WHEN ss.present = 1 
       THEN ss.week END) AS weeks_present
       FROM staff s
	   LEFT JOIN staff_schedule ss
	   ON s.staff_id=ss.staff_id
	   GROUP BY s.staff_id,
	            s.staff_name,
			    s.role,
			    s.service
	  ORDER BY weeks_present desc;
	 
