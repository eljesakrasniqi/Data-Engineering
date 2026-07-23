# Database Design - Day 14

## Project Goal

The goal of this database is to manage a training center. It stores information about students, programs, instructors, enrollments, attendance, and payments. The database supports reporting on student progress, attendance, payments, revenue, and program performance.

---

## Tables

### Students
Stores student information such as name, email, phone number, and city.

### Programs
Stores information about available training programs.

### Instructors
Stores instructor information.

### Enrollments
Connects students with programs and instructors. It also stores the enrollment status.

### Attendance
Stores attendance records for each enrollment.

### Payments
Stores payment records, payment amount, and payment status.

---

## Primary Keys

 Table:        Primary Key:
 students  -   student_id 
 programs  -   program_id 
 instructors - instructor_id 
 enrollments - enrollment_id 
 attendance -  attendance_id 
 payments  -   payment_id 

---

## Foreign Keys

 Table - Foreign Key - References 
 enrollments - student_id - students(student_id) 
 enrollments - program_id - programs(program_id) 
 enrollments - instructor_id - instructors(instructor_id) 
 attendance - enrollment_id - enrollments(enrollment_id) 
 payments - enrollment_id - enrollments(enrollment_id) 

---

## Relationship Type

- One student can have many enrollments.
- One program can have many enrollments.
- One instructor can manage many enrollments.
- One enrollment belongs to one student.
- One enrollment belongs to one program.
- One enrollment belongs to one instructor.
- One enrollment can have many attendance records.
- One enrollment can have many payment records.

---

## Constraints

- **PRIMARY KEY** ensures every record is unique.
- **FOREIGN KEY** maintains relationships between tables.
- **NOT NULL** prevents missing required values.
- **UNIQUE** prevents duplicate email addresses.
- **CHECK** limits valid values:
  - Enrollment status: active, completed, dropped.
  - Payment status: paid, unpaid, partial.
  - Attendance status: present, absent.
  - Payment amount must be greater than or equal to 0.

These constraints help keep the data accurate and consistent.

---

## Report Readiness

This database design supports business reports such as:

- Active students by program.
- Student attendance rate.
- Students with low attendance.
- Paid, unpaid, and partial payments.
- Total revenue by program.
- Program performance.
- Students at academic risk.
- Students at financial risk.
- Instructor workload.