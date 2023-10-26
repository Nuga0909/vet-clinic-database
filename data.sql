/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
('Agumon', '2020-02-03', 0, TRUE, 10.23),
('Gabumon', '2018-11-15', 2, TRUE, 8.00),
('Pikachu', '2021-01-07', 1, FALSE, 15.04),
('Devimon', '2017-05-12', 5, TRUE, 11.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES 
('Charmander','2020-02-08', 0, FALSE, -11.00),
('Plantmon','2021-11-15', 2, TRUE, -5.70),
('Squirtle', '1993-04-02', 3, FALSE, -12.13),
('Angemon', '2005-06-12', 1, TRUE, -45.00),
('Boarmon', '2005-06-07', 7, TRUE, 20.40),
('Blossom', '1998-10-13', 3, TRUE, 17.00),
('Ditto', '2022-05-14', 4, TRUE, 22.00);

INSERT INTO owners (full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
update animals
set species_id=(select id from species where name='Digimon')
where name like '%mon';

-- All other animals are Pokemon

update animals
set species_id=(select id from species where name='Pokemon')
where name not like '%mon';

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.

update animals
set owner_id=(select id from owners where full_name='Sam Smith')
where name='Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
update animals
set owner_id=(select id from owners where full_name='Jennifer Orwell')
where name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon.
update animals
set owner_id=(select id from owners where full_name='Bob')
where name='Devimon' or name='Plantmon';

-- Melody Pond owns Charmander, Squirtle, and Blossom.
update animals
set owner_id=(select id from owners where full_name='Melody Pond')
where name IN ('Charmander', 'Squirtle', 'Blossom');


-- Dean Winchester owns Angemon and Boarmon.
update animals
set owner_id=(select id from owners where full_name='Dean Winchester')
where name IN ('Angemon', 'Boarmon');