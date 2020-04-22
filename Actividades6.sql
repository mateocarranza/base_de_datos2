"""
1.List all the actors that share the last name. Show them in order
2.Find actors that don't work in any film
3.Find customers that rented only one film
4.Find customers that rented more than one film
5.List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
6.List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
7.List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
8.List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'
"""

"""
1.
"""
SELECT DISTINCT a1.* 
FROM actor a1 , actor a2
WHERE a1.last_name = a2.last_name
ORDER BY a.last_name 

"""
2.
"""
SELECT  DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a, film_actor fa, film f 
WHERE NOT EXISTS(SELECT *
     FROM actor a1, film_actor fa1, film f1
    WHERE a1.actor_id = fa1.actor_id 
    and fa1.film_id = f1.film_id)
    
"""
3.
"""
SELECT c.customer_id, c.first_name, c.last_name 
FROM customer c
WHERE (SELECT COUNT(*)
    FROM rental r 
    WHERE c.customer_id = r.customer_id) = 1 
"""
4.
"""
SELECT c.customer_id, c.first_name, c.last_name 
FROM customer c
WHERE (SELECT COUNT(*)
    FROM rental r 
    WHERE c.customer_id = r.customer_id) > 1
"""
5.
"""
SELECT  DISTINCT a.first_name, a.last_name, f.title, f.film_id, a.actor_id
FROM actor a, film f,  film_actor fa 
WHERE a.actor_id = fa.actor_id 
    and fa.film_id = f.film_id
    and f.title = 'BETRAYED REAR' 
    OR f.title ='CATCH AMISTAD'
"""
6.
"""
SELECT  DISTINCT a.first_name, a.last_name, f.title, f.film_id, a.actor_id
FROM actor a, film f,  film_actor fa 
WHERE a.actor_id = fa.actor_id 
    and fa.film_id = f.film_id
    and f.title = 'BETRAYED REAR' 
    and not  f.title ='CATCH AMISTAD'
"""
7.
"""
SELECT  DISTINCT a.first_name, a.last_name, f.title, f.film_id, a.actor_id
FROM actor a, film f,  film_actor fa 
WHERE a.actor_id = fa.actor_id 
    and fa.film_id = f.film_id
    and f.title = 'BETRAYED REAR' 
    and f.title ='CATCH AMISTAD'
"""
8.
"""
SELECT  DISTINCT a.first_name, a.last_name, f.title, f.film_id, a.actor_id
FROM actor a, film f,  film_actor fa 
WHERE a.actor_id = fa.actor_id 
    and fa.film_id = f.film_id
    and f.title <> 'BETRAYED REAR' 
    and f.title <>'CATCH AMISTAD'
