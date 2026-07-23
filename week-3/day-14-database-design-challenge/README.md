# Day 14 - Database Design Challenge

## Project Goal

The goal of this project is to design and build a relational database for a training center. The database manages students, programs, instructors, enrollments, attendance, and payments while supporting business reporting and data quality checks.

---

## Business Requirements

The system must support:

- Student information
- Training programs
- Instructors
- Student enrollments
- Attendance tracking
- Payment tracking
- Academic and financial risk analysis
- Business reporting
- Data quality validation

---

## Database Design

The database contains the following tables:

### Students
Stores student information such as name, email, phone number, and city.

### Programs
Stores available training programs.

### Instructors
Stores instructor information and specialization.

### Enrollments
Connects students, programs, and instructors while tracking enrollment status.

### Attendance
Stores attendance records for each enrollment.

### Payments
Stores payment amount, payment status, and payment date for each enrollment.

---

## Relationships

- One student can have many enrollments.
- One program can have many enrollments.
- One instructor can manage many enrollments.
- One enrollment belongs to one student.
- One enrollment belongs to one program.
- One enrollment belongs to one instructor.
- One enrollment can have many attendance records.
- One enrollment can have many payment records.

Primary Keys:
- student_id
- program_id
- instructor_id
- enrollment_id
- attendance_id
- payment_id

Foreign Keys:
- enrollments.student_id → students.student_id
- enrollments.program_id → programs.program_id
- enrollments.instructor_id → instructors.instructor_id
- attendance.enrollment_id → enrollments.enrollment_id
- payments.enrollment_id → enrollments.enrollment_id

---

## Constraints

The database uses several constraints to protect data quality:

- PRIMARY KEY for unique records.
- FOREIGN KEY to maintain relationships.
- NOT NULL to require important values.
- UNIQUE to prevent duplicate emails and program names.
- CHECK for:
  - Enrollment status (active, completed, dropped)
  - Payment status (paid, unpaid, partial)
  - Attendance values (0 or 1)
  - Non-negative payment amounts
  - Non-negative attendance minutes

---

## How to Run

Run the SQL files in this order:

1. database_schema.sql
2. insert_data.sql
3. relationship_tests.sql
4. join_reports.sql
5. aggregation_reports.sql
6. having_reports.sql
7. data_quality_checks.sql

---

## Business Insights

The reports answer important business questions such as:

- Which program has the most active students.
- Which program generates the most revenue.
- Which city has the most students.
- Which students are academically or financially at risk.
- Which instructor manages the most active students.
- Which programs have the weakest attendance.
- Which enrollments are missing payment records.

---

## Data Quality Checks

The project identifies:

- Students without enrollments.
- Programs without enrollments.
- Enrollments without attendance records.
- Enrollments without payment records.
- Active students with unpaid or partial payments.
- Students with low attendance.
- Students with high attendance but unpaid payments.
- Dropped students with payment records.
- Instructors without active students.
- Other incomplete or inconsistent records.

---

## What I Can Explain Live

I can explain:

- Database design decisions.
- Primary keys and foreign keys.
- One-to-many relationships.
- Why constraints are important.
- INNER JOIN and LEFT JOIN.
- Aggregate functions (COUNT, SUM, AVG).
- GROUP BY and HAVING.
- Attendance rate calculation.
- Business reporting.
- Data quality validation queries.