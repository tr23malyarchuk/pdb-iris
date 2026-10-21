Class User.Student Extends (User.Person, %Persistent)
{
// Ссылка на сохраненный объект StudentInfo
Property Info As User.StudentInfo [ Required ];

Property Rating1 As %Integer;
Property Rating2 As %Integer;

// Обчислювана властивість (Вычисляемое свойство)
Property TotalRating As %Integer [ Calculated ];

Method TotalRatingGet() As %Integer
{
    Quit (..Rating1 + ..Rating2)
}
}
