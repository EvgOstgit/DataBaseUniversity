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