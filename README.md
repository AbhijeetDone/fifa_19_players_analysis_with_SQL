# FIFA 19 Players Analysis Using SQL
In this project I have collected data of players of FIFA 2019 world cup and used that data to analyse players distribution over the globe and thier physical and performance stats.

## Objectives
1.Analyzing performance stats of players.

2.Finding Average physical stats of players representing diffrent nations.

3.Categorising players on the basis of overall score.

## Project Walktrough

Complete Dataset
```
SELECT 
	* 
FROM
	fifa_db;
```

Q1. Count of total players of each nationality.
--
This question will help to understand number of players across the globe representing thier respective nations.

```
SELECT
	nationality, COUNT(*) AS total_players
FROM
	fifa_db
GROUP BY 
	nationality
ORDER BY
	nationality;
```

Q2. Top 10 Countries having most players.
--
This shows 10 countries which have most players to represent in world cup.

```
SELECT TOP 10
	nationality,
	COUNT(*) AS total_players
FROM
	fifa_db
GROUP BY
	nationality
ORDER BY
	COUNT(*) DESC;
```

Q3. Average age,overall score,height and weight of players of each country.
--
In a game like football physical strength helds vital importance. this question helps to average physical strength of the players of each nation.

Before solving this question I had to do some cleaning on the data like converting datatype of height and weight column to integer.

--age,height and weight columns in this dataset are set as type VARCHAR, first have to convert it to an INT.

```
ALTER TABLE fifa_db
ALTER COLUMN age INT;

ALTER TABLE fifa_db
ALTER COLUMN overall INT;

ALTER TABLE fifa_db
ALTER COLUMN weight INT;

ALTER TABLE fifa_db
ALTER COLUMN height INT;
```
Some of the cells of data in height column gaves an error which were not possible to convert in INT.

--data error in hieght, have to remove those rows.
```
DELETE FROM fifa_db
WHERE height LIKE '%2020%';
```
After the cleaning and datatype converting process we are finally able to pull out desired information.
```
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
```

Q4. Top 10 countries with younger age average and highest height average.
--
On the basis of the data we pulled out in previous statement we decide to narrow down our search to find out best 10 nations in the terms of young age and height.

--Countries with younger age average and minimum age.
```
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
```

--Countries with highest height average and max height.
```
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
```

Q5. Locate palyers who is/are youngest, highted.
--
In this question we tried to find out who are the youngest and hieghted players are.

--Youngest players.

To find out who are the most youngest players have to find out what the minimum age is.
```
SELECT
	MIN(age) as min_age
FROM 
	fifa_db;
```
That returns 16 is the least age of the players in present dataset.

```
SELECT
	name,
	nationality,
	age
FROM
	fifa_db
WHERE 
	age=16;
```

--Heighted players.

To find out who are the most heighted players have to find out what the maximum height is.
```
SELECT 
	MAX(height) AS max_hgt
FROM
	fifa_db;
```
That returns 81 is the maximum height of the players in present dataset.

```
SELECT
	name,
	nationality,
	height
FROM
	fifa_db
WHERE height=81;
```

Q6. Countries Average overall score and max and min score.
--
Shows performance scores stats of each country.

```
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
```

Q7. Count of players across the nations categorised based on speacialty.
--
Distribution of players in diffrent speacialities for the nations.

--To find unique specialities.
```
SELECT DISTINCT
	speciality
FROM
	fifa_db;
```
```
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
```

Q8. Average overall score and number of palyers by speacialty.
--
Its shows overall performance score average for diffrent speacialty.
```
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
```

Q9. LEFT vs RIGHT foot average scores.
--
This copmares stats of Right foot player to Left foot player or the way around.
```
SELECT
	preferred_foot,
	AVG(overall) AS avg_score,
	MAX(overall) AS max_score,
	MIN(overall) AS min_score
FROM 
	fifa_db
GROUP BY
	preferred_foot;
```

Q10. Top 10 player with most overall score.
--
Among all the players who are the 10 best players based on the overall score.
```
SELECT TOP 10
	name,
	nationality,
	overall
FROM
	fifa_db
ORDER BY 
	overall DESC;
```

Q11. Number of players and average age,height,weight,score of every CLUB.
--
It is the same like done for the nations before instead we are grouping players on the basis of clubs they play for.
```
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
```

Q12. Create column to categorise playes based on their overall score.
--
--players having overall score greater than equal to 90 will be 'Excellent'

--players with overall score greater than equal to 80 will be 'Best'

--players with overall score greater than equal to 70 will be 'Good'

--players with overall score greater than equal to 60 will be 'Average'

--players with overall score less than 60 will be 'Below Average'

Here we try to give tags to the players based on their overall performance score.
```
SELECT *,
CASE
	WHEN overall>=90 THEN 'Excellent'
	WHEN overall>=80 THEN 'Best'
	WHEN overall>=70 THEN 'Good'
	WHEN overall>=60 THEN 'Average'
	ELSE 'Below Average'
END AS player_quality
FROM fifa_db;
```

We want this new column to be part of over dataset fifa_db

--Ading player_quality column in fifa_db table
```
ALTER TABLE fifa_db
ADD player_quality VARCHAR(255);
```
```
UPDATE fifa_db
SET player_quality=CASE
	WHEN overall>=90 THEN 'Excellent'
	WHEN overall>=80 THEN 'Best'
	WHEN overall>=70 THEN 'Good'
	WHEN overall>=60 THEN 'Average'
	ELSE 'Below Average'
END
```

With the solutions of these 12 questions, I here conclude my fifa_19_players_analysis_with_SQL.
--
