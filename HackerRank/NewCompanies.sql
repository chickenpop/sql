
-- 잘못된 풀이
SELECT 
       C.company_code
     , C.founder
     , COUNT(DISTINCT E.lead_manager) 
     , COUNT(DISTINCT E.senior_manager) 
     , COUNT(DISTINCT E.manager) 
     , COUNT(DISTINCT E.employee) 
  FROM company C
 INNER join Employee E
 ON C.company_code = E.company_code
 GROUP BY C.company_code, C.founder
 ORDER BY C.company_code;

-- employee 테이블로만 count하는 경우 lead_manager 하위로 이어지는 직급이 없는 경우 누락되는 인원이 생길 수 있다
SELECT 
       C.company_code
     , C.founder
     , COUNT(DISTINCT LM.lead_manager) 
     , COUNT(DISTINCT SM.senior_manager) 
     , COUNT(DISTINCT M.manager) 
     , COUNT(DISTINCT E.employee) 
  FROM Company C
  LEFT JOIN Lead_Manager LM ON C.company_code = LM.company_code
  LEFT JOIN Senior_Manager SM ON LM.lead_manager_code = SM.lead_manager_code
  LEFT JOIN Manager M ON SM.senior_manager_code = M.senior_manager_code
  LEFT JOIN Employee E ON M.manager_code = E.manager_code
 GROUP BY C.company_code, C.founder
 ORDER BY C.company_code;