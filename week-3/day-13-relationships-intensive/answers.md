# Answers and Explanation

## 1. What problem does a primary key solve?

A primary key uniquely identifies each row in a table. It prevents duplicate records and allows other tables to reference the correct row.

---

## 2. What problem does AUTOINCREMENT solve?

AUTOINCREMENT automatically generates a unique ID for each new record. It removes the need to enter IDs manually and prevents duplicate IDs.

---

## 3. What problem does a foreign key solve?

A foreign key maintains relationships between tables and protects data integrity. It prevents inserting records that reference non-existing parent records.

---

## 4. Why is enrollments a bridge table?

The enrollments table connects students and courses. It allows one student to enroll in many courses and one course to have many students.

---

## 5. Why is submissions also a relationship table?

The submissions table connects students with assignments. It stores each student's submission, score, and submission status.

---

## 6. What is one-to-many in your project? Give two examples.

- One instructor can teach many courses.
- One course can have many assignments.

---

## 7. What is many-to-many in your project? Give one example.

Students and courses have a many-to-many relationship. This relationship is managed through the enrollments bridge table.

---

## 8. Why should we not store instructor_name directly inside every course report table?

Storing instructor_name repeatedly creates duplicate data. If the instructor's name changes, it would need to be updated in many places. Keeping it in one table makes the database easier to maintain and keeps the data consistent.

---

## 9. What is the difference between INNER JOIN and LEFT JOIN?

INNER JOIN returns only matching records from both tables.

LEFT JOIN returns all records from the left table, even when there is no matching record in the right table.

---

## 10. Which constraint test was most important and why?

The duplicate enrollment test was the most important because the UNIQUE(student_id, course_id) constraint prevents a student from being enrolled in the same course more than once.

---

## 11. How does this prepare you for Databricks tables and reporting?

This project teaches how to design relational databases, use primary keys and foreign keys, enforce data quality with constraints, and build JOIN reports. These are important skills for working with Databricks tables, data pipelines, and business reporting.