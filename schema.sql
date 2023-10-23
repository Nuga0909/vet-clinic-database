/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY, 
    name VARCHAR (20), 
    date_of_birth DATE, 
    escape_attempts INT, 
    neutered BOOL, 
    weight_kg DECIMAL (5,2), 
    PRIMARY KEY(id)
    );
