-- q03_aggregatioin_function.sql

-- 1. tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라의 개수?? -> 7개
SELECT 
    COUNT(CASE WHEN continent ='AS' THEN 1 END ||
    CASE WHEN continent ='EU' THEN 1 END) as "아시아+유럽"
FROM tblCountry;
        

-- 2. 인구수가 7000 ~ 20000 사이인 나라의 개수?? -> 2개
SELECT COUNT(CASE WHEN population BETWEEN 7000 and 20000 THEN 1 END) as "인구수 7000~20000" 
FROM tblCountry;


-- 3. hr.employees. job_id > 'IT_PROG' 중에서 급여가 5000불이 넘는 직원이 몇명? -> 2명
SELECT 
    COUNT(CASE WHEN job_id = 'IT_PROG' and salary >= 5000 THEN 1 END) as "IT_PROG, 5000이상"
FROM employees;


-- 4. tblInsa. tel. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) -> 42명
SELECT 
    COUNT(CASE WHEN (not tel like '010-%-%') AND tel IS NOT NULL THEN 1 END) as "010외 연락처"
FROM tblinsa;

-- 5. city. 서울, 경기, 인천 -> 그 외의 지역 인원수? -> 18명
SELECT 
    COUNT(CASE WHEN not(city in ('서울', '경기', '인천')) THEN 1 END) as "수도권외지역"
FROM tblinsa;
        

-- 6. 여름태생(7~9월) + 여자 직원 총 몇명? -> 7명
SELECT 
    COUNT(CASE WHEN ssn like('__07%-2%') or ssn like('__08%-2%') or ssn like('__09%-2%') THEN 1 END) as "여름태생 여자직원"
FROM tblinsa;
    

-- 7. 개발부 + 직위별 인원수? -> 부장 ?명, 과장 ?명, 대리 ?명, 사원 ?명
SELECT 
    COUNT(CASE WHEN buseo = '개발부' and jikwi = '부장' THEN 1 END) as "개발부 부장", -- 1
    COUNT(CASE WHEN buseo = '개발부' and jikwi = '과장' THEN 2 END) as "개발부 과장", -- 2
    COUNT(CASE WHEN buseo = '개발부' and jikwi = '대리' THEN 3 END) as "개발부 대리", -- 2
    COUNT(CASE WHEN buseo = '개발부' and jikwi = '사원' THEN 4 END) as "개발부 사원" -- 9
FROM tblinsa;