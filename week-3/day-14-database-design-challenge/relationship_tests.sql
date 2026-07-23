--Part 4 - Relationship and Constraint Tests

--Insert enrollment with student ID that does not exist
INSERT INTO enrollments (student_id, program_id, instructor_id, status, enrollment_date) VALUES
(888,1,1,'active','2026-01-10');
--Error: Rejected because student_id 888 does not exist (FOREIGN KEY constraint failed)

--Insert enrollment with program ID that does not exist
INSERT INTO enrollments (student_id, program_id, instructor_id, status, enrollment_date) VALUES
(1,888,1,'active','2026-01-10');
--Error: Rejected because program_id 888 does not exist (FOREIGN KEY constraint failed)

--Insert attendance for enrollment ID that does not exist
INSERT INTO attendance(enrollment_id, session_date, attended, minutes_attended)VALUES
(888,'2026-02-01',1,120);
--Error: Rejected because enrollment_id 888 does not exist (FOREIGN KEY constraint failed)

--Insert payment for enrollment ID that does not exist
INSERT INTO payments (enrollment_id, payment_status, payment_date) VALUES
(888,'paid','2026-02-01');
--Error: Rejected because enrollment_id 888 does not exist (FOREIGN KEY constraint failed)

--Insert student with duplicate email
INSERT INTO students (full_name, email, phone_number, city) VALUES
('Arta Krasniqi', 'arta@gmail.com', '044111111', 'Prishtina');
--Error: Rejected because email is UNIQUE (UNIQUE constraint failed: students.email)

--Insert payment with negative amount
INSERT INTO payments (enrollment_id, payment_amount, payment_status, payment_date) VALUES
(1, -5, 'paid', '2026-02-01'),
--Error: Rejected because payment_amount cannot be negative(CHECK constraint failed: payment_amount >= 0)

--Insert invalid enrollment status
INSERT INTO enrollments (student_id, program_id, instructor_id, status, enrollment_date) VALUES
(1,1,1,'not completed','2026-01-10');
--Rejected because CHECK allows only active, completed, dropped (CHECK constraint failed: status IN ('active','completed','dropped'))