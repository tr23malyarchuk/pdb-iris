// Subclass 1
public class Student extends Person {
    public Student(String name, int id) {
        super(name, id);
    }

    @Override
    public void displayRole() {
        System.out.println("Student: " + getName() + " (ID: " + getId() + ")");
    }
}