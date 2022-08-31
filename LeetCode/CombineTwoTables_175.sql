
-- 175. Combine Two Tables
-- 한쪽 테이블 데이터 유무와 상관없이 두 테이블 JOIN
SELECT 
       P.firstName
     , P.lastName
     , A.city
     , A.state
  FROM PERSON P 
  LEFT OUTER JOIN ADDRESS A
    ON P.personId = A.personId;