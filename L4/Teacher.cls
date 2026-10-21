Class User.Teacher Extends (User.Person, %Persistent)
{
Property Info As User.TeacherInfo;

// Колекції-списки (Коллекция-список строк и объектов)
Property TargetGroups As list Of %String;
Property Courses As list Of User.Course;
}
