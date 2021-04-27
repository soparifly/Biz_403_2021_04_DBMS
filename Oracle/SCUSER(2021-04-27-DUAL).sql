--SCUSER접속
--음수(-)를 사용하면 정수부분을 절사하여 표현
SELECT TRUNC (333.55-1), trunc(333.99,-2), TRUNC(333.33, -3)
FROM DUAL;


--나머지연산을 위한 함수
SELECT MOD(3,2), MOD(4,2), MOD(5,2) FROM DUAL;

--150초가 몇분 몇초인가
SELECT TRUNC(150/60) || '분' || MOD(150,60) || '초'
FROM DUAL;

SELECT 
 CASE WHEN MOD(11,2) = 1 THEN '홀수'
    ELSE '짝수'
END CASE
FROM DUAL;

