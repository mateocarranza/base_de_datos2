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
"""
3.
"""
"""
4.
"""
"""
5.
"""
SELECT
