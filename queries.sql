/*Queries that provide answers to the questions from all projects.*/
SELECT *
FROM animals
WHERE name LIKE '%mon';


SELECT *
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';


SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon',
               'Pikachu');


SELECT name,
       escape_attempts
FROM animals
WHERE weight_kg > 10.5;


SELECT *
FROM animals
WHERE neutered = TRUE;


SELECT *
FROM animals
WHERE weight_kg >= 10.4
  AND weight_kg <= 17.3;


SELECT *
FROM animals
WHERE name != 'Gabumon';


SELECT name
FROM animals
WHERE neutered = TRUE
  AND escape_attempts < 3 BEGIN;


UPDATE animals
SET species = 'unspecified';


SELECT *
from animals;


ROLLBACK;


SELECT *
from animals;

BEGIN;


UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';


UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;


COMMIT;

BEGIN;


DELETE
FROM animals;


SELECT *
FROM animals;


ROLLBACK;


SELECT *
FROM animals;

BEGIN;


DELETE
FROM animals
WHERE date_of_birth > '2022/01/01';

SAVEPOINT delete_2022_animals;


UPDATE animals
SET weight_kg = weight_kg * -1;


ROLLBACK TO delete_2022_animals;


UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;


COMMIT;


SELECT COUNT(id)
FROM animals;


SELECT COUNT(id)
FROM animals
WHERE escape_attempts = 0;


SELECT AVG(weight_kg)
FROM animals;


SELECT neutered,
       SUM(escape_attempts)
FROM animals
GROUP BY neutered;


SELECT species,
       MIN(weight_kg),
       MAX(weight_kg)
FROM animals
GROUP BY species;


SELECT AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';


SELECT name
FROM animals
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';


SELECT animals.name
FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


SELECT full_name,
       name
FROM owners
LEFT JOIN animals ON owners.id = animals.owners_id;


SELECT species.name,
       COUNT(*)
FROM animals
LEFT JOIN species ON animals.species_id = species.id
GROUP BY species.name
SELECT name
FROM animals
JOIN owners ON owners.id = animals.owners_id
WHERE owners.full_name = 'Jennifer Orwell'
  AND animals.species_id = 2;


SELECT name
FROM animals
JOIN owners on owners.id = animals.owners_id
WHERE animals.escape_attempts = 0
  AND owners.full_name LIKE '%Dean%';


SELECT owners.full_name,
       COUNT(animals.owners_id)
FROM owners
JOIN animals ON owners.id = animals.owners_id
GROUP BY owners.full_name;

-- Who was the last animal seen by William Tatcher?

SELECT animals.name,
       date_of_visit
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT animals.name
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY animals.name;

-- List all vets and their specialties, including vets with no specialties.

SELECT vets.name,
       species.name
from specializations s
FULL JOIN vets ON s.vet_id = vets.id
FULL JOIN species ON species.id = s.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT vets.name AS "Vet",
       animals.name as "Animal",
       date_of_visit as "Visits"
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez'
  AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?

SELECT animals.name as "Animal",
       COUNT(date_of_visit) AS "Visits"
FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(date_of_visit) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
 
SELECT animals.name AS "Animal", 
       vets.name as "Vet", 
       date_of_visit AS "Visit"
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id 
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit
LIMIT 1; -- Details for most recent visit: animal information, vet information, and date of visit.


SELECT vets.*,
       animals.*,
       date_of_visit
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*)
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE animals.species_id NOT IN
    (SELECT species_id
     FROM specializations
     WHERE vet_id = vets.id );

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name,
       COUNT(*)
FROM visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name;

-- Explain analyze
EXPLAIN ANALYZE
SELECT COUNT(*)
FROM visits
where animal_id = 4;

-- Third query Optimization
EXPLAIN ANALYZE SELECT vets_id FROM visits WHERE vets_id=2;

-- Third query Optimization
EXPLAIN ANALYZE SELECT * FROM owners WHERE id=18333;