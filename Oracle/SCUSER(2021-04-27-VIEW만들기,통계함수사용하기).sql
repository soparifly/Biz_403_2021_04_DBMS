--여기는 scuser접속
-- 학과 정보를 저장할 Table생성

CREATE TABLE tbl_dept (

dp_code	CHAR(5)		PRIMARY KEY,
dp_name	nVARCHAR2(20)	NOT NULL,	
dp_prof	nVARCHAR2(20)	NOT NULL	


);
DELETE FROM tbl_dept;

--여러개의 데이터를 동시에 INSERT하기
--다른테이블로부터 데이터를 복사할때 사용하는 방식
INSERT ALL
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('001','컴퓨터공학','토발즈')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('002','전자공학','이철기')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('003','법학','킹스필드')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('004','관광학','이한우')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('005','국어국문','백석기')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('006','영어영문','권오순')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('007','무역학','심하균')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('008','미술학','필리스')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('009','고전음악학','파파로티')
INTO tbl_dept (dp_code, dp_name, dp_prof) VALUES ('0010','정보통신공학','최양록')
SELECT * FROM DUAL
;


--지금수행한 insert명령으로 추가된 데이터를 
--실제 Storage에 반영하라

COMMIT;

Select * from tbl_dept;



DROP TABLE TBL_STUDENT;

CREATE TABLE tbl_student(
    st_num	CHAR(5)		PRIMARY KEY,
    st_name	nVARCHAR2(20)	NOT NULL,
    st_dcode	CHAR(3)	NOT NULL	,
    st_grade	CHAR(1)	NOT NULL	,
    st_tel	VARCHAR2(20)	NOT NULL	,
    st_addr	nVARCHAR2(125)		
);

--학생테이블과, 학과테이블을
--학생의 st_dcode칼럼과 , 학과의 dp_code칼럼을 연관지어
--join을 수행하라
-- 학생테이블의 모든데이터를 나열하고
--학과 테이블에서 일치하는 데이터를 가져와서 연관하여 보여라
 CREATE VIEW view_학생정보 AS 
 (
SELECT ST.st_num 학번,
    st.st_name 학생이름,
    st.st_dcode 학과코드,
    dp.dp_name 학과명,
    dp.dp_prof 담당교수,
    st.st_grade 학년,
    st.st_tel  전화번호,
    st.st_addr 주소
FROM tbl_student ST
 LEFT JOIN tbl_dept DP
 ON st.st_dcode=dp.dp_code
);

SELECT * FROM view_학생정보
 ORDER BY 학번;

--학생정보 테이블에서 학과별로 몇명의 학생이 재학중인지
--학과코드 = 학과명은 항상 같은 값이 되므로
--학과코드, 학과명으로 GROUP BY를 하면
--학과별로 묶음이 이루어진다
--학과별로 묶음을 만들고 묶은 학과에 포함된 레코드가 몇개인가
--세어보면, 학과별 학생인원수가 조회된다.

SELECT 학과코드, 학과명, COUNT(*)  인원수
FROM view_학생정보
GROUP BY 학과코드, 학과명;

SELECT * FROM tbl_score;

CREATE VIEW view_성적일람표 AS (


SELECT sc.sc_num 학번,st.st_name 이름,DP.DP_NAME 학과명, st.st_dcode 학과코드 ,dp.dp_prof 교수명,st.st_tel 전화번호, SC.SC_KOR 국어,sc.sc_eng 영어,sc.sc_math 수학,
(SC.SC_KOR + SC.SC_ENG+ SC.SC_MATH)총점, 
ROUND((SC.SC_KOR + SC.SC_ENG + SC.SC_MATH)/3) 평균

FROM tbl_score SC
 LEFT JOIN tbl_student ST
  ON SC.sc_num = st.st_num
  LEFT JOIN TBL_DEPT DP
   ON ST.ST_DCODE = DP.DP_CODE
   );
   ORDER BY sc.sc_num;
   
   
   SELECT * FROM VIEW_성적일람표
   ORDER BY 학번;
   
   
   
   
   --생성된 VIEW_성적일람표를 사용하여
   --1. 총점이 200점 이상인 학생은 몇명?
   --2. 평균이 7 5점 이상인 학생들의 평균점수는???
    --3.  학과별로 총점과 평균
--1번   
   SELECT COUNT(*) 
   FROM VIEW_성적일람표 
   WHERE 총점 >= 200;

--2번
    SELECT ROUND(AVG(평균),0) FROM VIEW_성적일람표
    WHERE 평균 >= 75;
    
--3번 학과코드와 학과명으로 그룹을 설정하고
--각 그룹의 총점과 평균을 계산
--최고점과 최저점

    SELECT 학과코드, 학과명, 
    SUM(총점), 
    ROUND(AVG(평균),0),
    MAX(평균) 최고점,
    MIN(평균) 최저점
    FROM VIEW_성적일람표
    GROUP BY 학과코드,학과명
    ORDER BY 학과코드;
    
   
   