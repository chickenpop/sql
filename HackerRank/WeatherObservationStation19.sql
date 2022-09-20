
-- 오답
-- sqrt((x1-x2)^2 + y1-y2)^2)
SELECT 
       ROUND(SQRT(POWER(MIN(LAT_N)-MIN(LONG_W), 2) + POWER(MAX(LAT_N)-MAX(LONG_W), 2)), 4)
  FROM STATION;

-- 정답
-- Euclidean distance 
-- sqrt((x1-y1)^2 + x2-y2)^2)
SELECT 
       ROUND(SQRT(POWER(MIN(LAT_N)-MAX(LAT_N), 2) + POWER(MIN(LONG_W)-MAX(LONG_W), 2)), 4)
  FROM STATION;