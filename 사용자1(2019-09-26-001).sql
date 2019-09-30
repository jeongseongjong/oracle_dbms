 -- 여기는 USER1 화면입니다.
 -- TABLE 생성 연습
 
 CREATE TABLE tbl_addr (
 
    -- 이름, 주소, 전화번호, 나이, 관계
    name     VARCHAR2(10), -- String
    addr     VARCHAR2(125), -- String
    tel      VARCHAR2(20), -- String
    age      int, -- int
    chain    VARCHAR2(20) -- String 
 
 
 );
 
 -- 한개의 데이터를 tbl_addr table에 추가
 SELECT * FROM tbl_addr;
 INSERT INTO tbl_addr(name,addr,tel,age,chain)
 VALUES('홍길동', '서울시', '010-111-1111', 33, '친구');
 
 -- 현재 tbl_addr table에 저장된 데이터 전체를 출력
 SELECT * FROM tbl_addr ;
 
 -- tbl_addr table의 addr 칼럼에 저장된 값을
 -- 광주광역시로 변경하라
 UPDATE tbl_addr
 SET addr = '광주광역시';
 
 SELECT * FROM tbl_addr;
 
 
 DELETE FROM tbl_addr;
 SELECT * FROM tbl_addr;
 
 
 
 