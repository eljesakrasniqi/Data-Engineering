--Part 7 - HAVING Reports

--Show programs with more than 3 enrollments.
SELECT
    programs.program_name,
    COUNT(enrollments.enrollment_id) AS total_enrollments
FROM programs
JOIN enrollments ON programs.program_id = enrollments.program_id
GROUP BY programs.program_name
HAVING COUNT(enrollments.enrollment_id) > 3;

--Show cities with more than 2 students.
SELECT
    city,
    COUNT(student_id) AS total_students
FROM students
GROUP BY city
HAVING COUNT(student_id) > 2;

--Show students with attendance rate below 70% 
SELECT
    students.full_name AS student_name,
    AVG(attendance.attended) * 100 AS attendance_rate
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN attendance ON enrollments.enrollment_id = attendance.enrollment_id
GROUP BY students.student_id, students.full_name
HAVING AVG(attendance.attended) * 100 < 70;

--Show programs with collected revenue greater than 300
SELECT
    programs.program_name,
    SUM(payments.payment_amount) AS collected_revenue
FROM programs
JOIN enrollments ON programs.program_id = enrollments.program_id
JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
WHERE payments.payment_status = 'paid'
GROUP BY programs.program_name
HAVING SUM(payments.payment_amount) > 300;

--Show instructors with more than 3 active enrollments
SELECT
    instructors.full_name AS instructor_name,
    COUNT(enrollments.enrollment_id) AS active_enrollments
FROM instructors
JOIN enrollments ON instructors.instructor_id = enrollments.instructor_id
WHERE enrollments.status = 'active'
GROUP BY instructors.instructor_id, instructors.full_name
HAVING COUNT(enrollments.enrollment_id) > 3;

--Show programs with unpaid or partial payment amount greater than 100.
SELECT
    programs.program_name,
    SUM(payments.payment_amount) AS unpaid_partial_amount
FROM programs
JOIN enrollments ON programs.program_id = enrollments.program_id
JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
WHERE payments.payment_status IN ('unpaid', 'partial')
GROUP BY programs.program_name
HAVING SUM(payments.payment_amount) > 100;