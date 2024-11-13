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

-- modiy the length of data type in athletes column
ALTER TABLE games_results
MODIFY COLUMN athletes VARCHAR(5000);

-- disable safe update mode
SET SQL_SAFE_UPDATES = 0;

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

DELETE FROM olympics_results
WHERE medal IS NULL;

UPDATE olympics_results
SET Gender = "Female"
WHERE Gender = "1" AND athletes IN("Boryana Kaleyn", "Nikola Ogrodníková", "Anne-Marie Rindom", 
								   "Sarah Steyaert                        Charline Picon", 
                                   "Isabell Werth", "Jessica von Bredow-Werndl","Laura Collett", "Lottie Fry", 
                                   "Meerim Zhumanazarova", "Marit Bouwmeester",
                                   "Sharon van Rouwendaal", 
                                   "Olivia Brett
Lisa Carrington
Alicia Hoskin
Tara Vaughan",
                                   "Lisa Carrington
Alicia Hoskin", "Lisa Carrington", "Line Flem Høst");
                                   
UPDATE olympics_results
SET Gender = "Male"
WHERE Gender = "1" AND athletes IN("Chris Burton", "Michael Jung", "Christian Kukuk", "Nurbek Oralbay", "Maikel van der Vleuten",
								   "Isaac McHardie
William McKenzie",                                 
								   "Steve Guerdat", 
                                   "Iona Barrows                                         Hans Henken ");
								
CREATE TABLE games_results AS
	SELECT medals.country_rank, medals.country_name, olympics_results.medal, olympics_results.athletes, olympics_results.sport, 
           olympics_results.event_type, olympics_results.event_date, olympics_results.Gender
	FROM olympics_results 
    CROSS JOIN medals
    ON medals.country_name = olympics_results.country_name;
	
SELECT country_name,
	   SUM(CASE WHEN medal = 'Gold' THEN 1 ELSE 0 END) AS count_gold_medals,
	   SUM(CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END) AS count_silver_medals,
	   SUM(CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END) AS count_bronze_medals
FROM games_results
GROUP BY country_name;

SELECT COUNT(*) FROM games_results;

ALTER TABLE games_results
RENAME COLUMN Gender TO gender;

ALTER TABLE games_results
ADD record VARCHAR(5);

-- set to None if no records are broken
UPDATE games_results
SET record = 'None'
WHERE record IS NULL;
-- --------------------------------------------------------------------------------------
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
WHERE country_name = 'United States' AND medal = 'Gold' AND sport = 'Swimming' AND event_type = 'Women\'s 4 x 100 m medley relay';

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
-- --------------------------------------------------------------------------------------
-- update null rows in needed rows  
UPDATE games_results
SET athletes = 'Samuel Reardon\nLaviai Nielsen\nAlex Haydock-Wilson\nAmber Anning\nNicole Yeargin'
WHERE country_name = 'Great Britain' AND sport = 'Athletics' AND event_type = 'Mixed 4 x 400 m relay';

INSERT INTO games_results(country_rank, country_name, medal, athletes, sport, event_type, event_date, gender, record)
VALUES(7, 'Great Britain', 'Bronze', 'Lewis Davey\nCharlie Dobson\nToby Harries (h)\nAlex Haydock-Wilson\nMatthew Hudson-Smith\nSamuel Reardon (h)', 'Athletics', 'Men\'s 4 x 400 m relay', '8/10/11', 'Male', 'None'),
      (7, 'Great Britain', 'Bronze', 'Amber Anning\nYemi Mary John (h)\nHannah Kelly (h)\nLaviai Nielsen\nLina Nielsen (h)\nVictoria Ohuruogu\nJodie Williams (h)\nNicole Yeargin', 'Athletics', 'Women\'s 4 x 400 m relay', '8/10/11', 'Female', 'None');
