Class User.TeacherInfo Extends (%SerialObject, %Populate)
{
  Property Degree As %String(POPSPEC = "##class(User.PopUtils).Degree()");
  Property ScienceDegree As %String(POPSPEC = "##class(User.PopUtils).ScienceDegree()");
  Property Position As %String(POPSPEC = "##class(User.PopUtils).Position()");
}
