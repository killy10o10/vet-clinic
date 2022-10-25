CREATE TABLE "animals"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "escape_attempts" INTEGER NOT NULL,
    "neutered" BOOLEAN NOT NULL,
    "weight_kg" INTEGER NOT NULL,
    "species_id" INTEGER NOT NULL,
    "owner_id" INTEGER NOT NULL
);
ALTER TABLE
    "animals" ADD PRIMARY KEY("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_species_id_unique" UNIQUE("species_id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_owner_id_unique" UNIQUE("owner_id");
CREATE TABLE "owners"(
    "id" INTEGER NOT NULL,
    "full_name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "email" VARCHAR(255) NULL
);
ALTER TABLE
    "owners" ADD PRIMARY KEY("id");
CREATE TABLE "visits"(
    "animals_id" INTEGER NULL,
    "vets_id" INTEGER NULL,
    "date_of_visit" INTEGER NULL
);
CREATE INDEX "visits_animals_id_vets_id_index" ON
    "visits"("animals_id", "vets_id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_animals_id_unique" UNIQUE("animals_id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_vets_id_unique" UNIQUE("vets_id");
CREATE TABLE "species"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "species" ADD PRIMARY KEY("id");
CREATE TABLE "specializations"(
    "species_id" INTEGER NULL,
    "vet_id" INTEGER NULL
);
CREATE INDEX "specializations_species_id_vet_id_index" ON
    "specializations"("species_id", "vet_id");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_species_id_unique" UNIQUE("species_id");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_vet_id_unique" UNIQUE("vet_id");
CREATE TABLE "vets"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "date_of_graduation" DATE NOT NULL
);
ALTER TABLE
    "vets" ADD PRIMARY KEY("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_animals_id_foreign" FOREIGN KEY("animals_id") REFERENCES "animals"("id");
ALTER TABLE
    "animals" ADD CONSTRAINT "animals_owner_id_foreign" FOREIGN KEY("owner_id") REFERENCES "owners"("id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_animals_id_foreign" FOREIGN KEY("animals_id") REFERENCES "vets"("id");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "vets"("id");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "species"("id");