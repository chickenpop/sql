-- distinct

-- tblCountry, 대륙 종류 출력
select 
    distinct continent
from tblCountry;

-- tblInsa, 모든 부서 출력
select
    distinct buseo
from tblInsa;

-- tblGener, 현재 있는 비디오의 모든 장르 출력
select distinct g.name from tblVideo v inner join tblGenre g on v.genre = g.seq;



-- case
-- 대륙명 한국어로 출력하기
select 
    name, 
    case continent
        when 'AS' then '아시아'
        when 'NA' then '북아메리카'
        when 'SA' then '남아메리카'
        when 'EU' then '유럽'
        when 'AF' then '아프리카'
        when 'AU' then '오스트레일리아'
        else continent
    end as continent
from tblCountry;

-- tblInsa, 간부, 사원 직급으로 나누기
select 
    name,
    buseo,
    case 
        when jikwi = '부장' or jikwi = '과장' then '간부'
        else '사원'
    end as jikwi
from tblInsa;

-- tblInsa, 간부 월급 1.5배, 사원 1.2배 보너스를 더해서 지급
select 
    name,
    buseo,
    case 
        when jikwi = '부장' or jikwi = '과장' then basicpay * 1.5
        else basicpay * 1.2
    end as "basicpay+bonus"
from tblInsa;

-- order by 
-- tblInsa 부서별, 직급별 정렬
select name, jikwi, buseo from tblInsa
                            order by buseo,  case 
                                        when jikwi = '부장' then 1
                                        when jikwi = '과장' then 2
                                        when jikwi = '대리' then 3
                                        when jikwi = '사원' then 4 end;











