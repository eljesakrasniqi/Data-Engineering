--Part 5 - JOIN Reports

--Show all students with their programs and instructors
SELECT
    students.full_name AS student_name,
    programs.program_name,
    instructors.full_name AS instructor_name
FROM enrollments 
JOIN students ON enrollments.student_id = students.student_id
JOIN programs  ON enrollments.program_id = programs.program_id
JOIN instructors ON enrollments.instructor_id = instructors.instructor_id;

--Show active enrollments only, including student name, program name, instructor name, and status.
SELECT
   students.full_name AS student_name,
   programs.program_name,
   instructors.full_name AS instructor_name,
   enrollments.status
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
JOIN programs ON enrollments.program_id = programs.program_id
JOIN instructors ON enrollments.instructor_id = instructors.instructor_id
WHERE status = 'active';

--Show completed enrollments with student and program information.
SELECT
   students.full_name AS student_name,
   programs.program_name,
   programs.duration_months,
   enrollments.status
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
JOIN programs ON enrollments.program_id = programs.program_id
WHERE status = 'completed';

--Show dropped students and the program they dropped from.
SELECT
   students.full_name AS student_name,
   programs.program_name,
   programs.duration_months,
   enrollments.status
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
JOIN programs ON enrollments.program_id = programs.program_id
WHERE status = 'dropped';

--Show attendance records with student name, program name, date, and attended value
SELECT
    students.full_name AS student_name,
    programs.program_name,
    attendance.session_date,
    attendance.attended
FROM attendance
JOIN enrollments ON attendance.enrollment_id = enrollments.enrollment_id
JOIN students ON enrollments.student_id = students.student_id
JOIN programs ON enrollments.program_id = programs.program_id;

--Show payment records with student name, program name, payment month, status, and amount
SELECT
    students.full_name AS student_name,
    programs.program_name,
    payments.payment_date,
    payments.payment_status,
    payments.payment_amount
FROM payments
JOIN enrollments ON payments.enrollment_id = enrollments.enrollment_id
JOIN students ON enrollments.student_id = students.student_id
JOIN programs ON enrollments.program_id = programs.program_id;


--Show each student with city and all programs they are enrolled in
SELECT
    students.full_name AS student_name,
    students.city,
    programs.program_name
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN programs ON enrollments.program_id = programs.program_id;

--Show instructors and the students/programs they are responsible for
SELECT
    instructors.full_name AS instructor_name,
    instructors.specialization AS instructor_specialization,
    students.full_name AS student_name,
    programs.program_name
FROM instructors
JOIN enrollments ON instructors.instructor_id = enrollments.instructor_id
JOIN students ON enrollments.student_id = students.student_id
JOIN programs ON enrollments.program_id = programs.program_id;
  