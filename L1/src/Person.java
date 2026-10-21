// 1. Inheritance from the abstract class
public abstract class Person {
    // Public and private props
    private String name; // simple data type (string)
    private int id;      // simple data type (int)

    public Person(String name, int id) {
        this.name = name;
        this.id = id;
    }

    // Encapsulations via public getters
    public String getName() { return name; }
    public int getId() { return id; }

    // Abstract method to be overridden by subclasses
    public abstract void displayRole();
}