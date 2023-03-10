-- Create a file named more_exercises.sql to do your work in. Write the appropriate USE statements to switch databases as necessary.
-- More Drills With The Sakila Database
show databases;
use sakila;
show tables;
show create table address;

-- SELECT statements

-- Select all columns from the actor table.
select *
from actor_info
;
-- Select only the last_name column from the actor table.
select distinct last_name
from actor_info
;
-- Select only the film_id, title, and release_year columns from the film table.
-- DISTINCT operator
select distinct film_id, title, release_year
from film
;
-- Select all distinct (different) last names from the actor table.
select distinct last_name
from actor_info
;
-- Select all distinct (different) postal codes from the address table.
select distinct postal_code
from address
;
-- Select all distinct (different) ratings from the film table.
select distinct rating
from film
;
-- WHERE clause

-- Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
select title, description, rating, length
from film
where length < 180
;
-- Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
select payment_id, amount, payment_date
from payment
where payment_date >= '2005-05-27'
;
-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
select payment_id, amount, payment_date
from payment
where payment_date = '2005-05-27'
;
-- Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
select *
from customer
where last_name LIKE 'S%' AND first_name LIKE '%N'
;
-- Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
select *
from customer
where active = 0 
	OR last_name LIKE 'M%'
;
-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
select *
from category
where category_id > 4 AND (name LIKE 'C%'
	OR name LIKE 'S%'
    OR name LIKE 'T%')
;
-- Select all columns minus the password column from the staff table for rows that contain a password.
-- Select all columns minus the password column from the staff table for rows that do not contain a password.
-- IN operator

-- Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
-- Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
-- Select all columns from the film table for films rated G, PG-13 or NC-17.
-- BETWEEN operator

-- Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
-- Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.
-- LIKE operator

-- Select the following columns from the film table for rows where the description begins with "A Thoughtful".
-- Select the following columns from the film table for rows where the description ends with the word "Boat".
-- Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
-- LIMIT Operator

-- Select all columns from the payment table and only include the first 20 rows.
-- Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
-- Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.