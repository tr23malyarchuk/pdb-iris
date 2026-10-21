import java.util.ArrayList;
import java.util.List;

// 3. Object references & lists (composition)
public class Course {
    private String courseName;                  // simple data type
    private Teacher instructor;                 // reference to another object
    private List<Student> enrolledStudents;     // list of objects
    private List<String> syllabusTopics;        // list of simple types (strings)

    public Course(String courseName, Teacher instructor) {
        this.courseName = courseName;
        this.instructor = instructor;
        this.enrolledStudents = new ArrayList<>();
        this.syllabusTopics = new ArrayList<>();
    }

    // Public methods to manipulate private data structures
    public void enrollStudent(Student student) {
        enrolledStudents.add(student);
    }

    public void addTopic(String topic) {
        syllabusTopics.add(topic);
    }

    public void printCourseDetails() {
        System.out.println("\nCourse Details: " + courseName);
        System.out.println("Taught by: " + instructor.getName());

        System.out.print("Syllabus: ");
        System.out.println(String.join(", ", syllabusTopics));

        System.out.println("Enrolled Roster:");
        for (Student student : enrolledStudents) {
            student.displayRole();
        }
    }
}