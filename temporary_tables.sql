-- Exercises
-- Create a file named temporary_tables.sql to do your work for this exercise.

-- Using the example from the lesson, create a temporary table called employees_with_departments
-- that contains first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. 
-- If you see "Access denied for user ...", it means that the query was attempting to write a new 
-- table to a database that you can only read.
USE pagel_2193;
create temporary table employees_with_departments
	(
    n INT UNSIGNED NOT NULL
    )
;
alter table employees_with_departments add first_name varchar(100);
alter table employees_with_departments add last_name varchar(100);
alter table employees_with_departments add dept_name varchar(100);
-- alter table employees_with_departments drop column dept_name;

select database();
select*
from employees_with_departments
;

create temporary table employees_with_departments AS
select first_name, last_name, dept_name
from employees
join dept_emp using(emp_no)
join departments using(dept_no)
limit 100
;


-- Add a column named full_name to this table. 
-- alter table employees_with_departments add full_name varchar (250); -- in my first attempt I didn't read the next line of instruction and gave it 50 characters more. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
alter table employees_with_departments drop column full_name;
alter table employees_with_departments add full_name varchar (200); -- 100 char for the first_name + 100 from the last_name


-- Update the table so that the full_name column contains the correct data.
select database();
use pagel_2193;
select*
from employees_with_departments
;
-- Remove the first_name and last_name columns from the table.
alter table employees_with_departments drop column first_name;
alter table employees_with_departments drop column last_name;

select database();
select*
from employees_with_departments
;
-- What is another way you could have ended up with this same table?
-- *************************************************Teacher's Correct ANS**************************************************************************************************
use pagel_2193;

select *
from employees_with_departments
;
describe employees_with_departments
;

alter table employees_with_departments add full_name varchar(200);

update employees_with_departments
set full_name = concat(first_name, ' ', last_name)
;

-- another way to drop multiple columns at the same time (is not working)
drop table if exists employees_with_departments;

create temporary table employees_with_departments as
(
		select concat(first_name, ' ' , last_name) as full_name, dept_name
		from employees.employees
		join employees.dept_emp as de using(emp_no)
		join employees.departments as d using (dept_no)
		where to_date > curdate()
)
;

select *
from employees_with_departments
;

describe employees_with_departments;

-- *************************************************Teacher's Correct ANS**************************************************************************************************
use employees;

select e.first_name, e.last_name, dept_name
from employees as e
join dept_emp as de using(emp_no)
join departments as d using (dept_no)
where to_date > curdate()
;

use pagel_2193;

create temporary table empployess_with_departments as
		select first_name, last_name, dept_name
		from employees.employees
		join employees.dept_emp as de using(emp_no)
		join employees.departments as d using (dept_no)
		where to_date > curdate()
;

select *
from employees_with_departments
;


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Question #2 Create a temporary table based on the payment table from the sakila database.
use employees;
select *
from dept_emp
;

use sakila;
SELECT * FROM sakila.payment;

use pagel_2193;
create temporary table my_sakila_payment_table AS
select payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
from sakila.payment
;

select *
from my_sakila_payment_table
;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer
-- representing the number of cents of the payment. For example, 1.99 should become 199.
select *
from my_sakila_payment_table
;
-- UPDATE curr_employees
-- SET avg_dept_salary = (select avg(salary) from curr_employees) 
-- -- cant call the temp table when im trying to change it
-- ; -- errors out

-- UPDATE curr_employees
-- SET avg_dept_salary = '67285.2302' -- have to hard code this value
-- ;
update my_sakila_payment_table
set amount = 
;


-- *************************************************Teacher's Correct ANS**************************************************************************************************

create temporary table payments as (
select amount * 100 as amount_in_pennies
from sakila.payments
);

select *
from payments
;
describe payments;

alter table payments
modify amount_in_pennies int not null;

select *
from payments
;

drop table if exists payments;


create temporary table payments as (
select amount
from sakila.payments
);

select *
from payments
;

update payments
set amount = amount * 100;

describe payments;

alter table payments
modify amount dec(10,2);

select *
from payments
;

alter table payments
modify amount int not null;

select *
from payments
;


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Find out how the current average pay in each department compares to the overall current pay for everyone at the company. 
-- For this comparison, you will calculate the z-score for each salary. 
-- In terms of salary, what is the best department right now to work for? The worst?

-- Finding and using the z-score
-- A z-score is a way to standardize data and compare a data point to the mean of the sample.

-- Formula for the z-score
-- z
-- =
-- x
-- −
-- μ
-- σ

-- Notation	Description
-- z
-- the z-score for a data point
-- x
-- a data point
-- μ
-- the average of the sample
-- σ
-- the standard deviation of the sample
-- Hint The following code will produce the z-score for current salaries. Compare this to the formula for z-score shown above.
    -- Returns the current z-scores for each salary
    -- Notice that there are 2 separate scalar subqueries involved
    
    
--     SELECT salary,
--         (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
--         /
--         (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
--     FROM salaries
--     WHERE to_date > now();




# my anwser

-- *************************************************Teacher's Correct ANS**************************************************************************************************
select avg(salary), std(salary)
from employees.salaries
where to_date > curdate()
;

create temporary table overall_aggregates as 
	(
	select avg(salary) as avg_salary, std(salary) as stb_salary
	from employees.salaries
	where to_date > curdate()
	)
;

select *
from overall_aggregates
;

select dept_name, avg(salary) as department_current_average
from employees.salaries
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where employees.dept_emp.to_date > curdate()
and employees.salaries.to_date > curdate()
group by dept_name
;

create temporary table current_info as 
	(
	select dept_name, avg(salary) as department_current_average
	from employees.salaries
	join employees.dept_emp using(emp_no)
	join employees.departments using(dept_no)
	where employees.dept_emp.to_date > curdate()
	and employees.salaries.to_date > curdate()
	group by dept_name
	)
;

select *
from current_info
;

alter table current_info
add overall_avg float (10,2)
;

alter table current_info
add overall_std float (10,2)
;

select *
from current_info
;

update current_info
set overall_avg = (select avg_salary from overall_aggregates);

update current_info
set overall_std = (select std_salary from overall_aggregates);

select *
from current_info
;

alter table current_info
add zscore float (10,2)
;

select *
from current_info
;

update current_info
set zscore = (department_current_average - overall_avg) / overall_std;


select *
from current_info
order by zscore desc
;
;


