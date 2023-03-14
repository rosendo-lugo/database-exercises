-- Exercise Goals
-- Use join, left join, and right join statements on our Join Example DB
-- Integrate aggregate functions and clauses into our queries with JOIN statements
-- Create a file named join_exercises.sql to do your work in.

-- Join Example Database
show databases;

-- Use the join_example_db. Select all the records from both the users and roles tables.
use join_example_db;

select *
from roles r
join users u ON r.id = u.id
;
-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson.
-- Before you run each query, guess the expected number of results.
select *
from roles r
left join users u 
	ON r.id = u.id
;

select *
from roles r
right join users u ON r.id = u.id
;

-- correct
select *
from users
right join roles on users.role_id = roles.id;
-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of ****ROLES***** along with the NUMBER OF USERS that has the role. 
-- Hint: You will also need to use group by in the query.
select * -- , count(*)
from roles r
join users u ON r.id = u.id
	join roles On r.id = u.role_id
-- group by r.name, u.role_id
;

-- correct
select roles.name as role_name,
count(users.name) as number_of_employees
from users
right join roles on users.role_id = roles.id
group by role_name
;

use join_example_db;

select
	r.name
	, count(*)
from users as u
left join roles as r On r.id = u.role_id
group by r.name
;


-- Employees Database
-- Use the employees database.
use employees;
-- Using the example in the Associative Table Joins section as a guide, write a query that shows **EACH DEPARTMENT** along 
-- with the NAME of the CURRENT MANAGER for that DEPARTMENT.

--   Department Name    | Department Manager
--  --------------------+--------------------
--   Customer Service   | Yuchang Weedman
--   Development        | Leon DasSarma
--   Finance            | Isamu Legleitner
--   Human Resources    | Karsten Sigstam
--   Marketing          | Vishwani Minakawa
--   Production         | Oscar Ghazalie
--   Quality Management | Dung Pesch
--   Research           | Hilary Kambil
--   Sales              | Hauke Zhang
SELECT * FROM employees.departments;
SELECT * FROM employees.dept_manager;
SELECT * FROM employees.employees;
SELECT * FROM employees.salaries;

select distinct
	d.dept_name AS 'Department Name'
    , concat (e.first_name, ' '
    , e.last_name) AS 'Department Manager'
from departments as d
join dept_manager dm
	ON d.dept_no = dm.dept_no
join employees e
	ON dm.emp_no = e.emp_no
where dm.to_date > NOW()
order by d.dept_name
;
-- correct -- 
use employees;
select *
from employees
;
select *
from dept_manager
;
select *
from deparments
;
select d.dept_name, concat(e.first_name, ' ', last_name) as current_department_manager
from employees as e
join dept_manager dm using(emp_no)
join departments d using(dept_no)
where dm.to_date > curdate()
;
-- Find the name of all departments currently managed by women.
select distinct
	d.dept_name AS 'Department Name'
    , concat (e.first_name, ' '
    , e.last_name) AS 'Department Manager'
from departments as d
join dept_manager dm
	ON d.dept_no = dm.dept_no
join employees e
	ON dm.emp_no = e.emp_no
where dm.to_date > NOW() AND gender LIKE 'F'
order by d.dept_name
;

-- correct
select *
from deparments
;
select d.dept_name, concat(e.first_name, ' ', last_name) as current_department_manager
from employees as e
join dept_manager dm using(emp_no)
join departments d using(dept_no)
where dm.to_date > curdate() and e.gender = 'F' -- only add 'and e.gender = 'F''
;
-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil

-- Find the 'CURRENT TITLES of employees' currently working in the 'Customer Service department'.
use employees;
SELECT * FROM employees.titles;
SELECT * FROM employees.dept_emp;
select * from employees.departments;
select * from employees.dept_manager;

select
	t.title
    , count(t.emp_no) AS Count
from titles as t
join dept_emp as de
	ON de.emp_no = t.emp_no
where t.to_date > NOW() 
	AND de.to_date > NOW() 
    AND de.dept_no = 'd009'
group by t.title
;

-- correct --
select *
from title
;
select *
from departments
;
select *
from dept_emp
;
select t.title
	, count(de.emp_no) as count
from dept_emp de
join titles t using (emp_no)
join departments d using(dept_no)
where t.to_date > curdate() 
	and de.to_date > curdate()
    and d.dept_name = 'Customer Service'
group by t.title
;
-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241


-- Find the current salary of all current managers.
SELECT * FROM employees.salaries;
select distinct dept_name
	, concat(e.first_name
    , ' '
    , e.last_name) AS Name
    , s.salary
from departments as d
join dept_manager as dm
	ON d.dept_no = dm.dept_no
join employees as e
	ON dm.emp_no = e.emp_no
join salaries as s 
	ON e.emp_no = s.emp_no
where s.to_date > NOW() AND dm.to_date > NOW()
order by d.dept_name
;

-- correct --
select *
from salaries;
;
select *
from dept_manager;
select *
from employees
;
select d.dept_name
	, concat(e.first_name, ' ', e.last_name) as current_department_manager
    , s.salary
from employees e
join salaries s using (emp_no)
join dept_manager dm using(emp_no)
join departments d using(dept_no)
where s.to_date > curdate()
	and dm.to_date > curdate()
order by d.dept_name
;
-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987


-- Find the number of current employees in each department.
SELECT 
    de.dept_no
    , d.dept_name
    , COUNT(de.emp_no) AS num_employees
FROM
    dept_emp de
        JOIN
    departments d ON d.dept_no = de.dept_no
WHERE
    de.to_date > NOW()
GROUP BY de.dept_no
order by dept_no
;

-- correct --
select *
from dept_emp;
select *
from departments;

select d.dept_no
	, d.dept_name
    , count(de.emp_no) as num_employees
from dept_emp de
join departments d using(dept_no)
where de.to_date > curdate()
group by dept_no, dept_name
order by dept_no
;

-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+


-- Which department has the highest average salary? Hint: Use current not historic information.
use employees;
SELECT 
    d.dept_name, ROUND(AVG(salary), 4) AS average_salary
FROM
    dept_manager dm
        JOIN
    salaries s ON dm.emp_no = s.emp_no
        JOIN
    departments d ON d.dept_no = dm.dept_no
WHERE
    s.to_date > NOW()
GROUP BY d.dept_no
ORDER BY average_salary desc
LIMIT 1
;

-- copy 2 -- still wrong after adding a second "NOW"
use employees;
SELECT
	d.dept_name, ROUND(AVG(salary), 4) AS average_salary
FROM salaries s
JOIN dept_manager dm
	ON dm.emp_no = s.emp_no
JOIN
    departments d 
    ON d.dept_no = dm.dept_no
WHERE
    dm.to_date > NOW()
    and s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY average_salary desc
LIMIT 3
;
-- correct --
select *
from dept_emp
;
select *
from salaries
;
select *
from departments
;
select d.dept_name
	, round(avg(s.salary), 4) as average_salary
from dept_emp de
join salaries s
	ON de.emp_no = s.emp_no -- you cannot use "using" with the "AND" in combination
	AND de.to_date > curdate()
    and s.to_date > curdate()
join departments d using (dept_no)
group by d.dept_name
order by average_salary desc
limit 1
;
-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+
-- Who is the highest paid employee in the Marketing department?
select e.first_name, e.last_name -- still wrong find a way to fix it
from salaries s
join employees e
	ON s.emp_no = s.emp_no
join dept_emp de
	ON de.emp_no = e.emp_no
join departments d
	ON d.dept_no = de.dept_no
where s.to_date > NOW() 
	AND de.dept_no LIKE 'd001'
group by e.emp_no
order by salary desc
limit 1
;

-- correct ---
select e.first_name
	, e.last_name
    , salary
from employees e
join dept_emp de
	ON e.emp_no = de.emp_no
    and de.to_date > curdate()
join salaries s
	ON e.emp_no = s.emp_no
    AND s.to_date > curdate()
join departments d
	ON de.dept_no = d.dept_no
    AND d.dept_name = 'Marketing'
order by s.salary desc
limit 1
;

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+
-- Which current department manager has the highest salary?



-- correct --
select e.first_name
	, e.last_name
    , s.salary
    , d.dept_name
from employees e
join dept_manager dm
	ON e.emp_no = dm.emp_no
    and dm.to_date > curdate()
join salaries s
	ON s.emp_no = e.emp_no
    AND s.to_date = curdate()
join departments d using(dept_no)
order by s.salary desc
limit 1
;

-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+
-- Determine the average salary for each department. Use all salary information and round your results.

use employees;
SELECT * FROM employees.salaries;

SELECT 
    d.dept_name, AVG(salary)
FROM
    salaries
        JOIN
    dept_manager dm ON dm.emp_no = salaries.emp_no
        JOIN
    departments d ON d.dept_no = dm.dept_no
GROUP BY d.dept_name
;

-- correct --
SELECT 
    d.dept_name, ROUND(AVg(s.salary), 2) AS avg_dept_salary
FROM
    departments d
        JOIN
    dept_emp de USING (dept_no)
        JOIN
    salaries s USING (emp_no)
GROUP BY d.dept_name
ORDER BY avg_dept_salary DESC
;
-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+
-- Bonus Find the names of all current employees, their department name, and their current manager's name.


-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman

--  .....