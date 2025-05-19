SELECT 
	COUNT(*) AS "Количество студентов",
	ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, "ДатаРождения"))), 1) AS "Средний возраст"
FROM Faculty.student;