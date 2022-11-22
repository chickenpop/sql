
-- 595. Big Countries
-- 인구수 또는 지역 크기 범위 설정
SELECT 
       name
     , population
     , area
  FROM world
 WHERE area >= 3000000 
    OR population >= 25000000;