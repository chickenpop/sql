
-- 175. Combine Two Tables
-- 두 테이블 JOIN
SELECT 
       P.firstName
     , P.lastName
     , A.city
     , A.state
  FROM PERSON P 
  LEFT OUTER JOIN ADDRESS A
    ON P.personId = A.personId;