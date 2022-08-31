
-- 182. Duplicate Emails
-- 중복되는 이메일만 조회
SELECT email 
  FROM Person 
 GROUP BY EMAIL 
HAVING COUNT(email) > 1;