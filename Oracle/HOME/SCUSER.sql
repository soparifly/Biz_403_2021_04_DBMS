--SCUSER 

CREATE TABLE tbl_score(

sc_num CHAR(5),
sc_kor NUMBER,
sc_eng NUMBER,
sc_math NUMBER
);

SELECT * FROM tbl_score
WHERE sc_kor >=90;


SELECT sc_num as 학번,
(sc_kor + sc_eng + sc_math) as 총점
from tbl_score;


CREATE TABLE tbl_student(
    st_num CHAR(5) primary key,
    st_name nVARCHAR2(20) not null,
    st_dept nVARCHAR2(10),
    st_grade VARCHAR(5),
    st_tel VARCHAR2(20),
    st_addr nVARCHAR2(125)
);

SELECT * FROM tbl_score, tbl_student
WHERE sc_num = st_num;


SELECT SC.sc_num, 
        ST.st_name,
        ST.st_dept,
        SC.sc_kor,
        SC.sc_eng,
        SC.sc_math
        
        FROM tbl_score SC, tbl_student ST
        where sc_num = st_num;
        
        
SELECT SC.sc_num,
        ST.st_name,
        ST.st_dept,
        SC.sc_kor,
        SC.sc_eng,
        SC.sc_math
        
        FROM tbl_score SC, tbl_student ST
        where sc_num = st_num;
        
SELECT SC.sc_num,
        ST.st_name,
        ST.st_dept,
        SC.sc_kor,
        SC.sc_eng,
        SC.sc_math
    FROM tbl_score SC
    LEFT JOIN tbl_student ST
    ON sc_num = st_num;
    
    
CREATE VIEW view_성적정보 as (
SELECT SC.sc_num AS 학번,
        ST.st_name AS 이름,
        ST.st_dept AS 학과,
        SC.sc_kor AS 국어,
        SC.sc_eng AS 영어,
        SC.sc_math AS 수학,
        (sc_kor + sc_eng + sc_math) as 총점,
        Round((sc_kor + sc_eng + sc_math)/3,2) as 평균
    FROM tbl_score SC
    LEFT JOIN tbl_student ST
    ON sc_num = st_num
    );




