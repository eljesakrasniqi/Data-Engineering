--Which courses have the most enrollments?
SELECT
    courses.course_name,
    COUNT(enrollments.enrollment_id) AS total_enrollments
FROM courses 
JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name
ORDER BY total_enrollments DESC;

--Which students are active in more than one course?
SELECT
    students.full_name AS student_name,
    COUNT(enrollments.course_id) AS active_courses
FROM students 
JOIN enrollments ON stundents.student_id = enrollments.student_id
WHERE enrollments.status = 'active'
GROUP BY students.student_id, students.full_name
HAVING COUNT(enrollments.course_id) > 1;

--Which course has the strongest average attendance?
SELECT
    courses.course_name,
    AVG(attendance.minutes_attended) AS average_attendance_minutes
FROM courses 
JOIN enrollments ON courses.course_id = enrollments.course_id
JOIN attendance ON enrollments.enrollment_id = attendance.enrollment_id
WHERE attendance.attended = 1
GROUP BY courses.course_id, courses.course_name
ORDER BY average_attendance_minutes DESC
LIMIT 1;


-- Which students need attention because of missing/late submissions?
SELECT
    students.full_name AS student_name,
    courses.course_name,
    COUNT(submissions.submission_id) AS problems
FROM students 
JOIN submissions ON students.student_id = submissions.student_id
JOIN assignments ON submissions.assignment_id = assignments.assignment_id
JOIN courses ON assignments.course_id = courses.course_id
WHERE submissions.status IN ('missing', 'late')
GROUP BY students.student_id, students.full_name, courses.course_id, courses.course_name
ORDER BY problems DESC;


-- Final combined manager report
SELECT
    students.full_name AS student_name,
    courses.course_name,
    instructors.full_name AS instructor_name,
    enrollments.status AS enrollment_status,
    COUNT(attendance.attendance_id) AS total_sessions,
    SUM(attendance.attended) AS attended_sessions,
    SUM(attendance.minutes_attended) AS total_minutes,
    AVG(submissions.score) AS average_score
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
JOIN courses ON enrollments.course_id = courses.course_id
JOIN instructors ON courses.instructor_id = instructors.instructor_id
LEFT JOIN attendance ON enrollments.enrollment_id = attendance.enrollment_id
LEFT JOIN submissions  ON students.student_id = submissions.student_id
GROUP BY
    students.full_name,
    courses.course_name,
    instructors.full_name,
    enrollments.status;

