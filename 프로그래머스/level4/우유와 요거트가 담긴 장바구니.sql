-- 우유와 요거트를 동시에 구입한 장바구니
-- 오답
SELECT 
       CART_ID
  FROM(
  SELECT CART_ID
       , GROUP_CONCAT(NAME) AS NAMES
    FROM CART_PRODUCTS
   GROUP BY CART_ID) TMP
 WHERE NAMES LIKE '%Yogurt%Milk%'
 ORDER BY CART_ID; 

-- 정답
SELECT 
       CART_ID
  FROM(
  SELECT CART_ID
       , GROUP_CONCAT(NAME) AS NAMES
    FROM CART_PRODUCTS
   GROUP BY CART_ID) TMP
 WHERE NAMES LIKE '%Yogurt%' AND NAMES LIKE '%Milk%'
 ORDER BY CART_ID; 