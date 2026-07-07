
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


#Average attendance
average_attendance = sum(s["attendance"] for s in students_dataset) / len(students_dataset)
print(f"Average attendance: {average_attendance:.2f}")

#Average homework score
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

print()    

#Students with low attendance
print("Students with low attendance:")
low_attendance = [student for student in students_dataset if student["attendance"] < 70]
if len(low_attendance) == 0:
    print("No students with low attendance")
else:
    for student in low_attendance:
        print(f"{student['name']}")

print()

#Strong students:
print("Strong students:")
for student in students_dataset:
    if student["attendance"] >= 80 and student["homework_score"] >= 80:
        print(student["name"])
      
print()  

#Students that need support: 
print("Students that need support:")
for student in students_dataset:
    if student["attendance"] < 60 or student["homework_score"] < 60:
        print(student["name"])