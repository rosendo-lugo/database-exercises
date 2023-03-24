show databases;
use albums_db;
select database();
show create	database albums_db;
show tables;
use employees;
select database();
show tables;
show create database employees;
show create table employees;
/*
CREATE TABLE `employees` (
  `emp_no` int NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
show databases;
use fruits_db;
show tables;
















