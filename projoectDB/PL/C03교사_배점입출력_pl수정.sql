
-- C-03교사_배점입출력.sql - pl sql

-- C-03교사_배점입출력
-- 교사 로그인(테스트 교사)
select * from tblTeacher where t_password = 2532102;
select * from tblTeacher;
-- 배점 입력해야 하는 과목 정보 출력
-- 과목번호/강의실/과목명/과목시작일/과목종료일/교재명/출결/필기배점/실기배점
create or replace procedure procViewSubtPoint(

    -- 패스워드 입력
    ppw in tblteacher.t_password%type

)
is
    cscsub_seq tblcsub.csub_seq%type;
    rroom_name tblroom.room_name%type;
    snsubname tblsubjectname.subname%type;
    cscsstart_date tblcsub.csstart_date%type;
    cscsend_date tblcsub.csend_date%type;
    spattend_point tblsubtpoint.attend_point%type;
    sppilgi_point tblsubtpoint.pilgi_point%type;
    spsilgi_point tblsubtpoint.silgi_point%type;
    
    vstart_date date;
    vend_date date;
    
cursor vcursor 
    is
select 
    cs.csub_seq as 과목번호,
    r.room_name as 강의실,
    sn.subname as 과목명,
    cs.csstart_date as 과목시작일,
    cs.csend_date as 과목종료일,
    sp.attend_point as 출결배점,
    sp.pilgi_point as 필기배점,
    sp.silgi_point as 실기배점
from tblCourse c
    inner join tblRoom r
    on c.room_seq = r.room_seq
    inner join tblCourseName cn
    on c.cname_seq = cn.cname_seq
    inner join tblCSub cs
    on c.course_seq = cs.course_seq
    inner join tblSubjectName sn
    on cs.subname_seq = sn.subname_seq
    left outer join tblSubtPoint sp
    on cs.csub_seq = sp.csub_seq
where cs.csend_date < sysdate and sysdate < c.c_end_date and c.teacher_seq = (select teacher_seq from tblTeacher where t_password = ppw)
    order by cs.csstart_date;

begin
     
     open vcursor; 
     
     dbms_output.put_line('================================================================================================================================================='); 
     dbms_output.put_line(rpad('과목번호', 10, ' ') || rpad('강의실', 10, ' ') || rpad('과목명', 30, ' ') || rpad('과목시작일', 15, ' ') || rpad('과목종료일', 15, ' ')||rpad('출결배점', 12, ' ') || rpad('필기배점', 12, ' ') || rpad('실기배점', 12, ' '));
     dbms_output.put_line('================================================================================================================================================='); 
        loop
            fetch vcursor into  cscsub_seq, rroom_name, snsubname, cscsstart_date , cscsend_date ,  spattend_point ,  sppilgi_point ,  spsilgi_point ;
            exit when vcursor%notfound;
            
                dbms_output.put_line(rpad(cscsub_seq, 10, ' ') || rpad(rroom_name, 10, ' ') || rpad(snsubname, 30, ' ') || rpad(cscsstart_date, 15, ' ') || rpad(cscsend_date, 15, ' ') ||  rpad(spattend_point, 12, ' ') ||  rpad(sppilgi_point, 12, ' ') ||  rpad(spsilgi_point, 12, ' '));
        end loop;
    dbms_output.put_line('=================================================================================================================================================='); 
    close vcursor;

end;

set serveroutput on;

begin
    procViewSubtPoint(2532102);
end;


-- 특정 과목 선택 배점 입력, 시험문제 입력, 시험날짜 입력

-- 특정 과목 상세 내역 출력

create or replace procedure procViewsubname(

    -- 과목 번호 
    pcsub_seq in tblsubtpoint.csub_seq%type,
    
    presult out number
    
)
is

    spattend_point tblsubtpoint.attend_point%type;
    sppilgi_point  tblsubtpoint.pilgi_point%type;
    spsilgi_point  tblsubtpoint.silgi_point%type;
    tdtest_date    tbltestdate.test_date%type;
    tntest_type    tbltestname.test_type%type;
    tntest         tblTestName.test%type;
    
    cursor vcursor 
    is
select 
    sp.attend_point as 출결배점,
    sp.pilgi_point as  필기배점,
    sp.silgi_point as 실기배점,
    td.test_date as 시험날짜,
    tn.test_type as 유형,
    tn.test as 시험문제
from tblCSub cs 
    left outer join tblSubtPoint sp
    on cs.csub_seq = sp.csub_seq
    inner join tblSubjectName sn
    on cs.subname_seq = sn.subname_seq
    left outer join tbltestdate td
    on cs.csub_seq = td.csub_seq
    left outer join tblTest t
    on td.testnum_seq = t.testnum_seq
    left outer join tblTestName tn
    on t.testname_seq = tn.testname_seq
                 where cs.csub_seq = pcsub_seq;

begin
     open vcursor; 
     
     dbms_output.put_line('================================================================================================================================================='); 
     dbms_output.put_line(rpad('출결배점', 12, ' ') || rpad('필기배점', 12, ' ') || rpad('실기배점', 12, ' ') || rpad('시험날짜', 10, ' ')|| rpad('유형', 15, ' ') || rpad('시험문제', 15, ' '));
     dbms_output.put_line('================================================================================================================================================='); 
    loop
        fetch vcursor into  spattend_point, sppilgi_point, spsilgi_point, tdtest_date, tntest_type, tntest ;       
        exit when vcursor%notfound;
        
            dbms_output.put_line(rpad(spattend_point, 12, ' ') ||  rpad(sppilgi_point, 12, ' ') ||  rpad(spsilgi_point, 12, ' ') || rpad(tdtest_date, 10, ' ') || rpad(tntest_type , 15, ' ') || rpad(tntest, 15, ' '));
    end loop;
    dbms_output.put_line('=================================================================================================================================================='); 
    close vcursor;
    presult := 1;

exception
    when others then
        presult := 0;  
end;

declare
    vresult number;
begin
    
    procViewsubname(142, vresult);
    if(vresult = 1) then
        dbms_output.put_line('조회 완료되었습니다.');
    else
        dbms_output.put_line('조회 실패되었습니다.');
    end if;
    
end;



-- 배점 입력
create or replace procedure procSubtPoint(
    
     -- 패스워드 입력
    ppw in tblteacher.t_password%type,
    
    -- 배점 점수
    pattend_point in tblsubtpoint.attend_point%type,
    ppilgi_point in tblsubtpoint.pilgi_point%type,
    psilgi_point in tblsubtpoint.silgi_point%type,
    
    -- 과목 선택
    pcsub_seq in tblsubtpoint.csub_seq%type,
    
    -- 실행 결과
    presult out number
)
is
    vteacher_seq number;
    vsum number;
begin
    select teacher_seq into vteacher_seq from tblteacher where t_password= ppw;
    
    vsum := pattend_point + ppilgi_point + psilgi_point;
       
    if(vsum = 100) and (pattend_point >= 20) then
        insert into tblSubtPoint (subpoint_seq, attend_point, pilgi_point, silgi_point, teacher_seq, csub_seq) 
            values ((select max(subpoint_seq)+1 from tblSubtPoint), pattend_point, ppilgi_point, psilgi_point, vteacher_seq, pcsub_seq);
        presult := 1;
    elsif pattend_point is null or ppilgi_point is null or psilgi_point is null then
        presult := 2;    
    end if;

exception
    when others then
        presult := 0;
end procSubtPoint;

-- 배점 입력 insert
declare
    vresult number;
begin
    procSubtPoint(2532102, 20, 30, 50, 142, vresult);
    if(vresult = 1) then
        dbms_output.put_line('배점 입력에 성공했습니다.');
    else 
        dbms_output.put_line('배점 입력에 실패했습니다.');
    end if;
end;

select * from tblTestName;

-- 문제 입력
create or replace procedure procAddTest(
    
    -- 과목번호
    pcsub_seq in tblcsub.csub_seq%type,
    
    -- 시험 문제
    ptest in tbltestname.test%type,
    
    -- 필기/실기 
    ptest_type in tblTestName.test_type%type,
    
    prseult out number
)
is
begin

    if (ptest is not null) and (ptest_type is not null) then
        insert into tblTestName(testname_seq, test, test_type, subname_seq) 
            values((select max(testname_seq)+1 from tblTestname), ptest, ptest_type, (select s.subname_seq as subname_seq from tblcsub c inner join tblsubjectName s on c.subname_seq = s.subname_seq where csub_seq = pcsub_seq)); 
        prseult := 1;    
    end if;

exception
    when others then
        prseult := 0;

end procAddTest;


declare
    vresult number;
begin
    procAddTest(142, 'Java 필기 시험문제 클래스', '필기', vresult);
    if(vresult = 1) then
        dbms_output.put_line('시험문제 등록 성공했습니다.');
    else 
        dbms_output.put_line('시험문제 등록 실패했습니다.');
    end if;
end;


-- 시험 날짜 지정 
create or replace procedure procUpdateTestDate(
    
    pdate in tblTestDate.test_date%type,
    
    ptestname_seq in tbltestname.testname_seq%type,
    
    pcsub_seq in tblcsub.csub_seq%type,
    
    presult out number
)
is
    vnum number;
begin
    
    insert into tblTest(testnum_seq, teacher_seq, testname_seq) values((select max(testnum_seq)+1 from tbltest), pcsub_seq, ptestname_seq);    
    select max(testnum_seq) into vnum from tbltest;
    insert into tblTestDate(testdate_seq, test_date, testnum_seq, csub_seq) values((select max(testdate_seq)+1 from tblTestDate), pdate, vnum,  pcsub_seq);
    presult := 1;

exception
    when others then
        presult := 0;
end;

declare
    vresult number;
begin
    procUpdateTestDate('22/03/02', 74, 142, vresult);
    if(vresult = 1) then
        dbms_output.put_line('시험날짜 변경 성공했습니다.');
    else 
        dbms_output.put_line('시험날짜 변경 실패했습니다.');
    end if;
end;


