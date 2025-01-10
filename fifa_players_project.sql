--SQL Project

-- Fifa19 Data about players stats 

--Complete Dataset

SELECT 
	* 
FROM
	fifa_db;


--Q1 Count of total players of each nationality.

SELECT
	nationality, COUNT(*) AS total_players
FROM
	fifa_db
GROUP BY 
	nationality
ORDER BY
	nationality;

--Q2 Top 10 Countries having most players.


SELECT TOP 10
	nationality,
	COUNT(*) AS total_players
FROM
	fifa_db
GROUP BY
	nationality
ORDER BY
	COUNT(*) DESC;


--Q3 Average age,overall score,height and weight of players of each country

--age,height and weight columns in this dataset are set as type VARCHAR, first have to convert it
--to an int.

ALTER TABLE fifa_db
ALTER COLUMN age INT;

ALTER TABLE fifa_db
ALTER COLUMN overall INT;

ALTER TABLE fifa_db
ALTER COLUMN weight INT;

ALTER TABLE fifa_db
ALTER COLUMN height INT;
--data error in hieght, have to remove those rows
DELETE FROM fifa_db
WHERE height LIKE '%2020%';



SELECT
	nationality,
	AVG(age) AS avg_age,
	AVG(overall) AS avg_score,
	AVG(height) AS avg_hgt,
	AVG(weight) AS avg_wgt
FROM
	fifa_db
GROUP BY
	nationality
ORDER BY
	nationality;


--Q4 Top 10 countries with younger age average and highest height average

--Countries with younger age average and minimum age
SELECT TOP 10
	nationality,
	AVG(age) AS avg_age,
	MIN(age) AS min_age
FROM
	fifa_db
GROUP BY
	nationality
ORDER BY
	avg_age;

--Countries with highest height average and max height

SELECT TOP 10
	nationality,
	AVG(height) AS avg_height,
	MAX(height) AS max_height
FROM
	fifa_db
GROUP BY
	nationality
ORDER BY
	avg_height DESC;

--Q5 Locate palyers who is/are youngest, highted

---Youngest players

SELECT
	MIN(age) as min_age
FROM 
	fifa_db;

SELECT
	name,
	nationality,
	age
FROM
	fifa_db
WHERE 
	age=16;

---heighted players

SELECT 
	MAX(height) AS max_hgt
FROM
	fifa_db;

SELECT
	name,
	nationality,
	height
FROM
	fifa_db
WHERE
	height=81;


---Q6 Countries Average overall score and max and min score

SELECT
	nationality,
	AVG(overall) AS avg_score,
	MAX(overall) AS max_score,
	MIN(overall) AS min_score
FROM
	fifa_db
GROUP BY
	nationality
ORDER BY
	avg_score DESC;

---Q7 Count of players across the nations categorised based on speacialty.

--To find unique specialities

SELECT DISTINCT
	speciality
FROM
	fifa_db;

SELECT
	nationality,
	speciality,
	COUNT(speciality) AS players_count
FROM
	fifa_db
GROUP BY
	nationality,
	speciality
ORDER BY
	nationality;

---Q8 Average overall score and number of palyers by speacialty


SELECT
	speciality,
	AVG(overall) AS avg_score,
	COUNT(*) AS total_players
FROM
	fifa_db
GROUP BY
	speciality
ORDER BY 
	avg_score DESC,
	total_players DESC;

--Q9 LEFT vs RIGHT foot average scores

SELECT
	preferred_foot,
	AVG(overall) AS avg_score,
	MAX(overall) AS max_score,
	MIN(overall) AS min_score
FROM 
	fifa_db
GROUP BY
	preferred_foot;

--Q10 Top 10 player with most overall score

SELECT TOP 10
	name,
	nationality,
	overall
FROM
	fifa_db
ORDER BY 
	overall DESC;

--Q11 Number of players and average age,height,weight,score of every CLUB

SELECT
	club,
	COUNT(*) AS total_players,
	AVG(overall) AS avg_score,
	AVG(age) AS avg_age,
	AVG(height) AS avg_hgt,
	AVG(weight) AS avg_wgt
FROM
	fifa_db
GROUP BY 
	club
ORDER BY
	club,
	total_players,
	avg_score,
	avg_hgt;


--Q12 Create column to categorise playes based on their overall score
-----players having overall score greater than equal to 90 will be 'Excellent'
-----players with overall score greater than equal to 80 will be 'Best'
-----players with overall score greater than equal to 70 will be 'Good'
-----players with overall score greater than equal to 60 will be 'Average'
-----players with overall score less than 60 will be 'Below Average'

SELECT *,
CASE
	WHEN overall>=90 THEN 'Excellent'
	WHEN overall>=80 THEN 'Best'
	WHEN overall>=70 THEN 'Good'
	WHEN overall>=60 THEN 'Average'
	ELSE 'Below Average'
END AS player_quality
FROM fifa_db;

--Ading player_quality column in fifa_db table

ALTER TABLE fifa_db
ADD player_quality VARCHAR(255);

UPDATE fifa_db
SET player_quality=CASE
	WHEN overall>=90 THEN 'Excellent'
	WHEN overall>=80 THEN 'Best'
	WHEN overall>=70 THEN 'Good'
	WHEN overall>=60 THEN 'Average'
	ELSE 'Below Average'
END




