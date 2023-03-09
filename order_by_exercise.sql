-- Exercise Goals
-- Use ORDER BY clauses to create more complex queries for our database
-- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
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
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name.
select *
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name
;
	-- In your comments, answer: What was the first and last name in the first row of the results?
		-- Irena Reutenauer
    -- What was the first and last name of the last person in the table?
		-- Vidya Simmen

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
	-- In your comments, answer: 
		-- What was the first and last name in the first row of the results? 
			-- Irena Action
		-- What was the first and last name of the last person in the table?
			-- Vidya Zweizig
select *
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name
;
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
-- In your comments, answer:
	-- What was the first and last name in the first row of the results? 
		-- Action, Irena
    -- What was the first and last name of the last person in the table?
		-- Zyda, Maya
select last_name, first_name
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name
;
-- Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their employee number. 
	-- Enter a comment with the number of employees returned, 
		--  employees return 899
    -- the first employee number and their first and last name, 
		-- 10021, Ramzi Erde
    -- and the last employee number with their first and last name.
		-- 499648, Tadahiro Erde
select *
from employees
where last_name LIKE 'e%' AND last_name LIKE '%e'
ORDER BY emp_no
;

-- Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned,
		-- employees returned 899
-- the name of the newest employee,
		-- Teiji Eldridge
-- and the name of the oldest employee.
		-- Menkae Etalle
select *
from employees
where last_name LIKE 'e%' AND last_name LIKE '%e'
ORDER BY hire_date desc
;
-- Find all employees hired in the 90s and born on Christmas. 
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned,
	-- employes returned 362
-- the name of the oldest employee who was hired last,
	-- Gudjon Vakili
-- and the name of the youngest employee who was hired first.
	-- Tremaine Eugenio
select *
from employees
where hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND (birth_date LIKE '%12-25')
order by birth_date desc, hire_date desc
;