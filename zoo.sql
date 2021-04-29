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

-- More JOIN operations

SELECT id, title
 FROM movie
 WHERE yr=1962

SELECT yr
FROM movie
WHERE title ='Citizen Kane'

SELECT id,title,yr
FROM movie
WHERE title LIKE 'star trek%' ORDER BY yr

SELECT actor.id FROM movie
JOIN actor ON (movie.id = actor.id)
WHERE name = 'Glenn Close'

SELECT id
FROM movie
WHERE title = 'Casablanca'

SELECT name FROM casting
JOIN actor ON casting.actorid = actor.id
WHERE movieid = (SELECT id
FROM movie
WHERE title = 'Casablanca') and casting.actorid =actor.id

SELECT name FROM casting
JOIN actor ON casting.actorid = actor.id
WHERE movieid = (SELECT id
FROM movie
WHERE title = 'Alien') and casting.actorid =actor.id

SELECT DISTINCT title FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'

SELECT DISTINCT title FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'
AND ord <> 1

SELECT DISTINCT title,name FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE yr = 1962
AND ord = 1

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Doris Day'
GROUP BY yr
HAVING COUNT(title) > 1

SELECT DISTINCT title,name FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE ord = 1 AND movieid IN (SELECT movieid FROM casting JOIN actor ON actorid=id WHERE name = 'Julie Andrews')

SELECT DISTINCT name
FROM actor
JOIN casting on actorid =actor.id
GROUP BY name,ord
HAVING COUNT(name) >= 15 AND ord = 1

SELECT title, COUNT(movieid)
FROM movie
JOIN casting ON casting.movieid = movie.id
WHERE yr = 1978
GROUP BY movieid,title
ORDER BY COUNT(movieid) DESC ,title

SELECT name From actor
WHERE id IN (
SELECT actorid FROM casting
WHERE movieid IN(
SELECT movieid FROM casting
JOIN actor ON actor.id = casting.actorid
WHERE name = 'Art Garfunkel')) AND name <> 'Art Garfunkel' ORDER BY name

-- Using Null

SELECT name
FROM teacher
WHERE dept IS NULL

SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)


SELECT name, 
CASE 
  WHEN mobile IS NULL THEN '07986 444 2266' 
  ELSE mobile 
  END
FROM teacher

SELECT name, COALESCE(mobile,'07986 444 2266')
FROM teacher

SELECT teacher.name, COALESCE(dept.name,'None')
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)

SELECT COUNT(name),COUNT(mobile)
FROM teacher

SELECT dept.name ,COUNT(dept)
From teacher RIGHT JOIN dept ON dept.id = teacher.dept
GROUP BY dept.name

SELECT name,
CASE dept
WHEN 1 THEN 'Sci'
WHEN 2 THEN 'Sci'
ELSE 'Art'
END
FROM teacher

SELECT name,
CASE dept
WHEN 1 THEN 'Sci'
WHEN 2 THEN 'Sci'
WHEN 3 THEN 'Art'
ELSE 'None'
END
FROM teacher

-- Self Join
SELECT COUNT(id)
FROM stops

SELECT id
FROM stops
WHERE name= 'Craiglockhart'

SELECT id,name
FROM stops
JOIN route ON stops.id = route.stop
WHERE company = 'LRT' AND num = '4'

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop =149


SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name ='London Road'

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 and b.stop =137

SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name = 'Tollcross'

SELECT stopb.name,a.company,a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart'

SELECT DISTINCT a.name, b.name
  FROM stops a JOIN route z ON a.id=z.stop
  JOIN route y ON y.num = z.num
  JOIN stops b ON y.stop=b.id
 WHERE a.name='Craiglockhart' AND b.name ='Haymarket'

SELECT S2.id, S2.name, R2.company, R2.num
  FROM stops S1, stops S2, route R1, route R2
 WHERE S1.name='Haymarket' AND S1.id=R1.stop
   AND R1.company=R2.company AND R1.num=R2.num
   AND R2.stop=S2.id AND R2.num='2A'

SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
 WHERE stopa.name='Tollcross'
SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
 WHERE stopa.name='Tollcross'

                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
