INSERT INTO "user" (name, password_hash, birth_date)

VALUES ('user1', '123', '2000-01-01'),
       ('user2', '123', '2005-01-01'),
       ('user3', '123', '2010-01-01');

INSERT INTO location (name, address, capacity)
VALUES ('Площадка 1', 'Адрес 1', 1),
       ('Площадка 2', 'Адрес 2', 2),
       ('Площадка 3', 'Адрес 3', 3);


SELECT insert_event(1, 'event1', 'description1', 18, '2025-09-09 15:00:00', '2025-09-09 16:00:00'),
       insert_event(2, 'event2', 'description2', 21, '2025-09-09 17:00:00', '2025-09-09 18:00:00'),
       insert_event(3, 'event3', 'description3', 25, '2025-09-09 19:00:00', '2025-09-09 20:00:00');

INSERT INTO user_event (user_id, event_id)
VALUES (1, 2),
       (1, 3),
       (2, 1),
       (2, 3),
       (3, 2),
       (3, 3);
