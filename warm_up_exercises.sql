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


-- *******20 Mar 2023***********

-- in the the sakila database,
-- use the actor, film_actor, and film table
-- find all movies that "Zero Cage" has been in
-- and make a new colum that says if the moved 
-- is rate R or not

show databases;
use sakila;
show tables;
select * from actor; -- actor_id, name 
SELECT * FROM film_actor; -- actor_id, film_id
select * from film; -- film_id, title, rating

select *
from actor
	join film_actor
where first_name like ('Zero')
	AND last_name like ('Cage')
;







;


