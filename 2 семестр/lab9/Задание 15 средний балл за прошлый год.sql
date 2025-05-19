INSERT INTO Faculty.mark
VALUES ('100001', '2024-01-01', 8, 18, '2'),
	('100001', '2024-01-01', 9, 18, '2'),
	('100002', '2024-01-01', 8, 18, '2'),
	('100003', '2024-01-01', 8, 18, '3'),
	('100004', '2024-01-01', 8, 18, '3'),
	('100004', '2024-01-01', 9, 18, '2');

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

