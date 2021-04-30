--bookuser접속

--booksTable과 author, company table은 Relation관계가 있다
--books의 bk_code와 company의 cp_code 
--books의 bk_code와 company의 au_code

--연관관계에있는 Table을 EQJOIN을 실행할때
--만약 author, company table 에 없는 데이터(코드)가
--book에 있다면 EQ JOIN을 하면 데이터가 누락되어버린다.
-- 또한 Left join 을 하면 값이 (NULL)로 출력된다..
-- Join된데이터가 누락되거나 null이 출력되는것은 
--데이터가 문제가 발생한것이다. 즉 참조무결성이 무너졌다.
select * FROM VIEW_도서정보;



select * from tbl_books,tbl_author,tbl_company
where bk_ccode = cp_code and bk_acode = au_code;



--다수의 테이블이 연관 (Relation)관계에 있을때
--join 결과가 잘못되면 DB신뢰성에 매우 큰문제가 발생한다.
-- Relation 설정이 된 table간에 참조무결성을 보장하기위한
-- 제약 조건을 설정할수 잇다
--이 제약 조건을 "foreign key"(외래키)설정이라고 한다.
-- 이키는 테이블을 만들때 사용할수 있지만, 일반적으로 테이블을 만들고나서 사용한다
-- tbl_books와 tbl_company를 참조 무결성 설정
-- tbl_company의 PK를 참조하여 tbl_books데이터에 
--출판사 정보를 연동
-- tbl_company를 parent라고하며 reference table이라고 한다. ALTER talble을 이용해서 
--fk를 설정하는 대상은 child table인 tbl_books가 된다.
--FK를 설정할 Table\
--fk이름 설정
--.fk를 설정할 컬럼, child의 컬럼
--누구하고 parent table 컬럼

ALTER TABLE tbl_books 
ADD CONSTRAINT fk_company
FOREIGN KEY (bk_ccode)
REFERENCES tbl_company(cp_code);
--레퍼런스 의 프라이머리 컬럼하고에 부모 테이블의 연결할 기본키에 페어런츠키설정


ALTER TABLE tbl_books
ADD CONSTRAINT fk_author
FOREIGN KEY (bk_acode)
REFERENCES tbl_author(au_code);

DELETE FROM tbl_author
WHERE au_code = 'A0001;



INSERT INTO tbl_books(bk_isbn,bk_title,bk_acode,bk_code)
VALUES('970001','테스트','A0036',C001');

/*
============================================================
(기준)
TBL_BOOKS.BK_ACODE      TBL_AUTHOR.AU_CODE

-----------------------------------------------------------
 코드가 있으면      >>        반드시 있어야한다          
    있을수있다        <<      코드가 있으면 
    절대있을수 없다    <<     없으면
    코드가 있으면     >>      삭제불가능
    코드가 있으면     >>      코드값변경불가
    
    
 */
 
 --삭제를 하면 데이터는 NULL값을 바뀌어버린다
 ALTER TABLE tbl_books
 DROP CONSTRAINT fk_author;
 
 
 --데이터가 입력된 TABLE간에 FK를 설정하려고 할경우
 --먼저 모든 데이터가 참조무결성에 유한한지 검사하고 
 --데이터에 문제가 있을경우 문제를 해결한후 FK를 설정이 가능하다 
 
 INSERT INTO tbl_author(au_code, au_name)
 VALUES('A0036','삭제된 저자');
 
 
 --FK가 설정된 상태에서
 --PARENT테이블의 데이터가 잘못입력된 것이 발견되어
 -- 데이터를 삭제하고자 한다
 --하지만 이미사용된(BOOKS에 등록된) 데이터는 삭제가 불가능하다
 --그러한 제약 사항을 조금 약하게 하는 방법이 있다.
 -- PARENTS 데이터를 삭제하면 연관된 테이블의 모든데이터를 같이 
 -- 삭제하거나, 코드가 변경되면 연관된 데이터의 코드값을 변경하거나 
 
 
 ALTER TABLE tbl_books
ADD CONSTRAINT fk_author
FOREIGN KEY (bk_acode)
REFERENCES tbl_author(au_code)
ON DELETE CASCADE;