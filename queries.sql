/*Queries that provide answers to the questions from all projects.*/
/*Animals whose name ends in "mon"*/
SELECT *
FROM animals
WHERE name LIKE '%mon';
/*Animals born between 2016 and 2019*/
SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
/*Neutered animals with less than 3 escape attempts*/
SELECT name
FROM animals
WHERE neutered = TRUE
  AND escape_attempts < 3;
/*Date of birth of "Agumon" and "Pikachu"*/
SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');
/*Name and escape attempts of animals weighing more than 10.5kg*/
SELECT name,
  escape_attempts
FROM animals
WHERE weight_kg > 10.5;
/*All neutered animals*/
SELECT *
FROM animals
WHERE neutered = TRUE;
/*Animals not named "Gabumon"*/
SELECT *
FROM animals
WHERE name != 'Gabumon';
/*Animals weighing between 10.4kg and 17.3kg*/
SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;
-- To update the animals table inside a transaction and set the species column to unspecified
BEGIN TRANSACTION;
UPDATE animals
SET species = 'unspecified';
SELECT *
FROM animals
WHERE species = 'unspecified';
ROLLBACK TRANSACTION;
SELECT species
FROM animals;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL
  OR species = '';
SELECT species
FROM animals;
COMMIT TRANSACTION;
SELECT species
FROM animals;
-- delete wholw table and rollback
BEGIN TRANSACTION;
DELETE FROM animals;
SELECT COUNT(*)
FROM ANIMALS;
ROLLBACK TRANSACTION;
SELECT COUNT(*)
FROM ANIMALS;
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN TRANSACTION;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepoint;
UPDATE animals
SET weight = weight * -1;
ROLLBACK TO SAVEPOINT savepoint;
UPDATE animals
SET weight = weight * -1
WHERE weight < 0;
COMMIT TRANSACTION;
-- How many animals are there?
SELECT COUNT(*) AS num_animals
FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) AS num_never_escaped
FROM animals
WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) AS avg_weight
FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered,
  MAX(escape_attempts)
FROM animals
GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species,
  MIN(weight_kg) AS min_weight,
  MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,
  AVG(escape_attempts) AS avg_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
UPDATE animals
SET species_id = 'digimon'
WHERE name LIKE '%mon';
-- multiple querries
-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
select animals.name,
  owners.full_name
from animals,
  owners
where full_name = 'Melody Pond'
  and owners.id = animals.owner_id;
-- List of all animals that are pokemon (their type is Pokemon).
select animals.name animals,
  species.name species
from animals,
  species
where species.id = animals.species_id
  and species.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
select animals.name animals,
  owners.full_name owners
from animals
  right outer join owners on owners.id = animals.owner_id;
-- How many animals are there per species?
select count(animals.name) total_animals,
  species.name species
from animals
  inner join species on species.id = animals.species_id
Group by species.name;
-- List all Digimon owned by Jennifer Orwell.
select animals.name animals,
  owners.full_name owners,
  species.name
from animals
  inner join owners on owners.id = animals.owner_id
  inner join species on species.id = animals.species_id
where species.name = 'Digimon'
  and owners.full_name = 'Jennifer Orwell';
-- List all animals owned by Dean Winchester that haven't tried to escape.
select owners.full_name,
  animals.name,
  animals.escape_attempts
from animals
  inner join owners on owners.id = animals.owner_id
where owners.full_name = 'Dean Winchester'
  and animals.escape_attempts = 0;
-- Who owns the most animals?
select count(animals.name) total_animals,
  owners.full_name
from animals
  inner join owners on owners.id = animals.owner_id
group by owners.full_name
order by total_animals desc
limit 1;
-- join table..
-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
select animals.name,
  vets.name,
  visits.date_of_visit
from animals
  inner join visits on animals.id = visits.animals_id
  inner join vets on visits.vets_id = vets.id
where vets.name = 'William Tatcher'
order by visits.date_of_visit desc
limit 1;
-- How many different animals did Stephanie Mendez see?
select count(animals.name),
  vets.name
from animals
  inner join visits on animals.id = visits.animals_id
  inner join vets on visits.vets_id = vets.id
where vets.name = 'Stephanie Mendez'
group by vets.name;
-- List all vets and their specialties, including vets with no specialties.
select vets.name,
  species.name
from specializations
  inner join species on specializations.species_id = species.id
  right outer join vets on specializations.vets_id = vets.id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
select animals.name,
  vets.name,
  visits.date_of_visit
from animals
  inner join visits on animals.id = visits.animals_id
  inner join vets on visits.vets_id = vets.id
where vets.name = 'Stephanie Mendez'
  and visits.date_of_visit BETWEEN '2020-01-04' AND '2020-08-30';
-- What animal has the most visits to vets?
SELECT animals.name,
  visits.date_of_visit
FROM visits
  LEFT JOIN animals ON animals.id = visits.animals_id
  LEFT JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;
-- Who was Maisy Smith's first visit?
Select animals.name,
  vets.name,
  visits.date_of_visit
from animals
  inner join visits on animals.id = visits.animals_id
  inner join vets on vets.id = visits.vets_id
where vets.name = 'Maisy Smith'
order by visits.date_of_visit
limit 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
Select animals.name,
  vets.name,
  visits.date_of_visit
from animals
  inner join visits on animals.id = visits.animals_id
  inner join vets on vets.id = visits.vets_id
order by visits.date_of_visit desc
limit 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.date_of_visit) -(
    SELECT COUNT(vets.name)
    FROM vets,
      specializations,
      animals,
      visits
    WHERE visits.vets_id = vets.id
      AND animals.id = visits.animals_id
      AND concat(animals.species_id, visits.vets_id) = concat(
        specializations.species_id,
        specializations.vets_id
      )
  ) total_unspecialized_cases
FROM visits;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
WITH new AS(
  SELECT DISTINCT(animals.name) animal,
    COUNT(animals.name) total_visits,
    vets.name vet
  FROM vets,
    animals,
    visits
  WHERE visits.animals_id = animals.id
    AND visits.vets_id = vets.id
    AND vets.name = 'Maisy Smith'
  GROUP BY animals.name,
    vet
)
SELECT *
FROM new
WHERE total_visits = (
    SELECT MAX(total_visits)
    FROM new
  );
-- database performance audit
explain analyze
SELECT COUNT(*)
FROM visits
where animals_id = 4;
-- SELECT COUNT(*) FROM visits where animal_id = 4;
-- SELECT * FROM visits where vet_id = 2;
-- SELECT * FROM owners where email = 'owner_18327@mail.com';
-- Use EXPLAIN ANALYZE on the previous queries to check what is happening. Take screenshots of them - they will be necessary later.
-- Find a way to decrease the execution time of the first query
explain analyze
SELECT COUNT(*)
FROM visits
where animals_id = 4;
CREATE INDEX idx_animal_id ON visits (animals_id ASC);
explain analyze
SELECT COUNT(*)
FROM visits
where animals_id = 4;
SELECT *
FROM visits
where vet_id = 2;
SELECT *
FROM owners
where email = 'owner_18327@mail.com';