/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;


CREATE TABLE animals (id INT, name VARCHAR(100),
                                   date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg DECIMAL, PRIMARY KEY(id));


ALTER TABLE animals ADD species VARCHAR(100);


CREATE TABLE owners(id SERIAL NOT NULL PRIMARY KEY,
                                               full_name VARCHAR(100),
                                                         age INT);


CREATE TABLE species(species_id SERIAL NOT NULL PRIMARY KEY,
                                                        name VARCHAR(100));


ALTER TABLE animals
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;


ALTER TABLE animals
DROP COLUMN species;


ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);


ALTER TABLE animals ADD COLUMN owners_id INT REFERENCES owners(id);


CREATE TABLE vets(id SERIAL NOT NULL PRIMARY KEY,
                                             name VARCHAR(100),
                                                  age INT, date_of_graduation DATE);


CREATE TABLE specializations (vet_id INT REFERENCES vets(id),
                                                    species_id INT REFERENCES species(id),
                                                                              PRIMARY KEY (vet_id,
                                                                                           species_id));


CREATE TABLE visits (animal_id INT REFERENCES animals(id),
                                              vet_id INT REFERENCES vets(id),
                                                                    date_of_visit DATE, PRIMARY KEY (animal_id,
                                                                                                     vet_id,
                                                                                                     date_of_visit));

-- Add an email column to your owners table

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

