--여기는 관리자 화면으로 접속
-- 오라클에서 DBMS 프로젝트를 수행할때 
-- 제일 먼저 할일 TableSpace를 만들기

--TableSpace == DataBase : 실제 데이터가 저장되는 공간, 파일
--DDL명령 (data difinition Language . 명령, 데이터 정의어)
--          DBA(DataBase Administrator)의 권한을 갖는 사용자가 사용하는 명령어
-- CREATE로 시작하는 대부분의 명령어
-- Oracle에서는 SYSDBA 권한 등급이 있으며
-- 일반적인 DBA보다 높은 권한을 갖고 있다.
-- SYSDBA권한은 TableSpace 를 만들고, User를 만드는 역할을 한다.
--SYS 사용자로 접속을 한 상태

CREATE TABLESPACE schoolDB
DATAFILE 'C:/oraclexe/data/school.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

--SYSDBA는 시스템 모든 부분에 접근할 수 있는 권한이 있어서 
-- 자칫 명령을 잘못 입력하고 실행하면 Oracle DBMS 자체에 문제가 생긴다
--때문에 SYSDBA보다 등급이 낮은 생성자를 생성하고
-- 생성된 사용자 계정으로 명령을 수행, 실습한다


--새로운 사용자 계정을 등록할때 TableSpace와 연결하여
-- 데이터 베이스를 추가할 수 있도록 설정
--scuer 계정으로 데이터를 추가하면 자동으로 schoolDB tablespace에 데이터가 모이게 된다
Create user scuser identified by scuser 
default tablespace schoolDB;

--DBMS 사용자 계정 
-- DBMS 는 사용자에게 권한 등급을 부여하여 데이터  생성 . 조회, 삭제, 변경등을 세부적으로 
-- 지정할수 있다 
-- 세부적인 항목은 회사. 조직 마다 별도로 정책을 만들어 사용하기때문에 
-- 규칙이 정해진것은 없다.

--보통 DBMS에서 새로운 사용자 계정을 등록하면 
--일반적인명령을 수행할수 있도록 허용하는데
--Oracle 은 새로운 사용자계정을 생성하면 
--아무것도 할수 없는 상태이다
--관리자는(SYSDBA)는 새로 생성된 계정이 무언가
--명령을 수행할수 있도록 
--권한을 부여받는 명령을 수행해주어야한다,.
-- 오라클은 새로사용된 사용자 계정은 DBMS에 접속한는것 조차 막놓는다
--때문에 접속ㄱ Profile을 만들어도 접속 Test에서 오류가 발생한다.


-- DCL(DATA Controll Lang,. 데이터 제어어)
-- 보안과 관련 명령
-- scuser 사용자에게 CREATE SESSION 권한을 부여
-- CREATE SESSION : DBMS 서버에 접속(logon)을 할 수 있는 권한
-- GRANT ** TO user : user에게 ** 권한을 부여한다.
GRANT Create SESSION To SCUSER;
-- REVOKE ** FROM user : user에게서 ** 권한을 제거하기 
REVOKE CREATE SESSION FROM scuser;

--tbl_school TaBle 에 데이터를 추가하는 권한을 scuser에게 부여
GRANT INSERT ON tbl_SCHOOL TO scuser;

--tbl_school TABLE 데이터를 조회할수 있는 권한을
-- scuser에게 부여
GRANT SELECT ON tbl_school TO scuser;

--원칙은 사용자에게 권한을 일일 지정하여 
-- 세부적으로 관리해야한다
-- 하지만 학습(실습)하는 입장에서 
-- 일일이 세부적으로 지정하기에는 매우 불편함이 있다.
-- 사용등록을 하고 DBA(DB관리자) 권한을 부여하여
-- 실습용이 하도록 사용하겠다.
GRANT DBA TO scUSER;


