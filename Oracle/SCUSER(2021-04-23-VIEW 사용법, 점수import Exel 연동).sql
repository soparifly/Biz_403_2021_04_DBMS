--scuser 접속중
-- 학생의 점수를 저장할 Table 생성하기
-- 학번, 국어, 영어, 수학 항목을 저장
-- 고정문자열 : CHAR (최대크기)
--가변문자열: VARCHAR2(최대크기)
--한글가변문자열: nVARCHAR2(최대크기)
--숫자 : NUMBER(자릿수, 소수)

DROP TABLE tbl_score;
CREATE TABLE tbl_score(

sc_num CHAR(5),
sc_kor NUMBER,
sc_eng NUMBER,
sc_math NUMBER

);
--end table

--뒤에 컬럼명이없기때문에 쉽게 사용할수 있지만 항상 칼럼의 순서를 알고있어야하기때문에 모든칼럼에 데이터를 포함해야된다.=>임의로뺄수없다
--추천하지않음 // 만약 순서가 바뀌면 전혀 엉뚱한 데이터가 INSERT될수 있다.
-- INSERT 수행하기
--NULL 값을쓰면안되는지 물어보기
INSERT INTO tbl_score
VALUES('00001',90,80,90);


--추천
INSERT INTO tbl_score(sc_kor, sc_eng, sc_math, sc_num)
VALUES(90,70,80,'00002');

--테이블이 있는 상테에서 컬럼의 속성이 바뀌면 어떻게되는지 물어보기
SELECT * FROM tbl_score;

--위에서 생성한 tbl_score는 
-- 중복된 학번의 점수가  INSERT될수 있다
-- 한 학생의 점수가 2중 3중으로 INSERT되어 엉뚱한 결과가 나타날수있다,
-- NOT NULL & UNIQUE : PK로 선언하는 방법도 좋은방법
-- 제약 조건 부여
--1. 학번은 중복될 수 없고 절대 NULL이어서는 안된다
--2. 점수가 없는 학생의 데이터는 이후에 연산을 수행할때 문제를 일으킬수 있기매누에 NULL값이 없도록 하자

DROP TABLE tbl_score;


--PRIMERY KEY 여러개에 적용해야할때
CREATE TABLE tbl_score(

    sc_num CHAR(5),
    sc_kor NUMBER NOT NULL,
    sc_eng NUMBER NOT NULL,
    sc_math NUMBER NOT NULL,
     PRIMARY KEY (sc_num)
    );


--엑셀파일에서 작성하여 붙여넣기

CREATE TABLE tbl_score(

    sc_num	CHAR(5)		PRIMARY KEY,
    sc_kor	NUMBER	NOT NULL,	
    sc_eng	NUMBER	NOT NULL,	
    sc_math	NUMBER	NOT NULL
    
);

SELECT * FROM tbl_score;




--국어점수가 90점 이상인 리스트
SELECT * FROM tbl_score
WHERE sc_kor >=90;



--데이터를 보여줄때 머릿글(컬럼제목)을 바꾸어서 보이기
-- AS(Alies,별명)
SELECT sc_num AS 학번,sc_eng AS 영어, sc_kor AS 국어, sc_math AS 수학,
sc_kor + sc_eng + sc_math AS 총점
FROM tbl_score;


--총점이 250인 이상인 학생만 찾아서보여주기
SELECT sc_num AS 학번,sc_eng AS 영어, sc_kor AS 국어, sc_math AS 수학,
sc_kor + sc_eng + sc_math AS 총점
FROM tbl_score
where (sc_kor+ sc_eng+ sc_math) >=250;

SELECT sc_num AS 학번,sc_eng AS 영어, sc_kor AS 국어, sc_math AS 수학,
sc_kor + sc_eng + sc_math AS 총점 
FROM tbl_score
WHERE (sc_kor+ sc_eng + sc_math) >=250 
AND (sc_kor+ sc_eng + sc_math) <= 250 ;

--SELECT 사용하여 데이터를 조회하는데 
--계산하는 컬럼도 있고
-- 자꾸 문법이 복잡해진다
--새로운 TABLE만들어지는 것이 아님을 확실히하자
-- SELECT된 명령문을 VIEW 객체로 생성을 해둔다
-- VIEW는 사용법이 TABLE과 같다 
-- 단 SELECT 만 된다 
CREATE VIEW view_score
AS
(
    SELECT sc_num AS 학번,sc_eng AS 영어, sc_kor AS 국어, sc_math AS 수학,
    sc_kor + sc_eng + sc_math AS 총점 
    FROM tbl_score

);

SELECT * 
FROM view_score
WHERE 총점 >= 150 AND 총점 =250;

--영어 선생님의 전체학생의 정보를 보여줘야할때 다른과목의 점수는 감추고싶다
--보안적인 측면에서 사용자별로 보여줄 항목, 보이지않을 항목을 선별하여 view를 작성해두면
--불필요한 정보가 노출되는것을 최소화할수 있다


CREATE VIEW view_영어점수 AS (

    SELECT sc_num AS 학번, sc_eng AS 영어
    FROM tbl_score
    WHERE sc_num >= 'S0010' and sc_num <= 'S0020'
);

DROP VIEW view_영어점수;

