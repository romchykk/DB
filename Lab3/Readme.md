# Лабораторна робота №3 | Маніпулювання даними SQL (OLTP)

### Мета роботи
Тестування бази даних шляхом виконання запитів у стилі транзакцій (OLTP). Практичне застосування основних операцій маніпулювання даними (DML) у PostgreSQL: `SELECT`, `INSERT`, `UPDATE` та `DELETE`.

### База даних складається з наступних таблиць:

* **AUTHOR** (`author_id` [PK], `name`)
* **STUDENT** (`student_card_id` [PK], `full_name`, `faculty`, `email`)
* **BOOK** (`book_id` [PK], `title`, `category`, `publish_year`, `author_id` [FK])
* **LOAN** (`loan_id` [PK], `student_card_id` [FK], `book_id` [FK], `issue_date`, `return_date`) - *асоціативна таблиця, що фіксує видачу книг студентам.*

### Виконані операції маніпулювання даними

Згідно з вимогами, базу даних було протестовано наступними запитами:
1. **INSERT:** Додано нові рядки в таблиці `STUDENT` та `LOAN`, щоб кожна таблиця містила щонайменше 5 записів.
2. **UPDATE:** Змінено існуючі дані з використанням речення `WHERE` (зафіксовано факт повернення книги студентом шляхом проставлення `return_date`).
3. **DELETE:** Виконано безпечне видалення тестового запису з використанням речення `WHERE`.
4. **SELECT:** Виконано вибірку даних для перевірки результатів змін.

### Результати виконання 
Нижче наведено скриншоти результатів, в тому числі й фінального запиту `SELECT * FROM LOAN;`, який підтверджує успішне додавання 5 рядків та оновлення поля `return_date`:

<img width="822" height="278" alt="image" src="https://github.com/user-attachments/assets/ac2c37a6-76b6-455d-a481-b3feacb25650" />
<img width="1252" height="358" alt="image" src="https://github.com/user-attachments/assets/f1ed5c4e-2247-4c72-92e8-29ca16391453" />
<img width="1243" height="399" alt="image" src="https://github.com/user-attachments/assets/c83dcba5-34ac-4c51-a6c9-d6f8c7c29685" />
