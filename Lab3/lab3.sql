-- Лабораторна робота 3: Маніпулювання даними (OLTP)

-- Додавання даних (INSERT) до 5 рядків
INSERT INTO STUDENT (student_card_id, full_name, faculty, email) VALUES 
(202404, 'Олександр Усик', 'ФІОТ', 'usik.o@kpi.ua'),
(202405, 'Марія Кюрі', 'ФІОТ', 'marie.c@kpi.ua');

INSERT INTO LOAN (student_card_id, book_id, issue_date) VALUES 
(202404, 'ISBN-001', '2026-02-24'),
(202405, 'ISBN-002', '2026-02-24');

-- Оновлення (UPDATE) - проставляємо дату повернення
UPDATE LOAN 
SET return_date = '2026-02-25' 
WHERE student_card_id = 202401 AND book_id = 'ISBN-002';

-- Видалення (DELETE) тестового запису
DELETE FROM LOAN WHERE student_card_id = 202403 AND book_id = 'ISBN-003';

-- Фінальна перевірка
SELECT * FROM STUDENT;
SELECT * FROM LOAN;
