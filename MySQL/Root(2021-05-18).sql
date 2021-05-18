-- DataBase Schema
-- 물리적 저장공간
-- Orcle: 테이블 스페이스+ 유저 생성을 하여 연동을 하면 유저를 통해서 모든 물리적 데이터베이스에 접근이된다
-- MySQL : 데이터 베이스가 스키마가 되고 모든데이터의 저장공간이 된다 유저는 단지 DBSW에 접속하는 사용자개념이고 구체적으로 DB스키마와 연결되지않는다


CREATE DATABASE GuestBook;

-- GbUSER 사용자를 등록하고
-- 접근권한 localhost로 제한하겠다
CREATE USER gbUser@localhost;
-- 원격 또는 다른서버, 클라이언트에서 접속하도록 설정

CREATE USER gbUser@'%';

-- MYSQL databse 는  MySQL에서 
-- 매우 중요한 정보가 저장되는곳alter
USE MYSQL; -- DB정보 확인을 위하여 DB사전에 접근
SHOW TABLES;

desc user;
-- 사용자 정보가 등록된 테이블 검색
SELECT HOST, User FROM user;
-- 등록된 사용자의 권한 확인
SHOW GRANTS FOR gbUser@localhost;

-- gbUser에게 모든권한을 부여하라
-- local host에서만 접근한다
GRANT all privileges on *.* TO 
gbUser@localhost;

-- @'192.168.0.%'; 
-- 현재 공유기에 공통으로 연결된
-- PC에서 Mysql Server에 접근하라
create USER gbUser@'192.168.0.%';

-- 현재 공통으로 연결된 PC에서 접근할때모든 권한을 부여하겟다
GRANT ALL privileges ON *.* TO
gbUser@'192.168.0.%';  -- 집에 공유기에 연결된 컴퓨터가 모두접속이가능하다는뜻

-- 5.8버젼에서 user 비번 변경하기
SELECT * FROM USER;
update USER SET password=password('1234')
WHERE USER = 'gbUser';
-- MYSQL 8.X 버젼에서 비번 변경하기
ALTER USER	'gbUser'@'localhost'
identified with mysql_native_password
BY '12345';




