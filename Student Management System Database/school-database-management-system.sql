-- DDL for Rabin School Student Management System Database (Improved Version)

-- Table: Departments
CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(100) UNIQUE NOT NULL
);

-- Table: Students
CREATE TABLE Students (
    StudentID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Gender VARCHAR(10),
    DOB DATE NOT NULL,
    DepartmentID INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL
);

-- Table: Instructors
CREATE TABLE Instructors (
    InstructorID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Gender VARCHAR(10),
    HireDate DATE NOT NULL DEFAULT CURRENT_DATE,
    DepartmentID INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL
);

-- Table: Courses
CREATE TABLE Courses (
    CourseID SERIAL PRIMARY KEY,
    CourseName VARCHAR(255) UNIQUE NOT NULL,
    DepartmentID INT NOT NULL,
    Credits INT DEFAULT 3 CHECK (Credits > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE
);

-- Table: Enrollments
CREATE TABLE Enrollments (
    EnrollmentID SERIAL PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL DEFAULT CURRENT_DATE,
    UNIQUE (StudentID, CourseID),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

-- Indexes for performance
CREATE INDEX idx_students_department ON Students(DepartmentID);
CREATE INDEX idx_instructors_department ON Instructors(DepartmentID);
CREATE INDEX idx_enrollments_student ON Enrollments(StudentID);
CREATE INDEX idx_enrollments_course ON Enrollments(CourseID);


-- DML - Sample Data

-- Departments
INSERT INTO Departments (DepartmentName) VALUES
('Data Science'),
('Software Engineering'),
('Cybersecurity'),
('Cloud Computing');

-- Instructors
INSERT INTO Instructors (Name, Email, Gender, DepartmentID) VALUES
('Dr. Aisha Khan', 'aisha.khan@rabinschool.edu', 'Female', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science')),
('Prof. Ben Carter', 'ben.carter@rabinschool.edu', 'Male', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Software Engineering')),
('Ms. Clara Davies', 'clara.davies@rabinschool.edu', 'Female', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cybersecurity')),
('Mr. David Evans', 'david.evans@rabinschool.edu', 'Male', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science')),
('Dr. Emily Foster', 'emily.foster@rabinschool.edu', 'Female', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cloud Computing'));

-- Courses
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

-- Students
INSERT INTO Students (Name, Gender, DOB, DepartmentID) VALUES
('Alice Wonderland', 'Female', '2000-01-15', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science')),
('Bob The Builder', 'Male', '1999-05-20', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Software Engineering')),
('Charlie Chaplin', 'Male', '2001-11-01', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cybersecurity')),
('Diana Prince', 'Female', '2000-07-22', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Data Science')),
('Eve Adams', 'Female', '2002-03-10', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Cloud Computing')),
('Frankenstein Monster', 'Male', '1998-09-05', (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Software Engineering'));

-- Enrollments
-- Alice
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
((SELECT StudentID FROM Students WHERE Name = 'Alice Wonderland'), (SELECT CourseID FROM Courses WHERE CourseName = 'Introduction to Python for Data'), '2024-09-01'),
((SELECT StudentID FROM Students WHERE Name = 'Alice Wonderland'), (SELECT CourseID FROM Courses WHERE CourseName = 'Advanced SQL & Database Design'), '2024-09-01'),
((SELECT StudentID FROM Students WHERE Name = 'Alice Wonderland'), (SELECT CourseID FROM Courses WHERE CourseName = 'Machine Learning Fundamentals'), '2024-09-01');

-- Bob
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
((SELECT StudentID FROM Students WHERE Name = 'Bob The Builder'), (SELECT CourseID FROM Courses WHERE CourseName = 'Full-Stack Web Development'), '2024-09-05'),
((SELECT StudentID FROM Students WHERE Name = 'Bob The Builder'), (SELECT CourseID FROM Courses WHERE CourseName = 'Mobile App Development (Android)'), '2024-09-05');

-- Charlie
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
((SELECT StudentID FROM Students WHERE Name = 'Charlie Chaplin'), (SELECT CourseID FROM Courses WHERE CourseName = 'Ethical Hacking & Penetration Testing'), '2024-09-10'),
((SELECT StudentID FROM Students WHERE Name = 'Charlie Chaplin'), (SELECT CourseID FROM Courses WHERE CourseName = 'Network Security Essentials'), '2024-09-10');

-- Diana
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
((SELECT StudentID FROM Students WHERE Name = 'Diana Prince'), (SELECT CourseID FROM Courses WHERE CourseName = 'Introduction to Python for Data'), '2024-09-02'),
((SELECT StudentID FROM Students WHERE Name = 'Diana Prince'), (SELECT CourseID FROM Courses WHERE CourseName = 'Advanced SQL & Database Design'), '2024-09-02'),
((SELECT StudentID FROM Students WHERE Name = 'Diana Prince'), (SELECT CourseID FROM Courses WHERE CourseName = 'Full-Stack Web Development'), '2024-09-02');

-- Eve
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
((SELECT StudentID FROM Students WHERE Name = 'Eve Adams'), (SELECT CourseID FROM Courses WHERE CourseName = 'Cloud Infrastructure on AWS'), '2024-09-15'),
((SELECT StudentID FROM Students WHERE Name = 'Eve Adams'), (SELECT CourseID FROM Courses WHERE CourseName = 'DevOps & Containerization'), '2024-09-15');

-- Frankenstein
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
((SELECT StudentID FROM Students WHERE Name = 'Frankenstein Monster'), (SELECT CourseID FROM Courses WHERE CourseName = 'Full-Stack Web Development'), '2024-09-08'),
((SELECT StudentID FROM Students WHERE Name = 'Frankenstein Monster'), (SELECT CourseID FROM Courses WHERE CourseName = 'Introduction to Python for Data'), '2024-09-08');
