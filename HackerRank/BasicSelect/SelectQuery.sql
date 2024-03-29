
-- Revising the Select Query I
-- 인구가 100000 이상이면서 국가코드가 USA
SELECT * FROM CITY WHERE POPULATION >= 100000 AND CountryCode = 'USA';

-- Select All
SELECT * FROM CITY;
SELECT ID, NAME, COUNTRYCODE, DISTRICT, POPULATION FROM CITY;

-- Select By ID
SELECT ID, NAME, COUNTRYCODE, DISTRICT, POPULATION FROM CITY WHERE ID = 1661;

-- Japanese Cities' Attributes
SELECT ID, NAME,  COUNTRYCODE, DISTRICT, POPULATION FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Japanese Cities' Names
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Weather Observation Station 1
SELECT CITY, STATE FROM STATION;

-- Higher Than 75 Marks
-- marks가 75보다 크고, 마지막 문자열 3개가 동일한 경우 ID로 정렬
SELECT NAME FROM STUDENTS WHERE MARKS > 75 ORDER BY RIGHT(NAME, 3), ID; 

-- Employee Names
-- 직원 이름 정렬
SELECT NAME FROM EMPLOYEE ORDER BY NAME;

-- Employee Salaries
-- 월급 2000 이상 10개월 미만인 직원
SELECT NAME FROM EMPLOYEE WHERE SALARY >= 2000 AND MONTHS < 10 ORDER BY EMPLOYEE_ID;

-- African Cities
-- 아프리카 대륙 있는 도시 이름
SELECT C1.NAME 
  FROM CITY C1 
 INNER JOIN COUNTRY C2 ON C1.COUNTRYCODE = C2.CODE 
 WHERE C2.CONTINENT = 'Africa';

-- Average Population of Each Continent
-- 각 대륙의 평균 인구수를 내림해서 출력
SELECT C2.CONTINENT 
     , FLOOR(AVG(C1.POPULATION)) 
  FROM CITY C1 
 INNER JOIN COUNTRY C2 ON C1.COUNTRYCODE = C2.CODE
 GROUP BY C2.CONTINENT;

-- Type of Triangle
-- 조건에 따른 삼각형 이름 출력하기
SELECT 
       CASE 
           WHEN (A + B) <= C OR (A + C) <= B OR (B + C) <= A THEN 'Not A Triangle'
           WHEN (A = B) AND (A = C) THEN 'Equilateral'
           WHEN (A = B) OR (A = C) OR (B = C) THEN 'Isosceles'
           WHEN (A <> B) AND (A <> C) THEN 'Scalene'
       END
  FROM TRIANGLES;

-- The Blunder
-- 치횐하기
SELECT CEIL(AVG(SALARY) - AVG(REPLACE(SALARY, '0', ''))) FROM EMPLOYEES;