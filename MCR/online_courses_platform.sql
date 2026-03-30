-- ============================================================
--   ПЛАТФОРМА ОНЛАЙН-КУРСІВ
-- ============================================================

-- ============================================================
-- 1. СХЕМА БАЗИ ДАНИХ
-- ============================================================

-- Викладачі: облікові дані, біографія, спеціалізація
CREATE TABLE instructors (
    instructor_id   SERIAL PRIMARY KEY,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(255) NOT NULL UNIQUE,
    biography       TEXT,
    specialization  VARCHAR(200)
);

-- Студенти: контактна інформація, дата реєстрації
CREATE TABLE students (
    student_id    SERIAL PRIMARY KEY,
    first_name    VARCHAR(100) NOT NULL,
    last_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(255) NOT NULL UNIQUE,
    phone         VARCHAR(30),
    registered_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Курси: назва, опис, ціна, категорія
CREATE TABLE courses (
    course_id     SERIAL PRIMARY KEY,
    instructor_id INT NOT NULL REFERENCES instructors(instructor_id),
    title         VARCHAR(255) NOT NULL,
    description   TEXT,
    price         NUMERIC(10,2) NOT NULL,
    category      VARCHAR(100) NOT NULL
);

-- Уроки: належать до курсу, впорядковані через поле position
CREATE TABLE lessons (
    lesson_id    SERIAL PRIMARY KEY,
    course_id    INT NOT NULL REFERENCES courses(course_id),
    title        VARCHAR(255) NOT NULL,
    position     INT NOT NULL,
    duration_min INT
);

-- Реєстрації: зв'язок студент-курс зі статусом завершення
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id    INT NOT NULL REFERENCES students(student_id),
    course_id     INT NOT NULL REFERENCES courses(course_id),
    enrolled_at   TIMESTAMP NOT NULL DEFAULT NOW(),
    status        VARCHAR(20) NOT NULL DEFAULT 'active'
                  CHECK (status IN ('active', 'completed', 'dropped')),
    UNIQUE (student_id, course_id)
);

-- Прогрес по урокам: відстежує які уроки студент завершив
CREATE TABLE lesson_progress (
    progress_id   SERIAL PRIMARY KEY,
    enrollment_id INT NOT NULL REFERENCES enrollments(enrollment_id),
    lesson_id     INT NOT NULL REFERENCES lessons(lesson_id),
    is_completed  BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE (enrollment_id, lesson_id)
);


-- ============================================================
-- 2. ТЕСТОВІ ДАНІ
-- ============================================================

INSERT INTO instructors (first_name, last_name, email, biography, specialization) VALUES
('Олена',  'Коваль',   'o.koval@edu.ua',  'Розробник Python, 10 років досвіду.', 'Python, Data Science'),
('Ігор',   'Мельник',  'i.melnyk@edu.ua', 'Full-stack розробник React/Node.',    'JavaScript'),
('Тетяна', 'Бондар',   't.bondar@edu.ua', 'UX-дизайнер, 50+ проєктів.',         'UI/UX, Figma'),
('Василь', 'Грищенко', 'v.grysch@edu.ua', 'MBA, консультант з менеджменту.',    'Менеджмент'),
('Наталія','Шевченко', 'n.shev@edu.ua',   'ML-інженер, PhD.',                   'Machine Learning');

INSERT INTO students (first_name, last_name, email, phone) VALUES
('Андрій', 'Ткаченко',  'a.tkach@gmail.com',  '+380501112233'),
('Марія',  'Іванова',   'm.ivan@gmail.com',   '+380672223344'),
('Сергій', 'Пилипенко', 's.pylyp@gmail.com',  '+380633334455'),
('Оксана', 'Романчук',  'o.roman@gmail.com',  '+380444445566'),
('Денис',  'Захаренко', 'd.zakh@gmail.com',   '+380955556677');

INSERT INTO courses (instructor_id, title, description, price, category) VALUES
(1, 'Python для початківців',  'Базовий курс Python.',          499.00, 'Програмування'),
(1, 'Аналіз даних з Pandas',   'Обробка та візуалізація даних.',799.00, 'Data Science'),
(2, 'React: від нуля до джуна','Практичний курс з React.js.',   649.00, 'Програмування'),
(3, 'UI/UX Design з Figma',    'Проєктування інтерфейсів.',     549.00, 'Дизайн'),
(4, 'Основи менеджменту',      'Agile, Scrum, управління.',     399.00, 'Бізнес'),
(5, 'Machine Learning з нуля', 'Алгоритми ML на Python.',       899.00, 'Data Science'),
(3, 'Графічний дизайн',        'Логотипи, брендинг.',           449.00, 'Дизайн'),
(2, 'Node.js та REST API',     'Серверна розробка.',            599.00, 'Програмування');

INSERT INTO lessons (course_id, title, position, duration_min) VALUES
(1, 'Встановлення Python',    1, 15),
(1, 'Змінні та типи даних',   2, 25),
(1, 'Функції в Python',       3, 35),
(2, 'Вступ до Pandas',        1, 20),
(2, 'DataFrame та Series',    2, 30),
(3, 'JSX та компоненти',      1, 25),
(3, 'useState та useEffect',  2, 40);

INSERT INTO enrollments (student_id, course_id, status) VALUES
(1, 1, 'completed'),
(1, 3, 'active'),
(1, 5, 'active'),
(2, 1, 'completed'),
(2, 2, 'active'),
(3, 1, 'active'),
(3, 3, 'active'),
(3, 4, 'active'),
(4, 4, 'completed'),
(4, 5, 'active'),
(5, 6, 'completed'),
(5, 2, 'active');

INSERT INTO lesson_progress (enrollment_id, lesson_id, is_completed) VALUES
(1, 1, TRUE), (1, 2, TRUE), (1, 3, TRUE),
(4, 1, TRUE), (4, 2, TRUE), (4, 3, FALSE);


-- ============================================================
-- 3. OLTP ЗАПИТИ
-- ============================================================

-- INSERT 1: Додати нового студента
INSERT INTO students (first_name, last_name, email, phone)
VALUES ('Максим', 'Борисенко', 'm.borys2@gmail.com', '+380507778899');

-- INSERT 2: Зареєструвати студента на курс
INSERT INTO enrollments (student_id, course_id, status)
VALUES (6, 1, 'active');

-- UPDATE 1: Позначити реєстрацію як завершену
UPDATE enrollments
SET status = 'completed'
WHERE student_id = 6 AND course_id = 1;

-- UPDATE 2: Змінити ціну курсу
UPDATE courses
SET price = 399.00
WHERE course_id = 1;

-- DELETE 1: Видалити реєстрацію студента
DELETE FROM enrollments
WHERE student_id = 6 AND course_id = 1;

-- DELETE 2: Видалити студента
DELETE FROM students
WHERE email = 'm.borys2@gmail.com';

-- SELECT 1: Знайти всі курси конкретного викладача за іменем
SELECT c.course_id, c.title, c.price, c.category
FROM courses c
JOIN instructors i 
  ON i.instructor_id = c.instructor_id
WHERE i.first_name = 'Олена' AND i.last_name = 'Коваль';

-- SELECT 2: Знайти всіх студентів конкретного курсу
SELECT s.student_id, s.first_name, s.last_name, s.email, e.status
FROM students s
JOIN enrollments e 
  ON e.student_id = s.student_id
JOIN courses c 
  ON c.course_id = e.course_id
WHERE c.title = 'Python для початківців';


-- ============================================================
-- 4. OLAP ЗАПИТИ
-- ============================================================

-- OLAP 1: Середній рівень завершення курсів за категоріями
SELECT
    c.category,
    COUNT(e.enrollment_id) AS total_enrollments,
    ROUND(
        100.0 * SUM(CASE WHEN e.status = 'completed' THEN 1 ELSE 0 END)
              / COUNT(e.enrollment_id), 2
    ) AS completion_rate_pct
FROM courses c
JOIN enrollments e 
  ON e.course_id = c.course_id
GROUP BY c.category
ORDER BY completion_rate_pct DESC;

-- OLAP 2: Топ-5 викладачів за кількістю зареєстрованих студентів
SELECT
    i.first_name || ' ' || i.last_name AS instructor,
    i.specialization,
    COUNT(e.enrollment_id) AS total_students
FROM instructors i
JOIN courses c     
  ON c.instructor_id = i.instructor_id
JOIN enrollments e 
  ON e.course_id     = c.course_id
GROUP BY i.instructor_id, i.first_name, i.last_name, i.specialization
ORDER BY total_students DESC
LIMIT 5;

-- OLAP 3: Ранжування курсів за кількістю реєстрацій у межах категорії
SELECT
    c.category,
    c.title,
    COUNT(e.enrollment_id) AS enrollments,
    RANK() OVER (
        PARTITION BY c.category
        ORDER BY COUNT(e.enrollment_id) DESC
    ) AS rank_in_category
FROM courses c
LEFT JOIN enrollments e 
  ON e.course_id = c.course_id
GROUP BY c.category, c.course_id, c.title
ORDER BY c.category, rank_in_category;

-- OLAP 4: Студенти на кількох курсах але жодного не завершили 
WITH multi_enrolled AS (
    SELECT student_id
    FROM enrollments
    GROUP BY student_id
    HAVING COUNT(*) > 1
),
completed_any AS (
    SELECT DISTINCT student_id
    FROM enrollments
    WHERE status = 'completed'
)
SELECT
    s.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    s.email,
    COUNT(e.enrollment_id) AS courses_enrolled
FROM students s
JOIN enrollments e 
  ON e.student_id = s.student_id
WHERE s.student_id IN (SELECT student_id FROM multi_enrolled)
  AND s.student_id NOT IN (SELECT student_id FROM completed_any)
GROUP BY s.student_id, s.first_name, s.last_name, s.email
ORDER BY courses_enrolled DESC;
