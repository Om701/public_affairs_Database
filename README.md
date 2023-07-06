Public Affairs Database Schema
This is a database schema for a college system designed to manage the process of generating lectures and recording attendance for instructors. The schema is implemented using SQL Server and consists of several tables.

Tables
Auth: Stores user authentication information for the college system.
Building: Contains details about the college buildings, including their names and descriptions.
Course: Stores information about courses offered by the college, such as name, code, credit hours, semester, year, program, and related department and regulation.
CourseUpdates: Keeps track of updates made to specific courses, including the semester type.
Department: Stores details about college departments, including their names and descriptions.
DivisionDepartments: Links departments with divisions and tracks the number of students in each division.
InstructorRole: Stores different roles or positions that instructors can hold.
Instructor: Contains information about instructors, including their names, MAC addresses, date of birth, work years, department, and instructor role.
InstructorCourse: Links instructors with courses they are assigned to teach, including the number of groups.
Room: Stores details about college rooms, including names, QR codes, real and supported capacities, and related building.
Regulation: Stores information about regulations governing courses.
Lecture: Stores details about lectures, including section number, language, attendance, dashboard ID, instructor course, room, day of the week, and start time.
InstructorTime: Stores time availability for instructors, including start and end times, day of the week, and related instructor.
Database Relationships
The database schema includes various relationships between tables using foreign key constraints to maintain data integrity. Some notable relationships are:

The Course table has foreign key references to the Regulation and Department tables.
The CourseUpdates table references the Course table.
The Department table is referenced by the DivisionDepartments, Instructor, and Course tables.
The InstructorCourse table references the Instructor and Course tables.
The Room table has a foreign key reference to the Building table.
The Lecture table references the InstructorCourse and Room tables.
The InstructorTime table references the Instructor table.
