import iris

def search_academic_records():
    student_id = input("Введіть ID студента: ")

    conn = iris.connect("localhost", 1972, "USER", "_SYSTEM", "SYS")
    db = iris.createIRIS(conn)

    gbl = "^AcademicCourse"
    found = False

    course = ""
    while True:
        course = db.nextSubscript(False, gbl, course)
        if not course:
            break

        student = ""
        while True:
            student = db.nextSubscript(False, gbl, course, student)
            if not student:
                break

            date = ""
            while True:
                date = db.nextSubscript(False, gbl, course, student, date)
                if not date:
                    break

                lab = ""
                while True:
                    lab = db.nextSubscript(
                        False, gbl, course, student, date, lab
                    )
                    if not lab:
                        break

                    if str(student) == student_id:
                        value = db.get(gbl, course, student, date, lab)

                        if isinstance(value, iris.IRISList):
                            value = ",".join(
                                str(value.get(i))
                                for i in range(1, value.length() + 1)
                            )

                        print(
                            f"{course} | {student} | "
                            f"{date} | {lab} | {value}"
                        )
                        found = True

    if not found:
        print("Записів для цього студента не знайдено.")

    conn.close()

if __name__ == "__main__":
    search_academic_records()
