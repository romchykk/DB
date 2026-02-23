-- ==========================================
-- Лабораторна робота 2: DDL та DML скрипти
-- Предметна область: Студентська бібліотека
-- ==========================================

-- Створення таблиць (DDL)

CREATE TABLE AUTHOR (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE STUDENT (
    student_card_id INTEGER PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    faculty VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE BOOK (
    book_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    publish_year INTEGER CHECK (publish_year > 0),
    author_id INTEGER NOT NULL REFERENCES AUTHOR(author_id) ON DELETE CASCADE
);

CREATE TABLE LOAN (
    loan_id SERIAL PRIMARY KEY,
    student_card_id INTEGER NOT NULL REFERENCES STUDENT(student_card_id),
    book_id VARCHAR(50) NOT NULL REFERENCES BOOK(book_id) ON DELETE CASCADE,
    issue_date DATE NOT NULL DEFAULT CURRENT_DATE,
    return_date DATE,
    CONSTRAINT check_dates CHECK (return_date >= issue_date)
);

-- Наповнення даними (DML)

INSERT INTO AUTHOR (name) VALUES 
('Тарас Шевченко'), 
('Роберт Мартін'), 
('Джоан Роулінг');

INSERT INTO STUDENT (student_card_id, full_name, faculty, email) VALUES 
(202401, 'Роман Петренко', 'ФІОТ', 'roma.p@kpi.ua'),