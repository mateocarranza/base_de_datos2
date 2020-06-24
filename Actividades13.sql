--1 Add a new customer
--  To store 1
--  For address use an existing address. The one that has the biggest address_id in 'United States'

--2 Add a rental
--  Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the var.
--  Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest var.
--  Select any staff_id from Store 2.

--3 Update film year based on the rating
--  For example if rating is 'G' release date will be '2001'
--  You can choose the mapping between rating and year.
--  Write as many statements are needed.

--4 Return a film
--  Write the necessary statements and queries for the following steps.
--  Find a film that was not yet returned. And use that rental var. Pick the latest that was rented for example.
--  Use the var to return the film.

--5 T ry to delete a film
--  Check what happens, describe what to do.
--  Write all the necessary delete statements to entirely remove the film from the DB.

--6 Rent a film
--  Find an inventory var that is available for rent (available in store) pick any movie. Save this var somewhere.
--  Add a rental entry
--  Add a payment entry Add a new customer
--  Use sub-queries for everything, except for the inventory var that can be used directly in the queries.

--1
INSERT INTO customer 
(store_id, first_name, last_name, address_id, create_date)
SELECT 1 ,'carlos'  ,'carranza', MAX(a.address_id) as 'addres_id', CURRENT_TIMESTAMP as 'create_date' 
FROM customer
JOIN address a USING (address_id)
JOIN city cy USING (city_id)
JOIN country c USING (country_id)
WHERE c.country = 'United States';

--2
INSERT into rental 
(rental_date, inventory_id, customer_id, staff_id)
select CURRENT_TIMESTAMP as rental_date, max(i.inventory_id ), max(r.customer_id) , min(s.staff_id )
from rental r
inner join inventory i using(inventory_id)
inner join film f using(film_id)
inner join staff s using(staff_id)
where f.title  = "ADAPTATION HOLES" AND 
s.store_id = 2

--3
UPDATE film
SET release_year = 2000
WHERE rating = 'G';
-------------------------------------------------------------------------------------
UPDATE film
SET release_year = 2001
WHERE rating = 'PG-13';
--------------------------------------------------------------------------------------
UPDATE film
SET release_year = 2002
WHERE rating = 'PG';
---------------------------------------------------------------------------------------
UPDATE film
SET release_year = 2003
WHERE rating = 'NC-17';
---------------------------------------------------------------------------------------
UPDATE film
SET release_year = 2004
WHERE rating = 'R';

--4
set @var = (SELECT r.rental_id 
	from film f 
		inner join inventory i using(film_id)
		left join rental r using(inventory_id)
		where return_date is null
		and rental_date in (select rental_date from rental order by rental_date desc)
		limit 1)
		
UPDATE sakila.rental
SET return_date=current_timestamp
WHERE rental_id =@var;

--5
DELETE FROM film_actor
    WHERE film_id = 1000;
---------------------------------------------------------------------------------------
DELETE FROM film_category
    WHERE film_id = 1000;
---------------------------------------------------------------------------------------
DELETE FROM rental
    WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1000);
---------------------------------------------------------------------------------------
DELETE FROM inventory
    WHERE film_id = 1000;
---------------------------------------------------------------------------------------
DELETE FROM film
    WHERE film_id = 1000;

--6
set @var = (SELECT max(i.inventory_id)
            FROM inventory i
            INNER JOIN rental USING (inventory_id)
            WHERE inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL))


INSERT INTO rental
(inventory_id, customer_id, staff_id, rental_date)
SELECT @var as inventory_id, MAX(customer_id), MIN(staff_id), 
(SELECT rental_date FROM rental WHERE rental_id = (SELECT MAX(rental_id) FROM rental)) as rental_date
FROM rental;


INSERT INTO payment
(customer_id, staff_id, rental_id, amount, payment_date)
SELECT (SELECT MIN(customer_id) FROM customer WHERE first_name LIKE 'FRANK%') as customer_id,
(SELECT MAX(staff_id) FROM staff) as staff_id,
rental_id,
(SELECT AVG(amount) FROM payment) as amount,
(SELECT rental_date FROM rental WHERE rental_id = @var) as payment_date
FROM rental
WHERE rental_id = @var;
