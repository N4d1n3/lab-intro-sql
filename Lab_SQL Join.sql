

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
