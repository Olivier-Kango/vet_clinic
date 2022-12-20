/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

-- Update animals table
ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

-- Multiple tables
CREATE TABLE owners (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);

ALTER TABLE animals  
DROP COLUMN species;

ALTER TABLE animals  
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id);

ALTER TABLE animals 
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owners
FOREIGN KEY (owner_id)
REFERENCES owners(id);

-- Create a table vets
CREATE TABLE vets (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

-- There is a many-to-many relationship between the tables species and vets through a "join table" called specializations.
CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    CONSTRAINT fk_vets
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    CONSTRAINT fk_species
    FOREIGN KEY (species_id) REFERENCES species(id)
);

-- There is a many-to-many relationship between the tables animals and vets through a "join table" called visits.
CREATE TABLE visits (
    vet_id INT,
    animal_id INT,
    date_of_visit DATE,
    PRIMARY KEY (vet_id, animal_id),
    CONSTRAINT fk_vets
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    CONSTRAINT fk_animals
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

-- Add an email column to your owners table
ALTER TABLE owners
ADD COLUMN email VARCHAR(120);

-- Drop visits table
DROP TABLE visits;

-- Create visits table
CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE,
    PRIMARY KEY(id)
);