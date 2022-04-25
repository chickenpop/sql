-- q04_where_aggregatioin.sql

--sum()
--1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblCountry > 14,198
SELECT 
    sum(population) as "EU,AF인구수합"
FROM tblcountry
WHERE continent in ('EU', 'AF');

--2. 매니저(108)이 관리하고 있는 직원들의 급여 총합? hr.employees > 39,600
SELECT 
    sum(salary) as "manager_id(108)담당총급여"
FROM employees
where manager_id = 108;

--3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? hr.employees > 120,000
SELECT 
    sum(salary)
FROM employees
where job_id in ('ST_CLERK', 'SH_CLERK');

-- 4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblInsa > 33,812,400
select 
    sum(basicpay + sudang) as "급여합"
from tblinsa
where city = '서울';

-- 5. 장급(부장+과장)들의 급여 합? tblInsa > 36,289,000
select
    sum(basicpay)
from tblInsa
where jikwi in ('부장', '과장');


--avg()
--1. 아시아에 속한 국가의 평균 인구수? tblCountry > 39,165
select 
    avg(population) as 아시아국가평균인구수
from tblCountry
where continent = 'AS';

--2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분없이) hr.employees > 6,270.4
select 
    avg(salary) as AN이름직원평균급여
from employees
    where lower(first_name) like '%an%';

--3. 장급(부장+과장)의 평균 급여? tblInsa > 2,419,266.66
select 
    avg(basicpay)
from tblInsa
    where jikwi in ('부장', '과장');

--4. 사원급(대리+사원)의 평균 급여? tblInsa > 1,268,946.66
select 
    avg(basicpay) as 사원급평균급여
from tblInsa
    where jikwi in ('대리', '사원');

--5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차액? tblInsa > 1,150,320
select 
    abs(avg(case
        when jikwi in ('부장', '과장') then basicpay
        else null
    end)
    -avg(case
        when jikwi in ('대리', '사원') then basicpay
        else null
    end)) as "장급사원급 급여 차액"
from tblInsa;

--max(),min()
--1. 면적이 가장 넓은 나라의 면적은? tblCountry > 959
select
    max(area)
from tblCountry;

--2. 급여(급여+수당)가 가장 적은 직원은 총 얼마를 받고 있는가? tblInsa > 988,000
select 
    min(basicpay+sudang)
from tblInsa;



