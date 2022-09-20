
-- 중간과정1
SELECT 
       S.ID
     , S.NAME
     , F.ID
     , (SELECT Salary FROM Packages P WHERE S.id = P.id) AS Salary
     , (SELECT Salary FROM Packages P WHERE F.id = P.id) AS 'Friend Salary'
  FROM Students S
 INNER JOIN Friends F ON S.id = F.Friend_ID
 WHERE (SELECT Salary FROM Packages P WHERE S.id = P.id) < (SELECT Salary FROM Packages P WHERE F.id = P.id)

-- 중간과정2
-- 정렬 불가능
SELECT 
       S.NAME
  FROM Students S
 INNER JOIN Friends F ON S.id = F.Friend_ID
 WHERE (SELECT Salary FROM Packages P WHERE S.id = P.id) < (SELECT Salary FROM Packages P WHERE F.id = P.id) 


-- 정답
SELECT S.name
  FROM Friends F
 INNER JOIN Students S ON  F.id = S.id
 INNER JOIN Packages P1 ON P1.id = F.id
 INNER JOIN Packages P2 ON P2.id = F.friend_id
 WHERE P1.Salary < P2.Salary
 ORDER BY P2.Salary;
