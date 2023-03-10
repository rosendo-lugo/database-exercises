-- ###WARM UP EXERCISES###

-- *****10 MAR 2023****
-- using the chipotle database,
show databases;
use chipotle;
show tables;
-- find how many times someone ordered a chicken or veggie bowl
-- with a quantity greater than 1
select *
from orders
where item_name IN ('Chicken Bowl', 'Veggie Bowl') AND quantity > 1
; 
-- 35 Orders where made. 