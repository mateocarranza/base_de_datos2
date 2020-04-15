"""
1.Show title and special_features of films that are PG-13
2.Get a list of all the different films duration.
3.Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
4.Show title, category and rating of films that have 'Behind the Scenes' as special_features
5.Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
6.Show the address, city and country of the store with id 1
7.Show pair of film titles and rating of films that have the same rating.
8.Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
"""

"""
1.
"""
SELECT f.title, f.special_features, f.rating 
FROM film f
where f.rating = 'PG-13'

"""
2.
"""
SELECT f.title, f.`length`
FROM film f
ORDER BY f.`length`

"""
3.
"""
SELECT f.title, f.rental_rate , f.replacement_cost 
FROM film f
where f.replacement_cost between 20.00 AND 24.00

"""
4.
"""
SELECT f.title, c.name , f.rating 
FROM film f, category c, film_category fc 
where fc.category_id = c.category_id 
AND fc.film_id = f.film_id 
AND f.special_features = 'Behind the Scenes'

"""
5.
"""
SELECT a.first_name, a.last_name 
FROM actor a,film f, film_actor fa 
where fa.film_id = f.film_id 
AND fa.actor_id = a.actor_id 
AND f.title = 'ZOOLANDER FICTION'

"""
6.
"""
SELECT a.address,c.city, co.country 
FROM store s,address a,city c,country co
where s.address_id = a.address_id 
AND a.city_id = c.city_id 
AND c.country_id = co.country_id 
AND s.store_id = 1

"""
7.
"""
SELECT f.title, f.rating 
FROM film f
where f.rating IN(SELECT f2.rating
                    from film f2
                    where f.rating = f2.rating
                    AND f.film_id <> f2.film_id
                 )

"""
8.
"""
SELECT f.title, s.first_name, s.last_name 
FROM staff s, store st, film f,inventory i 
where i.film_id = f.film_id 
AND st.manager_staff_id = s.staff_id 