Class User.PopUtils
{
  // Discipline name generator
  ClassMethod CourseTitle() As %String
  {
    Set list = $ListBuild("Postrelational Databases",
        "Big Data",
        "Visualization of Graphical and Geometric Data",
        "Computer Networks",
        "Causal Artificial Intelligence",
        "Machine Learning",
        "Computer Vision",
        "Natural Language Processing")
    Set base = $List(list, $Random($ListLength(list)) + 1)
    Quit base_" #"_($Random(900) + 100)
  }

  // Group code name generator
  ClassMethod GroupCode() As %String
  {
    Set prefixes = $ListBuild("TP-61mp",
        "KH-23",
        "TB-52",
        "TP-11",
        "KH-12",
        "TB-22",
        "TP-31",
        "KH-42",
        "TB-32")
    Quit $List(prefixes, $Random($ListLength(prefixes)) + 1)
  }

  // Specialty name generator
  ClassMethod Specialty() As %String
  {
    Set list = $ListBuild("Computer Science",
        "Information Technology",
        "Software Engineering",
        "Cybersecurity",
        "Data Science",
        "Artificial Intelligence",
        "Computer Engineering",
        "Information Systems")
    Quit $List(list, $Random($ListLength(list)) + 1)
  }

  // Institute name generator
  ClassMethod Institute() As %String
  {
    Set list = $ListBuild("FICT", "IPSA", "ITS", "FAM", "RTF", "FPM", "FET", "FME", "FMM")
    Quit $List(list, $Random($ListLength(list)) + 1)
  }

  // Course number generator
  ClassMethod CourseNumber() As %Integer
  {
    Quit ($Random(6) + 1)
  }

  // Degree generator
  ClassMethod Degree() As %String
  {
    Set list = $ListBuild("Doctor of Philosophy",
        "Doctor of Technical Sciences",
        "Doctor of Jurisprudence")
    Quit $List(list, $Random($ListLength(list)) + 1)
  }

  // Scientific degree generator
  ClassMethod ScienceDegree() As %String
  {
    Set list = $ListBuild("Candidate of Science",
        "Doctor of Science",
        "Master of Science",
        "Bachelor of Science")
    Quit $List(list, $Random($ListLength(list)) + 1)
  }

  // Teacher position generator
  ClassMethod Position() As %String
  {
    Set list = $ListBuild("Assistant", "Senior Teacher", "Associate Professor", "Professor")
    Quit $List(list, $Random($ListLength(list)) + 1)
  }

  // Binary stream generator for image data
  ClassMethod BioPhotoGenerator() As %Stream.GlobalBinary
  {
    Set stream = ##class(%Stream.GlobalBinary).%New()
    Do stream.Write("IMAGE_DATA_"_$Random(1000000)_"_BINARY_DATA")
    Quit stream
  }
}
