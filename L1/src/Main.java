// TR-61mp Maliarchuk Bohdan
// Creation of a program using high-level language and OOP principles

// 4. Main Orchestrator
public class Main {
    public static void main(String[] args) {
        System.out.println("OOP Demonstration\n");

        // Create objects of all classes & populate simple properties
        Teacher headTeacher = new Teacher("Irene Mykhailova", 101);
        Student studentA = new Student("Vasyl", 501);
        Student studentB = new Student("Bohdan", 502);

        // Call inherited abstract behaviors & demonstrate overloading
        headTeacher.displayRole();
        headTeacher.assignHomework("Creation of high-level program using OOP principles");
        headTeacher.assignHomework("Work with lists and globals in IRIS", "Next Thursday");

        // Create structural object references and lists
        Course dbCourse = new Course("Postrelational Databases", headTeacher);

        // Populating lists of simple types
        dbCourse.addTopic("InterSystems IRIS multi-model DBMS");
        dbCourse.addTopic("Hierarchical model");
        dbCourse.addTopic("Object model");
        dbCourse.addTopic("Relational model");
        dbCourse.addTopic("Document model");
        dbCourse.addTopic("Work with the web");

        // Populating lists of objects
        dbCourse.enrollStudent(studentA);
        dbCourse.enrollStudent(studentB);

        // Call final method showing that all connections make sense
        dbCourse.printCourseDetails();
    }
}
