--kscuser 


--학생정보 테이블 
CREATE TABLE tbl_student (

    st_num	CHAR(5)		PRIMARY KEY,
    st_name	NVARCHAR2(20)	NOT NULL	,
    st_tel	VARCHAR2(20)		,
    st_addr	NVARCHAR2(125)		,
    st_grade	NUMBER	NOT NULL,	
    st_dpcode	CHAR(5)	NOT NULL	

);

--학과 테이블 
CREATE TABLE tbl_dept (
    dp_code	CHAR(5)	NOT NULL,
dp_name	NVARCHAR2(20)	NOT NULL,
dp_pro	NVARCHAR2(20)	NOT NULL,
dp_tel	VARCHAR2(5)	NOT NULL

);

--과목테이블
CREATE TABLE tbl_sbject (
    sb_code	CHAR(5)		PRIMARY KEY,
    sb_name	NVARCHAR2(25)	NOT NULL	,
    sb_prof	NVARCHAR2(25)	NOT NULL	
);

--성적테이블
CREATE TABLE tbl_score(
    sc_seq	NUMBER		PRIMARY KEY,
sc_stnum	NVARCHAR2(10)	NOT NULL	,
sc_sbcode	NVARCHAR2(25)	NOT NULL,	
sc_score	NUMBER		
);






