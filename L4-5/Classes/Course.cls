Class User.Course Extends %Persistent
{
Property Title As %String(MAXLEN = 100) [ Required ];
Property Credits As %Integer;
Property HoursLectures As %Integer;
Property HoursPractice As %Integer;
Property HoursSelf As %Integer;
Property TotalHours As %Integer [ Calculated ]; // callculated property to get total hours
Property ControlType As %String(VALUELIST = ",Exam,Credit");

Index TitleIndex On Title [ Unique ];

Relationship Teacher As User.Teacher [ Cardinality = one, Inverse = Courses ];

Relationship EnrolledStudents As User.Student [ Cardinality = many, Inverse = Course ];

Property ExtraNotes As array Of %String;

// Classmethod to calculate total hours
ClassMethod CalculateTotalHours(lectures As %Integer, practice As %Integer, selfStudy As %Integer) As %Integer
{
    Quit (lectures + practice + selfStudy)
}

// Call the class method to calculate total hours for the calculated property
Method TotalHoursGet() As %Integer [ CodeMode = expression, ServerOnly = 1]
{
    ##class(User.Course).CalculateTotalHours(..HoursLectures, ..HoursPractice, ..HoursSelf)
}
}