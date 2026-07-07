
students_dataset = [
    {
        "student_id": 1,
        "name": "Arta",
        "city": "Vushtrri",
        "course": "Python",
        "age": 17,
        "attendance": 90,          
        "homework_score": 85     
    },
    {
        "student_id": 2,
        "name": "Blend",
        "city": "Prishtina",
        "course": "React",
        "age": 18,
        "attendance": 60,
        "homework_score": 70
    },
    {
        "student_id": 3,
        "name": "Dion",
        "city": "Vushtrri",
        "course": "Python",
        "age": 16,
        "attendance": 75,
        "homework_score": 95
    },
    {
        "student_id": 4,
        "name": "Elira",
        "city": "Mitrovica",
        "course": "React",
        "age": 17,
        "attendance": 80,
        "homework_score": 60
    },
    {
        "student_id": 5,
        "name": "Faton",
        "city": "Vushtrri",
        "course": "Data Enineering",
        "age": 19,
        "attendance": 100,
        "homework_score": 90
    },
    {
        "student_id": 6,
        "name": "Gresa",
        "city": "Prishtina",
        "course": "Python",
        "age": 18,
        "attendance": 55,
        "homework_score": 88
    }
]


#Detyra 1:
print("Total students:", len(students_dataset))

print()

print("Student names:")
for student in students_dataset:
    print(student["name"])

print()

print("Student details:")
for student in students_dataset:
    print(student["name"], "is from", student["city"], "and is learning", student["course"])

print()

#Detyra 2
print("Students from Vushtrri:")
vushtrri_students = [student for student in students_dataset if student["city"] == "Vushtrri"]


if len(vushtrri_students) == 0:
    print("No students from Vushtrri.")
else:
    for student in vushtrri_students:
        print(f"{student['name']}")

print()


print("Students with low attendance:")
low_attendance = [student for student in students_dataset if student["attendance"] < 70]
if len(low_attendance) == 0:
    print("No students with low attendance")
else:
    for student in low_attendance:
        print(f"{student['name']}")

print()
print("Students with homework score above 85:")
homework_score = [student for student in students_dataset if student["homework_score"] > 85]
if len(homework_score) == 0:
    print("No students with homework_score above 85")
else:
    for student in homework_score:
        print(f"{student['name']}")



#Detyra 3:
print()
average_attendance = sum(s["attendance"] for s in students_dataset) / len(students_dataset)
print(f"Average attendance: {average_attendance:.2f}")

average_homework= sum(s["homework_score"] for s in students_dataset) / len(students_dataset)
print(f"Average homework score: {average_homework:.2f}")


print()
city_counts = {}

for s in students_dataset:
    city = s["city"]
    if city in city_counts:
        city_counts[city] += 1
    else:
        city_counts[city] = 1

print("Students by city:")

for city, count in city_counts.items():
    print(f"{city}: {count}")

    
print()
course_counts = {}

for s in students_dataset:
    course = s["course"]
    if course in course_counts:
        course_counts[course] += 1
    else:
        course_counts[course] = 1

print("Students by course:")

for course, count in course_counts.items():
    print(f"{course}: {count}")



#Detyra 4:
print()
print("Performance status:")

for s in students_dataset:
    attendance = s["attendance"]
    homework = s["homework_score"]

    if attendance >= 80 and homework >= 80:
        status = "Strong"
    elif attendance >= 60 and homework >= 60:
        status = "Average"
    else:
        status = "Needs Support"

    print(f"{s['name']}: {status}")
    
print()
#Detyra 5    
clean_report = []

for student in students_dataset:
    attendance = student["attendance"]
    homework = student["homework_score"]

    if attendance >= 80 and homework >= 80:
        status = "Strong"
    elif attendance >= 60 and homework >= 60:
        status = "Average"
    else:
        status = "Needs Support"

    clean_report.append({
        "student_id": student["student_id"],
        "name": student["name"],
        "course": student["course"],
        "performance_status": status
    })

print("Clean report records:")
for student in clean_report:
    print(f"{student['student_id']} - {student['name']} - {student['course']} - {student['performance_status']}")
    
print()    
    
#Bonus task - Sort students
print("Sorted students:")
sorted_students = sorted(students_dataset, key=lambda s: s["homework_score"], reverse=True)

for student in sorted_students:
    print(student["name"], "-", student["homework_score"])
    
    