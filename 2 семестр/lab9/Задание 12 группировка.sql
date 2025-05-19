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