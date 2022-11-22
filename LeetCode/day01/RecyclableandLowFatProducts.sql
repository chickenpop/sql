SELECT product_id 
  FROM Products
 WHERE low_fats = 'Y' AND recyclable = 'Y'
 ORDER BY 1 ASC; -- 없는 경우 속도 저하, 1은 첫번째 컬럼으로 정렬