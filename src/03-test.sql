


SELECT e.id, e.name, e.description, e.minimal_age, e.start_time, e.end_time
FROM event e
JOIN location l ON e.location_id = l.id;


INSERT INTO user_event (user_id, event_id)
SELECT 1, 1
FROM event e
WHERE e.id = 1
AND e.minimal_age <= (SELECT EXTRACT(YEAR FROM age(birth_date)) FROM "user" WHERE id = 1);



SELECT * FROM "user";
SELECT * FROM location;
SELECT * FROM event;
SELECT * FROM user_event;