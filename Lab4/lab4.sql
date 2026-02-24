-- Лабораторна робота №4 | Аналітичні SQL-запити (OLAP)



-- БЛОК 1: Агрегатні функції та групування

-- 1. Загальна кількість студентів
SELECT COUNT(*) AS total_students 
FROM STUDENT;

-- 2. Знаходження найстарішої та найновішої книги
SELECT MIN(publish_year) AS oldest_book, MAX(publish_year) AS newest_book 
FROM BOOK;

-- 3. Кількість студентів на кожному факультеті
SELECT faculty, COUNT(*) AS students_count 
FROM STUDENT 
GROUP BY faculty;

-- 4. Книги, які видавали більше одного разу (фільтрація груп)
SELECT book_id, COUNT(*) AS loan_count 
FROM LOAN 
GROUP BY book_id 
HAVING COUNT(*) > 1;




-- БЛОК 2: Об'єднання таблиць (JOIN)

-- 5. INNER JOIN: ПІБ студентів та дати видачі їм книг
SELECT s.full_name, l.issue_date 
FROM STUDENT s
INNER JOIN LOAN l ON s.student_card_id = l.student_card_id;

-- 6. LEFT JOIN: Всі книги та дати їх видачі (навіть якщо ще не видавались)
SELECT b.title, l.issue_date, l.return_date
FROM BOOK b
LEFT JOIN LOAN l ON b.book_id = l.book_id;

-- 7. Багатотабличний JOIN: ПІБ студента, назва книги та дата видачі
SELECT s.full_name, b.title, l.issue_date 
FROM STUDENT s 
JOIN LOAN l ON s.student_card_id = l.student_card_id 
JOIN BOOK b ON l.book_id = b.book_id;




-- БЛОК 3: Підзапити (Subqueries)

-- 8. Підзапит у WHERE: Назви книг, які хоча б раз брали студенти
SELECT title 
FROM BOOK 
WHERE book_id IN (SELECT book_id FROM LOAN);

-- 9. Підзапит у SELECT: Підрахунок кількості взятих книг для кожного студента
SELECT full_name, 
       (SELECT COUNT(*) FROM LOAN l WHERE l.student_card_id = s.student_card_id) AS books_taken 
FROM STUDENT s;

-- 10. Підзапит у WHERE: Студенти, які брали книги після 20 лютого
SELECT full_name, email 
FROM STUDENT 
WHERE student_card_id IN (SELECT student_card_id FROM LOAN WHERE issue_date >= '2026-02-20');
