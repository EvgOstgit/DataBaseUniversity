SELECT ROUND(AVG(CAST("Оценка" AS INT)), 1),
	"Дисциплина"
	FROM Faculty.mark
	WHERE "Оценка" NOT IN ('зачет', 'незачет')
	GROUP BY "Дисциплина";