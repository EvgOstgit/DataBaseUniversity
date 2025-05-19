SELECT "Фамилия" || ' ' || LEFT("Имя", 1) || '.' || LEFT("Отчество", 1) AS "ФИО",
	   "ДатаРождения",
	   EXTRACT(YEAR FROM AGE(CURRENT_DATE, "ДатаРождения")) AS "Возраст"
FROM Faculty.teacher
ORDER BY "ДатаРождения" DESC
LIMIT 3;