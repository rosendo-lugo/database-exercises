-- Exercises
-- Exercise Goals

-- Use CASE statements or IF() function to explore information in the employees database
use employees;
-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

-- #1 Write a query that returns all employees, their department number, 
	-- their start date, their end date, 
	-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
select *
from dept_emp
;
-- MY correct Query 
select *,
	CASE 
		when to_date > curdate() then true
        else false
	END as 'is_current_employee'
from dept_emp
;

-- #1 **** Teacher's Correct ANS****
select 
	emp_no
    , concat(first_name, ' ', last_name) as ful_name
    , hire_date
    , to_date
    , if (to_date > now(), 1, 0) as is_current_employees -- option 1
	, to_date > now() as is_current_employees_2 -- option 2
	, if (to_date > now(), TRUE, FALSE) as is_current_employees_3 -- option 3
from employees
	join dept_emp using(emp_no)
;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- #2 Write a query that returns all employee names (previous and current),
	-- and a new column 'alpha_group' that returns 'A-H', 'I-Q',
    -- or 'R-Z' depending on the first letter of their last name.
select *
from employees
order by last_name
;
-- Subquery
select last_name,
	CASE
		WHEN last_name < 'I' then 'A-H'
        WHEN last_name < 'R' then 'I-Q'
		ELSE 'r-z'
    END as 'alpha_group'
from employees
order by alpha_group desc
;

-- My correct query
select last_name
	, alpha_group
from 
		(
		select last_name,
			CASE
				WHEN last_name < 'I' then 'A-H'
				WHEN last_name < 'R' then 'I-Q'
				ELSE 'r-z'
			END as 'alpha_group'
		from employees
		) as alpha_group_2
group by last_name
order by last_name
;
-- #2 **** Teacher's Correct ANS****
select first_name, last_name,
	case
		when left(last_name, 1) <+ 'H' then 'A-H'
		when left(last_name, 1) <+ 'I' then 'I-Q'
        ELSE 'R-Z'
	end as alpha_group
from employees
;

-- example
select first_name, left(first_name,1), substr(first_name, 1,1)
from employees
;

-- example
select first_name
from employees
where left(first_name, 1) <= 'H'
;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- #3 How many employees (current or previous) were born in each decade?
select birth_date
from employees
order by birth_date
;

select birth_date,
	CASE
		WHEN birth_date < '1959-12-3' then "1950's"
		WHEN birth_date < '1969-12-3' then "1960's"
 		WHEN birth_date < '1979-12-3' then "1970's" 
		WHEN birth_date < '1989-12-3' then "1980's"
		WHEN birth_date < '1999-12-3' then "1990's"
		WHEN birth_date < '2000-12-3' then "2000's"
 		WHEN birth_date < '2010-12-3' then "2010's" 
		ELSE "2020's"
    END AS 'decade_born_in'
from employees
order by decade_born_in
;

select count(*), decade_born_in
from
	(
	select birth_date,
		CASE
			WHEN birth_date < '1959-12-3' then "1950's"
			WHEN birth_date < '1969-12-3' then "1960's"
			WHEN birth_date < '1979-12-3' then "1970's" 
			WHEN birth_date < '1989-12-3' then "1980's"
			WHEN birth_date < '1999-12-3' then "1990's"
			WHEN birth_date < '2000-12-3' then "2000's"
			WHEN birth_date < '2010-12-3' then "2010's" 
			ELSE "2020's"
		END AS 'decade_born_in'
	from employees
	) AS subquery
group by decade_born_in
;
-- total people born in 1950's #181,014 and 1960 #119,010 (not sure)

-- #3 **** Teacher's Correct ANS****
-- find out how many decades do we have
select min(birth_date), max(birth_date)
from employees
;
-- Query
select 
	case
		when birth_date like '195%' then '50s'
  		else '60s'
	end as birth_decade, count(*)
from employees
group by birth_decade
;
-- ANS 50's 182,886 and 60s 117,138

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- #4 What is the current average salary for each of the following department groups: 
	-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
select *
from salaries
;
select *
from departments
;
select *
from dept_emp
;

select round(avg(salary),2) as Overall_Avg_Salary -- Overall average salary $63,810.74
from salaries
;

-- find the current salary for each department

-- not sure what I was going for in the below query but found the number of employees per department that are current
select -- count(*) as number_people_in_the_dept, d.dept_name
	count(Avg(salary)), d.dept_name
from salaries s
join dept_emp de using(emp_no)
join departments d using(dept_no)
where de.to_date > curdate()
group by d.dept_name
;
-- Not sure if this will help
select count(*)
from(
		select concat(e.last_name, ' ', e.last_name)as EmpName
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
-- Come back to this later
select count(*),
	CASE
		WHEN THEN
        ELSE
	END AS
from dept_emp
;

-- RESTART
-- #4 What is the current average salary for each of the following department groups: 
	-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

-- found the current employees that work in each department. Now what?
select de.emp_no, d.dept_name, s.salary
from dept_emp de
join departments d using(dept_no)
join salaries s using(emp_no)
where de.to_date > curdate()
;

select round(avg(salary),2)
from 
	(
		select de.emp_no, d.dept_name, s.salary
		from dept_emp de
		join departments d using(dept_no)
		join salaries s using(emp_no)
		where de.to_date > curdate()
	) as subq
group by d.dept_name
;
-- Teacher's Correct ANS ---------
select -- dept_name, this was just to show the information as we were going 
	Case
		when dept_name IN ('Reaserch', 'Development') then 'R&D'
		when dept_name IN ('Sales', 'Marketing') then 'Sales & Marketing'
		when dept_name IN ('Production', 'Quality Management') then 'Prod & QM'
		when dept_name IN ('Finance', 'Human Resources') then 'Finance & HR'
        ELSE dept_name
	END as dept_group
    , round(avg(salary), 2)
--     , dept_emp.* -- shows everything (this was only to help follow where we were grabing the information
--     , salaries.* -- shows everything (this was only to help follow where we were grabing the information
from departments
join dept_emp using(dept_no)
join salaries using(emp_no)
where salaries.to_date > NOW()
	AND dept_emp.to_date > now()
group by dept_group
;


-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- #1 Write a query that returns all employees, their department number, 
	-- their start date, their end date, 
	-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

select *
from employees
;
select emp_no, max(to_date) -- find all the employee with a max date
from dept_emp
group by emp_no
;

select employees.emp_no
, concat(first_name, ' ', last_name) as Full_name
, hire_date
, max_date
, dept_no
, if(max_date > NOW(), TRUE, FALSE) as is_current_employee
from employees
	join
		(
        select emp_no, max(to_date) as max_date -- find all the employee with a max date
		from dept_emp
		group by emp_no
        ) as current_hire_date
        using(emp_no)
	join dept_emp
		ON dept_emp.to_date = current_hire_date.max_date
        and dept_emp.emp_no = current_hire_date.emp_no
;

select *
from  dept_emp
limit 11
;

-- Wilson's short method
select emp_no
	, dept_no
    , hire_date
    , to_date
    , to_date > now() AS 'is_current_employee'
from dept_emp
join employees
		using(emp_no)
where (emp_no, to_date) IN 
	(select emp_no, max(to_date) from dept_emp group by emp_no)
    ;