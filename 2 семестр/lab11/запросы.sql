--Создание представлений
--Задание 1
CREATE VIEW faculty.infoStudents
AS
SELECT s."НомерЗачетнойКнижки" AS "Зачетка",
	s."Фамилия" || ' ' || LEFT(s."Имя", 1) || '. ' || LEFT(s."Отчество", 1) || '.' AS "ФИО",
	TO_CHAR(s."ДатаРождения", 'DD.MM.YYYY') AS "Дата рождения"
FROM faculty.student s;

--Задание 2
--а)
CREATE VIEW faculty."Занятость кабинетов"
AS
SELECT
	l."Аудитория",
	COUNT(l."Аудитория")
FROM faculty.lesson l
GROUP BY l."Аудитория";

--б)
CREATE VIEW faculty."Занятость кабинетов 2"
AS
SELECT
	l."Аудитория",
	COUNT(l."Аудитория")
FROM faculty.lesson l
GROUP BY l."Аудитория"
ORDER BY COUNT(l."Аудитория") ASC
LIMIT 3;

--Задание 3
CREATE VIEW faculty."Статистика успеваемости"
AS
SELECT
	EXTRACT(YEAR FROM m."Дата") AS "Год",
	EXTRACT(MONTH FROM m."Дата") AS "Месяц",
	ROUND(AVG(CAST(m."Оценка" AS INTEGER)), 1) AS "Средний балл",
	COUNT(m."№Зачетки") AS "Количество студентов"
FROM faculty.mark m
WHERE m."Оценка" NOT IN ('зачет', 'незачет')
GROUP BY EXTRACT(YEAR FROM m."Дата"), EXTRACT(MONTH FROM m."Дата");

--Задание 4
CREATE VIEW faculty."Дни рождения студентов"
AS
SELECT
	CASE
		WHEN EXTRACT(MONTH FROM s."ДатаРождения") IN (1, 2, 12) THEN 'Зима'
		WHEN EXTRACT(MONTH FROM s."ДатаРождения") IN (3, 4, 5) THEN 'Весна'
		WHEN EXTRACT(MONTH FROM s."ДатаРождения") IN (6, 7, 8) THEN 'Лето'
		WHEN EXTRACT(MONTH FROM s."ДатаРождения") IN (9, 10, 11) THEN 'Осень'
	END
	AS "Сезон",
	COUNT(s."НомерЗачетнойКнижки") AS "Количество студентов"
FROM faculty.student s
WHERE NOT(s."ДатаРождения" IS NULL)
GROUP BY "Сезон";

--Задание 5
CREATE VIEW faculty."Количество сдавших сессию"
AS
SELECT
	CASE
		WHEN EXTRACT(MONTH FROM m."Дата") IN (1, 2, 12) THEN 'Зимняя'
		WHEN EXTRACT(MONTH FROM m."Дата") IN (5, 6, 7) THEN 'Летняя'
	END AS "Сессия",
	COUNT(m."№Зачетки") AS "Количество студентов"
FROM faculty.mark m
WHERE EXTRACT(MONTH FROM m."Дата") IN (1, 2, 5, 6, 7, 12)
GROUP BY "Сессия";