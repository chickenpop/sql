-- B-08 관리자_출결 관리 및 출결 조회

-- 강의 상태 조회 
select 
    c.course_seq as "강의번호",
    n.course_neme as "강의 과정명",
    case 
        when sysdate < c.c_start_date then '강의예정'
        when sysdate between c.c_start_date and c.c_end_date then '강의중'
        when sysdate > c.c_end_date then '강의종료' 
    end as "강의상태"
from tblCourse c 
    inner join tblcoursename n 
        on c.cname_seq = n.cname_seq 
            order by c.course_seq desc;
           
-- 특정 개설 과정 출결 전체 조회 
select 
    distinct
    s.sugang_seq as "교육생 번호",
    m.m_name as "교육생 이름",
    (select count(*) from tblattendance where attendance_type = '정상' and sugang_seq = s.sugang_seq) as 정상,
    (select count(*) from tblattendance where attendance_type = '지각' and sugang_seq = s.sugang_seq) as 지각,
    (select count(*) from tblattendance where attendance_type = '조퇴' and sugang_seq = s.sugang_seq) as 조퇴,
    (select count(*) from tblattendance where attendance_type = '병가' and sugang_seq = s.sugang_seq) as 병가,
    (select count(*) from tblattendance where attendance_type = '결석' and sugang_seq = s.sugang_seq) as 결석,
    (select count(*) from tblattendance where attendance_type = '기타' and sugang_seq = s.sugang_seq) as 기타
from tblcourse c
    inner join tblcoursename cn
        on c.cname_seq = cn.cname_seq
            inner join tblsugang s
                on c.course_seq = s.course_seq
                    inner join tblmember m
                        on s.member_seq = m.member_seq
                            inner join tblattendance a
                                on s.sugang_seq = a.sugang_seq
                                    where c.course_seq = 25
                                        order by s.sugang_seq;
                                    
-- 특정 개설 과정 연도 조회
select 
    distinct
    s.sugang_seq as "교육생 번호",
    m.m_name as "교육생 이름",
    (select count(*) from tblattendance where attendance_type = '정상' and sugang_seq = s.sugang_seq and a.attend_date like '22/%') as 정상,
    (select count(*) from tblattendance where attendance_type = '지각' and sugang_seq = s.sugang_seq and a.attend_date like '22/%') as 지각,
    (select count(*) from tblattendance where attendance_type = '조퇴' and sugang_seq = s.sugang_seq and a.attend_date like '22/%') as 조퇴,
    (select count(*) from tblattendance where attendance_type = '병가' and sugang_seq = s.sugang_seq and a.attend_date like '22/%') as 병가,
    (select count(*) from tblattendance where attendance_type = '결석' and sugang_seq = s.sugang_seq and a.attend_date like '22/%') as 결석,
    (select count(*) from tblattendance where attendance_type = '기타' and sugang_seq = s.sugang_seq and a.attend_date like '22/%') as 기타
from tblcourse c
    inner join tblcoursename cn
        on c.cname_seq = cn.cname_seq
            inner join tblsugang s
                on c.course_seq = s.course_seq
                    inner join tblmember m
                        on s.member_seq = m.member_seq
                            inner join tblattendance a
                                on s.sugang_seq = a.sugang_seq
                                    where c.course_seq = 25  
                                        order by s.sugang_seq;

-- 특정 개설 과정 월 조회
select 
    distinct
    s.sugang_seq as "교육생 번호",
    m.m_name as "교육생 이름",
    (select count(*) from tblattendance where attendance_type = '정상' and sugang_seq = s.sugang_seq and attend_date like '22/04%') as 정상,
    (select count(*) from tblattendance where attendance_type = '지각' and sugang_seq = s.sugang_seq and attend_date like '22/04%') as 지각,
    (select count(*) from tblattendance where attendance_type = '조퇴' and sugang_seq = s.sugang_seq and attend_date like '22/04%') as 조퇴,
    (select count(*) from tblattendance where attendance_type = '병가' and sugang_seq = s.sugang_seq and attend_date like '22/04%') as 병가,
    (select count(*) from tblattendance where attendance_type = '결석' and sugang_seq = s.sugang_seq and attend_date like '22/04%') as 결석,
    (select count(*) from tblattendance where attendance_type = '기타' and sugang_seq = s.sugang_seq and attend_date like '22/04%') as 기타
from tblcourse c
    inner join tblcoursename cn
        on c.cname_seq = cn.cname_seq
            inner join tblsugang s
                on c.course_seq = s.course_seq
                    inner join tblmember m
                        on s.member_seq = m.member_seq
                            inner join tblattendance a
                                on s.sugang_seq = a.sugang_seq
                                    where c.course_seq = 25
                                        order by s.sugang_seq;


-- 특정 개설 과정 일 조회
select 
    su.sugang_seq as "교육생 번호",
    m.m_name as "교육생 이름",
    ad.attend_date as "출석일",
    ad.attendance_type as "상태"
from tblSugang su 
    inner join tblAttendance ad 
        on su.sugang_seq = ad.sugang_seq 
            inner join tblMember m 
                on su.member_seq = m.member_seq 
                    where su.course_seq = 25 and ad.attend_date like '22/03/01'
                        order by ad.attend_date;


-- 특정 교육생 출결 조회
select 
    m.m_name as "교육생 이름",
    a.attend_date as "출석일",
    a.attendance_type as "상태"
from tblcourse c
    inner join tblsugang s
        on c.course_seq = s.course_seq
            inner join tblmember m
                on s.member_seq = m.member_seq
                    inner join tblattendance a
                        on s.sugang_seq = a.sugang_seq
                            where a.sugang_seq = 182;
         
                                    
                        