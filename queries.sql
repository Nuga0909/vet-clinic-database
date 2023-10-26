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
SELECT species FROM animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';
SELECT species FROM animals;
COMMIT TRANSACTION;
SELECT species FROM animals;

-- delete wholw table and rollback
BEGIN TRANSACTION;
DELETE FROM animals;
SELECT COUNT(*) FROM ANIMALS;
ROLLBACK TRANSACTION;
SELECT COUNT(*) FROM ANIMALS;

-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepoint;
UPDATE animals SET weight = weight * -1;
ROLLBACK TO SAVEPOINT savepoint;
UPDATE animals SET weight = weight * -1 WHERE weight < 0;
COMMIT TRANSACTION;

-- How many animals are there?
SELECT COUNT(*) AS num_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS num_never_escaped FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS avg_weight FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
  -- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS avg_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;