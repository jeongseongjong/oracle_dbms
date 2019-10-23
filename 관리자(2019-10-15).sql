 -- 여기는 관리자 화면입니다.
 /*
    TABLESPACE생성
    이름 : grade_db
    데이터파일 : C:/bizwork/oracle/data/grade.dbf
    초기 사이즈 : 10MB
    자동증가 옵션 : 10KB
*/
-- SIZE를 쓸때 MB/KB 는 B 를 빼주어야 한다.(오류나옴)
 CREATE TABLESPACE grade_db
 DATAFILE 'C:/bizwork/oracle/data/grade.dbf'
 SIZE 10M AUTOEXTEND ON NEXT 10K;
 
 /*
    사용자 생성 : 스키마 생성(TABLE을 관리하는 주체)
    id : grade
    pw : grade
    권한 : DBA
    DEFAULT TABLESPACE : grade_DB
 */
  CREATE USER grade IDENTIFIED BY grade
  DEFAULT TABLESPACE grade_DB;
  GRANT DBA TO grade;
  SELECT * FROM ALL_USERS WHERE username = 'GRADE';
  
  -- 비밀번호 변경
  ALTER USER grade IDENTIFIED BY grade;