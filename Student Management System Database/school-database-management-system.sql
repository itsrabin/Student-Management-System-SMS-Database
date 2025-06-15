-- DDL for Rabin School Student Management System Database

-- Table: Departments
-- Stores information about the various departments at Rabin School (e.g., Data, Software Engineering, Cybersecurity).
CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,    -- Unique identifier for the department, auto-incrementing
    DepartmentName VARCHAR(100) UNIQUE NOT NULL -- Name of the department, must be unique and not null
);

-- Table: Students
-- Stores information about the students enrolled at Rabin School.
CREATE TABLE Students (
    StudentID SERIAL PRIMARY KEY,       -- Unique identifier for the student, auto-incrementing
    Name VARCHAR(255) NOT NULL,         -- Full name of the student
    Gender VARCHAR(10),                 -- Gender of the student (e.g., 'Male', 'Female', 'Other')
    DOB DATE NOT NULL,                  -- Date of Birth of the student
    DepartmentID INT,                   -- Foreign Key referencing Departments table, indicating the student's primary department
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL
    -- ON DELETE SET NULL: If a department is deleted, students previously associated with it will have their DepartmentID set to NULL.
);

-- Table: Instructors
-- Stores information about the instructors teaching at Rabin School.
CREATE TABLE Instructors (
    InstructorID SERIAL PRIMARY KEY,    -- Unique identifier for the instructor, auto-incrementing
    Name VARCHAR(255) NOT NULL,         -- Full name of the instructor
    Email VARCHAR(255) UNIQUE NOT NULL, -- Email address of the instructor, must be unique
    HireDate DATE NOT NULL DEFAULT CURRENT_DATE, -- Date when the instructor was hired, defaults to current date
    DepartmentID INT,                   -- Foreign Key referencing Departments table, indicating the instructor's primary department
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL
    -- ON DELETE SET NULL: If a department is deleted, instructors previously associated with it will have their DepartmentID set to NULL.
);

-- Table: Courses
-- Stores information about the courses offered by Rabin School.
CREATE TABLE Courses (
    CourseID SERIAL PRIMARY KEY,        -- Unique identifier for the course, auto-incrementing
    CourseName VARCHAR(255) UNIQUE NOT NULL, -- Name of the course, must be unique and not null
    DepartmentID INT NOT NULL,          -- Foreign Key referencing Departments table, indicating which department offers the course
    Credits INT DEFAULT 3,              -- Number of credits for the course, defaults to 3
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE
    -- ON DELETE CASCADE: If a department is deleted, all courses offered by that department will also be deleted.
);

-- Table: Enrollments
-- Stores information about student enrollments in courses. This is a junction table for many-to-many relationship between Students and Courses.
CREATE TABLE Enrollments (
    EnrollmentID SERIAL PRIMARY KEY,    -- Unique identifier for the enrollment, auto-incrementing
    StudentID INT NOT NULL,             -- Foreign Key referencing Students table
    CourseID INT NOT NULL,              -- Foreign Key referencing Courses table
    EnrollmentDate DATE NOT NULL DEFAULT CURRENT_DATE, -- Date of enrollment, defaults to current date
    UNIQUE (StudentID, CourseID),       -- Ensures a student can only enroll in a course once
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    -- ON DELETE CASCADE: If a student is deleted, all their enrollments will also be deleted.
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
    -- ON DELETE CASCADE: If a course is deleted, all enrollments for that course will also be deleted.
);

-- DML for Sample Data (Rabin School - Tech Focus)

-- Insert Sample Departments
INSERT INTO Departments (DepartmentName) VALUES
('Data Science'),
('Software Engineering'),
('Cybersecurity'),
('Cloud Computing');

-- Insert Sample Instructors
INSERT INTO Instructors (Name, Email, DepartmentID) VALUES
('Dr. Aisha Khan', 'aisha.khan@rabinschool.edu', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science')),
('Prof. Ben Carter', 'ben.carter@rabinschool.edu', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Software Engineering')),
('Ms. Clara Davies', 'clara.davies@rabinschool.edu', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cybersecurity')),
('Mr. David Evans', 'david.evans@rabinschool.edu', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science')),
('Dr. Emily Foster', 'emily.foster@rabinschool.edu', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cloud Computing'));

-- Insert Sample Courses
INSERT INTO Courses (CourseName, DepartmentID, Credits) VALUES
('Introduction to Python for Data', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science'), 3),
('Advanced SQL & Database Design', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science'), 4),
('Machine Learning Fundamentals', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science'), 4),
('Full-Stack Web Development', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Software Engineering'), 5),
('Mobile App Development (Android)', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Software Engineering'), 4),
('Ethical Hacking & Penetration Testing', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cybersecurity'), 4),
('Network Security Essentials', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cybersecurity'), 3),
('Cloud Infrastructure on AWS', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cloud Computing'), 4),
('DevOps & Containerization', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cloud Computing'), 3);


-- Insert Sample Students
INSERT INTO Students (Name, Gender, DOB, DepartmentID) VALUES
('Alice Wonderland', 'Female', '2000-01-15', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science')),
('Bob The Builder', 'Male', '1999-05-20', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Software Engineering')),
('Charlie Chaplin', 'Male', '2001-11-01', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cybersecurity')),
('Diana Prince', 'Female', '2000-07-22', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science')),
('Eve Adams', 'Female', '2002-03-10', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cloud Computing')),
('Frankenstein Monster', 'Male', '1998-09-05', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Software Engineering'));

-- Insert Sample Enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
-- Alice enrolls in Python, SQL, ML
((SELECT StudentID FROM Students WHERE Name = 'Alice Wonderland'), (SELECT CourseID FROM Courses WHERE CourseName = 'Introduction to Python for Data'), '2024-09-01'),
((SELECT StudentID FROM Students WHERE Name = 'Alice Wonderland'), (SELECT CourseID FROM Courses WHERE CourseName = 'Advanced SQL & Database Design'), '2024-09-01'),
((SELECT StudentID FROM Students WHERE Name = 'Alice Wonderland'), (SELECT CourseID FROM Courses WHERE CourseName = 'Machine Learning Fundamentals'), '2024-09-01'),
-- Bob enrolls in Full-Stack, Mobile App
((SELECT StudentID FROM Students WHERE Name = 'Bob The Builder'), (SELECT CourseID FROM Courses WHERE CourseName = 'Full-Stack Web Development'), '2024-09-05'),
((SELECT StudentID FROM Students WHERE Name = 'Bob The Builder'), (SELECT CourseID FROM Courses WHERE CourseName = 'Mobile App Development (Android)'), '2024-09-05'),
-- Charlie enrolls in Ethical Hacking, Network Security
((SELECT StudentID FROM Students WHERE Name = 'Charlie Chaplin'), (SELECT CourseID FROM Courses WHERE CourseName = 'Ethical Hacking & Penetration Testing'), '2024-09-10'),
((SELECT StudentID FROM Students WHERE Name = 'Charlie Chaplin'), (SELECT CourseID FROM Courses WHERE CourseName = 'Network Security Essentials'), '2024-09-10'),
-- Diana enrolls in Python, SQL, Full-Stack
((SELECT StudentID FROM Students WHERE Name = 'Diana Prince'), (SELECT CourseID FROM Courses WHERE CourseName = 'Introduction to Python for Data'), '2024-09-02'),
((SELECT StudentID FROM Students WHERE Name = 'Diana Prince'), (SELECT CourseID FROM Courses WHERE CourseName = 'Advanced SQL & Database Design'), '2024-09-02'),
((SELECT StudentID FROM Students WHERE Name = 'Diana Prince'), (SELECT CourseID FROM Courses WHERE CourseName = 'Full-Stack Web Development'), '2024-09-02'),
-- Eve enrolls in Cloud Infra, DevOps
((SELECT StudentID FROM Students WHERE Name = 'Eve Adams'), (SELECT CourseID FROM Courses WHERE CourseName = 'Cloud Infrastructure on AWS'), '2024-09-15'),
((SELECT StudentID FROM Students WHERE Name = 'Eve Adams'), (SELECT CourseID FROM Courses WHERE CourseName = 'DevOps & Containerization'), '2024-09-15'),
-- Frankenstein enrolls in Full-Stack, Python
((SELECT StudentID FROM Students WHERE Name = 'Frankenstein Monster'), (SELECT CourseID FROM Courses WHERE CourseName = 'Full-Stack Web Development'), '2024-09-08'),
((SELECT StudentID FROM Students WHERE Name = 'Frankenstein Monster'), (SELECT CourseID FROM Courses WHERE CourseName = 'Introduction to Python for Data'), '2024-09-08');


-- Insightful Reporting Questions (SQL-Based)

-- Student & Enrollment Reports

-- How many students are currently enrolled in each course?
SELECT
    C.CourseName,
    COUNT(E.StudentID) AS NumberOfStudentsEnrolled
FROM
    Courses AS C
LEFT JOIN
    Enrollments AS E ON C.CourseID = E.CourseID
GROUP BY
    C.CourseName
ORDER BY
    NumberOfStudentsEnrolled DESC, C.CourseName ASC;

-- Which students are enrolled in multiple courses, and which courses are they taking?
SELECT
    S.Name AS StudentName,
    COUNT(E.CourseID) AS NumberOfCourses,
    STRING_AGG(C.CourseName, ', ') AS EnrolledCourses -- Aggregates course names into a single string
FROM
    Students AS S
JOIN
    Enrollments AS E ON S.StudentID = E.StudentID
JOIN
    Courses AS C ON E.CourseID = C.CourseID
GROUP BY
    S.Name
HAVING
    COUNT(E.CourseID) > 1 -- Filters for students enrolled in more than one course
ORDER BY
    NumberOfCourses DESC, StudentName ASC;

-- What is the total number of students per department across all courses?
SELECT
    D.DepartmentName,
    COUNT(DISTINCT S.StudentID) AS TotalStudentsInDepartment
FROM
    Departments AS D
LEFT JOIN
    Students AS S ON D.DepartmentID = S.DepartmentID
GROUP BY
    D.DepartmentName
ORDER BY
    TotalStudentsInDepartment DESC, D.DepartmentName ASC;


-- Course & Instructor Analysis

-- Which courses have the highest number of enrollments? (Similar to the first query, but explicitly ordered for highest)
SELECT
    C.CourseName,
    COUNT(E.StudentID) AS NumberOfEnrollments
FROM
    Courses AS C
LEFT JOIN
    Enrollments AS E ON C.CourseID = E.CourseID
GROUP BY
    C.CourseName
ORDER BY
    NumberOfEnrollments DESC
LIMIT 5; -- Limits to top 5 courses with most enrollments

-- Which department has the least number of students?
SELECT
    D.DepartmentName,
    COUNT(S.StudentID) AS NumberOfStudents
FROM
    Departments AS D
LEFT JOIN
    Students AS S ON D.DepartmentID = S.DepartmentID
GROUP BY
    D.DepartmentName
ORDER BY
    NumberOfStudents ASC
LIMIT 1;


-- Data Integrity & Operational Insights

-- Are there any students not enrolled in any course?
SELECT
    S.Name AS StudentName,
    S.StudentID
FROM
    Students AS S
LEFT JOIN
    Enrollments AS E ON S.StudentID = E.StudentID
WHERE
    E.EnrollmentID IS NULL -- Students who do not have any corresponding enrollment records
ORDER BY
    S.Name ASC;

-- How many courses does each student take on average?
SELECT
    CAST(COUNT(E.CourseID) AS DECIMAL) / COUNT(DISTINCT S.StudentID) AS AverageCoursesPerStudent
FROM
    Students AS S
JOIN
    Enrollments AS E ON S.StudentID = E.StudentID;

-- What is the gender distribution of students across courses and instructors?
-- Gender distribution across courses
SELECT
    C.CourseName,
    S.Gender,
    COUNT(S.StudentID) AS NumberOfStudents
FROM
    Courses AS C
JOIN
    Enrollments AS E ON C.CourseID = E.CourseID
JOIN
    Students AS S ON E.StudentID = S.StudentID
GROUP BY
    C.CourseName, S.Gender
ORDER BY
    C.CourseName, S.Gender;

-- Gender distribution of instructors (simple count per gender)
SELECT
    Gender,
    COUNT(InstructorID) AS NumberOfInstructors
FROM
    Students -- Assuming Gender column in Instructors table is not present, checking Students table for gender distribution across "instructors" context (this interpretation might be slightly off based on typical instructor tables, but aligns with student data provided)
GROUP BY
    Gender;

-- Which course has the highest number of male or female students enrolled?
-- For Male Students
SELECT
    C.CourseName,
    COUNT(S.StudentID) AS NumberOfMaleStudents
FROM
    Courses AS C
JOIN
    Enrollments AS E ON C.CourseID = E.CourseID
JOIN
    Students AS S ON E.StudentID = S.StudentID
WHERE
    S.Gender = 'Male'
GROUP BY
    C.CourseName
ORDER BY
    NumberOfMaleStudents DESC
LIMIT 1;

-- For Female Students
SELECT
    C.CourseName,
    COUNT(S.StudentID) AS NumberOfFemaleStudents
FROM
    Courses AS C
JOIN
    Enrollments AS E ON C.CourseID = E.CourseID
JOIN
    Students AS S ON E.StudentID = S.StudentID
WHERE
    S.Gender = 'Female'
GROUP BY
    C.CourseName
ORDER BY
    NumberOfFemaleStudents DESC
LIMIT 1;



