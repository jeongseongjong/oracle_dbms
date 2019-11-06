DROP TABLE tbl_student;
CREATE TABLE tbl_student (
    st_code	VARCHAR2(5)		PRIMARY KEY,
    st_name	nVARCHAR2(50)	NOT NULL,	
    st_tel	VARCHAR2(20),		
    st_addr	VARCHAR2(125),		
    st_grade	NUMBER,
    st_dcode VARCHAR2(5)
);
SELECT * FROM tbl_score;
SELECT sc_name
FROM tbl_score
GROUP BY sc_name;

 SELECT SC.sc_seq, SC.sc_name, SC.sc_subject, SC.sc_score, 
        SB.sb_code, SB.sb_pro, ST.st_code, ST.st_tel, ST.st_addr, ST.st_grade, ST.st_dcode
 FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.sc_name = ST.st_name
    LEFT JOIN tbl_subject SB
        ON SC.sc_subject = SB.sb_name
