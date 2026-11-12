# Laboratory work 4

- Create classes in a DB from a Class Diagram from Practice 3.
- Create at least 2 objects of each class, set all their properties minding all the constraints (unique, required etc) and save all the objects to the DB.
  Objects and their properties should make sense.

# Laboratory work 5

- Add an always computed property to one of the classes and write a getter for it.
- Create code for automatic data generation for all classes.
- Create code for Unit Testing a class/classes where there are unique, required, constrained properties and relationship and check that all tests succeed:
  - Test creation of the object
  - Test unique, required, constrained properties
  - Test behavior when deleting an object with many/children relationship
  - Test deletion of the object

**Used IRIS commands**

- Launch IRIS terminal:\
  `irissession IRIS`\
  or:\
  `iris terminal IRIS`
- Compile classes in IRIS terminal:\
  ```
  do $system.OBJ.ImportDir("C:\Users\Bohdan\Software\PDB\L4-5\Classes", "*.cls", "ck", , 1)
  ```
- Compile routines:\
  ```
  do $system.OBJ.ImportDir("C:\Users\Bohdan\Software\PDB\L4-5\Routines", "*.mac", "ck", , 1)
  ```
- Run routines:\
  `do ^Seed`\
  `do ^Show`

- Compile tests:\
  ```
  do $system.OBJ.Load("C:\Users\Bohdan\Software\PDB\L4-5\Tests\CourseSuite\CourseTests.cls", "ck")
  ```
