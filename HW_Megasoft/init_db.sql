CREATE TABLE worker (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(1000), -- довжина має бути від 2 до 1000 символів включно
    birthday DATE,  -- Рік у цій даті має бути більшим за 1900
    level ENUM ('Trainee', 'Junior', 'Middle', 'Senior'),
    salary INT,
    CHECK (EXTRACT(YEAR FROM birthday) > 1900),
    CHECK (CHAR_LENGTH(name) > 1 AND CHAR_LENGTH(name) < 1000)
);

-- Test valid values
# INSERT INTO worker
#     (name, birthday, level, salary)
# VALUES
#     ('Bill', '1981-01-25', 'Trainee', 800),
#     ('John', '1985-10-14', 'Junior', 850),
#     ('Mary', '1989-02-10', 'Middle', 1100),
#     ('Adam', '1991-11-01', 'Senior', 1900)

-- Test invalid values
# INSERT INTO worker
#     (name, birthday, level, salary)
# VALUES
#     ('Duncan', '1900-01-25', 'Senior', 800)
--
# INSERT INTO worker
#     (name, birthday, level, salary)
# VALUES
#     ('A', '1901-01-01', 'Senior', 800)
--
# INSERT INTO worker
#     (name, birthday, level, salary)
# VALUES
#     ('Steve', '1981-01-25', 'Batman', 800)


CREATE TABLE client (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(1000) NOT NULL -- довжина має бути від 2 до 1000 символів включно
    CHECK (CHAR_LENGTH(name) > 1 AND CHAR_LENGTH(name) < 1000)
);

CREATE TABLE project (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    start_date TIMESTAMP,  -- Рік у цій даті має бути більшим за 1900
    finish_date TIMESTAMP  -- Рік у цій даті має бути більшим за 1900
    CHECK (
        EXTRACT(YEAR FROM start_date) > 1900
        AND
        EXTRACT(YEAR FROM finish_date) > 1900
    )
);

CREATE TABLE project_worker (
    project_id INT,
    worker_id INT
    -- первинний ключ для цієї таблиці - складений, пара (PROJECT_ID, WORKER_ID)
);