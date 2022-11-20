CREATE TABLE project(
    id IDENTITY PRIMARY KEY,
    name VARCHAR (100),
    department_id BIGINT
);

CREATE TABLE department(
    id IDENTITY PRIMARY KEY,
    name VARCHAR (200),
    description VARCHAR (200)
);

ALTER TABLE project -- змінити таблицю project
    ADD CONSTRAINT department_id_fk -- додати обмеження - department_id_fk
    FOREIGN KEY (department_id) -- зовнішній ключ (з табл project)
    REFERENCES department(id) -- посилається на 'id' таблиці 'department'

ALTER TABLE project
    ALTER COLUMN department_id BIGINT NOT NULL

SHOW COLUMNS FROM project

CREATE TABLE worker(
    id IDENTITY PRIMARY KEY,
    first_name VARCHAR (100),
    last_name VARCHAR (100),
);

CREATE TABLE department_worker(
    worker_id BIGINT NOT NULL,
    department_id BIGINT NOT NULL,
    PRIMARY KEY (worker_id, department_id),
    FOREIGN KEY (worker_id)
        REFERENCES worker(id),
    FOREIGN KEY (department_id)
        REFERENCES department(id)
);

CREATE TABLE worker_details(
    worker_id BIGINT PRIMARY KEY,
    address VARCHAR (100),
    sex VARCHAR (10),
    FOREIGN KEY (worker_id)
        REFERENCES worker(id)
)

ALTER TABLE worker_details
    ADD CONSTRAINT sex_enum_values
    CHECK (sex IN ('male','female','unknown'))

ALTER TABLE worker_details
ALTER COLUMN sex VARCHAR(10) NOT NULL;

INSERT INTO worker (first_name, last_name) VALUES
    ('John', 'Snow'),
    ('Max', 'Dreamer'),
    ('Bill', 'Gates'),
    ('Elon', 'Musk')

INSERT INTO worker_details (worker_id, address, sex) VALUES
(1, 'Mexico', 'male'),
(2, 'Afgan', 'female'),
(3, 'France', 'unknown'),
(4, 'USA', 'female')

INSERT INTO department (name, description) VALUES
('Air defence', 'Protect from air attacs'),
('Ground defence', 'Protect from ground attacs'),
('Water defence', 'Protect from ground water')

INSERT INTO department_worker (worker_id, department_id) VALUES
(1, 3),
(2, 1),
(3, 2),
(4, 1)

INSERT INTO project (name, department_id) VALUES
('Cold Water', 1),
('Black Ice', 2),
('Random Air', 2),
('Business as is', 3);

-- --------------------------------------------------------------

SELECT * FROM worker
WHERE id IN (
    SELECT worker_id
    FROM worker_details
    WHERE sex='male'
)

-- JOIN (не заповнює NULL)
-- LEFT JOIN  (заповнює NULL)
SELECT * FROM worker
    JOIN worker_details -- обєднати таблиці worker та worker_details
        ON worker.id = worker_details.worker_id
    WHERE sex = 'male'