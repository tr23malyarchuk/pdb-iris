Class User.StudentInfo Extends %Persistent
{
Property GroupNumber As %String(MAXLEN = 10, MINLEN = 2) [ Required ];
Property Specialty As %String;
Property Institute As %String;
Property CourseNumber As %Integer;
Property Status As %String(VALUELIST = ",Учится,Отчислен,Академ");
}
