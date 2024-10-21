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
ADD Gender VARCHAR(10);

CASE
    WHEN event_type IN('Men\'s Greco-Roman 60 kg', 'Men\'s Greco-Roman 67 kg', 'Men\'s Greco-Roman 77 kg', 'Men\'s Greco-Roman 87 kg',
                       'Men\'s Greco-Roman 97 kg', 'Men\'s Greco-Roman 130 kg', 'Men\'s freestyle 57 kg', 'Men\'s freestyle 65 kg',
                       'Men\'s freestyle 74 kg', 'Men\'s freestyle 86 kg', 'Men\'s freestyle 97 kg', 'Men\'s freestyle 125 kg',
                       'Men\'s 61 kg', 'Men\'s 73 kg', 'Men\'s 89 kg', 'Men\'s 102 kg', 'Men\'s +102 kg', 'Men\'s individual',
                       'Men\'s singles', 'Men\'s doubles', 'Men -58 kg', 'Men -68 kg', 'Men -80 kg', 'Men +80 kg', 'Men\'s team',
                       'Men\'s 50 m freestyle', 'Men\'s 100 m freestyle', 'Men\'s 200 m freestyle', 'Men\'s 400 m freestyle',
                       'Men\'s 800 m freestyle', 'Men\'s 1500 m freestyle', 'Men\'s 100 m backstroke', 'Men\'s 200 m backstroke',
                       'Men\'s 100 m breaststroke', 'Men\'s 200 m breaststroke', 'Men\'s 100 m butterfly', 'Men\'s 200 m butterfly',
                       'Men\'s 200 m individual medley', 'Men\'s 400 m individual medley', 'Men\'s 4 x 100 m freestyle relay',
                       'Men\'s 4 x 200 m freestyle relay', 'Men\'s 4 x 100 m medley relay', 'Men\'s boulder & lead', 'Men\'s speed',
                       'Men\'s street', 'Men\'s park', '10 m air rifle men', '50 m rifle 3 positions men', '10 m air pistol men',
                       '25 m rapid fire pistol men', 'trap men', 'skeet men', 'Men\'s windsurfing', 'Men\'s kite', 'Men\'s dinghy',
                       'Men\'s skiff', 'Men\'s pair', 'Men\'s double sculls', 'Men\'s four', 'Men\'s single sculls', 'Lightweight Men\'s double sculls',
                       'Men\'s quadruple sculls', 'Men\'s eight', 'Men\'s 10 km', 'Men -60 kg', 'Men -66 kg', 'Men -73 kg', 'Men -81 kg',
                       'Men -90 kg', 'Men -100 kg', 'Men +100 kg', 'Men\'s individual stroke play', 'Men\'s épée individual',
                       'Men\'s foil individual', 'Men\'s sabre individual', 'Men\'s épée team', 'Men\'s foil team', 'Men\'s sabre team',
                       'Men\'s 3 m springboard', 'Men\'s 10 m platform', 'Men\'s synchronised 3 m springboard', 'Men\'s synchronised 10 m platform',
                       'Men\'s team sprint', 'Men\'s sprint', 'Men\'s keirin', 'Men\'s team pursuit', 'Men\'s omnium', 'Men\'s madison',
                       'Men\'s road race', 'Men\'s individual time trial', 'Men\'s cross-country', 'Men\'s kayak single 1000 m', 'Men\'s kayak double 500 m',
                       'Men\'s kayak four 500 m', 'Men\'s canoe single 1000 m', 'Men\'s canoe double 500 m', 'Men\'s kayak single', 'Men\'s canoe single',
                       'Men\'s kayak cross', 'Men\'s 51 kg', 'Men\'s 57 kg', 'Men\'s 63.5 kg', 'Men\'s 71 kg', 'Men\'s 80 kg', 'Men\'s 92 kg',
                       'Men\'s +92 kg', 'Men\'s 100 m', 'Men\'s 200 m', 'Men\'s 400 m', 'Men\'s 800 m', 'Men\'s 1500 m', 'Men\'s 5000 m', 'Men\'s 10,000 m',
                       'Men\'s marathon', 'Men\'s 3000 m steeplechase', 'Men\'s 110 m Hurdles', 'Men\'s 400 m Hurdles', 'Men\'s high jump', 'Men\'s pole vault',
                       'Men\'s long jump', 'Men\'s triple jump', 'Men\'s shot put', 'Men\'s discus throw', 'Men\'s hammer throw', 'Men\'s javelin throw',
                       'Men\'s Decathlon', 'Men\'s 20 km race walk', 'Men\'s 4 x 100 m relay', 'Men\'s 4 x 400 m relay', 'Men\'s all-around', 'Men\'s floor exercise',
                       'Men\'s pommel horse', 'Men\'s rings', 'Men\'s vault', 'Men\'s parallel bars', 'Men\'s horizontal bar')
    THEN 'Male'
    WHEN event_type IN('Women\'s individual', 'Women\'s team', 'Women\'s all-around', 'Women\'s vault', 'Women\'s uneven bars', 'Women\'s balance team',
                       'Women\'s floor exercise', 'Duet', 'Team', 'Women\'s 100 m', 'Women\'s 200 m', 'Women\'s 400 m', 'Women\'s 800 m', 'Women\'s 1500 m',
                       'Women\'s 5000 m', 'Women\'s 10,000 m', 'Women\'s marathon', 'Women\'s 3000 m steeplechase', 'Women\'s 100 m hurdles', 'Women\'s 400 m hurdles',
                       'Women\'s high jump', 'Women\'s pole vault', 'Women\'s long jump', 'Women\'s triple jump', 'Women\'s shot put', 'Women\'s discus throw',
                       'Women\'s hammer throw', 'Women\'s javelin throw', 'Women\'s heptathlon', 'Women\'s 20 km race walk', 'Women\'s 4 x 100 m relay', 'Women\'s 4 x 400 m relay',
                       'Women\'s singles', 'Women\'s doubles', 'Women', 'Women\'s 50 kg', 'Women\'s 54 kg', 'Women\'s 57 kg', 'Women\'s 60 kg', 'Women\'s 66 kg', 'Women\'s 75 kg',
                       'B-Girls')
	THEN 'Female'
    ELSE NULL
END;
