-- 관리자

drop user kscuser ;
CREATE USER kscuser IDENTIFIED by kscuser
DEFAULT TABLESPACE KschoolDB;
grant dba TO kscuser;


CREATE TABLESPACE KschoolDB
DATAFILE 'C:/oraclexe/data/kschool.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;
