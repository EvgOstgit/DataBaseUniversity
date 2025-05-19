COPY Faculty.classroom
FROM 'C:\\sql_labs_files\\classrooms.csv'
DELIMITER ','
CSV HEADER;

COPY Faculty.subject("Название",
                    "КоличествоЛекционныхЧасов",
                    "КоличествоЛабораторныхЧасов",
                    "КоличествоПрактическихЧасов",
                    "СеместрИзучения",
                    "ФормаКонтроля")
FROM 'C:\\sql_labs_files\\subjects.csv'
DELIMITER ','
CSV HEADER;

COPY Faculty.mark
FROM 'C:\\sql_labs_files\\marks.csv'
DELIMITER ','
CSV HEADER;

COPY Faculty.teacher
	TO 'C:\\sql_labs_files\\teachers.csv'
	DELIMITER ','
	CSV HEADER;

COPY (
	SELECT * FROM Faculty.classroom
	WHERE "Проектор" = true
)
	TO 'C:\\sql_labs_files\\classrooms_with_proector.csv'
	DELIMITER ','
	CSV HEADER;