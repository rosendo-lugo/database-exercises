-- Create a file named where_advanced_exercises.sql. Use the employees database.
show databases;
use employees;
show tables;
;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?
-- 10200, 10397 and 10610
select *
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
limit 3
;
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, 
-- but use OR instead of IN. W
-- what is the employee number of the top three results? Does it match the previous question?
-- 		The results are the same
select *
from employees
where first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya'
limit 3
;
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is (male). 
-- What is the employee number of the top three results.
	-- 10200, 10397 and 10821
select *
from employees
where (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya')
	AND gender = 'M'
limit 3
;

-- Find all unique last names that start with 'E'.
select *
from employees
where last_name LIKE 'E%'
;
-- Find all unique last names that start or end with 'E'.
select *
from employees
where last_name LIKE 'E%' OR last_name LIKE '%e'
;
-- Find all unique last names that end with E, but does not start with E?
select *
from employees
where last_name LIKE '%e' AND last_name NOT LIKE 'E%'
;
-- Find all unique last names that start and end with 'E'.
select *
from employees
where last_name LIKE 'E%' AND last_name LIKE '%E'
;
-- Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.
select *
from employees
where hire_date BETWEEN '1990-01-01' AND '1999-12-31' 
limit 3
;
-- Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
select *
from employees
where birth_date LIKE '%12-25'
limit 3
;
-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with top three employee numbers.
select *
from employees
where hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND (birth_date LIKE '%12-25')
limit 3
;
-- Find all unique last names that have a 'q' in their last name.
select *
from employees
where last_name LIKE '%Q%'
;
-- Find all unique last names that have a 'q' in their last name but not 'qu'.
select *
from employees
where last_name LIKE '%Q%' AND last_name NOT LIKE '%qu%'
;