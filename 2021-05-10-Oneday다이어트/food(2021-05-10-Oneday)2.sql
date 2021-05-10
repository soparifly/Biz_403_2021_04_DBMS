-- 여기서 food


-- 식품정보 , 제조사 정보, 식품분류 테이블을 JOIN하여 view를 생성 
-- view_식품정보


--식품정보view
CREATE VIEW view_상품정보 AS (

    SELECT Ti.cb_name,
    CP.cp_name 회사명,
    FD.fd_name 상품명,
    FD.fd_birth 생산일,
    FD.fd_order 회당제공량,
    FD.fd_weight 총내용량,
    FD.fd_kcal 칼로리,
    FD.fd_dan 단백질,
    FD.fd_gi 지방,
    FD.fd_tan 탄수화물,
    FD.fd_dang 당
FROM tbl_foods FD
 LEFT JOIN  tbl_company CP
    ON FD.fd_ccode = CP.cp_code
    LEFT JOIN tbl_items TI
        on FD.fd_bcode = ti.cb_code
        );
        
        
SELECT * FROM VIEW_상품정보
 ORDER BY cb_name;

        

