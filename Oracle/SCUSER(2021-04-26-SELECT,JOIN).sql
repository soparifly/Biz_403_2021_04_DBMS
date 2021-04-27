-- scuser 접속

--학생정보  table생성

--학번 : 고정문자열 5, 기본키설정
--이름 : 한글가변문자열 20 , 널값이 올수없다
--학과 : 한글가변문자열 10,
--학년 : 가변가변문자열 20,
--주소 : 한글가변문자열 125
DROP TABLE tbl_STUDENT;
CREATE TABLE tbl_STUDENT(
st_num	CHAR(5)		PRIMARY KEY,
st_name	nVARCHAR2(20)	NOT NULL,	
st_dept	nVARCHAR2(10),		
st_grade	VARCHAR2(5),		
st_tel	VARCHAR2(20),		
st_addr	nVARCHAR2(125)
);

-- 학생 점수 테이블
--학번 : 고정문자열 기본키
--국어점수 : 숫자 , 빈칸 X
--영어점수 : 숫자 , 빈칸 X
--수학점수 : 숫자, 빈칸 X

CREATE TABLE tbl_score(
sc_num	CHAR(5)		PRIMARY KEY,
sc_kor	NUMBER	NOT NULL,	
sc_eng	NUMBER	NOT NULL,	
sc_math	NUMBER	NOT NULL

);
DROP TABLE tbl_SCORE;

DROP VIEW VIEW_SCORE;

--임포트한 데이터확인
SELECT * FROM tbl_student;

--임포트한 데이터의 개수(데이터 레코드의 수) 확인
--COUNT() : SQL  의 통계 함수, 개수를 계산
SELECT COUNT (*) FROM tbl_student;


--임포트된 성적데이터의 전체과목총점 계산
--통계함수 SUM() : 숫자 칼럼의 합계를 계산
-- 전체 레코드의 데이터를 합산
 

 SELECT SUM (sc_KOR) AS 국어총점,
        SUM (sc_ENG) AS 영어총점,
        SUM (sc_math) AS 수학총점
FROM tbl_score;


--숫자칼럼의 연산을 하여 총점 표시
SELECT sc_num AS 학번,
(sc_kor + sc_eng + sc_math) AS c총점
FROM tbl_score;


--전체 과목의 평균점수
--통계함수 avg()를 사용하여 과목 평균 계싼
--as를 생략할수 있다
 SELECT AVG(sc_kor) 국어, AVG(sc_eng) 영어, AVG(sc_math) 수학
 FROM tbl_score;

--전체 학생의 성적중에 국어 최고점, 국어 최저점
-- 통계함수 MAX() , MIN()
 SELECT MAX(SC_KOR), MIN(SC_KOR)
 FROM TBL_SCORE;
 
 SeLECT sc_num , sum(sc_kor)
FROM tbl_score
GROUP BY sc_num;

SELECT * FROM tbl_student
WHERE st_num ='S0005';

-- 성적데이터를 보면서 
--각 학생의 이름등을 같이보고싶다
--2개의 테이블을 JOIN을 하여 함께보자
-- tbl_score 테이블을 나열하고
-- tbl_scroe의 sc_num칼럼의 값과 같은 데이터를
-- tbl_student 에서 찾아서 함께 나열하라
  SELECT * FROM tbl_score, tbl_student
 WHERE sc_num = st_num; 

SELECT sc_num, st_name, st_dept, sc_kor, sc_eng, sc_math
FROM tbl_score, tbl_student
WHERE sc_num = st_num;


--2개 이상의 테이블을 Join할때
--각각 테이블의 컬럼(속성)이름이 같은 경우
--문제가 발생할 수 있다.
--문제가 발생할 경우에는 각테이블 이름을 명시해주어야한다
SELECT tbl_score.sc_num,
        tbl_student.st_name,
        tbl_student.st_dept,
        tbl_score.sc_kor,
        tbl_score.sc_eng,
        tbl_score.sc_math
FROM tbl_score, tbl_student
WHERE sc_num = st_num;

--테이블 이름을 풀네임으로 부착하기가 부담스럽다면
--테이블에 alias를 추가한후 
--각 칼럼이름에 alias를 사용할 수 있다
--테이블 alias에도 AS키워드를 사용하지만
--오라클에서는 테이블 Alias에 AS키워드를 사용하면 문법오류가 발생한다
SELECT SC.sc_num,
        ST.st_name,
        ST.st_dept,
        SC.sc_kor,
        SC.sc_eng,
        SC.sc_math
FROM tbl_score SC, tbl_student ST
WHERE sc_num = st_num;


--테스트를 위해서 학생데이터 일부를 삭제 
DELETE FROM tbl_student WHERE st_num >= 'S0080';

--학생 데이터에서 일부를 삭제한후 
--JOIN을 실행하였더니 
-- 성적데이터가 79개 밖에 조회되지않는다
-- 성적데이터는 모두 100개가 있지만 
-- 학생 데이터에서는 79개만 남아있는 상태이기때문에 
-- JOIN을한 결과가 79개 학생 데이터와 같은 수인 79개만 
-- 조회되고있다 
-- EQ JOIN (참조 무결성이 보장되는 경우 사용하는 일반적인 JOIN)
SELECT SC.sc_num,
        ST.st_name,
        ST.st_dept,
        SC.sc_kor,
        SC.sc_eng,
        SC.sc_math
FROM tbl_score SC, tbl_student ST
WHERE sc_num = st_num;

--학생데이터는 1~ 79번까지만 있고
--성적데이터는 1~ 100번까지있다
--성적데이터의 80~100번까지는 실제로 실제로 존재하는 학생인지 아닌지 증명할 방법이없다.
--이럴경우 성적데이터는 무결성이 깨진상태가 된다
--학생테이블과 성적 테이블간의 연관(관계) 참조가 무너진 상태가 된다.
-- ==> 참조 무결성이 깨졌다 / 오류가 발생했다 라고표현한다.
--참조 무결성에 문제가 생긴겅우
-- JOIN 을 했을때 인출되는 데이터의 신뢰성을 보증할 수 없다.
SELECT * FROM tbl_score;
SELECT * FROM tbl_student;


--참조 무결성 여부와 관계없이 
--모든 데이터를 JOIN하여 보고싶을때 
--참조 무결성에 문제가 있거나하는 경우
--LEFT JOIN(LEFT OUT JOIN) 이라고한다
-- tbl_score테이블의 데이터는 모두 보여주고
-- 학생 테이블에서 학생이 일치하는 학생이 있으면 같이보여달라
-- 보통 TABLE의 참조 무결성 보증을 설정하는 경우가 있는데
-- 참조 관계에 없는 다수의 테이블을 JOIN하여 보고싶을때는
-- LEFT JOIN을 사용한다,
--참조 무결성 보증이 된 경우도 LEFT JOIN을 수행하면
-- 모든 데이터의 참조 무결성이 잘되고 있는지 확인할 수 있다.
SELECT SC.sc_num,
        ST.st_name,
        ST.st_dept,
        SC.sc_kor,
        SC.sc_eng,
        SC.sc_math
    FROM tbl_score SC 
        LEFT JOIN tbl_student ST
         ON sc_num = st_num;
        
-- EQ JOIN을 이용할때 조건을 부여하지 않으면
-- 테이블 x 테이블 만큼의 데이터가 출력된다
--이렇게 인출된 데이터를 "카티션 곱" 이라고한다.
SELECT COUNT(*)
FROM tbl_score, tbl_student;
        
        
--학생데이터에 없는 학생의 성적이 추가되어있는지의 여부를 
--알아

SELECT COUNT(*)
FROM tbl_score
    LEFT JOIN tbl_student
        ON sc_num = st_num;
--학생데이터를 모두 나열하고 
--학생 데이터와 일치하는 성적데이터만 보여달라
--학생데이터와 성적 데이터간의 참조 무결성에 오류가 있기때문에
-- 실제 학생데이터에 존재하는 성적정보만 보고싶을때
SELECT COUNT(*)
FROM tbl_student
    LEFT JOIN tbl_score
        ON sc_num = st_num;        
        
--ROUND() DBMS 시스템 함수, 소수점 이하 자릿수 제한
--ROUND(값, 자릿수) :  자릿수 이하에서 반올림
--TRUNC(값,0)  : 자릿수 이하 값은 무조건 절사 , 소수점 이하 반올림하고 무조건 정수형으로
-- INT (값) : 소수점이하 절사하고 무조건 정수 형식으로 (오라클에서 안됨)

    DROP VIEW VIEW_성적정보;
   CREATE VIEW VIEW_성적정보 as (
   SELECT SC.sc_num AS 학번, 
        ST.st_name AS 이름,
        ST.st_dept AS 학과,
        ST.st_grade AS 학년,
        ST.st_tel AS 전화번호,
        SC.sc_kor AS 국어,
        SC.sc_eng AS 영어,
        SC.sc_math AS 수학,
        (sc_kor + sc_eng + sc_math) as 총점,
        Round((sc_kor + sc_eng + sc_math)/3,2) as 평균
    FROM tbl_score SC
        LEFT JOIN tbl_student ST
        ON sc_num = st_num
        );
        
        
        --학과별로 묶고
        --각 학과의 총점을 계산
        --평균도 계산
        --학과 컬럼을 GROUP BY로 묶지않으면 오류가 발생한다.
        SeLECT * FROM view_성적정보;
        
        SELECT * FROM view_성적정보
        ORDER by 학과, 총점 DESC;
        
        SELECT 학과, SUM(총점) AS 학과총점, ROUND (AVG(평균),0) AS 학과평균
        FROM view_성적정보
        GROUP BY 학과
        ORDER BY 학과평균 DESC , 학과총점 DESC;
--        ORDER BY SUM(총점) DESC;
        
        
        
        
        
        
        
        
        
        
        
        
        