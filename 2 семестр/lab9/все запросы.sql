SELECT ROUND(AVG(CAST("Оценка" AS INT)), 1) AS "Средний балл",
	"Дисциплина"
	FROM Faculty.mark
	WHERE "Оценка" NOT IN ('зачет', 'незачет')
		AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, "Дата")) = 1
	GROUP BY "Дисциплина"
	HAVING ROUND(AVG(CAST("Оценка" AS INT)), 1) < 3.5
	ORDER BY "Средний балл" DESC;

SELECT "Преподаватель"
FROM Faculty.subject
ORDER BY "Название" ASC;

SELECT "Фамилия" || ' ' || LEFT("Имя", 1) || '.' || LEFT("Отчество", 1) AS "ФИО",
	   "ДатаРождения",
	   EXTRACT(YEAR FROM AGE(CURRENT_DATE, "ДатаРождения")) AS "Возраст"
FROM Faculty.teacher
ORDER BY "ДатаРождения" DESC
LIMIT 3;

SELECT "Фамилия" || ' ' || LEFT("Имя", 1) || '.' || LEFT("Отчество", 1) AS "ФИО",
	"ДатаПринятияНаРаботу",
	"УченаяСтепень"
FROM Faculty.teacher
WHERE "ДатаПринятияНаРаботу" >= '2015-08-01';

SELECT "КодГруппы"
FROM Faculty.sgroup
WHERE NOT("НаправлениеПодготовки" IS NULL) AND "Профиль" IS NULL;

SELECT *
FROM Faculty.classroom
WHERE ("НомерКабинета" LIKE '%14-%'
	OR "НомерКабинета" LIKE '%16-%')
	AND "КомпьютерныйКласс" = true;

SELECT *
FROM Faculty.subject
WHERE "Название" LIKE '%акультатив%'
	AND "КоличествоЛекционныхЧасов" > 0;

SELECT *
FROM Faculty.subject
WHERE "СеместрИзучения" IN ('1', '3', '5');

SELECT *
FROM Faculty.student
WHERE "Группа" LIKE '%МКб-%';

SELECT *
FROM Faculty.subject
ORDER BY "ОбщийОбъемЧасов" DESC
LIMIT 3;

SELECT min("ДатаПринятияНаРаботу") FROM Faculty.teacher;

SELECT 
	COUNT(*) AS "Количество студентов",
	ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, "ДатаРождения"))), 1) AS "Средний возраст"
FROM Faculty.student;

SELECT 
	COUNT(*) AS "Количество студентов",
	"Группа"
	FROM Faculty.student
	GROUP BY "Группа";

SELECT 
	COUNT(*) AS "Количество преподавателей",
	"УченаяСтепень"
	FROM Faculty.teacher
	WHERE NOT("УченаяСтепень" = 'без степени')
	GROUP BY "УченаяСтепень";

SELECT ROUND(AVG(CAST("Оценка" AS INT)), 1),
	"Дисциплина"
	FROM Faculty.mark
	WHERE "Оценка" NOT IN ('зачет', 'незачет')
	GROUP BY "Дисциплина";

SELECT COUNT(*) AS "Количество кабинетов",
	SPLIT_PART("НомерКабинета", '-', 1) AS "Корпус"
	FROM Faculty.classroom
	WHERE "Проектор" = true AND "КоличествоМест" > 50
	GROUP BY "Корпус";

SELECT ROUND(AVG(CAST("Оценка" AS INT)), 1) AS "Средний балл",
	"№Зачетки"
	FROM Faculty.mark
	WHERE "Оценка" NOT IN ('зачет', 'незачет')
	GROUP BY "№Зачетки"
	HAVING ROUND(AVG(CAST("Оценка" AS INT)), 1) > 4.4
	ORDER BY "Средний балл" DESC;

SELECT ROUND(AVG(CAST("Оценка" AS INT)), 1) AS "Средний балл",
	"Дисциплина"
	FROM Faculty.mark
	WHERE "Оценка" NOT IN ('зачет', 'незачет')
		AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, "Дата")) = 1
	GROUP BY "Дисциплина"
	HAVING ROUND(AVG(CAST("Оценка" AS INT)), 1) < 3.5
	ORDER BY "Средний балл" DESC;

