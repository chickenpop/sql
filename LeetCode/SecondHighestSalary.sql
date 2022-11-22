SELECT IFNULL((SELECT DISTINCT salary --  IFNULL, 데이터가 없는 경우 NULL
                 FROM Employee
                ORDER BY salary DESC
                LIMIT 1 OFFSET 1),NULL) AS SecondHighestSalary; -- 1번째 행부터 1행까지