---1
SELECT CONCAT_WS(' ',c.first_name , c.last_name ) as nombre, a.address, c2.city
FROM customer c
inner join address a using(address_id)
inner join city c2 using(city_id)
inner join country co USING(country_id)
WHERE country = "Argentina"
---------------------------------------------------------------------------------------

---2
SELECT f.title, l.name, 
		CASE WHEN f.rating = 'G' THEN 'All ages admitted.'
		WHEN f.rating = 'PG' THEN 'Some material may not be suitable for children.'
		WHEN f.rating = 'PG-13' THEN 'Some material may be inappropriate for children under 13.'
		WHEN f.rating = 'R' THEN 'Under 17 requires accompanying parent or adult guardian.'
		WHEN f.rating = 'NC-17' THEN 'No one 17 and under admitted.' END  AS 'Rating'
FROM film f 
inner join `language` l using(language_id)
--------------------------------------------------------------------------------------

---3
SELECT CONCAT_WS(' ',a.first_name , a.last_name) as name, f.title, f.release_year 
FROM actor a 
inner join film_actor fa using(actor_id)
inner join film f using(film_id)
WHERE CONCAT_WS(' ',a.first_name , a.last_name) LIKE  '%PENELOPE GUINESS'
--------------------------------------------------------------------------------------

---4
SELECT CONCAT_WS('',c.first_name, c.last_name ), f2.title,
		case when r2.last_update then 'si'
		when r2.last_update is null then 'no' end as returned
FROM customer c
left join rental r2 using(customer_id)
inner join inventory i2 using(inventory_id)
inner join film f2 using(film_id)
WHERE r2.rental_date BETWEEN '2005-05-01 00:0:00' AND '2005-06-01 00:0:00'
-------------------------------------------------------------------------------------

---5
---Cast y convert
---hacen lo mismo, covierten tipos de datos
SELECT CAST("2017-08-29" AS DATE);
---------------------------------
SELECT CONVERT("2017-08-29", DATE);
-------------------------------------------------------------------------------------

---6
---nvl, isnull, ifnull y coalesce
---Dan un resultado alternativo si el valor es null

--nvl es de oraculo
--isnull es de sql server

---La función IFNULL () devuelve un valor especificado si la expresión es NULL. Si la expresión NO ES NULO, esta función devuelve la expresión.
SELECT IFNULL(NULL,'hola'); 
--hola
SELECT IFNULL('hola', 'xd');
--hola


---La función COALESCE () devuelve el primer valor no nulo en una lista
SELECT COALESCE(NULL, 'hola');
---hola
SELECT COALESCE(NULL, NULL, 'hola');
--hola
