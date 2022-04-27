-- q06_groupby.sql


--1. traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.
select * from traffic_accident; 

select
    trans_type as "교통수단",
    sum(total_acct_num) as "교통사고건수",
    sum(death_person_num) as "사망자수",
    round(sum(death_person_num)/sum(total_acct_num), 3) as "사건당 평균 사망자수"
from traffic_accident
    group by trans_type
        having trans_type in ('지하철', '철도', '항공기', '선박', '자동차');      
        

--2. tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.

select * from tblZoo; 
    
select
    family,
    round(avg(leg)) as "평균 다리수" 
from tblZoo
    group by family;
    
--3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.

select * from tblZoo; 
        
select 
    breath,
    count(distinct family) as "종의 개수"
from tblZoo
where thermo = 'variable'
    group by breath;        

--4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.

select 
    sizeof,
    family, 
    count(*) as "종류 수"
from tblZoo
    group by sizeof, family
        order by family, sizeof desc; 

    
--12. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.

select 
    email
from tblAddressBook
    group by email
        having count(email) > 1;


        
--15. tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.
select 
    substr(name, 1, 1) as "100명이상 성씨"
from tblAddressBook
    group by substr(name, 1, 1)
        having count(substr(name, 1, 1)) >= 100;




--17. tblAddressBook. 이메일이 스네이크 명명법으로 만들어진 사람들 중에서 여자이며, 20대이며, 키가 150~160cm 사이며, 고향이 서울 또는 인천인 사람들만 가져오시오.
select * from tblAddressBook;

select 
    *
from tblAddressBook
    where instr(email, '_') <> 0 and gender = 'f' and age like '2_' and (height between 150 and 160) and hometown in ('서울', '인천');



--20. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?
select 
    job, 
    round(count(decode(substr(address, 1, 2), '서울', 1))/count(job) * 100, 2)  || '%' as 거주지서울,
    round((count(*) - count(decode(substr(address, 1, 2), '서울', 1)))/count(*)* 100, 2) || '%' as 거주지지방
from tblAddressBook
    group by job
        having job in ('건물주', '건물주자제분');

