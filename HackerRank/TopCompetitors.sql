-- 오답
-- 1. 풀스코어의 의미를 해석 못함
SELECT
       H.hacker_id
     , H.name
  FROM Hackers H
  INNER JOIN Challenges C
  ON H.hacker_id = C.hacker_id
  INNER JOIN Difficulty D
  ON C.difficulty_level = D.difficulty_level
  INNER JOIN Submissions S
  ON S.challenge_id = C.challenge_id
  WHERE S.score = D.score;

-- 정답
-- Submisssion의 score가 Difficulty의 score와 동일하고 
-- score가 동일한 아이디가 2개 이상인 hacker의 아이디와 이름을 찾아라
-- 정렬은 풀 스코어 내림차순, 동일하면 hacker_id 오름차순
SELECT
       H.hacker_id
     , H.name
  FROM Submissions s
 INNER JOIN Hackers H ON S.hacker_id = H.hacker_id
 INNER JOIN Challenges C ON S.challenge_id = C.challenge_id
 INNER JOIN Difficulty D ON C.difficulty_level = D.difficulty_level
 WHERE S.score = D.score
 GROUP BY H.hacker_id, h.name
 HAVING COUNT(DISTINCT S.submission_id) > 1
 ORDER BY COUNT(DISTINCT S.submission_id) DESC, H.hacker_id;