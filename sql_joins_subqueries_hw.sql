--Week 5 - Wednesday Questions


--1. List all customers who live in Texas (use JOINs)

SELECT customer_id, first_name, last_name, address.address_id, address, district
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

	-- Answer: Kim Cruz, Jennifer Davis, Richard McCrary, Bryan Hardison, Ian Still



--2. Get all payments above $6.99 with the Customer’s full name

SELECT payment_id, amount, payment.customer_id, first_name, last_name
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;



--3. Show all customer names who have made total payments over $175 (use subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

	-- Answer: Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, Tommy Collazo, Karl Seal



--4. List all customers that live in Argentina (use the city table)

--customer --> address --> city --> county

SELECT c.customer_id, c.first_name, c.last_name, a.address_id, a.address, a.district, a.city_id, ci.city, ci.country_id, co.country
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city ci 
ON a.city_id = ci.city_id
JOIN country co
ON ci.country_id = co.country_id
WHERE co.country = 'Argentina';



--5. Which film category has the most movies in it?

SELECT c.category_id, COUNT(*), c.name
FROM film_category fc
JOIN category c
ON c.category_id = fc.category_id
GROUP BY c.category_id
ORDER BY COUNT(*) DESC
LIMIT 1;

	-- Answer: Sports has the most movies in it (total of 74)

SELECT *
FROM category c
WHERE category_id = (
	SELECT category_id
	FROM film_category fc
	GROUP BY category_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
);

	-- Answer: Sports has the most movies in it



--6. What film had the most actors in it?

-- using JOIN:

SELECT f.film_id, COUNT(*), f.title, f.description
FROM film_actor fa
JOIN film f
ON f.film_id = fa.film_id
GROUP BY f.film_id
ORDER BY COUNT(*) DESC
LIMIT 1;

	-- Answer: 'Lambs Cincinatti' had 15 actors in it



--7. Which actor has been in the least movies?

-- using SUBQUERY:

SELECT * -- Main query finds the actor info from the film_actor ID produced BY the subquery
FROM actor a
WHERE a.actor_id = (
	SELECT fa.actor_id -- Subquery finds the film actor ID WITH the LEAST movie appearances
	FROM film_actor fa
	GROUP BY fa.actor_id
	ORDER BY COUNT(*)
	LIMIT 1
);

	-- Answer: Emily Dee (actor_id 148)



--8. Which country has the most cities?

SELECT ci.country_id, COUNT(*) AS number_of_cities, co.country
FROM city ci
JOIN country co
ON ci.country_id = co.country_id
GROUP BY ci.country_id, co.country
ORDER BY number_of_cities DESC
LIMIT 1;

	-- Answer: India WITH 60 cities



--9. List the actors who have been in more than 20 films but less than 30.


SELECT *
FROM actor
WHERE actor_id IN(
	SELECT actor_id
	FROM film_actor
	GROUP BY actor_id
	HAVING COUNT(*) > 20 AND COUNT(*) < 30
);



-- USUALLY:
-- Use a JOIN if you need to see column info from multiple tables
-- Use a SUBQUERY if you only need column info from one table




