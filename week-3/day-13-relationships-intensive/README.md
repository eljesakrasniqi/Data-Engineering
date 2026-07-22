# Day 13 - Intensive Relationships and Foreign Keys

## Project Goal

The goal of this project is to design a relational database for a training management system using SQLite. The project focuses on primary keys, foreign keys, relationships, constraints, realistic seed data, and SQL JOIN reports for business analysis.

---

## Database Design

The database contains tables for students, instructors, courses, enrollments, attendance, assignments, and submissions. The design follows database normalization principles to reduce duplicate data and maintain data integrity.

---

## Tables and Relationships

- **students** – Stores student information.
- **instructors** – Stores instructor information.
- **courses** – Stores course information and links each course to an instructor.
- **enrollments** – Bridge table connecting students and courses.
- **attendance** – Stores attendance records for each enrollment.
- **assignments** – Stores assignments for each course.
- **submissions** – Stores assignment submissions for each student.

Relationships:

- One instructor → Many courses
- One course → Many assignments
- One student → Many enrollments
- One enrollment → Many attendance records
- One assignment → Many submissions
- Many students ↔ Many courses (through enrollments)

---

## Primary Keys, Foreign Keys, and Constraints

The database uses:

- Primary Keys with AUTOINCREMENT.
- Foreign Keys to enforce relationships.
- UNIQUE constraints for student emails and duplicate enrollments.
- CHECK constraints for course levels, enrollment status, attendance values, minutes attended, and submission status.

These constraints help maintain data quality and prevent invalid records.

---

## Seed Data

The database includes realistic sample data:

- 8 students
- 3 instructors
- 5 courses
- 12 enrollments
- 18 attendance records
- 6 assignments
- 12 submissions

The data allows meaningful JOIN queries and business reports.

---

## Constraint Tests

The project includes tests for:

- Invalid foreign keys
- Duplicate enrollments
- Duplicate email addresses
- Invalid course levels
- Invalid attendance minutes
- Invalid submission scores

These tests demonstrate that the database protects data integrity.

---

## JOIN Reports

The project includes reports using INNER JOIN and LEFT JOIN, including:

- Students with city and email
- Courses with instructors
- Assignments by course
- Student enrollments
- Active enrollments
- Attendance reports
- Submission reports
- Student count per course
- Students enrolled in multiple courses
- Average attendance
- Average assignment score
- Missing and late submissions
- Students without enrollments
- Assignments without submissions

---

## Manager Report

Business reports include:

- Courses with the most enrollments
- Students active in multiple courses
- Strongest average attendance
- Weakest assignment completion
- Students needing attention
- Instructor with the most active enrollments
- Final combined management report with student, course, instructor, attendance, and score information

---

## Screenshots

Include screenshots of:

- Database schema
- Seed data
- Constraint tests
- JOIN reports
- Manager reports

---

## What I Can Explain Live

- Primary Keys and Foreign Keys
- One-to-many and many-to-many relationships
- Bridge tables
- Database normalization
- CHECK and UNIQUE constraints
- INNER JOIN vs LEFT JOIN
- Aggregate functions (COUNT, AVG)
- Business reporting using SQL

---

## What I Would Improve Next

- Add triggers for advanced validation.
- Add indexes to improve query performance.
- Add more realistic business reports and dashboards.
- Create database views for common reports.
- Expand the schema with certificates and course schedules.