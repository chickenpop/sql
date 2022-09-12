-- 가장 인구가 많은 도시와 적은 도시의 차이
SELECT MAX(POPULATION) - MIN(POPULATION)
  FROM CITY; 