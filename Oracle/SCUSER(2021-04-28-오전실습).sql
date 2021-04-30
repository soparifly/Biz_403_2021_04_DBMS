--SCUSER 


CREATE TABLE tbl_BOOKS (
    tb_isbn	CHAR(13)		PRIMARY KEY,
    tb_company	nVARCHAR2(50)	NOT NULL,	
    tb_name	nVARCHAR2(125)	NOT NULL,	
    tb_writer	NVARCHAR2(50)	NOT NULL,	
    tb_translator	NVARCHAR2(20),		
    tb_makedata	VARCHAR(10)	NOT NULL,	
    tb_page	NUMBER	NOT NULL,	
    tb_price	NUMBER	NOT NULL	

);


INSERT INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price) 
VALUES('9791162540770','비즈니스북스','데스 바이 아마존','시로타 마코토','신희원',2019-04-15,272,15000);

INSERT ALL
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price)VALUES('9791188850549','북라이프','4주 만에 완성하는 레깅스핏 스트레칭','모리 다쿠로','김현정',2019-04-11,132,13000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_makedata,tb_page,tb_price)VALUES('9791188850518','북라이프','왕이 된 남자2','김선덕',2019-04-10,388,14000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_makedata,tb_page,tb_price)VALUES('9791188850501','북라이프','왕이 된 남자1','김선덕',2019-04-10,440,14000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_makedata,tb_page,tb_price)VALUES('979116250756','비즈니스북스','새벽에읽는 유대인 인생특강','장대은',2019-04-10,280,15000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_makedata,tb_page,tb_price)VALUES('9791188850471','북라이프','왕이 된 남자 포토에세이','스튜디오 드래곤',2019-04-10,368,25000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price) VALUES('9791162540732','비즈니스북스','4주 만에 완성하는 레깅스핏 스트레칭','모리 다쿠로','김현정',2019-04-11,132,13000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price) VALUES('9791162540718','비즈니스북스','4주 만에 완성하는 레깅스핏 스트레칭','모리 다쿠로','김현정',2019-04-11,132,13000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price) VALUES('9791162540695','비즈니스북스','4주 만에 완성하는 레깅스핏 스트레칭','모리 다쿠로','김현정',2019-04-11,132,13000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price) VALUES('9791162540671','비즈니스북스','4주 만에 완성하는 레깅스핏 스트레칭','모리 다쿠로','김현정',2019-04-11,132,13000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price) VALUES('9791188850440','북라이프','4주 만에 완성하는 레깅스핏 스트레칭','모리 다쿠로','김현정',2019-04-11,132,13000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price) VALUES('9791188850426','북라이프','4주 만에 완성하는 레깅스핏 스트레칭','모리 다쿠로','김현정',2019-04-11,132,13000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price) VALUES('9791162540440','비즈니스북스','4주 만에 완성하는 레깅스핏 스트레칭','모리 다쿠로','김현정',2019-04-11,132,13000)
INTO tbl_BOOKS(tb_isbn,tb_company,tb_name,tb_writer,tb_translator,tb_makedata,tb_page,tb_price) VALUES('9791186805398','비즈니스북스','4주 만에 완성하는 레깅스핏 스트레칭','모리 다쿠로','김현정',2019-04-11,132,13000)
