-- 오답
SELECT 
       N
     , CASE
       WHEN N IN (SELECT P FROM BST) IS NULL THEN 'Root' -- > N은 Null값이 없다, 노드 중 P가 Null값이 뿌리쪽
       WHEN N IN (SELECT N FROM BST) AND N IN (SELECT P FROM BST) THEN 'Inner'
       ELSE 'Leaf'
       END
  FROM BST
 ORDER BY N ASC;

-- 정답
SELECT 
       N
     , CASE
       WHEN P IS NULL THEN 'Root'
       WHEN N IN (SELECT N FROM BST) AND N IN (SELECT P FROM BST) THEN 'Inner'
       ELSE 'Leaf'
       END AS 'OUTPUT'
  FROM BST
 ORDER BY N ASC;