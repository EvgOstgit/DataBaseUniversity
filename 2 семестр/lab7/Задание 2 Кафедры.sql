CREATE TABLE Faculty.department (
"Код кафедры" INT NOT NULL PRIMARY KEY,
"Название кафедры" VARCHAR(100) NOT NULL,
"Подразделение" VARCHAR(100) NOT NULL,
"Кабинет" VARCHAR(10) NOT NULL,
"Телефон" CHAR(6) CHECK ("Телефон" ~ '^[0-9]{6}$'),
"Заведующий кафедрой" INT,
CONSTRAINT fk_department_teacher
	FOREIGN KEY ("Заведующий кафедрой")
	REFERENCES Faculty.teacher("Код преподавателя")
	ON UPDATE CASCADE,
CONSTRAINT fk_department_classroom
	FOREIGN KEY ("Кабинет")
	REFERENCES Faculty.classroom("НомерКабинета")
	ON UPDATE CASCADE,
);

ALTER TABLE Faculty.teacher DROP COLUMN "Кафедра";

CREATE TABLE Faculty.department_teacher (
"Код кафедры" INT,
"Код преподавателя" INT,
PRIMARY KEY ("Код кафедры", "Код преподавателя"),
CONSTRAINT fk_department_teacher_department
	FOREIGN KEY ("Код кафедры")
	REFERENCES Faculty.department("Код кафедры")
	ON UPDATE CASCADE,
CONSTRAINT fk_department_teacher_teacher
	FOREIGN KEY ("Код преподавателя")
	REFERENCES Faculty.teacher("Код преподавателя")
	ON UPDATE CASCADE
);