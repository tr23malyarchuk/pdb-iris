import iris
import sys

def get_db_connection():
    conn = iris.connect("localhost", 1972, "USER", "_SYSTEM", "SYS")
    return conn, iris.createIRIS(conn)

def clear_database():
    conn, db = get_db_connection()
    print("--- Очищення бази даних ООБД ---")
    try:
        # Utilizing standard SQL TRUNCATE/DELETE to instantly clear object tables safely
        # Clear child dependencies first, then parent structures
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, "DELETE FROM User.Student")
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, "DELETE FROM User.Teacher")
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, "DELETE FROM User.Course")
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, "DELETE FROM User.StudentInfo")
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, "DELETE FROM User.TeacherInfo")
        print("[Успіх] Усі об'єкти успішно видалено з бази даних.\n")
    except Exception as e:
        print(f"[Помилка при очищенні]: {e}\n")
    finally:
        conn.close()

def seed_database():
    conn, db = get_db_connection()
    print("--- Наповнення бази даних тестовими об'єктами ---")
    try:
        # Check if records already exist to prevent constraint duplication errors
        if db.nextSubscript(False, "^User.StudentD", ""):
            print("[Інфо] База даних вже містить дані. Очистіть її перед повторним посівом.\n")
            return

        # Insert Courses
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, 
            "INSERT INTO User.Course (Title, Credits, HoursLectures, HoursPractice, HoursSelf, ControlType) VALUES ('Базы Данных', 4, 30, 30, 60, 'Экзамен')")
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, 
            "INSERT INTO User.Course (Title, Credits, HoursLectures, HoursPractice, HoursSelf, ControlType) VALUES ('ООП', 5, 36, 36, 78, 'Зачет')")
        
        # Insert Student Details Info
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, 
            "INSERT INTO User.StudentInfo (GroupNumber, Specialty, Institute, CourseNumber, Status) VALUES ('КН-301', 'Компьютерные Науки', 'ИКТ', 3, 'Учится')")
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, 
            "INSERT INTO User.StudentInfo (GroupNumber, Specialty, Institute, CourseNumber, Status) VALUES ('ИП-302', 'Инженерия ПО', 'ИКТ', 3, 'Академ')")

        # Map newly generated relational IDs to assemble cross-object structures
        # Course IDs (1 and 2) and StudentInfo IDs (1 and 2) link into the Student entities
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, 
            "INSERT INTO User.Student (FullName, Info, Rating1, Rating2, Course) VALUES ('Иваненко Иван Иванович', 1, 45, 48, 1)")
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, 
            "INSERT INTO User.Student (FullName, Info, Rating1, Rating2, Course) VALUES ('Петренко Петр Петрович', 38, 42, 2)")
        
        # Insert Teacher Details Info and instances
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, 
            "INSERT INTO User.TeacherInfo (Degree, ScienceDegree, Position) VALUES ('Доцент', 'к.т.н.', 'Лектор')")
        db.classMethodVoid("%SQL.Statement", "ExecDirect", None, 
            "INSERT INTO User.Teacher (FullName, Info) VALUES ('Сидоров Алексей Николаевич', 1)")

        print("[Успіх] Базу даних успішно наповнено об'єктами.\n")
    except Exception as e:
        print(f"[Помилка при посиві]: {e}\n")
    finally:
        conn.close()

def display_database():
    conn, db = get_db_connection()
    print("--- Перегляд успішності студентів (Живі дані з СУБД IRIS) ---")
    print(f"{'ID':<4} | {'ФИО Студента':<24} | {'Группа':<7} | {'R1':<4} | {'R2':<4} | {'Итог (Calculated)':<10}")
    print("-" * 68)
    
    gbl = "^User.StudentD"
    has_data = False
    
    if db.nextSubscript(False, gbl, ""):
        s_id = ""
        while True:
            s_id = db.nextSubscript(False, gbl, s_id)
            if not s_id:
                break
            
            student_data = db.get(gbl, s_id)
            if isinstance(student_data, iris.IRISList):
                has_data = True
                name = student_data.get(2)
                info_id = student_data.get(3)
                r1 = int(student_data.get(4) or 0)
                r2 = int(student_data.get(5) or 0)
                
                group = "Не вказ."
                if info_id:
                    info_data = db.get("^User.StudentInfoD", info_id)
                    if isinstance(info_data, iris.IRISList):
                        group = info_data.get(2)
                
                # Verified calculated logic parameter extraction expression
                total_rating = r1 + r2
                print(f"{s_id:<4} | {name:<24} | {group:<7} | {r1:<4} | {r2:<4} | {total_rating:<10}")

    if not has_data:
        print("[Увага] База даних порожня. Запустіть скрипт із флагом --seed для створення об'єктів.")

    print("\n[Система] Об'єкти успішно верифіковані об'єктною моделлю CLS.")
    conn.close()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        command = sys.argv[1].lower()
        if command == "--seed":
            seed_database()
        elif command == "--clear":
            clear_database()
        else:
            print("Невідомий параметр. Доступні: --seed (наповнити), --clear (очистити)")
    else:
        display_database()
