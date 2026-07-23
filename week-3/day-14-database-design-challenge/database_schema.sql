PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS programs;
DROP TABLE IF EXISTS students;

CREATE TABLE students(
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone_number TEXT NOT NULL,
    city TEXT NOT NULL
);

CREATE TABLE programs(
    program_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_name TEXT NOT NULL UNIQUE,
    duration_months INTEGER NOT NULL
);
CREATE TABLE instructors(
    instructor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE,
    phone TEXT,
    specialization TEXT
);
CREATE TABLE enrollments(
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    program_id INTEGER NOT NULL,
    instructor_id INTEGER NOT NULL,
    status TEXT NOT NULL CHECK(status IN ('active','completed','dropped')),
    enrollment_date TEXT NOT NULL,
    UNIQUE(student_id, program_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (program_id) REFERENCES programs(program_id),
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)

);
CREATE TABLE attendance(
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    enrollment_id INTEGER NOT NULL,
    session_date TEXT NOT NULL,
    attended INTEGER NOT NULL CHECK (attended IN (0, 1)),
    minutes_attended INTEGER NOT NULL CHECK (minutes_attended >= 0),
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);
CREATE TABLE payments(
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    enrollment_id INTEGER NOT NULL,
    payment_amount REAL NOT NULL CHECK(payment_amount >= 0),
    payment_status TEXT NOT NULL CHECK (payment_status IN ('paid', 'unpaid', 'partial')),
    payment_date DATE,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);