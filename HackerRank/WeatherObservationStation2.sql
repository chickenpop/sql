
-- LAT_N, LONG_W의 각각 합계를 구하는데 결과는 소수점 2자리까지만 표현해라
SELECT 
       ROUND(SUM(LAT_N), 2) 
     , ROUND(SUM(LONG_W), 2) 
  FROM STATION;