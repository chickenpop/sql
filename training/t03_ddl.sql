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

create sequence seqCons;

select * from tblConstraint;


-- DML (insert(추가), update(수정), delecte(삭제))

-- insert
insert into tblConstraint (seq, name, nickname, memo) values (seqCons.nextVal, '홍길동', 'hijava', 'hi~');
-- ORA-00001: unique constraint (HR.TBLCONSTRAINT_NICKNAME_UQ) violated
-- 의도적 삽입 > 유니크 특성 : 중복값 불가, null가능 
insert into tblConstraint (seq, name, nickname, memo) values (seqCons.nextVal, '아무개', 'hijava', 'hi~');
insert into tblConstraint (seq, name, memo) values (seqCons.nextVal, '홍길동', 'hi~');
insert into tblConstraint (seq, name, nickname, memo) values (seqCons.nextVal, '홍길동', 'hong', 'hi~');


-- alter 제약사항 확인
-- ORA-00001: unique constraint (HR.TBLCONSTRAINT_SEQ_PK) violated
insert into tblConstraint (seq, name, nickname, memo) values (1, '홍길동', 'hijava', 'hi~');
insert into tblConstraint (seq, name, nickname, memo) values (1, '홍길동', 'hong', 'hi~');


-- update
update tblConstraint set nickname = '안녕자바' where seq = 1;
-- ORA-00001: unique constraint (HR.TBLCONSTRAINT_NICKNAME_UQ) violated
update tblConstraint set nickname = '안녕자바' where seq = 2;
update tblConstraint set nickname = 'hijava' where seq = 2;

select * from tblConstraint;



