CREATE DATABASE paris2024;
USE paris2024;

-- enable write operations for the paris2024 database
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

ALTER TABLE medals
RENAME COLUMN noc TO country_name;

ALTER TABLE medals
RENAME COLUMN gold TO gold_medals;

ALTER TABLE medals
RENAME COLUMN silver TO silver_medals;

ALTER TABLE medals
RENAME COLUMN bronze TO bronze_medals;

ALTER TABLE medals
RENAME COLUMN total TO total_medals;

ALTER TABLE olympics_results
RENAME COLUMN noc TO country_name;

ALTER TABLE olympics_results
RENAME COLUMN full_name TO athletes;

ALTER TABLE olympics_results
MODIFY COLUMN athletes VARCHAR(2000);

ALTER TABLE olympics_results
ADD Gender VARCHAR(10);

-- increase the length of the 'athletes' column to accommodate more data
ALTER TABLE games_results
MODIFY COLUMN athletes VARCHAR(5000);

-- disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- update the 'Gender' column based on patterns in the 'event_type' column
UPDATE olympics_results
SET Gender = 
	CASE
		WHEN event_type LIKE 'Women%' OR event_type LIKE '%Women%' OR event_type LIKE '% Women%' OR event_type LIKE '%Girl%' OR event_type LIKE 'D%' OR event_type LIKE 'T%' OR event_type LIKE 'Group%' THEN 'Female'
		WHEN event_type LIKE 'Men%' OR event_type LIKE '%Men%' OR event_type LIKE '% Men%' OR event_type LIKE '%Boy%' OR event_type IN('Dressage Team', 'Eventing Team', 'Jumping Team')THEN 'Male'
		WHEN event_type LIKE 'Mixed%' OR event_type LIKE '%Mixed%' OR event_type LIKE 'Eventing%' THEN 'Mixed'
		ELSE event_type IS NOT NULL
	END
WHERE event_type IS NOT NULL;

-- enable safe update mode
SET SQL_SAFE_UPDATES = 1;

-- create the 'games_results' table by joining two tables						
CREATE TABLE games_results AS
	SELECT medals.country_rank, medals.country_name, olympics_results.medal, olympics_results.athletes, olympics_results.sport, 
           olympics_results.event_type, olympics_results.event_date, olympics_results.Gender
	FROM olympics_results 
    CROSS JOIN medals
    ON medals.country_name = olympics_results.country_name;

-- retrieve the total count of gold, silver, and bronze medals for each country	
SELECT country_name,
	   SUM(CASE WHEN medal = 'Gold' THEN 1 ELSE 0 END) AS count_gold_medals,
	   SUM(CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END) AS count_silver_medals,
	   SUM(CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END) AS count_bronze_medals
FROM games_results
GROUP BY country_name;

SELECT * FROM games_results;

ALTER TABLE games_results
RENAME COLUMN Gender TO gender;

ALTER TABLE games_results
ADD record VARCHAR(5);

-- update the 'record' column to 'None' for entries where no records were broken
UPDATE games_results
SET record = 'None'
WHERE record IS NULL;

UPDATE games_results
SET record = 'OB'
WHERE country_name = 'Czech Republic' AND sport = 'Canoeing' AND event_type = 'Men\'s C1 1000 m';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'Dominican Republic' AND sport = 'Athletics' AND event_type = 'Women\'s 400 m';

UPDATE games_results
SET record = 'WR'
WHERE country_name = 'Egypt' AND sport = 'Modern pentathlon' AND event_type = 'Men\'s individual';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'Ethiopia' AND sport = 'Athletics' AND event_type = 'Men\'s marathon';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'United States' AND medal = 'Gold' AND sport = 'Athletics' AND event_type = 'Men\'s 1500 m';

UPDATE games_results
SET record = 'WR'
WHERE country_name = 'United States' AND medal = 'Bronze' AND sport = 'Sport climbing' AND event_type = 'Men\'s speed';

UPDATE games_results
SET record = 'WR'
WHERE country_name = 'United States' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Men\'s 1500 m freestyle';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'United States' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Women\'s 1500 m freestyle';

UPDATE games_results
SET record = 'WR'
WHERE country_name = 'United States' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Mixed 4 x 100 m medley relay';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'China' AND medal = 'Gold' AND sport = 'Shooting' AND event_type = 'Men\'s 10 m air rifle';

UPDATE games_results
SET record = 'WR	'
WHERE country_name = 'China' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Men\'s 100 m freestyle';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'China' AND medal = 'Gold' AND sport = 'Weightlifting' AND event_type = 'Women\'s 59 kg';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'China' AND medal = 'Gold' AND sport = 'Weightlifting' AND event_type = 'Women\'s 49 kg';

UPDATE games_results
SET record = 'WB'
WHERE country_name = 'China' AND medal = 'Silver' AND sport = 'Shooting' AND event_type = 'Women\'s 10 m air rifle';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'France' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Men\'s 400 m individual medley';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'France' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Men\'s 200 m butterfly';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'France' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Men\'s 200 m breaststroke';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'France' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Men\'s 200 m individual medley';

UPDATE games_results
SET record = 'WR'
WHERE country_name = 'Netherlands' AND medal = 'Gold' AND sport = 'Cycling' AND event_type = 'Men\'s team sprint';

UPDATE games_results
SET record = 'WR'
WHERE country_name = 'Netherlands' AND medal = 'Gold' AND sport = 'Cycling' AND event_type = 'Men\'s team sprint';

UPDATE games_results
SET record = 'WR'
WHERE country_name = 'Great Britain' AND medal = 'Gold' AND sport = 'Cycling' AND event_type = 'Women\'s team sprint';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'Great Britain' AND medal = 'Gold' AND sport = 'Shooting' AND event_type = 'Men\'s trap';

UPDATE games_results
SET record = 'OB'
WHERE country_name = 'New Zealand' AND medal = 'Gold' AND sport = 'Canoeing' AND event_type = 'K-1 500 m';

UPDATE games_results
SET record = 'WR'
WHERE country_name = 'Sweden' AND medal = 'Gold' AND sport = 'Athletics' AND event_type = 'Men\'s pole vault';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'Kenya' AND medal = 'Gold' AND sport = 'Athletics' AND event_type = 'Women\'s 1500 m';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'Norway' AND medal = 'Gold' AND sport = 'Weightlifting' AND event_type = 'Women\'s 81 kg';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'Ireland' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Men\'s 800 m freestyle';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'Jamaica' AND medal = 'Gold' AND sport = 'Athletics' AND event_type = 'Men\'s Discus throw';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'Guatemala' AND medal = 'Gold' AND sport = 'Shooting' AND event_type = 'Women\'s trap';

UPDATE games_results
SET record = 'OR'
WHERE country_name = 'Pakistan' AND medal = 'Gold' AND sport = 'Athletics' AND event_type = 'Men\'s javelin throw';

-- analysis of Olympic results
-- analyze which country won the highest number of medals in each sport
SELECT country_name, max_medals AS highest_number_of_medals, sport
FROM (
    SELECT country_name, sport, COUNT(medal) AS total_medals,
           MAX(COUNT(medal)) OVER (PARTITION BY country_name) AS max_medals
    FROM games_results
    GROUP BY country_name, sport
) AS subquery_table
WHERE total_medals = max_medals
ORDER BY highest_number_of_medals DESC, country_name ASC, sport ASC;

-- compare the number of medals won by male and female athletes for each sport
SELECT country_name, gender, sport, COUNT(medal) AS total_medals
FROM games_results
GROUP BY country_name, gender, sport
ORDER BY total_medals DESC, sport ASC, gender ASC;

-- identify male and female athletes with the highest number of medals in each sport
SELECT athletes, gender, MAX(total_medals) AS max_medals, sport
FROM (SELECT athletes, gender, COUNT(medal) AS total_medals, sport
      FROM games_results
      GROUP BY athletes, gender, sport
) AS derived_table
WHERE gender IN('Male', 'Female')
GROUP BY athletes, gender, sport
ORDER BY max_medals DESC;

-- find the date on which the highest number of medals were won by male and female athletes
SELECT gender, MAX(total_medals) AS max_medals, event_date
FROM (
    SELECT gender, COUNT(medal) AS total_medals, event_date
    FROM games_results
    GROUP BY gender, event_date
) AS derived_table
GROUP BY gender, event_date
ORDER BY max_medals DESC, event_date ASC;

-- identify the countries whose athletes broke Olympic or World Records (OR, WR)
SELECT country_name, athletes, record
FROM games_results
WHERE record LIKE '_R'
ORDER BY country_name, record ASC;

-- find the first athlete to break a record (OR, WR) and the date it occurred 
SELECT athletes, record, MIN(event_date)
FROM games_results
WHERE record LIKE '_R'
GROUP BY athletes, record;

-- Find the top athlete(s) with the most medals in each country
SELECT country_name, athletes, COUNT(medal) AS total_medals
FROM games_results
GROUP BY country_name, athletes
ORDER BY total_medals DESC;






