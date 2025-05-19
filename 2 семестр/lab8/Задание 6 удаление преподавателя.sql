UPDATE Faculty.teacher
	SET "ДатаРождения" = '1900-01-01'
	WHERE "КодПреподавателя" = 3;

DELETE FROM Faculty.teacher
	WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, "ДатаРождения")) > 65;

