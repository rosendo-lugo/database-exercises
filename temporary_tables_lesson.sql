use pagel_2193;
select database();


# Create a temporary table called my _numbers
# with tow columns - n& name

create temporary table my_numbers -- my_number is my new table name
	(
    n int unsigned not null, -- first column
    name varchar(20) not null -- second column
    ) -- containded in paranthesis
;

-- view table that i created
select *
from my_numbers
;

show tables;

-- insert data in my_numbers

-- add in more data
INSERT INTO my_numbers (n, name) -- table name (columns)
VALUES (1,'a'), (2,'b'), (3,'c'), (4,'d') -- inserting each colunm by row
;

select *
from my_numbers
;

# update values in temp table

update my_numbers -- stating that in going to update tmy_numbers table 
set name = 'BIG' -- WHAT i want to change my values to 
where n >= 4 -- WHER I wan tto change my values
;

# delete values from temp table 

delete from my_numbers
where n = 2
;

select *
from my_numbers
;


# -------------------------------------------

use employees;
-- find all current 
 select employees.*,
	salary,
    dept_name
 from employees
  join dept_emp
	using(emp_no)
join salaries
	using(emp_no)
join departments
	using(dept_no)
where salaries.to_date > Now()
	and dept_emp.to_date > now()
    and dept_name = 'customer Service'
;

create temporary table pagel_2193 -- write to my current database
	( -- same setup as our initial temp table. but with our query in the paranthesis
     select *
 from employees
  join dept_emp
	using(emp_no)
join salaries
	using(emp_no)
join departments
	using(dept_no)
where salaries.to_date > Now()
	and dept_emp.to_date > now()
    and dept_name = 'customer Service'
)
;

select database();

select *
from pagel_2193.curr_employees
;


use pagel_2193;
show tables;

select *
from curr_employees
;

select avg(salary)
from curr_employees
; -- i dont have to recreate the big query becuase i have it saved as a temp table

-- add a new column for avg salary in tiemp table
ALTER TABLE curr_employees -- adding a new colunm to curre_employees (altering our tble curr_employeees 
add avg_dept_salary float -- adding colunm by specifiyin name and datatype
;

select *
from curr_employees
;

-- update the average salary
update curr_employees
SET avg_dept_salary = '67285.2302'
;

select avg(salary)
from curr_employees
SET avg_dept_salary = '67285.2302'
;

select avg(salary)
from curr_employees
SET avg_dept_salary = (select avg(salary) from curr_employees
;
-- errors out

-- delete table 
select *
from my_numbers 
DROP TABLE curr_employees;
DROP TABLE my_numbers;

select *
from my_numbers;

-- RECAP
-- can only werite to YOUR database

-- CREATE TEMPORYARY TABLE [NEW_TABLE_NAM]
-- OPTION 1. create table from scratch with values and dattypes, then insert values 
-- option 2. crate table from anothyer query

-- ALTER TABLE [table_name] -- changing the STRUCTURE of hte table 
-- ADD/DROP [colunm_name/ row condition]

-- udpate table [TABLE_NAME] -- changing the VALUES in our table 
-- SET 