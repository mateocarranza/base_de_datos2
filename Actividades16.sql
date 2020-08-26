CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);


INSERT INTO employees (`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) 
values (1002,'Murphy','Diane','x5800',NULL,'1',NULL,'President')
---SQL Error [1048] [23000]: Column 'email' cannot be null, este error se produce porque la tabla tiene como regla que el email no puede ser null

---2
UPDATE employees SET employeeNumber = employeeNumber - 20
---Explicacion: esta query actualiza todos los employeeNumber que se encuentren cargandos restandoles 20

UPDATE employees SET employeeNumber = employeeNumber + 20
---Explicacion: esta query actualiza todos los employeeNumber que se encuentren cargandos sumandoles 20

---3
ALTER TABLE employees
ADD age INT

ALTER TABLE employees
   ADD CONSTRAINT myCheckConstraint CHECK(age BETWEEN 16 AND 70);

---4
---La tabla referencial film_actor tiene referencia a la tabla films y actors attravez de dos FOREIGN_KEY una para cada tabla asi logrando una comunicacion de muchos a muchos entre las mismas.

---5
ALTER TABLE employees
ADD lastUpdate DATETIME;

ALTER TABLE employees 
ADD lastUpdateUser VARCHAR(50);

DELIMITER $$
CREATE TRIGGER before_employee_update
    before UPDATE ON employees
    FOR EACH ROW
BEGIN
    INSERT INTO employees
    set ACTION = 'update',
    lastUpdate = NOW(),
    lastUpdateUser = CURRENT_USER();
END$$
DELIMITER ;
-------------------------------------------------
DELIMITER $$
CREATE TRIGGER before_employee_insert BEFORE
    INSERT ON employees 
    FOR EACH ROW 
BEGIN
    INSERT INTO employees 
    SET action = 'update',
	lastUpdate = NOW(),
	lastUpdateUser = CURRENT_USER();
END$$
DELIMITER ;

---6

CREATE DEFINER=`root`@`localhost` TRIGGER `upd_film` AFTER UPDATE ON `film` FOR EACH ROW BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END
  --------------------------------------------------------------
  CREATE DEFINER=`root`@`localhost` TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END
  -------------------------------------------------------------
  CREATE DEFINER=`root`@`localhost` TRIGGER `del_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END