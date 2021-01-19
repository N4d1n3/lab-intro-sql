use sakila;
SELECT title
FROM  film;
SELECT DISTINCT name as language
FROM language;
SELECT return_date
FROM rental;
SELECT first_name
FROM staff;
SELECT city
FROM city;
Select COUNT(rental_date)
FROM rental;