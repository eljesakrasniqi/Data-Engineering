--Part 6 - Aggregation Reports

--Count students by city
SELECT
    city,
    COUNT(*) AS total_students
FROM students
GROUP BY city
ORDER BY total_students DESC;

--Count enrollments by status
SELECT
   status
   COUNT(*) AS total_status,
FROM enrollments
GROUP BY status
ORDER BY total_status DESC;

--Count enrollments by program
SELECT
    programs.program_name,
    COUNT(enrollments.enrollment_id) AS total_enrollments
FROM programs
LEFT JOIN enrollments ON programs.program_id = enrollments.program_id
GROUP BY programs.program_name
ORDER BY total_enrollments DESC;

--Count active enrollments by program
SELECT
    programs.program_name,
    COUNT(enrollments.enrollment_id) AS active_enrollments
FROM programs
JOIN enrollments ON programs.program_id = enrollments.program_id
WHERE enrollments.status = 'active'
GROUP BY programs.program_name
ORDER BY active_enrollments DESC;

--Calculate total paid amount by program.
SELECT
    programs.program_name,
    SUM(payments.payment_amount) AS total_paid_amount
FROM programs
JOIN enrollments ON programs.program_id = enrollments.program_id
JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
WHERE payments.payment_status = 'paid'
GROUP BY programs.program_name
ORDER BY total_paid_amount DESC;

--Calculate unpaid or partial amount by program.
SELECT
    programs.program_name,
    SUM(payments.payment_amount) AS total_paid_amount
FROM programs
JOIN enrollments ON programs.program_id = enrollments.program_id
JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
WHERE payments.payment_status IN ('unpaid', 'partial')
GROUP BY programs.program_name
ORDER BY total_paid_amount DESC;

--Calculate collected revenue by city
SELECT
    students.city,
    SUM(payments.payment_amount) AS collected_revenue
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
WHERE payments.payment_status = 'paid'
GROUP BY students.city
ORDER BY collected_revenue DESC;

-- Calculate average attendance rate by student.
-- Formula: attended sessions / total sessions * 100
SELECT
    students.full_name AS student_name,
    AVG(attendance.attended) * 100 AS attendance_rate
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN attendance ON enrollments.enrollment_id = attendance.enrollment_id
GROUP BY students.student_id, students.full_name
ORDER BY attendance_rate DESC;

--Calculate average attendance rate by program
SELECT 
   programs.program_name,
   AVG(attendance.attended) * 100 as attendance_rate
FROM programs
JOIN enrollments ON programs.program_id = enrollments.program_id
JOIN attendance ON enrollments.enrollment_id = attendance.enrollment_id
GROUP BY programs.program_name
ORDER BY attendance_rate DESC;

--Show top 5 students by attendance rate
SELECT
    students.full_name AS student_name,
    AVG(attendance.attended) * 100 AS attendance_rate
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN attendance ON enrollments.enrollment_id = attendance.enrollment_id
GROUP BY students.student_id, students.full_name
ORDER BY attendance_rate DESC
LIMIT 5;

--Show top 5 programs by collected revenue.
SELECT
    programs.program_name,
    SUM(payments.payment_amount) AS collected_revenue
FROM programs
JOIN enrollments ON programs.program_id = enrollments.program_id
JOIN payments ON enrollments.enrollment_id = payments.enrollment_id
WHERE payments.payment_status = 'paid'
GROUP BY programs.program_name
ORDER BY collected_revenue DESC
LIMIT 5;

--Show instructors ranked by number of active students
SELECT
    instructors.full_name AS instructor_name,
    COUNT(enrollments.student_id) AS active_students
FROM instructors
JOIN enrollments ON instructors.instructor_id = enrollments.instructor_id
WHERE enrollments.status = 'active'
GROUP BY instructors.instructor_id, instructors.full_name
ORDER BY active_students DESC;