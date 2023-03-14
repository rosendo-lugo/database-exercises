use employees;

-- What's the higths employees higthe average salary

-- average employee salary
select avg(salary)
from salaries
;

select *
from salaries
;

select *
from salaries
where salary > 63810
;

select *
from salaries
where salary > 
	(select avg(salary)
	from salaries
    )
;

select e.first_name
, e.last_name
, s.salary
from salaries s
join employees e using(emp_no)
where s.salary > 
	(select avg(salary)
	from salaries
    )
;
select e.first_name
, e.last_name
, s.* -- shows everything in salaries table
from salaries s
join employees e using(emp_no)
where s.salary > 
	(select avg(salary)
	from salaries
    )
and s.to_date > curdate() -- anyone that's currently employed
;
-- What's the average salary? -- Subquery build from the "Select"
select e.first_name
, e.last_name
	, s.salary
    , (select avg(salary) from salaries) as avg_salary -- added another query
from salaries s
join employees e using(emp_no)
where s.salary > -- added another query
	(select avg(salary)
	from salaries
    )
;
    
    -- Find all current department manager name and birtdays
select *
from employees
;
select *
from dept_manager
;

select *
from dept_manager dm
where to_date > now()
;

select first_name
	, last_name
    , birth_date
from employees e
;

-- build two query that have employees and dept number
select first_name
	, last_name
    , birth_date
from employees e
where emp_no in 
	(
    select emp_no
	from dept_manager dm
	where to_date > now()
	)
;

-- Add in what department they work in
select e.first_name
	, e.last_name
    , e.birth_date
    , d.dept_name -- added another column
from employees e
join dept_manager dm using(emp_no) -- added dept_manager
join departments d using(dept_no) -- added departments
where emp_no in 
	(
    select emp_no
	from dept_manager dm
	where to_date > now()
	)
;

-- Another example "Subquery from "where" This is to show that you can subquery a row. 
select *
from employees
where emp_no = 101010 -- finding a row
;

select e.first_name
	, e.last_name
    , e.birth_date -- selecting a row
from employees e
where emp_no = 
	(
    select emp_no
    from employees
    where emp_no = 101010 -- selecting a row
    )
;

-- this has an extra row showing a "null" -- returns one row with a "null" row at the end 
select *
from employees
where emp_no = 101010
;

-- Subquery from the "from"
-- How many users are from the users query
select sum(cnt)
	, count(cnt)
    , max(cnt)
from 
	(
    select lower(concat(substr(first_name, 1,1)
	, substr(last_name, 1, 4)
    , ' '
    , lpad(month(birth_date), 2, 0)
    , substr(birth_date, 3, 2)
    )
    )as username
    , count(*) as cnt
from employees
group by username
having count(*) >= 2
order by count(*) desc
) as un
;
