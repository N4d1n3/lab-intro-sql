-- all sql labs may be found in this file in consecutive order

use sakila;

-- 1
SELECT first_name, last_name
FROM actor
WHERE first_name = 'Scarlett';
-- 2
SELECT COUNT(*) from sakila.film;

SELECT rental_duration, film_id
FROM film;
-- 3
SELECT max(rental_duratio) as max_duration, min(rental_duration) as min_duration 
FROM sakila.film; 

-- 4 
SELECT floor(avg(length)/60) as hours, round(avg(length)%60) as minutes
FROM sakila.film;

-- 5 
SELECT COUNT(distinct last_name)
FROM actor; 

-- 6
SELECT DATEDIFF (MAX(return_date), MIN(rental_date)) as datenew
FROM rental; 


-- 7
SELECT *, date_format(rental_date, '%M') as month, date_format(rental_date, '%W') as weekday
FROM rental
LIMIT 20;

-- 8
SELECT *, case when date_format(rental_date, '%W') in ('Saturday', 'Sunday')


	then 'weekend'
    else 'workday' end as day_type
FROM rental;

-- 9


-- LESSON 2.6

-- 1
USE sakila;
SELECT release_year
FROM film;
-- 2
SELECT title
FROM film
WHERE title regexp 'Armageddon';
-- 3
SELECT title
FROM film
WHERE title regexp 'APOLLO$';
-- 4
SELECT length
FROM film
ORDER BY length DESC
LIMIT 10;

-- 5
SELECT title
FROM film
WHERE title regexp 'behind the scenes';

-- 6
ALTER TABLE staff
DROP COLUMN picture;

-- 7
SELECT *
FROM customer
WHERE first_name= 'Tammy' and last_name = 'Sanders';

INSERT INTO staff (first_name, last_name, address_id, email, store_id, username)
VALUES ('TAMMY', 'SANDER', '79' , 'TAMMY.SANDERS@sakilacustomer.org', '1', 'bla');

-- 8
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select * from sakila.film
where title = 'Academy Dinosaur';

select * from sakila.rental
where film_id = '1';

INSERT INTO rental (customer_id, rental_date, rental_id, inventory_id, staff_id)
VALUES ('130', '2021-01-21', '79' , '2', '1');

-- 9

drop table if exists deleted_users;

CREATE TABLE sakila.deleted_users(
customer_id int UNIQUE NOT NULL,
email varchar(255) UNIQUE NOT NULL,
delete_date date);

Insert into deleted_users
select customer_id, email, curdate()
from sakila.customer
where active = 0; 

SELECT * 
FROM sakila.deleted_users;

delete from customer where active = 0;

USE sakila;
drop table if exists films_2020;
CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

LOAD DATA INFILE '/Users/nadinekampmann/Desktop/Ironhack/Week2/dataV3_Lesson_2.7_lab/files_for_part1/films_2020.csv' 
INTO TABLE films_2020 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

show variables like 'local_infile';
set global local_infile = 1;
-- LAB 
show variables like 'local_infile';
set global local_infile = 1;

UPDATE films_2020
SET rental_duration = '3', rental_rate = '2.99€', replacement_cost = '8.99€'
WHERE language_id = language_id;

select * 
from films_2020;

-- LAB PART 2
USE sakila; 
-- 1
SELECT  last_name, count(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*)=1;

-- 2
SELECT  last_name, count(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*)>1;

-- 3
SELECT staff_id, COUNT(rental_id)
FROM rental
GROUP BY staff_id;

-- 4
SELECT release_year, COUNT(film_id)
FROM film
GROUP BY release_year;

-- 5 
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating;

-- 6 
SELECT round(avg(length),2), rating
FROM film
GROUP BY rating;
 
 -- 7
SELECT rating, round(avg(length),2)
FROM film
GROUP BY rating
HAVING round(avg(length),2) > '120' ;


-- Lab | SQL Queries 8
-- 1

SELECT length, title,
RANK() OVER (PARTITION BY length
ORDER BY length DESC)
FROM film WHERE length IS NOT NULL;

-- 2
SELECT title, length, rating,
RANK() OVER(PARTITION BY rating
ORDER BY length DESC)
FROM film;

-- 3
USE sakila; 
SELECT name, COUNT(film_id) AS SUM_FILM
FROM category 
INNER JOIN film_category
ON film_category.category_id = category.category_id
GROUP BY category.name;

-- 4

SELECT COUNT(film_id) as count_movies, actor.actor_id, first_name, last_name
FROM actor
RIGHT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor_id 
ORDER BY count_movies DESC;

-- 5
SELECT customer.customer_id, COUNT(rental_date) as no_of_rentals
FROM customer
INNER JOIN rental
ON rental.customer_id=customer.customer_id
GROUP BY customer_id
ORDER BY no_of_rentals desc;
 

-- Lab | SQL Join
-- 1 List number of films per category.
USE sakila;
SELECT *
FROM category a
JOIN film_category b
ON b.category_id = a.category_id
JOIN film c
ON c.film_id = b.film_id;

SELECT SUM(a.film_id), category_id
FROM film_category a
JOIN film b
ON b.film_id = a.film_id
GROUP BY a.category_id;

-- 2 Display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, a.address_id, address
FROM staff a
JOIN address b
on a.address_id = b.address_id;

-- 3 Display the total amount rung up by each staff member in August of 2005.
SELECT sum(b.amount), first_name, a.last_name, a.staff_id
FROM staff a
Right Join payment b
on a.staff_id = b. staff_id
GROUP BY first_name, a.last_name, a.staff_id
HAVING MONTH('08');

-- 4 List each film and the number of actors who are listed for that film.
SELECT title, COUNT(actor_id)
FROM film a
JOIN film_actor b
ON a.film_id = b.film_id
GROUP BY title;

-- 5 Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT a.last_name, sum(amount)
FROM customer a
JOIN payment b
ON a.customer_id = b.customer_id
GROUP BY a.last_name;