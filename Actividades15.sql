---1
CREATE OR REPLACE VIEW list_of_customer as
	SELECT c.customer_id, concat_ws(" ",c.first_name ,c.last_name ) as name, a2.address, a2.postal_code , a2.phone, c2.city, c3.country, s.store_id,
	CASE when c.active = "1" then "activa"
	else "inactive" End as status
	FROM country c3
	inner join city c2 using(country_id)
	inner join address a2 using(city_id)
	inner join store s using(address_id)
	right join customer c using(store_id)

---2
CREATE OR REPLACE VIEW film_details as
	select f.film_id , f.title, c.name, f.replacement_cost as precio, f.description, f.`length`, f.rating, group_concat(CONCAT_WS(" ", a.first_name , a.last_name ) )
	from film f
	INNER JOIN film_category fc USING (film_id)
	INNER JOIN category c USING (category_id)
	INNER JOIN film_actor fa USING (film_id)
	INNER JOIN actor a USING (actor_id)
	group by f.film_id, c.name 

---3
CREATE OR REPLACE VIEW sales_by_film_category as
	select c.name, COUNT(r.rental_id ) as total_rental
	from category c
	inner join film_category fc using(category_id)
	inner join film f using (film_id)
	inner join inventory i using(film_id)
	inner join rental r using(inventory_id)
	group by c.name 
--------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW sales_by_film_category as
	select c.name ,sum(p.amount ) as 'Total_rental'
	from category c
	inner join film_category fc using(category_id)
	inner join film f using(film_id)
	inner join inventory i using(film_id )
	inner join rental r using(inventory_id)
	inner join payment p using (rental_id)
	group by c.name

---4
CREATE OR REPLACE VIEW actor_information as
	select a.actor_id , CONCAT_WS(" ", a.first_name ,a.last_name), count(f.film_id ) as amount_of_film
	from actor a 
	inner join film_actor fa using(actor_id)
	inner join film f using(film_id)
	group by a.actor_id 

---5
CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `sakila`.`actor_info` AS
select
    `a`.`actor_id` AS `actor_id`,
    `a`.`first_name` AS `first_name`,
    `a`.`last_name` AS `last_name`,
    group_concat(distinct concat(`c`.`name`, ': ',(select group_concat(`f`.`title` order by `f`.`title` ASC separator ', ') from ((`sakila`.`film` `f` join `sakila`.`film_category` `fc` on((`f`.`film_id` = `fc`.`film_id`))) join `sakila`.`film_actor` `fa` on((`f`.`film_id` = `fa`.`film_id`))) where ((`fc`.`category_id` = `c`.`category_id`) and (`fa`.`actor_id` = `a`.`actor_id`))))
order by
    `c`.`name` ASC separator '; ') AS `film_info`
from
    (((`sakila`.`actor` `a`
left join `sakila`.`film_actor` `fa` on
    ((`a`.`actor_id` = `fa`.`actor_id`)))
left join `sakila`.`film_category` `fc` on
    ((`fa`.`film_id` = `fc`.`film_id`)))
left join `sakila`.`category` `c` on
    ((`fc`.`category_id` = `c`.`category_id`)))
group by
    `a`.`actor_id`,
    `a`.`first_name`,
    `a`.`last_name`
--- Crea o remplaza una view con el nombre actor_info, esta contiene el acotr_id de la columna actor, first_name de la columna actor, last_name de la columna actor y
--- luego concatena las films por grupos segun su categoria con group_concat, ademas agrega separadores para cada film(",") y cada category(";") por lo 
--- que se mostrara de la siguiente forma "category: (la pelicula en la que actuo); ....." , para que esto funcione tiene que unir las tablas category y film esto lo realiza
--- con los join dentro de la subqueri y el where conparando las id para que no se repitan 
--- luego reliza conecione atravez de los left join dando prioridad a la columna de la izquierda que es la primera realizada anteriormente estas conexiones son con
--- fil_actor, film_category y category, y los agrupa segun actor_id, first_name y last_name.

---6
--- Materialized views es un objeto de la base de datos que dentro contiene el resultado de una consulta, esta permite mantener copias de las tablas ya creada, pero
--- son mucho mas ligeras y pueden contenerla en tu host local.
--- Materialized views existe en Oracle,Mysql
--- una alternativa es usar refresh
