-- 정보처리기사 프로젝트

 DROP TABLE tbl_cbt;
 DROP TABLE tbl_body;

 CREATE TABLE tbl_cbt (
    cb_seq	VARCHAR2(5)		NOT NULL PRIMARY KEY,
    cb_plo	nVARCHAR2(125) NOT NULL
   	
);
 CREATE TABLE tbl_body (
    bo_seq	    VARCHAR2(5)		    NOT NULL,
    bo_ex1	    nVARCHAR2(64)		NOT NULL,	
    bo_ex2	    nVARCHAR2(64)		NOT NULL,	
    bo_ex3	    nVARCHAR2(64)		NOT NULL,	
    bo_ex4	    nVARCHAR2(64)		NOT NULL,	
    bo_answer	NUMBER(5),			
    bo_Oplo	    nVARCHAR2(125),			
    bo_Xplo	    nVARCHAR2(125),			
    bo_Ocount	NUMBER(5),			
    bo_Xcount	NUMBER(5)			
);


 SELECT * FROM tbl_cbt;

 CREATE SEQUENCE seq_cbt
 START WITH 1 INCREMENT BY 1;
 
 CREATE SEQUENCE seq_body
 START WITH 1 INCREMENT BY 1;
 
 ALTER TABLE tbl_body
 ADD CONSTRAINT FK_CBT
 FOREIGN KEY (bo_seq)
 REFERENCES tbl_cbt(cb_seq);
 
 SELECT cb_seq, cb_plo, bo_ex1, bo_ex2, bo_ex3, bo_ex4, bo_answer
 FROM tbl_cbt, tbl_body
 WHERE cb_seq = bo_seq;
 
 commit;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 