--Show all students with their city and email
SELECT
  students.full_name,
  students.city, 
  students.email
FROM students;

--Show all courses with instructor name and specialization
SELECT
  courses.course_name,
  instructors.full_name,
  instructors.specialization
FROM courses
JOIN instructors ON courses.instructor_id = instructors.instructor_id;

--Show all assignments with course name and due date.
SELECT
   courses.course_name,
   assignments.title,
   assignments.due_date
FROM assignments
JOIN courses ON assignments.course_id = courses.course_id;

--Show all enrollments with student name, course name, enrollment date, and status.
SELECT
    students.full_name AS student_name,
    courses.course_name,
    enrollments.enrollment_date,
    enrollments.status
FROM enrollments 
JOIN students ON enrollments.student_id = students.student_id
JOIN courses ON enrollments.course_id = courses.course_id;

--Show only active enrollments.
SELECT
    students.full_name AS student_name,
    courses.course_name,
    enrollments.enrollment_date,
    enrollments.status
FROM enrollments 
JOIN students ON enrollments.student_id = students.student_id
JOIN courses ON enrollments.course_id = courses.course_id
WHERE status = 'active';

--Show attendance records with student, course, session date, attended, and minutes_attended.
SELECT 
   students.full_name AS student_name,
   courses.course_name,
   attendance.session_date,
   attendance.attended,
   attendance.minutes_attended
FROM attendance
JOIN enrollments ON attendance.enrollment_id = enrollments.enrollment_id
JOIN students ON enrollments.student_id = students.student_id
JOIN courses ON enrollments.course_id = courses.course_id;

--Show submissions with student name, assignment title, course name, score, and status.
SELECT 
  students.full_name AS student_name,
  assignments.title,
  courses.course_name,
  submissions.score,
  submissions.status
FROM submissions
JOIN students ON submissions.student_id = students.student_id
JOIN assignments ON submissions.assignment_id = assignments.assignment_id
JOIN courses ON assignments.course_id = courses.course_id;

--Count students enrolled in each course
SELECT
    courses.course_name,
    COUNT(enrollments.student_id) AS total_students
FROM courses 
LEFT JOIN enrollments ON courses.course_id = enrollments.course_id
GROUP BY courses.course_id, courses.course_name;

--Show students enrolled in more than one course
SELECT
    students.full_name,
    COUNT(enrollments.course_id) AS number_of_courses
FROM students 
JOIN enrollments ON students.student_id = enrollments.student_id
GROUP BY students.student_id, students.full_name
HAVING COUNT(enrollments.course_id) > 1;

--Show average attendance minutes by course
SELECT
    courses.course_name,
    AVG(attendance.minutes_attended) AS average_minutes
FROM courses 
JOIN enrollments ON courses.course_id = enrollments.course_id
JOIN attendance ON enrollments.enrollment_id = attendance.enrollment_id
GROUP BY courses.course_id, courses.course_name;

-- Show average score by course
SELECT
    courses.course_name,
    AVG(submissions.score) AS average_score
FROM courses 
JOIN assignments ON courses.course_id = assignments.course_id
JOIN submissions ON assignments.assignment_id = submissions.assignment_id
GROUP BY courses.course_id, courses.course_name;

--Show missing or late submissions with student and course context
SELECT
    students.full_name AS student_name,
    courses.course_name,
    assignments.title AS assignment_title,
    submissions.status
FROM submissions
JOIN students ON submissions.student_id = students.student_id
JOIN assignments ON submissions.assignment_id = assignments.assignment_id
JOIN courses ON assignments.course_id = courses.course_id
WHERE submissions.status IN ('missing', 'late');

--Use LEFT JOIN to show students with no enrollments
SELECT
    students.full_name,
    students.city,
    enrollments.enrollment_id
FROM students 
LEFT JOIN enrollments ON students.student_id = enrollments.student_id
WHERE enrollments.enrollment_id IS NULL;

--Use LEFT JOIN to show assignments with no submissions
SELECT
    assignments.title AS assignment_title,
    courses.course_name
FROM assignments
LEFT JOIN submissions ON assignments.assignment_id = submissions.assignment_id
LEFT JOIN courses ON assignments.course_id = courses.course_id
WHERE submissions.submission_id IS NULL;