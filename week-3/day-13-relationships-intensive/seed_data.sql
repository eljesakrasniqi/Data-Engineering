INSERT INTO students (full_name, city, email, created_at) VALUES
('Arta Krasniqi', 'Prishtina', 'arta@gmail.com', '2026-07-01'),
('Blend Hoxha', 'Prizren', 'blend@gmail.com', '2026-07-01'),
('Era Gashi', 'Peja', 'era@gmail.com', '2026-07-02'),
('Dion Berisha', 'Gjakova', 'dion@gmail.com', '2026-07-02'),
('Lira Shala', 'Ferizaj', 'lira@gmail.com', '2026-07-03'),
('Noar Rexha', 'Mitrovica', 'noar@gmail.com', '2026-07-03'),
('Sara Morina', 'Vushtrri', 'sara@gmail.com', '2026-07-04'),
('Leon Kelmendi', 'Gjilan', 'leon@gmail.com', '2026-07-04');

SELECT * FROM students;

INSERT INTO instructors (full_name, specialization) VALUES
('Arben Mustafa', 'Database Engineering'),
('Elira Krasniqi', 'Programming'),
('Mentor Selimi', 'Data Engineering');

SELECT * FROM instructors;


INSERT INTO courses (course_name, level, instructor_id)
VALUES
('SQL', 'Beginner', 1),
('Python', 'Intermediate', 2),
('Databricks', 'Advanced', 3),
('PySpark', 'Advanced', 3),
('Data Modeling', 'Intermediate', 1);

SELECT * FROM courses;

INSERT INTO enrollments (student_id, course_id, status, enrollment_date) VALUES
(1,1,'active','2026-07-05'),
(1,2,'active','2026-07-05'),
(2,1,'completed','2026-07-06'),
(2,5,'active','2026-07-06'),
(3,2,'active','2026-07-07'),
(3,3,'active','2026-07-07'),
(4,4,'active','2026-07-08'),
(5,1,'completed','2026-07-08'),
(5,3,'active','2026-07-08'),
(6,5,'active','2026-07-09'),
(7,2,'active','2026-07-09'),
(7,4,'active','2026-07-09');
SELECT * FROM enrollments;


INSERT INTO attendance (enrollment_id, session_date, attended, minutes_attended) VALUES
(1,'2026-07-10',1,120),
(1,'2026-07-11',1,110),
(2,'2026-07-10',0,0),
(3,'2026-07-10',1,90),
(4,'2026-07-11',1,120),
(5,'2026-07-12',1,100),
(6,'2026-07-12',0,0),
(7,'2026-07-13',1,120),
(8,'2026-07-13',1,110),
(9,'2026-07-14',1,90),
(10,'2026-07-14',0,0),
(11,'2026-07-15',1,120),
(12,'2026-07-15',1,100),
(2,'2026-07-16',1,80),
(5,'2026-07-16',1,95),
(6,'2026-07-17',1,120),
(9,'2026-07-17',0,0),
(10,'2026-07-18',1,100);

SELECT * FROM attendance;


INSERT INTO assignments (course_id, title, max_score, due_date) VALUES
(1,'SQL Queries Project',100,'2026-07-20'),
(1,'Database Design Task',100,'2026-07-22'),
(2,'Python ETL Pipeline',100,'2026-07-23'),
(3,'Databricks Notebook',100,'2026-07-24'),
(4,'PySpark Transformation',100,'2026-07-25'),
(5,'Data Warehouse Model',100,'2026-07-26');

SELECT * FROM assignments;


INSERT INTO submissions (assignment_id, student_id, submitted_at, score, status) VALUES
(1,1,'2026-07-19',95,'submitted'),
(1,2,'2026-07-20',88,'submitted'),
(2,5,'2026-07-23',75,'late'),
(3,1,'2026-07-22',90,'submitted'),
(3,3,'2026-07-23',80,'submitted'),
(4,3,'2026-07-25',70,'late'),
(4,5,NULL,NULL,'missing'),
(5,4,'2026-07-24',85,'submitted'),
(5,7,'2026-07-26',60,'late'),
(6,2,'2026-07-25',92,'submitted'),
(6,6,NULL,NULL,'missing'),
(2,8,NULL,NULL,'missing');

SELECT * FROM submissions;
