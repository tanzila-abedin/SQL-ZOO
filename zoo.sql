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
 
 
 
 
 
 
 
