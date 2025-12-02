--Who entered the CEO’s Office close to the time of the murder?


SELECT employee_id, entry_time,exit_time
FROM keycard_logs
WHERE room = 'CEO Office'
AND entry_time BETWEEN '2025-10-15 20:30:00' AND '2025-10-15 21:30:00'
ORDER BY entry_time,exit_time;

--Who claimed to be somewhere else but was not?
SELECT * 
FROM alibis
WHERE employee_id IN(
SELECT employee_id
FROM keycard_logs
WHERE room = 'CEO Office'
AND entry_time BETWEEN '2025-10-15 20:30:00' AND '2025-10-15 21:30:00'
ORDER BY entry_time,exit_time
);

--Who made or received calls around 20:50–21:00?

SELECT caller_id FROM calls
WHERE call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00';

-- What evidence was found at the crime scene?

SELECT description FROM evidence
WHERE room='CEO Office' AND found_time BETWEEN '2025-10-15 21:00:00' AND '2025-10-15 21:30:00';

-- Which suspect’s movements, alibi, and call activity don’t add up?

SELECT e.employee_id, e.name,e.role,e.department,
       k.entry_time,k.exit_time
FROM employees e
JOIN keycard_logs k
ON e.employee_id=k.employee_id
LEFT JOIN alibis a
ON e.employee_id = a.employee_id
AND a.claim_time BETWEEN '2025-10-15 20:30:00' AND '2025-10-15 21:30:00'
WHERE k.room = 'CEO Office'
AND k.entry_time BETWEEN '2025-10-15 20:30:00' AND '2025-10-15 21:30:00'
ORDER BY k.entry_time,k.exit_time;

