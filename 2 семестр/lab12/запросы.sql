--Задание 1
CREATE OR REPLACE FUNCTION faculty.sgrouplist(IN groupid_ VARCHAR(20))
RETURNS TABLE ("ФИО" VARCHAR(100))
AS
$$
SELECT
	s."Фамилия" || ' ' || s."Имя" || ' ' || s."Отчество"
FROM faculty.student s
WHERE s."Группа" = groupid_
$$
LANGUAGE SQL;

SELECT * FROM faculty.sgrouplist('МКб-3301-51-00');

--Задание 2
CREATE OR REPLACE FUNCTION faculty.comp_classroomlist(IN uni_building_ VARCHAR(2))
RETURNS TABLE ("Номер кабинета" VARCHAR(10))
AS
$$
SELECT
	c."НомерКабинета"
FROM faculty.classroom c
WHERE
	c."КомпьютерныйКласс" = true AND
	c."НомерКабинета" LIKE uni_building_ || '-%'
$$
LANGUAGE SQL;

SELECT * FROM faculty.comp_classroomlist('16');

--Задание 3
REATE OR REPLACE FUNCTION faculty.avg_gpa_list(
	IN surname_ VARCHAR(100),
	IN firstname_ VARCHAR(100),
	IN secondname_ VARCHAR(100)
)
RETURNS NUMERIC(10, 2)
AS
$$
SELECT ROUND(AVG(CAST(m."Оценка" AS INTEGER)), 2)
FROM faculty.mark m
JOIN faculty.student s ON m."№Зачетки" = s."НомерЗачетнойКнижки"
WHERE 
	m."Оценка" NOT IN ('зачет', 'незачет') AND
	s."Фамилия" = surname_ AND
	s."Имя" = firstname_ AND
	s."Отчество" = secondname_
$$
LANGUAGE SQL;

SELECT * FROM faculty.avg_gpa_list('Иванов', 'Иван', 'Иванович');

--Задание 4
CREATE PROCEDURE faculty.delete_classroom(IN class_num_ VARCHAR(10))
LANGUAGE SQL
AS
$$
DELETE FROM faculty.classroom
WHERE "НомерКабинета" = class_num_
$$;

CALL faculty.delete_classroom('16-332');

--Перед удалением проверить, не проводится ли в кабинете занятий
SELECT DISTINCT c."НомерКабинета"
FROM faculty.classroom c
EXCEPT (
SELECT l."Аудитория"
FROM faculty.lesson l
INTERSECT
SELECT c."НомерКабинета"
FROM faculty.classroom c
);

--Задание 5
CREATE OR REPLACE FUNCTION faculty.get_teacher_id(
	IN surname_ VARCHAR(100),
	IN firstname_ VARCHAR(100),
	IN secondname_ VARCHAR(100),
	IN birthday_ DATE
)
RETURNS INTEGER
AS
$$
SELECT t."КодПреподавателя"
FROM faculty.teacher t
WHERE
	t."Фамилия" = surname_ AND
	t."Имя" = firstname_ AND
	t."Отчество" = secondname_ AND
	t."ДатаРождения" = birthday_;
$$
LANGUAGE SQL;

CREATE OR REPLACE PROCEDURE faculty.insert_data(
	IN surname_ VARCHAR(100),
	IN firstname_ VARCHAR(100),
	IN secondname_ VARCHAR(100),
	IN birthday_ DATE,
	IN department1_ INTEGER,
	IN title1_ VARCHAR(100),
	IN department2_ INTEGER,
	IN title2_ VARCHAR(100)
)
LANGUAGE plpgsql
AS
$$
DECLARE
	new_teacher_id INT;
BEGIN
	INSERT INTO faculty.teacher ("Фамилия", "Имя", "Отчество", "ДатаРождения")
	VALUES (surname_, firstname_, secondname_, birthday_);

	SELECT INTO new_teacher_id faculty.get_teacher_id(surname_, firstname_, secondname_, birthday_);

	INSERT INTO faculty.teacher_department
	VALUES
		(new_teacher_id, department1_, title1_),
		(new_teacher_id, department2_, title2_);
END;
$$;

CALL faculty.insert_data(
	'Валентинов',
	'Валентин',
	'Валентинович',
	'1950-01-01',
	4,
	'Преподаватель',
	3,
	'Лаборант'
);