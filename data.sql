/* Populate database with sample data. */
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23),
    ('Gabumon', '2018-11-15', 2, TRUE, 8.00),
    ('Pikachu', '2021-01-07', 1, FALSE, 15.04),
    ('Devimon', '2017-05-12', 5, TRUE, 11.00);
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES ('Charmander', '2020-02-08', 0, FALSE, -11.00),
    ('Plantmon', '2021-11-15', 2, TRUE, -5.70),
    ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
    ('Angemon', '2005-06-12', 1, TRUE, -45.00),
    ('Boarmon', '2005-06-07', 7, TRUE, 20.40),
    ('Blossom', '1998-10-13', 3, TRUE, 17.00),
    ('Ditto', '2022-05-14', 4, TRUE, 22.00);
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);
INSERT INTO species (name)
VALUES ('Pokemon'),
    ('Digimon');
-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
update animals
set species_id =(
        select id
        from species
        where name = 'Digimon'
    )
where name like '%mon';
-- All other animals are Pokemon
update animals
set species_id =(
        select id
        from species
        where name = 'Pokemon'
    )
where name not like '%mon';
-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
update animals
set owner_id =(
        select id
        from owners
        where full_name = 'Sam Smith'
    )
where name = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
update animals
set owner_id =(
        select id
        from owners
        where full_name = 'Jennifer Orwell'
    )
where name IN ('Gabumon', 'Pikachu');
-- Bob owns Devimon and Plantmon.
update animals
set owner_id =(
        select id
        from owners
        where full_name = 'Bob'
    )
where name = 'Devimon'
    or name = 'Plantmon';
-- Melody Pond owns Charmander, Squirtle, and Blossom.
update animals
set owner_id =(
        select id
        from owners
        where full_name = 'Melody Pond'
    )
where name IN ('Charmander', 'Squirtle', 'Blossom');
-- Dean Winchester owns Angemon and Boarmon.
update animals
set owner_id =(
        select id
        from owners
        where full_name = 'Dean Winchester'
    )
where name IN ('Angemon', 'Boarmon');
-- join tables
-- Insert the following data for vets:
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');
-- Insert the following data for specializations:
-- Vet William Tatcher is specialized in Pokemon.
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations (vets_id, species_id)
VALUES (
        (
            SELECT id
            FROM vets
            WHERE name = 'William Tatcher'
        ),
        (
            SELECT id
            FROM species
            WHERE name = 'Pokemon'
        )
    ),
    (
        (
            SELECT id
            FROM vets
            WHERE name = 'Stephanie Mendez'
        ),
        (
            SELECT id
            FROM species
            WHERE name = 'Pokemon'
        )
    ),
    (
        (
            SELECT id
            FROM vets
            WHERE name = 'Stephanie Mendez'
        ),
        (
            SELECT id
            FROM species
            WHERE name = 'Digimon'
        )
    ),
    (
        (
            SELECT id
            FROM vets
            WHERE name = 'Jack Harkness'
        ),
        (
            SELECT id
            FROM species
            WHERE name = 'Digimon'
        )
    );
-- Agumon visited William Tatcher on May 24th, 2020.
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- Pikachu visited Maisy Smith on May 14th, 2020.
-- Devimon visited Stephanie Mendez on May 4th, 2021.
-- Charmander visited Jack Harkness on Feb 24th, 2021.
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
-- Plantmon visited William Tatcher on Aug 10th, 2020.
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
-- Angemon visited Jack Harkness on Nov 4th, 2020.
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
-- Boarmon visited Maisy Smith on May 15th, 2019.
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
-- Blossom visited Stephanie Mendez on May 24th, 2020.
-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES (
        (
            SELECT id
            FROM animals
            WHERE name = 'Agumon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'William Tatcher'
        ),
        '2020-05-24'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Agumon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Stephanie Mendez'
        ),
        '2020-07-22'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Gabumon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Jack Harkness'
        ),
        '2021-02-02'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Pikachu'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Maisy Smith'
        ),
        '2020-01-05'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Pikachu'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Maisy Smith'
        ),
        '2020-03-08'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Pikachu'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Maisy Smith'
        ),
        '2020-05-14'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Devimon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Stephanie Mendez'
        ),
        '2021-05-04'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Charmander'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Jack Harkness'
        ),
        '2021-02-24'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Plantmon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Maisy Smith'
        ),
        '2019-12-21'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Plantmon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'William Tatcher'
        ),
        '2020-08-10'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Plantmon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Maisy Smith'
        ),
        '2021-04-07'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Squirtle'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Stephanie Mendez'
        ),
        '2019-09-29'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Angemon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Jack Harkness'
        ),
        '2020-10-03'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Angemon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Jack Harkness'
        ),
        '2020-11-04'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Boarmon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Maisy Smith'
        ),
        '2019-01-24'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Boarmon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Maisy Smith'
        ),
        '2019-05-15'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Boarmon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Maisy Smith'
        ),
        '2020-02-27'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Boarmon'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Maisy Smith'
        ),
        '2020-08-03'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Blossom'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'Stephanie Mendez'
        ),
        '2020-05-24'
    ),
    (
        (
            SELECT id
            FROM animals
            WHERE name = 'Blossom'
        ),
        (
            SELECT id
            FROM vets
            WHERE name = 'William Tatcher'
        ),
        '2021-01-11'
    );


-- database performance audit

-- add new data
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits 
(animals_id, vets_id, date_of_visit) 
SELECT * FROM 
(SELECT id FROM animals) animals_id, 
(SELECT id FROM vets) vets_id, 
generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') 
visit_timestamp;
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email)
select 'Owner ' || generate_series(1, 2500000),
    'owner_' || generate_series(1, 2500000) || '@mail.com';