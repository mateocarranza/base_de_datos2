--1
CREATE user data_analyst@'%' IDENTIFIED BY 'secret';

--2
grant select, update, delete on sakila.* to 'data_analyst'@'%';

--3
--ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'Test'

--4
UPDATE film
set title = "Pitufos"
Where film_id = 5;

--5
REVOKE UPDATE ON sakila.* FROM data_analyst;

--6
--ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'films'
