-- 여기는 iouser접속화면 

CREATE TABLE tbl_iolist (

    io_seq	NUMBER		PRIMARY KEY,
    io_pdate	VARCHAR2(10)	NOT NULL	,
    io_pname	nVARCHAR2(50)	NOT NULL	,
    io_dname	nVARCHAR2(50)	NOT NULL	,
    io_dceo	nVARCHAR2(20)	NOT NULL	,
    io_inout	nVARCHAR2(5)	NOT NULL,	
    io_qty	NUMBER	NOT NULL	,
    io_price	NUMBER	NOT NULL,	
    io_total	NUMBER		

);

SELECT COUNT(*) FROM tbl_iolist
where io_inout = '매입';
SELECT COUNT(*) FROM tbl_iolist
where io_inout = '매출';

SELECT io_inout, COUNT(*)
FROM tbl_iolist
GROUP BY io_inout;

--매입과 매출 금액 총합 

SELECT io_inout, SUM(io_total)
FROM tbl_iolist
GROUP BY io_inout;

SELECT 
  SUM(  DECODE(io_inout, '매입', io_total) ) AS 매입합계, 
  SUM(  DECODE(io_inout, '매출', io_total) ) AS 매출합계
FROM tbl_iolist;


--일년동안 매입금액과 매출금액을 계산하고
--단순 이익금 계산해보기
SELECT 
  SUM(  DECODE(io_inout, '매입', io_total) ) AS 매입합계, 
  SUM(  DECODE(io_inout, '매출', io_total) ) AS 매출합계,
  SUM(  DECODE(io_inout, '매출', io_total)) - 
  SUM(  DECODE(io_inout, '매입', io_total)) AS 이익금
FROM tbl_iolist;


--매입매출관련하여 
--소매점에서 상품을 매입하여 소비자한테 판매할때
--매입할때 매입부가세 발생
--판매할때 매출부가세 발생
-- 매출부가세 - 매입구사 발생 일년에 2~ 4회에 걸쳐 부가가치세를 납부한다

--농사를 지어서 쌀 20kg를 생산하여 판매를 하면
--5만원 정도의 금액에 판매하게된다
--쌀을 공장에서 가공하여 생산품(공산품)로 만들게되면
--실제 20kg의 쌀을 직접 판매하는것보다 더비싼가격에 판매를 하게된다
--이때 실제 쌀보다 더많은 이익이 발생하게되므로
--가치가 부가되었다라고 표현한다
--가치가 부가된만큼 세금을 납부하도록한다
--부가가치세 (Value Add tax, VAT)
--매입을 할때는 매입금액의 10% 만큼으로 세금을 포함하여 매입하고
--매출을 할때는 매출금액의 10%만큼 세금을 포함하여 판매한다

--매입매출 데이터에서 보면
--매입금액은 부가세 10%를 제외한 금액으로 입력하고
--매출금액은 부가세 10%가 포함된 금액으로 입력한다
--샘플데이터의 금액입력은 VAT제외 금액이고
--매출금액은 VAT포함된 금액이다
--매입과 매출데이터로 지난 1년간 납부한 VAT금액을 계산해보자



-- 매입금액 :22737397
-- 매출금액 :41683800
-- VAT = (매출금액에 포함된 VAT) - (매입금액 * 0.1)
-- 매출금액의 VAT 제외된 합계 = 매출금액 / 1.1
-- 매출부가세 =VAT 제외된 매출금액 *0.1
SELECT 
SUM(DECODE(io_inout,'매입',ROUND(io_total * 0.1))) AS 매입부가세,
SUM(DECODE(io_inout,'매출',ROUND((io_total /1.1) * 0.1 ))) AS 매출부가세,


SUM(DECODE(io_inout,'매출',ROUND((io_total /1.1) * 0.1 ))) -
SUM(DECODE(io_inout,'매입',ROUND(io_total * 0.1)))  AS 납부세액
FROM tbl_iolist;


-- 거래처별로 매입과 매출합계
-- DECODE(칼럼명, 조건값, true일때 ,false일때)
-- 실제 저장된 데이터를 PIVOT으로 보여주기
SELECT io_dname,

    SUM(DECODE(io_inout, '매입', io_total, 0)) AS 매입합계,
    SUM(DECODE(io_inout, '매출', io_total, 0)) AS 매출합계

FROM tbl_iolist
GROUP BY io_dname;


--상품별로 매입과 매출합계
SELECT io_pname,
    SUM(DECODE(io_inout,'매입',io_total,0)) AS 매입합계,
    SUM(DECODE(io_inout,'매출',io_total,0)) AS 매출합계
    from tbl_iolist
GROUP BY io_pname;

--2021-01-01부터 2020-06-30 기간동안
--거래된 리스트를 거래처별로 조회


SELECT * FROM tbl_iolist  
WHERE io_pdate BETWEEN '01/01/2020' AND '30/06/2020';

SELECT io_dname,
 SUM(DECODE(io_inout,'매입',io_total,0)) AS 매입,
 SUM(DECDDE(io_inout,'매출',io_total,0)) AS 매출
 FROM tbl_iolist
 WHERE io_pdate BETWEEN '01/01/2020' AND '30/06/2020'
 GROUP BY io_dname
 ORDER BY io_dname;
 
 -- 전체 데이터에서 상품리스트만 중복없이 조회
 --상품리스트와 매입, 매출단가 조회하기
 --같은 상품이라도 거래시기에 따라 매입과 매출금액이
 --달라질수 있기때문에
 --  단가 데이터중에서 제일높은 단가를 가져요기

SELECT io_pname,
    MAX (decode(io_inout,'매입',io_price,0)) AS 매입단가,
    MAX (decode(io_inout,'매출',io_price,0)) AS 매출단가

from tbl_iolist
GROUP by io_pname
ORDER BY io_pname;
/*
매입매출 데이터로 부터 상품정보 테이블데이터를 생성하기
1. 매입매출 데이터에서 상품명으로 그룹을하고
2. 매입, 매출 구분에 따라 각각 매입단가, 매출단가를 가져오기
3. 매입과 매출에 0인 값이 있다
4. 매입단가가 0인 데이터는 매출데이터에서 임의로 생성하기
    매출 단가의 80%를 매입단가로 하고, 부가세를 제외한 금액으로 계싼 
    E2항목의 값을 0.8로 곱하여 E2의 80% 가격이 되고 
    그 금액의 1.1로 나누면 부가세를 제외한 가격이 된다.
    =ROUND(IF(C2 = 0,(E2*0.8)/1.1,C2),0)
    
5.  매출단가가 0인 데이터는 매입데이터에서 임의로 생성하기
매입단가의 20% 를 추가하고 부가세 10%를 추가 
매입단가 20% + 10%
=INT(IF(E2=0,D2+20%+10%,E2)/10)*10
*/


 -- 전체 데이터에서 거래처 리스트만 중복없이 조회
 
 SELECT io_dname, io_dceo
 FROM tbl_iolist
 GROUP BY io_dname, io_dceo;
    ORDER BY io_dname;
    
    
    --상품정보 테이블
    --deFault속성
    --InSERT 를 수행할때 값이 지정되지않으면
    -- 자동으로 추가될 데이터
    --값을 지정해주지않으면 자동으로 NOT NULl로  설정된다
    CREATE TABLE tbl_product (
    p_code	CHAR(6)		PRIMARY KEY,
p_name	nVARCHAR2(50)	NOT NULL,	
p_iprice	NUMBER	NOT NULL	,
p_oprice	NUMBER	NOT NULL	,
p_vat	VARCHAR2(1)	DEFAULT'Y' --값이 지정되지않으며 Y로지정된다	
);

create table tbl_dept (

    dp_code	CHAR(5)		PRIMARY KEY,
dp_name	nVARCHAR2(50)	NOT NULL	,
dp_ceo	nVARCHAR2(50)	NOT NULL	,
dp_tel	VARCHAR2(50)	NOT NULL	,
dp_addr	nVARCHAR2(20)	NOT NULL	

)

SELECT * FROM tbl_dept;

/*
매입매출 데이터로부터
상품정보, 거래처정보 데이터를 생성하고
테이블을 생성하여 데이터를 impot했다
매입매출 데이터와, 상품정보 거래처 정보를 JOIN하기 위해서는 매입매출데이터에 상품코드 , 거래처 코드가 있어야한다
그러나 현재 데이터 코드 칼럼이 없이 칼럼만 있는 상태이다

매입 매출 데이터에 상품코드 거래처 코드 칼럼을 추가하고
세 table을 JOIN 할수 있도록 변경하기

*/














