-- q01_select_where.sql


-- 요구사항.001.tblCountry
-- 모든 행과 모든 컬럼을 가져오시오.
SELECT name, capital, population, continent, area FROM tblcountry;
SELECT * FROM tblcountry;

-- 요구사항.002.tblCountry
-- 국가명과 수도명을 가져오시오.
SELECT name, capital FROM tblcountry;

-- 요구사항.003.tblCountry
-- 아래와 같이 가져오시오
-- [국가명]    [수도명]   [인구수]   [면적]    [대륙] <- 컬럼명
-- 대한민국   서울        4403       101       AS     <- 데이터
SELECT name as "[국가명]", capital as "[수도명]", population as "[인구수]", area as "[면적]", continent as "[대륙]" FROM tblcountry;

--요구사항.004.tblCountry
--아래와 같이 가져오시오
-- [국가정보] <- 컬럼명
-- 국가명: 대한민국, 수도명: 서울, 인구수: 4403   <- 데이터
SELECT '국가명:' || name || ', 수도명:' || capital || ', 인구수:'|| population as "[국가정보]" FROM tblcountry;

--요구사항.005.employees
--아래와 같이 가져오시오.
-- [이름]                 [이메일]                 [연락처]            [급여]
-- Steven King	        SKING@gmail.com	515.123.4567	   $24000
SELECT first_name || ' ' || last_name as "[이름]", email || '@gmail.com' as "[이메일]" , phone_number as "[연락처]", '$' || salary as "[급여]" FROM employees;


--요구사항.006.tblCountry
--면적(area)이 100이하인 국가의 이름과 면적을 가져오시오.
SELECT name, area FROM tblcountry WHERE area <= 100;

--요구사항.007.tblCountry
--아시아와 유럽 대륙에 속한 나라를 가져오시오. AS, EU
SELECT name, capital, population, continent, area FROM tblcountry WHERE continent = 'AS' or continent = 'EU';


--요구사항.008.employees
--직업(job_id)이 프로그래머(it_prog)인 직원의 이름(풀네임)과 연락처 가져오시오.
SELECT first_name || ' ' || last_name as name, phone_number FROM employees
WHERE job_id = 'IT_PROG';


--요구사항.009.employees
--last_name이 'Grant'인 직원의 이름, 연락처, 고용날짜를 가져오시오.
SELECT first_name || ' ' || last_name as name, phone_number, hire_date FROM employees WHERE last_name = 'Grant';


--요구사항.010.employees
--특정 매니저(manager_id: 120)이 관리하는 직원의 이름, 급여, 연락처를 가져오시오.
SELECT first_name || ' ' || last_name as name, salary, phone_number FROM employees
WHERE manager_id = 120;


--요구사항.011.employees
--특정 부서(60, 80, 100)에 속한 직원들의 이름, 연락처, 이메일, 부서ID 가져오시오.
SELECT first_name || ' ' || last_name as name, phone_number, email || '@gmail.com', department_id FROM employees 
WHERE department_id in (60, 80, 100);


--요구사항.012.tblInsa
--기획부 직원들 가져오시오.
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang FROM tblinsa
WHERE buseo = '기획부';

--요구사항.013.tblInsa
--서울에 있는 직원들 중 직위가 부장인 사람의 이름, 직위, 전화번호 가져오시오.
SELECT name, jikwi, tel FROM tblinsa
WHERE city = '서울' and jikwi = '부장';


--요구사항.014.tblInsa
--기본급여 + 수당 합쳐서 150만원 이상인 직원 중 서울에 직원만 가져오시오.
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang FROM tblinsa 
WHERE basicpay+sudang >= 1500000 and city = '서울';


--요구사항.015.tblInsa
--수당이 15만원 이하인 직원 중 직위가 사원, 대리만 가져오시오.
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang FROM tblinsa
WHERE sudang <= 150000 and (jikwi in ('사원', '대리'));



--요구사항.016.tblInsa
--수당을 제외한 기본 연봉이 2천만원 이상, 서울, 직위 과장(부장)만 가져오시오.
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang FROM tblinsa
WHERE basicpay*12 >= 20000000 and city = '서울' and (jikwi  in ('과장', '부장'));



--요구사항.017.tblInsa
--국가명 'O국'인 나라를 가져오시오.
SELECT name, capital, population, continent, area FROM tblCountry
WHERE name like '%국';



--요구사항.018.employees
--연락처가 515로 시작하는 직원들 가져오시오.
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
FROM employees
WHERE phone_number like '515%';

    

--요구사항.019.employees
--직업 ID가 SA로 시작하는 직원들 가져오시오.
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
FROM employees
WHERE job_id like 'SA%';
    

--요구사항.020.employees
--first_name에 'de'가 들어간 직원들 가져오시오.
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
FROM employees
WHERE first_name like '%de%' or first_name like '%DE%' or first_name like '%De%' or first_name like '%dE%';


--요구사항.021.tblInsa
--남자 직원만 가져오시오.
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang 
FROM tblinsa
WHERE ssn like '%-1%';


-- 요구사항.022.tblInsa
--여자 직원만 가져오시오.   
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang 
FROM tblinsa
WHERE ssn like '%-2%';


--요구사항.023.tblInsa
--여름에(7,8,9월) 태어난 직원들 가져오시오.
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang 
FROM tblinsa
WHERE (ssn like '__07%-%' or ssn like '__08%-%' or ssn like '__09%-%');


--요구사항.024.tblInsa
--서울, 인천에 사는 김씨만 가져오시오.    
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang 
FROM tblinsa
where city in ('서울', '인천') and name like '김%';


--요구사항.025.tblInsa
--영업부/총무부/개발부 직원 중 사원급(사원/대리) 중에 010을 사용하는 직원들을 가져오시오.
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang 
FROM tblinsa
where buseo in ('영업부', '총무부', '개발부') and jikwi in ('사원', '대리') and tel like '010%';



--요구사항.026.tblInsa
--서울/인천/경기에 살고 입사일이 2008~2010년 사이인 직원들을 가져오시오.
SELECT num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang 
FROM tblinsa
WHERE city in ('서울', '인천', '경기') and ibsadate BETWEEN '2008-01-01' and '2010-12-31';


--요구사항.027.employees
--부서가 아직 배정 안된 직원들을 가져오시오. (department_id가 없는 직원)
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
FROM employees
WHERE department_id is null;

