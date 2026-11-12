Class User.StudentInfo Extends (%SerialObject, %Populate)
{
  Property GroupNumber As %String(MAXLEN = 10, MINLEN = 2, POPSPEC = 
"##class(User.PopUtils).GroupCode()") [
    Required
  ];
  Property Specialty As %String(POPSPEC = 
"##class(User.PopUtils).Specialty()");
  Property Institute As %String(POPSPEC = 
"##class(User.PopUtils).Institute()");
  Property CourseNumber As %Integer(POPSPEC = 
"##class(User.PopUtils).CourseNumber()");
  Property Status As %String(VALUELIST = ",Studying,Expelled,AcademicBreak");
}
