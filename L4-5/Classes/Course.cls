Class User.Course Extends (%Persistent, %Populate)
{
  Property Title As %String(MAXLEN = 100, POPSPEC = "##class(User.PopUtils).CourseTitle()") [
    Required
  ];
  Property Credits As %Integer(MAXVAL = 10, MINVAL = 1);
  Property HoursLectures As %Integer(MAXVAL = 80, MINVAL = 10);
  Property HoursPractice As %Integer(MAXVAL = 80, MINVAL = 10);
  Property HoursSelf As %Integer(MAXVAL = 120, MINVAL = 20);
  Property TotalHours As %Integer [Calculated]; // callculated property to get total hours
  Property ControlType As %String(VALUELIST = ",Exam,Credit");

  Index TitleIndex On Title [IdKey, PrimaryKey, Unique];

  Relationship Teacher As User.Teacher [Cardinality = one, Inverse = Courses];

  Relationship EnrolledStudents As User.Student [Cardinality = many, Inverse = Course];

  Property ExtraNotes As array Of %String(POPSPEC = "String(25):3:String(5)");

  // Classmethod to calculate total hours
  ClassMethod CalculateTotalHours(
    lectures As %Integer,
    practice As %Integer,
    selfStudy As %Integer
  ) As %Integer
  {
    Quit (lectures + practice + selfStudy)
  }

  // Call the class method to calculate total hours for the calculated property
  Method TotalHoursGet() As %Integer [CodeMode = expression, ServerOnly = 1]
  {
    ##class(User.Course).CalculateTotalHours(..HoursLectures, ..HoursPractice, ..HoursSelf)
  }

  /// 2. COS query to retrieve all courses with their details, including total hours
  Query AllCoursesCOS() As %Query(ROWSPEC = "ID:%Integer,Title:%String,ControlType:%String,TotalHours:%Integer")
  {
  }

  ClassMethod AllCoursesCOSExecute(ByRef qHandle As %Binary) As %Status
  {
    Set qHandle = ""
    Quit $$$OK
  }

  ClassMethod AllCoursesCOSFetch(
    ByRef qHandle As %Binary,
    ByRef Row As %List,
    ByRef AtEnd As %Integer = 0
  ) As %Status
  {
    Set qHandle = $Order(^User.CourseD(qHandle), 1, data)
    If qHandle = "" {
      Set AtEnd = 1, Row = ""
      Quit $$$OK
    }
    Set total = ..CalculateTotalHours($ListGet(data, 4), $ListGet(data, 5), $ListGet(data, 6))
    Set Row = $ListBuild(qHandle, $ListGet(data, 2), $ListGet(data, 7), total)
    Quit $$$OK
  }

  ClassMethod AllCoursesCOSClose(ByRef qHandle As %Binary) As %Status
  {
    Kill qHandle
    Quit $$$OK
  }

  /// 3.3 Dynamic query with -> operator to retrieve courses based on control type, including teacher information
  ClassMethod ShowCoursesDynamic(controlType As %String = "Exam")
  {
    Set sql = "SELECT ID, Title, Credits, Teacher->FullName AS TeacherName FROM SQLUser.Course WHERE ControlType = ? ORDER BY Title"
    Set stmt = ##class(%SQL.Statement).%New()
    Set status = stmt.%Prepare(sql)
    If $$$ISERR(status) {
      Do $System.OBJ.DisplayError(status)
      Quit
    }
    Set rset = stmt.%Execute(controlType)
    Do rset.%Display()
  }

  /// 4. Trigger for logging course creation and updates in the ^CourseLog global
  Trigger LogCourseChanges [Event = INSERT/UPDATE, Foreach = row/object, Time = AFTER]
  {
    Set id = {ID}
    Set op = {%%OPERATION}
    Set ts = $ZDateTime($Horolog, 3)
    Set ^CourseLog(id, op, ts, "Title") = {Title}
    Set ^CourseLog(id, op, ts, "ControlType") = {ControlType}
  }
}
