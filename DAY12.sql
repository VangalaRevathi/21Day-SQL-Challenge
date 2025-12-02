-- DAY12 Practice Queries

-- Find all weeks in services_weekly where no special event occurred.

SELECT * FROM services_weekly;

SELECT week FROM services_weekly
WHERE event='none';

-- Count how many records have null or empty event values.

SELECT COUNT(patients_admitted) AS Total_patient_records FROM services_weekly
WHERE event is NULL || event ='';

-- List all services that had at least one week with a special event.

SELECT  DISTINCT service,week,event FROM services_weekly
WHERE event IS NOT NULL AND event <>'none';

-- DAY12 Challenge

-- Analyze the event impact by comparing weeks with events vs weeks without events.
-- Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale.
-- Order by average patient satisfaction descending.

SELECT COUNT(week) AS Week_count, ROUND(AVG(patient_satisfaction),2) AS Avg_satisfaction,
ROUND(AVG(staff_morale),2) AS Avg_morale,
CASE 
WHEN event IS NOT NULL AND event <> 'none' THEN 'With Event'
ELSE 'No Event'
END AS event_status
FROM services_weekly
GROUP BY 
CASE 
WHEN event IS NOT NULL AND event <> 'none' THEN 'With Event'
ELSE 'No Event'
END ;
