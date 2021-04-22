-- 여기는 관리자 접속
-- 실습을 위해 기존 객체 삭제
DROP USER scuser CASCADE;

--TABLE SPACE 삭제

DROP TABLESPACE schoolDB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

-------------------------------------------------------------

--TABLESPACE 생성

--SchooleDB, dataFile : school.dbf, SIZE :1m, Ex: 1k

CREATE TABLESPACE SchoolDB
DATAFILE 'C:/oraclexe/data/school.dbf'
Size 1M AUTOEXTEND ON NEXT 1K;

--사용자 생성
-- id: scuser, pw : scuser
-- default tablespace : schoolDB

create user scuser identified by scuser
default tablespace schoolDB;

-- 사용자 권한 부여
-- 편의상 DBA 권한을 부여

Grant dba to scuser;

-- 삭제는 역순으로 한다.