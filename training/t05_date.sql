-- t05_date.sql


-- 날짜 검색하고 싶을때(년)
select * from tblInsa where to_char(ibsadate, 'yy') = 08; -- 2008년

-- 열거형도 가능하다
select * from tblInsa where to_char(ibsadate, 'yy') in (08, 09);

-- 월, 일 순서대로

select * from tblInsa where to_char(ibsadate, 'mm') = 8; -- 8월

select * from tblInsa where to_char(ibsadate, 'dd') = 8; -- 8일