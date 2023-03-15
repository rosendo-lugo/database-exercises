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

-- *******15 Mar 2023***********
-- Using the customer table from sakila databes,
-- find the number of active and invactive users

show databases;
use sakila;
show tables;

select *
from customer
;

-- total active # 584
select count(*)
from customer
where active = 1
;

-- total inactive #15
select count(*)
from customer
where active = 0
;

-- total # of active and inactive members #599
select
(
select count(*)
from customer
where active = 1
)
+
(
select count(*)
from customer
where active = 0
) as total 
;

-- correct --
select active, count(*)
from customer
group by active
;