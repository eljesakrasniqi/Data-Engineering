import csv
students = []

#Task 2:
def load_students():
    with open("data/students_raw.csv", "r", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        return list(reader)
students = load_students()

print("CSV Inspection")
print()
print("Total raw records:", len(students))

print()
print("Columns:")
print(list(students[0].keys()))

print()
print("First 3 records:")
for student in students[:3]:
    print(f"{student['student_id']} - {student['name']} - {student['city']} - {student['course']}")
print()

#Task 3:
def generate_report(students):
    missing_values = []
    invalid_numeric_values = []
    inconsistent_text_values = []

    numeric_columns = ["student_id", "age", "attendance", "homework_score"]
    text_columns = ["name", "city", "course"]

    # Missing values
    for student in students:
        for column, value in student.items():
            if value == "":
                missing_values.append(
                    f"student_id={student['student_id']}, column={column}"
                )

    # Invalid numeric values
    for student in students:
        for column in numeric_columns:
            value = student[column]

            if value != "":
                try:
                    int(value)
                except ValueError:
                    invalid_numeric_values.append(
                        f"student_id={student['student_id']}, column={column}, value={value}"
                    )

    # Inconsistent text values
    for student in students:
        for column in text_columns:
            value = student[column]

            if value != "":
                if value != value.title():
                    inconsistent_text_values.append(
                        f"student_id={student['student_id']}, column={column}, value={value}"
                    )


    total_issues = (
        len(missing_values)
        + len(invalid_numeric_values)
        + len(inconsistent_text_values)
    )


    with open("output/data_quality_report.txt", "w", encoding="utf-8") as file:

        file.write("Data Quality Report\n")
        file.write(f"Total issues found: {total_issues}\n\n")

        file.write("Missing values:\n")
        for item in missing_values:
            file.write(item + "\n")

        file.write("\nInvalid numeric values:\n")
        for item in invalid_numeric_values:
            file.write(item + "\n")

        file.write("\nInconsistent text values:\n")
        for item in inconsistent_text_values:
            file.write(item + "\n")

generate_report(students)


#Task 4:
def clean_students(students):
    cleaned_students = []

    for student in students:
        cleaned_student = student.copy()

        if cleaned_student["city"] == "":
            cleaned_student["city"] = "Unknown"
        elif cleaned_student["city"] == "VUSHTRRI":
            cleaned_student["city"] = "Vushtrri"
        elif cleaned_student["city"] == "prishtina":
            cleaned_student["city"] = "Prishtina"

        if cleaned_student["course"] == "":
            cleaned_student["course"] = "Not Assigned"
        elif cleaned_student["course"] == "Data engineering":
            cleaned_student["course"] = "Data Engineering"

        if cleaned_student["age"] == "":
            cleaned_student["age"] = "0"

        if cleaned_student["attendance"] == "":
            cleaned_student["attendance"] = "0"
        else:
            try:
                int(cleaned_student["attendance"])
            except ValueError:
                cleaned_student["attendance"] = "0"

        if cleaned_student["homework_score"] == "":
            cleaned_student["homework_score"] = "0"

        if cleaned_student["registered_date"] == "":
            cleaned_student["registered_date"] = "Unknown Date"

        #Convert student_id, age, attendance, and homework_score into numbers after cleaning:
        numeric_columns = ["student_id", "age", "attendance", "homework_score"]

        for column in numeric_columns:
            cleaned_student[column] = int(cleaned_student[column])

        #Create a new field named total_score, calculated as attendance + homework_score:
        cleaned_student["total_score"] = (
            cleaned_student["attendance"] + cleaned_student["homework_score"]
        )
        
        # Create attendance_level field -- Bonus level
        if cleaned_student["attendance"] >= 80:
           cleaned_student["attendance_level"] = "High"

        elif cleaned_student["attendance"] >= 60:
            cleaned_student["attendance_level"] = "Medium"

        else:
          cleaned_student["attendance_level"] = "Low"


        cleaned_students.append(cleaned_student)

    return cleaned_students


def save_cleaned_students(cleaned_students):
    with open("output/students_clean.csv", "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(
            file,
            fieldnames=cleaned_students[0].keys()
        )

        writer.writeheader()
        writer.writerows(cleaned_students)


cleaned_students = clean_students(students)

save_cleaned_students(cleaned_students)


#Task 5:
def students_performance_status(students):
    for student in students:

        attendance = student["attendance"]
        homework_score = student["homework_score"]

        # Performance status
        if attendance >= 80 and homework_score >= 80:
            student["performance_status"] = "Strong"

        elif attendance >= 60 and homework_score >= 60:
            student["performance_status"] = "Average"

        else:
            student["performance_status"] = "Needs Support"

        # Risk flag
        if attendance < 60 or homework_score < 60:
            student["risk_flag"] = "At Risk"

        else:
            student["risk_flag"] = "OK"

    return students


cleaned_students = students_performance_status(cleaned_students)

print("Performance Status")

for student in cleaned_students:
    print(
        f"{student['name']}: {student['performance_status']} - {student['risk_flag']}"
    )
    
def save_students_performance(cleaned_students):
    with open("output/students_clean.csv", "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(
            file,
            fieldnames=cleaned_students[0].keys()
        )

        writer.writeheader()
        writer.writerows(cleaned_students)


save_students_performance(cleaned_students)


print()

#Save report to summary_report.txt
from collections import Counter
def generate_final_report(raw_students, cleaned_students):
    with open("output/summary_report.txt", "w", encoding="utf-8") as file:

        file.write("Final Student Data Report\n\n")

        # Total records
        file.write(f"Total raw records: {len(raw_students)}\n")
        file.write(f"Total cleaned records: {len(cleaned_students)}\n")

        total_issues = 9
        file.write(f"Total data quality issues found: {total_issues}\n\n")


        # Average values
        average_attendance = sum(
            student["attendance"] for student in cleaned_students
        ) / len(cleaned_students)

        average_homework = sum(
            student["homework_score"] for student in cleaned_students
        ) / len(cleaned_students)

        file.write(f"Average attendance: {average_attendance:.2f}\n")
        file.write(f"Average homework score: {average_homework:.2f}\n")


        # Students by city
        file.write("\nStudents by city:\n")

        cities = Counter(student["city"] for student in cleaned_students)

        for city, count in cities.items():
            file.write(f"{city}: {count}\n")


        # Students by course
        file.write("\nStudents by course:\n")

        courses = Counter(student["course"] for student in cleaned_students)

        for course, count in courses.items():
            file.write(f"{course}: {count}\n")


        # Strong students
        file.write("\nStrong students:\n")

        for student in cleaned_students:
            if student["performance_status"] == "Strong":
                file.write(f"{student['name']}\n")


        # Needs Support
        file.write("\nStudents that need support:\n")

        for student in cleaned_students:
            if student["performance_status"] == "Needs Support":
                file.write(f"{student['name']}\n")


        # At Risk
        file.write("\nAt Risk students:\n")

        for student in cleaned_students:
            if student["risk_flag"] == "At Risk":
                file.write(f"{student['name']}\n")


        # Top 3
        file.write("\nTop 3 students by total score:\n")

        top_students = sorted(
            cleaned_students,
            key=lambda student: student["total_score"],
            reverse=True
        )[:3]

        for student in top_students:
            file.write(
                f"{student['name']}: {student['total_score']}\n"
            )
        
generate_final_report(students, cleaned_students)





