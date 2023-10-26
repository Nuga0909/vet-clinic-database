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


-- To update the animals table inside a transaction and set the species column to unspecified
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals WHERE species = 'unspecified';
ROLLBACK TRANSACTION;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';
COMMIT TRANSACTION;