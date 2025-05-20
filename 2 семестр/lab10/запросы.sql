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