-- Exercise Goals
-- Use subqueries to find information in the employees database
-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

-- #1 Find all the current employees with the same hire date as employee 101010 using a subquery.
use employess;
select *
from dept_emp
;
-- version 1
select e.first_name
, e.last_name
,e.hire_date
from employees e
where emp_no = 101010
;

-- version 2
select e.first_name
	, e.last_name
    , e.birth_date
    , e.hire_date
from employees e
join dept_emp de using(emp_no)
where de.to_date > curdate()
-- 	AND e.emp_no = 101010 
;

-- version 3
select e.first_name
	, e.last_name
    , e.birth_date
from employees e
where e.hire_date =
	(
	select emp_no
	from employees e
	where e.emp_no = 101010
    AND e.hire_date > curdate()
	)
;
-- #1 Find all the current employees with the same hire date as employee 101010 using a subquery.
-- version 4 (My correct version)
select e.first_name
	, e.last_name
    , e.birth_date
    , e.hire_date
from employees e -- I'm missing the join dept_emp :(
where e.hire_date =
	(
	select
	e.hire_date
	from employees e
	where emp_no = 101010
	)
;
-- correct --
-- employee 101010's hire date
select * from employees
where emp_no = 101010
;
select *
from employees e
join dept_emp de ON de.emp_no = e.emp_no
where hire_date = (select hire_date from employees where emp_no = 101010)
	AND de.to_date > curdate()
;


-- #2 Find all the titles ever held by all current employees with the first name Aamod.
-- v1 p1 -- incomplete
select *
from employees
where first_name = 'Aamod'
;
-- v2 p2 -- incomplete
select first_name
	, last_name
from employees
where first_name = 'Aamod'
;
-- v2 p2 -- This version only show one row
select first_name
from employees
where first_name = 'Aamod'
group by first_name
;
-- v1 p2 (My correct version)
SELECT e.first_name
	, t.title
FROM employees e
join titles t using(emp_no)
where t.to_date > curdate()
	AND first_name =
	(
	select first_name
	from employees
	where first_name = 'Aamod'
	group by first_name
    )
;

-- correct --
SELECT * FROM employees.titles;
select *
from employees
where first_name = 'Aamod'
;
-- lsit of all Aamon emp_no's
select emp_no
from employees
where first_name = 'Aamod'
;
select t.title
from employees e
join titles t on t.emp_no = e.emp_no
where e.emp_no In 
	(
    select emp_no
	from employees
	where first_name = 'Aamod'
	)
    AND t.to_date > curdate()
group by t.title
;
-- #3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
-- Department tables
select *
from employees dm
;
select *
from dept_emp de
;
-- v1 p1 -- employees no longer working
-- current employees # 240,124
select count(*)
from dept_emp de
where de.to_date > curdate()
;
-- v2 p1 #6,084 - The count seems wrong
select count(distinct(to_date)) as count
from dept_emp de
where de.to_date < curdate() 
;

-- v3 p1 # 300,024 total number of employees in the database including duplicates
-- subtract current employees (240,124) from the total and you get #59,900. 
-- This gives you the amount of employees no longer working at the company
select count(*)
from employees
;
-- v4 p1
select
	 count(distint(de.emp_no)) as employees_no_longer_working
from dept_emp de
where de.to_date < curdate()
group by de.emp_no
order by employees_no_longer_working desc
;
-- v5 p1
select de.emp_no
	, count(de.emp_no) as employees_no_longer_working
from dept_emp de
where de.to_date < curdate()
group by de.emp_no
order by employees_no_longer_working desc
;
-- v6 p1
select de.emp_no
	, count(distinct(to_date)) as employees_no_longer_working
from dept_emp de
where de.to_date < curdate()
	AND to_date
group by de.emp_no
order by employees_no_longer_working desc
;
-- p1 v7
select emp_no
from dept_emp de
where de.to_date > curdate()
;
-- p1 v8
-- select *
-- from dept_emp de
-- where de.to_date < curdate()
-- ;

-- p2 v1
select DISTINCT id, day, month, year
	,count(*) as no_longer_working
from employees e
join dept_emp de using(emp_no)
;
-- p2 v2
select * -- count(*)
from dept_emp de
where emp_no in
	(select emp_no
	from dept_emp de
	where de.to_date < curdate()
    )
;

-- p2 v3
select distinct emp_no
	, count(*)
from dept_emp de
where emp_no in
	(select emp_no
	from dept_emp de
	where de.to_date > curdate()
    )
group by emp_no
;
-- p2 v4
select emp_no
from dept_emp de
where de.to_date > curdate()
;

-- p2 v5 #59,900 employees not working in the company
select count(*)
from employees e
where emp_no NOT IN
	(
    select emp_no
	from dept_emp de
	where de.to_date > curdate()
	)
;
-- correct --
select *
from dept_emp de
where to_date < curdate()
order by de.emp_no
;

select count(e.emp_no)
from employees e
-- join dept_emp de
-- 	ON de.emp_no = e.emp_no
where e.emp_no NOT IN (
		select distinct(emp_no)
		from dept_emp de
		where to_date >  curdate()
		)
;
-- #4 Find all the current department managers that are female. List their names in a comment in your code.
-- v1
-- subquery
use employees;

select *
from dept_manager dm
where dm.to_date > curdate()
;
-- Query
select first_name
	, last_name
    , gender
    , d.dept_name
from employees e
join dept_emp de using(emp_no)
join departments d using(dept_no)
where gender = 'F' AND emp_no =
		(
		select dm.dept_no
		from dept_manager dm
		where dm.to_date > curdate()
		)
;

-- v2
-- Subquery -- this subquery returns an error "Subquery returns more than 1 row"
-- it returns 1000 rows
select e.emp_no, gender
from employees e
where e.gender = 'F' 
;
-- (Query) v2
select * from departments;
select * from dept_manager;
select * from dept_emp;
select * from employees;

select d.dept_name
	, e.first_name
    , e.last_name
    , e.gender
from employees e
join dept_manager dm using(emp_no)
join departments d using(dept_no)
where dm.to_date > curdate() 
	AND emp_no = 
    (
    select gender
	from employees
	where gender = 'F' 
    )
;
-- v3 Find all the current department managers that are female. List their names in a comment in your code.
-- subquery -error: Error Code: 1242. Subquery returns more than 1 row
select emp_no
from dept_manager dm
where dm.to_date > curdate()
;
-- Query
select e.first_name
from employees e
join dept_manager dm using(emp_no)
where e.gender = 'F' and emp_no = -- put IN and it will fix the problem. 
	(
    select emp_no
	from dept_manager dm
	where dm.to_date > curdate()
    )
;
-- v4 Find all the current department managers that are female. List their names in a comment in your code.
-- subquery -The following error can be avoided if you change the "=" for "IN": Error Code: 1242. Subquery returns more than 1 row
select concat(e.first_name, ' ',e.last_name)
from employees e
join dept_manager dm using(emp_no)
where gender = 'F' and dm.to_date > curdate()
;
-- Query
select concat(e.first_name, ' ', e.last_name) as first_and_last_name
from employees e
where emp_no IN -- not sure why (IN vs =) doesn't give you an "Error Code: 1242. Subquery returns more than 1 row"
		(
		select dm.emp_no
		from employees e
		join dept_manager dm
        ON dm.emp_no = e.emp_no
		where gender = 'F' and dm.to_date > curdate()
		)
;









-- correct --
select *
from dept_manager
;
select *
from employees
;
-- subquery
select *
from dept_manager dm
join employees e
	ON dm.emp_no = e.emp_no
where dm.to_date > curdate()
	AND gender = 'F'
;

select concat(e.last_name, ' ', e.first_name) as current_female_department_managers
from employees e
where e.emp_no IN
	(
    select dm.emp_no
	from dept_manager dm
	join employees e
		ON dm.emp_no = e.emp_no
	where dm.to_date > curdate()
		AND gender = 'F'
    )
;
/*
Legleitner Isamu'
'Sigstam Karsten'
'DasSarma Leon'
'Kambil Hilary'
*/

-- #5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.



-- correct --
-- subquery
select avg(salary)
from salaries
;

select count(*) 
from(
	select concat(e.last_name, ' ', e.last_name))as EmpName
	, s.salary
	from employees e
	join salaries s 
		ON s.emp_no = e.emp_no
	where s.to_date > curdate()
		and s.salary >
		(
		select avg(salary)
		from salaries
    )
)
;



-- #6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?


-- correct --
select max(salary)
from salaries s
where s.to_date > curdate()
;
-- subquery
select round(stddev(salary), 2)
from salaries s
where s.to_date > curdate()
;

-- Numerator; salaries 1 stddev from the max salary
select count(*) from salaries 
where salary >(select max(salary) - round(stddev(salary), 2)
				from salaries s
				where s.to_date > curdate())
and to_date > curdate()
;
-- denamenator; total salary
select count(*) from salaries 
where  to_date > curdate()
;

select round(
(-- Numerator; salaries 1 stddev from the max salary
select count(*) from salaries 
where salary >(select max(salary) - round(stddev(salary), 2)
				from salaries s
				where s.to_date > curdate())
and to_date > curdate())
/ -- divide
(-- denamenator; total salary
select count(*) from salaries 
where  to_date > curdate())*100, 2) as prctmaxstddev
;


-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. 
-- Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.

-- BONUS

-- Find all the department names that currently have female managers.
-- Find the first and last name of the employee with the highest salary.
-- Find the department name that the employee with the highest salary works in.

-- Who is the highest paid employee within each department.