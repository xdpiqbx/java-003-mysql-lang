CREATE TABLE worker (
    id IDENTITY PRIMARY KEY,
    name VARCHAR(1000) NOT NULL, -- довжина має бути від 2 до 1000 символів включно
    birthday DATE NOT NULL,  -- Рік у цій даті має бути більшим за 1900
    level ENUM ('Trainee', 'Junior', 'Middle', 'Senior'),
    salary INT NOT NULL,
    CHECK (EXTRACT(YEAR FROM birthday) > 1900),
    CHECK (CHAR_LENGTH(name) > 1 AND CHAR_LENGTH(name) < 1000)
);
ALTER TABLE worker
    ALTER COLUMN birthday TIMESTAMP NOT NULL

CREATE TABLE client (
    id IDENTITY PRIMARY KEY,
    name VARCHAR(1000) NOT NULL -- довжина має бути від 2 до 1000 символів включно
    CHECK (CHAR_LENGTH(name) > 1 AND CHAR_LENGTH(name) < 1000)
);

CREATE TABLE project (
    id IDENTITY PRIMARY KEY,
    client_id BIGINT NOT NULL,
    start_date TIMESTAMP, -- Рік у цій даті має бути більшим за 1900
    finish_date TIMESTAMP, -- Рік у цій даті має бути більшим за 1900
    FOREIGN KEY (client_id)
        REFERENCES client(id),
    CHECK (
        EXTRACT(YEAR FROM start_date) > 1900
        AND
        EXTRACT(YEAR FROM finish_date) > 1900
    )
);

CREATE TABLE project_worker (
    project_id BIGINT NOT NULL,
    worker_id BIGINT NOT NULL,
    PRIMARY KEY (project_id, worker_id),
    FOREIGN KEY (project_id)
        REFERENCES project(id),
    FOREIGN KEY (worker_id)
        REFERENCES worker(id)
);