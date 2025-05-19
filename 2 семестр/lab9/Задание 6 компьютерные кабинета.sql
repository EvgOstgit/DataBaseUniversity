SELECT *
FROM Faculty.classroom
WHERE ("НомерКабинета" LIKE '%14-%'
	OR "НомерКабинета" LIKE '%16-%')
	AND "КомпьютерныйКласс" = true;