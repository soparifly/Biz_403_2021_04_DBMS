SELECT *
FROM tbl_student;

DROP TABLE tbl_student;

CREATE TABLE tbl_score(
st_num char(5),
st_kor NUMBER,
st_eng NUMBER,
st_math NUMBER
);

DROP TABLE tbl_score;


CREATE TABLE tbl_score(
st_num char(5) UNIQUE NOT NULL,
st_kor NUMBER NOT NULL,
st_eng NUMBER,
st_math NUMBER
);