-- DAY13 Practice queries

SELECT * FROM patients;
SELECT * FROM staff;

-- Join patients and staff based on their common service field
-- (show patient and staff who work in same service).

SELECT 
p.name,
p.patient_id,
s.staff_name,
s.staff_id,
s.service 
FROM patients p
JOIN staff s ON p.service=s.service
ORDER BY s.service;


-- Join services_weekly with staff to show weekly 
-- service data with staff information.

SELECT * FROM services_weekly;
SELECT * FROM staff;

SELECT
     sv.*,
     s.staff_id,
	 s.staff_name,
	 s.role
	 FROM services_weekly sv
	 JOIN staff s
	 ON sv.service=s.service;


-- Create a report showing patient information along
-- with staff assigned to their service.


	SELECT * FROM patients;
	SELECT * FROM staff;

	SELECT 
	p.*,
	s.staff_id,
	s.staff_name,
	s.role
	FROM patients p
	JOIN staff s
	ON p.service=s.service;

-- DAY13 Challenge

-- Create a comprehensive report showing patient_id, patient name, age, 
-- service, and the total number of staff members available in their service. Only include patients from services
-- that have more than 5 staff members.
-- Order by number of staff descending, then by patient name.

   SELECT p.patient_id,
          p.name,
		  p.age,
		  p.service,
		  COUNT(s.staff_name) AS staff_members
		  FROM patients p
		  JOIN staff s 
		  ON p.service=s.service
		  GROUP BY p.patient_id, 
	s	           p.service,
				   p.age,
				   p.service
		  HAVING COUNT(s.staff_id)>5
		  ORDER BY staff_members desc,
		           p.name asc;