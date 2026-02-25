# Лабораторна робота №6 | Міграції

Цей файл документує зміни, внесені до схеми бази даних (`schema.prisma`) в рамках лабораторної роботи №6.

## 1. Додавання нової таблиці (Review)

**Опис:** Створено нову модель `Review` для зберігання відгуків користувачів на книги. 

Встановлено зв'язки:
* Одна книга (`book`) може мати багато відгуків (`Review`).

**Зміни в `schema.prisma`:**

```prisma
// НОВА МОДЕЛЬ
model Review {
  id        Int      @id @default(autoincrement())
  rating    Int
  comment   String?
  book_id   String
  book      book     @relation(fields: [book_id], references: [book_id])
}

// ОНОВЛЕННЯ ІСНУЮЧОЇ МОДЕЛІ
model book {
  book_id      String   @id @db.VarChar(50)
  // ... інші поля
  Review       Review[] // Зворотній зв'язок
}
```

## 2. Модифікація таблиці student
Додано нове необов'язкове поле phone для розширення контактних даних користувачів.

**Попередня структура:**
```prisma
model student {
  student_card_id Int    @id
  full_name       String @db.VarChar(255)
  email           String @unique @db.VarChar(150)
}
```

**Оновлена структура:**

```prisma
 model student {
  student_card_id Int    @id
  full_name       String @db.VarChar(255)
  email           String @unique @db.VarChar(150)
  phone           String? // Нове поле (Optional)
  loan            loan[]
}
```
---

## 3. Видалення стовпця з таблиці book

З метою оптимізації схеми було видалено поле category.


## 4. Перевірка та верифікація

Для підтвердження успішного застосування міграцій використано інструмент Prisma Studio.

Результати перевірки:

* Таблиця Review доступна для CRUD-операцій.
* Поле phone відображається в таблиці student зі значенням null для існуючих записів.
* Поле category повністю видалено з фізичної структури БД.
* Цілісність даних (Foreign Keys) збережена.
* Зміни зафіксовані в локальній папці prisma/migrations.

<img width="1920" height="534" alt="image" src="https://github.com/user-attachments/assets/597838f2-626e-4565-a0e3-e0fe3e02bf01" />
