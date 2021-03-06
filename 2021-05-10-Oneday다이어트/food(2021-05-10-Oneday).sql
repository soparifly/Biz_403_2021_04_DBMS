--여기서부터 food



-- 식품정보 테이블tbl_foods 생성
DROP TABLE tbl_foods;
CREATE  TABLE tbl_foods (
    
    fd_code	CHAR(7)		PRIMARY KEY,
    fd_name	nVARCHAR2(200)	NOT NULL,	
    fd_birth	NUMBER	NOT NULL	,
    fd_ccode	CHAR(7)		,
    fd_bcode	CHAR(7)		,
    fd_order	NUMBER		,
    fd_weight	NUMBER		,
    fd_kcal	NUMBER		,
    fd_dan	NUMBER		,
    fd_gi	NUMBER		,
    fd_tan	NUMBER		,
    fd_dang	NUMBER		

);
--외래키 지정
ALTER TABLE tbl_foods
ADD CONSTRAINT fk_ccode FOREIGN KEY(fd_ccode)
REFERENCES tbl_company(cp_code);
--외래키지정
ALTER TABLE tbl_foods
ADD CONSTRAINT fk_bcode FOREIGN KEY(fd_bcode)
REFERENCES tbl_items(cb_code);



ALTER TABLE tbl_foods DROP CONSTRAINT fk_ccode;
ALTER TABLE tbl_foods DROP CONSTRAINT fk_bcode;


DESC tbl_foods;

--제조사 정보 테이블 tbl_company 생성
CREATE TABLE tbl_company(

cp_code	CHAR(6)		PRIMARY KEY,
cp_name	nVARCHAR2(200)	NOT NULL	

);



-- 식품 분류 정보테이블 tbl_items 생성
DROP TABLE tbl_items;
CREATE TABLE    tbl_items(

cb_code	CHAR(5) PRIMARY KEY,
cb_name	nVARCHAR2(10)
);

drop table tbl_myfoods;
CREATE TABLE tbl_myfoods(
    eat_date	VARCHAR2(10)	,
    eat_ccode	CHAR(7)	NOT NULL,
    eat_order	NUMBER	
    
);

ALTER TABLE tbl_myfoods 
ADD eat_seq CHAR(5) primary key;
--가. 일일 가공식품 섭취정보를 저장할 Table 설계 : tbl_myfoods 다음과 같이 날짜별로 식품을 섭취하며 섭취한 정보를 테이블에 INSERT 할수 있어야 한다
ALTER TABLE tbl_myfoods 
ADD CONSTRAINT fk_ecode  FOREIGN key (eat_ccode)
REFERENCES tbl_foods(fd_code);

/*
SELECT MF.eat_date 날짜,
MF.eat_ccode 식품코드,
MF.eat_order 섭취량,
    SUM(DECODE(섭취량,'입력한섭취량',(총내용량*섭취량))) AS 총내용량
FROM tbl_myfoods MF
LEFT JOIN tbl_foods FD
 ON FD.fd_code = MF.eat_ccode;
*/


select eat_seq 순번, eat_date 섭취일, fd_name 식품명, eat_ccode 식품코드

FROM tbl_myfoods
LEFT JOIN tbl_foods
ON eat_ccode = fd_code;



CREATE VIEW view_섭취정보 AS (
 SELECT MF.eat_seq ,  
    MF.eat_date 섭취일,
    FD.fd_name 식품명,
    MF.eat_ccode 식품코드,
    FD.fd_order 회제공량, 
    FD.fd_weight 총제공량, 
    MF.eat_order 내가섭취한량, 
 (FD.fd_kcal * MF.eat_order ) 에너지,
 ( FD.fd_dan * MF.eat_order )  단백질,
 ( FD.fd_gi * MF.eat_order ) 지방량,
 ( FD.fd_tan * MF.eat_order ) 탄수화물,
( FD.fd_dang * MF.eat_order )  총당
FROM tbl_myfoods MF 
 LEFT JOIN tbl_foods FD
ON MF.eat_ccode = FD.fd_code) ;

SELECT * FROM view_섭취정보;


SELECT * FROM tbl_foods
WHERE fd_name Like '%' || '고메' || '%' ;


SELECT * FROM view_식품목록
WHERE 상품명 LIKE '%' || '고메' || '%';

CREATE SEQUENCE eat_seq
START WITH 1
INCREMENT BY 1;

SELECT eat_seq.NEXTVAL FROM dual;


--무결성 검사  NULL인 항목이 있는지없는지 
SELECT *
FROM tbl_foods F
LEFT JOIN tbl_company C
 ON F.fd_ccode = C.cp_code
 WHERE C.cp_code IS NULL;
 
 CREATE VIEW view_식품정보 AS
 (
    SELECT
    fd_code	식품코드,
    fd_name	식품명,
    fd_birth	출시연도,
    fd_ccode	제조사코드,
    fd_bcode	분류코드,
    fd_order	제공량,
    fd_weight	총내용량,
    fd_kcal	에너지,
    fd_dan	단백질,
    fd_gi	지방,
    fd_tan	탄수화물,
    fd_dang	총당류,
    cp_name	제조사명,
    cb_name	분류명

FROM tbl_foods
    LEFT JOIN tbl_company
    on fd_code = cp_code
    LEFT JOIN tbl_items
    ON fd_ccode = cb_code
    ); 

SELECT 

eat_seq	일련번호,
eat_date	날짜,
eat_ccode	식품코드,
eat_order	섭취량,
식품코드,
    식품명,
    출시연도,
    제조사코드,
    분류코드,
    제공량,
    총내용량,
    에너지,
    단백질,
    지방,
    탄수화물,
    총당류,
    제조사명,
    분류명
FROM tbl_myfoods
LEFT JOIN view_식품정보
ON eat_ccode = 식품코드;

CREATE VIEW view_섭취량계산 AS (
SELECT 
    eat_date	날짜,
    eat_ccode	식품코드,
    식품코드,
    식품명,
    eat_order	섭취량,
    제공량 * eat_order as 제공량,
    총내용량 * eat_order as 총내용량,
    에너지 * eat_order as 에너지,
    단백질 * eat_order as 단백질,
    지방 * eat_order as 지방,
    탄수화물 * eat_order as 탄수화물,
    총당류 * eat_order as 총당류
   
FROM tbl_myfoods
LEFT JOIN view_식품정보
ON eat_ccode = 식품코드
);



