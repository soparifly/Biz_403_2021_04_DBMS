-- 여기서부터 scuser

DROP TABLE tbl_dept;

CREATE TABLE tbl_dept(

    dp_code CHAR(5)		PRIMARY KEY,
	dp_name	nVARCHAR2(20)	NOT NULL,	
	dp_prof	nVARCHAR2(20)	NOT NULL

);
INSERT INTO tbl_dept
VALUES('001','컴퓨터공학','토발즈');

INSERT INTO tbl_dept
VALUES('002','전자공학','이철기');

INSERT INTO tbl_dept
VALUES('003','법학','킹스필드');

INSERT INTO tbl_dept
VALUES('004','관광학','이한우');

INSERT INTO tbl_dept
VALUES('005','국어국문','백석기');
INSERT INTO tbl_dept
VALUES('006','영어영문','권오순');