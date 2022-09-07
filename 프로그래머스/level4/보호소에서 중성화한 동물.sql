
-- JOIN
-- 중성화를 거치지 않은 동물은 Intact 하나라서 
-- 보호소에 들어온 당시 중성화 아닌 동물 Intact
-- 보호소 나갈 당시 Intact가 아니면 중성화한 동물
SELECT 
       O.ANIMAL_ID
     , O.ANIMAL_TYPE
     , O.NAME
  FROM ANIMAL_OUTS O
 INNER JOIN ANIMAL_INS I
 ON O.ANIMAL_ID = I.ANIMAL_ID
 WHERE I.SEX_UPON_INTAKE LIKE '%Intact%' AND O.SEX_UPON_OUTCOME NOT LIKE '%Intact%'
 ORDER BY O.ANIMAL_ID;