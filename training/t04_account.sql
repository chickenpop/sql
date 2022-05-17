-- t04_account.sql

-- 프로젝트용 계정 만들기, 권한부여
-- system 계정으로 부여
create user projectAcc IDENTIFIED by java1234; -- 계정 생성

grant connect, resource to projectAcc; -- 권한 부여 connect, resource 이미 있는 권한 모음

-- 생성 후 접속 > name, 사용자 이름, 비밀번호, 비밀번호 저장 
-- 테스트 > 성공뜨면 저장하고 사용