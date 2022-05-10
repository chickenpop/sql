-- 프로시저 연습

-- 프로시저 총 정리(***)
-- 1. 추가 작업(C)
create or replace procedure 추가작업 (
    추가할 데이터 -> in 매개변수,
    추가할 데이터 -> in 매개변수, --원하는 개수만큼
    성공 유무 반환 -> out 매개변수 --return 사용X
)
is
    내부 변수 선언
begin
    작업(insert + (select, update, delete))
    commit; --마무리
exception
    when others then
        예외작업
        rollback; --마무리
end;

select * from tblTodo;

create sequence todo_seq;
drop sequence todo_seq;
-- 사용중 테이블에 적용할 시퀀스 객체를 나중에 만들었을 경우(번호 중복 충돌 발생)
-- 1. 노가다(낮은 번호)
select todo_seq.nextval from dual;
-- 2. seed 지정(권장)
select max(*) from tblTodo;
create sequence todo_seq
    start with 30;


insert into tblTodo (seq, title, adddate, completedate) 
    values (todo_seq.nextval, '할일 추가하기', sysdate, null);

create or replace procedure procAddTodo (
    ptitle in varchar2,
    presult out number -- 1 or 0
)
is
begin
    
    insert into tblTodo (seq, title, adddate, completedate) 
        values (todo_seq.nextval, ptitle, sysdate, null);
    presult := 1; --성공 메시지 반환
    commit;
    
exception
    when others then
        presult := 0; --실패 메시지 반환
        rollback;
end;




create or replace procedure procAddTodo (
    ptitle in varchar2,
    presult out number -- 1 or 0
)
is
    vseq number; --시퀀스 역할
begin

    select max(seq) + 1 into vseq from tblTodo; --시퀀스 객체와 동일한 역할
    
    insert into tblTodo (seq, title, adddate, completedate) 
        values (vseq, ptitle, sysdate, null);
    presult := 1; --성공 메시지 반환
    commit;
    
exception
    when others then
        presult := 0; --실패 메시지 반환
        rollback;
end;


--호출
set serveroutput on;

declare
    vresult number;
begin
    procAddTodo('새로운 할일', vresult);
    dbms_output.put_line(vresult);
end;


select * from tblTodo;


--2. 수정 작업(U)
create or replace procedure 수정작업(
    수정할 데이터 -> in 매개변수,
    수정할 데이터 -> in 매개변수, --원하는 개수
    식별할 데이터 -> int 매개변수, --where절에 사용할 PK or 데이터
    성공 유무 반환 -> out 매개변수 -- N or 0
)
is
    내부 변수
begin
    작업(update + (insert, update, delete, select))
    commit;
exception
    when others then
        예외작업
        rollback;
end;


-- 할일을 했다. > completedate 채우기
create or replace procedure procCompleteTodo (
    --수정할 데이터 > sysdate 대치
    pseq in number,  --수정할 할일 번호
    presult out number --성공 유무
)
is
begin
    update tblTodo set
        completedate = sysdate
            where seq = pseq;
    presult := 1;
    commit;
exception
    when others then
        presult := 0;
        rollback;
end;

select * from tblTodo;

declare
    vresult number;
begin
    procCompleteTodo(32, vresult);
    dbms_output.put_line(vresult);
end;




--3. 삭제 작업(D)
create or replace procedure 삭제작업 (
    식별자 데이터 -> in 매개변수,
    성공 유무 반환 -> out 매개변수
)
is
    내부 변수
begin
    작업(delete + (insert, update, delete, select))
    commit;
exception
    when others then
        예외작업
        rollback;
end;



create or replace procedure procDeleteTodo (
    pseq number, --삭제할 할일 번호
    presult out number --N or 0
)
is
begin
    delete from tblTodo where seq = pseq;
    presult := 1;
    commit;
exception
    when others then
        presult := 0;
        rollback;
end;

select * from tblTodo;

declare
    vresult number;
begin
    procDeleteTodo(32, vresult);
    dbms_output.put_line(vresult);
end;



-- 4. 읽기 작업(R)
-- : 조건없이 반환 
-- : 조건있고 반환
-- : 반환 > 단일행 or 다중행 + 단일컬럼 or 다중행
create or replace procedure 읽기작업 (  
    조건 데이터 -> in 매개변수,
    단일 반환값 -> out 매개변수
)
is
    내부 변수
begin
    작업(select + (insert, update, delete, select))
    commit;
exception
    when others then
        예외작업
        rollback;
end;


create or replace procedure procCountTodo (  
    pstate in number, -- 0(안한일), 1(한일), 2(모두)
    pcnt out number
)
is
begin
    
    if pstate = 0 then
        select count(*) into pcnt from tblTodo where completedate is null;
    elsif pstate = 1 then
        select count(*) into pcnt from tblTodo where completedate is not null;
    else
        select count(*) into pcnt from tblTodo;
    end if;    
    
exception
    when others then
        dbms_output.put_line('에러발생');
end;



declare
    vcnt number;
begin
    procCountTodo(0, vcnt);
    dbms_output.put_line(vcnt);
    procCountTodo(1, vcnt);
    dbms_output.put_line(vcnt);
    procCountTodo(2, vcnt);
    dbms_output.put_line(vcnt);
end;



-- 4. 읽기 작업(R)
create or replace procedure 읽기작업 (  
    조건 데이터 -> in 매개변수,
    단일 반환값 -> out 매개변수,
    단일 반환값 -> out 매개변수,
    단일 반환값 -> out 매개변수 -- 원하는 만큼 > 1행 + 다중컬럼
)
is
    내부 변수
begin
    작업(select + (insert, update, delete, select))
    commit;
exception
    when others then
        예외작업
        rollback;
end;


create or replace procedure procCountSetTodo (  
    --조건 데이터 -> in 매개변수,
    pcnt1 out number,
    pcnt2 out number,
    pcnt3 out number
)
is
begin
    
    select count(*) into pcnt1 from tblTodo where completedate is null;
    select count(*) into pcnt2 from tblTodo where completedate is not null;
    select count(*) into pcnt3 from tblTodo;
    
exception
    when others then
        dbms_output.put_line('예외 발생');
end;


declare
    vcnt1 number;
    vcnt2 number;
    vcnt3 number;
begin
    procCountSetTodo(vcnt1, vcnt2, vcnt3);
    dbms_output.put_line(vcnt1);
    dbms_output.put_line(vcnt2);
    dbms_output.put_line(vcnt3);
end;






-- 4. 읽기 작업(R)
create or replace procedure 읽기작업 (  
    조건 데이터 -> in 매개변수,
    커서 -> out 매개변수 --행이 여러개
)
is
    내부 변수
begin
    작업(select + (insert, update, delete, select))
    commit;
exception
    when others then
        예외작업
        rollback;
end;


create or replace procedure procListTodo (  
    presult out sys_refcursor --반환값으로 커서를 사용할 때 사용하는 자료형(= 결과 테이블, ResultSet)
)
is
begin
    
    open presult for select * from tblTodo;
    
exception
    when others then
        dbms_output.put_line('예외 작업');
end;


declare
    vresult sys_refcursor; --프로시저의 커서
    vrow tblTodo%rowtype;
begin
    
    procListTodo(vresult);
    
    --vresult > 커서 탐색
    loop
        fetch vresult into vrow;
        exit when vresult%notfound;
        
        dbms_output.put_line(vrow.title);
    end loop;
    
end;