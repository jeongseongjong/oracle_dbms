-- 여기는 관리자 화면입니다.
-- 매입매출 관리를 수행할 TABLESPACE, USER를 생성

/*
 TABLESPACE 생성
 이름 : iolist_DB
 파일 : /bizwork/oracle/data/iolist.bdf
 초기크기 : 50M
 자동확장 : AUTO 10K
 */
 CREATE TABLESPACE iolist_DB
 DATAFILE '/bizwork/oracle/data/iolist.bdf'
 SIZE 50M AUTOEXTEND ON NEXT 10K;
 
 /*
 사용자 생성
 ID : iolist
 PW : iolist
 권한 : DBA
 DEFAULT TABLESPACE : iolist_DB
 */
 CREATE USER iolist IDENTIFIED BY iolist
 DEFAULT TABLESPACE iolist_DB;
 
 GRANT DBA TO iolist;
 
 
 
 
 
 
 
 
 
 
 