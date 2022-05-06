-- 22.04.30 4~5번 문제
-- 22.05.01 8~11, 13~14문제
-- 22.05.04 15~17, 20~23
-- 22.05.05 24~31
-- 22.05.06 33~36, docs 18번부터 누락된 결과 표시

-- 1. employees. 'Munich' 도시에 위치한 부서에 소속된 직원들 명단?
-- 1. 결과
select 
    e.*
from employees e
    inner join departments d
        on e.department_id = d.department_id
            inner join locations l
                on d.location_id = l.location_id
                    where l.city = 'Munich';


-- 2. tblMan. tblWoman. 서로 짝이 있는 사람 중 남자와 여자의 정보를 모두 가져오시오.
--    [남자]        [남자키]   [남자몸무게]     [여자]    [여자키]   [여자몸무게]
--    홍길동         180       70              장도연     177        65
--    아무개         175       null            이세영     163        null
--    ..
select * from tblMan;
select * from tblWoman;

-- 2. 결과
select 
    m.name as 남자,
    m.height as 남자키,
    m.weight as 남자몸무게,
    w.name as 여자,
    w.height as 여자키,
    w.weight as 여자몸무게
from tblMan m
    inner join tblWoman w
        on m.couple = w.name;


-- 3. tblAddressBook. 가장 많은 사람들이 가지고 있는 직업은 주로 어느 지역 태생(hometown)인가? 
select * from tblAddressBook;

select max(count(*)) from tblAddressBook group by job; -- 학생(332명)

select job from tblAddressBook group by job having count(*) = (select max(count(*)) from tblAddressBook group by job);
-- 3. 결과
select 
    hometown, 
    count(*) as 분포수
from tblAddressBook 
    where job = (select job from tblAddressBook group by job having count(*) = (select max(count(*)) from tblAddressBook group by job)) 
        group by hometown
            order by count(*) desc;

-- 4. tblAddressBook. 이메일 도메인들 중 평균 아이디 길이가 가장 긴 이메일 사이트의 도메인은 무엇인가?
select * from tblAddressBook;

select substr(email, instr(email, '@')+1), count(*) from tblAddressBook group by substr(email, instr(email, '@')+1);

select email, avg(length(substr(email, 1, instr(email, '@')-1))) as emailLen from tblAddressBook group by email;

select max(avg(length(substr(email, 1, instr(email, '@')-1)))) as maxEmailLen from tblAddressBook group by substr(email, 1, instr(email, '@')-1);

-- 4. 결과
select substr(email, instr(email, '@')+1) as domain, 
        avg(length(substr(email, 1, instr(email, '@')-1))) as emailLen
from tblAddressBook
    group by substr(email, instr(email, '@')+1)
        having avg(length(substr(email, 1, instr(email, '@')-1))) 
                = (select max(avg(length(substr(email, 1, instr(email, '@')-1)))) as maxEmailLen from tblAddressBook group by substr(email, instr(email, '@')+1));


-- 5. tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은?
select hometown, avg(age) as avgAge from tblAddressBook group by hometown;

select max(avg(age)) from tblAddressBook group by hometown;

select 
    max(count(*)) 
from tblAddressBook 
    where hometown = (select hometown from tblAddressBook group by hometown having avg(age) = (select max(avg(age)) from tblAddressBook group by hometown)) group by job;

-- 5. 결과
select 
    job 
from tblAddressBook 
    where hometown = (select hometown from tblAddressBook group by hometown having avg(age) = (select max(avg(age)) from tblAddressBook group by hometown))
        group by job
            having count(*) = (select max(count(*)) from tblAddressBook where hometown = (select hometown from tblAddressBook group by hometown having avg(age) = (select max(avg(age)) from tblAddressBook group by hometown)) group by job);



-- 6. tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.

-- 6. 결과
select 
    *
from tblAddressBook
    where hometown = '서울' and age > (select avg(age) from tblAddressBook where gender = 'm') and job not in('백수', '학생', '취업준비생');

-- 7. tblAddressBook. gmail.com을 사용하는 사람들의 성별 > 세대별(10,20,30,40대) 인원수를 가져오시오.

-- 7.결과
select 
    decode(gender, 'm', '남자', 'f', '여자') as 성별,
    count(decode(round(age/10), 1, 1)) as "10대",
    count(decode(round(age/10), 2, 1)) as "20대",
    count(decode(round(age/10), 3, 1)) as "30대",
    count(decode(round(age/10), 4, 1)) as "40대"
from tblAddressBook
    where email like '%gmail.com'
    group by gender;


-- 8. tblAddressBook. 가장 나이가 많으면서 가장 몸무게가 많이 나가는 사람과 같은 직업을 가지는 사람들을 가져오시오. 

select * from tblAddressBook;

select * from tblAddressBook order by age desc, weight desc;

select job from (select * from tblAddressBook order by age desc, weight desc) where rownum = 1;

-- 8. 결과
select * from tblAddressBook where job = (select job from (select * from tblAddressBook order by age desc, weight desc) where rownum = 1);

-- 8. 다른 결과
select * from tblAddressBook 
    where job = (select job from tblAddressBook where weight = (select max(weight) from tblAddressBook where age = (select max(age) from tblAddressBook)) and age = (select max(age) from tblAddressBook));

-- 9. tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인(모든 이도윤)의 명단을 가져오시오.
select name, count(*) from tblAddressBook group by name having count(name) > 1;
        
select max(count(*)) from tblAddressBook group by name having count(name) > 1;

-- 9. 결과
select * from tblAddressBook 
    where name = (select name from tblAddressBook group by name having count(*) = (select max(count(*)) from tblAddressBook group by name having count(name) > 1));

-- 10. tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.
--    [10대]       [20대]       [30대]       [40대]
--    8.7%        30.7%        28.3%        32.2%
select max(count(*)) from tblAddressBook group by job;

select job from tblAddressBook group by job having count(*) = (select max(count(*)) from tblAddressBook group by job);

-- 10. 결과
select
    round(count(case
        when age >= 10 and age <= 19 then 1
    end)/count(*)*100, 1) || '%' as "[10대]",
    round(count(case
        when age >= 20 and age <= 29 then 1
    end)/count(*)*100, 1) || '%' as "[20대]",
    round(count(case
        when age >= 30 and age <= 39 then 1
    end)/count(*)*100, 1) || '%' as "[30대]",
    round(count(case
        when age >= 40 and age <= 49 then 1
    end)/count(*)*100, 1) || '%' as "[40대]"
from tblAddressBook
    where job = (select job from tblAddressBook group by job having count(*) = (select max(count(*)) from tblAddressBook group by job));

-- 11. tblStaff, tblProject. 현재 재직중인 모든 직원의 이름, 주소, 월급, 담당프로젝트명을 가져오시오.

select * from tblStaff;     -- 부모, seq
select * from tblProject;   -- 자식, staff_seq

-- 11. 결과
select 
    s.name,
    s.address,
    s.salary,
    p.project
from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq;
       
-- 12. tblVideo, tblRent, tblMember. '뽀뽀할까요' 라는 비디오를 빌려간 회원의 이름은?
select * from tblVideo;
select * from tblRent;
select * from tblMember;

-- 12. 결과 
select
    v.name as 비디오명,
    m.name as 회원명
from tblMember m
    inner join tblvideo v
        on m.seq = v.genre
            inner join tblRent r
                on v.seq = r.video
                    where v.name = '뽀뽀할까요';
    
    
-- 13. tblStaff, tblProejct. 'TV 광고'을 담당한 직원의 월급은 얼마인가? 

-- 13. 결과
select 
    s.salary
from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq
            where p.project = 'TV 광고';
    
    
-- 14. tblVideo, tblRent, tblMember. '털미네이터' 비디오를 한번이라도 빌려갔던 회원들의 이름은?
select * from tblvideo;
select * from tblRent;
select * from tblMember;

-- 14. 결과
select
    m.name
from tblMember m
    inner join tblRent r
        on m.seq = r.member
            inner join tblVideo v
                on r.video = v.seq
                    where v.name = '털미네이터';

                
-- 15. tblStaff, tblProject. 서울시에 사는 직원을 제외한 나머지 직원들의 이름, 월급, 담당프로젝트명을 가져오시오.
select * from tblStaff;
select * from tblProject;

-- 15. 결과
select 
    s.name,
    s.salary,
    p.project
from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq
            where address <> '서울시';
        
        
        
-- 16. tblCustomer, tblSales. 상품을 2개(단일상품) 이상 구매한 회원의 연락처, 이름, 구매상품명, 수량을 가져오시오.
select * from tblCustomer; -- seq
select * from tblSales;    -- cseq

-- 16. 결과
select 
    c.tel,
    c.name,
    s.item,
    s.qty
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq
            where s.qty > 1;

                                
-- 17. tblVideo, tblRent, tblGenre. 모든 비디오 제목, 보유수량, 대여가격을 가져오시오.
select * from tblVideo;
select * from tblRent;
select * from tblGenre;
     
-- 17. 결과     
select 
    v.name,
    v.qty,
    g.price
from tblVideo v 
    inner join tblGenre g
        on v.genre = g.seq;
                
-- 18. tblVideo, tblRent, tblMember, tblGenre. 2007년 2월에 대여된 구매내역을 가져오시오. 회원명, 비디오명, 언제, 대여가격
select * from tblVideo;
select * from tblRent;
select * from tblMember;
select * from tblGenre;

-- 18. 결과
select 
    m.name as 회원명,
    v.name as 비디오명,
    r.rentdate as 언제,
    g.price as 대여가격
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video
                    inner join tblMember m
                        on m.seq = r.member;
        
create or replace view tblTest
as
select 
    m.name as 회원명,
    v.name as 비디오명,
    r.rentdate as 언제,
    g.price as 대여가격
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video
                    inner join tblMember m
                        on m.seq = r.member;
                        
select 
    * 
from tblTest
where to_char(언제) like '07/02/%';
        
-- 19. tblVideo, tblRent, tblMember. 현재 반납을 안한 회원명과 비디오명, 대여날짜를 가져오시오.
-- 19. 결과
select
    m.name as 회원명,
    v.name as 비디오명,
    r.rentdate as 대여날짜
from tblMember m
    inner join tblvideo v
        on m.seq = v.genre
            inner join tblRent r
                on v.seq = r.video
                    where r.retdate is null;
    
    
-- 20. employees, departments. 사원들의 이름, 부서번호, 부서명을 가져오시오.
select * from employees;
select * from departments;

-- 20. 결과
select 
    e.first_name || ' ' || e.last_name as 사원명,
    e.department_id as 부서번호,
    d.department_name as 부서명
from employees e
    inner join departments d
        on e.department_id = d.department_id;
        
        
-- 21. employees, jobs. 사원들의 정보와 직업명을 가져오시오.

-- 21. 결과
select 
    e.*,
    j.job_title
from employees e
    inner join jobs j
        on e.job_id = j.job_id;
        
        
-- 22. employees, jobs. 직무(job_id)별 최고급여(max_salary) 받는 사원 정보를 가져오시오.

-- 22. 결과
select 
    e.job_id,
    max(e.salary) as 최고급여
from employees e
    inner join jobs j
        on e.job_id = j.job_id
            group by e.job_id;
    
    
-- 23. departments, locations. 모든 부서와 각 부서가 위치하고 있는 도시의 이름을 가져오시오.
select * from departments;
select * from locations;
        
-- 23. 결과
select 
    d.department_name, 
    l.city
from departments d
    inner join locations l
        on d.location_id = l.location_id;
        
-- 24. locations, countries. location_id 가 2900인 도시가 속한 국가 이름을 가져오시오.
select * from locations;
select * from countries;
     
-- 24. 결과       
select 
    c.country_name as 국가명 
from locations l
    inner join countries c
        on l.country_id = c.country_id
            where l.location_id = 1900;
            
-- 25. employees. 급여를 12000 이상 받는 사원과 같은 부서에서 근무하는 사원들의 이름, 급여, 부서번호를 가져오시오.
select 
    distinct e.department_id
from employees e
    inner join departments d
        on e.department_id = d.department_id
            where e.salary >= 12000;
  
-- 25. 결과   
select
    first_name || ' ' || last_name as name, 
    salary,
    department_id
from employees
    where department_id in (select distinct e.department_id from employees e 
                                                                inner join departments d
                                                                    on e.department_id = d.department_id
                                                                            where e.salary >= 12000);
     
-- 26. employees, departments. locations.  'Seattle'에서(LOC) 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 가져오시오.

-- 26. 결과
select 
    e.first_name || ' ' || e.last_name as 이름, 
    e.job_id as 직위,
    e.department_id as 부서번호,
    d.department_name as 부서명
from employees e
    inner join departments d
        on e.department_id = d.department_id
            inner join locations l
                on d.location_id = l.location_id
                    where l.city = 'Seattle';
    
    
-- 27. employees, departments. first_name이 'Jonathon'인 직원과 같은 부서에 근무하는 직원들 정보를 가져오시오.
select 
    department_id
from employees 
    where lower(first_name) like 'jonathon';
    
-- 27. 결과   
select 
    *
from employees
    where department_id = (select 
                                department_id
                            from employees 
                                where lower(first_name) like 'jonathon');

    
-- 28. employees, departments. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 가져오시오.

-- 28. 결과
select 
    e.first_name || ' ' || e.last_name as 이름,
    d.department_name as 부서명,
    e.salary as 월급
from employees e
    inner join departments d
        on e.department_id = d.department_id
            where e.salary >= 3000;
            
            
-- 29. employees, departments. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급을 가져오시오.

-- 29. 결과
select 
    d.department_id,
    d.department_name,
    e.first_name || ' ' || e.last_name as name,
    e.salary
from employees e
    inner join departments d
        on e.department_id = d.department_id
            where e.department_id = 10;
            
-- 30. departments, job_history. 퇴사한 사원의 입사일, 퇴사일, 근무했던 부서 이름을 가져오시오.
select * from departments;
select * from job_history;
        
-- 30. 결과
select 
    j.start_date,
    j.end_date,
    d.department_name
from job_history j
    inner join departments d
        on j.department_id = d.department_id;
        
-- 31. employees. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호', '사원이름', '관리자번호', '관리자이름'으로 하여 가져오시오.

-- 31. 결과
select 
    e.employee_id as 사원번호,
    e.first_name || ' ' || e.last_name as 사원이름,
    e.manager_id as 관리자번호,
    m.first_name || ' ' || m.last_name as 관리자이름
from HR.employees e
    inner join HR.employees m
        on e.manager_id = m.employee_id ;
    
        
-- 32. employees, jobs. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 가져오시오. 년도를 기준으로 오름차순 정렬.
select * from employees;
select * from jobs;

select 
    *
from employees e
    inner join jobs j
        on e.job_id = j.job_id
        where j.job_title = 'Sales Manager';

-- 32. 결과
select 
    substr(e.hire_date, 1, 2) as 입사년도,
    round(avg(e.salary)) as "입사년도 평균급여"
from employees e
    inner join jobs j
        on e.job_id = j.job_id
        where j.job_title = 'Sales Manager'
            group by e.hire_date
                order by e.hire_date;



-- 33. employees, departments. locations. 각 도시(city)에 있는 모든 부서 사원들의 평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 사원수를 가져오시오. 단, 도시에 근 무하는 사원이 10명 이상인 곳은 제외하고 가져오시오.
select * from employees;
select * from departments;
select * from locations;

-- 33. 결과
select 
    l.city, round(avg(e.salary)) as avgSalary, count(*) as employeeCnt 
from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id 
    group by l.city 
        having count(*) < 10 
            order by avg(e.salary);
       
          
-- 34. employees, jobs, job_history. ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 가져오시오. 현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 말것.
select * from employees;
select * from jobs;
select * from job_history;
    
select jh.employee_id from jobs js inner join job_history jh on js.job_id = jh.job_id where js.job_title = 'Public Accountant';
  
-- 34. 결과  
select 
    employee_id,
    first_name || ' ' || last_name as name
from employees
    where employee_id in (select jh.employee_id from jobs js inner join job_history jh on js.job_id = jh.job_id where js.job_title = 'Public Accountant');
    
-- 35. employees, departments, locations. 커미션을 받는 모든 사람들의 first_name, last_name, 부서명, 지역 id, 도시명을 가져오시오.
select * from employees;
select * from departments;
select * from locations;

-- 35. 결과    
select 
    e.first_name,
    e.last_name,
    d.department_name,
    l.location_id,
    l.city
from employees e inner join departments d on e.department_id = d.department_id inner join locations l on d.location_id = l.location_id 
    where e.commission_pct > 0;
    
-- 36. employees. 자신의 매니저보다 먼저 고용된 사원들의 first_name, last_name, 고용일을 가져오시오.

-- 36. 결과 ef 매니저, el 사원
select 
    el.first_name,
    el.last_name,
    el.hire_date 
from employees ef
    inner join employees el
        on ef.employee_id = el.manager_id
            where ef.hire_date > el.hire_date;

-- 36. 결과 ef 사원 el 매니저
select 
    ef.first_name,
    ef.last_name,
    ef.hire_date 
from employees ef
    inner join employees el
        on ef.manager_id = el.employee_id
            where ef.hire_date < el.hire_date;

