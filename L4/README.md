- Create classes in a DB from a Class Diagram from Practice 3.
- Create at least 2 objects of each class, set all their properties minding all the constraints (unique, required etc) and save all the objects to the DB.
  Objects and their properties should make sense.

**Used IRIS commands**

- Launch IRIS terminal:\
  `iris terminal IRIS`
- Compile classes in IRIS terminal:\
  `do $system.OBJ.ImportDir("C:\Users\Bohdan\Software\PDB\L4\Classes", "*.cls", "ck", , 1)`
- Compile routines:\
  `do $system.OBJ.ImportDir("C:\Users\Bohdan\Software\PDB\L4\Routines", "*.mac", "ck", , 1)`
- Run routines:\
  `do ^Seed`\
  `do ^Show`
