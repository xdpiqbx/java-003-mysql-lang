CREATE TABLE worker (
    id INT PRIMARY KEY, -- сурогатний? первинний ключ
    name VARCHAR(1000) NOT NULL, -- довжина має бути від 2 до 1000 символів включно? Як вказати діапазон?
    birthday DATE,  -- INTERVAL?? Рік у цій даті має бути більшим за 1900
    level ENUM ('Trainee', 'Junior', 'Middle', 'Senior'),
    salary INT
);

CREATE TABLE client (
    id INT PRIMARY KEY, -- сурогатний? первинний ключ
    name VARCHAR(1000) NOT NULL -- довжина має бути від 2 до 1000 символів включно? Як вказати діапазон?
);

CREATE TABLE project (
    id INT PRIMARY KEY, -- сурогатний? первинний ключ
    client_id INT,
    start_date DATE,  -- INTERVAL?? Рік у цій даті має бути більшим за 1900
    finish_date DATE  -- INTERVAL?? Рік у цій даті має бути більшим за 1900
);

CREATE TABLE project_worker (
    project_id INT,
    worker_id INT
    -- первинний ключ для цієї таблиці - складений, пара (PROJECT_ID, WORKER_ID)
);