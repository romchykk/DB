# Лабораторна робота №4 | Аналітичні SQL-запити (OLAP)

### Мета роботи
Написання аналітичних SQL-запитів для існуючої схеми бази даних Бібліотеки. Використання агрегатних функцій, об'єднань (JOIN) та підзапитів для підсумовування тенденцій та створення звітів.

---

### Блок 1: Базова агрегація та групування даних

Написано 4 запити з використанням агрегатних функцій (`COUNT`, `MIN`, `MAX`) та групування (`GROUP BY`, `HAVING`):

* **Підрахунок студентів:** Визначає загальну кількість зареєстрованих читачів.
* **Аналіз фонду:** Знаходить найстарішу та найновішу книгу в бібліотеці.
* **Статистика факультетів:** Рахує кількість студентів на кожному факультеті.
* **Популярні книги:** Фільтрує книги, які брали почитати більше одного разу (використання `HAVING`).

**Результат роботи фільтрації (HAVING):**

<img width="1240" height="735" alt="image" src="https://github.com/user-attachments/assets/1f5e650d-0ef3-4f64-8a8c-7e9269c81b45" />
<img width="1235" height="701" alt="image" src="https://github.com/user-attachments/assets/3cd3cc65-2317-46ca-924f-68b77bfdbb71" />
<img width="1232" height="740" alt="image" src="https://github.com/user-attachments/assets/3d12848c-e0c3-46fe-86bd-4151c04f7644" />
<img width="1241" height="731" alt="image" src="https://github.com/user-attachments/assets/12a33449-1123-425b-8408-c4433181fc80" />

---

### Блок 2: Запити JOIN (Об'єднання таблиць)

Написано 3 запити для об'єднання даних з кількох таблиць:

* **INNER JOIN:** Виводить ПІБ студентів та дати видачі їм книг.
* **LEFT JOIN:** Показує весь каталог книг (`BOOK`) та інформацію про їх видачу (навіть якщо книгу ще ніхто не брав).
* **Багатотаблична агрегація:** Об'єднує таблиці `STUDENT`, `LOAN` та `BOOK`, щоб показати, який конкретно студент взяв яку саме книгу.

**Результат об'єднання трьох таблиць:**

<img width="1242" height="759" alt="image" src="https://github.com/user-attachments/assets/3dee1ce6-e3f9-48e3-8e17-553c1257d994" />
<img width="1239" height="730" alt="image" src="https://github.com/user-attachments/assets/81d33271-3bce-42fd-8dc7-bc2509e84255" />
<img width="1235" height="735" alt="image" src="https://github.com/user-attachments/assets/a786319b-f5f7-4b52-bd5d-654197b124b7" />

---

### Блок 3: Підзапити (Subqueries)

Написано 3 запити з використанням вкладених конструкцій:

* **Підзапит у WHERE (з IN):** Шукає назви книг, які хоча б раз видавалися.
* **Підзапит у SELECT:** Виводить список студентів і поруч динамічно підраховує кількість взятих кожним студентом книг.
* **Підзапит у WHERE:** Знаходить студентів, які брали книги після певної дати.

**Результат підзапиту в SELECT (підрахунок книг):**

<img width="1238" height="740" alt="image" src="https://github.com/user-attachments/assets/f62cd395-38e9-4c45-b467-da1871a42a87" />
<img width="1238" height="727" alt="image" src="https://github.com/user-attachments/assets/0b73a67e-2743-4a2c-9a8a-f28f2db8e9b0" />
<img width="1231" height="733" alt="image" src="https://github.com/user-attachments/assets/f9d7a10e-4682-4d4b-9158-13ad8b695298" />

