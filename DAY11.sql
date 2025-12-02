-- DAY 11 Practice Queries

-- List all unique services in the patients table.

SELECT * FROM patients;
SELECT DISTINCT service FROM patients;

-- Find all unique staff roles in the hospital
SELECT DISTINCT role FROM staff;

-- Get distinct months from the services_weekly table.
SELECT * FROM services_weekly;
SELECT DISTINCT 
To_char(To_date(month::text,'MM'),'FMMonth') as month_name
FROM services_weekly;

-- DAY11 Challenge

--  Find all unique combinations of service and event type from the services_weekly table 
--  where events are not null or none, along with the count of occurrences for each combination.
--  Order by count descending.

SELECT * FROM services_weekly;

SELECT service AS service_category,
event AS event_category,
COUNT(*) as occurence_count
FROM services_weekly
WHERE event IS NOT NULL AND event <> 'none' AND event <> ':'
GROUP BY service, event
ORDER BY occurence_count desc;
