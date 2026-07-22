-- Invalid course instructor: Insert a course with instructor_id = 999
INSERT INTO courses (course_name, level,instructor_id)
VALUES('SQL', 'Beginner', 1);
-- Error: Rejected because instructor_id 999 does not exist

-- Invalid enrollment student: Insert enrollment with student_id = 999
INSERT INTO enrollments(student_id, course_id, status, enrollment_date)
VALUES(999,1,'active','2026-07-05');
-- Error: Rejected because student_id 999 does not exist

--Invalid enrollment course: Insert enrollment with course_id = 999
INSERT INTO enrollments(student_id, course_id, status, enrollment_date)
VALUES(1,999,'active','2026-07-05');
-- Error: Rejected because course_id 999 does not exist

--Duplicate enrollment: Enroll the same student in the same course twice
INSERT INTO enrollments(student_id, course_id, status, enrollment_date)
VALUES (1,1,'active','2026-07-05');
--Error - UNIQUE constraint failed: enrollments.student_id, enrollments.course_id

--Invalid attendance enrollment: Insert attendance with enrollment_id = 999
INSERT INTO attendance (enrollment_id, session_date, attended, minutes_attended) 
VALUES(999,'2026-07-10',1,120);
--Error: Rejected because enrollment_id 999 does not exist

--Invalid attendance minutes: Insert minutes_attended = -10
INSERT INTO attendance (enrollment_id, session_date, attended, minutes_attended) 
VALUES(1,'2026-07-10',1,-10);
--Error: Rejected because minutes_attended cannot be negative(CHECK constraint failed: minutes_attended >= 0)

--Invalid course level: Insert level = Expert
INSERT INTO courses (course_name, level, instructor_id)
VALUES('SQL', 'Expert', 1);
--Error: Rejected because CHECK allows only Beginner, Intermediate, Advanced

--Invalid submission assignment: Insert submission with assignment_id = 999
INSERT INTO assignments (course_id, title, max_score, due_date) 
VALUES(1,'SQL Queries Project',100,'2026-07-20');
--Error: Rejected because assignment_id 999 does not exist

-- Invalid submission score: Insert score greater than max_score or negative score
INSERT INTO submissions (assignment_id, student_id, submitted_at, score, status) VALUES
(1,1,'2026-07-19',-120,'submitted');
--Error: Negative scores are rejected by CHECK.

--Duplicate email: Insert two students with the same email
INSERT INTO students (full_name, city, email, created_at) VALUES
('Arta Krasniqi', 'Prishtina', 'arta@gmail.com', '2026-07-01');
-- Error: Rejected because email is UNIQUE