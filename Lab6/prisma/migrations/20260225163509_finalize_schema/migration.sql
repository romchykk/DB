-- CreateTable
CREATE TABLE "author" (
    "author_id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "author_pkey" PRIMARY KEY ("author_id")
);

-- CreateTable
CREATE TABLE "book" (
    "book_id" VARCHAR(50) NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "publish_year" INTEGER,
    "author_id" INTEGER NOT NULL,

    CONSTRAINT "book_pkey" PRIMARY KEY ("book_id")
);

-- CreateTable
CREATE TABLE "loan" (
    "loan_id" SERIAL NOT NULL,
    "student_card_id" INTEGER NOT NULL,
    "book_id" VARCHAR(50) NOT NULL,
    "issue_date" DATE NOT NULL DEFAULT CURRENT_DATE,
    "return_date" DATE,

    CONSTRAINT "loan_pkey" PRIMARY KEY ("loan_id")
);

-- CreateTable
CREATE TABLE "student" (
    "student_card_id" INTEGER NOT NULL,
    "full_name" VARCHAR(255) NOT NULL,
    "faculty" VARCHAR(100) NOT NULL,
    "email" VARCHAR(150) NOT NULL,
    "phone" TEXT,

    CONSTRAINT "student_pkey" PRIMARY KEY ("student_card_id")
);

-- CreateTable
CREATE TABLE "Review" (
    "id" SERIAL NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "book_id" TEXT NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "student_email_key" ON "student"("email");

-- AddForeignKey
ALTER TABLE "book" ADD CONSTRAINT "book_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "author"("author_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "loan" ADD CONSTRAINT "loan_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "book"("book_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "loan" ADD CONSTRAINT "loan_student_card_id_fkey" FOREIGN KEY ("student_card_id") REFERENCES "student"("student_card_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "book"("book_id") ON DELETE RESTRICT ON UPDATE CASCADE;
