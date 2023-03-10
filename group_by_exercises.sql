-- Exercise Goals
-- Use the GROUP BY clause to create more complex queries
-- Create a new file named group_by_exercises.sql

-- In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
	-- 7 unique titles have ever been
show databases;
use employees;
show tables;
;
select title, count(*) 
from titles
group by title
;
		
-- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
select last_name, count(*) 
from employees
group by last_name
having last_name LIKE 'E%E'
;
-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
select first_name, last_name
from employees
group by first_name, last_name
having last_name LIKE 'E%E'
;
-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
select first_name, last_name
from employees
group by first_name, last_name
having last_name LIKE '%Q%'
	 AND last_name NOT LIKE '%qu%'
;
-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
select first_name, last_name, count(*)
from employees
group by first_name, last_name
having last_name LIKE '%Q%'
	 AND last_name NOT LIKE '%qu%'
;
-- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) 
-- and GROUP BY to find the number of employees for each gender with those names.
select first_name, gender, count(*)
from employees
group by first_name, gender
having first_name IN ('Irena', 'Vidya', 'Maya') AND (gender = 'F')
;
-- Using your query that generates a username for all of the employees, generate a count employees for each unique username.
select emp_no, count(*)
from employees
group by emp_no
;

select first_name, last_name, birth_date, hire_date
			, concat(LOWER( LEFT(first_name, 1))
				, LOWER( left( last_name, 4))
                , date_format(birth_date, '_%m%y')) AS username
                , count(*)
from employees
group by first_name, last_name, birth_date, hire_date
order by username desc
;
select *
from employees

;
-- From your previous query, are there any duplicate usernames? 
	-- No duplicates
-- What is the higest number of times a username shows up?
	-- 1
-- Bonus: How many duplicate usernames are there from your previous query?