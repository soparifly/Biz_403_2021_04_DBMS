--scuser 접속

DROP TABLE tbl_student;

CREATE TABLE tbl_student(
    
    st_num CHAR(5) PRIMARY KEY,
    st_name NVARCHAR2(20),
    st_dept NVARCHAR2(10),
    st_grade VARCHAR2(5),
    st_tel varchar(20),
    st_address NVARCHAR2(125)
    );
    
    
    
DROP TABLE tbl_score;

CREATE TABLE tbl_score(
    st_num CHAR(5) PRIMARY KEY,
    sc_kor NUMBER NOT NULL,
    sc_eng  NUMBER NOT NULL,
    sc_math NUMBER NOT NULL
    );
    

