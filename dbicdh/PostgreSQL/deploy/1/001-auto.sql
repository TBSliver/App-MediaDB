-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Mon Jun  1 01:55:32 2015
-- 
;
--
-- Table: movies
--
CREATE TABLE "movies" (
  "id" serial NOT NULL,
  "title" text NOT NULL,
  PRIMARY KEY ("id")
);

;
--
-- Table: users
--
CREATE TABLE "users" (
  "id" serial NOT NULL,
  "ra_user" integer NOT NULL,
  "email" character varying(50) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "users_email" UNIQUE ("email"),
  CONSTRAINT "users_ra_user" UNIQUE ("ra_user")
);

;
--
-- Table: locations
--
CREATE TABLE "locations" (
  "id" serial NOT NULL,
  "name" text NOT NULL,
  "admin_id" integer NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "locations_idx_admin_id" on "locations" ("admin_id");

;
--
-- Table: user_locations
--
CREATE TABLE "user_locations" (
  "id" serial NOT NULL,
  "user_id" integer NOT NULL,
  "location_id" integer NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "user_locations_user_id_location_id" UNIQUE ("user_id", "location_id")
);
CREATE INDEX "user_locations_idx_location_id" on "user_locations" ("location_id");
CREATE INDEX "user_locations_idx_user_id" on "user_locations" ("user_id");

;
--
-- Table: user_movies
--
CREATE TABLE "user_movies" (
  "id" serial NOT NULL,
  "user_id" integer NOT NULL,
  "movie_id" integer NOT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "user_movies_idx_movie_id" on "user_movies" ("movie_id");
CREATE INDEX "user_movies_idx_user_id" on "user_movies" ("user_id");

;
--
-- Table: movie_locations
--
CREATE TABLE "movie_locations" (
  "movie_id" integer NOT NULL,
  "location_id" integer NOT NULL,
  CONSTRAINT "movie_locations_movie_id" UNIQUE ("movie_id")
);
CREATE INDEX "movie_locations_idx_location_id" on "movie_locations" ("location_id");
CREATE INDEX "movie_locations_idx_movie_id" on "movie_locations" ("movie_id");

;
--
-- Foreign Key Definitions
--

;
ALTER TABLE "locations" ADD CONSTRAINT "locations_fk_admin_id" FOREIGN KEY ("admin_id")
  REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "user_locations" ADD CONSTRAINT "user_locations_fk_location_id" FOREIGN KEY ("location_id")
  REFERENCES "locations" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "user_locations" ADD CONSTRAINT "user_locations_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "user_movies" ADD CONSTRAINT "user_movies_fk_movie_id" FOREIGN KEY ("movie_id")
  REFERENCES "movies" ("id") ON DELETE CASCADE DEFERRABLE;

;
ALTER TABLE "user_movies" ADD CONSTRAINT "user_movies_fk_user_id" FOREIGN KEY ("user_id")
  REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "movie_locations" ADD CONSTRAINT "movie_locations_fk_location_id" FOREIGN KEY ("location_id")
  REFERENCES "locations" ("id") ON DELETE CASCADE ON UPDATE CASCADE DEFERRABLE;

;
ALTER TABLE "movie_locations" ADD CONSTRAINT "movie_locations_fk_movie_id" FOREIGN KEY ("movie_id")
  REFERENCES "user_movies" ("id") ON DELETE CASCADE DEFERRABLE;

;
