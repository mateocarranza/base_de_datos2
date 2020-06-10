"""
4.Find all the film titles that are not in the inventory.

5.Find all the films that are in the inventory but were never rented.

Show title and inventory_id.
This exercise is complicated.
hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is null

6.Generate a report with:

customer (first, last) name, store id, film title,
when the film was rented and returned for each of these customers
order by store_id, customer last_name

7.Show sales per store (money of rented films)

show store's city, country, manager info and total sales (money)
(optional) Use concat to show city and country and manager first and last name

8.Which actor has appeared in the most films?
"""

"""
4.
"""
select f.title
FROM film f
LEFT JOIN inventory USING(film_id)
where inventory_id is NULL;

"""
5.
"""
SELECT f.title i.inventory_id
FROM film f
INNER JOIN inventory i USING(film_id)
LEFT JOIN rental r USING(inventory_id)
where rental_id is NULL;

"""
6.
"""
SELECT c.first_name, c.last_name, i.store_id, f.title, r.rental_date, r.return_date
from customer c
INNER JOIN rental r USING(customer_id)
INNER JOIN inventory i USING(rental_id)
INNER join film f USING(inventory_id)
ORDER by c.last_name, i.store_id;

"""
7.
"""
SELECT CONCAT_WS(" ", c.country, ci.city) as origen, CONCAT_WS(" ", st.last_name, st.first_name)as nombre, sum(p.amount) as ventas
FROM country c
INNER JOIN city ci USING(country_id)
INNER JOIN 'address' a USING(city_id)
INNER JOIN store s USING(address_id)
INNER JOIN staff st USING(s.store_id)
INNER JOIN payment p USING(staff_id)
Group by s.store_id;

"""
8.
"""
SELECT a.first_name, a.last_name, COUNT(*) AS peliculas 
FROM actor a 
JOIN film_actor USING(actor_id)
JOIN film USING(film_id)
GROUP BY a.actor_id 
HAVING peliculas = (SELECT MAX(Countt) FROM
(SELECT COUNT(*) AS Countt
    FROM actor
    JOIN film_actor using (actor_id)
	JOIN film using(film_id)
    GROUP BY actor.actor_id ) AS num_peliculas),