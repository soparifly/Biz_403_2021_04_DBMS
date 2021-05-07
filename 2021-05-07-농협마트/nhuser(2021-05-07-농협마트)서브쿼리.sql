-- 여기는 nhuser로 접속

/*
iolist 테이블과 prod테이블간에 상품으로 Join을 하여 
Null값이 없는것이 확인되었다

1. iolist테이블에 상품 코드 칼럼을 추가하고 
2. prod테이블에서 상품코드를 가져와 iolist 테이블에 저장
3. iolist 테이블과 prod 테이블간에  상품코드를 기준으로 JOIN을 할수있도록
    테이블 변경을 시작한다

*/

--tbl_iolist에 상품코드를 저장할 컬럼을 추가

ALTER TABLE tbl_iolist
ADD io_pcode CHAR(6);

--추가된정보확인
DESC tbl_iolist;

--생성된 io_pcode 컬럼에 io_pname컬럼의 상품이름에 해당하는 
-- 코드데이터를 tbl_product에서 가져와서 
--저장을 해야한다.


--테이블의 데이터를 변경하기위한 DML
--tbl_iolist 전체를 반복하면서 
-- io_pcdoe칼럼에 값을 갱신하라
--이때 tbl_iolist의 상품으로 tbl_product데이터를 조회하여 일치하는 데이터가 있으면
--그중에 상품코드 컬럼의 값을 가져와서 io_pcode칼럼에 저장하라

-- 다중sub쿼리 
UPDATE tbl_iolist IO --iolist를 업데이트한다 
SET io_pcode = ( --여기io_pcode에 셋팅한다
    SELECT p_code FROM tbl_product P  --tbl_product에 p_code를
    WHERE IO.io_pname = P.p_name      -- 조건, IO리스트에 pname과 productd의 p_name 이 같을때
);

UPDATE tbl_iolist IO
SET io_pcode = 'A';
/*
iolist 전체 데이터를 보여달라
iolist 데이터의 상품이름을 product 테이블에서 조회하여
일치하는 상품이 있으면 리스트를 보일때 보여달라

*/

SELECT IO.io_pname,
(
    SELECT P.p_name FROM tbl_product P
     WHERE IO.io_pname = P.p_name
    ) AS 상품이름,
(
    SELECT P.p_name FROM tbl_product P
    WHERE IO.io_pname = P.p_name
    ) AS 상품코드    
FROM tbl_iolist IO;


SELECT  IO.io_pcode, IO.io_pname,
        P.p_code, P.p_name, P.p_iprice, P.p_oprice
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
    ON IO.io_pcode = P.p_code;

/*
매입매출데이터에서 거래처 정보를 추출하고
거래처 정보 데이터를 생성한후 
거래처 코드를 만들고
tbl_dept Table 을 작성한다음 데이터 import

iolist에 io_dcode 칼럼을 추가하고
데이터를 업데이트 수행
 */


--1. iolist로 부터 거래처명, 대표자명 컬럼을 기준으로
--중복되지않은 데이터를 조회
--거래처명 , 대표자 명 순으로 정렬


--projection :기준이 되는 컬럼을 SELECT 표현
SELECT io_dname, io_dceo --io_dceo, io_dname을 찾는다

    FROM tbl_iolist -- FROM tbl_iolist으로부터 

  GROUP BY  io_dceo, io_dname-- 그룹으로 묶는다 io_dname, io_dceo  중복되지않게 같은데이터는 1번만 출력하기위해
  ORDER BY io_dceo, io_dname;




