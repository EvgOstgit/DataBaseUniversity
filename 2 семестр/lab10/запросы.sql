-- Задание 1
SELECT t."КодПреподавателя",
	t."Фамилия" || ' ' || t."Имя" || ' ' || t."Отчество" AS "ФИО",
	l."Группа"
FROM Faculty.teacher t, Faculty.lesson l
WHERE t."КодПреподавателя" = l."Преподаватель";

-- Задание 2
SELECT s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО",
	s."Группа",
	sg."Профиль",
	sg."Курс"
FROM Faculty.student s, Faculty.sgroup sg
WHERE s."Группа" = sg."КодГруппы" AND s."Группа" = 'МКб-3301-51-00'
ORDER BY "ФИО" ASC;
-- ORDER BY sg."Профиль" ASC;

-- Задание 3
SELECT DISTINCT sg."КодГруппы",
	s."Название" AS "НазваниеДисциплины",
	s."КоличествоЛекционныхЧасов",
	s."КоличествоПрактическихЧасов",
	s."КоличествоЛабораторныхЧасов",
	s."ОбщийОбъемЧасов"
FROM (Faculty.sgroup sg JOIN Faculty.lesson l ON sg."КодГруппы" = l."Группа")
	JOIN Faculty.subject s ON l."Дисциплина" = s."КодДисциплины"
ORDER BY sg."КодГруппы";

--Задание 4
SELECT sg."КодГруппы",
	COUNT(s."НомерЗачетнойКнижки") AS "Количество студентов"
FROM Faculty.student s
JOIN Faculty.sgroup sg ON s."Группа" = sg."КодГруппы"
GROUP BY sg."КодГруппы"
ORDER BY sg."КодГруппы";

--Задание 5
SELECT d."Название кафедры" AS "Кафедра",
	COUNT(t."КодПреподавателя") AS "Количество преподавателей"
FROM Faculty.teacher t
JOIN faculty.teacher_department td ON t."КодПреподавателя" = td."Преподаватель"
JOIN faculty.department d ON td."Кафедра" = d."Код кафедры"
GROUP BY d."Название кафедры"
HAVING COUNT(t."КодПреподавателя") < 3;

--Задание 6
SELECT t."Фамилия" || ' ' || LEFT(t."Имя", 1) || '.' || LEFT(t."Отчество", 1) AS "ФИО",
	COUNT(td."Кафедра") AS "Количество кафедр"
FROM faculty.teacher t
JOIN faculty.teacher_department td ON t."КодПреподавателя" = td."Преподаватель"
GROUP BY "ФИО"
HAVING COUNT(td."Кафедра") > 1;

--Задание 7
SELECT t."Фамилия" || ' ' || LEFT(t."Имя", 1) || '.' || LEFT(t."Отчество", 1) AS "ФИО",
	sg."КодГруппы",
	s."Название",
	l."ВидЗанятия"
FROM faculty.lesson l
JOIN faculty.teacher t ON l."Преподаватель" = t."КодПреподавателя"
JOIN faculty.sgroup sg ON l."Группа" = sg."КодГруппы"
JOIN faculty.subject s ON l."Дисциплина" = s."КодДисциплины"
WHERE NOT s."КоличествоЛекционныхЧасов" = 0
ORDER BY s."Название";

--Задание 8
SELECT t."Фамилия" || ' ' || LEFT(t."Имя", 1) || '.' || LEFT(t."Отчество", 1) AS "ФИО",
	COUNT(DISTINCT s."НомерЗачетнойКнижки") AS "Количество студентов"
FROM faculty.teacher t
JOIN faculty.lesson l ON t."КодПреподавателя" = l."Преподаватель"
JOIN faculty.student s ON l."Группа" = s."Группа"
GROUP BY t."КодПреподавателя"
HAVING COUNT(DISTINCT s."НомерЗачетнойКнижки") > 3;

--Задание 9
--Внутреннее соединение
SELECT s."НомерЗачетнойКнижки" AS "Зачетка",
	s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО",
	sg."КодГруппы" AS "Группа"
FROM faculty.student s
JOIN faculty.sgroup sg ON sg."КодГруппы" = s."Группа";

--Левое соединение
SELECT s."НомерЗачетнойКнижки" AS "Зачетка",
	s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО",
	sg."КодГруппы" AS "Группа"
FROM faculty.student s
LEFT JOIN faculty.sgroup sg ON sg."КодГруппы" = s."Группа";

--Правое соединение
SELECT s."НомерЗачетнойКнижки" AS "Зачетка",
	s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО",
	sg."КодГруппы" AS "Группа"
FROM faculty.student s
RIGHT JOIN faculty.sgroup sg ON sg."КодГруппы" = s."Группа";

--Задание 10
SELECT c."НомерКабинета",
	c."Проектор"
FROM faculty.classroom c
LEFT JOIN faculty.lesson l ON c."НомерКабинета" = l."Аудитория"
WHERE c."Проектор" = true AND l."Аудитория" IS NULL;

--Задание 11
SELECT s."НомерЗачетнойКнижки"
FROM faculty.student s
LEFT JOIN faculty.mark m ON s."НомерЗачетнойКнижки" = m."№Зачетки"
WHERE m."№Зачетки" IS NULL;

--Задание 12
SELECT t."Фамилия" || ' ' || LEFT(t."Имя", 1) || '.' || LEFT(t."Отчество", 1) AS "ФИО"
FROM faculty.teacher t
LEFT JOIN faculty.lesson l ON t."КодПреподавателя" = l."Преподаватель"
WHERE l."Преподаватель" IS NULL;

--Задание 13
--Количество срок 15(дисциплины)*9(студенты) = 135
SELECT DISTINCT
	s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО",
	sub."Название" AS "Дисциплина"
FROM faculty.student s
CROSS JOIN faculty.subject sub
ORDER BY "ФИО";

--Задание 14
--Работник с максимальным стажем
SELECT t."Фамилия" || ' ' || LEFT(t."Имя", 1) || '.' || LEFT(t."Отчество", 1) AS "ФИО",
	t."ДатаПринятияНаРаботу",
	EXTRACT(YEAR FROM AGE(CURRENT_DATE, t."ДатаПринятияНаРаботу")) AS "Стаж"
FROM faculty.teacher t
WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, t."ДатаПринятияНаРаботу")) = (
	SELECT MAX(EXTRACT(YEAR FROM AGE(CURRENT_DATE, t."ДатаПринятияНаРаботу")))
	FROM faculty.teacher t
);

--Задание 15
--Студент с возрастом ниже среднего по факультету
SELECT s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО",
	EXTRACT(YEAR FROM AGE(CURRENT_DATE, s."ДатаРождения")) AS "Возраст"
FROM faculty.student s
WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, s."ДатаРождения")) < (
	SELECT AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, s."ДатаРождения")))
	FROM faculty.student s
);

--Задание 16
--а) Список студентов, получивших по предмету оценку выше средней
SELECT s."НомерЗачетнойКнижки"
FROM faculty.student s
WHERE s."НомерЗачетнойКнижки" IN (
	SELECT m."№Зачетки"
	FROM faculty.mark m
	WHERE m."Дисциплина" = 10 AND CAST(m."Оценка" AS INTEGER) > (
		SELECT AVG(CAST(m."Оценка" AS INTEGER))
		FROM faculty.mark m
		WHERE m."Дисциплина" = 10
	)
);

--b) Вывод ФИО вместо номеров зачеток
SELECT s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО"
FROM faculty.student s
WHERE s."НомерЗачетнойКнижки" IN (
	SELECT m."№Зачетки"
	FROM faculty.mark m
	WHERE m."Дисциплина" = 10 AND CAST(m."Оценка" AS INTEGER) > (
		SELECT AVG(CAST(m."Оценка" AS INTEGER))
		FROM faculty.mark m
		WHERE m."Дисциплина" = 10
	)
);

--c) Использование соединения таблиц
SELECT DISTINCT s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО"
FROM faculty.student s
JOIN faculty.mark m ON m."№Зачетки" = s."НомерЗачетнойКнижки"
WHERE m."Дисциплина" = 10
	AND CAST(m."Оценка" AS INTEGER) > (
		SELECT AVG(CAST(m."Оценка" AS INTEGER))
		FROM faculty.mark m
		WHERE m."Дисциплина" = 10
);

--Коррелированные подзапросы
--Задание 17
SELECT s."НомерЗачетнойКнижки",
	s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО Студента",
	m."Дата",
	sub."Название" AS "НазваниеДисциплины",
	t."Фамилия" || ' ' || LEFT(t."Имя", 1) || '.' || LEFT(t."Отчество", 1) AS "ФИО Преподавателя",
	m."Оценка"
FROM faculty.student s
JOIN faculty.mark m ON s."НомерЗачетнойКнижки" = m."№Зачетки"
JOIN faculty.subject sub ON m."Дисциплина" = sub."КодДисциплины"
JOIN faculty.teacher t ON m."Преподаватель" = t."КодПреподавателя"
WHERE m."Дата" = (
	SELECT MIN(m."Дата")
	FROM faculty.mark m
	WHERE s."НомерЗачетнойКнижки" = m."№Зачетки"
);

--Задание 18
SELECT 
    t."Фамилия" || ' ' || LEFT(t."Имя", 1) || '.' || LEFT(t."Отчество", 1) AS "ФИО Преподавателя",
    sub."Название" AS "Дисциплина",
    AVG(CAST(m."Оценка" AS INTEGER)) AS "Средний балл"
FROM faculty.teacher t
JOIN faculty.mark m ON t."КодПреподавателя" = m."Преподаватель"
JOIN faculty.subject sub ON m."Дисциплина" = sub."КодДисциплины"
WHERE m."Оценка" NOT IN ('зачет', 'незачет')
GROUP BY sub."КодДисциплины", sub."Название", t."КодПреподавателя", t."Фамилия", t."Имя", t."Отчество"
HAVING AVG(CAST(m."Оценка" AS INTEGER)) < (
    SELECT AVG(CAST(m2."Оценка" AS INTEGER))
    FROM faculty.mark m2
    WHERE m2."Оценка" NOT IN ('зачет', 'незачет')
      AND m2."Дисциплина" = sub."КодДисциплины"
);

--Операторы объединения, пересечения, вычитания
--Задание 19
SELECT s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО",
	s."Группа" AS "Структурное подразделение",
	s."ДатаРождения",
	s."СотовыйТелефон"
FROM faculty.student s
UNION
SELECT t."Фамилия" || ' ' || t."Имя" || ' ' || t."Отчество",
	d."Название кафедры" || ', ' || d."Подразделение",
	t."ДатаРождения",
	t."Сотовый телефон"
FROM faculty.teacher t
JOIN faculty.teacher_department td ON t."КодПреподавателя" = td."Преподаватель"
JOIN faculty.department d ON td."Кафедра" = d."Код кафедры"
ORDER BY "Структурное подразделение", "ФИО";

--Задание 20
SELECT s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО",
	s."ДатаРождения"
FROM faculty.student s
INTERSECT
SELECT t."Фамилия" || ' ' || t."Имя" || ' ' || t."Отчество",
	t."ДатаРождения"
FROM faculty.teacher t;

--Задание 21
SELECT t."Фамилия" || ' ' || t."Имя" || ' ' || t."Отчество" AS "ФИО"
FROM faculty.teacher t
EXCEPT
SELECT DISTINCT t."Фамилия" || ' ' || t."Имя" || ' ' || t."Отчество"
FROM faculty.mark m
JOIN faculty.teacher t ON t."КодПреподавателя" = m."Преподаватель"
WHERE m."Оценка" = '2';

--Задание 22
SELECT sub."Название" AS "Дисциплина"
FROM faculty.lesson l
JOIN faculty.subject sub ON l."Дисциплина" = sub."КодДисциплины"
WHERE l."Группа" LIKE '%МКб%'
INTERSECT
SELECT sub."Название" AS "Дисциплина"
FROM faculty.lesson l2
JOIN faculty.subject sub ON l2."Дисциплина" = sub."КодДисциплины"
WHERE l2."Группа" LIKE '%ФИб%'
INTERSECT
SELECT sub."Название" AS "Дисциплина"
FROM faculty.lesson l3
JOIN faculty.subject sub ON l3."Дисциплина" = sub."КодДисциплины"
WHERE l3."Группа" LIKE '%ПМИб%';

--Задание 23
SELECT s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество" AS "ФИО"
FROM faculty.student s
EXCEPT
SELECT s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество"
FROM faculty.mark m
JOIN faculty.student s ON m."№Зачетки" = s."НомерЗачетнойКнижки";

--Задание 24
SELECT sub."Название"
FROM faculty.subject sub
EXCEPT (
SELECT sub."Название"
FROM faculty.lesson l
JOIN faculty.subject sub ON l."Дисциплина" = sub."КодДисциплины"
UNION
SELECT sub."Название"
FROM faculty.mark m
JOIN faculty.subject sub ON m."Дисциплина" = sub."КодДисциплины"
);