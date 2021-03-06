--여기서부터 관리자



CREATE TABLESPACE homeDB
DATAFILE 'C:\oraclexe\data\homeDB.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K ;

DROP TABLESPACE homeDB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;


DROP USER home; 
CREATE USER home IDENTIFIED BY home
DEFAULT TABLESPACE homeDB;

GRANT DBA TO home;

CREATE TABLESPACE scinfoDB
DATAFILE 'C:\oraclexe\data\scinfoDB.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

DROP TABLESPACE scinfoDB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;


CREATE TABLESPACE homeschoolDB
DATAFILE 'C:\oraclexe\data\homeschoolDB.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER Homescuser IDENTIFIED BY Homescuser
DEFAULT TABLESPACE homeschoolDB;
GRANT DBA TO Homescuser;