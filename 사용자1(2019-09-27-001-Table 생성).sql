 -- 여기는 USER1 사용자 화면입니다.
 -- DBA역할 중에서
 -- 데이터 저장소의 기초인 Table을 만드는 것
 
 -- 학생정보를 저장할 tbl_student Table 생성
 
 -- tbl_student 라는 이름으로 table(물리적 저장소)를 생성
 -- tbl_student : 생성할 table 이름
 -- 이름명명규칙 : Java에서 변수, 클래스, method 등의 이름을 명명하는것과 일치
 -- 단, 오라클에서는 대소문자를 구별하지 않는다.
 -- table 명명 패턴 : 
 --      일반적으로 테이블을 만들때 테이블 이름앞에서 접두사로 tbl_ 사용한다.
 CREATE TABLE tbl_student(
    -- 칼럼 : 필드(멤버)변수와 같은 개념
    -- 칼럼들은 컴마(,)로 구분하여 나열
    -- 칼럼들의 data type을 지정한다.
    -- data type에는 () 사용하여 최대저장할 크기를 byte 단위로 지정
    -- CHAR() : 고정길이 문자열 저장 칼럼
    --   저장할 데이터가 항상 일정한 길이를 갖고있음이 보장될 경우
    -- 최대 2000글자까지 지정
    -- 오라클에서 CHAR칼럼에 순수 숫자로만 되어있는 데이터를 저장할 경우
    -- 약간의 문제 발생
    -- A0001 형식으로 저장시 문자열로 인식
    -- 0001 형식으로 저장시 오라클DB에는 문자열로 저장
    --      java(또는 프로그래밍언어)를 통해서 DB 접속시 숫자로 인식하는 오류생성
    -- 그래서 오라클에서는 아주특별한 경우가 아니면 그냥 VARCHAR2()로 사용
    st_num CHAR(5),
    
    -- VARCHAR2() : 가변길이 문자열 저장칼럼
    -- 최대 4000글자까지 저장
    -- 최대글자까지 저장하는것은 CHAR와 유사하지만
    -- 만약 저정하는 데이터의 길이가 일정하지 않을경우
    -- 데이터 길이만큼 칼럼이 변환되어 파일에 저장이 된다.
    -- nVARCHAR2() : 유니코드, 다국어 지원 칼럼
    -- 만약 한글 데이터가 입력될 가능성이 있는 칼럼은 반드시 nVARCHAR2() 사용
    -- 한글이 입력될 가능성이 없는 기본칼럼은 VARCHAR2()이지만 nVARCHAR2()해도 무관 
    st_name nVARCHAR2(20),
    st_addr nVARCHAR2(125),
    
    st_tel VARCHAR2(20),
    
    -- 숫자를 저장할 칼럼
    -- 표준 SQL에서는 INT, FLOAT, LONG, DOUBLE 등등 Keyword가 있다.
    -- 오라클에서도 표준 SQL 숫자 type 사용가능
    -- 오라클 코드에서는 NUMBER 칼럼 사용
    -- st_grade INT, --INT Keyword 사용시 NUMBER(38)으로 변환되어 생성된다.(한글자 쳐도 38)
    st_grade NUMBER(1),
    st_dept nVARCHAR2(10),
    st_age NUMBER(3) -- 마지막 칼럼은 뒤에 컴마(,)가 붙지않는다.
    
    
    
    
 );
 
 INSERT INTO tbl_student(st_num, st_name, st_addr)
 VALUES('00001', '성춘향', '익산시');
 INSERT INTO tbl_student(st_num, st_name, st_addr)
 VALUES('00001', '성춘향', '남원시');
 
 SELECT * FROM tbl_student dual;
 
 
 DROP TABLE tbl_student;
 -- 시나리오
 -- tbl_student에 많은 학생의 데이터를 추가하다보니
 -- 학번이 0100인 학생의 데이터가 2번 추가가 되었다
 -- 이후에 tbl_student 테이블에서 0100의 학생데이터를 조회 했더니
 -- 데이터가 2개 조회되었다.
 -- 이런 상황이 되면 0100학생의 데이터 2개중에 어떤 데이터가
 -- 이 학생의 데이터인지 매우 알기가 어려워진다.
 -- 여러가지 데이터를 다시 검증해야만 어떤 데이터가 정상적(사용할 수 있는)인
 --         데이터인지 확인할 수 있다.
 
 -- 이런 문제를 발생하지 않도록 미리 무언가 조치를 취해 줘야 하는데
 -- DB에서는 이런 문제가 발생하지 않도록 설정을 할 수 있다.
 -- 이런 설정을 "제약조건" 설정이라고 한다.
 
 -- tbl_student table에는 절대 학번이 동일한 데이터가 2개이상 없어야한다.라는
 -- "제약조건"을 설정해야 한다.
 -- 이 설정을  "UNIQ 제약조건"이라고 한다.
 CREATE TABLE tbl_student(
 
    st_num CHAR(5) UNIQUE,
    st_name nVARCHAR2(20),
    st_addr nVARCHAR2(125),
    st_tel VARCHAR2(20),
    st_dept nVARCHAR2(20),
    st_grade NUMBER(1),
    st_age NUMBER(3)
 

 );
 
 -- 다시 생성된 tbl_student에
 -- 00001학생의 데이터를 추가
  INSERT INTO tbl_student(st_num, st_name, st_tel)
  VALUES('00001', '성춘향', '남원시');
 
 -- 많은양의 데이터를 입력하는 과정에서
 -- 실수로 학번 10001학생을 추가해야 하는데
 -- 학번을 00001로 하여 추가하는 코드를 작성하고 명령실행
 INSERT INTO tbl_student(st_num, st_name, st_tel)
 VALUES('00001', '이몽룡', '서울시');
 -- 그랬더니
 -- ORA-00001: unique constraint (USER1.SYS_C006997) violated
 -- 오라클이 보내는 메시지 중 "unique constraint"가 포함되면
 -- UNIQUE 설정된 칼럼에 이미 존재하는 값을 추가하려고
 -- 시도했다는 뜻이다.
 -- UNIQUE : 중복배제, 중복금지
 
 INSERT INTO tbl_student(st_num, st_tel)
 VALUES('20111', '010-111-1234');
 SELECT * FROM tbl_student;
 
 -- 학생 데이터를 추가하는 과정에서
 -- 학번은 위에서 중복금지 제약조건을 설정하여
 -- 중복된 값이 추가되지 못하도록 설정했다.
 
 -- 많은 양의 데이터를 추가하다보니
 -- 실수로 학생이름, 전화번호 등을 입력하지 않고  추가한 데이터들이 존재
 -- 나중에 tbl_student 테이블의 데이터를 사용하여 업무를 수행하려고 했더니
 -- 이름, 전화번호가 없어서 상당히 문제를 일으킨다.
 
 -- 이러한 일들을 방지하기 위해서
 -- 값이 없는 칼럼이
 -- 존재하면 안되는 데이터들이  추가되는 것을 방지
 -- 꼭 값이 있어야 하는 칼럼에 NOT NULL 제약조건을 설정
 
 -- NOT NULL 제약조건이 설정된 칼럼은
 -- 데이터를 추가할 때 반드시 값이 있어야 한다.
 
 DROP TABLE tbl_student;
 CREATE TABLE tbl_student(
 
    st_num CHAR(5) UNIQUE NOT NULL,
    st_name nVARCHAR2(20) NOT NULL,
    st_addr nVARCHAR2(125) ,
    st_tel VARCHAR2(20)NOT NULL,
    st_dept nVARCHAR2(20),
    st_grade NUMBER(1),
    st_age NUMBER(3)
    );
    
 -- 데이터를 추가하는 과정에서
 -- 학번, 전화번호만 데이터를 입력하고
 -- 이름은 없는 상태로 데이터를 추가하려고 명령실행
 INSERT INTO tbl_student(st_num, st_tel)
 VALUES('20111', '010-111-1234');
 
 -- 그랬더니 오라클이
 -- ORA-01400: cannot insert NULL into ("USER1"."TBL_STUDENT"."ST_NAME")
 -- USER1 사용자가 만든 tbl_student 테이블의 st_name 칼럼은
 -- 값이 없는 상태로는 INSERT 명령을 수행할 수 없다.
 
 -- 최소한 st_num, st_name, st_tel 칼럼은 값이 있는 상태로
 -- INSERT를 수행해야 명령이 정상으로 실행된다.
 INSERT INTO tbl_student(st_num, st_name, st_tel)
 VALUES('20111', '이몽룡', '010-111-1234');
 
 -- tbl_student 테이블은 학생정보를 보관하는 중요한 table이다.
 -- tbl_student에서 어떤 학생의 데이터를 조회하고자 할때는 
 -- 학생이름, 전화번호 등으로 조회를 할 수 있다.
 -- 하지만 학생이름이나 전화번호로 조회를 하면
 -- 조회(추출)되는 데이터가 2개이상 보일 수도 있다.
 -- 2개 이상의 데이터가 보이면 어떤 데이터가 내가 필요한 데이터인지
 -- 다른 항목을 통해서 살펴봐야 하는 불편함이 있다.
 -- 이대 어떤 칼럼의 값을 조회했을때
 -- 유일하게 1개의 데이터만 추출되도록 설정을 할 수 있는데
 -- 이런 설정을 한 칼럼을 기본키(Primary Key)라고 한다.
 
 -- tbl_student 테이블에 저장된 수많은 데이터 중에서
 -- st_num 값으로 조회를 실행하면
 -- 추출되는 데이터는 1개만 나타날 것이다.
 -- 이유는 현재 st_num 칼럼이 UNIQUE로 설정되어 있기 때문에
 -- 또한
 -- st_num 값을 조회를 했을때
 -- 추출되는 데이터는 없거나 유일하게 1개만 나타난다.
 
 -- 이러한 조건을 만족하기 위해서
 -- st_num 칼럼은 UNIQUE와 NOT NULL 제약조건을 설정해 둔다.
 
 -- st_num칼럼은 PrimaryKey(PK)라는 조건을 설정한다.
 -- PRIMARY KEY로 설정한 칼럼은
 -- UNIQUE와 NOT NULL 조건을 만족하며
 -- 더불어 key로서 조회를 할때 매우 빨리 값을
 -- 조회할 수 있도록 DBMS가 별도 관리를 한다.
 -- PRIMARY KEY로 설정한 칼럼은
 -- UNIQUE와 NOT NULL 설정을 생략한다.
 
 DROP TABLE tbl_student;
 CREATE TABLE tbl_student(
 
    st_num CHAR(5) PRIMARY KEY, -- UNIQUE NOT NULL,
    st_name nVARCHAR2(20) NOT NULL,
    st_addr nVARCHAR2(125) ,
    st_tel VARCHAR2(20)NOT NULL,
    st_dept nVARCHAR2(20),
    st_grade NUMBER(1),
    st_age NUMBER(3)
    );
 
 -- st_num는 PK로 설정되어있기 때문에
 -- st_num의 값으로 조회를 하면 없거나 1개의 데이터만 보여준다.
 
 
 
 -- table의 구조를 확인하는 명령문
 DESCRIBE tbl_student ;
 DESC tbl_student;
 
 -- user1 사용자가 생성한 테이블을 보여라
 SELECT * FROM dba_tables 
 WHERE OWNER = 'USER1'; 
 
 
 -- tbl_student에 데이터 추가하기
 -- INSERT INTO [table] ([colums], [colums], ...)
 -- VALUES([value], [value], ...)
 INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept)
 VALUES('00001', 'AAA', '010-111-1234', '서울시', 33, '컴공과');
 
  INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept)
 VALUES('00002', 'BBB', '010-111-1234', '남원시', 34, '컴공과');
 
  INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept)
 VALUES('00003', 'CCC', '010-111-1234', '익산시', 35, '컴공과');
 
  INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept)
 VALUES('00004', 'DDD', '010-111-1234', '목포시', 36, '컴공과');
 
  INSERT INTO tbl_student(st_num, st_name, st_tel, st_addr, st_age, st_dept)
 VALUES('00005', 'EEE', '010-111-1234', '광주시', 37, '컴공과');
 
 SELECT * FROM tbl_student dual;
 
 
