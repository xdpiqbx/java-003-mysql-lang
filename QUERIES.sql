-- https://www.h2database.com/html/commands.html

-- Create table (DDL)
CREATE TABLE people (
    name VARCHAR(100) PRIMARY KEY,
    age INT
);

CREATE TABLE simple_boolean (
    val BOOLEAN
);

CREATE TABLE money (
    name VARCHAR(100) PRIMARY KEY,
    amount NUMERIC(10, 2) -- 10 чисел до коми і 2 числа після коми
);

CREATE TABLE birthday (
    name VARCHAR(100) PRIMARY KEY,
    birthday DATE -- DATE - ISO 8601
);

CREATE TABLE event (
    name VARCHAR(100) PRIMARY KEY,
    start_at TIMESTAMP,
    finish_at TIMESTAMP
);

CREATE TABLE notebook (
    name VARCHAR(100) PRIMARY KEY,
    price NUMERIC(10, 2), -- 10 чисел до коми і 2 числа після коми
    config JSON
);

-- alter table (DDL)
ALTER TABLE notebook
ADD COLUMN
    (sold BOOLEAN DEFAULT false);

ALTER TABLE notebook
ALTER COLUMN sold INT;

-- Drop table (DDL)
DROP TABLE people;

-- insert into (DML)
INSERT INTO people (name, age)
VALUES ('John', 15), ('Max', 17);

INSERT INTO simple_boolean
VALUES (true), (false);

INSERT INTO money
    (name, amount)
VALUES
    ('Elon', 1000.25),
    ('Bill', 2000.55);

INSERT INTO birthday
    (name, birthday)
VALUES
    ('Max', '1990-04-20');

INSERT INTO event
    (name, start_at, finish_at)
VALUES
    ('Demo course', '2022-03-30T19:30:00', '2022-03-30T21:30:00')

INSERT INTO notebook
    (name, price, config)
VALUES
    ('HP', 1500, '{"country": "USA", "S/N": "XC7234"}');

-- Read all data (DML)
SELECT name, age FROM people;
SELECT DISTINCT age FROM people;
SELECT DISTINCT age*3 FROM people;
SELECT name, age FROM people WHERE age>20;
SELECT name, age FROM people OFFSET 2; --OFFSET - пропустити перші два вивести з третього
SELECT name, age FROM people LIMIT 1 OFFSET 1; --LIMIT 1 - вивести 1 запис
SELECT val FROM simple_boolean;
SELECT name, amount FROM money;
SELECT * FROM birthday;

SELECT price, sold
FROM notebook
WHERE sold = 0 AND price > 1000 AND name = 'HP'

-- UPDATE (DML)
UPDATE people SET age=17 WHERE name='John'
UPDATE notebook SET sold=true;

-- delete from (DML)
DELETE FROM people WHERE name='Max'