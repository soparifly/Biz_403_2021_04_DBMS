-- GBUSER
SHOW databases;

Create database GuestBook;
USE guestBook;


CREATE TABLE tbl_guest_book (
	gb_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	gb_date	VARCHAR(10)	NOT NULL	,
	gb_time	VARCHAR(10)	NOT NULL	,
	gb_writer	VARCHAR(30)	NOT NULL,	
	gb_email	VARCHAR(30)	NOT NULL,	
	gb_password	VARCHAR(125)	NOT NULL,	
	gb_content	VARCHAR(2000)	NOT NULL	
);
DROP TABLE tbl_guest_book;

-- seq 빼고 넣음
insert into tbl_guest_book(gb_date,gb_time,gb_writer,gb_email,gb_password,gb_content)
values('2021-05-18','10:20:00','callor','callor@callor.com','12345','오늘은 화요일, 내일은 쉬는날');

select * FROM tbl_guest_book;


select * FROM tbl_guest_book
WHERE gb_date = '2021-05-18';



select * FROM tbl_guest_book
ORDER BY gb_seq DESC;
-- 날짜와 시간기중르ㅗ 최근글이 제일 위
select * FROM tbl_guest_book
ORDER BY gb_seq DESC, gb_time DESC;

-- seq 3의 데이터가 명령문과같이 변경됨
UPDATE tbl_guest_book
SET gb_time ='10:36:00'
WHERE gb_seq = 3;


-- where 절을 넣지않으면 모두삭제됨으로 항상 주의한다 !!
DELETE FROM tbl_guest_book
WHERE gb_seq = 1;

select * FROM tbl_guest_book;
-- Mysql은 자동커밋이 되기때문에 롤백을 하여도 복구안됨
rollback;

-- SELECT 연산만으로 4칙연산을 수행할수있음.
SELECT 30* 40;

-- CONCAT은 MYSQL 고유함수로 문자열을 연결할때 사용한다
SELECT CONCAT('대한','민국','만세');

-- 문자열 사이에 오늘이 들어가있는 content를 찾음
SELECT * FROM tbl_guest_book
WHERE gb_content LIKE CONCAT('%','오늘','%');
-- 오라클의 디코드와 유사한 형태의 조건연산
-- gb_seq의 짝이 짝수이면 짝수로 표시
-- 아니면 홀수로 표시 
SELECT if( MOD(gb_seq, 2) = 0,'짝수','홀수')
FROM tbl_guest_book;

SELECT floor(RAND() *10) ;


SELECT COUNT(*) FROM tbl_guest_book;
SELECT * FROM tbl_guest_book;


SELECT * FROM tbl_guest_book
WHERE gb_writer = '경시현';


SELECT * FROM tbl_guest_book
order by gb_date desc , gb_time desc ;

SELECT * FROM tbl_guest_book
where gb_content Like '%국가%'
order by gb_date desc, gb_time desc;

CREATe VIEW view_방명록 as (
SELECT 
gb_seq '일련번호',
gb_date '등록일자',
gb_time '등록시간',
gb_writer '등록자이름',
gb_email '등록이메일',view_방명록view_방명록
gb_password '비밀번호',
gb_content '내용'
from tbl_guest_book
);
