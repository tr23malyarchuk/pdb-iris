Class User.Student Extends (%Persistent, User.Person, %Populate)
{
  Property Info As User.StudentInfo [Required];

  Property BioPhoto As %Stream.GlobalBinary(POPSPEC = "##class(User.PopUtils).BioPhotoGenerator()");

  Property Rating1 As %Integer(MAXVAL = 50, MINVAL = 0);
  Property Rating2 As %Integer(MAXVAL = 50, MINVAL = 0);

  Property TotalRating As %Integer [Calculated];

  Relationship Course As User.Course [Cardinality = one, Inverse = EnrolledStudents];

  Method TotalRatingGet() As %Integer
  {
    Quit (..Rating1 + ..Rating2)
  }

  /// 1.2 Query with a default parameter value for groupCode, returning students in a specific group
  Query ByGroup(groupCode As %String = "TP-61mp") As %SQLQuery(CONTAINID = 1)
  {
    SELECT ID, FullName, (Rating1 + Rating2) AS TotalRating, Course->Title AS CourseTitle, Course->Teacher->FullName AS TeacherName
    FROM SQLUser.Student
    WHERE Info_GroupNumber = :groupCode
    ORDER BY FullName
  }

  /// 3.1 Simple built-in query to retrieve all students with their basic information
  ClassMethod CountStudentsByTeacher(teacherName As %String) As %Integer
  {
    New SQLCODE
    Set count = 0
    &sql(
      SELECT COUNT(*) INTO :count
               FROM SQLUser.Student
               WHERE Course->Teacher->FullName = :teacherName
    )
    If SQLCODE = 0 {
      Quit count
    }
    Quit 0
  }

  /// 3.2 Built-in query with cursor and -> operator to retrieve students with their course and teacher information
  ClassMethod PrintTopStudents(minRating As %Integer = 60)
  {
    New SQLCODE
    &sql(
      DECLARE TopStudCursor CURSOR FOR
               SELECT FullName, (Rating1 + Rating2), Course->Title, Course->Teacher->FullName
               INTO :sName, :sRating, :cTitle, :tName
               FROM SQLUser.Student
               WHERE (Rating1 + Rating2) >= :minRating
               ORDER BY (Rating1 + Rating2) DESC
    )

    &sql(OPEN TopStudCursor)
    If SQLCODE '= 0 {
      Write !, "Error opening cursor: ", SQLCODE
      Quit
    }

    For {
      &sql(FETCH TopStudCursor)
      Quit:(SQLCODE '= 0)
      Write !, "Student: ", sName, " | Rating: ", sRating, " | Course: ", cTitle, " | Teacher: ",
        tName
    }

    &sql(CLOSE TopStudCursor)
  }
}
