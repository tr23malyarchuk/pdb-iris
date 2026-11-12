Class CourseSuite.CourseTests Extends %UnitTest.TestCase
{
  // Ensure a clean state before and after tests
  Method OnBeforeOneTest() As %Status
  {
    Do ##class(User.Student).%KillExtent()
    Do ##class(User.Course).%KillExtent()
    Do ##class(User.Teacher).%KillExtent()
    Quit $$$OK
  }
  Method OnAfterAllTests() As %Status
  {
    Do ##class(User.Student).%KillExtent()
    Do ##class(User.Course).%KillExtent()
    Do ##class(User.Teacher).%KillExtent()
    Quit $$$OK
  }

  /// 1. Test creation of a Course object and its calculated property
  Method TestCreateCourse()
  {
    Set course = ##class(User.Course).%New()
    Do $$$AssertTrue($IsObject(course), "Create new Course object")

    Set course.Title = "Postrelational Databases"
    Set course.Credits = 5
    Set course.HoursLectures = 36
    Set course.HoursPractice = 18
    Set course.HoursSelf = 96
    Set course.ControlType = "Exam"

    Set status = course.%Save()
    Do $$$AssertStatusOK(status, "Course saved successfully")
    Do $$$AssertEquals(course.TotalHours, 150, "Calculated TotalHours equals 150")
  }

  /// 2. Test unique constraint on Title and required field validation
  Method TestConstraints()
  {
    // Test required field (Required: Title)
    Set cNoTitle = ##class(User.Course).%New()
    Set statusReq = cNoTitle.%Save()
    Do $$$AssertStatusNotOK(statusReq, "Course requires Title")

    // Test value list constraint (VALUELIST: ControlType)
    Set cBadType = ##class(User.Course).%New()
    Set cBadType.Title = "Valid Course Title"
    Set cBadType.ControlType = "TestWork"
    Set statusVal = cBadType.%Save()
    Do $$$AssertStatusNotOK(statusVal, "ControlType must match VALUELIST (Exam or Credit)")

    // Test unique constraint (Unique: TitleIndex)
    Set c1 = ##class(User.Course).%New()
    Set c1.Title = "Unique Discipline"
    Do $$$AssertStatusOK(c1.%Save(), "First course with unique title saved")

    Set c2 = ##class(User.Course).%New()
    Set c2.Title = "Unique Discipline"
    Set statusUniq = c2.%Save()
    Do $$$AssertStatusNotOK(statusUniq, "Duplicate course Title is rejected")
  }

  /// 3. Test behaviour of deleting a Course object that has a relationship with a Student object
  Method TestDeleteWithRelationship()
  {
    Set course = ##class(User.Course).%New()
    Set course.Title = "Course With Student"
    Do $$$AssertStatusOK(course.%Save(), "Course saved")
    Set courseId = course.%Id()

    Set student = ##class(User.Student).%New()
    Set student.FullName = "Ivanov,Ivan"
    Set student.Info.GroupNumber = "TP-61mp"
    Set student.Course = course
    Do $$$AssertStatusOK(student.%Save(), "Student linked to course saved")
    Set studentId = student.%Id()

    // attempt to delete the course while it is still referenced by a student
    Set statusDelBlocked = ##class(User.Course).%DeleteId(courseId)
    Do $$$AssertStatusNotOK(statusDelBlocked, "Cannot delete Course while Student references it")
    Do $$$AssertTrue(##class(User.Course).%ExistsId(courseId), "Course still exists in DB")

    // unlink the student from the course and then delete the course
    Set student.Course = ""
    Do $$$AssertStatusOK(student.%Save(), "Student unlinked from course")

    Set statusDelAllowed = ##class(User.Course).%DeleteId(courseId)
    Do $$$AssertStatusOK(statusDelAllowed, "Course deleted after unlinking student")
    Do $$$AssertNotTrue(##class(User.Course).%ExistsId(courseId), "Course no longer exists in DB")
  }

  /// 4. Test deletion of an object without relationships
  Method TestDeleteWithoutRelationship()
  {
    Set course = ##class(User.Course).%New()
    Set course.Title = "Standalone Course"
    Do $$$AssertStatusOK(course.%Save(), "Standalone course saved")
    Set courseId = course.%Id()

    Set statusDel = ##class(User.Course).%DeleteId(courseId)
    Do $$$AssertStatusOK(statusDel, "Standalone course deleted successfully")
    Do $$$AssertNotTrue(##class(User.Course).%ExistsId(courseId), "Course no longer exists in DB")
  }
}
