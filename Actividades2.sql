--1
CREATE DATABASE imdb;
use imdb

--2
CREATE TABLE 'film'(
  'film_id' int unsigned NOT NULL AUTO_INCREMENT,
  'title' varchar(100) DEFAULT NULL,
  'description' text,
  'release year' date DEFAULT NULL,
  PRIMARY KEY (`film_id`)
)


CREATE TABLE 'actor' (
  'actor_id' int(10) unsigned NOT NULL AUTO_INCREMENT,
  'first_name' varchar(100) DEFAULT NULL,
  'last_name' varchar(100) DEFAULT NULL,
  PRIMARY KEY ('actor_id')
)

CREATE TABLE 'film_actor' (
  'actor_id' int(10) unsigned NOT NULL,
  'film_id' int(10) unsigned NOT NULL,
)

--3
ALTER TABLE 'film'
ADD 'last_update' date DEFAULT NULL,

ALTER TABLE 'actor'
ADD 'last_update' date DEFAULT NULL,

--4
ALTER TABLE 'film_actor'
ADD  FOREIGN KEY ('actor_id') REFERENCES 'actor'('actor_id')

ALTER TABLE 'film_actor'
ADD  FOREIGN KEY ('film_id') REFERENCES 'actor'('film_id')

--5
INSERT INTO `actor` VALUES (1,'Vin','Diesel','2020-04-16'),(2,'Daniel','Radcliffe','2020-04-16'),(3,'Emma','Watson','2020-04-16');