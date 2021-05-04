
--left join 을 하여 임포트된 두테이블간에 데이터유효성 검증
--학생테이블에 없는 학과 코드가 있는지 검증하기
-- 학생테이블과 학과테이블간에 FK설정을 하기 위한 검증단계
SELECT ST.st_num AS 학번,
        ST.st_name AS 이름, 
    ST.st_dpcode AS 학과코드,
    DP.dp_name AS 학과명,
    ST.st_grade  AS 학년,
    ST.st_tel AS 연락처,
    ST.st_addr AS 주소
        FROM tbl_student st
        LEFT JOIN tbl_dept DP 
    ON ST.st_dpcode = dp.dp_code;
    
    
    DROP VIEW VIEW_성적정보;
    CREATE VIEW view_성적정보 AS (
    
    SELECT SC.sc_seq 일련번호,
        SC.sc_stnum 학번,
        ST.st_name 학생이름,
        ST.st_tel 전화번호,
        SC.sc_sbcode 과목코드,
        SB.sb_name 과목명,
        SC.sc_score 점수,
        SB.sb_prof 담임교수
    FROM tbl_score SC
    LEFT JOIN tbl_student ST
    ON SC.sc_stnum = ST.st_num
    LEFT JOIN tbl_sbject SB
    ON SC.sc_sbcode = SB.sb_code
    );
    
    select * from view_성적정보;
    
    --학생별 총점
    --학번, 과목, 점수형태로 저장된 제 2 정규화 테이블
    --제2정규화 된 테이블에는 통계함수를 적용할 수 있다.
    
    SELECT 학번, 학생이름, SUM(점수) AS 총점,
            ROUND(AVG(점수),1) AS 평균
    FROM view_성적정보
    GROUP BY 학번, 학생이름
    ORDER BY 학번;
    
    
    
    --decode() if와 유사한 조건검색 함수
    --decode(컬럼명, '값', 리턴)
    --      컬럼명에 '값'이 담겨있으면 return명령을 수행하라
    --과목명 컬럼에 국어 문자열이 담겨있으면 해당 레코드의 점수 컬럼 값을 표시하고
    -- 그렇지않으면 (null) 을 표시하라
    SELECT 학번 ,
    DECODE(과목명,'국어',점수) AS 국어점수,
    DECODE(과목명,'영어',점수) AS 영어점수,
    DECODE(과목명,'수학',점수) AS 수학점수
    FROM view_성적정보
    ORDER BY 학번;
    
    --위의 SQL을 학번으로 GROUPING하고
    --각점수를 합산(SUM())GKAUS 
    --DBMS의 SQL에서는( NULL) + 숫자 = 0 + 숫자와 같다
    
    --SUM(NULL,NULL,NULL, 50, NULL) = SUM (0,0,0, 50, 0)과 같다
    
    DROP VIEW view_성적보고서;
    
  CREATE VIEW view_성적보고서 AS ( 
    SELECT 학번,
    SUM (DECODE(과목명,'국어',점수)) AS 국어점수,
    SUM (DECODE(과목명,'영어',점수)) AS 영어점수,
    SUM (DECODE(과목명,'데이터베이스',점수)) AS DB점수,
    SUM (DECODE(과목명,'미술',점수)) AS 미술점수,
    SUM (DECODE(과목명,'음악',점수)) AS 음악점수,
    SUM (DECODE(과목명,'소프트웨어공학',점수)) AS sw점수,
    SUM (DECODE(과목명,'수학',점수)) AS 수학점수,
    SUM(점수)AS 총점,
    ROUND(AVG(점수),1) AS 평균
    FROM view_성적정보
    GROUP BY 학번
);
    ORDER BY 학번;
    SELECT * FROM veiw_성적보고서
    ORDER BY 학번;
    
    SELECT * 
    
    
    
    
    
    