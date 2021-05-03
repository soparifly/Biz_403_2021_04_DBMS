--bookuser


 
CREATE TABLE tbl_buyer (

bu_code CHAR(5) Primary KEY,
bu_name nVARCHAR2(50) not null,
bu_birth number NOT NULL,
bu_tel VARCHAR2(20),
bu_addr NVARCHAR2(20)

);
Delete tbl_buyer;
DROP TABLE tbl_ber;
SELECT * FROM tbl_buyer;

INSERT INTO tbl_buyer(bu_code,bu_name,bu_birth,bu_tel,bu_addr) VALUES ('S0001','김양','900513','01025550000','광천효광길26');
INSERT INTO tbl_buyer(bu_code,bu_name,bu_birth,bu_tel,bu_addr) VALUES ('S0001','김양','900513','01025550000','광천효광길26');


CREATE TABLE tbl_book_rent(
    br_seq	    NUMBER		PRIMARY KEY,
    br_sdate	VARCHAR2(10)	NOT NULL	,
    br_isbn	    CHAR(13)	NOT NULL	,
    br_bcode	CHAR(5)	NOT NULL	,
    br_edate	VARCHAR2(10)		,
    br_price	NUMBER		
);

SELECT * FROM tbl_book_rent;





DELETE tbl_books;

ALTER TABLE tbl_book_rent 
ADD CONSTRAINT fk_books FOREIGN KEY (br_isbn) REFERENCES tbl_books(bk_isbn);

ALTER TABLE tbl_book_rent
ADD CONSTRAINT fk_buyer FOREIGN KEY (br_bcode) REFERENCES tbl_buyer(bu_code);
COMMIT;
-- TBL_BOOK_RENT 와 TBL_BOOKS, TBL_BUYER TABLE 을 참조무결성 설정
-- 대상 테이블은 다중관계의 TABLE
-- TBL_BUYER 데이터 1개 (1명의) 고객데이터와
-- 다수의 TBL_BOOK_RENT N = 1 의 다수 관계이다
-- N의 TABLE 에서 FK를 설정을 하고 1의 테이블과 관계를 맺는다
/* ALTER TABLE tbl_book_rent --N (다, 多) TABLE 
 ADD CONSTRAINT fk_books --외래키의 이름정함
 FOREIGN KEY (br_isbn) -- N table의 컬럼
 REFERENCES tbl_books(bk_isbn) --1 TABLE과 컬럼
 
ALTER TABLE tbl_book_rent
ADD CONSTRAINT fk_buyer
FOREIGN KEY (br_bcode)
REFERENCES tbl_buyer(bu_code)

*/

DESC tbl_book_rent;
/*
이름       널?       유형           
-------- -------- ------------ 
BR_SEQ   NOT NULL NUMBER       
BR_SDATE NOT NULL VARCHAR2(10) 
BR_ISBN  NOT NULL CHAR(13)     
BR_BCODE NOT NULL CHAR(5)      
BR_EDATE          VARCHAR2(10) 
BR_PRICE          NUMBER       
tbl_book_rent table 에는 필수 사용하는 데이터 컬럼을
pk로 설정하는데 어려움이 있따
다른 table의 컬럼을 참조하고는 있지만
모든 컬럼이 중복값을 가질수 있는 관계로
단일 컬럼으로 pk로 설정할수 없다.

그래서 PK를 설정하고 더불어 주문관련 리스트를 보는데 사용할 br_seq컬럼을 만들고 이 컬럼으로 pk를 설정했다

*/
