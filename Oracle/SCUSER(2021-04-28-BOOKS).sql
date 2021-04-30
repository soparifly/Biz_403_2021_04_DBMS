--SCUSER

CREATE TABLE tbl_books_v1(
    bk_isbn	CHAR(13)		PRIMARY KEY,
    bk_comp	NVARCHAR2(15)	NOT NULL	,
    bk_title	NVARCHAR2(125)	NOT NULL,	
    bk_author	NVARCHAR2(50)	NOT NULL,	
    bk_trans	NVARCHAR2(20)		,
    bk_date	NVARCHAR2(10)		,
    bk_pages	NUMBER		,
    bk_price	NUMBER		


);

--ALRTER TABLE: TABLE 을 변경하는 명령
-- 만들어진 table의 이름을 변경하기
ALTER TABLE tbl_books RENAME TO tbl_books_v2;


--이미 데이터가 담긴 테이블을 복제하기
--테이블 구조와 데이터를 복제하여 백업을 하는 용도
-- 일부 제약조건이 함께 복제되지않는다

CREATE TABLE tbl_books as select * from tbl_books_v1;

--오라클에서는 TABLE을 복제한후 오라클에서는
--반드시 PK를 다시설정해주어야한다

--테이블을 생성하고 존재하는 상태에서
--PK를 변경 추가하는 경우에는
-- PK로 설정하려는 컬럼의 데이터가
--PK조건(유일성, NOTNULL)을 만족하지않는 상황이라면 명령이 실패한다
--대량의 데이터가 저장된 TABLE을 ARTER(변경)할 경우에는
--매우 신중하게 실행을 해야한다.
--또한 미리 데이터 검증을 통하여 제약조건에 위배되고있는지 확인을 해야한다 
ALTER TABLE tbl_books --tbl_books 테이블을 변경하겠다
ADD CONSTRAINT PK_ISBN --제약조건을 추가하는데 이름을 PK_isbn이라고하는데
PRIMARY KEY(bk_isbn); --BK_ISBN 칼럼을  PK로 설정하겠다


--생성된 PK를 제거하기
ALTER TABLE tbl_books DROP PRIMARY KEY CASCADE;



/*
도서 정보를 저장하기 위하여 TBL_BOOK 테이블을 생성하고
도서정보를 IMORT했다.
도서 정보는 어플로 만들기 전에 사용하던 데이터인관계로 데이터 베이스의 규칙에 다소 어긋난 데이터가 있다.

저자 항목(칼럼)을 보면 두명인 이상인 데이터가 있고 또한 역자도 두명 이상인 경우가 있다.

데이터를 저장할 컬럼을 크게 설정 하여 입력(IMPOT)하는데는 문제가 없는데
저자나 역자를 기준으로 데이터를 여러가지 조건을 부여하여 조회를 하려고하면 문제가 발생할수 있다
특히, 저자이름으로 GROUPPING을 하여 데이터를 조회해보려고 하면 상당히 어려움을 겪을수 있다.

*/


DESC tbl_books;

ALTER TABLE    tbl_books --테이블을 변경하라
RENAME COLUMN bk_author TO bk_author1; --특정 칼럼의 이름을 변경한다 bk_author -> bk_author1

DESC  tbl_books;

ALTER TABLE tbl_books --테이블을 변경한다
ADD bk_author2 nVARCHAR2(50); --- 한글가변문자열50개로 설정하는 author2컬럼을 추가하라 not null이있으면 오류가 발생한다

/*
데이터 베이스의 제 1 정규화
한컬럼에 저장되는 데이터는 원자성을 가져야한다.
한칼럼에 2개이상의 데이터가 구분자(,)로 나뉘어 저장되는 것을 막는 조치
이미 2개이상의 데이터가 저장된 경우 분리하여 원자성을 갖도록하는것이다.
*/

/*
도서 정보 데이터의 제 1정규화를 수행하고보니
저자 데이터를 저장할 ㅏㅋㄹ럼이 이후에 또 변경해야하는 상황이
발생할수 있는 이슈가 발견되었다ㅣ.

제 2 정규화를 통하여 테이블 설계를 다시해야하겠다 

1. 정규화를 수행할 컬럼은 무엇인가 파악(인식한다)
    저자 데이터를 저장할 컬럼
    족수의 데이터가 필요한 경우 
2.도서 정보와 관련된 저자 데이터를 저장할 TABLE을 새로생성한다
    tbl_author 테이블을 생성할예정
    
    도서의 ISBM과 저자 리스트를 포함하는 형태의 데이터를 만든다
    ----------------------
    ISBN     저자
    ----------------------
    1       홍길동
    2       이몽룡
    3       성춘향
    4       임꺽정
    5       장녹수
    ----------------------
    
    
    --도서의 저자 리스트를 저장할 TABLE생성
    */
    
    
    create table tbl_books_author (
    ba_seq	number		primary key,
    ba_isbn	char(13)	not null	,
    ba_author	NVARCHAR2(50)	not null	
);


--    tbl_books의 데이터를 삭제하고 제1정규화가 완료된 데이터를 다시 INport



delete from tbl_books;
commit;
select * from tbl_books;


--제 1정규화가 완료된 도서정보로 부터 저자리스트를 생성
--도서정보 테이블에서 저자이름들 목록 추출하기 
select '(' || bk_isbn, bk_author1 from tbl_books
group by '(' || bk_isbn, bk_author1

union all

select '(' || bk_isbn, bk_author2 from tbl_books
where bk_author2 is not null
group by '(' ||bk_isbn, bk_author2;

--도서 정보와 저자리스트를 join하여 데이터 조회
--저자가 1명인 경우는 한개의 도서만 출력이 되고
-- 저자가 2명 이상인 경우는 같은 isbn, 같은 도서명,
 -- 다른 저자 형식으로 저자수 만큼 데이터가 출력된다 .
select bk_isbn, bk_title, ba_author
from tbl_books
 left join tbl_books_author
    on bk_isbn = ba_isbn;

--제 2 정규화가 완료된 상태에서
--도서정보를 입력하면서 저자정보를 출력하면
--저자정보에는 iosbn저자명을 포함한 데이터를 추가해 주면된다
select ba_author, bk_isbn, bk_title
from tbl_books
 left join tbl_books_author
    on bk_isbn = ba_isbn
order by ba_author;

--정보처리기사
--제1정규화 : 원자성
--제2정규화 : 완전함수 종속성
--제3정규화 : 이행적함수 종속성

--tbl_book_author에 데이터를 추가하려고할때
-- isbn 이 도서에 저자를 추가하고싶을때