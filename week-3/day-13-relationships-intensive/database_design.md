# Database Design

## Project Goal

The goal of this database is to organize and manage a training system. It stores information about students, instructors, courses, enrollments, attendance, assignments, and submissions. The tables are connected using primary keys and foreign keys to reduce duplicate data and maintain data integrity.

---

## Database Tables

### students
Represents people attending the training.

**Primary Key:** `student_id`

One student can have many enrollments and many submissions.

### instructors
Represents instructors who teach courses.

**Primary Key:** `instructor_id`

One instructor can teach many courses.

### courses
Represents training courses or modules.

**Primary Key:** `course_id`

Each course belongs to one instructor and can have many enrollments.

### enrollments
Represents the relationship between students and courses.

**Primary Key:** `enrollment_id`

This is a bridge table that connects students and courses.

### attendance
Represents attendance records for each enrollment.

**Primary Key:** `attendance_id`

Each enrollment can have many attendance records.

### assignments
Represents assignments created for a course.

**Primary Key:** `assignment_id`

Each course can have many assignments.

### submissions
Represents student submissions for assignments.

**Primary Key:** `submission_id`

Each submission belongs to one student and one assignment.

---

# Primary Keys

| Table | Primary Key |
|--------|-------------|
| students | student_id |
| instructors | instructor_id |
| courses | course_id |
| enrollments | enrollment_id |
| attendance | attendance_id |
| assignments | assignment_id |
| submissions | submission_id |

---

# Foreign Keys

| Table | Foreign Key | References |
|--------|-------------|------------|
| courses | instructor_id | instructors(instructor_id) |
| enrollments | student_id | students(student_id) |
| enrollments | course_id | courses(course_id) |
| attendance | enrollment_id | enrollments(enrollment_id) |
| assignments | course_id | courses(course_id) |
| submissions | student_id | students(student_id) |
| submissions | assignment_id | assignments(assignment_id) |

---

# One-to-Many Relationships

- One instructor can teach many courses.
- One course can have many enrollments.
- One course can have many assignments.
- One student can have many enrollments.
- One enrollment can have many attendance records.
- One assignment can have many submissions.
- One student can have many submissions.

---

# Many-to-Many Relationship

Students and courses have a many-to-many relationship.

- One student can enroll in many courses.
- One course can have many students.

This relationship is handled by the **enrollments** table, which acts as a bridge table. It stores the `student_id` and `course_id` to connect students with courses without duplicating data.

---

# Why course_name should not be stored inside students

The `course_name` should not be stored repeatedly in the `students` table because one student can enroll in multiple courses. Repeating course names would create duplicate data and make updates more difficult. Instead, the `enrollments` table connects students and courses using IDs, which keeps the database organized and normalized.
