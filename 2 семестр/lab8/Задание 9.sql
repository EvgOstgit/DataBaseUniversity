DELETE FROM Faculty.student
WHERE 
    ("Адрес" IS NULL OR "Адрес" = 'Неизвестно')
    AND ("СотовыйТелефон" IS NULL)
    AND ("Почта" IS NULL)
    AND ("ГодПоступления" IS NULL);