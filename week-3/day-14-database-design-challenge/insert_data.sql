-- Insert Students
INSERT INTO students (full_name, email, phone_number, city) VALUES
('Arta Krasniqi', 'arta@gmail.com', '044111111', 'Prishtina'),
('Blend Hoxha', 'blend@gmail.com', '044222222', 'Vushtrri'),
('Sara Berisha', 'sara@gmail.com', '044333333', 'Peja'),
('Dren Gashi', 'dren@gmail.com', '044444444', 'Prizren'),
('Elira Mustafa', 'elira@gmail.com', '044555555', 'Gjilan'),
('Arjan Rama', 'arjan@gmail.com', '044666666', 'Ferizaj'),
('Lira Shala', 'lira@gmail.com', '044777777', 'Mitrovica'),
('Besa Aliu', 'besa@gmail.com', '044888888', 'Prishtina'),
('Klea Morina', 'klea@gmail.com', '044999999', 'Peja'),
('Leon Krasniqi', 'leon@gmail.com', '044000000', 'Prizren');


-- Insert Programs
INSERT INTO programs (program_name, duration_months) VALUES
('Full Stack Development', 6),
('Data Engineering', 6),
('English Language', 4),
('After School Program', 9);


-- Insert Instructors
INSERT INTO instructors (full_name, email, phone, specialization) VALUES
('Arben Gashi', 'arben@gmail.com', '045111111', 'Full Stack'),
('Mira Hoxha', 'mira@gmail.com', '045222222', 'Data Engineering'),
('Sara Dema', 'sara@gmail.com', '045333333', 'English');


-- Insert Enrollments
INSERT INTO enrollments (student_id, program_id, instructor_id, status, enrollment_date) VALUES
(1,1,1,'active','2026-01-10'),
(1,2,2,'active','2026-02-15'),
(2,1,1,'completed','2025-09-01'),
(3,1,1,'active','2026-01-20'),
(4,2,2,'dropped','2025-10-05'),
(5,3,3,'active','2026-03-01'),
(6,2,2,'completed','2025-08-10'),
(7,1,1,'active','2026-02-01'),
(8,3,3,'active','2026-03-10'),
(9,1,1,'dropped','2025-11-15'),
(10,2,2,'active','2026-01-25'),
(2,3,3,'active','2026-04-01'),
(3,2,2,'completed','2025-07-15'),
(5,1,1,'active','2026-02-20');


-- Insert Attendance
INSERT INTO attendance(enrollment_id, session_date, attended, minutes_attended)VALUES
(1,'2026-02-01',1,120),
(1,'2026-02-05',1,120),
(1,'2026-02-10',1,120),

(2,'2026-02-15',1,120),
(2,'2026-02-20',0,0),
(2,'2026-02-25',1,120),

(3,'2025-10-01',1,120),
(3,'2025-10-05',1,120),
(3,'2025-10-10',1,120),

(4,'2026-02-01',1,120),
(4,'2026-02-05',0,0),
(4,'2026-02-10',0,0),

(5,'2025-11-01',0,0),
(5,'2025-11-05',1,120),

(6,'2026-03-05',1,120),
(6,'2026-03-10',1,120),

(7,'2025-09-01',1,120),
(7,'2025-09-05',1,120),
(7,'2025-09-10',1,120),

(8,'2026-02-10',1,120),
(8,'2026-02-15',0,0),

(9,'2026-03-15',1,120),
(9,'2026-03-20',1,120),

(10,'2025-12-01',0,0),
(10,'2025-12-05',0,0),

(11,'2026-02-01',1,120),
(11,'2026-02-05',1,120),

(12,'2026-04-10',1,120),
(12,'2026-04-15',1,120),

(13,'2025-08-01',1,120),
(13,'2025-08-05',1,120);


-- Insert Payments
INSERT INTO payments (enrollment_id, payment_amount, payment_status, payment_date) VALUES
(1, 1200.00, 'paid', '2026-02-01'),
(2, 600.00, 'partial', '2026-02-15'),
(3, 1000.00, 'paid', '2025-09-05'),
(4, 0.00, 'unpaid', '2026-02-01'),
(5, 0.00, 'unpaid', '2025-10-10'),
(6, 1500.00, 'paid', '2026-03-05'),
(7, 1200.00, 'paid', '2025-08-15'),
(8, 500.00, 'partial', '2026-02-05'),
(9, 1200.00, 'paid', '2026-03-15'),
(10, 0.00, 'unpaid', '2025-12-01'),
(11, 1500.00, 'paid', '2026-02-05'),
(12, 250.00, 'partial', '2026-04-05'),
(13, 1000.00, 'paid', '2025-08-20'),
(14, 0.00, 'unpaid', '2026-02-25');