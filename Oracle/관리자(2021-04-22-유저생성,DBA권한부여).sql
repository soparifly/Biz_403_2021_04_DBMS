-- 여기는 관리자 권한으로 접속 
DROP TABLESPACE schoolDB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

--데이터테이블 만들기
CREATE TABLESPACE schoolDB
DATAFILE 'C:/oraclexe/data/school1.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;
--오토사이즈는 보통 전체사이즈의 10퍼센트로 지정한다

--schema : table, index, view 등등 데이터의 전체적인 모음집
--객체들의 정보를 담는곳
--CREATE SCHEMA

--User만들기 오라클에서는 SCHEMA대신에 USER를 사용한다.
--scuser을 추가하면 schoolDB에 저장하라는 명령어 ->DATAFILE 'C:/oraclexe/data/school_1.dbf'에 저장된다 (자동저장 오라클장점)
CREATE USER scuser IDENTIFIED BY scuser
DEFAULT TABLESPACE schoolDB;

--권한부여, 실습을 위해서 DBA로 권한을 부여하자/ DBA권한은 최초의 한사람에게만 준다 //남발하면 DB보안적인 측면에서 무결성을 해칠수 있는 여지가 많다
-- DB와 관련된 보안용어 / 보안침해 : 허가받지않은 사용자가 접속하여 문제를 일으키기
--                     / 무결성 침해(파괴) : 허가받은 사용자가 권한을 남용하여 문제를 일크기기 
--                                          CUD(추가, 수정, 삭제)등을 잘못하여 데이터에 문제가 생기는것 

--접속창 없어졌을때 보기 - 접속

-- scuser에게 DBA권한을 부여한다
GRANT DBA TO scuser;


