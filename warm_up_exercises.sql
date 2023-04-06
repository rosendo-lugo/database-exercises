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

-- -----27 Mar-------
-- SQL WARMUP:
-- Find all employees who are current managers and make more than one standard deviation over the companies salary average.
show databases;
use employees;
show tables;

SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM dept_emp;
SELECT * FROM salaries;

select emp_no, round(std(salary),1), round(stddev(salary),1), count(*)
from dept_manager dm
join salaries s using(emp_no)
where dm.to_date > curdate()
group by emp_no
;


-- correct ans
select e.first_name, e.last_name, s.salary
from employees e
join salaries s using(emp_no)
where e.emp_no in (select emp_no from dept_manager where to_date > curdate())
	and s.to_date > curdate()
    
    and s.salary > (select avg(salary) + std(salary)from salaries)
;


-- --------28 Mar---------------
use telco_churn;
SELECT * FROM telco_churn.customer_payments;
SELECT * FROM telco_churn.customers;

# Using the telco_churn DB, give me all the customers who pay over the company monthly average

select count(customer_id)
from customers
where monthly_charges > (select avg(monthly_charges) from customers)
;


-- where e.emp_no in (select emp_no from dept_manager where to_date > curdate())
-- 	and s.to_date > curdate()
--     and s.salary > (select avg(salary) + std(salary)from salaries)

select count(customer_id)/(select count(customer_id)
							from customers) * 100
from customers
where monthly_charges < (select avg(monthly_charges) from customers)
;


select count(customer_id)
from customers
where monthly_charges < (select avg(monthly_charges) from customers)
;






