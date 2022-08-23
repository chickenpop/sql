-- 처음 풀이한 내용
-- order by로 날짜를 정렬하여 LIMIT 1개만 출력
SELECT
       NAME
  FROM ANIMAL_INS
 ORDER BY DATETIME
 LIMIT 1;


-- 서브쿼리를 이용한 풀이
-- 집계함수를 활용하여 WHERE절에 가장 빠른 날짜를 조건으로 사용 검색 
SELECT 
       NAME
FROM ANIMAL_INS
WHERE DATETIME = (SELECT MIN(DATETIME) FROM ANIMAL_INS);