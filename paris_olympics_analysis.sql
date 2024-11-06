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
MODIFY athletes VARCHAR(1000);

ALTER TABLE olympics_results
ADD Gender VARCHAR(10);

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

INSERT INTO olympics_results(country_name, athletes, sport, event_type, Gender)
VALUES ("Australia", "Chris Burton", "Equestrian", "Individual eventing", "Male"),
	   ("Bulgaria", "Boryana Kaleyn", "Gymnastics", "Rhythmic individual all-around", "Female"),
       ("Czech Republic", "Nikola Ogrodníková", "Athletics", "Javelin throw", "Female"),
       ("Denmark", "Anne-Marie Rindom", "Sailing", "ILCA 6", "Female"),
       ("France", "Sarah Steyaert\tCharline Picon", "Sailing", "49er FX", "Female"),
       ("Germany", "Michael Jung", "Equestrian", "Individual eventing", "Male"),
       ("Germany", "Isabell Werth", "Equestrian", "Individual dressage", "Female"),
       ("Germany", "Jessica von Bredow-Werndl", "Equestrian", "Individual dressage", "Female"),
       ("Germany", "Christian Kukuk", "Equestrian", "Individual jumping", "Male"),
       ("Great Britain", "Laura Collett", "Equestrian", "Individual eventing", "Female"),
       ("Great Britain", "Lottie Fry", "Equestrian", "Individual dressage", "Female"),
       ("Kazakhstan", "Nurbek Oralbay", "Boxing", "Middleweight", "Male"),
       ("Kyrgyzstan", "Meerim Zhumanazarova", "Wrestling", "Woman's Freestyle -68 kg", "Female"),
       ("Netherlands", "Maikel van der Vleuten", "Equestrian", "Individual jumping", "Male"),
       ("Netherlands", "Marit Bouwmeester", "Sailing", "ILCA 6", "Female"),
       ("Netherlands", "Sharon van Rouwendaal", "Swimming", "10 km open water", "Female"),
       ("New Zealand", "Isaac McHardie\tWilliam McKenzie", "Sailing", "49er", "Male"),
       ("New Zealand", "Olivia Brett\tLisa Carrington\tAlicia Hoskin\tTara Vaughan", "Canoeing", "K-4 500 m", "Female"),
       ("New Zealand", "Lisa Carrington\tAlicia Hoskin", "Canoeing", "K-2 500 m", "Female"),
       ("New Zealand", "Lisa Carrington", "Canoeing", "K-1 500 m", "Female"),
       ("Norway", "Line Flem Høst", "Sailing", "ILCA 6", "Female"),
       ("Switzerland", "Steve Guerdat", "Equestrian", "Individual jumping", "Male"),
       ("United States", "Iona Barrows\tHans Henken", "Sailing", "49er", "Male");

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

SELECT * FROM games_results;

INSERT INTO games_results(country_rank, country_name, medal, sport, event_type, Gender)
VALUES(53, 'Argentina', 'Bronze', 'Field hockey', 'Women\'s tournament', 'Female'),
      (4, 'Australia', 'Silver', 'Water polo', 'Women\'s tournament', 'Female'),
      (4, 'Australia', 'Bronze', 'Swimming', 'Men\'s 4 x 200 m freestyle relay', 'Male'),
      (4, 'Australia', 'Bronze', 'Basketball', 'Women\'s tournament', 'Female'),
      (20, 'Brazil', 'Silver', 'Football', 'Women\'s tournament', 'Female'),
      (20, 'Brazil', 'Bronze', 'Volleyball', 'Women\'s tournament', 'Female'),
      (12, 'Canada', 'Silver', 'Rugby sevens', 'Women\'s tournament', 'Female'),
      (2, 'China', 'Gold', 'Artistic swimming', 'Team event', 'Female'),
      (2, 'China', 'Silver', 'Field hockey', 'Women\'s tournament', 'Female'),
      (30, 'Croatia', 'Silver', 'Water polo', 'Men\'s tournament', 'Male'),
      (29, 'Denmark', 'Gold', 'Handball', 'Men\'s tournament', 'Male'),
      (29, 'Denmark', 'Bronze', 'Handball', 'Women\'s tournament', 'Female'),
      (75, 'Fiji', 'Silver', 'Rugby sevens', 'Men\'s tournament', 'Male'),
      (5, 'France', 'Gold', 'Rugby sevens', 'Men\'s tournament', 'Male'),
      (5, 'France', 'Gold', 'Judo', 'Mixed Team', 'Mixed'),
      (5, 'France', 'Gold', 'Volleyball', 'Men\'s tournament', 'Male'),
      (10, 'Germany', 'Silver', 'Field hockey', 'Men\'s tournament', 'Male'),
      (10, 'Germany', 'Silver', 'Handball', 'Men\'s tournament', 'Male'),
      (10, 'Germany', 'Bronze', 'Football', 'Women\'s tournament', 'Female'),
      (7, 'Great Britain', 'Gold', 'Swimming', 'Men\'s 4 x 200 m freestyle relay', 'Male'),
      (7, 'Great Britain', 'Gold', 'Rowing', 'Men\'s eight', 'Male'),
      (7, 'Great Britain', 'Silver', 'Athletics', 'Women\'s 4 x 100 m relay', 'Female'),
      (7, 'Great Britain', 'Bronze', 'Rowing', 'Women\'s eight', 'Female'),
      (7, 'Great Britain', 'Bronze', 'Athletics', 'Men\'s 4 x 400m relay', 'Male'),
      (7, 'Great Britain', 'Bronze', 'Athletics', 'Women\'s 4 x 400m relay', 'Female'),
      (72, 'India', 'Bronze', 'Field hockey', 'Men\'s tournament', 'Male'),
      (9, 'Italy', 'Gold', 'Volleyball', 'Women\'s tournament', 'Female'),
      (6, 'Netherlands', 'Gold', 'Field hockey', 'Men\'s tournament', 'Male'),
      (6, 'Netherlands', 'Gold', 'Field hockey', 'Women\'s tournament', 'Female'),
      (6, 'Netherlands', 'Silver', 'Rowing', 'Men\'s eight', 'Male'),
      (6, 'Netherlands', 'Bronze', 'Water polo', 'Women\'s tournament', 'Female'),
      (18, 'Norway', 'Gold', 'Handball', 'Women\'s tournament', 'Female'),
      (42, 'Poland', 'Silver', 'Volleyball', 'Men\'s tournament', 'Male'),
      (27, 'Serbia', 'Gold', 'Water polo', 'Men\'s tournament', 'Male'),
      (44, 'South Africa', 'Bronze', 'Rugby sevens', 'Men\'s tournament', 'Male'),
      (8, 'South Korea', 'Bronze', 'Judo', 'Mixed team', 'Mixed'),
      (15, 'Spain', 'Bronze', 'Handball', 'Men\'s tournament', 'Male'),
      (1, 'United States', 'Gold', 'Gymnastics', 'Women\'s artistic team all-around', 'Female'),
      (1, 'United States', 'Gold', 'Swimming', 'Mixed 4 x 100 m medley relay', 'Mixed'),
      (1, 'United States', 'Gold', 'Swimming', 'Women\'s 4 x 100 m medley relay', 'Female'),
      (1, 'United States', 'Gold', 'Athletics', 'Men\'s 4 x 100 m relay', 'Male'),
      (1, 'United States', 'Gold', 'Athletics', 'Women\'s 4 x 100 m relay', 'Female'),
      (1, 'United States', 'Gold', 'Basketball', 'Men\'s tournament', 'Male'),
      (1, 'United States', 'Gold', 'Football', 'Women\'s tournament', 'Female'),
      (1, 'United States', 'Gold', 'Basketball', 'Women\'s tournament', 'Female'),
      (1, 'United States', 'Silver', 'Swimming', 'Women\'s 4 x 100 m freestyle relay', 'Female'),
      (1, 'United States', 'Silver', 'Swimming', 'Men\'s 4 x 200 m freestyle relay', 'Male'),
      (1, 'United States', 'Silver', 'Swimming', 'Women\'s 4 x 200 m freestyle relay', 'Female'),
      (1, 'United States', 'Silver', 'Swimming', 'Men\'s 4 x 100 m medley relay', 'Male'),
      (1, 'United States', 'Silver', 'Artistic swimming', 'Team', 'Female'),
      (1, 'United States', 'Silver', 'Volleyball', 'Women\'s tournament', 'Female'),
      (1, 'United States', 'Bronze', 'Gymnastics', 'Men\'s artistic team all-around', 'Male'),
      (1, 'United States', 'Bronze', 'Rugby sevens', 'Women\'s tournament', 'Female'),
      (1, 'United States', 'Bronze', 'Rowing', 'Men\'s eight', 'Male'),
      (1, 'United States', 'Bronze', 'Basketball', 'Women\'s 3x3 tournament', 'Female'),
      (1, 'United States', 'Bronze', 'Volleyball', 'Men\'s tournament', 'Male'),
      (1, 'United States', 'Bronze', 'Water polo', 'Men\'s tournament', 'Male');

ALTER TABLE games_results
RENAME COLUMN Gender TO gender;

