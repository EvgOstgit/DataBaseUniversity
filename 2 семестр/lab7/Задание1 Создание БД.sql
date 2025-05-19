CREATE TABLE Faculty.sgroup (
"КодГруппы" VARCHAR(20) NOT NULL PRIMARY KEY,
"НаправлениеПодготовки" VARCHAR(100),
"Профиль" VARCHAR(100),
"Курс" INT CHECK ("Курс" >= 1 AND "Курс" <= 5)
);

CREATE TABLE Faculty.student (
"НомерЗачетнойКнижки" CHAR(6) NOT NULL PRIMARY KEY CHECK ("НомерЗачетнойКнижки" ~ '^[0-9]{6}$'),
"Группа" VARCHAR(20),
"Фамилия" VARCHAR(100) NOT NULL,
"Имя" VARCHAR(100) NOT NULL,
"Отчество" VARCHAR(100),
"Пол" CHAR(1) CHECK ("Пол" IN ('м', 'ж')),
"ДатаРождения" DATE CHECK ("ДатаРождения" <= CURRENT_DATE),
"Адрес" VARCHAR(100) DEFAULT 'Неизвестно',
"Сотовый телефон" CHAR(12) CHECK ("Сотовый телефон" ~ '^\+7[0-9]{10}$'),
"Почта" VARCHAR(100),
"Год поступления" INT CHECK ("Год поступления" >= 1000 AND "Год поступления" < 10000),
"Проживает в общежитии" VARCHAR(3) NOT NULL DEFAULT 'нет' CHECK ("Проживает в общежитии" IN ('да', 'нет')),
CONSTRAINT fk_student_sgroup
	FOREIGN KEY ("Группа")
	REFERENCES Faculty.sgroup("КодГруппы")
	ON UPDATE CASCADE
);

CREATE TABLE Faculty.subject (
"Код дисциплины" SERIAL4 PRIMARY KEY,
"Название" VARCHAR(100) NOT NULL,
"Количество лекционных часов" INT NOT NULL CHECK ("Количество лекционных часов" >= 0),
"Количество практических часов" INT NOT NULL CHECK ("Количество практических часов" >= 0),
"Количество лабораторных часов" INT NOT NULL CHECK ("Количество лабораторных часов" >= 0),
"Общий объем часов" INT GENERATED ALWAYS AS
	("Количество лекционных часов" + 
	 "Количество практических часов" + 
	 "Количество лабораторных часов") STORED,
"Семестр изучения" INT NOT NULL CHECK ("Семестр изучения" >= 1 AND "Семестр изучения" <= 10),
"Форма контроля" VARCHAR(20) NOT NULL CHECK ("Форма контроля" IN ('зачет', 'экзамен', 'зачет + экзамен'))
);

CREATE TABLE Faculty.classroom (
"№ Кабинета" VARCHAR(10) NOT NULL PRIMARY KEY,
"Количество мест" INT NOT NULL CHECK ("Количество мест" >= 0),
"Компьютерный класс" VARCHAR(3) NOT NULL DEFAULT 'нет' CHECK ("Компьютерный класс" IN ('да', 'нет')),
"Проектор" VARCHAR(3) NOT NULL DEFAULT 'нет' CHECK ("Проектор" IN ('да', 'нет'))
);

CREATE TABLE Faculty.teacher (
"Код преподавателя" SERIAL4 PRIMARY KEY,
"Фамилия" VARCHAR(100) NOT NULL,
"Имя" VARCHAR(100) NOT NULL,
"Отчество" VARCHAR(100),
"Сотовый телефон" CHAR(12) CHECK ("Сотовый телефон" ~ '^\+7[0-9]{10}'),
"Почта" VARCHAR(100),
"Кафедра" VARCHAR(100) NOT NULL,
"Должность" VARCHAR(100) NOT NULL,
"Ученая степень" VARCHAR(100),
"Дата принятия на работу" DATE NOT NULL DEFAULT CURRENT_DATE CHECK ("Дата принятия на работу" <= CURRENT_DATE),
"Дата рождения" DATE CHECK ("Дата рождения" <= CURRENT_DATE)
);

CREATE TABLE Faculty.lesson (
"Группа" VARCHAR(20) NOT NULL,
"Дисциплина" INT NOT NULL,
"Вид занятия" VARCHAR(20) NOT NULL,
"Преподаватель" INT NOT NULL,
"Аудитория" VARCHAR(10) NOT NULL,
PRIMARY KEY ("Группа", "Дисциплина", "Вид занятия"),
CONSTRAINT fk_lesson_sgroup
	FOREIGN KEY ("Группа")
	REFERENCES Faculty.sgroup("КодГруппы")
	ON UPDATE CASCADE,
CONSTRAINT fk_lesson_subject
	FOREIGN KEY ("Дисциплина")
	REFERENCES Faculty.subject("Код дисциплины")
	ON UPDATE CASCADE,
CONSTRAINT fk_lesson_teacher
	FOREIGN KEY ("Преподаватель")
	REFERENCES Faculty.teacher("Код преподавателя")
	ON UPDATE CASCADE,
CONSTRAINT fk_lesson_classroom
	FOREIGN KEY ("Аудитория")
	REFERENCES Faculty.classroom("№ Кабинета")
	ON UPDATE CASCADE
);

CREATE TABLE Faculty.mark (
"№ Зачетки" CHAR(6),
"Дата" DATE,
"Дисциплина" INT,
"Преподаватель" INT,
"Оценка" VARCHAR(10) NOT NULL,
PRIMARY KEY ("№ Зачетки", "Дата", "Дисциплина"),
CONSTRAINT fk_mark_student
	FOREIGN KEY ("№ Зачетки")
	REFERENCES Faculty.student("НомерЗачетнойКнижки")
	ON UPDATE CASCADE,
CONSTRAINT fk_mark_subject
	FOREIGN KEY ("Дисциплина")
	REFERENCES Faculty.subject("Код дисциплины")
	ON UPDATE CASCADE,
CONSTRAINT fk_mark_teacher
	FOREIGN KEY ("Преподаватель")
	REFERENCES Faculty.teacher("Код преподавателя")
	ON UPDATE CASCADE
);