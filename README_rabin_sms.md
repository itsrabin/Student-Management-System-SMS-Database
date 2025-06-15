# 🎓 Rabin School Management System (SMS) Database

This project is a relational **School Management System (SMS)** database designed using **PostgreSQL**. It simulates how a technical school like Rabin School can manage its students, instructors, departments, courses, and enrollments.

## 📘 Project Summary

The system is built to:
- Store structured student data
- Track course enrollments
- Associate instructors with departments and courses
- Answer real-world education analytics questions using SQL

## 🧱 Database Schema

### 📂 Tables
- **Departments**: Academic departments (e.g., Data Science, Cybersecurity)
- **Students**: Student records, demographics, and departments
- **Instructors**: Teacher profiles, email, gender, and hire dates
- **Courses**: Courses offered under each department with credit allocations
- **Enrollments**: Junction table mapping students to courses

### ⚙️ Constraints & Features
- Foreign keys with cascade or set-null behavior
- Unique and not-null constraints
- Timestamp tracking with `created_at`
- `CHECK (Credits > 0)` constraint on course credits
- Performance indexes on foreign key columns

## 📊 Sample Insights (SQL Queries)
- Top enrolled courses
- Students enrolled in multiple courses
- Students not enrolled in any course
- Average courses per student
- Gender distribution by course
- Department-wise student counts

## 🚀 Technologies Used
- PostgreSQL
- SQL (DDL & DML)
- Google Sheets (for sample data prep)

## 🗂 Sample Data
- 4 Departments
- 6 Students
- 5 Instructors
- 9 Courses
- 18 Enrollments

## 🧪 Getting Started

1. Clone the repository
2. Open the file `rabin_school_sms_improved.sql` in any PostgreSQL-compatible SQL client
3. Run the script to generate the schema and insert sample data
4. Use included SQL queries or create your own for analysis

## 🛠 Future Improvements
- Normalize student/instructor names into first/last fields
- Add course schedules and grading systems
- Build a frontend to interact with the system

## 🙋‍♂️ Author

**Ignatius Rabin Kusimba**  
📧 kusimba62@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/ignatius-kusimba)

---

⭐ Feel free to fork this project, suggest improvements, or use it as a template for your own student management systems!
