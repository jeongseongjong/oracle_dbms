 -- 관리자 화면
 -- id: user5, password : user5
 -- tablespace : user5_db, datafile:user5.dbf
 -- size 10M, autoextend newt 1k
 
 CREATE TABLESPACE user5_db
 DATAFILE '/bizwork/oracle/data/user5.dbf'
 SIZE 10M AUTOEXTEND ON NEXT 1K;
 
 -- 사용자를 생성하고 기본 tablespace를 user5에 저장하라
 /*
 오라클 DBMS에서의 user의 개념
 타 DBMS(mysql, mssql)등에서는 기본적인 Schema를 DATABASE라는 이름으로
 생성하여 관리를 한다.
 오라클에서는 기본 Schema가 user와 밀접한 관련이 있다.
 USER = DataBase 기본 Schema의 관점으로 생각을 해야한다.
 
 USER란
 DBMS OBject들을 관리하는 주체
 TABLE, VIEW, SEQUENCE, INDEX ... 
 
 만약 USER5로 접속하여 USER4가 가지고 있는 어떤 TABLE을 SELECT하고 싶다.
 >> SELECT * FROM USER4.TBL_TABLE
 
 
 */
 CREATE USER user5 IDENTIFIED BY user5
 DEFAULT TABLESPACE user5_db;
 
 GRANT DBA TO user5;
 