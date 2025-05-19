SELECT *
FROM Faculty.student
WHERE "Группа" LIKE '%МКб-%';

SELECT *
FROM Faculty.subject
ORDER BY "ОбщийОбъемЧасов" DESC
LIMIT 3;