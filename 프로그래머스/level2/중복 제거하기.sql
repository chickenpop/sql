-- 중복되는 이름 제거하기
-- 오답
-- COUNT의 NAME 컬럼을 중복제거하기 위해서 DISTINCT를 사용했지만 
-- 실행순서를 잘못 이해하여 NAME 중복이 해소되지 않음
SELECT DISTINCT COUNT(NAME) AS COUNT FROM ANIMAL_INS

-- DISTINCT로 NAME 중복 해소 후 COUNT해주면 정답
SELECT COUNT(DISTINCT NAME) AS COUNT FROM ANIMAL_INS;