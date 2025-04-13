CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    birth_date TIMESTAMP NOT NULL
);

CREATE TABLE location (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE event (
    id SERIAL PRIMARY KEY,
    location_id INT NOT NULL REFERENCES location(id),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    minimal_age INT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL
);

CREATE TABLE user_event (
    user_id INT NOT NULL REFERENCES "user"(id),
    event_id INT NOT NULL REFERENCES event(id),
    PRIMARY KEY (user_id, event_id)
);

CREATE OR REPLACE FUNCTION insert_event(
    p_location_id INT,
    p_name VARCHAR,
    p_description VARCHAR,
    p_minimal_age INT,
    p_start_time TIMESTAMP,
    p_end_time TIMESTAMP
) RETURNS VOID AS $$
BEGIN
    -- Check for overlapping events
    IF EXISTS (
        SELECT 1
        FROM event
        WHERE location_id = p_location_id
        AND (
            (p_start_time >= start_time AND p_start_time < end_time) OR
            (p_end_time > start_time AND p_end_time <= end_time) OR
            (p_start_time < start_time AND p_end_time > end_time)
        )
    ) THEN
        RAISE EXCEPTION 'Event times are overlapping with an existing event at this location';
    END IF;

    -- Insert the event
    INSERT INTO event (location_id, name, description, minimal_age, start_time, end_time)
    VALUES (p_location_id, p_name, p_description, p_minimal_age, p_start_time, p_end_time);
END;
$$ LANGUAGE plpgsql;