Class User.Student Extends (%Persistent, User.Person)
{
Property Info As User.StudentInfo [ Required ];

Property BioPhoto As %Stream.GlobalBinary;

Property Rating1 As %Integer(MAXVAL = 50, MINVAL = 0);
Property Rating2 As %Integer(MAXVAL = 50, MINVAL = 0);

Property TotalRating As %Integer [ Calculated ];

Relationship Course As User.Course [ Cardinality = one, Inverse = EnrolledStudents ];

Method TotalRatingGet() As %Integer
{
    Quit (..Rating1 + ..Rating2)
}
}
