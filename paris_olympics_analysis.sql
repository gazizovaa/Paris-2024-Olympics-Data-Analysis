CREATE DATABASE paris2024;
USE paris2024;
ALTER DATABASE paris2024 READ ONLY = 0;
CREATE TABLE medals (
	country_rank INT,
    noc VARCHAR(50),
    gold INT,
    silver INT,
    bronze INT,
    total INT
);

SELECT * FROM medals;

CREATE TABLE olympics_results (
	noc VARCHAR(50),
    medal VARCHAR(10),
    full_name VARCHAR(200),
    sport VARCHAR(30),
    event_type VARCHAR(60),
    event_date VARCHAR(10)
);

SELECT * FROM olympics_results;