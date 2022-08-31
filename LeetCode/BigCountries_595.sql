
-- 595. Big Countries
select 
       name
     , population
     , area
  from world
 where 3000000 <= area or 25000000 <= population;