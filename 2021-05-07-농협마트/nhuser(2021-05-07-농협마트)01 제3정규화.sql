--여기서부터 nhuser '

SELECT io_inout, COUNT(*)
FROM tbl_iolist
GROUP BY io_inout;
-- 인아웃 매입이 1이면 매입 아니면 매출이라는뜻
SELECT DECODE(in_inout,'1','매입','매출') AS 구분,
    COUNT(*)
FROM tbl_iolist
GROUP BY DECODE(io_input,'1','매입','매출');


--IF io_inout == 1 THEN '매입'
--ELSE IF io_inout == 2

SELECT DECODE(io_inout,'1','매입','2','매출') AS 구분,
count (*)
from tbl_iolist
group by decode(io_inout,'1','매입','2','매출');


/*
매입 매추르 데이터를 DB import한후
테이블에서 상품정보와 거래처 정보를 분리하여
제3정규화를 수행하기
현재 매입매출 테이블에 상품이름과 거래처명 (대표포함)이
저장되어있다
현재 테이블에서 만약 상품이름이나 거래처명이 변경되어야하는 일이 발생한다면
다수의 데이터(레코드)에 변경(update)가 되는 상황이만들어진다

다수의 데이터를 변경하는 명령은 데이터 무결성을 해치는 원인중에
하나이다
상품테이블을 별도로 분리하고 상품코드, 상품명 형식으로 저장한후 매입 매출 테이블에는 상품명 대신 상품코드를 포함하고   
이후에 JOIN을 통해 데이터를 조회하는 것이 좋다

*/

--1. 매입매출 테이블에서 상품정보를 중복없이 축출하기
SELECT io_pname
FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;
--2. 매입 매출 테이블에서 상품정보와 매입단가도 같이 추출하기
--  전체 데이터에서 상품별로 가장 높은 가격을 가져와서
--  매입 매출 단가로 사용하자

SELECT io_pname,
    MAX(DECODE(io_inout,'1',io_price,0)) AS 매입단가,
    MAX(DECODE(io_inout,'2',io_price,0)) AS 매출단가

FROM tbl_iolist
GROUP BY io_pname
ORDER BY io_pname;

/*
상품리스트를 추출했는데 매입단가가 0, 또는 매출단가가 0인경우
매입단가와 매출단가를 계산하기

매입단가가 0인 경우 매출단가에서 마진(20%)을빼고 다시 부가세 10%를 뺀 가격 으로 계산
매입단가 = (매출단가 /1.2)/1.1
매출단가 = (매입단가 *1.2) * 1.1
매출단가 = INT(매출단가 /10) * 10

10원단위 절사 
매출단가 = INT(매출단가 /10) * 10 

*/


-- 추출된 상품 정보를 저장할 테이블생성
CREATE TABLE tbl_product (
    p_code	CHAR(6)		PRIMARY KEY,
p_name	nVARCHAR2(50)	NOT NULL	,
p_iprice	NUMBER	NOT NULL	,
p_oprice	NUMBER	NOT NULL	,
p_vat	VARCHAR2(1)	DEFAULT 'Y'	
);


--매입 매출 데이터에서 상품정보를 생성
--생성된 상품정보가 맞게 되었는지 검증하기
-- 2테이블을 Join 하여 혹시 Null값이 있는지 확인한다

SELECT IO.io_pname , P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name;
        
        
        --리스트가 너무많아서 찾기가 어려울때
        --JOIN된 상품정보의 상품이름이 NULL인 데이터만 조회하기
        --이 조회에서 데이터가 한건도 나타나지않아야한다
        SELECT IO.io_pname , P.p_name
        FROM tbl_iolist IO
        LEFT JOIN tbl_product P
        ON IO.io_pname = P.p_name
        WHERE P.p_name IS NULL;
        
        
        
        
        
        
        