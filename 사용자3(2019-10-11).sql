 -- 여기는 user3 화면입니다.
 -- 현재 uiser3 사용자가 사용할 수 있는 Table 목록
 SELECT * FROM TAB;
 
 -- TABLE 과 View의 차이
 /*
 --------------------------------
 TABLE                        VIEW
 --------------------------------
 실제 저장된 데이터          가상의 데이터
                             테이블로부터 SELECT 실행한 후 보여주는 형태
 CRUD 모두 가능              READ 조회(SELECT)만 가능한 형태
 원본데이터                  TABLE로 부터 새로 생성된 보기전용 데이터
 -------------------------------
 */
 
 -- 단순한 성격테이블 조회
 SELECT * FROM tbl_score;
 
 -- JOIN 이란
 -- 단순 성적테이블 조회로는 구체적으로 학생의 이름이라던가 다른 정보를
 -- 찾기가 매우 어렵다.
 -- 학번과 연계된 학생테이블로부터 학생이름을 연결하고
 -- 학과와 연계된 학과테이블로부터 학과이름을 연결하여
 -- 마치 한개의 데이터 Sheet(엑셀표현)처럼 보기 위한 SQL
 
 -- 학생테이블
 DESC tbl_student;
 
 -- 현재 학생테이블에 학과 코드 칼럼이 잇음에도
 -- SQL의 편의성을 고려하여
 -- 성적테이블에 학과 코드를 추가하여 관리를 했다. : tbl_score2
 -- 이런상황이 되면 자칫 잘못하여 TBL_score2 테이블에 등록된
 -- 학과 코드가 실제 학생의 학과 코드가 아닌 값이 등록될 수 있다.
 -- 이런경우 데이터를 조회했을때 실제 데이터와 차이가 있는 오류가 날 수 있다.
 
 -- tbl_score 테이블과 tbl_student 를 JOIN하고 
 -- 그 결과에서 학과코드를 기준으로 다시 tbl_dept와 JOIN을 수행하는 SQL
 
 -- tbl_score와 tbl_student JOIN
 SELECT * 
 FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.s_num = ST.st_num;
        
 SELECT  * FROM tbl_dept;
 
 -- 학생데이터 전체 삭제(매우주의)
 DELETE FROM tbl_student;
 
 SELECT * FROM tbl_student;
 
 -- 학생테이블과 학과테이블 JOIN
 -- 보고자하는 칼럼만 리스트로 나열하고
 -- 결과를 학번순으로 정렬하여 보기
 SELECT ST.st_num, ST.st_name, ST.st_dept,
        DP.d_name, DP.d_pro
 FROM tbl_student ST
    LEFT JOIN tbl_dept DP
        ON ST.st_dept = DP.d_num
 ORDER BY ST.st_num;

 -- 위의 SQL을 View로 생성
 -- 1. ORDER BY절 삭제(있으면 view 생성이 안됨)
 -- 2. 각 칼럼에 별도의 Alias 설정하기
 -- 3. SQL문 () 감싸기
 -- 4. CREATE VIEW AS 키워드 추가
 
 CREATE VIEW view_st_dept
 AS
 (
     SELECT ST.st_num 학번,
            ST.st_name 이름, 
            ST.st_dept 학과코드,
            DP.d_name 학과이름,
            DP.d_pro 담임교수
     FROM tbl_student ST
        LEFT JOIN tbl_dept DP
            ON ST.st_dept = DP.d_num
 );
 
 SELECT * FROM view_st_dept;
 
 SELECT * FROM view_st_dept
 WHERE 학과이름 = '컴퓨터공학';
 
 SELECT * FROM view_st_dept
 WHERE 학과이름 LIKE '컴퓨터%'
 ORDER BY 학번;
 
 -- view_st_dept를 사용해서
 -- 학과별로 학생수(COUNT)를 확인
 SELECT 학과코드, 학과이름, COUNT(학과코드)
 FROM view_st_dept
 GROUP BY 학과코드,학과이름
 ORDER BY 학과이름;
 
 -- 학생수를 기준으로 오름차순 정렬
 -- 집계함수(SUM, COUNT, MAX, MIN, AVG)를 사용할 때
 -- 만약 집계함수로 감싸지 않은 칼럼을 Procetion에 표시하려고 하면
 -- 그 칼럼들은 반드시 GROUP BY 절에 칼럼들을 나열해 주어야 한다.
 SELECT 학과코드, 학과이름, COUNT(*)
 FROM view_st_dept
 GROUP BY 학과코드, 학과이름
 ORDER BY COUNT(학과코드);
 -- 1. 전체 데이터에서 학과코드별로 묶어서, 학과코드가 무엇인지 List
 -- 2. List내에 포함된 학생수를 계산하여 보기
 -- >> 학과코드별 부분 합(개수)을 계산하기
 
 
 -- 이 SQL에서는 학번은 현재 view에서 절대 중복된 값이 없으므로
 -- GROUP BY가 아무런 효과를 발휘하지 못한다.
 SELECT 학번, 학생이름, COUNT(*)
 FROM view_st_dept
 GROUP BY 학번, 학생이름;
 
 -- 학과별로 학생수를 계산하고
 -- 학생수가 20명 이상인 과만 보고싶다.
 -- 집계를 계산 후 결과에 대한 조건 설정
 SELECT 학과코드, 학과이름, COUNT(*)
 FROM view_st_dept
 GROUP BY 학과코드, 학과이름
 HAVING COUNT(*) >= 20;
 
 
 -- 학과별로 학생수를 계산하고
 -- 컴퓨터공학 학과만 보여라
 SELECT 학과코드, 학과이름, COUNT(*)
 FROM view_st_dept
 GROUP BY 학과코드, 학과이름
 HAVING 학과이름 = '컴퓨터공학';
 
 -- HAVING 절은 GROUP BY가 이루어지고, 집계함수가 계산된 후
 -- 조건을 설정하여 리스트를 추출하는 부분이다.
 -- 이 경우 원본데이터를 먼저 GROUP하는 연산이 수행되고
 -- 그 결과에 대하여 조건을 설정
 -- 만약 어떤 기존의 칼럼을 기준으로 조건을 설정하려면
 -- HAVING절이 아닌 WHERE절에서 조건을 설정하여
 -- 추추로디는 LIST개수를 줄이고 
 -- 추출된 LIST만 가지고 GROUP, 집계함수 연산을 수행하는 것이
 -- SQL 수행효율면에서 매우 유리하다.
 SELECT 학과코드, 학과이름, COUNT(*)
 FROM view_st_dept -- 1.실행
 WHERE 학과이름 = '컴퓨터공학' -- 2. 실행
 GROUP BY 학과코드, 학과이름; -- 3.실행
 -- >> WHERE에 의해 제한 LIST만 가지고 GROUP 실행
 
 -- 성적테이블과 학생테이블 JOIN
 SELECT *
 FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.s_num = ST.st_num;
        
 CREATE VIEW view_sc_St
 AS
 (
     SELECT SC.s_num AS 학번,
            ST.st_name AS 이름,
            ST.st_dept AS 학과코드, 
            SC.s_kor AS 국어, 
            SC.s_eng AS 영어, 
            SC.s_math AS 수학
     FROM tbl_score SC
        LEFT JOIN tbl_student ST
            ON SC.s_num = ST.st_num
 );
 
 SELECT * FROM view_sc_st;
 
 -- 생성된 2개의 view JOIN
 SELECT * 
 FROM view_sc_st SC -- main table
    LEFT JOIN view_st_dept DP -- sub table
        ON SC.학과코드 = DP.학과코드 ;
        
 SELECT SC.학번, SC.이름, SC.학과코드, DP.학과이름,
        SC.국어, SC.영어, SC.수학
 FROM view_sc_st SC -- main table
    LEFT JOIN view_st_dept DP -- sub table
        ON SC.학과코드 = DP.학과코드 
 ORDER BY SC.학번;
 
 -- 2개의 view JOIN을 했더니 결과가 이상하게 생성되었다.
 SELECT *
 FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.s_num = ST.st_num
    LEFT JOIN tbl_dept DP
        ON ST.st_dept = DP.d_num;
 
 DROP VIEW tbl_성적일람표;
 DROP VIEW view_성적일람표;
 CREATE VIEW view_성적일람표
 AS
 (
 SELECT SC.s_num AS 학번, 
        ST.st_name AS 학생이름,
        ST.st_dept AS 학과코드,
        DP.d_name AS 학과이름,
        DP.d_pro AS 담임교수,
        SC.s_kor AS 국어,
        SC.s_eng AS 영어,
        SC.s_math AS 수학,
        SC.s_kor + SC.s_eng + SC.s_math AS 총점,
        ROUND((SC.s_kor + SC.s_eng + SC.s_math) / 3,0) AS 평균,
        RANK() OVER ( ORDER BY (SC.s_kor + SC.s_eng + SC.s_math) DESC ) AS 석차
 FROM tbl_score SC
    LEFT JOIN tbl_student ST
        ON SC.s_num = ST.st_num
    LEFT JOIN tbl_dept DP
        ON ST.st_dept = DP.d_num
 );
 SELECT * FROM VIEW_성적일람표;
 
 -- 전체 학생의 과목별 총점
 SELECT SUM(국어), SUM(영어), SUM(수학)
 FROM view_성적일람표;
 
 -- 학과별로 과목별 총점
 SELECT 학과코드, 학과이름, SUM(국어), SUM(영어), SUM(수학)
 FROM view_성적일람표
 GROUP BY 학과코드, 학과이름;
 
 SELECT 학과코드, 학과이름, 
        SUM(국어) AS 국어총점, 
        SUM(영어) AS 영어총점, 
        SUM(수학) AS 수학총점, 
        SUM(총점) AS 전체총점,
        ROUND(AVG(평균),1) AS 전체평균
 FROM view_성적일람표
 GROUP BY 학과코드, 학과이름;
 
 -- 군사학, 영어 학생들의 성적일람표 집계 계산
 SELECT 학과코드, 학과이름, 
        SUM(국어) AS 국어총점, 
        SUM(영어) AS 영어총점, 
        SUM(수학) AS 수학총점, 
        SUM(총점) AS 전체총점,
        ROUND(AVG(평균),1) AS 전체평균
 FROM view_성적일람표
 WHERE 학과이름 IN('영어','군사')
 GROUP BY 학과코드, 학과이름;
 
 -- WHERE, HAVING 으로 어떤 조건을 부여할때는
 -- 길이가 가변적인 값으로 조회하기 보다는
 -- 고정된 길이의 값으로 조회하는 것이
 -- 결과를 더 확실하게 찾을 수 있다.
 -- 학과이름으로 조건을 부여한느 것 보다는
 -- 학과코드로 조건을 부여하는것이 좋다.
 
 SELECT 학과코드, 학과이름, 
        SUM(국어) AS 국어총점, 
        SUM(영어) AS 영어총점, 
        SUM(수학) AS 수학총점, 
        SUM(총점) AS 전체총점,
        ROUND(AVG(평균),1) AS 전체평균
 FROM view_성적일람표
 GROUP BY 학과코드, 학과이름;
 
 DELETE tbl_score;
 
 SELECT * FROM tbl_score;
 
 -- 학과별 평균이 75점 이상인 학과만 표시
 -- GROUP으로 묶고 집계를 수행한 결과를 조건으로 설정한 조회
 SELECT 학과코드, 학과이름, 
        SUM(국어) AS 국어총점, 
        SUM(영어) AS 영어총점, 
        SUM(수학) AS 수학총점, 
        SUM(총점) AS 전체총점,
        ROUND(AVG(평균),1) AS 전체평균
 FROM view_성적일람표
 GROUP BY 학과코드, 학과이름
 HAVING ROUND(AVG(평균),1) >= 75;
 
 -- 학과 코드가 002부터 004까지
 -- 문자열이지만 데이터의 길이가 모두 같은경우
 -- 관계연산자를 사용한 범위 조회가 가능
 SELECT 학과코드, 학과이름, 
        SUM(국어) AS 국어총점, 
        SUM(영어) AS 영어총점, 
        SUM(수학) AS 수학총점, 
        SUM(총점) AS 전체총점,
        ROUND(AVG(평균),1) AS 전체평균
 FROM view_성적일람표
 WHERE 학과코드 BETWEEN '002' AND '005'
 -- WHERE 학과코드 >= '002' AND 학과코드 <= '005'
 GROUP BY 학과코드, 학과이름
 ORDER BY 학과코드;
 
 -- view_성적일람표에 어떤 학과들이 있는가
 SELECT 학과코드, 학과이름
 FROM view_성적일람표
 GROUP BY 학과코드, 학과이름 ;
 
 SELECT 학과코드, 학과이름,
    COUNT(*) 학생수,
    MAX(총점) AS 최고점,
    MIN(총점) AS 최저점,
    SUM(총점),
    ROUND(AVG(평균),1)
 FROM view_성적일람표
 GROUP BY 학과코드, 학과이름 
 ORDER BY 학과코드;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 