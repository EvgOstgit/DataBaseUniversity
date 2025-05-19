UPDATE Faculty.teacher
	SET "УченаяСтепень" = 'без степени'
	WHERE "УченаяСтепень" not in ('Кандидат наук', 'Доктор наук') or "УченаяСтепень" is null;