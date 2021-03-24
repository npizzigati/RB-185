CREATE TABLE list(
  id serial PRIMARY KEY,
  name text UNIQUE NOT NULL);
CREATE TABLE todo(
  id serial PRIMARY KEY,
  name text NOT NULL,
  completed boolean DEFAULT false,
  list_id int NOT NULL REFERENCES list(id);
