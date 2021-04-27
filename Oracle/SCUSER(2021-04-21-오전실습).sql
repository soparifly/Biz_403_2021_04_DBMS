-- 여기서부터 scuser

DROP TABLE tbl_dept;

CREATE TABLE tbl_dept(

    dp_code CHAR(5)		PRIMARY KEY,
	dp_name	nVARCHAR2(20)	NOT NULL,	
	dp_prof	nVARCHAR2(20)	NOT NULL

);

