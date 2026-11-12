Class User.Teacher Extends (%Persistent, User.Person, %Populate)
{
  Property Info As User.TeacherInfo;

  Property TargetGroups As list Of %String (POPSPEC = "##class(User.PopUtils).GroupCode()");

  Relationship Courses As User.Course [Cardinality = many, Inverse = Teacher];

  // 1.1 Simple query to retrieve all teachers with their basic information
  Query AllTeachers() As %SQLQuery(CONTAINID = 1)
  {
    SELECT ID, FullName, Info_Position AS Position, Info_Degree AS Degree
    FROM SQLUser.Teacher
    ORDER BY FullName
  }
}
