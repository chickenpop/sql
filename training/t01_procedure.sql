-- 프로시저 연습

-- 1. 추가 작업 연습

-- temp

-- 사용 테이블 제작
create table tblPerson(
    seq number primary key,
    name varchar2(30) not null,
    phoneNum varchar2(15) not null
);

-- 테이블 확인
select * from tblPerson;

-- 사용 테이블 삭제
drop table tblPerson;

create sequence seqPerson;
drop sequence seqPerson;

-- temp 테이블 사용마다 복사해서 구분

create or replace procedure procT1(
    pname in varchar2,
    pphoneNum in varchar2
)
is
begin

    insert into tblPerson (seq, name, phoneNum) values (seqPerson.nextVal, pname, pphoneNum);
    commit;
exception
    when others then
        dbms_output.put_line('procT1 에러발생');
        rollback;
end;

begin
    procT1('홍길동', '010-4321-9876');
end;

select * from tblPerson;

drop procedure procT1;



-- 2. sequence

-- temp

-- 사용 테이블 제작
create table tblPerson(
    seq number primary key,
    name varchar2(30) not null,
    phoneNum varchar2(15) not null
);

-- 테이블 확인
select * from tblPerson;

-- temp

insert into tblPerson (seq, name, phoneNum) values (1, '홍길동', '010-4321-9876');
insert into tblPerson (seq, name, phoneNum) values (2, '아무개', '010-1111-9876');
insert into tblPerson (seq, name, phoneNum) values (3, '흰둥이', '010-4321-5555');

-- 2. 시퀀스를 중간에 만들었을 경우 start with 사용하기
-- 시퀀스 찾는 방법 1. 직접확인
--                  2. max(seq)
select max(seq) from tblPerson;

create sequence seqPerson
    start with 4;

insert into tblPerson (seq, name, phoneNum) values (seqPerson.nextVal, '폼포푸린', '010-4561-5789');
    
select * from tblPerson;
    
-- 사용 테이블, 시퀀스 삭제
drop table tblPerson;
drop sequence seqPerson;


-- 3. 프로시저 성공, 실패 유무 반환하기
set serveroutput on;
create table tblPerson(
    seq number primary key,
    name varchar2(30) not null,
    phoneNum varchar2(15) not null
);

-- 테이블 확인
select * from tblPerson;

-- 사용 테이블 삭제
drop table tblPerson;

-- 시퀀스
create sequence seqPerson;
drop sequence seqPerson;

-- insert
insert into tblPerson (seq, name, phoneNum) values (seqPerson.nextVal, '홍길동', '010-4321-9876');
insert into tblPerson (seq, name, phoneNum) values (seqPerson.nextVal, '아무개', '010-1111-9876');
insert into tblPerson (seq, name, phoneNum) values (seqPerson.nextVal, '흰둥이', '010-4321-5555');


create or replace procedure procPerson(
    pname       in varchar2,
    pphoneNum   in varchar2,
    presult     out number
)
is
begin

    insert into tblPerson (seq, name, phoneNum) values (seqPerson.nextVal, pname, pphoneNum);
    presult := 1;
    commit;

exception 
    when others then
        presult := 0;
        rollback;
end;

declare
    vresult number;
begin

    procPerson('총균쇠', '010-4567-4654', vresult);
    dbms_output.put_line(vresult);

end;


