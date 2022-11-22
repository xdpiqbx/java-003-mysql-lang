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

INSERT INTO department_worker (worker_id, department_id) VALUES
(1, 1),
(2, 3),
(3, 1)


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

SELECT * FROM worker
    JOIN department_worker
    ON worker.id = department_worker.worker_id
    WHERE department_id = 3

SELECT worker.* FROM worker -- взяти дані лише з таблиці worker
    JOIN department_worker
    ON worker.id = department_worker.worker_id
    WHERE department_id = 3

-- У якому департаменті найбільше людей
SELECT department_id, COUNT(worker_id)
    FROM department_worker
    GROUP BY department_id
    ORDER BY COUNT(worker_id) DESC
    LIMIT 1;

-- Не враховує якщо в декількох відділах однакова кількість робітників
SELECT * FROM department
WHERE id IN (
    SELECT department_id
        FROM department_worker
        GROUP BY department_id
        ORDER BY COUNT(worker_id) DESC
        LIMIT 1
);

--
SELECT department_id, COUNT(worker_id)
    FROM department_worker
    GROUP BY department_id
-- Після групування WHERE не можна, треба користуватись HAVING
    HAVING COUNT(worker_id) = 2

SELECT department_id, COUNT(worker_id)
    FROM department_worker
    GROUP BY department_id
-- Після групування WHERE не можна, треба користуватись HAVING
    HAVING COUNT(worker_id) IN (
        SELECT COUNT(worker_id)
            FROM department_worker
            GROUP BY department_id
            ORDER BY COUNT(worker_id) DESC
            LIMIT 1
    )

-- ТУТ враховує якщо в декількох відділах однакова кількість робітників
SELECT * FROM department
WHERE id IN(
    SELECT department_id
        FROM department_worker
        GROUP BY department_id
        HAVING COUNT(worker_id) IN (
            SELECT COUNT(worker_id)
                FROM department_worker
                GROUP BY department_id
                ORDER BY COUNT(worker_id) DESC
                LIMIT 1
        )
) -- ТУТ враховує якщо в декількох відділах однакова кількість робітників


-- Вибрати тих хто не працює у жодному відділі
-- або працюють у двох або більше відділах

SELECT department_id, COUNT(worker_id)
FROM department_worker
GROUP BY department_id

-- Працівники які ніде не працюють
SELECT *, 'Free' FROM worker
    WHERE id NOT IN (
        SELECT worker_id FROM department_worker
    )
UNION
-- Працівники які працюють в 2+ відділах
SELECT *, '2+ deps'
FROM worker
WHERE id IN (
    SELECT worker_id
    FROM department_worker
    GROUP BY worker_id
    HAVING COUNT(department_id) >= 2
)

-- Вибрати усіх у кого у імені або у прізвищі є літера А
SELECT * FROM worker
WHERE LOWER(first_name) LIKE '%a%' OR LOWER(last_name) LIKE '%a'