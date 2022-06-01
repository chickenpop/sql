-- B-04 관리자_개설 과정 관리.sql

-- 수료날짜

-- 테스트용 업데이트
update tblsugang set complete_date = null where complete_date = '22/02/01';

-- 수료일 미정 출력
select 
    c.course_seq,
    c.c_start_date,
    c.c_end_date,
    s.sugang_seq, 
    s.complete_date,
    s.progress
from tblcourse c
    inner join tblsugang s
        on c.course_seq = s.course_seq
            where c.c_end_date < sysdate and s.complete_date is null;
            
            
            
-- 수료일 업데이트

update tblsugang sg set complete_date = (select c.c_end_date from tblcourse c inner join tblsugang s on c.course_seq = s.course_seq    
                                                where c.c_end_date < sysdate and s.sugang_seq = sg.sugang_seq and s.progress <> '중도탈락');
                                                                                     

-- 테스트용
select * from tblsugang;    
update tblsugang set progress = '중도탈락' where sugang_seq = 180;
update tblsugang set progress = '중도탈락' where sugang_seq = 80;
update tblsugang set progress = '중도탈락' where sugang_seq = 150;


-- 삭제해야하는 거

select 
    sn.subname as 과목명,
    sp.attend_point as 출결배점,
    sp.pilgi_point as 필기배점,
    sp.silgi_point as 실기배점,
    sc.attend_score as 출결점수,
    sc.pilgi_score as 필기점수,
    sc.silgi_score as 실기점수,
    (sc.silgi_score + sc.pilgi_score + sc.attend_score) as 총점
from tblSugang s
    inner join tblCourse c on s.course_seq = c.course_seq --과정
         left join tblCsub cs on c.course_seq = cs.course_seq --과정내 과목
                inner join tblSubjectName sn on cs.subname_seq = sn.subname_seq --과목명
                        left outer join tblSubtPoint sp on cs.csub_seq = sp.csub_seq -- 강좌 배점 
                            left outer join tblScore sc on s.sugang_seq = sc.sugang_seq  -- 시험 점수 — 수정필요!!!
                                left outer join tbltestdate td
                                    on cs.csub_seq = td.csub_seq
                                        left outer join tblTest t
                                            on td.testnum_seq = t.testnum_seq
                                                left outer join tblTestName tn
                                                    on t.testname_seq = tn.testname_seq
    where sc.sugang_seq = 180;



select 
    sn.subname as 과목명,
    sp.attend_point as 출결배점,
    sp.pilgi_point as 필기배점,
    sp.silgi_point as 실기배점,
    sc.attend_score as 출결점수,
    sc.pilgi_score as 필기점수,
    sc.silgi_score as 실기점수,
    sc.silgi_score + sc.pilgi_score + sc.attend_score as 총점
    
from tblSugang s
    inner join tblCourse c on s.course_seq = c.course_seq --과정
         join tblCsub cs on c.course_seq = cs.course_seq --과정내 과목
                inner join tblSubjectName sn on cs.subname_seq = sn.subname_seq --과목명
                        left outer join tblSubtPoint sp on cs.csub_seq = sp.csub_seq --강좌 배점 
                            right outer join tblScore sc on s.sugang_seq = sc.sugang_seq and cs.csub_seq = sc.csub_seq -- 시험 점수 — 수정필요!!!
                            
where sc.sugang_seq = 181;





