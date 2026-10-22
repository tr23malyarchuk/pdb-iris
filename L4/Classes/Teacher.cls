Class User.Teacher Extends (User.Person, %Persistent)
{
Property Info As User.TeacherInfo;

Property TargetGroups As list Of %String;

Relationship Courses As User.Course [ Cardinality = many, Inverse = Teacher ];
}
