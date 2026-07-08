--Part 5:

-- Query 1: Show all students
SELECT *
FROM school;

-- Query 2: Show only student names and courses
SELECT student_name, course
FROM school;


-- Query 3: Show only paid payments
SELECT *
FROM school
WHERE status = 'paid';


-- Query 4: Show unpaid payments
SELECT *
FROM school
WHERE status = 'unpaid';


-- Query 5: Show payments higher than 150
SELECT *
FROM school
WHERE amount > 150;


-- Query 6: Sort students by payment amount from highest to lowest
SELECT *
FROM school
ORDER BY amount DESC;


-- Query 7: Show who is in python course
SELECT *
FROM school
WHERE course = 'Python';

-- Query 8: Show the top 3 highest payments
SELECT
    student_name,
    course,
    amount
FROM school
ORDER BY amount DESC
LIMIT 3;


--Required queries for your custom table:

--Query 37: Show all rows from your custom table
SELECT *
FROM school;

--Query 38: Show only 2 or 3 selected columns
SELECT student_name, course
FROM school

--Query 39: Filter rows by a text/status column.
SELECT *
FROM school
WHERE status = 'paid';

-- Query 40: Filter rows by a numeric column using > or <
SELECT *
FROM school
WHERE amount > 150;

--Query 41: Combine two conditions using AND
SELECT *
FROM school
WHERE student_name = 'Arta'
AND status = 'paid';

--Query 42: Combine two conditions using OR
SELECT *
FROM school
WHERE status = 'paid'
OR course = 'Python';

--Query 43: Sort rows from highest to lowest by a numeric column
SELECT *
FROM school
ORDER BY amount DESC;

--Query 44: Limit the result to the top 3 rows
SELECT *
FROM school
ORDER BY amount DESC
LIMIT 3;

--Query 45: Create one calculated column using two existing columns.
SELECT
    student_name,
    amount,
    payment_id,
    amount + payment_id AS total_value
FROM school;

--Query 46: Create one business-ready query that looks like something a manager would use
SELECT
    student_name,
    course,
    amount,
    status
FROM school
WHERE status = 'paid'
ORDER BY amount DESC;