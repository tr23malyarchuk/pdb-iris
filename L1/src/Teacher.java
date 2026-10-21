// Subclass 2
public class Teacher extends Person {
    public Teacher(String name, int id) {
        super(name, id);
    }

    @Override
    public void displayRole() {
        System.out.println("Teacher: " + getName() + " (ID: " + getId() + ")");
    }

    // 2. Overloaded Methods
    // A: Takes one parameter
    public void assignHomework(String topic) {
        System.out.println(getName() + " assigned homework on: " + topic);
    }

    // B: Overloaded method with two parameters
    public void assignHomework(String topic, String dueDate) {
        System.out.println(getName() + " assigned homework on: " + topic + ". Due to: " + dueDate);
    }
}