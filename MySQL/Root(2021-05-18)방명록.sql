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

