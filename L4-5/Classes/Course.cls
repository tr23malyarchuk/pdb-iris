Class User.Course Extends %Persistent
{
Property Title As %String(MAXLEN = 100) [ Required ];
Property Credits As %Integer;
Property HoursLectures As %Integer;
Property HoursPractice As %Integer;
Property HoursSelf As %Integer;
Property ControlType As %String(VALUELIST = ",Exam,Credit");

Index TitleIndex On Title [ Unique ];

Relationship Teacher As User.Teacher [ Cardinality = one, Inverse = Courses ];

Relationship EnrolledStudents As User.Student [ Cardinality = many, Inverse = Course ];

Property ExtraNotes As array Of %String;
}
