/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,2)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);


-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
-- Add column species_id which is a foreign key referencing species table
-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT, ADD COLUMN owner_id INT;

ALTER TABLE animals ADD CONSTRAINT fk_animals_species FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals ADD CONSTRAINT fk_animals_owners FOREIGN KEY (owner_id) REFERENCES owners (id);

-- add join table

-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    age INT,
    date_of_graduation DATE
);

-- many-to-many relationship between the tables species and vets
CREATE TABLE specializations (
    id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(id),
    vets_id INT REFERENCES vets(id)
);

-- many-to-many relationship between the tables animals and vets
CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id),
    date_of_visit DATE
);