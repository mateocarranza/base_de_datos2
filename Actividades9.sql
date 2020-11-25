"""
1.Get the amount of cities per country in the database. Sort them by country, country_id.
2.Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest
3.Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films.
    Show the ones who spent more money first .
4.Which film categories have the larger film duration (comparing average)?
    Order by average in descending order
5.Show sales per film rating
"""


"""
1.
"""
SELECT COUNT(*), c3.country
FROM city c,country c3
WHERE c.country_id = c3.country_id
GROUP BY c3.country ;

"""
2.
"""
SELECT co.country, count(*) AS ciudades
FROM country co, city ci
WHERE co.country_id = ci.country_id
GROUP BY co.country
HAVING ciudades > 10
ORDER BY ciudades DESC;

"""
3.
"""
SELECT 	c.first_name, c.last_name, a.address, COUNT(*) as amount_rented, sum(p.amount) as spent
FROM 	customer c, address a, rental r , payment p
WHERE	c.address_id = a.address_id
	AND c.customer_id = r.customer_id
	AND p.rental_id = r.rental_id
GROUP BY c.first_name, c.last_name, a.address
ORDER BY spent DESC;

"""
4.
"""
SELECT c1.name ,AVG(f.length) AS duration_average 
FROM film f ,film_category f2,category c1
WHERE f.film_id = f2.film_id 
AND f2.category_id = c1.category_id 
GROUP BY c1.name
HAVING AVG(f.length) > (SELECT AVG(f3.length) FROM film f3)
ORDER BY duration_average DESC

"""
5.
"""
SELECT
SELECT f.rating, SUM(p1.amount) AS SALES 
FROM film f, inventory i1 ,rental r1 ,payment p1
WHERE p1.rental_id = r1.rental_id 
AND r1.inventory_id = i1.inventory_id 
AND i1.film_id = f.film_id 
GROUP BY f.rating;