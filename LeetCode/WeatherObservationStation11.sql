-- 틀린 풀이 1
SELECT
       DISTINCT CITY
  FROM STATION
 WHERE LEFT(CITY, 1) NOT IN('a', 'e', 'i', 'o', 'u') AND RIGHT(CITY, 1) NOT IN('a', 'e', 'i', 'o', 'u');

-- 정답
-- 첫글자 혹은 마지막 글자 중 하나라도 모음이면 탈락이기 때문에 OR
SELECT
       DISTINCT CITY
  FROM STATION
 WHERE LEFT(CITY, 1) NOT IN('a', 'e', 'i', 'o', 'u') 
    OR RIGHT(CITY, 1) NOT IN('a', 'e', 'i', 'o', 'u');