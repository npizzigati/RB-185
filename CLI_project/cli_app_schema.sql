CREATE TABLE expenses(
  id serial PRIMARY KEY,
  amount decimal(8,2) NOT NULL,
  memo text,
  created_on timestamp DEFAULT now());
