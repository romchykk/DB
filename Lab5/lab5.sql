-- Лабораторна робота №5 | Нормалізація бази даних
-- Фінальна схема у 3NF (Третя нормальна форма)


-- 1. Видалення старих таблиць (якщо вони існують), щоб уникнути помилок при перестворенні
DROP TABLE IF EXISTS LOAN CASCADE;
DROP TABLE IF EXISTS BOOK CASCADE;
DROP TABLE IF EXISTS STUDENT CASCADE;
DROP TABLE IF EXISTS AUTHOR CASCADE;

-- 2. Створення нових нормалізованих таблиць (3NF)

-- Таблиця авторів (нова сутність, яка усунула транзитивну залежність)
CREATE TABLE AUTHOR (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Таблиця студентів (без змін, відповідає 3NF)
CREATE TABLE STUDENT (
    student_card_id INTEGER PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    faculty VARCHAR(100),
    email VARCHAR(150)
);

-- Таблиця книг (тепер посилається на автора через зовнішній ключ author_id)
CREATE TABLE BOOK (
    book_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    publish_year INTEGER,
    author_id INTEGER REFERENCES AUTHOR(author_id)
);

-- Асоціативна таблиця видачі книг (зв'язує студентів і книги)
CREATE TABLE LOAN (
    loan_id SERIAL PRIMARY KEY,
    student_card_id INTEGER REFERENCES STUDENT(student_card_id),
    book_id VARCHAR(50) REFERENCES BOOK(book_id),
    issue_date DATE NOT NULL,
    return_date DATE
);
