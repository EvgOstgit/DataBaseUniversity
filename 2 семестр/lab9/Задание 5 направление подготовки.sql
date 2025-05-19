SELECT "КодГруппы"
FROM Faculty.sgroup
WHERE NOT("НаправлениеПодготовки" IS NULL) AND "Профиль" IS NULL;