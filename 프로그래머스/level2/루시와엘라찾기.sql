-- 처음 풀이한 내용
SELECT
       ANIMAL_ID,
       NAME,
       SEX_UPON_INTAKE
  FROM ANIMAL_INS
 WHERE NAME IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty')
 ORDER BY ANIMAL_ID;


-- MySql 문법 활용
-- LIKE, CONCAT
-- 문자열에 NAME이 있는지 검사
SELECT
       ANIMAL_ID,
       NAME,
       SEX_UPON_INTAKE
  FROM ANIMAL_INS
 WHERE 'Lucy, Ella, Pickle, Rogan, Sabrina, Mitty' LIKE CONCAT('%',NAME,'%')
 ORDER BY ANIMAL_ID;