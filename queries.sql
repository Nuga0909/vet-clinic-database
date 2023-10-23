/*Queries that provide answers to the questions from all projects.*/

/*Animals whose name ends in "mon"*/
SELECT * FROM animals WHERE name LIKE '%mon';

/*Animals born between 2016 and 2019*/
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/*Neutered animals with less than 3 escape attempts*/
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

/*Date of birth of "Agumon" and "Pikachu"*/
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

/*Name and escape attempts of animals weighing more than 10.5kg*/
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/*All neutered animals*/
SELECT * FROM animals WHERE neutered = TRUE;

/*Animals not named "Gabumon"*/
SELECT * FROM animals WHERE name != 'Gabumon';

/*Animals weighing between 10.4kg and 17.3kg*/
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
