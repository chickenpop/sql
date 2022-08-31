
-- 620. Not Boring Movies
-- 홀수인 id 찾기
-- description이 boring이면 제외
-- rating 정렬
SELECT id
     , movie
     , description
     , rating 
  FROM Cinema 
 WHERE mod(id, 2) = 1 
   AND description != 'boring' 
 ORDER BY rating DESC;

-- 홀수 찾는 다른 방법 % 연산자 이용
SELECT id
     , movie
     , description
     , rating 
  FROM Cinema 
 WHERE id % 2 = 1 
   AND description != 'boring' 
 ORDER BY rating DESC;