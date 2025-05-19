ALTER TABLE Faculty.subject
	ADD COLUMN "Кафедра" INT;

ALTER TABLE Faculty.subject
	ADD CONSTRAINT fk_subject_department
	FOREIGN KEY ("Кафедра")
	REFERENCES Faculty.department("Код кафедры")
	ON UPDATE CASCADE;