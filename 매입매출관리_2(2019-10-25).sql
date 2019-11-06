 CREATE TABLE tbl_score (
    sc_seq	NUMBER		PRIMARY KEY,
    sc_name	nVARCHAR2(50)	NOT NULL,	
    sc_subject	nVARCHAR2(5)	NOT NULL,	
    sc_score	NUMBER	NOT NULL,	
    sc_sbcode	VARCHAR2(5),		
    sc_stcode	VARCHAR2(5)		
 );
 
 SELECT * FROM tbl_score;
 
 CREATE TABLE tbl_subject (
    sb_code	VARCHAR2(5)		PRIMARY KEY,
    sb_name	nVARCHAR2(50)	NOT NULL,	
    sb_pro	nVARCHAR2(50)		
 );
 SELECT * FROM tbl_subject;
 
 SELECT COUNT(*)
 FROM tbl_score, tbl_subject
 WHERE sc_subject = sb_name;
 
 SELECT SC.sc_seq, SC.sc_name, SC.sc_subject, SC.sc_score, SB.sb_code, SB.sb_name, SB.sb_pro
 FROM tbl_score SC
    LEFT JOIN tbl_subject SB
        ON SC.sc_subject = SB.sb_name;
 
 