-- 여기는 scuser로 접속


-- 예제 ) TABLE 명 tbl_student
--List:
--학번 st_num 고정 문자열 5
--이름:st_name, 한글 가변문자열 20
--학과:st_dept, 한글 가변문자열 10
--학년:st_grade,가변문자열 5
--전화번호: st_tel, 가변문자열 20
--주소 :st_addr 가변문자열 125

--풀이 : 일단 Table을 만든후 작성할 변수를 입력하여 줄을 세운다,
--       변수뒤에 문자열길이를 입력한다
-- 고정문자열 char , 한글 가변문자열 nVARCHAR2 , t
CREATE TABLE tbl_student(
st_num CHAR(5),
st_name nVARCHAR2(20),
st_deps NVARCHAR2(10),
-- 숫자값을 입력하지만 문자형으로 인식하기위해서 VARCHAR2로 입력한다
st_grade VARCHAR2(5),
--000-0000-0000
st_tel VARCHAR2(20),
st_addr NVARCHAR2(125)

);
--생성한 Table에 데이터 추가 
--DML(데이터 조작어) 명령를 사용하여 데이터를 추가(create)<-ddl하고는 다른개념이지만 
--테이블에 존재하지않는 데이터를 새로추가한다 라는개념
INSERT INTO tbl_student(st_num,st_name,st_dept,st_grade)
values('00001','홍길동','국어국문','3');

--데이터를 추가한 후에는 잘 추가되었는지 확인
--tbl_student table 에 저장되어있는 모든 데이터를 무조건 보여달라
SELECT * FROM tbl_student;

INSERT INTO tbl_student(st_num, st_dept, st_grade)
VALUES ('00001','홍길동','컴퓨터공학','2');

SELECT * FROM tbl_student;



-- 위에서 생성한  tbl_ sutdent테이블에는
--데이터를 추가하려고할때
-- 이름 데이터가 없어도 데이터가 정상적으로 추가가되어버린다
--같은 학번의 데이터가 이미 추가되어있어도 또다시 추가가 되어버린다
--이런식으로 데이터가 계속 추가된다면 전체 데이터의 신뢰성에 무제가 될것이다
--DBMS에서는 table(ENTIFY)를 설계하ㅓㄹ때 이러한 오류를 방지하기 위하여
--TABLE을 생성할때 "제약 조건"을 설정하여 데이터가 INSERT되지 못하도록 하는 기능이 있다
--작성된 TABLE을 삭제하고 다시 제약조건을 설정하여 생성하자

DROP TABLE tbl_student;
--1. 학생의 이름은 데이터가 반드시 있어야하만 한다.
--  st_name(학생이름) 칼럼은 NOT_NULL이어야한다
-- 2. 학번은 절대 중복되면안된다
--      tbl_student 테이블의 모든 데이터의 학번은 유일해야한다.

-- (,) 는 명령어한 문장을끝낸다 
CREATE TABLE tbl_student(
--유일한 학번만 제약조건
st_num CHAR(5) UNIQUE NOT NULL,
--빈칸으로 사용하는걸 금지함
st_name nVARCHAR2(20) NOT NULL,
st_dept NVARCHAR2(10),
-- 숫자값을 입력하지만 문자형으로 인식하기위해서 VARCHAR2로 입력한다
st_grade VARCHAR2(5),
--000-0000-0000
st_tel VARCHAR2(20),
st_addr NVARCHAR2(125)

);
--중간에 한 데이터라도 없으면 INSERT불가능하다
--학생이름  데이터를 같이 포함하여 INSERT수행
INSERT INTO tbl_student(st_dept,st_name)
VALUES('사회과학','이몽룡');

INSERT INTO tbl_student(st_dept,st_name,st_num)
VALUES('사회과학','이몽룡','00001');

--st_num컬럼이 UNIQUE인데 이미존재하는 00001학번으로 
--데이터를 추가하려고하니 문제가 있어서 INSERT불가
--Table 의 제약조건을 설정할때
-- UNIQUE는 매우 신중하게 선택해야한다
INSERT INTO tbl_student(st_dept,st_name,st_num)
VALUES('사회복지','홍길동','00100');

INSERT INTO tbl_student(st_dept,st_name,st_num)
VALUES('법학과','성춘향','00002');

INSERT INTO tbl_student(st_dept,st_name,st_num)
VALUES('컴퓨터공학','이몽룡','00001');

--INser값은 저장한 순차적으로 저장된다
SELECT * FROM tbl_student;

--<기본키 컬럼(primary key)> 
--반드시 원하는 데이터는 UNIQUE하면서 NOT NULL이어야 한다.
--하나의 데이터는 레코드 또는 객체라고부른다. 어떤칼럼을 기준으로 조회했을때 유일하게 값이 나타나는가 ==> 객체무결성 //기본키컬럼
--데이터를 조회(SELECT할때) st_num컬럼을 기준으로 조회를 하면 반드시 원하는 데이터를 1개만 보여주는 조건을 만족하게 하는 컬럼

DROP table tbl_student;
--DBMS에서는 기본키 제약조건을 설정하는 키워드가 별도로있다
--primary key : unique + not null + 기타 조건 + INDEX 자동생성(검색을빨리하기위한설정) TableTAP에서 SQL으로 자세한 명령어, INDEX확인가능
-- 매우 강력한, 가장 우선순위가 높은 제약조건이다.
CREATE TABLE tbl_student(
st_num CHAR(5) Primary key,
st_name nVARCHAR2(20) NOT NULL,
st_dept NVARCHAR2(10),
st_grade VARCHAR2(5),
st_tel VARCHAR2(20),
st_addr NVARCHAR2(125)
);

--DESCRIBE => DESC 표준 sql은 아니지만 사용함
--TABLE 구조를 보여달라
DESC tbl_student;


INSERT INTO tbl_student(st_dept,st_name,st_num)
VALUES('사회복지','홍길동','00100');

INSERT INTO tbl_student(st_dept,st_name,st_num)
VALUES('법학과','성춘향','00002');

INSERT INTO tbl_student(st_dept,st_name,st_num)
VALUES('컴퓨터공학','이몽룡','00001');

--PK(PRIMARY KEY)로 설정된 칼럼에 조건으로 데이터 조회하기
SELECT *
FROM tbl_student
WHERE st_num = '00001'; 
--개체무결성을 완성했다.

DROP TABLE tbl_student;

SELECT
FROM tbl_student;
