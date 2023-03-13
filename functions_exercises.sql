-- Exercise Goals
-- Copy the order by exercise and save it as functions_exercises.sql.
-- Exercise Goals
-- Use ORDER BY clauses to create more complex queries for our database
-- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
-- Create a file named where_advanced_exercises.sql. Use the employees database.
show databases;
use employees;
show tables;
;
/*
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
where last_name LIKE 'e%e'
ORDER BY emp_no
;

-- Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned,
		-- employees returned 899
-- the name of the newest employee,
		-- Teiji Eldridge
-- and the name of the oldest employee.
		-- Sergi Erde
select *
from employees
where last_name LIKE 'e%e'
ORDER BY hire_date desc
;
-- Find all employees hired in the 90s and born on Christmas. 
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned,
	-- employes returned 362
-- the name of the oldest employee who was hired last,
	-- Douadi Pettis
-- and the name of the youngest employee who was hired first.
	-- Khun Bemini
select *
from employees
where hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND (birth_date LIKE '%12-25')
order by birth_date, hire_date desc
;
*/

-- Write a query to to find all employees whose last name starts and ends with 'E'.
select *
from employees
where last_name LIKE 'E%E'
;
-- Use concat() to combine their first and last name together as a single column named full_name.
select concat(first_name, last_name) AS full_name
from employees
where last_name LIKE 'E%E'
;
-- Convert the names produced in your last query to all uppercase.
select UPPER (concat(first_name, last_name)) AS full_name
from employees
where last_name LIKE 'E%E'
;
-- Use a function to determine how many results were returned from your previous query.
select count(*)
from employees
where last_name LIKE 'E%E'
;
-- Find all employees hired in the 90s and born on Christmas. 
select *
from employees
where hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND (birth_date LIKE '%12-25')
;
-- Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
select first_name, last_name, hire_date, NOW(), datediff(NOW(), hire_date) AS total_working_days
from employees
where hire_date LIKE '199%'
	AND (birth_date LIKE '%12-25')
;
-- Find the smallest and largest CURRENT salary from the salaries table.
show databases;
use employees;
show tables;
;
select MIN(salary), MAX(salary)
from salaries
where to_date > NOW()
;
select MIN(salary), MAX(salary)
from salaries
;
-- Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, 
-- and consist of the first character of the employees first name, 
-- the first 4 characters of the employees last name, an underscore, 
-- the month the employee was born, 
-- and the last two digits of the year that they were born. 
-- Below is an example of what the first 10 rows will look like:
use employees;
show tables;
;
select *
from employees
;

select first_name, last_name, birth_date, hire_date,
		LOWER( LEFT(first_name, 1))
        , LOWER( SUBSTR(last_name, 1, 4)) -- left( last_name, 4)
			, concat(LOWER( LEFT(first_name, 1))
				, LOWER( SUBSTR(last_name, 1, 4))
                , '_'
                , SUBSTR(birth_date, 6, 2)
                , SUBSTR(birth_date, 3, 2)) AS username
from employees
;


select distinct first_name, last_name, birth_date, hire_date
			, concat(LOWER( LEFT(first_name, 1))
				, LOWER( left( last_name, 4))
                , date_format(birth_date, '_%m%y')) AS username
from employees
;

