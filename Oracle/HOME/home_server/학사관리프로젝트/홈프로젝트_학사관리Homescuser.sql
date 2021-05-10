--Homescuser
--점수테이블
CREATE TABLE tbl_score(
sc_seq NUMBER PRIMARY KEY,
sc_stnum CHAR(5) NOT NULL,
sc_sbcode CHAR(5) NOT NULL,
sc_score NUMBER
);
--과목테이블
CREATE TABLE tbl_sbject(
sb_code CHAR(6) PRIMARY KEY,
sb_name nVARCHAR2(15) NOT NULL,
sb_prof nVARCHAR2(10)
);


--학생테이블
CREATE TABLE tbl_student(
st_num char(5) PRIMARY KEY,
st_name NVARCHAR2(20) NOT NULL,
st_tel VARCHAR2(20),
st_addr nVARCHAR2(125),
st_grade NUMBER,
st_dpcode CHAR(5)
);
--과목테이
CREATE TABLE tbl_dept(
dp_code CHAR(5) PRIMARY KEY,
dp_name nVARCHAR2(10) NOT NULL,
dp_pro nVARCHAR2(10),
dp_tel VARCHAR2(5)
);


--학생정보 테이블 작성 학번,학생이름,학과코드,학과명,담당교수,학년,전화번호,주소
CREATE VIEW view_학생정보 AS (
    SELECT ST.st_num,
    ST.st_name,
    D.dp_code,
    D.dp_name,
    D.dp_pro,
    st.st_grade,st.st_tel,st.st_addr
    FROM tbl_student ST
    LEFT JOIN tbl_dept D
    ON st_dpcode = dp_code
    );


--제 2정규
CREATE view view_성적정보 AS (
SELECT sc.sc_seq 일련번호,
SC.sc_stnum 학번,
ST.st_name 학생이름,
ST.st_tel 학생전화번호,
SC.sc_sbcode 과목번호,
SB.sb_name 과목명,
SC.sc_score 점수,
SB.sb_prof 담당교수
FROM tbl_score SC
    LEFT JOIN tbl_student ST
    ON SC.sc_stnum = St.st_num 
    LEFT JOIN tbl_sbject SB
    ON sc_sbcode = SB.sb_code
    );

SELECT 학번, 학생이름, sum(점수) as 총점,
ROUND(AVG(점수),1)as평균화
from view_성적정보
group by 학번, 학생이름
order by 학번;








select 학번,
     DECODE(과목명,'국어',점수) AS 국어점수,
     DECODE(과목명,'영어',점수) AS 영어점수,
     DECODE(과목명,'수학',점수) AS 수학점수
     
     FROM view_성적정보
     order by 학번;
     
select 학번,
SUM(DECODE(과목명,'국어',점수)) AS 국어점수,
SUM(DECODE(과목명,'영어',점수))AS 영어점수,
SUM(DECODE(과목명,'수학',점수)) AS 수학점수
FROM view_성적정보
GROUP BY 학번
order by 학번;
     





