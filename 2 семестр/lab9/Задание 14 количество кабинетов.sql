SELECT COUNT(*) AS "Количество кабинетов",
	SPLIT_PART("НомерКабинета", '-', 1) AS "Корпус"
	FROM Faculty.classroom
	WHERE "Проектор" = true AND "КоличествоМест" > 50
	GROUP BY "Корпус";
	