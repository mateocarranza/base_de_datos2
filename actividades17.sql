--1
SELECT *
FROM address a2 
inner join city c using (city_id)
inner join country c2 using (country_id )
WHERE a2.postal_code in ('18743', '93896', '77948', '45844', '53628')
ORDER BY c.city_id, c2.country_id, a2.address_id 

--Esta query selecciona todos los datos de la trabla address, city, country y los filtra atravez del portal_code y devuelve los datos que tengan esos portal_code
--5 row(s) fetched - 213ms (+2ms).


SELECT *
FROM address a2 
inner join city c using (city_id)
inner join country c2 using (country_id )
WHERE a2.postal_code NOT in ('18743', '93896', '77948', '45844', '53628')
ORDER BY c.city_id, c2.country_id, a2.address_id 

--Esta query selecciona todos los datos de la trabla address, city, country y los filtra atravez del portal_code y excluye los datos que tengan esos portal_code
--200 row(s) fetched - 6ms (+21ms).

CREATE INDEX postalCode 
ON address(postal_code);

--crea un index llamado portalCode en la tabla de address atravez del portal_code.
--0 row(s) updated - 3.128s.

--2
SELECT a.first_name 
FROM actor a 
inner join film_actor fa using(actor_id)
inner join film f using(film_id)
-----------------------------------
SELECT a.last_name
FROM actor a 
inner join film_actor fa using(actor_id)
inner join film f using(film_id)

--una busca todos los datos que tenga nombre y la otra todo lo que tenga apellido, pero solo muetra un dato.

--3
SELECT *
FROM film_text ft 
where description LIKE "%Fateful%"


SELECT *
FROM film_text ft 
WHERE MATCH(title, description) against('Fateful,Display')

--Full text search usa un indexy like tiene que escaniar toda la tabla.
--Like te trae menos rows por que es mas precisa.
--Like tiende a se mas extricta por lo que si le decimo que  "%hello " hello world no lo devolveria, pero el full text lo haria de igual forma.

