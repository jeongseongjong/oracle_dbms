CREATE TABLE tbl_books(
B_CODE	VARCHAR2(6)	NOT NULL	PRIMARY KEY,
B_NAME	nVARCHAR2(125)	NOT NULL,	
B_AUTHER	nVARCHAR2(125)	NOT NULL,	
B_COMP	nVARCHAR2(125),		
B_YEAR	NUMBER	NOT NULL,	
B_IPRICE	NUMBER,		
B_RPRICE	NUMBER	NOT NULL
);
SELECT * FROM tbl_books;
SELECT * FROM tbl_users;


CREATE TABLE tbl_users(
U_CODE	VARCHAR2(6)	NOT NULL	PRIMARY KEY,
U_NAME	nVARCHAR2(125)	NOT NULL,
U_TEL	nVARCHAR2(125),	
U_ADDR	nVARCHAR2(125)		
);
DROP TABLE tbl_rent_book;
CREATE TABLE tbl_rent_book(
RENT_SEQ	NUMBER	NOT NULL	PRIMARY KEY,
RENT_DATE	VARCHAR2(10)	NOT NULL,	
RENT_RETURN_DATE	VARCHAR2(10)	NOT NULL,	
RENT_BCODE	VARCHAR2(6)	NOT NULL,	
RENT_UCODE	VARCHAR2(6)	NOT NULL,	
RENT_RETURN_YN	VARCHAR2(1),		
RENT_POINT	NUMBER		
);


ALTER TABLE tbl_rent_book -- 연동되는 테이블
 ADD CONSTRAINT FK_BOOKS
 FOREIGN KEY (rent_bcode) -- 연동되는 칼럼
 REFERENCES tbl_books(b_code);
 
 ALTER TABLE tbl_rent_book -- 연동되는 테이블
 ADD CONSTRAINT FK_USERS
 FOREIGN KEY (rent_ucode) -- 연동되는 칼럼
 REFERENCES tbl_users(u_code);
 
SELECT MAX(rent_seq) FROM tbl_rent_book;
CREATE SEQUENCE SEQ_IOLIST
START WITH 600 INCREMENT BY 1;

SELECT * FROM tbl_iolist;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 