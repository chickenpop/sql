-- create와 제약사항

drop table tblConstraint;
drop sequence seqCons;

-- constraint로 만들기
create table tblConstraint(
-- null은 적지 않으면 기본값
-- not null, null, default는 컬럼수준에서 가능
    seq number(3),
    name varchar2(15) not null,
    nickname varchar2(30) null,
    memo varchar2(300) null, 
    regdate date default sysdate,
    
    --constraint tblConstraint_seq_pk primary key(seq),
    constraint tblConstraint_nickname_uq unique(nickname),
    constraint tblConstraint_memo_ck check(length(memo) > 0)

);

-- alter로 제약사항 추가하기
alter table tblConstraint
    add constraint tblConstraint_seq_pk primary key(seq);

create sequence seqConstraint;

select * from tblConstraint;


-- DML (insert(추가), update(수정), delecte(삭제))

-- insert
insert into tblConstraint (seq, name, nickname, memo) values (seqConstraint.nextVal, '홍길동', 'hijava', 'hi~');
-- ORA-00001: unique constraint (HR.TBLCONSTRAINT_NICKNAME_UQ) violated
-- 의도적 삽입 > 유니크 특성 : 중복값 불가, null가능 
insert into tblConstraint (seq, name, nickname, memo) values (seqConstraint.nextVal, '아무개', 'hijava', 'hi~');
insert into tblConstraint (seq, name, memo) values (seqCons.nextVal, '홍길동', 'hi~');
insert into tblConstraint (seq, name, nickname, memo) values (seqConstraint.nextVal, '홍길동', 'hong', 'hi~');


-- alter 제약사항 확인
-- ORA-00001: unique constraint (HR.TBLCONSTRAINT_SEQ_PK) violated
insert into tblConstraint (seq, name, nickname, memo) values (1, '홍길동', 'hijava', 'hi~');
insert into tblConstraint (seq, name, nickname, memo) values (1, '홍길동', 'hong', 'hi~');

-- insert
insert into tblConstraint (seq, name, nickname, memo) values (seqConstraint.nextVal, '박우창', 'park12', '책읽기');
insert into tblConstraint (seq, name, nickname, memo) values (seqConstraint.nextVal, '남송희', 'nam0515', '김치만들기');
insert into tblConstraint (seq, name, nickname, memo) values (seqConstraint.nextVal, '이현룡', 'leelee', '문서 제출하기');


-- update
update tblConstraint set nickname = '안녕자바' where seq = 1;
-- ORA-00001: unique constraint (HR.TBLCONSTRAINT_NICKNAME_UQ) violated
update tblConstraint set nickname = '안녕자바' where seq = 2;
update tblConstraint set nickname = 'hijava' where seq = 2;

select * from tblConstraint;

-- delete 

-- 5번 아무개 삭제
delete tblConstraint where seq = 5;
select * from tblConstraint;

-- ck 제약사항 확인

drop table tblConstraint;

create table tblConstraint(
    seq number primary key, 
    num1 number,
    num2 number,
    num3 number,
    
    constraint tblConstraint_ck check(num1 + num2 + num3 = 100)
);

-- ORA-02290: check constraint (HR.TBLCONSTRAINT_CK) violated > check 에러 확인
insert into tblconstraint(seq, num1, num2, num3) values(1, 10, 20, 30);

-- 정상 삽입 > 가능
insert into tblconstraint(seq, num1, num2, num3) values(1, 30, 30, 40);

-- 일부값만 주기 > null 허용인 경우 > 가능
insert into tblconstraint(seq, num1, num2) values(2, 50, 50);

-- not null인 경우 확인

create table tblConstraint(
    seq number primary key, 
    num1 number,
    num2 number,
    num3 number not null,
    
    constraint tblConstraint_ck check(num1 + num2 + num3 = 100)
);

-- ORA-01400: cannot insert NULL into ("HR"."TBLCONSTRAINT"."NUM3") > 당연히 불가능
insert into tblconstraint(seq, num1, num2) values(1, 50, 50);

-- null 값 중 일부만 생략해서 check 조건으로 insert 가능
-- num1 + num2 + num3 = 100인 경우
-- num3이 not null이면 (num1, num2) 택일 혹은 둘다 + num3 값을 넣어줄수 있음
insert into tblconstraint(seq, num2, num3) values(1, 50, 50);








