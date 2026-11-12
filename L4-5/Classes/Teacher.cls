Class User.Teacher Extends (%Persistent, User.Person, %Populate)
{
  Property Info As User.TeacherInfo;

  Property TargetGroups As list Of %String (POPSPEC = "##class(User.PopUtils).GroupCode()");

  Relationship Courses As User.Course [Cardinality = many, Inverse = Teacher];
}
