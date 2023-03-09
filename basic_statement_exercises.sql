-- Use the albums_db database.
show databases;
use albums_db;
show tables;
show create table albums;

/*
CREATE TABLE `albums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `artist` varchar(240) DEFAULT NULL,
  `name` varchar(240) NOT NULL,
  `release_date` int DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `genre` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1
*/

-- What is the primary key for the albums table?
-- 'PRIMARY KEY (`id`)

-- What does the column named 'name' represent?
-- album title

-- What do you think the sales column represents?
-- number of sales of units or money

-- Find the name of all albums by Pink Floyd.
-- The Dark Side of the wall and The wall
select *
from albums
where artist = 'Pink Floyd'
;
-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
-- 1967
select *
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band"
;

-- What is the genre for the album Nevermind?
-- Grunge, Alternative rock
select genre
from albums
where name = 'Nevermind'
;

-- Which albums were released in the 1990s?
select name, release_date
from albums
where release_date between 1990 and 1999
;

-- Which albums had less than 20 million certified sales?
select name, sales
from albums
where sales < 20
;

