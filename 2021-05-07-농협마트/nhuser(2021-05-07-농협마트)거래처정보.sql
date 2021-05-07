--nhuser

Create table tbl_dept (
d_code	CHAR(6)		PRIMARY KEY,
d_name	nVARCHAR2(50)	NOT NULL,	
d_ceo	nVARCHAR2(20)	NOT NULL,	
d_tel	VARCHAR2(20)		,
d_addr	nVARCHAR2(125)		,
d_product	nVARCHAR2(20)		

);

--impot 된 거래처정보와 매입매출정보를 JOIN하여 
--NULL값이 있는지 확인

SELECT io_dname, d_name, d_ceo, d_code
FROM tbl_iolist
LEFT JOIN tbl_dept
ON io_dname = d_name AND io_dceo = d_ceo;

--거래처 정보 테이블에서 거래처 코드를 조회하여
--tbl_iolist의 io_dcode 칼럼에 UDATE
/*
ALTER TABLE tbl_iolist
ADD io_dcode CHAR(6);
*/

--매입 매출 정보 Table에 io_dcode칼럼 추가, 
--CHAR(5)
ALTER TABLE tbl_iolist
ADD io_dcode CHAR(6);
--추가된정보 확인
DESC tbl_iolist;

--업데이트함 iolst 의 dcode를 조회하여 
UPDATE tbl_iolist
    SET io_dcode = ( 
    SELECT d_code
    FROM tbl_dept
    WHERE io_dname = d_name AND io_dceo = d_ceo

);


SELECT  io_date, io_time,
        io_pcode, p_name,
        io_dcode, d_name, d_ceo,
        DECODE(io_inout,1,'매입',2,'매출')AS 구분,
        io_qty, io_price
FROM tbl_iolist 
LEFT JOIN tbl_product
ON p_code = io_pcode
LEFT JOIN tbl_dept
ON d_code = io_dcode;

