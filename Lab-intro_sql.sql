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

SELECT COUNT(*)
FROM 


