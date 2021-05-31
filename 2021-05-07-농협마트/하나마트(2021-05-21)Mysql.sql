-- 여기서 부터 gbUser

use nhDB;
drop table tbl_iolist;
drop table tbl_product;
drop table tbl_dept;
create table tbl_iolist (
io_seq	INT		PRIMARY KEY,
io_date	VARCHAR(10)	NOT NULL	,
io_time	VARCHAR(10)	NOT NULL	,
io_pname	VARCHAR(50)	NOT NULL	,
io_dname	VARCHAR(50)	NOT NULL	,
io_dceo	VARCHAR(20)	NOT NULL	,
io_inout	VARCHAR(1)	NOT NULL	,
io_qty	INT	NOT NULL	,
io_price	INT	NOT NULL	
);

select * from nhDB;

create table tbl_product (
p_code	INT		PRIMARY KEY,
p_name	VARCHAR(50)	NOT NULL,	
p_iprice	INT	NOT NULL	,
p_oprice	INT	NOT NULL	,
p_vat	VARCHAR(1)	DEFAULT 'Y'	

);

create table tbl_dept (
d_code	INT(6)		PRIMARY KEY,
d_name	VARCHAR(50)	NOT NULL	,
d_ceo	VARCHAR(20)	NOT NULL	,
d_tel	VARCHAR(20)		,
d_addr	VARCHAR(125)	,	
d_product	VARCHAR(20)		
);
