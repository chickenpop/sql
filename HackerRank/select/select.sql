-- Revising Aggregations - The Count Function
SELECT 
       COUNT(POPULATION)
  FROM CITY
 WHERE POPULATION > 100000;

-- Revising Aggregations - The Sum Function
SELECT 
       SUM(POPULATION)
  FROM CITY
 WHERE DISTRICT = 'California';

-- Revising Aggregations - Averages
SELECT AVG(POPULATION) FROM CITY WHERE DISTRICT = 'California';

-- Average Population
SELECT ROUND(AVG(POPULATION)) FROM CITY ;