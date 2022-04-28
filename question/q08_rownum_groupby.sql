-- q08_rownum_groupby.sql

-- 1. tblInsa. 남자 급여(기본급+수당)을 (내림차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
select * from tblInsa;

select * from tblInsa where substr(ssn, 8, 1) = 1 order by basicpay+sudang desc;

select salary.*, rownum as rnum from (select * from tblInsa where substr(ssn, 8, 1) = 1 order by basicpay+sudang desc) salary;

-- 1.결과
select 
    name, 
    buseo, 
    jikwi, 
    basicpay+sudang as 급여, 
    rnum 
from (select salary.*, rownum as rnum from (select * from tblInsa where substr(ssn, 8, 1) = 1 order by basicpay+sudang desc) salary);




-- 2. tblInsa. 여자 급여(기본급+수당)을 (오름차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
-- 2.결과
select 
    name, 
    buseo, 
    jikwi, 
    basicpay+sudang as 급여, 
    rnum 
from (select salary.*, rownum as rnum from (select * from tblInsa where substr(ssn, 8, 1) = 2 order by basicpay+sudang) salary);

-- 3. tblInsa. 여자 인원수가 (가장 많은 부서 및 인원수) 가져오시오. 

select * from tblInsa where substr(ssn, 8, 1) = 2;

select buseo, count(*) as cnt from tblInsa where substr(ssn, 8, 1) = '2' group by buseo;

-- 3.결과
select 
    buseo, cnt, rownum 
from (select buseo, count(*) as cnt from tblInsa where substr(ssn, 8, 1) = '2' group by buseo) where rownum = 1;




-- 4. tblInsa. 지역별 인원수 (내림차순)순위를 가져오시오.(city, 인원수)
select * from tblInsa;

-- 4.결과
select city, count(*) as 인원수 from tblInsa group by city order by count(*) desc;





-- 5. tblInsa. 부서별 인원수가 가장 많은 부서 및원수 출력.
select * from tblInsa;

select buseo, count(*) from tblInsa group by buseo order by count(*) desc;

select buseoPersonNum.*, rownum as rnum from (select buseo, count(*) from tblInsa group by buseo order by count(*) desc) buseoPersonNum;

-- 5.결과
select 
    buseo, 인원수 
from (select buseoPersonNum.*, rownum as rnum from (select buseo, count(*) as 인원수 from tblInsa group by buseo order by count(*) desc) buseoPersonNum) where rnum = 1;




-- 6. tblInsa. 남자 급여(기본급+수당)을 (내림차순) 3~5등까지 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
-- 6.결과
select 
    name, 
    buseo, 
    jikwi, 
    basicpay+sudang as 급여, 
    rnum 
from (select salary.*, rownum as rnum from (select * from tblInsa where substr(ssn, 8, 1) = 1 order by basicpay+sudang desc) salary)
    where rnum >= 3 and rnum <= 5; 




-- 7. tblInsa. 입사일이 빠른 순서로 5순위까지만 가져오시오.
select * from tblInsa;

select * from tblInsa order by ibsadate;

select workstartdate.*, rownum from (select * from tblInsa order by ibsadate) workstartdate;

-- 7.결과
select * from (select workstartdate.*, rownum as rnum from (select * from tblInsa order by ibsadate) workstartdate) where rnum <= 5;




-- 8. tblhousekeeping. 지출 내역(가격 * 수량) 중 가장 많은 금액을 지출한 내역 3가지를 가져오시오.
select * from tblhousekeeping;

select * from tblhousekeeping order by price*qty desc;

select expense.*, rownum as rnum from (select * from tblhousekeeping order by price*qty desc) expense;

-- 8.결과
select 
    * 
from (select expense.*, rownum as rnum from (select * from tblhousekeeping order by price*qty desc) expense)
    where rnum <= 3;




-- 9. tblinsa. 평균 급여 2위인 부서에 속한 직원들을 가져오시오.

select * from tblInsa;

select buseo, avg(basicpay) from tblInsa group by buseo order by avg(basicpay) desc;


select
    buseo, rownum as rnum
from (select buseo, avg(basicpay) from tblInsa group by buseo order by avg(basicpay) desc);

select
    buseo
from (select
         buseo, rownum as rnum
      from (select buseo, avg(basicpay) from tblInsa group by buseo order by avg(basicpay) desc))
       where rnum = 2;

-- 9. 결과
select
    *
from tblInsa
     where buseo = (select
                        buseo
                    from (select
                            buseo, rownum as rnum
                    from (select buseo, avg(basicpay) from tblInsa group by buseo order by avg(basicpay) desc))
                        where rnum = 2);





-- 10. tbltodo. 등록 후 가장 빠르게 완료한 할일을 순서대로 5개 가져오시오.
select * from tblTodo;

select * from tblTodo order by completedate-adddate; 

-- 10.결과
select complete.*, rownum as rnum from (select * from tblTodo order by completedate-adddate) complete where rownum <= 5;





-- 11. tblinsa. 남자 직원 중에서 급여를 3번째로 많이 받는 직원과 9번째로 많이 받는 직원의 급여 차액은 얼마인가? 
select * from tblInsa;

select * from tblInsa where substr(ssn, 8, 1) = '1' order by basicpay desc;

select salary.*, rownum from (select * from tblInsa where substr(ssn, 8, 1) = '1' order by basicpay desc) salary;

-- 11.결과
select 
    sum(case
            when rnum = 3 then basicpay
            when rnum = 9 then -basicpay
            else null
    end) as 차액
from (select salary.*, rownum as rnum from (select * from tblInsa where substr(ssn, 8, 1) = '1' order by basicpay desc) salary);

