-- select from basics

SELECT population FROM world
  WHERE name = 'Germany';
  
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway' , 'Denmark');
  
SELECT name, area FROM world
  WHERE area BETWEEN 200000 and 250000;
  
-- select from world tutorial

SELECT name, continent, population FROM world;

SELECT name
  FROM world
 WHERE population > 200000000
 
SELECT name, GDP/population
 FROM world
WHERE population > 200000000

SELECT name, population/ 1000000
 FROM world
WHERE continent = 'South America';
  
SELECT name, population 
 FROM world
WHERE name IN ('France','Germany','Italy');

SELECT name 
 FROM world
WHERE name LIKE 'United%';

SELECT name,population,area 
 FROM world
WHERE area > '3000000' OR population > 250000000

SELECT name, population, area
 FROM world
WHERE area > 3000000 AND population < 250000000 OR area < 3000000 
AND population > 250000000

SELECT name, ROUND(population/1000000, 2), ROUND(GDP/1000000000, 2) 
 FROM world
WHERE continent = 'South America'

SELECT name, ROUND(GDP/population, -3) 
 FROM world
WHERE GDP >= 1000000000000

SELECT name, capital 
 FROM world
WHERE LENGTH(name) = LENGTH(capital) 

SELECT name, capital 
 FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital

SELECT name
 FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%'
AND name NOT LIKE '% %' AND name LIKE '%o%' AND name LIKE '%u%'

-- SELECT from Nobel Tutorial

SELECT yr, subject, winner
  FROM nobel
WHERE yr = 1950

SELECT winner
  FROM nobel
WHERE yr = 1962
  AND subject = 'Literature'
  
SELECT yr, subject 
 FROM nobel 
WHERE winner = 'Albert Einstein' 

SELECT winner
 FROM nobel
WHERE subject = 'Peace' AND yr >= 2000

SELECT yr,subject, winner 
 FROM nobel
WHERE yr BETWEEN 1980 AND 1989 AND subject ='Literature'

SELECT winner
 FROM nobel
WHERE winner LIKE 'John%'

SELECT * 
 FROM nobel
WHERE (yr = 1980 AND Subject ='Physics' OR yr = 1984 AND subject = 'Chemistry')

SELECT * 
 FROM nobel
WHERE yr = 1980 AND Subject NOT IN ('Medicine','Chemistry')

SELECT *
 FROM nobel
WHERE yr < 1910 AND subject = 'Medicine' OR yr >= 2004 AND subject = 'Literature'

SELECT * FROM nobel
 WHERE winner LIKE 'PETER GRÜNBERG%'

SELECT * FROM nobel
 WHERE winner LIKE 'EUGENE O_NEILL'
 
SELECT winner, yr, subject FROM nobel
WHERE winner LIKE 'sir%' 
ORDER BY yr DESC

SELECT winner,subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'),subject,winner
 
--  SELECT within SELECT Tutorial

SELECT name 
  FROM world
WHERE population >
     (SELECT population 
       FROM world
      WHERE name='Russia')
     
SELECT name
 FROM world 
WHERE GDP/Population > (
  SELECT GDP/Population 
   FROM world
  WHERE name = 'United Kingdom') AND continent = 'Europe'

SELECT name,continent
FROM world
WHERE continent IN (
(SELECT continent FROM world WHERE name = 'Argentina'),
(SELECT continent FROM world WHERE name = 'Australia')
)
ORDER BY name IN ('Argentine'),name,continent
 
SELECT name,population 
 FROM world
WHERE population > (
 SELECT population 
  FROM world
 WHERE name = 'Canada') AND population < (
 SELECT population 
  FROM world
 WHERE name = 'Poland') 

SELECT name,
       CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany')),'%') 
 FROM world 
WHERE continent = 'Europe'
                    
SELECT name 
 FROM world 
WHERE gdp > (SELECt MAX(gdp) FROM world WHERE continent = 'Europe')
 
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area 
     FROM world y
     WHERE y.continent=x.continent AND area>0)
                    
SELECT continent, name FROM world x
  WHERE name <= ALL
    (SELECT name FROM world y
     WHERE y.continent=x.continent AND area>0) 
                    
-- SUM and COUNT
                    
SELECT SUM(population)
FROM world

SELECT DISTINCT(continent)
FROM world
   
SELECT SUM(gdp)
 FROM world
WHERE continent = 'Africa'
                    
SELECT count(name) 
 FROM world
WHERE area >= 1000000
                    
SELECT SUM(population)
 FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')
                    
SELECT continent,COUNT(name)
 FROM world
GROUP BY continent
                    
SELECT continent, COUNT(name)
 FROM world
WHERE population >= 10000000
GROUP BY continent
                    
SELECT continent
 FROM world
GROUP BY continent
HAVING sum(population) >= 100000000
                    
-- The JOIN operation
                    
SELECT matchid, player 
 FROM goal 
 WHERE  teamid = 'GER'
                    
SELECT DISTINCT id,stadium,team1,team2
  FROM game
WHERE id= 1012

SELECT player,teamid,stadium,mdate
  FROM game JOIN goal ON (id=matchid)
WHERE teamid ='GER'

SELECT player, teamid,coach, gtime
  FROM goal JOIN eteam on (teamid=id) 
 WHERE gtime<=10

SELECT mdate,teamname
 FROM game JOIN eteam ON (team1 = eteam.id)
WHERE coach = 'Fernando Santos'

SELECT player
FROM game 
JOIN goal ON (game.id = goal.matchid)
WHERE stadium = 'National Stadium, Warsaw'

SELECT matchid,mdate, COUNT(mdate)
  FROM game JOIN goal ON matchid = id 
 WHERE teamid = 'GER' GROUP BY matchid,mdate

SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1,
team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2
  FROM game JOIN goal ON matchid = id GROUP BY mdate,matchid,team1,team2
ORDER BY mdate,matchid,team1,team2
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
