
-- 좌표 P1, P2의 거리를 소수점 4자리까지 구하여라
SELECT 
       ROUND((MAX(LAT_N) - MIN(LAT_N) + MAX(LONG_W) - MIN(LONG_W)), 4)
  FROM STATION;