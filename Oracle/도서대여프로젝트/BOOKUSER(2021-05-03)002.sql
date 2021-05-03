-- 2021.05.03
-- bookuser 접속

-- 도서대여 프로젝트의 회원정보 Table
CREATE TABLE tbl_buyer (
    bu_code       CHAR(5)          PRIMARY KEY,
    bu_name       nVarCHAR2(50)   NOT NULL,   
    bu_birth   NUMBER           NOT NULL,   
    bu_tel       VarCHAR2(20),      
    bu_addr       nVarCHAR2(125)      
);

SELECT *
FROM tbl_buyer;


CREATE TABLE tbl_book_rent(
    br_seq       NUMBER           PRIMARY KEY,
    br_sdate   VarCHAR2(10)   NOT NULL,
    br_isbn       CHAR(13)       NOT NULL,
    br_bcode   CHAR(5)           NOT NULL,
    br_edate   VarCHAR(10),   
    br_price   NUMBER   
);

DROP TABLE tbl_book_rent
CASCADE CONSTRAINTS;

DROP TABLE tbl_buyer
CASCADE CONSTRAINTS;


--tbl_book_rent와 tbl_books, tbl_buyer table을 참조무결성 설정
-- 대상 테이블은 다중관계의 테이블
-- tbl_byer 데이터 1개(1명의)고객이 다수의 tbl_book_rent 테이블에 포함이 된다

--tbl_buyer 1: tbl_book_rent N = 1:다 관계이다
-- N의 테이블에서 fk 설정을 하고 1의 테이블과 관계를 맺는다

ALTER TABLE tbl_book_rent           -- N 테이블
ADD CONSTRAINT fk_books             -- fk 이름
FOREIGN KEY(br_isbn)                -- N 테이블 칼럼
REFERENCES tbl_books(bk_isbn);  -- 1 테이블과 칼럼



ALTER TABLE tbl_book_rent           
ADD CONSTRAINT fk_buyer             
FOREIGN KEY(br_bcode)                
REFERENCES tbl_buyer(bu_code); 


DESC tbl_book_rent;
/*
이름       널?       유형           
-------- -------- ------------ 
BR_SEQ   NOT NULL NUMBER       
BR_SDATE NOT NULL VARCHAR2(10) 
BR_ISBN  NOT NULL CHAR(13)     
BR_BCODE NOT NULL VARCHAR2(5)  
BR_EDATE          CHAR(10)     
BR_PRICE          NUMBER    

tbl_book_rent 테이블에는 필수 사용하는 데이터 칼럼을 
PK로 설정하는ㄷ에 어려움이 있다
다른 table의 칼럼을 참조를 하고는 있지만
모든 칼럼이 중복 값을 가질 수 있는 관계로
단일 칼럼으로  pk를 설정할 수 없다

pk를 설정하고, 더불어 주문관련 리스트를 보는데 사용할
br_seq 칼럼을 만들고 이 칼럼으로 pk를 설정했다.

book_rent 테이블에 데이터를 Insert하려고 할 떄
항상 유일한 값으로 pk를 설정해야하나는 어려움이 있다
보통 이러한 칼럼은 일련번호 순으로 만드는데
오라클 이외의 다른 DBMS는 일련번호를 자동으로 만들어주는 테이블 속성이 있다.

오라클(11 이하)에서는 그러한 속성이 없다

mySQL의 경우 칼럼 속성에 AUTO_INCREMENT로 설정을 하면
그 칼럼은 INSERT 할 떄 별도 값을 지정하지 않아도
항상 유일한 일련번호로 자동 생성이 된다. 

오라클에서는 일련번호를 생성하기 위한 별도의 객체가 존재한다.

*/

-- 오라클에서 일련번호를 생성하는 SEQUENCE 객체
-- DDL 명령을 사용하여 SEQ 객체 생성
-- 보통 이름을 명명할 떄 SEQ_로 시작하고
-- 뒤에 적용할 대상 table 명을 붙여 생성한다
CREATE SEQUENCE seq_book_rent   -- 시퀀스 이름
START WITH 1                    -- 시작값
INCREMENT BY 1 ;                -- 증가값

SELECT seq_book_rent.NEXTVAL FROM dual;


INSERT INTO tbl_book_rent(br_seq, br_sdate, br_isbn, br_bcode)
VALUES(SEQ_BOOK_RENT.nextval, '2021-05-03','9791162540732','B0001');

SELECT *
FROM tbl_book_rent ;



-- 이미 만들어져 있는 시퀀스 삭제하기
DROP SEQUENCE seq_book_rent ;


-- 기존에 사용하던 시퀀스를 삭제하고 다시 생성할 경우
-- 반드시 적용되는 테이블의 칼럼값을 확인해야 한다
-- 시퀀스 칼럼의 최대값을 확인하고
SELECT MAX(br_seq) FROM tbl_book_rent;


-- SEQ의 start 값을 적용하는 테이블의 SEQ 최대값보다
-- 크게 설정을 하자 
CREATE SEQUENCE seq_book_rent
START WITH 25
INCREMENT BY 1 ;



INSERT INTO tbl_book_rent(br_seq, br_sdate, br_isbn, br_bcode)
VALUES(SEQ_BOOK_RENT.nextval, '2021-05-02','9791186805398','B0003');


-- tbl_book_rent는 회원이 도서를 대여한 리스트가 있다
-- 여기에는 도서코드, 회원코드만 있기 때문에
-- 구체적인 정보를 알 수 없다
-- Table 조인을 통해서 구체적인 정보를 확인하자


-- EQ 조인
SELECT *
FROM tbl_book_rent BR, tbl_books BO, tbl_buyer BU
    WHERE br.br_isbn = bo.bk_isbn AND br.br_bcode = bu.bu_code ; 


-- INNER 조인
-- FK 관계가 설정된 테이블 간에 사용하는 조인
-- FK 관계가 설정되지 않은 테이블 간에서는 조회되는 데이터가
-- 실제와 다를 수 있다.
-- 반드시 폴링키가 설정되어 있어야 한다는 전제가 있어야 한다. 
SELECT 
    br.br_sdate AS 대여일,
    br.br_bcode AS 회원코드,
    bu.bu_name AS 회원명,
    br.br_isbn AS ISBN,
    bk.bk_title AS 도서명,
    br.br_edate AS  반납일,
    br.br_price AS 대여금
FROM tbl_book_rent BR
    JOIN tbl_books BK
        ON br.br_isbn = bk.bk_isbn
    JOIN tbl_buyer BU
        on br.br_bcode = bu.bu_code ;


-- LEFR(OUTER) JOIN
-- 테이블간에 FK가 설정되지 않고
-- 참조하는 테이블의 데이터가 마련되지 않은 경우
-- FROM 절에 표현된 테이블 데이터 위주로 조회하고자 할 때
-- FK 설정되지 않아도 데이터 조회는 모두 할 수 있다
-- 단 조인된 테이블에 데이터가 없으면 (NULL)로 표현된다.
DROP view VIEW_도서대여정보;




CREATE VIEW view_도서대여정보 AS (
    SELECT 
        BR.br_seq AS 주문번호,
        BR.br_sdate AS 대여일,
        BR.br_bcode AS 회원코드,
        BU.bu_name AS 회원명,
        BU.bu_tel AS 회원연락처,
        BR.br_isbn AS ISBN,
        BK.bk_title AS 도서명,
        BR.br_edate AS  반납일,
        BR.br_price AS 대여금
    FROM tbl_book_rent BR
        LEFT JOIN tbl_books BK
            ON br.br_isbn = bk.bk_isbn
        LEFT JOIN tbl_buyer BU
            on br.br_bcode = bu.bu_code             
);



SELECT *
FROM view_도서대여정보 ;

SELECT *
FROM view_도서대여정보 
WHERE 회원명 = '명윤일';

SELECT *
FROM view_도서대여정보 
WHERE 대여일 > '2021-04-30';


-- 4월 25일 이전에 대여했는데
-- 아직 반납하지 않은 사람
SELECT *
FROM view_도서대여정보 
WHERE 대여일 < '2021-05-03' AND 반납일 IS NULL;

SELECT 대여일, 회원코드, 회원명, 반납일, bu.bu_tel
FROM view_도서대여정보 BR
    LEFT JOIN tbl_buyer BU
        ON BR."회원코드" = bu.bu_code
WHERE 대여일 < '2021-05-03' AND 반납일 IS NULL;

--중복된 데이터가 있으면 그룹으로 묶어서 단순하게 보여달라

SELECT 대여일, 회원코드, 회원명, BU.bu_tel
FROM view_도서대여정보 BR
 LEFT JOIN tbl_buyer BU
    ON BR.회원코드 = BU.bu_code
    WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL
     GROUP BY 대여일, 회원코드, 회원명, BU.bu_tel;
     --from절이 먼저실행되서 필요한데이터만 추출하고 그룹으로 묶어서 출력함

SELECT 대여일, 회원코드, 회원명, BU.bu_tel
FROM view_도서대여정보 BR
 LEFT JOIN tbl_buyer BU
    ON BR.회원코드 = BU.bu_code
     GROUP BY 대여일, 회원코드, 회원명, BU.bu_tel
    HAVING 대여일 < '2021-04-25' AND 반납일 IS NULL;
   --전체데이터를 group byu를 묶고 그안에서 
   --having 은 groupby 와 사용가능하다
     --전체데이터를 그룹으로 묶고 , 대여일이 
     
     --예제)
     /*
     학생이름  과목  점수
     ---------------------
     
      홍길동   국어   50
      홍길동   영어   50
      홍길동   수학   50
      이몽룡   국어    90
      이몽룡   영어    90
      이몽룡   수학    90
      --------------------
      홍길동 150
      이몽룡 270
      이데이터에서 홍길동 학생의 3과목 총점을 계산하기 위한 코드
       */
     select 학생이름 , sum(점수) 
     from tbl_score
     GROUP BY 학생이름
     HAVING SUM(점수)> 90;
     
     
     /*
     위의 코드는 전체 데이터중에서 대여일과 반납일에 조건을 부여한후
     데이터를 간추리고 , 간추려진 데이터를 GROUP으로 묶어 보여주기
  
     아래 코드는 전체 데이터를 Group으로 묶고 
     묶인 데이터를 조건에 맞는 항목만 보여주기
     
     이 두 코드는 결과는 같지만 실행하는 성능은 매우 많은 차이가난다
     데이터가 많을수록 성능차이는 매우 극명하게 나타난다
     */
     
     --tbl_score에서 과학, 수학2과목의 점수만 총점을 계산하고싶다
     SELECT 학생이름, SUM(점수)
     FROM tbl_score
     where 과목 = '과학' or 과목 = '수학'
     group by 학생이름;
     
     --직업별로 급여를 합계 계산할때
     --직업이 영업직인 사람을 제외하고싶다
     
     select 직업, sum(급여)
     from tbl_급여
     where 직업!= '영업직'
     group by 직업;
     
     select 직업, sum(급여)
     from tbl_급여
     group by 직업
     having 직업!='영업직';
     --급여테이블에서 영업직을 제외한 급여의 급여 총합계를 계산하고
     --총합계가 3000000이상인 데이터만 보여라
     select 직업, sum(급여)
     from tbl_급여
     WHERE 직업 !='영업직' 
     group by 직업
     having sum(급여) >= 300000; 
     
     
    select 직업, sum(급여)
     from tbl_급여
     WHERE 직업 !='영업직' AND 급여 > 1000000;
     group by 직업;
     
     
     drop view view_도서대여정보;
     
     
     --대여일이 2021-04-25 이전이고 아직 미반납된 데이터
     SELECT * FROM VIEW_도서대여정보
     WHERE 대여일 < '2021-04-25'AND 반납일 IS NULL;
     
     SELECT 대여일, 회원코드, 회원명, 회원연락처, 도서명
     FROM VIEW_도서대여정보
     WHERE 대여일 < '2021-04-25' AND 반납일 IS NULL
     GROUP BY 대여일, 회원코드, 회원명, 회원연락처, 도서명
     ORDER BY 회원코드;
     
     
     INSERT INTO tbl_book_rent(br_seq, br_Sdate, br_bcode, br_isbn)
     values (seq_book_rent.NEXTVAL,
     '2021-04-21','B0012','9791162540770');
     
     