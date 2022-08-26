-- String, Date
-- 이름에 el이 들어가는 동물 찾기
-- MySQL은 특별한 설정을 하지 않는 경우 대소문자를 구분하지 않는다.
SELECT 
       ANIMAL_ID,
       NAME
  FROM ANIMAL_INS
 WHERE ANIMAL_TYPE = 'Dog' AND NAME LIKE '%EL%'
 ORDER BY NAME;